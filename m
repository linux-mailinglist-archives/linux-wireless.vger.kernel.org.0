Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C55232178D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 13:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBVMt4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 07:49:56 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:29895
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231752AbhBVMsT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 07:48:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itsBjreFMRadscO45qq/mFrqsUZIf3F/8N8GDAk3yCYk301cxvwEbi4hKZvh8XtxNcMKPbl/B+Jo9SkwncEhH2I9YgTGUWQgvIWjO21KD0legRaPNspnqOGyEe/1nG3RZ+S0E8HWhauXHDqohtGrYMPU+a2K7rA1DWoGHV5FfdrY44lncARi/l0FpGi/QTobDX8dIiRyMYTOVym5nn8yV5S4QtZodymeFY7Ch4gsz6FJu7Bi6F3FXJ8gudKmxTeBo+xHIX2CX76LDpqsG4eBufJP8A9kv5WESRnaPf6NAIh2ljOx4sMeRR54XxTQlnrqn9HQP2OZfeOVIgyc5NfP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OumTrqIdQYuSUkCZ6//VKOh5VTLfJ6QiHflrJPLp0Fo=;
 b=JDFqm426xVnfPNRhHip65CCRfcjgeehj/md6zkQMX1uFPIFqG1w1g5+6WTN4g1kLAMYJrs6Ze9fZIF8CM1in2ZyBouQkkQ4j8u8i/JDdZswvb3J2d7kWiwTvMHXCNzWWhYx4jK/ZWaR9bWsXwpeDZJ394i/N9lwahCKc2QeA85KM0USUKQt7h53YQJyBSBc3FMVDtFMpc6VHxFCXGuKipf3TsUucHRTnAYzIVaLQvNKkVuSi67zI3xJjEAQKgTG+xemZievpRO26WyQXIfDhgxCio5Qdri0msj4eshvB3JJGvz6Cn/lMUcGP+HP1f8OMDClKElf7foA8c/o01XF/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OumTrqIdQYuSUkCZ6//VKOh5VTLfJ6QiHflrJPLp0Fo=;
 b=dF0d7tlgMjN+jSYzE3ww32KlsOLsxgbJN4XKNho4vttSkdFXxs7Ebv/hUJtGN5YvcuEo+5pabLqNQymSQVWXsbCc6X6FETBxjVqpTRreuhkYrhuB9/urh8RDBWVDs/j8b40wBqV8/pCYro7TddIFrgB23O/az+UgNJmUYA62rjE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (2603:10a6:5:2e::18) by
 DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.31; Mon, 22 Feb 2021 12:47:31 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::11d3:a9e:6ccc:4bdc]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::11d3:a9e:6ccc:4bdc%6]) with mapi id 15.20.3868.029; Mon, 22 Feb 2021
 12:47:31 +0000
From:   Sharvari Harisangam <sharvari.harisangam@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     Rakesh Parmar <rakesh.parmar@nxp.com>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Pali Rohar <pali@kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>
Subject: [PATCH] MAINTAINERS: update for mwifiex driver maintainers
Date:   Mon, 22 Feb 2021 18:19:44 +0530
Message-Id: <1613998184-20047-1-git-send-email-sharvari.harisangam@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [115.112.95.158]
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To DB7PR04MB4538.eurprd04.prod.outlook.com (2603:10a6:5:2e::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pe-lt747.in-pnq01.nxp.com (115.112.95.158) by SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 12:47:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3c52544-0a02-4fb9-3bf5-08d8d730042b
X-MS-TrafficTypeDiagnostic: DB8PR04MB7113:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB711367079AE95BBE3935FB40FC819@DB8PR04MB7113.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzPwYlJ7+WeoR+7r78a1tH0K9PKDgdvfnxaUTUf6qrp9GEXnvGuHfyMDMRlI70glEGSm+sLetkL/8E6C+iUGYLNQH/vQ2hC87BVCTOrb3KFPuUMQWnkiX4YAQU6ek/RiHL7fwmMl24nPyJPNTXSIdp5NPgBUEN5tGV0kaDSP/GqqGupo8nXLLxNEGHhHQDcYVCv/Aug5EkBjIaYjsQvzO1yXImwxNzu9xIXPxI513JcsyT1XD8xdEdSyMsKRuOuIF+OnmrMnmu+p1OW0y6xup5GOZVmk0sbwvAGAUgC1xosw58AygPz1hX9uYTCxv7h4MFp98b/JdTIPDGE3BJUOInqaluhIKCnN28BlItng+3jzYNuZetzLchNiOzfoWZ5qQiq5w7fohT6CR8JUr3rHS/ULk0yVaaq9cPQjibxbFzML5SXAOFVbpiiZm7P1FNWfL/eI44LoOIwt/ZeJ1eQkVFKBQXVf09vKdToYoVJB4SdapwM8whIUd0lqzSWaOYvD3hxuWC/mXA8mYWuHa+3/oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4538.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(186003)(2616005)(26005)(55236004)(956004)(6666004)(54906003)(66476007)(5660300002)(16526019)(7696005)(6916009)(83380400001)(36756003)(4326008)(52116002)(2906002)(8676002)(316002)(478600001)(66556008)(86362001)(66946007)(4744005)(6486002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qep4hNwCU8qCUJSVjsqN6m9yD6RQbDUT+bBvaPFZCw+6gEaNcN320nE04hiE?=
 =?us-ascii?Q?va/oRmcsd838WlThRWGIZudK8aJqIx78avHgihxDd686H8a9KhvqQlZr2r1r?=
 =?us-ascii?Q?r79yxMVxMi8Uy+80X2WkCoh18zz9Tgn5MRU1r4wqmlXJNfnpSjFQORvymbCM?=
 =?us-ascii?Q?UaMA+dCZy/tybMKNn84p040Q3vhMyPFSUIu47QciATCvIq3SU0K3mfkChG+m?=
 =?us-ascii?Q?xKCb2t6O4rzHaMmb7L4v0Zvrr7ZJOHKlUVggJSi8DB4O6qIrfzcorIAa3EWe?=
 =?us-ascii?Q?IcqL6QdlY2bsYJC6xyG67hGdJNqQ6rHAxDS6N12dG+v2bX96f6YFfjUoYSN7?=
 =?us-ascii?Q?0cAHCFSeu7ovjHF3tLxi3p8gddA8AG8wA2tM6SyNISgCKl65bLlHpa65fxLX?=
 =?us-ascii?Q?4n15QT7dSRX569juo9T0ocLbqcEMeHtUnpi/EPGfhleBuK9HpgPbcJOzbngo?=
 =?us-ascii?Q?2ybEAo3BeVhkQeIrDmTQV/KcYr2DFP/U/7xmVuEuLqiwQZKYikI2uv+4JsRd?=
 =?us-ascii?Q?/W7j+u8QDPuf5oj2O9c+iUs9FaV+e7vr+Gy5xwgha784a0vyAuZvfxcI+Bmq?=
 =?us-ascii?Q?aSFB7Nu56qvMCqR54eK1IDraDlcgwzZvXDZtHssA/WxGH+vcfLQZroUYSGxC?=
 =?us-ascii?Q?QVQJX5mObCKb0pKH+BvankdTig7X3PJPf/L0Gv1bYU5JY5Slxzh8mm0AF5MG?=
 =?us-ascii?Q?xqVc/448PImO02XK11C5QoYJ4x9kwpy0RuFGYG+Gqno1ssy6RdV+mW5Zw79C?=
 =?us-ascii?Q?N46MZjX48dq3hyMOLjkgncR8mZ5K8i4pOnhueAIVFFAUcheoYS3pmZbeHRZV?=
 =?us-ascii?Q?NgnG2FGTe74KqJuRL+Zu+YX+UdDl3synjDv7buiOCp9qX7BziIXcplP9u0OJ?=
 =?us-ascii?Q?j/9WBubcUEs0PDkpgKoZLzGbvrfn7Cp3XfW+NgRVMEk8CRFY07mJRX31DFef?=
 =?us-ascii?Q?FTQZnhzdWlG1Z8dt1lEnlqkk1/AD14QOSRHDzBzTR+uMqFwajQ8c4G2DEd96?=
 =?us-ascii?Q?q66CHRhNqqnqY7/rb6UVkMEpSgfcnu+pLusYKMxew7CdQrIFLZ8Iym36vNe+?=
 =?us-ascii?Q?ldfkBapfFoRz+/yQzto8dsCy4dSYDM0S9jD14yHRUpYpTgAi6jXLEldvajsr?=
 =?us-ascii?Q?4gaG6CZQ/IE6zX33le2oqksm9r4ZBIDtqfyDcwjOo3E3DVYEcejRppLkFyMX?=
 =?us-ascii?Q?nT71MyFjfxEHdPcogxElki/kzkvMF6+xA5p1h+ic9fjOSbodanIRJutWNMld?=
 =?us-ascii?Q?7wbaiDgptb7r7XDlOlm/ezUyDJRD5mva1UtqMNAFwMJFWUbv7zQM1/+FnDU2?=
 =?us-ascii?Q?t2dHTk4RXJ/NgmColcR2W9WG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c52544-0a02-4fb9-3bf5-08d8d730042b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4538.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 12:47:31.0953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcxNyM1TsmTT/WXnkK9p45DTsQQet2pwRQBKBDhYCKG6l2xjtijPIk4OsZzXnzYW7LOTrmGS6TsTt5aSa13YxNH2sZRE14xCAfgq8/gAzlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add Sharvari Harisangam to Maintainer list.
Replace Ganapathi Bhat's email id in Maintainer list.

Signed-off-by: Rakesh Parmar <rakesh.parmar@nxp.com>
Signed-off-by: Sharvari Harisangam <sharvari.harisangam@nxp.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 99335fd..98fd98e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10685,7 +10685,8 @@ F:	drivers/net/ethernet/marvell/mvpp2/
 
 MARVELL MWIFIEX WIRELESS DRIVER
 M:	Amitkumar Karwar <amitkarwar@gmail.com>
-M:	Ganapathi Bhat <ganapathi.bhat@nxp.com>
+M:	Ganapathi Bhat <ganapathi017@gmail.com>
+M:	Sharvari Harisangam <sharvari.harisangam@nxp.com>
 M:	Xinming Hu <huxinming820@gmail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-- 
2.7.4

