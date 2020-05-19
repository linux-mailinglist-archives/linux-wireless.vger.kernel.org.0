Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7CE1D94EE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 13:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgESLKT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 07:10:19 -0400
Received: from mail-bn8nam12on2111.outbound.protection.outlook.com ([40.107.237.111]:28801
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbgESLKT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 07:10:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJLmWqTEKXe1PzAucjKDgWNb/k0QLUR31pMASZiQwrrQVX0hGWC6AJzxQVOOA8XABg1NNuZ3/X+3uNDIBRiBwLExzqCsyGP00l4zJJvUfOdv35QeSSpK+s82kO4Z0NlLd7iJBFlOF68Y86kADJMnED+Cmc6WR0mPs6TBBstZkuMwlI4urBeu/gjQuidUj3skVOcHUzvWqi1s6gC/P1nlpzGGgb5NADuw6uHRRlNHK1HfZVq9qoHvAqCNkLNsN3yNVkEte8PRg2yolRai9jq5DFZxIgk5sZtDyWUj2UnNYmO/mOc4jGlBpCB55jspDgFkB6KnesKo0T86pw6A6zlqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8P7gPOkmCOSnqPFOe0rpjvKSb45BDU9WMrGMoqJ/IA=;
 b=E6RoQsGNVeqwD6DIPeNETevq3VjipiXGIbAp5JQhzVZuM9HQDhEHnMbr8J4ZkDSq7P7YrtaWSIh9wkiE8qjUd7IYKnhV8seBuzRI0sxhKFsso8Nd2ldBr2UOCfDV3H167du8LDtoOe6ixzBpnh2jkyMUHdiRSTHWyOBeWhuBv5WvoKHwr22jzppzp5JEKmEY3mv0UNb+6Nqh3OBw6tzHqRehR+OkR2Fa7Ktrv2BsFxJNq4XItCYNz3uswc/KgYJx2qrTpo07EZ7h4c4lzXU4ENuC2s2JP7oWTRwSaem3p0OQr6GfDuu0U/e46d02Ob0sJJ1+D4vqZxrVaACb2VfNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8P7gPOkmCOSnqPFOe0rpjvKSb45BDU9WMrGMoqJ/IA=;
 b=lyVhykSxDEmH2Wj8O8mBFLquZSyZHZnKibv1nCX8tBdnSepJeNG0YeGr8p5L8j4NIieCY8rUaciJolqCsaSbovq0kVKGm7RFAdRi/vnWX9OX3YGgyVxLuMXO66vgk9Ij+t3O21BKgkOpN1p8yyje/yViuJF023ItNAjfslJ2QdI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4906.namprd06.prod.outlook.com (2603:10b6:5:56::11) by
 DM6PR06MB6043.namprd06.prod.outlook.com (2603:10b6:5:10b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Tue, 19 May 2020 11:10:01 +0000
Received: from DM6PR06MB4906.namprd06.prod.outlook.com
 ([fe80::c0ed:fb1f:a976:5c3f]) by DM6PR06MB4906.namprd06.prod.outlook.com
 ([fe80::c0ed:fb1f:a976:5c3f%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 11:10:01 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 0/4] brcmfmac: SoftAP creation and dcmd buffer size changes
Date:   Tue, 19 May 2020 06:09:47 -0500
Message-Id: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To DM6PR06MB4906.namprd06.prod.outlook.com
 (2603:10b6:5:56::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR06CA0029.namprd06.prod.outlook.com (2603:10b6:a03:d4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 11:09:59 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31e2ad21-18ea-44fb-9a04-08d7fbe52c4b
X-MS-TrafficTypeDiagnostic: DM6PR06MB6043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB6043E69EDEC63F8897E41F59BBB90@DM6PR06MB6043.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cn5JCTHINi3V2cYPSQsfvyxkHhxuA2+deyV2vMLHeOy7oSsp3S93RM7ICmhxwSCR+HamnkV7WHAIX6Dv6amBBUXr+XsPzQpStgdqcOSS4gplvHnd1NBAKa4N9QY+/oB9y1wS35HJzYIGdTy1bLW0XMjesOowYIoVtwUCyqnQNauwhMurqhD6JursvmYurp4TAmjULaGwJq8Cwk1e3esgeEta5WnIYLi42IYDP8pycqg9/5lH/ixjjpBRjHjXe3fD45a8w/Sa0KpbvHyIdWQ36IXDOBwe33YVFDnAiQ/allI/R1SK6SBoBdUnWB+wyRIZXjE4jF/E3urV8tQTCj5RVMl4s1PduIRHyUvuwDtJPemxrLcvAQKV1XZsnIRMZvVOqqbaDiqv5cUh2rDzu6u1kpWiZh8y92oOUj+psF6BMCUsR5f+xOF7NfZj2rUfijiC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4906.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(366004)(396003)(136003)(346002)(52116002)(66946007)(66556008)(86362001)(36756003)(7696005)(54906003)(66476007)(8936002)(8676002)(6916009)(478600001)(956004)(316002)(2616005)(6486002)(1076003)(5660300002)(6666004)(2906002)(4326008)(186003)(16526019)(107886003)(4744005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hPaWRUlMySJy4TsbtPAAYwHXlaafqBJruMNa7A81rnj/CDoeysVTXdjMFrmRUA92QQH6cF2BahFCHhR6DU/0367CH36DBNj9zeZ3FssSdPa1rENF8ka7CvdV7YY0Aijiw3DIs1NLfVFe0lHBkFHejFo4k/XBPwxLUd1M8VEobo0nKnZy2FyQAmDYovH6zhVTl2nHbDjlWAQaXb1wZFN95SZVD1pNU8Lz0IRqcbwjD6ljtINWa56GyCpxiJlgGzXfZQQd8pqzw3eGI3EqkU0R2msjAHSn084KBM73PbNw/l96OwlcrU+8sP6PSYVAWITQVmw1Ot74+vWbkuAmcs3yK8aA0EwBTSICA1o/u1AITf0t8td60V3qkq9A2uBWBhxAsvfHhW1IO/Tw3WxH4xmhk1WaKRemGUaBs/kadHt8hEcenzUx+g60brQ+zw4xG9Q/LGoO5iZNH/pa1kpUrCCTXhYKDR1JhxsyDp0ZiJlkXFcUHmAe0ePkZsqGkTjGKYvT
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e2ad21-18ea-44fb-9a04-08d7fbe52c4b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 11:10:00.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwg2w1P3XPTe3fjDcsetsPvOVsOfR35LKfc9zH3J6WgZC5Qg/Z4a4RXDTHXt1wyZciiJH3GwzThgHdNp2RxEtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6043
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow SoftAP creation via ioctl from test tool; also update dcmd buffer siz=
e
settings for new firmware. Also fix a sparse check error.

Chi-Hsien Lin (1):
  brcmfmac: fix a sparse incorrect type error in p2p.c

Double Lo (2):
  brcmfmac: support virtual interface creation from firmware
  brcmfmac: increase dcmd maximum buffer size

Kurt Lee (1):
  brcmfmac: set net carrier on via test tool for AP mode

 .../broadcom/brcm80211/brcmfmac/bcdc.c        |  4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 46 +++++++++++++++++--
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  3 +-
 .../broadcom/brcm80211/brcmfmac/vendor.c      |  9 ++++
 4 files changed, 56 insertions(+), 6 deletions(-)

--
2.25.0


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
