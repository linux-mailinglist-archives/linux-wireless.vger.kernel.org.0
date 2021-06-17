Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840A23AB850
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhFQQGW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:22 -0400
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:8512
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233655AbhFQQGH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i90fCE7nPHXwLgMYlkrnECBjFv7EShhylvZVHbEuKChYVcMDPkUTUjRLTydj7g1MiYTOhAh3Bw8VxrzXEOqOvqr65t3Pz5H+xY5oX2WHodCE/ORnCEPSvcRHUXKwgK4lm5YFzuOaD5M0DDIGZKc9NGTYdp1FAW97fmYt2DHqNyimUZsxuEtCTb5grJXoeGuSp9n9sFBv7rTTxNqtypBC3OuJVv9hWOtFB9iWrAqT/LM2OTQJApRuS9PNf475N6jdXXng1Z1uf3aEGQpZtpT5pxBwYH2cpeajKKZeo481USPHVn6sNtV3PJkUzPg3tbCrD4HSNZ4AOcRniqybDW2BGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQkxMtIsaYt5KHAZ9P2Yzshhst0afc4CYb9uqzHoqcw=;
 b=iaVVNp7n8UxxJCKPBlDtj7ute8oTPjLMeOv9lDGMuRsEBo0ZSbEuqGwe5ysv/pQ1gRU9JlYdzhSLa7U8lPtnqbYSB9aG2atVO0pGXAlggjgBmnTsUkYmyRq+kJj3WzFktRR4extiSCAZM6k9kwjpiveDPlLgzwDysRewc71EVxMmZypp2xnXjcsJ3aJT+deVE7iQ0r1qNwdGb57brhcL95I7ez3oQvw9vp0yJmxw/tT7oa0/tkIeVuFTemxRFu5ujHhQaDmiomDfloVouIjgOjrult9C/wqMjxSQMggjpgKr/KWWcxmVCfm6KEC2uVZ3NPeh0dVSUcCt0rwHp6vzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQkxMtIsaYt5KHAZ9P2Yzshhst0afc4CYb9uqzHoqcw=;
 b=BF7XO2JspLREaFa9MbRYSyMnE7OLl4cdkBhs94jygaRQzePdsoRBYPER6Z8VuYgBQ64XSM5tgDNyeMmdSLpuDikChom9qS83DvPxs7p3tUUqZaAX/81bsPwz46q/KHQWWY+UyeRfXJ2Xm1ev9l1rMus8L4cXKUOn2zJU9GIx23U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:45 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:45 +0000
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
Subject: [RFC v1 050/256] cl8k: add data_rates.c
Date:   Thu, 17 Jun 2021 15:58:57 +0000
Message-Id: <20210617160223.160998-51-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9836b8a5-58e5-497b-dd49-08d931a97243
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB12346C03A06E3AACD9D34B3FF60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhsug7LJ1vyJl9YvMKqjKojYsl6EvOIHgq9k1fN27VHUhJatQeyvgHU9PwQ5PwYRJsojX1DlDjtK7JsN1qnZy12ul3wAZkdNBcIx5RHExudfOFcB0vcQ6G+F3dsFnJLJJEypXCqVaF81fF2+P17+Fjp05+taW5bUfxwy4xTGD0FXTQe2Bmlh3IAgrE3WQmJ/8NOD+yyDh/wpKkhDE0jX3gostmZxNrXAACs4VsKjokkxXo9eeNdt5oylcAVVM7hVbyISzCQMglGsSS+SFKeMaZ1C6YvnqXFmOCUzYSpLzy8YApP4Cm6MOLvYfz7HNQC46751CYKHw6PVEGKpKsij+QauEFPX9o9NyiWN2W0D1nl738Be1kmV14Lne7KEcUesf+s5tSgNEwVA6lzf9Gycv4N1FwZxykS1QfgQDZ70ypg3X4LkCQfRkvrVzUrdTuEfCGazQuBuMLZOh6tN/H8JZBeAM2y8em1+yCb8QgIacKZ54ormSRxeY0x13PVktmgJbLiJKtHEfiiXnzNted8hgHjEApamqehwu4tCX270UgRTUzPfowTXmG93F7iLhXgGi2QYiYxTIg38RHz6XNLtvIcnfVE/rI7e+S1KrgidRPS0l787w3dqYhmQawgfmya0EBw/m7Q+ZJJQuMvP2WT1hwNSScPKjf3WJODmxJbEepahwYf1c2iGW1SSUBXfdJvUAF/rejf7Now1Ix/J/0jb+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(30864003)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jfeyf2ZE1N8fCNd/Gs835/vWTX2r7pgmupI4MNVZ4am6BGlqoB4LBMOT5Iwk?=
 =?us-ascii?Q?WgC5ULozr7yqvokLtg5aZp8ZszVOvVcFxzxEUC7XcgnPlRKPb9BP1lYIiPvX?=
 =?us-ascii?Q?Z7rclDDrLRPosVjGVX5iVqhdqvhbhVWyOXtiUh8LvN8I5YWNz15bMRNYiwsr?=
 =?us-ascii?Q?cqPKdfrclFb9taUg8zgivYpUrHnjKFNrgW3kN7czmcNL+tP0/bh1eia18ap/?=
 =?us-ascii?Q?zR7cJN1RnffY4aGf/hg+kgFr5GvwtImJ411LrySgheNG/ji+Uvn1tuULBsgH?=
 =?us-ascii?Q?OUT9bnfUEdLGkJhm01T5xV1jJpKzBcHAbMd+Ghla0R83nWec33BItjNk8AdF?=
 =?us-ascii?Q?T8/mwtlB+98tgH7VnNchuRGghwPZV3BhJIzyPFbAFGu9lcA2Be9Ku/y0MUB4?=
 =?us-ascii?Q?BZBlRrJnP9vKgcLhz324hp5eNw2tX6aoV228LU49VK7/tR+YBL8a118hqYKc?=
 =?us-ascii?Q?6B7ZoexFfRYJb4rQghj8hFMeT81QF5UOuSxzrBd5MC2mPVF0Yx7cFqx5yGtX?=
 =?us-ascii?Q?sASaBd4eOhsIss6IhyTmsfR334q2mrzMtJin5cNMd/qN81e2ubgF9l2Rj+np?=
 =?us-ascii?Q?m/Cc2PJEgydadv2afUlbTdc16oLUIKzj62McDsSlX1IH81GVyoUuwAng3HLa?=
 =?us-ascii?Q?1pZBrV3hq3fuCvxgFHWbH9wqK/iiuo8mKr7XR1Mt8aHqKox3Lifotpyg0SLc?=
 =?us-ascii?Q?bbSww9siFtBxdWoxhC8fKmcl0w9FZGImGwLhuVRu0c/CqDpkhXqHwEwM9aa6?=
 =?us-ascii?Q?kjTAltjtQc/rUSFdk3hz42/Qnvmg/Ht040LZIpV/950uxi0TmtKrplujo15p?=
 =?us-ascii?Q?DLgZlKzGlLwxNTx1GbFyBaQ7n4jTJxCPCXqIvuFqov6BwTgOpIIfUNaB5fg5?=
 =?us-ascii?Q?dzC5LBCzYr88DSjjIKSIEZNvCesnohGSIBZanpLCChD8mzqamQxebMZR+sEf?=
 =?us-ascii?Q?OEqhxlJptTQRDxg81/+vlx7+z9oKNj1C4UeTfmntyOTRoWSazAFaD8ApsBlE?=
 =?us-ascii?Q?5J2tvW+gzQ5+qazxkZUmcbNmz0UH+cO24pLth+iHNyRtEnn86e5Y8YpX/MWP?=
 =?us-ascii?Q?lj3kQ+Q83BGB3zcyf9HXdXQeRYiop47Py9DYmzPQVp1bJhOTTC4WplaKdrxB?=
 =?us-ascii?Q?JiF+XSNECiL+bS9TVX49JSreJ5jDkOjso3IiRIRJOr7KucNhgIopUHni4f9Y?=
 =?us-ascii?Q?r/f4isotwCz2eYV7JYLJBhcao//y8vj0KFe7NRl9WsA98IbRQiUPUv5V9yn+?=
 =?us-ascii?Q?8ebQDKhLfITiNvXh0qaRUTkGuuKUNhY3lYHjxKBKEo+t+d4bZsBgEKPsLUzF?=
 =?us-ascii?Q?tBk34tX66R0HL8989JGdS7ww?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9836b8a5-58e5-497b-dd49-08d931a97243
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:28.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REF6u/bgV4FvorwxBsqjjAlX2oLrQMXCV0HCEG6ldwcy0pHZFuKDEnHnyINcvoCVZamwI5sBGwfsuW7/4n9N0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/data_rates.c | 1019 +++++++++++++++++
 1 file changed, 1019 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/data_rates.c

diff --git a/drivers/net/wireless/celeno/cl8k/data_rates.c b/drivers/net/wi=
reless/celeno/cl8k/data_rates.c
new file mode 100644
index 000000000000..64c02b9385c1
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/data_rates.c
@@ -0,0 +1,1019 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "data_rates.h"
+
+/*
+ * This table of rates was taken from IEEE 802.11ax Draft v3.3, 28.5. Para=
meters
+ * for HE-HE_MCSs. The units are 1/10 Mbs. Note that we don't support DCM,=
 so it is
+ * not taken into account in this table.
+ */
+const u16 data_rate_he_x10[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI=
_MAX_HE] =3D {
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_0][WRS_GI_LONG]     =3D 73,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_0][WRS_GI_SHORT]    =3D 81,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_0][WRS_GI_VSHORT]   =3D 86,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_1][WRS_GI_LONG]     =3D 146,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_1][WRS_GI_SHORT]    =3D 163,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_1][WRS_GI_VSHORT]   =3D 172,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_2][WRS_GI_LONG]     =3D 219,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_2][WRS_GI_SHORT]    =3D 244,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_2][WRS_GI_VSHORT]   =3D 258,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_3][WRS_GI_LONG]     =3D 293,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_3][WRS_GI_SHORT]    =3D 325,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_3][WRS_GI_VSHORT]   =3D 344,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_4][WRS_GI_LONG]     =3D 439,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_4][WRS_GI_SHORT]    =3D 488,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_4][WRS_GI_VSHORT]   =3D 516,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_5][WRS_GI_LONG]     =3D 585,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_5][WRS_GI_SHORT]    =3D 650,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_5][WRS_GI_VSHORT]   =3D 688,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_6][WRS_GI_LONG]     =3D 658,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_6][WRS_GI_SHORT]    =3D 731,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_6][WRS_GI_VSHORT]   =3D 774,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_7][WRS_GI_LONG]     =3D 731,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_7][WRS_GI_SHORT]    =3D 813,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_7][WRS_GI_VSHORT]   =3D 860,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_8][WRS_GI_LONG]     =3D 878,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_8][WRS_GI_SHORT]    =3D 975,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_8][WRS_GI_VSHORT]   =3D 1032,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_9][WRS_GI_LONG]     =3D 975,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_9][WRS_GI_SHORT]    =3D 1083,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_9][WRS_GI_VSHORT]   =3D 1147,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_10][WRS_GI_LONG]    =3D 1097,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_10][WRS_GI_SHORT]   =3D 1219,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_10][WRS_GI_VSHORT]  =3D 1290,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_11][WRS_GI_LONG]    =3D 1219,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_11][WRS_GI_SHORT]   =3D 1354,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_11][WRS_GI_VSHORT]  =3D 1434,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_0][WRS_GI_LONG]     =3D 146,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_0][WRS_GI_SHORT]    =3D 163,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_0][WRS_GI_VSHORT]   =3D 172,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_1][WRS_GI_LONG]     =3D 293,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_1][WRS_GI_SHORT]    =3D 325,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_1][WRS_GI_VSHORT]   =3D 344,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_2][WRS_GI_LONG]     =3D 439,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_2][WRS_GI_SHORT]    =3D 488,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_2][WRS_GI_VSHORT]   =3D 516,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_3][WRS_GI_LONG]     =3D 585,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_3][WRS_GI_SHORT]    =3D 650,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_3][WRS_GI_VSHORT]   =3D 688,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_4][WRS_GI_LONG]     =3D 878,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_4][WRS_GI_SHORT]    =3D 975,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_4][WRS_GI_VSHORT]   =3D 1032,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_5][WRS_GI_LONG]     =3D 1170,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_5][WRS_GI_SHORT]    =3D 1300,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_5][WRS_GI_VSHORT]   =3D 1376,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_6][WRS_GI_LONG]     =3D 1316,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_6][WRS_GI_SHORT]    =3D 1463,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_6][WRS_GI_VSHORT]   =3D 1549,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_7][WRS_GI_LONG]     =3D 1463,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_7][WRS_GI_SHORT]    =3D 1625,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_7][WRS_GI_VSHORT]   =3D 1721,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_8][WRS_GI_LONG]     =3D 1755,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_8][WRS_GI_SHORT]    =3D 1950,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_8][WRS_GI_VSHORT]   =3D 2065,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_9][WRS_GI_LONG]     =3D 1950,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_9][WRS_GI_SHORT]    =3D 2167,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_9][WRS_GI_VSHORT]   =3D 2294,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_10][WRS_GI_LONG]    =3D 2194,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_10][WRS_GI_SHORT]   =3D 2438,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_10][WRS_GI_VSHORT]  =3D 2581,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_11][WRS_GI_LONG]    =3D 2438,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_11][WRS_GI_SHORT]   =3D 2708,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_11][WRS_GI_VSHORT]  =3D 2868,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_0][WRS_GI_LONG]     =3D 219,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_0][WRS_GI_SHORT]    =3D 244,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_0][WRS_GI_VSHORT]   =3D 258,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_1][WRS_GI_LONG]     =3D 439,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_1][WRS_GI_SHORT]    =3D 488,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_1][WRS_GI_VSHORT]   =3D 516,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_2][WRS_GI_LONG]     =3D 658,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_2][WRS_GI_SHORT]    =3D 731,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_2][WRS_GI_VSHORT]   =3D 774,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_3][WRS_GI_LONG]     =3D 878,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_3][WRS_GI_SHORT]    =3D 975,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_3][WRS_GI_VSHORT]   =3D 1032,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_4][WRS_GI_LONG]     =3D 1316,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_4][WRS_GI_SHORT]    =3D 1463,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_4][WRS_GI_VSHORT]   =3D 1549,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_5][WRS_GI_LONG]     =3D 1755,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_5][WRS_GI_SHORT]    =3D 1950,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_5][WRS_GI_VSHORT]   =3D 2065,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_6][WRS_GI_LONG]     =3D 1974,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_6][WRS_GI_SHORT]    =3D 2194,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_6][WRS_GI_VSHORT]   =3D 2323,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_7][WRS_GI_LONG]     =3D 2194,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_7][WRS_GI_SHORT]    =3D 2438,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_7][WRS_GI_VSHORT]   =3D 2581,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_8][WRS_GI_LONG]     =3D 2633,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_8][WRS_GI_SHORT]    =3D 2925,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_8][WRS_GI_VSHORT]   =3D 3097,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_9][WRS_GI_LONG]     =3D 2925,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_9][WRS_GI_SHORT]    =3D 3250,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_9][WRS_GI_VSHORT]   =3D 3441,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_10][WRS_GI_LONG]    =3D 3291,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_10][WRS_GI_SHORT]   =3D 3656,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_10][WRS_GI_VSHORT]  =3D 3871,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_11][WRS_GI_LONG]    =3D 3656,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_11][WRS_GI_SHORT]   =3D 4063,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_11][WRS_GI_VSHORT]  =3D 4301,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_0][WRS_GI_LONG]     =3D 293,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_0][WRS_GI_SHORT]    =3D 325,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_0][WRS_GI_VSHORT]   =3D 344,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_1][WRS_GI_LONG]     =3D 585,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_1][WRS_GI_SHORT]    =3D 650,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_1][WRS_GI_VSHORT]   =3D 688,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_2][WRS_GI_LONG]     =3D 878,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_2][WRS_GI_SHORT]    =3D 975,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_2][WRS_GI_VSHORT]   =3D 1032,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_3][WRS_GI_LONG]     =3D 1170,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_3][WRS_GI_SHORT]    =3D 1300,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_3][WRS_GI_VSHORT]   =3D 1376,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_4][WRS_GI_LONG]     =3D 1755,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_4][WRS_GI_SHORT]    =3D 1950,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_4][WRS_GI_VSHORT]   =3D 2065,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_5][WRS_GI_LONG]     =3D 2340,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_5][WRS_GI_SHORT]    =3D 2600,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_5][WRS_GI_VSHORT]   =3D 2753,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_6][WRS_GI_LONG]     =3D 2633,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_6][WRS_GI_SHORT]    =3D 2925,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_6][WRS_GI_VSHORT]   =3D 3097,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_7][WRS_GI_LONG]     =3D 2925,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_7][WRS_GI_SHORT]    =3D 3250,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_7][WRS_GI_VSHORT]   =3D 3441,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_8][WRS_GI_LONG]     =3D 3510,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_8][WRS_GI_SHORT]    =3D 3900,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_8][WRS_GI_VSHORT]   =3D 4129,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_9][WRS_GI_LONG]     =3D 3900,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_9][WRS_GI_SHORT]    =3D 4333,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_9][WRS_GI_VSHORT]   =3D 4588,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_10][WRS_GI_LONG]    =3D 4388,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_10][WRS_GI_SHORT]   =3D 4875,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_10][WRS_GI_VSHORT]  =3D 5162,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_11][WRS_GI_LONG]    =3D 4875,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_11][WRS_GI_SHORT]   =3D 5417,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_11][WRS_GI_VSHORT]  =3D 5735,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_0][WRS_GI_LONG]     =3D 146,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_0][WRS_GI_SHORT]    =3D 163,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_0][WRS_GI_VSHORT]   =3D 172,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_1][WRS_GI_LONG]     =3D 293,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_1][WRS_GI_SHORT]    =3D 325,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_1][WRS_GI_VSHORT]   =3D 344,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_2][WRS_GI_LONG]     =3D 439,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_2][WRS_GI_SHORT]    =3D 488,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_2][WRS_GI_VSHORT]   =3D 516,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_3][WRS_GI_LONG]     =3D 585,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_3][WRS_GI_SHORT]    =3D 650,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_3][WRS_GI_VSHORT]   =3D 688,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_4][WRS_GI_LONG]     =3D 878,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_4][WRS_GI_SHORT]    =3D 975,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_4][WRS_GI_VSHORT]   =3D 1032,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_5][WRS_GI_LONG]     =3D 1170,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_5][WRS_GI_SHORT]    =3D 1300,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_5][WRS_GI_VSHORT]   =3D 1376,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_6][WRS_GI_LONG]     =3D 1316,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_6][WRS_GI_SHORT]    =3D 1463,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_6][WRS_GI_VSHORT]   =3D 1549,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_7][WRS_GI_LONG]     =3D 1463,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_7][WRS_GI_SHORT]    =3D 1625,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_7][WRS_GI_VSHORT]   =3D 1721,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_8][WRS_GI_LONG]     =3D 1755,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_8][WRS_GI_SHORT]    =3D 1950,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_8][WRS_GI_VSHORT]   =3D 2065,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_9][WRS_GI_LONG]     =3D 1950,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_9][WRS_GI_SHORT]    =3D 2167,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_9][WRS_GI_VSHORT]   =3D 2294,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_10][WRS_GI_LONG]    =3D 2194,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_10][WRS_GI_SHORT]   =3D 2438,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_10][WRS_GI_VSHORT]  =3D 2581,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_11][WRS_GI_LONG]    =3D 2438,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_11][WRS_GI_SHORT]   =3D 2708,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_11][WRS_GI_VSHORT]  =3D 2868,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_0][WRS_GI_LONG]     =3D 293,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_0][WRS_GI_SHORT]    =3D 325,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_0][WRS_GI_VSHORT]   =3D 344,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_1][WRS_GI_LONG]     =3D 585,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_1][WRS_GI_SHORT]    =3D 650,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_1][WRS_GI_VSHORT]   =3D 688,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_2][WRS_GI_LONG]     =3D 878,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_2][WRS_GI_SHORT]    =3D 975,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_2][WRS_GI_VSHORT]   =3D 1032,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_3][WRS_GI_LONG]     =3D 1170,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_3][WRS_GI_SHORT]    =3D 1300,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_3][WRS_GI_VSHORT]   =3D 1376,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_4][WRS_GI_LONG]     =3D 1755,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_4][WRS_GI_SHORT]    =3D 1950,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_4][WRS_GI_VSHORT]   =3D 2065,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_5][WRS_GI_LONG]     =3D 2340,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_5][WRS_GI_SHORT]    =3D 2600,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_5][WRS_GI_VSHORT]   =3D 2753,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_6][WRS_GI_LONG]     =3D 2633,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_6][WRS_GI_SHORT]    =3D 2925,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_6][WRS_GI_VSHORT]   =3D 3097,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_7][WRS_GI_LONG]     =3D 2925,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_7][WRS_GI_SHORT]    =3D 3250,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_7][WRS_GI_VSHORT]   =3D 3441,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_8][WRS_GI_LONG]     =3D 3510,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_8][WRS_GI_SHORT]    =3D 3900,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_8][WRS_GI_VSHORT]   =3D 4129,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_9][WRS_GI_LONG]     =3D 3900,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_9][WRS_GI_SHORT]    =3D 4333,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_9][WRS_GI_VSHORT]   =3D 4588,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_10][WRS_GI_LONG]    =3D 4388,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_10][WRS_GI_SHORT]   =3D 4875,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_10][WRS_GI_VSHORT]  =3D 5162,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_11][WRS_GI_LONG]    =3D 4875,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_11][WRS_GI_SHORT]   =3D 5417,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_11][WRS_GI_VSHORT]  =3D 5735,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_0][WRS_GI_LONG]     =3D 439,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_0][WRS_GI_SHORT]    =3D 488,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_0][WRS_GI_VSHORT]   =3D 516,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_1][WRS_GI_LONG]     =3D 878,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_1][WRS_GI_SHORT]    =3D 975,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_1][WRS_GI_VSHORT]   =3D 1032,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_2][WRS_GI_LONG]     =3D 1316,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_2][WRS_GI_SHORT]    =3D 1463,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_2][WRS_GI_VSHORT]   =3D 1549,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_3][WRS_GI_LONG]     =3D 1755,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_3][WRS_GI_SHORT]    =3D 1950,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_3][WRS_GI_VSHORT]   =3D 2065,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_4][WRS_GI_LONG]     =3D 2633,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_4][WRS_GI_SHORT]    =3D 2925,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_4][WRS_GI_VSHORT]   =3D 3097,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_5][WRS_GI_LONG]     =3D 3510,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_5][WRS_GI_SHORT]    =3D 3900,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_5][WRS_GI_VSHORT]   =3D 4129,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_6][WRS_GI_LONG]     =3D 3949,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_6][WRS_GI_SHORT]    =3D 4388,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_6][WRS_GI_VSHORT]   =3D 4646,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_7][WRS_GI_LONG]     =3D 4388,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_7][WRS_GI_SHORT]    =3D 4875,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_7][WRS_GI_VSHORT]   =3D 5162,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_8][WRS_GI_LONG]     =3D 5265,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_8][WRS_GI_SHORT]    =3D 5850,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_8][WRS_GI_VSHORT]   =3D 6194,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_9][WRS_GI_LONG]     =3D 5850,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_9][WRS_GI_SHORT]    =3D 6500,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_9][WRS_GI_VSHORT]   =3D 6882,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_10][WRS_GI_LONG]    =3D 6581,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_10][WRS_GI_SHORT]   =3D 7313,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_10][WRS_GI_VSHORT]  =3D 7743,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_11][WRS_GI_LONG]    =3D 7313,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_11][WRS_GI_SHORT]   =3D 8125,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_11][WRS_GI_VSHORT]  =3D 8603,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_0][WRS_GI_LONG]     =3D 585,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_0][WRS_GI_SHORT]    =3D 650,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_0][WRS_GI_VSHORT]   =3D 688,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_1][WRS_GI_LONG]     =3D 1170,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_1][WRS_GI_SHORT]    =3D 1300,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_1][WRS_GI_VSHORT]   =3D 1376,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_2][WRS_GI_LONG]     =3D 1755,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_2][WRS_GI_SHORT]    =3D 1950,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_2][WRS_GI_VSHORT]   =3D 2065,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_3][WRS_GI_LONG]     =3D 2340,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_3][WRS_GI_SHORT]    =3D 2600,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_3][WRS_GI_VSHORT]   =3D 2753,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_4][WRS_GI_LONG]     =3D 3510,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_4][WRS_GI_SHORT]    =3D 3900,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_4][WRS_GI_VSHORT]   =3D 4129,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_5][WRS_GI_LONG]     =3D 4680,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_5][WRS_GI_SHORT]    =3D 5200,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_5][WRS_GI_VSHORT]   =3D 5506,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_6][WRS_GI_LONG]     =3D 5265,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_6][WRS_GI_SHORT]    =3D 5850,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_6][WRS_GI_VSHORT]   =3D 6194,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_7][WRS_GI_LONG]     =3D 5850,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_7][WRS_GI_SHORT]    =3D 6500,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_7][WRS_GI_VSHORT]   =3D 6882,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_8][WRS_GI_LONG]     =3D 7020,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_8][WRS_GI_SHORT]    =3D 7800,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_8][WRS_GI_VSHORT]   =3D 8259,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_9][WRS_GI_LONG]     =3D 7800,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_9][WRS_GI_SHORT]    =3D 8667,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_9][WRS_GI_VSHORT]   =3D 9176,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_10][WRS_GI_LONG]    =3D 8775,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_10][WRS_GI_SHORT]   =3D 9750,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_10][WRS_GI_VSHORT]  =3D 10324,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_11][WRS_GI_LONG]    =3D 9750,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_11][WRS_GI_SHORT]   =3D 10833,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_11][WRS_GI_VSHORT]  =3D 11471,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_0][WRS_GI_LONG]     =3D 306,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_0][WRS_GI_SHORT]    =3D 340,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_0][WRS_GI_VSHORT]   =3D 360,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_1][WRS_GI_LONG]     =3D 613,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_1][WRS_GI_SHORT]    =3D 681,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_1][WRS_GI_VSHORT]   =3D 721,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_2][WRS_GI_LONG]     =3D 919,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_2][WRS_GI_SHORT]    =3D 1021,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_2][WRS_GI_VSHORT]   =3D 1081,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_3][WRS_GI_LONG]     =3D 1225,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_3][WRS_GI_SHORT]    =3D 1361,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_3][WRS_GI_VSHORT]   =3D 1441,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_4][WRS_GI_LONG]     =3D 1838,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_4][WRS_GI_SHORT]    =3D 2042,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_4][WRS_GI_VSHORT]   =3D 2162,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_5][WRS_GI_LONG]     =3D 2450,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_5][WRS_GI_SHORT]    =3D 2722,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_5][WRS_GI_VSHORT]   =3D 2882,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_6][WRS_GI_LONG]     =3D 2756,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_6][WRS_GI_SHORT]    =3D 3063,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_6][WRS_GI_VSHORT]   =3D 3243,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_7][WRS_GI_LONG]     =3D 3063,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_7][WRS_GI_SHORT]    =3D 3403,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_7][WRS_GI_VSHORT]   =3D 3603,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_8][WRS_GI_LONG]     =3D 3675,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_8][WRS_GI_SHORT]    =3D 4083,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_8][WRS_GI_VSHORT]   =3D 4324,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_9][WRS_GI_LONG]     =3D 4083,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_9][WRS_GI_SHORT]    =3D 4537,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_9][WRS_GI_VSHORT]   =3D 4804,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_10][WRS_GI_LONG]    =3D 4594,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_10][WRS_GI_SHORT]   =3D 5104,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_10][WRS_GI_VSHORT]  =3D 5404,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_11][WRS_GI_LONG]    =3D 5104,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_11][WRS_GI_SHORT]   =3D 5671,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_11][WRS_GI_VSHORT]  =3D 6004,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_0][WRS_GI_LONG]     =3D 613,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_0][WRS_GI_SHORT]    =3D 681,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_0][WRS_GI_VSHORT]   =3D 721,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_1][WRS_GI_LONG]     =3D 1225,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_1][WRS_GI_SHORT]    =3D 1361,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_1][WRS_GI_VSHORT]   =3D 1441,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_2][WRS_GI_LONG]     =3D 1838,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_2][WRS_GI_SHORT]    =3D 2042,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_2][WRS_GI_VSHORT]   =3D 2162,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_3][WRS_GI_LONG]     =3D 2450,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_3][WRS_GI_SHORT]    =3D 2722,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_3][WRS_GI_VSHORT]   =3D 2882,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_4][WRS_GI_LONG]     =3D 3675,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_4][WRS_GI_SHORT]    =3D 4083,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_4][WRS_GI_VSHORT]   =3D 4324,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_5][WRS_GI_LONG]     =3D 4900,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_5][WRS_GI_SHORT]    =3D 5444,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_5][WRS_GI_VSHORT]   =3D 5765,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_6][WRS_GI_LONG]     =3D 5513,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_6][WRS_GI_SHORT]    =3D 6125,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_6][WRS_GI_VSHORT]   =3D 6485,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_7][WRS_GI_LONG]     =3D 6125,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_7][WRS_GI_SHORT]    =3D 6806,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_7][WRS_GI_VSHORT]   =3D 7206,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_8][WRS_GI_LONG]     =3D 7350,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_8][WRS_GI_SHORT]    =3D 8167,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_8][WRS_GI_VSHORT]   =3D 8647,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_9][WRS_GI_LONG]     =3D 8166,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_9][WRS_GI_SHORT]    =3D 9074,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_9][WRS_GI_VSHORT]   =3D 9607,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_10][WRS_GI_LONG]    =3D 9188,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_10][WRS_GI_SHORT]   =3D 10208,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_10][WRS_GI_VSHORT]  =3D 10809,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_11][WRS_GI_LONG]    =3D 10208,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_11][WRS_GI_SHORT]   =3D 11343,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_11][WRS_GI_VSHORT]  =3D 12010,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_0][WRS_GI_LONG]     =3D 919,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_0][WRS_GI_SHORT]    =3D 1021,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_0][WRS_GI_VSHORT]   =3D 1081,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_1][WRS_GI_LONG]     =3D 1838,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_1][WRS_GI_SHORT]    =3D 2042,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_1][WRS_GI_VSHORT]   =3D 2162,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_2][WRS_GI_LONG]     =3D 2756,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_2][WRS_GI_SHORT]    =3D 3063,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_2][WRS_GI_VSHORT]   =3D 3243,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_3][WRS_GI_LONG]     =3D 3675,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_3][WRS_GI_SHORT]    =3D 4083,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_3][WRS_GI_VSHORT]   =3D 4324,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_4][WRS_GI_LONG]     =3D 5513,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_4][WRS_GI_SHORT]    =3D 6125,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_4][WRS_GI_VSHORT]   =3D 6485,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_5][WRS_GI_LONG]     =3D 7350,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_5][WRS_GI_SHORT]    =3D 8167,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_5][WRS_GI_VSHORT]   =3D 8647,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_6][WRS_GI_LONG]     =3D 8269,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_6][WRS_GI_SHORT]    =3D 9188,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_6][WRS_GI_VSHORT]   =3D 9728,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_7][WRS_GI_LONG]     =3D 9188,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_7][WRS_GI_SHORT]    =3D 10208,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_7][WRS_GI_VSHORT]   =3D 10809,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_8][WRS_GI_LONG]     =3D 11025,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_8][WRS_GI_SHORT]    =3D 12250,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_8][WRS_GI_VSHORT]   =3D 12971,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_9][WRS_GI_LONG]     =3D 12250,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_9][WRS_GI_SHORT]    =3D 13611,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_9][WRS_GI_VSHORT]   =3D 14412,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_10][WRS_GI_LONG]    =3D 13781,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_10][WRS_GI_SHORT]   =3D 15313,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_10][WRS_GI_VSHORT]  =3D 16213,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_11][WRS_GI_LONG]    =3D 15313,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_11][WRS_GI_SHORT]   =3D 17014,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_11][WRS_GI_VSHORT]  =3D 18015,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_0][WRS_GI_LONG]     =3D 1225,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_0][WRS_GI_SHORT]    =3D 1361,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_0][WRS_GI_VSHORT]   =3D 1441,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_1][WRS_GI_LONG]     =3D 2450,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_1][WRS_GI_SHORT]    =3D 2722,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_1][WRS_GI_VSHORT]   =3D 2882,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_2][WRS_GI_LONG]     =3D 3675,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_2][WRS_GI_SHORT]    =3D 4083,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_2][WRS_GI_VSHORT]   =3D 4324,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_3][WRS_GI_LONG]     =3D 4900,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_3][WRS_GI_SHORT]    =3D 5444,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_3][WRS_GI_VSHORT]   =3D 5765,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_4][WRS_GI_LONG]     =3D 7350,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_4][WRS_GI_SHORT]    =3D 8167,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_4][WRS_GI_VSHORT]   =3D 8647,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_5][WRS_GI_LONG]     =3D 9800,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_5][WRS_GI_SHORT]    =3D 10889,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_5][WRS_GI_VSHORT]   =3D 11529,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_6][WRS_GI_LONG]     =3D 11025,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_6][WRS_GI_SHORT]    =3D 12250,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_6][WRS_GI_VSHORT]   =3D 12971,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_7][WRS_GI_LONG]     =3D 12250,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_7][WRS_GI_SHORT]    =3D 13611,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_7][WRS_GI_VSHORT]   =3D 14412,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_8][WRS_GI_LONG]     =3D 14700,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_8][WRS_GI_SHORT]    =3D 16333,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_8][WRS_GI_VSHORT]   =3D 17294,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_9][WRS_GI_LONG]     =3D 16333,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_9][WRS_GI_SHORT]    =3D 18148,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_9][WRS_GI_VSHORT]   =3D 19215,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_10][WRS_GI_LONG]    =3D 18375,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_10][WRS_GI_SHORT]   =3D 20417,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_10][WRS_GI_VSHORT]  =3D 21618,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_11][WRS_GI_LONG]    =3D 20416,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_11][WRS_GI_SHORT]   =3D 22685,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_11][WRS_GI_VSHORT]  =3D 24019,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_0][WRS_GI_LONG]    =3D 613,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_0][WRS_GI_SHORT]   =3D 681,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_0][WRS_GI_VSHORT]  =3D 721,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_1][WRS_GI_LONG]    =3D 1225,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_1][WRS_GI_SHORT]   =3D 1361,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_1][WRS_GI_VSHORT]  =3D 1441,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_2][WRS_GI_LONG]    =3D 1838,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_2][WRS_GI_SHORT]   =3D 2042,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_2][WRS_GI_VSHORT]  =3D 2162,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_3][WRS_GI_LONG]    =3D 2450,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_3][WRS_GI_SHORT]   =3D 2722,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_3][WRS_GI_VSHORT]  =3D 2882,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_4][WRS_GI_LONG]    =3D 3675,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_4][WRS_GI_SHORT]   =3D 4083,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_4][WRS_GI_VSHORT]  =3D 4324,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_5][WRS_GI_LONG]    =3D 4900,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_5][WRS_GI_SHORT]   =3D 5444,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_5][WRS_GI_VSHORT]  =3D 5765,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_6][WRS_GI_LONG]    =3D 5513,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_6][WRS_GI_SHORT]   =3D 6125,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_6][WRS_GI_VSHORT]  =3D 6485,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_7][WRS_GI_LONG]    =3D 6125,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_7][WRS_GI_SHORT]   =3D 6806,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_7][WRS_GI_VSHORT]  =3D 7206,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_8][WRS_GI_LONG]    =3D 7350,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_8][WRS_GI_SHORT]   =3D 8167,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_8][WRS_GI_VSHORT]  =3D 8647,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_9][WRS_GI_LONG]    =3D 8166,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_9][WRS_GI_SHORT]   =3D 9074,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_9][WRS_GI_VSHORT]  =3D 9607,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_10][WRS_GI_LONG]   =3D 9188,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_10][WRS_GI_SHORT]  =3D 10208,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_10][WRS_GI_VSHORT] =3D 10809,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_11][WRS_GI_LONG]   =3D 10208,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_11][WRS_GI_SHORT]  =3D 11342,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_11][WRS_GI_VSHORT] =3D 12010,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_0][WRS_GI_LONG]    =3D 1225,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_0][WRS_GI_SHORT]   =3D 1361,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_0][WRS_GI_VSHORT]  =3D 1441,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_1][WRS_GI_LONG]    =3D 2450,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_1][WRS_GI_SHORT]   =3D 2722,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_1][WRS_GI_VSHORT]  =3D 2882,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_2][WRS_GI_LONG]    =3D 3675,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_2][WRS_GI_SHORT]   =3D 4083,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_2][WRS_GI_VSHORT]  =3D 4324,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_3][WRS_GI_LONG]    =3D 4900,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_3][WRS_GI_SHORT]   =3D 5444,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_3][WRS_GI_VSHORT]  =3D 5765,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_4][WRS_GI_LONG]    =3D 7350,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_4][WRS_GI_SHORT]   =3D 8167,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_4][WRS_GI_VSHORT]  =3D 8647,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_5][WRS_GI_LONG]    =3D 9800,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_5][WRS_GI_SHORT]   =3D 10889,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_5][WRS_GI_VSHORT]  =3D 11529,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_6][WRS_GI_LONG]    =3D 11025,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_6][WRS_GI_SHORT]   =3D 12250,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_6][WRS_GI_VSHORT]  =3D 12971,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_7][WRS_GI_LONG]    =3D 12250,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_7][WRS_GI_SHORT]   =3D 13611,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_7][WRS_GI_VSHORT]  =3D 14412,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_8][WRS_GI_LONG]    =3D 14700,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_8][WRS_GI_SHORT]   =3D 16333,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_8][WRS_GI_VSHORT]  =3D 17294,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_9][WRS_GI_LONG]    =3D 16333,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_9][WRS_GI_SHORT]   =3D 18148,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_9][WRS_GI_VSHORT]  =3D 19215,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_10][WRS_GI_LONG]   =3D 18375,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_10][WRS_GI_SHORT]  =3D 20417,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_10][WRS_GI_VSHORT] =3D 21618,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_11][WRS_GI_LONG]   =3D 20416,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_11][WRS_GI_SHORT]  =3D 22685,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_11][WRS_GI_VSHORT] =3D 24019,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_0][WRS_GI_LONG]    =3D 1838,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_0][WRS_GI_SHORT]   =3D 2042,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_0][WRS_GI_VSHORT]  =3D 2162,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_1][WRS_GI_LONG]    =3D 3675,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_1][WRS_GI_SHORT]   =3D 4083,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_1][WRS_GI_VSHORT]  =3D 4324,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_2][WRS_GI_LONG]    =3D 5513,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_2][WRS_GI_SHORT]   =3D 6125,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_2][WRS_GI_VSHORT]  =3D 6485,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_3][WRS_GI_LONG]    =3D 7350,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_3][WRS_GI_SHORT]   =3D 8167,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_3][WRS_GI_VSHORT]  =3D 8647,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_4][WRS_GI_LONG]    =3D 11025,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_4][WRS_GI_SHORT]   =3D 12250,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_4][WRS_GI_VSHORT]  =3D 12971,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_5][WRS_GI_LONG]    =3D 14700,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_5][WRS_GI_SHORT]   =3D 16333,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_5][WRS_GI_VSHORT]  =3D 17294,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_6][WRS_GI_LONG]    =3D 16538,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_6][WRS_GI_SHORT]   =3D 18375,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_6][WRS_GI_VSHORT]  =3D 19456,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_7][WRS_GI_LONG]    =3D 18375,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_7][WRS_GI_SHORT]   =3D 20417,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_7][WRS_GI_VSHORT]  =3D 21618,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_8][WRS_GI_LONG]    =3D 22050,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_8][WRS_GI_SHORT]   =3D 24500,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_8][WRS_GI_VSHORT]  =3D 25941,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_9][WRS_GI_LONG]    =3D 24500,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_9][WRS_GI_SHORT]   =3D 27222,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_9][WRS_GI_VSHORT]  =3D 28824,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_10][WRS_GI_LONG]   =3D 27563,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_10][WRS_GI_SHORT]  =3D 30625,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_10][WRS_GI_VSHORT] =3D 32426,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_11][WRS_GI_LONG]   =3D 30625,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_11][WRS_GI_SHORT]  =3D 34028,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_11][WRS_GI_VSHORT] =3D 36029,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_0][WRS_GI_LONG]    =3D 2450,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_0][WRS_GI_SHORT]   =3D 2722,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_0][WRS_GI_VSHORT]  =3D 2882,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_1][WRS_GI_LONG]    =3D 4900,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_1][WRS_GI_SHORT]   =3D 5444,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_1][WRS_GI_VSHORT]  =3D 5765,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_2][WRS_GI_LONG]    =3D 7350,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_2][WRS_GI_SHORT]   =3D 8167,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_2][WRS_GI_VSHORT]  =3D 8647,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_3][WRS_GI_LONG]    =3D 9800,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_3][WRS_GI_SHORT]   =3D 10889,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_3][WRS_GI_VSHORT]  =3D 11529,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_4][WRS_GI_LONG]    =3D 14700,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_4][WRS_GI_SHORT]   =3D 16333,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_4][WRS_GI_VSHORT]  =3D 17294,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_5][WRS_GI_LONG]    =3D 19600,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_5][WRS_GI_SHORT]   =3D 21778,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_5][WRS_GI_VSHORT]  =3D 23059,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_6][WRS_GI_LONG]    =3D 22050,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_6][WRS_GI_SHORT]   =3D 24500,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_6][WRS_GI_VSHORT]  =3D 25941,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_7][WRS_GI_LONG]    =3D 24500,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_7][WRS_GI_SHORT]   =3D 27222,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_7][WRS_GI_VSHORT]  =3D 28824,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_8][WRS_GI_LONG]    =3D 29400,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_8][WRS_GI_SHORT]   =3D 32667,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_8][WRS_GI_VSHORT]  =3D 34588,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_9][WRS_GI_LONG]    =3D 32666,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_9][WRS_GI_SHORT]   =3D 36296,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_9][WRS_GI_VSHORT]  =3D 38431,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_10][WRS_GI_LONG]   =3D 36750,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_10][WRS_GI_SHORT]  =3D 40833,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_10][WRS_GI_VSHORT] =3D 43235,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_11][WRS_GI_LONG]   =3D 40833,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_11][WRS_GI_SHORT]  =3D 45370,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_11][WRS_GI_VSHORT] =3D 48039,
+};
+
+/*
+ * This table of rates was taken from IEEE Std 802.11TM-2016, 21.5 Paramet=
ers
+ * for VHT-MCSs. The units are 1/10 Mbs. Invalid combinations are with 0's=
. Note
+ * that HT data rates are a subset of VHT data rates, so we can use a sing=
le
+ * table for both.
+ */
+const u16 data_rate_ht_vht_x10[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_VHT][W=
RS_GI_MAX_VHT] =3D {
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_0][WRS_GI_LONG]   =3D 65,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_0][WRS_GI_SHORT]  =3D 72,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_1][WRS_GI_LONG]   =3D 130,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_1][WRS_GI_SHORT]  =3D 144,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_2][WRS_GI_LONG]   =3D 195,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_2][WRS_GI_SHORT]  =3D 217,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_3][WRS_GI_LONG]   =3D 260,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_3][WRS_GI_SHORT]  =3D 289,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_4][WRS_GI_LONG]   =3D 390,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_4][WRS_GI_SHORT]  =3D 433,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_5][WRS_GI_LONG]   =3D 520,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_5][WRS_GI_SHORT]  =3D 578,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_6][WRS_GI_LONG]   =3D 585,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_6][WRS_GI_SHORT]  =3D 650,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_7][WRS_GI_LONG]   =3D 650,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_7][WRS_GI_SHORT]  =3D 722,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_8][WRS_GI_LONG]   =3D 780,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_8][WRS_GI_SHORT]  =3D 867,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_9][WRS_GI_LONG]   =3D 0,
+       [CHNL_BW_20][WRS_SS_1][WRS_MCS_9][WRS_GI_SHORT]  =3D 0,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_0][WRS_GI_LONG]   =3D 130,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_0][WRS_GI_SHORT]  =3D 144,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_1][WRS_GI_LONG]   =3D 260,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_1][WRS_GI_SHORT]  =3D 289,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_2][WRS_GI_LONG]   =3D 390,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_2][WRS_GI_SHORT]  =3D 433,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_3][WRS_GI_LONG]   =3D 520,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_3][WRS_GI_SHORT]  =3D 578,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_4][WRS_GI_LONG]   =3D 780,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_4][WRS_GI_SHORT]  =3D 867,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_5][WRS_GI_LONG]   =3D 1040,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_5][WRS_GI_SHORT]  =3D 1156,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_6][WRS_GI_LONG]   =3D 1170,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_6][WRS_GI_SHORT]  =3D 1303,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_7][WRS_GI_LONG]   =3D 1300,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_7][WRS_GI_SHORT]  =3D 1444,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_8][WRS_GI_LONG]   =3D 1560,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_8][WRS_GI_SHORT]  =3D 1733,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_9][WRS_GI_LONG]   =3D 0,
+       [CHNL_BW_20][WRS_SS_2][WRS_MCS_9][WRS_GI_SHORT]  =3D 0,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_0][WRS_GI_LONG]   =3D 195,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_0][WRS_GI_SHORT]  =3D 217,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_1][WRS_GI_LONG]   =3D 390,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_1][WRS_GI_SHORT]  =3D 433,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_2][WRS_GI_LONG]   =3D 585,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_2][WRS_GI_SHORT]  =3D 650,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_3][WRS_GI_LONG]   =3D 780,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_3][WRS_GI_SHORT]  =3D 867,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_4][WRS_GI_LONG]   =3D 1170,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_4][WRS_GI_SHORT]  =3D 1300,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_5][WRS_GI_LONG]   =3D 1560,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_5][WRS_GI_SHORT]  =3D 1733,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_6][WRS_GI_LONG]   =3D 1755,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_6][WRS_GI_SHORT]  =3D 1950,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_7][WRS_GI_LONG]   =3D 1950,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_7][WRS_GI_SHORT]  =3D 2167,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_8][WRS_GI_LONG]   =3D 2340,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_8][WRS_GI_SHORT]  =3D 2600,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_9][WRS_GI_LONG]   =3D 2600,
+       [CHNL_BW_20][WRS_SS_3][WRS_MCS_9][WRS_GI_SHORT]  =3D 2889,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_0][WRS_GI_LONG]   =3D 260,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_0][WRS_GI_SHORT]  =3D 288,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_1][WRS_GI_LONG]   =3D 520,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_1][WRS_GI_SHORT]  =3D 576,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_2][WRS_GI_LONG]   =3D 780,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_2][WRS_GI_SHORT]  =3D 868,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_3][WRS_GI_LONG]   =3D 1040,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_3][WRS_GI_SHORT]  =3D 1156,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_4][WRS_GI_LONG]   =3D 1560,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_4][WRS_GI_SHORT]  =3D 1732,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_5][WRS_GI_LONG]   =3D 2080,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_5][WRS_GI_SHORT]  =3D 2312,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_6][WRS_GI_LONG]   =3D 2340,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_6][WRS_GI_SHORT]  =3D 2600,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_7][WRS_GI_LONG]   =3D 2600,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_7][WRS_GI_SHORT]  =3D 2888,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_8][WRS_GI_LONG]   =3D 3120,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_8][WRS_GI_SHORT]  =3D 3468,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_9][WRS_GI_LONG]   =3D 0,
+       [CHNL_BW_20][WRS_SS_4][WRS_MCS_9][WRS_GI_SHORT]  =3D 0,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_0][WRS_GI_LONG]   =3D 135,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_0][WRS_GI_SHORT]  =3D 150,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_1][WRS_GI_LONG]   =3D 270,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_1][WRS_GI_SHORT]  =3D 300,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_2][WRS_GI_LONG]   =3D 405,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_2][WRS_GI_SHORT]  =3D 450,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_3][WRS_GI_LONG]   =3D 540,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_3][WRS_GI_SHORT]  =3D 600,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_4][WRS_GI_LONG]   =3D 810,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_4][WRS_GI_SHORT]  =3D 900,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_5][WRS_GI_LONG]   =3D 1080,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_5][WRS_GI_SHORT]  =3D 1200,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_6][WRS_GI_LONG]   =3D 1215,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_6][WRS_GI_SHORT]  =3D 1350,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_7][WRS_GI_LONG]   =3D 1350,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_7][WRS_GI_SHORT]  =3D 1500,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_8][WRS_GI_LONG]   =3D 1620,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_8][WRS_GI_SHORT]  =3D 1800,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_9][WRS_GI_LONG]   =3D 1800,
+       [CHNL_BW_40][WRS_SS_1][WRS_MCS_9][WRS_GI_SHORT]  =3D 2000,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_0][WRS_GI_LONG]   =3D 270,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_0][WRS_GI_SHORT]  =3D 300,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_1][WRS_GI_LONG]   =3D 540,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_1][WRS_GI_SHORT]  =3D 600,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_2][WRS_GI_LONG]   =3D 810,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_2][WRS_GI_SHORT]  =3D 900,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_3][WRS_GI_LONG]   =3D 1080,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_3][WRS_GI_SHORT]  =3D 1200,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_4][WRS_GI_LONG]   =3D 1620,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_4][WRS_GI_SHORT]  =3D 1800,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_5][WRS_GI_LONG]   =3D 2160,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_5][WRS_GI_SHORT]  =3D 2400,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_6][WRS_GI_LONG]   =3D 2430,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_6][WRS_GI_SHORT]  =3D 2700,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_7][WRS_GI_LONG]   =3D 2700,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_7][WRS_GI_SHORT]  =3D 3000,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_8][WRS_GI_LONG]   =3D 3240,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_8][WRS_GI_SHORT]  =3D 3600,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_9][WRS_GI_LONG]   =3D 3600,
+       [CHNL_BW_40][WRS_SS_2][WRS_MCS_9][WRS_GI_SHORT]  =3D 4000,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_0][WRS_GI_LONG]   =3D 405,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_0][WRS_GI_SHORT]  =3D 450,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_1][WRS_GI_LONG]   =3D 810,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_1][WRS_GI_SHORT]  =3D 900,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_2][WRS_GI_LONG]   =3D 1215,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_2][WRS_GI_SHORT]  =3D 1350,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_3][WRS_GI_LONG]   =3D 1620,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_3][WRS_GI_SHORT]  =3D 1800,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_4][WRS_GI_LONG]   =3D 2430,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_4][WRS_GI_SHORT]  =3D 2700,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_5][WRS_GI_LONG]   =3D 3240,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_5][WRS_GI_SHORT]  =3D 3600,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_6][WRS_GI_LONG]   =3D 3645,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_6][WRS_GI_SHORT]  =3D 4050,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_7][WRS_GI_LONG]   =3D 4050,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_7][WRS_GI_SHORT]  =3D 4500,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_8][WRS_GI_LONG]   =3D 4860,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_8][WRS_GI_SHORT]  =3D 5400,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_9][WRS_GI_LONG]   =3D 5400,
+       [CHNL_BW_40][WRS_SS_3][WRS_MCS_9][WRS_GI_SHORT]  =3D 6000,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_0][WRS_GI_LONG]   =3D 540,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_0][WRS_GI_SHORT]  =3D 600,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_1][WRS_GI_LONG]   =3D 1080,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_1][WRS_GI_SHORT]  =3D 1200,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_2][WRS_GI_LONG]   =3D 1620,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_2][WRS_GI_SHORT]  =3D 1800,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_3][WRS_GI_LONG]   =3D 2160,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_3][WRS_GI_SHORT]  =3D 2400,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_4][WRS_GI_LONG]   =3D 3240,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_4][WRS_GI_SHORT]  =3D 3600,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_5][WRS_GI_LONG]   =3D 4320,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_5][WRS_GI_SHORT]  =3D 4800,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_6][WRS_GI_LONG]   =3D 4860,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_6][WRS_GI_SHORT]  =3D 5400,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_7][WRS_GI_LONG]   =3D 5400,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_7][WRS_GI_SHORT]  =3D 6000,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_8][WRS_GI_LONG]   =3D 6480,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_8][WRS_GI_SHORT]  =3D 7200,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_9][WRS_GI_LONG]   =3D 7200,
+       [CHNL_BW_40][WRS_SS_4][WRS_MCS_9][WRS_GI_SHORT]  =3D 8000,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_0][WRS_GI_LONG]   =3D 293,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_0][WRS_GI_SHORT]  =3D 325,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_1][WRS_GI_LONG]   =3D 585,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_1][WRS_GI_SHORT]  =3D 650,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_2][WRS_GI_LONG]   =3D 878,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_2][WRS_GI_SHORT]  =3D 975,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_3][WRS_GI_LONG]   =3D 1170,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_3][WRS_GI_SHORT]  =3D 1300,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_4][WRS_GI_LONG]   =3D 1755,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_4][WRS_GI_SHORT]  =3D 1950,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_5][WRS_GI_LONG]   =3D 2340,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_5][WRS_GI_SHORT]  =3D 2600,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_6][WRS_GI_LONG]   =3D 2633,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_6][WRS_GI_SHORT]  =3D 2925,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_7][WRS_GI_LONG]   =3D 2925,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_7][WRS_GI_SHORT]  =3D 3250,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_8][WRS_GI_LONG]   =3D 3510,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_8][WRS_GI_SHORT]  =3D 3900,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_9][WRS_GI_LONG]   =3D 3900,
+       [CHNL_BW_80][WRS_SS_1][WRS_MCS_9][WRS_GI_SHORT]  =3D 4333,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_0][WRS_GI_LONG]   =3D 585,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_0][WRS_GI_SHORT]  =3D 650,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_1][WRS_GI_LONG]   =3D 1170,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_1][WRS_GI_SHORT]  =3D 1300,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_2][WRS_GI_LONG]   =3D 1755,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_2][WRS_GI_SHORT]  =3D 1950,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_3][WRS_GI_LONG]   =3D 2340,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_3][WRS_GI_SHORT]  =3D 2600,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_4][WRS_GI_LONG]   =3D 3510,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_4][WRS_GI_SHORT]  =3D 3900,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_5][WRS_GI_LONG]   =3D 4680,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_5][WRS_GI_SHORT]  =3D 5200,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_6][WRS_GI_LONG]   =3D 5265,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_6][WRS_GI_SHORT]  =3D 5850,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_7][WRS_GI_LONG]   =3D 5850,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_7][WRS_GI_SHORT]  =3D 6500,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_8][WRS_GI_LONG]   =3D 7020,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_8][WRS_GI_SHORT]  =3D 7800,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_9][WRS_GI_LONG]   =3D 7800,
+       [CHNL_BW_80][WRS_SS_2][WRS_MCS_9][WRS_GI_SHORT]  =3D 8667,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_0][WRS_GI_LONG]   =3D 878,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_0][WRS_GI_SHORT]  =3D 975,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_1][WRS_GI_LONG]   =3D 1755,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_1][WRS_GI_SHORT]  =3D 1950,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_2][WRS_GI_LONG]   =3D 2633,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_2][WRS_GI_SHORT]  =3D 2925,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_3][WRS_GI_LONG]   =3D 3510,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_3][WRS_GI_SHORT]  =3D 3900,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_4][WRS_GI_LONG]   =3D 5265,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_4][WRS_GI_SHORT]  =3D 5850,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_5][WRS_GI_LONG]   =3D 7020,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_5][WRS_GI_SHORT]  =3D 7800,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_6][WRS_GI_LONG]   =3D 0,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_6][WRS_GI_SHORT]  =3D 0,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_7][WRS_GI_LONG]   =3D 8775,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_7][WRS_GI_SHORT]  =3D 9750,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_8][WRS_GI_LONG]   =3D 10530,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_8][WRS_GI_SHORT]  =3D 11700,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_9][WRS_GI_LONG]   =3D 11700,
+       [CHNL_BW_80][WRS_SS_3][WRS_MCS_9][WRS_GI_SHORT]  =3D 13000,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_0][WRS_GI_LONG]   =3D 1172,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_0][WRS_GI_SHORT]  =3D 1300,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_1][WRS_GI_LONG]   =3D 2340,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_1][WRS_GI_SHORT]  =3D 2600,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_2][WRS_GI_LONG]   =3D 3512,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_2][WRS_GI_SHORT]  =3D 3900,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_3][WRS_GI_LONG]   =3D 4680,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_3][WRS_GI_SHORT]  =3D 5200,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_4][WRS_GI_LONG]   =3D 7020,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_4][WRS_GI_SHORT]  =3D 7800,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_5][WRS_GI_LONG]   =3D 9360,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_5][WRS_GI_SHORT]  =3D 10400,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_6][WRS_GI_LONG]   =3D 10532,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_6][WRS_GI_SHORT]  =3D 11700,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_7][WRS_GI_LONG]   =3D 11700,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_7][WRS_GI_SHORT]  =3D 13000,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_8][WRS_GI_LONG]   =3D 14040,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_8][WRS_GI_SHORT]  =3D 15600,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_9][WRS_GI_LONG]   =3D 15600,
+       [CHNL_BW_80][WRS_SS_4][WRS_MCS_9][WRS_GI_SHORT]  =3D 17332,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_0][WRS_GI_LONG]  =3D 585,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_0][WRS_GI_SHORT] =3D 650,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_1][WRS_GI_LONG]  =3D 1170,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_1][WRS_GI_SHORT] =3D 1300,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_2][WRS_GI_LONG]  =3D 1755,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_2][WRS_GI_SHORT] =3D 1950,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_3][WRS_GI_LONG]  =3D 2340,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_3][WRS_GI_SHORT] =3D 2600,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_4][WRS_GI_LONG]  =3D 3510,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_4][WRS_GI_SHORT] =3D 3900,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_5][WRS_GI_LONG]  =3D 4680,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_5][WRS_GI_SHORT] =3D 5200,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_6][WRS_GI_LONG]  =3D 5265,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_6][WRS_GI_SHORT] =3D 5850,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_7][WRS_GI_LONG]  =3D 5850,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_7][WRS_GI_SHORT] =3D 6500,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_8][WRS_GI_LONG]  =3D 7020,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_8][WRS_GI_SHORT] =3D 7800,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_9][WRS_GI_LONG]  =3D 7800,
+       [CHNL_BW_160][WRS_SS_1][WRS_MCS_9][WRS_GI_SHORT] =3D 8667,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_0][WRS_GI_LONG]  =3D 1170,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_0][WRS_GI_SHORT] =3D 1300,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_1][WRS_GI_LONG]  =3D 2340,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_1][WRS_GI_SHORT] =3D 2600,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_2][WRS_GI_LONG]  =3D 3510,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_2][WRS_GI_SHORT] =3D 3900,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_3][WRS_GI_LONG]  =3D 4680,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_3][WRS_GI_SHORT] =3D 5200,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_4][WRS_GI_LONG]  =3D 7020,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_4][WRS_GI_SHORT] =3D 7800,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_5][WRS_GI_LONG]  =3D 9360,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_5][WRS_GI_SHORT] =3D 10400,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_6][WRS_GI_LONG]  =3D 10530,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_6][WRS_GI_SHORT] =3D 11700,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_7][WRS_GI_LONG]  =3D 11700,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_7][WRS_GI_SHORT] =3D 13000,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_8][WRS_GI_LONG]  =3D 14040,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_8][WRS_GI_SHORT] =3D 15600,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_9][WRS_GI_LONG]  =3D 15600,
+       [CHNL_BW_160][WRS_SS_2][WRS_MCS_9][WRS_GI_SHORT] =3D 17333,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_0][WRS_GI_LONG]  =3D 1755,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_0][WRS_GI_SHORT] =3D 1950,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_1][WRS_GI_LONG]  =3D 3510,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_1][WRS_GI_SHORT] =3D 3900,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_2][WRS_GI_LONG]  =3D 5265,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_2][WRS_GI_SHORT] =3D 5850,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_3][WRS_GI_LONG]  =3D 7020,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_3][WRS_GI_SHORT] =3D 7800,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_4][WRS_GI_LONG]  =3D 10530,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_4][WRS_GI_SHORT] =3D 11700,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_5][WRS_GI_LONG]  =3D 14040,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_5][WRS_GI_SHORT] =3D 15600,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_6][WRS_GI_LONG]  =3D 15795,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_6][WRS_GI_SHORT] =3D 17550,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_7][WRS_GI_LONG]  =3D 17550,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_7][WRS_GI_SHORT] =3D 19500,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_8][WRS_GI_LONG]  =3D 21060,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_8][WRS_GI_SHORT] =3D 23400,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_9][WRS_GI_LONG]  =3D 0,
+       [CHNL_BW_160][WRS_SS_3][WRS_MCS_9][WRS_GI_SHORT] =3D 0,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_0][WRS_GI_LONG]  =3D 2340,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_0][WRS_GI_SHORT] =3D 2600,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_1][WRS_GI_LONG]  =3D 4680,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_1][WRS_GI_SHORT] =3D 5200,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_2][WRS_GI_LONG]  =3D 7020,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_2][WRS_GI_SHORT] =3D 7800,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_3][WRS_GI_LONG]  =3D 9360,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_3][WRS_GI_SHORT] =3D 10400,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_4][WRS_GI_LONG]  =3D 10400,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_4][WRS_GI_SHORT] =3D 15600,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_5][WRS_GI_LONG]  =3D 18720,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_5][WRS_GI_SHORT] =3D 20800,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_6][WRS_GI_LONG]  =3D 21060,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_6][WRS_GI_SHORT] =3D 23400,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_7][WRS_GI_LONG]  =3D 23400,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_7][WRS_GI_SHORT] =3D 26000,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_8][WRS_GI_LONG]  =3D 28080,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_8][WRS_GI_SHORT] =3D 31200,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_9][WRS_GI_LONG]  =3D 31200,
+       [CHNL_BW_160][WRS_SS_4][WRS_MCS_9][WRS_GI_SHORT] =3D 34667,
+};
+
+/* OFDM Data Rates - (multiplied by 10) */
+const u16 data_rate_ofdm_x10[] =3D {
+       60,
+       90,
+       120,
+       180,
+       240,
+       360,
+       480,
+       540,
+};
+
+/* CCK Data Rates - (multiplied by 10) */
+const u16 data_rate_cck_x10[] =3D {
+       10,
+       20,
+       55,
+       110,
+};
+
+struct cl_inverse_data_rate inverse_data_rate;
+
+static u16 cl_data_rates_inverse_he(u8 bw, u8 nss, u8 mcs, u8 gi)
+{
+       return (80 << DATA_RATE_INVERSE_Q) / data_rate_he_x10[bw][nss][mcs]=
[gi];
+}
+
+static u16 cl_data_rates_inverse_vht(u8 bw, u8 nss, u8 mcs, u8 gi)
+{
+       u16 data_rate =3D data_rate_ht_vht_x10[bw][nss][mcs][gi];
+
+       if (data_rate)
+               return (80 << DATA_RATE_INVERSE_Q) / data_rate;
+
+       return 0;
+}
+
+static u16 cl_data_rates_inverse_ofdm(u8 mcs)
+{
+       return (80 << DATA_RATE_INVERSE_Q) / data_rate_ofdm_x10[mcs];
+}
+
+static u16 cl_data_rates_inverse_cck(u8 mcs)
+{
+       return (80 << DATA_RATE_INVERSE_Q) / data_rate_cck_x10[mcs];
+}
+
+void cl_data_rates_inverse_build(void)
+{
+       /*
+        * The calculation is: round((2^15[Q] * 8[bits] * 10)/rate[Mbps]) -=
 unit (us * 2^15)
+        * multiply by 10 because data rates in the above tables are also m=
ultiplied by 10
+        */
+       u8 bw, nss, mcs, gi;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX; bw++)
+               for (nss =3D 0; nss < WRS_SS_MAX; nss++) {
+                       /* HE */
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX_HE; mcs++)
+                               for (gi =3D 0; gi < WRS_GI_MAX_HE; gi++)
+                                       inverse_data_rate.he[bw][nss][mcs][=
gi] =3D
+                                               cl_data_rates_inverse_he(bw=
, nss, mcs, gi);
+
+                       /* VHT */
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX_VHT; mcs++)
+                               for (gi =3D 0; gi < WRS_GI_MAX_VHT; gi++)
+                                       inverse_data_rate.ht_vht[bw][nss][m=
cs][gi] =3D
+                                               cl_data_rates_inverse_vht(b=
w, nss, mcs, gi);
+               }
+
+       /* OFDM */
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_OFDM; mcs++)
+               inverse_data_rate.ofdm[mcs] =3D cl_data_rates_inverse_ofdm(=
mcs);
+
+       /* CCK */
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_CCK; mcs++)
+               inverse_data_rate.cck[mcs] =3D cl_data_rates_inverse_cck(mc=
s);
+}
+
+u16 cl_data_rates_get(u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi)
+{
+       return cl_data_rates_get_x10(mode, bw, nss, mcs, gi) / 10;
+}
+
+u16 cl_data_rates_get_x10(u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi)
+{
+       switch (mode) {
+       case WRS_MODE_HE:
+               return data_rate_he_x10[bw][nss][mcs][gi];
+       case WRS_MODE_VHT:
+       case WRS_MODE_HT:
+               return data_rate_ht_vht_x10[bw][nss][mcs][gi];
+       case WRS_MODE_OFDM:
+               return data_rate_ofdm_x10[mcs];
+       case WRS_MODE_CCK:
+               return data_rate_cck_x10[mcs];
+       default:
+               return 0;
+       }
+}
+
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

