Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB643AB934
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhFQQNa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:30 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:32846
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232941AbhFQQMH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCIfal5hJIPwy0taSOcm9Lgi7lT1pCvTUYxVvbaFMX++79czGFBZPDildO877zKczmEicKzF1vjF45DvBRhQUR7J6ry4JMatEfccdHe93WBrjLtcyFPzQcOX/WA/LH4deDAIrzMOK56ylksGwGMQSSQxpbye3J7qGqhQnSW/BrBeuMxqKJX/hOpHG8yAQdV61lVKTU0zsm1qFSqHenuAs7lFdvXedwgQgewO5+2xgxK87jw1uNtITSFpbZbHcYoqlhifSrp39hmVffB+6MYWCXwxVz0Na1Kbu+OD6DgUFssYKb9eqnmbsU62KPREx3ajCPplhkq46sGeRfh/AEw30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySco48bqbR+0T/HqXFw24uswvFEncwsvgV5jDkojB/4=;
 b=ha3yXe01rv99P+zlDCasj8TwurBz4n63Qn008aRW1SKOx//EWPgSzm8NN0pumm+TvJ3zW25+X3dqnCeH65jdZL82uFqVZJIqGmkTe9227WOWia7YSoNuvr+ZEjUx6T70KTVB4LtWt/jT0Kgg4mnZ3VPv70Az7MkE9XNKZ0Hw0mUQbJwLGnaOuIZRsCWeapZvd6bZM1dcy4kuVt0QGfg8tDBipT1Xcmy3zOB2sPQJpXScvAAQXf/AsaY3DvC7bU4jr76U9Q/BsZL9+7/Ed+Gsru532aC4GHuJvnuNTl/tpSjjz0ljxJpiWKnUE0Pmz/H9KZgQT0K0W6NmjV2Jh8cZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySco48bqbR+0T/HqXFw24uswvFEncwsvgV5jDkojB/4=;
 b=ZBPJFf7e9s6QyPIfp66HdeOTeOiFGQIgs/DDgm9r0tbX/GrelDOcMIaXl12pDkhdZiZsldDRvP3jC4Edo32O6z2C5XzDpgcuvxhBv6D3q9Ozyztsbr/4fJUN4LLyVtHLzNxZN+Y2kclCOtltm034XG5CYuHs5Hgen1r5M6zndmY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:07:12 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:12 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 190/256] cl8k: add trace.c
Date:   Thu, 17 Jun 2021 16:01:17 +0000
Message-Id: <20210617160223.160998-191-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 975dd28e-1907-437b-cce2-08d931a9cf2d
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0260C3C367F29D0D0582BD81F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNzjEPl5wKbB6+jFS7w01qH61a4ewf90ndEu8WnCvPTS2x9IVSLIR+2h8eFXzqYsNf8S8rWHUYrRMhRnNrXkyYg89I27lKvseuR5pb1qlAkj3CoXuCabR1w0tBesLvkce1b6KBT4tFHQY34aFB059tkUM7H7pv5Ewd2gyhHoi1mY6i6FoB3Muzb13aUKCPU/V4Nk/zsko3DqKfoIKwqTdCWP1pcRhK0IZDjCq7LoKoVMOAH1lipRESq2dICjFOHErA2Qts6tvGcZSPslrH6MiKxvfQlpEbE1a3eU5Z1qtlmk5FbJoDOL69KTtvLH+HAo5mh9+irWn1NVzI41LS5pVgDp5X+HOazhpfon++8MoCJwNY3dEmwdeNN/KPau/LMzjnJsJd1M2LjCSlNlUYwN9bFHCFPOVUUq0BD5XFfhXFXDoX0wgeJR+BNKcYPnx+1MFOimuA2tJMTK3c8xGrMSkFWfDoLSV278BQHURaa540HcykZUtSBSirCLtjituxPVBhTlq8+qa99HDHBH82X4sU6+89bKzE+AAuwG/H/AlQDnwIOQM39k6CFkp4hD5wEl9cxrgQp2hGHScMtNquBPEGjas89TjL2Qtb8up3ztCjVGCdbDtKhSMfG3LRtYjTUh8AS0OYT68HS5gA4wInxFcyzN1sTuPMeF9EcqdwBhgY2kdPgoc5goj0Fr5EMFdC7EFQBzIcC7v7BSUx+NUTcunw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8936002)(86362001)(107886003)(4326008)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(498600001)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kb0f0MXB9/Uf/tentArrKZzMYglDo90LWJs9wJZiRnBmAYbRuS4qlimErBhk?=
 =?us-ascii?Q?UKtXtHLHY/aG3QufAHPQp7KN8B5tqzcPuTZn1hWd4FEZx9g9BbQbKg/HFboF?=
 =?us-ascii?Q?WE4UP3s8hOYv42jeAJ09ekANmmRhN/TuSpjbMihaFrO7hCaZ8eMAbAwUA9kQ?=
 =?us-ascii?Q?yrhrlIj3dxlf8SmJD1uwjc2XaIKQR7cSiIY67Us+WzH59K+AARSqrLUE8UKY?=
 =?us-ascii?Q?JQQXLY6KvsTLTMwmU1lT+rYpgxbHjuK/fcI3+8jcdEDgyhexC4vgpBSjILCD?=
 =?us-ascii?Q?ecq1aSHEh88SQXOHLnuzFDwGIzRuOvlrsuIb3IJ4/VqxF68AO2NowrXnK8N7?=
 =?us-ascii?Q?S/7wRsuwzdAA+T2V9mrIKn6zyhOSKIobbvWPsFKVUQqF1cKV7QV+N8PN49nO?=
 =?us-ascii?Q?aGWdh6Fs9ZDZYGg9v+Bkmn1NIyr9xF1eDhCNQeajmHo+o4+NaNfD6gTz/+Ew?=
 =?us-ascii?Q?OcjLK7/cKAIcXWHCrDobIepJ6hawETmh3j9ziu1wYji1lQTcMOIITsSyW8Rb?=
 =?us-ascii?Q?e2HZ+o0vJiSASejkQh/T/uvSk9foBoik2GeUACEs3kkLuWTPJ5KP6Mch1cWu?=
 =?us-ascii?Q?Z5SfkVa5PFXJbeUdkPiu25UvDaOAcXjRvfmDtZhWfNbOnpLof/daK6Nu/bhD?=
 =?us-ascii?Q?N34leWrNov9UBNboNEWNlEjhM7Q4OUoQ1XpfcJZAkLokrHL372FjdUt+4hBl?=
 =?us-ascii?Q?C0voktOg4EOTVytIdhVksrZfbm8ywJ3GGA/wH1hDQhSaTl2uRATWAFpjJUSC?=
 =?us-ascii?Q?E37AQez5NSHnpy9VR2tbjux9J3u7nwGUP+p8/eX02hTiV4Ma4lJpxKRQ/QkF?=
 =?us-ascii?Q?jaMOU0TkwzGdhhAjy7OyPPS7AdOGK+L75imFY5TbfRiBF8Acfj9Fmv/oyl+B?=
 =?us-ascii?Q?PoNDcCnvawHWdxBbZP3Vz1TVhQYdHfNGXWzT4v4X8YJX6Mg8LOQ3NoQVBBaN?=
 =?us-ascii?Q?U6xCf61gCYl9pbV9vW51BAYpaj2Vhyyd9frpt1KUM2udASM7yBAEJPecs//u?=
 =?us-ascii?Q?qNYGSp/dFuwpn4IxdIevy93670VPu4rac4oOqk7RuDMI9rqVri8crmcTcR+m?=
 =?us-ascii?Q?pYr/ARHm5ffvVlvh6NvZSzQYn+p69beOedpPneaQWyTEniUa/U2d0DDv26In?=
 =?us-ascii?Q?cklzhg8X/X46+jaUq04PFQcY90GJp68lapsNnAcMCDhgwLk+dRcTsYbTj9M1?=
 =?us-ascii?Q?uetW6HmVjr14D0Lbt7v+QtAg50pmssOgi1l7tlrbPqFk63CkCteMF2LZ/kK1?=
 =?us-ascii?Q?4xHz/PxPrhMbN35lhRVVMG85BTM0i4kX9qFirjPAZe+GlttUrqETiyHZzNZR?=
 =?us-ascii?Q?d1ACPzlNaZNVI9CYuYc48nZv?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975dd28e-1907-437b-cce2-08d931a9cf2d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:04.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 052U4ckTw85LAdcD161063snl22BUnNq9mkREXxJDm5yAB5t+twHPOJ9Xu0cBY1JhXfke1Tg3oKwHhA065rDjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/trace.c | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/trace.c

diff --git a/drivers/net/wireless/celeno/cl8k/trace.c b/drivers/net/wireles=
s/celeno/cl8k/trace.c
new file mode 100644
index 000000000000..4644f4132bdd
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/trace.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+/*
+ * The definition below generates all the relevant code for the tracepoint=
s.
+ * It should appear in only one translation unit.
+ */
+#define CREATE_TRACE_POINTS
+#include "trace.h"
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

