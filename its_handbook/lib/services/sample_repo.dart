import '../models/article.dart';

class SampleRepository {
  static final List<Article> articles = [
    Article(
      id: 'a1',
      title: 'pfSense New Client Setup',
      content: '''
# pfSense New Client Setup

1. Provision a VM with 2 vCPUs and 4GB RAM.
2. Download the latest pfSense image and attach to the VM.
3. Install pfSense following the installer prompts.
4. Configure WAN and LAN interfaces.

```bash
# Example: enable SSH
pfSense# system enable ssh
```

> Notes: Ensure management NIC is on a private network for setup.
''',
      categoryId: 'networking',
      tags: ['pfSense', 'Networking'],
      lastUpdatedBy: 'alice',
      lastUpdatedAt: DateTime.now().subtract(const Duration(days: 2)),
      type: 'playbook',
    ),
    Article(
      id: 'a2',
      title: 'S3 Bucket Policy Template',
      content: '''
## S3 Bucket Policy (Example)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::example-bucket/*"
    }
  ]
}
```

Use this as a starting point and tighten the Principal/Actions for production.
''',
      categoryId: 'cloud',
      tags: ['AWS', 'S3'],
      lastUpdatedBy: 'bob',
      lastUpdatedAt: DateTime.now().subtract(const Duration(days: 5)),
      type: 'playbook',
    ),
    Article(
      id: 'r1',
      title: 'Email outage',
      content: '''
# Email outage

**Severity:** High

Steps:

1. Verify provider status page.
2. Check MX records with dig.
3. Confirm mail queue on MTA.

Escalation: On-call -> SLA manager -> Provider support.
''',
      categoryId: 'incidents',
      tags: ['Email', 'Incident'],
      lastUpdatedBy: 'oncall',
      lastUpdatedAt: DateTime.now().subtract(const Duration(hours: 12)),
      type: 'runbook',
    ),
  ];

  static List<Article> getAllArticles() => articles;

  static Article? getArticleById(String id) {
    try {
      return articles.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<Article> pinned() => [articles.first];

  static List<Article> recents() => articles.take(2).toList();
}
