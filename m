Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC13AB8FE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhFQQLq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:46 -0400
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:63555
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232834AbhFQQK2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOmU6WW8mA3Wib9VYR8Zf7pbqsyRIOkEZrZ8bwFuHsaz2egfHsgKoNKCEl6TFC/zomssbgDi78Bv9h2h/uor6dH/c3TX77FmPq6wE9XuTEz9T39Oz9fW1OsbXhYAU9UYSlWYdfE5w1XbKaL04DnCUSRcQoomiC6qhroOTjCPA18amv6/ju++JFB/CI3/sqy7dAo/um+AWyqWTYrxGey6w2REhn472qfDls0//RHk91dCh/rgtwjgLerWBNdlwMj0+JWI6Xhz0yTHNAaGT/ewktkuK+XgygkVpmf7DIwVFkK71u+WKKnU/JFfskIxowFqa9C2fsrN3SCYoniflpkePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPATddJtv+T6J8mQy9N8tDif6AiIRkYa+0KQ6uBAqwM=;
 b=BxnmVH1GiuK6F6XgvAXguETz6xwVKzo+3cRthBVmEqEylL+1CDeHhiZE6bTXF7kaNZxL/8yWrtg74a2eV3003MKdwEDM0IKqF5eIm8lcsvCHLIp9PU4e7rAQP069ySkiZnne4AvaE3N1gPfAjGn1jIoTHykJ2TsMjyoI35M4LSbF1HVqGhiCl32RLo9DJ8N8/J0sI80X+LWm55QY3M+9f/9F06POWIRFRnYhBcMYsjGqI1tHyIj3XMEeU1of/9jdU+fFfYjTX+5A5qo55Sy+ezGiP1AjtpTp8r4pdjJWSOtRaxowdkp5MYqb/vPxpp4L9rmoe6PcfNSimh9neNxSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPATddJtv+T6J8mQy9N8tDif6AiIRkYa+0KQ6uBAqwM=;
 b=vADakhaO2Ktbbcwn4kVfuMeNUEtJ3rN76I8FNNDe2q7fIE8usjbMTSYV7ySNxW7kPl+RF1MVXpdp6sqN7v3SuORSQxX8VogqGt6bR3WQ347cdkGDVik8X79jUHf9qvlHOS1bTHK/KDwgvbn8Xvxgid30pmUbsuigmh3nqGmYtsI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0981.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:06:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:37 +0000
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
Subject: [RFC v1 179/256] cl8k: add rx/rx_reorder.h
Date:   Thu, 17 Jun 2021 16:01:06 +0000
Message-Id: <20210617160223.160998-180-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1bc3519-4c83-4eba-d52a-08d931a9c78e
X-MS-TrafficTypeDiagnostic: AM9P192MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0981A96F17618518593E3E19F60E9@AM9P192MB0981.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjzktfHpjvMtEz1DTeHNLU3A08xBI5qhGjdkhRwi3Pqwom1TYIGOcqS9hsb1/ANhmd+w82/rSGc/HoUZTrswj61OtprwJbo5XHvp3BbBWfAsDBa/EvfpMUS5AT0Kmlot4O0gfA2Ndtsm5VoSBcJ1oqvfPvINzjBn/poc3AUAUJEZUSDbqaHKDvHBlbulRXTe5brSZbATeoLyvrRYGeZxPYMHLuhBzzlwhtC3bhsULfui63POVFcZ/ehd0oKH+nH7fBL8M6EhqQKkexWg2a958GaggspN5W7M9JS3tT7r0NH5hC2vA+HpwhSHTauCdMVJgNsY4rf6sDRfr7TLagnyd24rzhKQZlHFjPQalCJSL4aJSIifK4egOpJz+ezjvi6BBq/7PWt2qrei/RqPrC0p9v8mwrVMywoFsM5J7xgdCTu/TBLCwpYqRbUj4FcNr+Xf6aJBkP6hX6XbaeLxqHRklA8s3tt9VWtYELOEDZCheJq9VW6MMHhExplUM6IDjIJw8BPw1V8gk34O3pjwAPFULIH3GvpYgKZVzEfqO6o8bO1lFBeAtooBdMcOeXSAVbU4qB3YgivXhBWYT8uIBQdNc0KOp3OowZAm42+DJIBcg0Rx7FedpBlegpwuI0wzaoNXUvMDbaK9unXXt2sJIq1s2iulj2ubxckhZ/A+d96VUmL4MJCOhWXcpahUXKO4dkg9ze3hfiBXAofy3/SWJwdasg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39850400004)(86362001)(5660300002)(9686003)(54906003)(107886003)(6666004)(1076003)(2906002)(478600001)(6512007)(26005)(2616005)(38350700002)(16526019)(55236004)(38100700002)(6506007)(4326008)(8676002)(66946007)(186003)(66476007)(66556008)(956004)(83380400001)(6916009)(8936002)(36756003)(52116002)(6486002)(316002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dwi7DS+9YtwAOI19rY1WIRXRxsysiJfiiMmMoMuQb9lUxf58s08mgCTPDt+l?=
 =?us-ascii?Q?l4/HoDzL9eWaCZT1bvmfAoPJqNf3OvCjAZx5iGq62avV2jlcOjMExspaQr+u?=
 =?us-ascii?Q?DJ8KfTl5eIkRfhlSq1mS/dBuKRn45pygw0eQR4iP7idvhh/69hGvSTvO0E0E?=
 =?us-ascii?Q?ILOFPhVynDQtLY2qptJsDcCj5C5o0pulUGqHVvjsbcUMf0cGPAlHWyO2OdNz?=
 =?us-ascii?Q?+Ncm6uQOFyonWOBl3AzNBP7Br29y5gQNaMeU8nfOYdssKB9t32y5JeA2Ht62?=
 =?us-ascii?Q?Ici6d3wLvqqtdX1aNVii6MZ/8ON9mKWZzLsLYKrTJbthWMoluMheaRNgQWZh?=
 =?us-ascii?Q?/AWYmTQzi4C25oZ57jBHANxQ2FEywO+umGJnOUhKYyjgzEXHLK5x3Gewt/4s?=
 =?us-ascii?Q?mdH1JqRROyyWApqpa0emRyY5NuotmNVDbE+lnCFVmjNkjREtr/I1VNybD16G?=
 =?us-ascii?Q?UhmuEzLk8lNUnu6Asbvsk4NYQUcJK+i7RS/QtlzpsUEuw+HD0fgwwfn4lCyU?=
 =?us-ascii?Q?W5gHR006kFgkSbVR5hlkYYCXO/cG2A5zN0tVwGn3Q7QNcR3CNQjIrkENC8PA?=
 =?us-ascii?Q?TAkHf88xNx9A68u65nPFz5pmF9GCxnAlsWs2cYP5cLd9v2iX3VSTN3eI3737?=
 =?us-ascii?Q?RaetUyZAz1WoOXtAm2kSYimYxiBAbpL9NsD+4/CkacjZubDJ1Ln0tjNULCcT?=
 =?us-ascii?Q?7CWqniGjzt3dw5M4w28sXu+No+UnyxUeTkVL9WApqnVEZa9LhUaR7xeKC92X?=
 =?us-ascii?Q?Sb4EDyhYsNWuLSKjl+b50Ps93MZr9MmRVeXo2cmgcjJu6ZHgZc5+dnuQ7/tC?=
 =?us-ascii?Q?ePAtnOIJvFTg3z57w5fOOLZS734NxDhJ9F56REUh2qh2w+O9UfQ3cn1wRu/v?=
 =?us-ascii?Q?CrwzZZJu+Mli9KjAa811oPbPIo0uBdcRaWc3EV+PDXehMfLsQXU4zpOPgAbb?=
 =?us-ascii?Q?M5HeXbLKdEFawkzK8PharKLuBwgZaCKa2pejczmVcLmg77yp9E4r8r3/53V+?=
 =?us-ascii?Q?WQuJach19A+Vl78GOIRZhYKwI+gwsRFe7RwBsHXvWQDe0UkppDQVkFB5SNWX?=
 =?us-ascii?Q?Y1FXQ1eR5ksYze8Gvd2Wo5ZbAKcG8nEy9rNXdwPlvawpZSt2EogANXwYVCqP?=
 =?us-ascii?Q?tkWVQDmaVX40OV4BuuDznt5AmqOJ+aZPSnDOFIbq3NQ0DV/yymOpT9aZzZjV?=
 =?us-ascii?Q?NxYb1vHnqh3agoDoIrlrWaGEBtydKx7roqsAaPKV9tfnNt6ncIBwAzBbcl0I?=
 =?us-ascii?Q?uYBhb6+b1UxjY4oGH08PYqLGqrB790qrDEfl3BJd3IquTgW740kKvysdWN6a?=
 =?us-ascii?Q?RWCiokrmA1sTXAWX2nuaN/NC?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bc3519-4c83-4eba-d52a-08d931a9c78e
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:51.8380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dfkveqv99IISGCZuk70CFnTOIqjUHsR5GTIxk+wmWruOdOGzs/7MzuWZ5qHTXp9s1/CUDAvP6O9K0fc+08kZgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0981
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rx/rx_reorder.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_reorder.h

diff --git a/drivers/net/wireless/celeno/cl8k/rx/rx_reorder.h b/drivers/net=
/wireless/celeno/cl8k/rx/rx_reorder.h
new file mode 100644
index 000000000000..7fa98236c1ff
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rx/rx_reorder.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_RX_REORDER_H
+#define CL_RX_REORDER_H
+
+#include "hw.h"
+
+void cl_rx_reorder_ampdu(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                        struct sk_buff *skb, struct sk_buff_head *ordered_=
mpdu);
+void cl_rx_reorder_close(struct cl_sta *cl_sta, u8 tid);
+void cl_rx_reorder_init(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 tid=
, u16 buf_size);
+
+#endif /* CL_RX_REORDER_H */
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

