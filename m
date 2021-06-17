Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685563AB889
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhFQQIr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:47 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:56046
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233594AbhFQQH4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBPZ+B2kxOli98wsXj2hFuasc7567mvkfDMiJu3NL0T3MOo8Iog6PDdlp8RNkhr6YJ75BNNNlpe5a3yk8ZgttoDKWUhwee5AfEAda27eRhJNPh4BF3qSDm56LTMhvMVWkK6wQAKoCpwIt1FsoQIrv88dqp8jy4hcBpazeK4lcAAWD7e05qfMfA2h9Yzo+yN2xMyKu2Pr7eF3Q2zZ6NAfCwKtHh6CrNTEnoFRrGBD0DWQnkNOs65ZsyIU0wIQl/joHQeoo4PEr1bLKPS2odKlfAuUwCOPodw08cmhcMkvtjF30A3J119e3STWsVuQhmEkJCfzsitOvKI/CmUnt1cw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/JHCUo0hG3CkBa0l2f+0xMSw0iNO7fN4ibITJQe68s=;
 b=fCNcP2y73Oi+4S2y7GxQNzXaL5XKebGZUonHzALLwKAKbeX8Ls4MGpu10uP829VtcoLgvLhm9WLslaYcARab6QnqTwRGwPC3hCqUGfhx5z6uzbgU/cHhy72bDhfYrgAnQhbZVI4P/DdXke6HT+xltvpoUFCTDOqA1hbid4Cs2Vz4JXAToMpG60XBxgZkFe4wOlLiKmga1zm8/l9PM3iUEJ3esnIoNatOW0Nkn+qX2SSBN8jRM1IA1HiOAhGp3mSl6xtVy/yQw2jhT99xp0cJZu0g/Cx45QozOU7E7BUiYSIC+HezzhQLiZ+mAIm04mp85lWClK4Gp7zsO495/C29Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/JHCUo0hG3CkBa0l2f+0xMSw0iNO7fN4ibITJQe68s=;
 b=2imFV2vhGeKINk66y+u6L81ddvo92awouGjyc0TuijfEN7PpdN+pzNTCZtuJd1WI5g0DFj+OWGV1ePCdScJovQTGjfGTYdXCENqMNi1eG3UCliprlUwcTQQvAKmFOrT0eBv8Rz513tWD4inZqOZOu1pHeqO5r8NrQyf3JiuD1Js=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1059.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:46 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:46 +0000
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
Subject: [RFC v1 130/256] cl8k: add phy/phy_common_lut.h
Date:   Thu, 17 Jun 2021 16:00:17 +0000
Message-Id: <20210617160223.160998-131-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14ecee24-fb28-45d1-b22b-08d931a9a6ff
X-MS-TrafficTypeDiagnostic: AM8P192MB1059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1059CB31E2D8238C28CF86AFF60E9@AM8P192MB1059.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnl8kjZzBniTsW3lro06G4/jNKs0Xn5LQ9qSg8JRbrPIc0cCnV7mHr+giJFj6Rvdmy5n0YWNTxJG9B5bw/YjGZgr6Vf1xJ7+Rp34PKWW7ynSNWuDiYA6PNAm7vh1TrRIZfaEtPnvxZ8V83EaEC8dIxGHwz5k79yma+WTF1OVz+/NKQsQ7hskS9s7XnMqHwjLi3Q0ZiIWxLZt64PtjnIKIq70vgczWYRTBQPDgloMzhdDBrg3efp5WRZvElk1bsb/CZrT1r5AJyjc0Codf5yQXkJdOzRE95qqlssUZOq366uGr5kbFSiKMhF3mxHmb9dloBKMGemJXHzS1yYPhDX3cDPW0V74zxxH008M8p0G5A0zx84NmxQqma/VneGfYwh2AFc7clPWjUV8DYBO5XwJhR/kQb2Ib2QrpAGenwE6NUR8kjS1PQ47EAC3oFDDy+CsBGpj8h8S68fCnFNnPPraxAQzYjbDVnyYH61b1Df7VbToDXaVgBncnky9pp/mJdB7xhBrH8AO6M3miwvT/gCURdzi2nGdR82Fdi6ZziJr390BLTzzSXsOmFgh8NqG2iAlYdGjmqkgCw3H4UhIjmxOiAzG3r1DvCx/0q/LBXzh2eKX3XgYOPWSbGTwHQGnoAuH8LmCiuqofKbpbhYoK544z/FLgk1F0V5U2OmIhe9TOn0dV3i1cveNq6gpNYUNR/T3HxWyShj83xvDsulLWMnRAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(26005)(956004)(498600001)(186003)(66556008)(16526019)(107886003)(66946007)(66476007)(8936002)(6916009)(2616005)(1076003)(2906002)(54906003)(6506007)(6666004)(4326008)(38100700002)(38350700002)(83380400001)(9686003)(6512007)(5660300002)(6486002)(86362001)(55236004)(36756003)(52116002)(8676002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EawNoORgwlYHjMzLv39nDVHoiEstrmkKXcA4gdkmZcMgY6jmGVVx+0dnc8gS?=
 =?us-ascii?Q?sfaxNAdv84gFvo4vK55LoJ3Hlw0MRlnuMUPUoS0ZxDvzKBq/vgdOU8R7GA4u?=
 =?us-ascii?Q?PXLt3cCBzusIn+Tx5+sM0SztePKwAlkLqAXCmUvlCXD+tVTI0MysR9TnPvRA?=
 =?us-ascii?Q?2ofZ5mYg23xp3Qk3YAE8BpG4v79R0rokTGqckiLHGtPqPNhp3cBgo4dCWlS6?=
 =?us-ascii?Q?1J9FVbRDL268hOWJOKsDuZLWVIvlTACceN6k92ZkN2C4qT4PZx39MJqhSyZa?=
 =?us-ascii?Q?8nKmRsH49vJUsM81DFvi1p+ACmWfuAjwGxKImWOkNHmGkjsk7BAzyhMO2JTP?=
 =?us-ascii?Q?uA7OzeawlMjtDHl61i/0YNqYhXJ5Chsg/U5u3ciB/1UEwiHZjuMEl6uRRURY?=
 =?us-ascii?Q?dhd//NSANAanbcZHIoXusn8cMe6qzy8H51EVIQMY0+T1xqdDCSvHJap3xMqK?=
 =?us-ascii?Q?miQFJREX0Bu++5P7DOuNeK0Zz111sR0TWZmsxpQCoJ+2P6N2nK7b5p1Es/3Q?=
 =?us-ascii?Q?oozqftgTgxDRGpdSj+yhlV6+acoxMpYBwcIOlc3vWpMihpIbhLY7bf2bKAQ4?=
 =?us-ascii?Q?opOblmPKS6uUcoS2zXtHEaPxTFn97lRLyoyP7D4JIeCvvdknNvrjtnxZwClZ?=
 =?us-ascii?Q?Z+ho39hnUCUaChBkNkVuowEchKuM9PbmfY2xve+5+WwvxhQgEBPtyP2S/qhD?=
 =?us-ascii?Q?whfthyU2BzKdRdnDTnXjSNzjHbDYvRg2dEgX3H0tdWNGRMc+dLOyE62yCLyj?=
 =?us-ascii?Q?st7OjjAlazjROF2y5fKF7AbTT5Ryk5xZW47To6r3TkKjRSP4nbtQzLLIJgjn?=
 =?us-ascii?Q?+QlFfJxOETAAmosNV6nrukW2Kndp6oQfvRxdiM9PMAXjMW1vHKxRz/mZZ0q+?=
 =?us-ascii?Q?r0YOP3rQ5Xxd1faE25Z6jSx4wb00Kax5QCutAx0oy1lRsfOCQieiG3Gd80Yw?=
 =?us-ascii?Q?ok8GIOeSaOQFR+Xw3zsVgYm4Maf0CCVTp9yvnKt3SAYA0KdgSU7iVmXOv9Hy?=
 =?us-ascii?Q?BX99cEPPe3VCVCC/JZPlRDOMJ5YcRrlMpPxA8l/l6D51Itjg0gO1Rz5txrge?=
 =?us-ascii?Q?4gmxOwFZz1NCELLJEiMOV8HiouVcInOiPnltaJ6WZ/sBLK9hX16HiCsRX8Dv?=
 =?us-ascii?Q?UyRTRF4anWkM8JegCYpWMXxBzQ+rHafyumcCQiXzClJcdjocGPP4C8yXea0L?=
 =?us-ascii?Q?QLvJ+xKrgSEcd37z7LC2wnZaHZAOq021XWECdsYoJ1uC4U3hjhfMH25A5MPe?=
 =?us-ascii?Q?2uVq7wq7Jg8z4Wu/O6Vfp9wprU8fDIuurOUIyjnmfH/3YRbbLvBqJreI9TSw?=
 =?us-ascii?Q?Jjw/vHHJHn2HC0/uj2BrSP37?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ecee24-fb28-45d1-b22b-08d931a9a6ff
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:57.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HREsLu/OE4k8PmspLrfeWflv2zcFT4fXTfuB7ie8MtvJxdMXNmgPgf882kPVLekB/JJ4/xg5y+4588oF21+Ykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/phy/phy_common_lut.h | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy_common_lut.h

diff --git a/drivers/net/wireless/celeno/cl8k/phy/phy_common_lut.h b/driver=
s/net/wireless/celeno/cl8k/phy/phy_common_lut.h
new file mode 100644
index 000000000000..7ff17cb81ca3
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/phy/phy_common_lut.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_PHY_COMMON_LUT_H
+#define CL_PHY_COMMON_LUT_H
+
+#include <linux/types.h>
+#include "fw/fw_msg.h"
+
+struct common_lut_line {
+       u16 frequency_q2;
+       u8 vcocalsel;
+       u8 nint;
+       u32 nfrac;
+       u32 freqmeastarg;
+};
+
+void cl_phy_oly_lut_update(u8 nl_band, u16 freq,
+                          struct mm_mac_api_lut_line *api_lut_line);
+
+#endif /* CL_PHY_COMMON_LUT_H */
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

