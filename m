Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5E93AB8BE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhFQQKQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:16 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:4749
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233724AbhFQQJJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfbuPU1GYJdmLbq4sqb+GUVC3ambpqzj90LvddJFMG+zL+P7u4qTXHz9PK55Kq2cfL9KksHSHT3fJie2Sw0tVPa4JA7gQ24ydlzbnq7nBg/+psYkuWn8Ih+UHCclYSEqxg2FBKu0y/ov333oUDuCIFAIW0K3mKjj4g9vrasw9DH8uAc8WtE4lPHZpg+vNbJD6Zuo/zKIPICFPrzlsiuMX1FZjDMcT14D45SwXkHndkPontus6LdjFdoLlctlbRv40CiUuSO11xDDqMGRzd7Kv1jn886pTcqarqcG9SFAuVhpUv9CWKBVJTUVqdSwvu+ikoXevyFqaJ8Za3X/0Of/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6Jp2ZWDpmXuvhy2UC/IlOvFWHexJBSfLpvrJKhbvxI=;
 b=nfSdoh5N057jOow3jReB6NasyGsOZ47y2GZN0ZXn9QmJakl8XUm7dlIfpfUNWYBiKdjfv888N9eYY9d8NpnawkFkMp5cV12wrxB38UAn5gGV90fnTsX85hhKa5zmWGAG1HKkC7w/xj2mqeVIZnJmrZCzkMnCtEFex4hTqNo3zBIQI7m0Pf3b76+VD67shqYI2W0jCB7SyE7eFB2UNVBg54IyDB0+dX3PZYWNVkK2y1rU2YKbhLcG/Kl3ko7tUj+xPy+51ZMZVYEbIcFmf9HKKJIeaka+EOsp9xfpkiCN9UGa0JmLx1yPelHxQLTE6RWM7LHhm0OAKXT2XN0am36FGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6Jp2ZWDpmXuvhy2UC/IlOvFWHexJBSfLpvrJKhbvxI=;
 b=tSEoR/Iog/Z6GqV9wJWL0oa5PBIXoTyIA5Fjo9y5CAQo6jYQlf4gaCjmBDOSDxO4jpOy2YTXTNIr7cyM8rSEPmVA62ngSsdu5CCYbLwufzslpgTNB+rH7sTlRPuMC33b1DY09fzHHArzY3Psc99V7AFNijgg5B+yLdTHZKYEbvQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:25 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:25 +0000
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
Subject: [RFC v1 155/256] cl8k: add reg/reg_lcu_common.h
Date:   Thu, 17 Jun 2021 16:00:42 +0000
Message-Id: <20210617160223.160998-156-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40a4952f-88c8-4285-eeb6-08d931a9b736
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1187C286B6DED7407A7910E0F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHIhKjXDnnV3h6TENEfWMwfLVhiOwNznQ9+BHKvsQBVCt56LvVLiP9nDeOf6t01aCHWjeQuTkvONcpw4hQFWaz+skghp5k2r6xjygZ7q74UqugrXpF9hoSpPKicGlOrunLtl3FRW+cUOhKTIIss2ujznm6DPJ6UdwEoHa8NDoD0QVG7TJ45OY8Yckn3TQvoZVZsJ8xKa9lesSskoT7w/o9Z4pdM5oLb1rGAMmNIQW8cg7tmprAmCXl6en89DZOEGfuxyHzBpns3sjTKeqcDwEtGRt021wjTK1mFW/vQppDPm5R+VPl0sYEw0QOyoPOnN5shtuZspwhNMD6mvsoKakd6iHSfzrA62QIllHB9ZJ0vRRR0jAY3YmAFlIT1Uur6rOGA4ByWkZ6aj5d0f88eGoedaY+JuB16Hur2nw+2pdmwOBIubAgSsgwAFeWkpbP8Kxnzh1gaGVNaS2RibyNFVgP9gd4CaMfFy9yScyLUnmaadUawpYKdhDsOyAVK5YUET6OoYBCWyl/PBb7Lyc4AjahYNHJzPvaN/g7bhBiTZbGr2lh80d2OO82o/b8bLTEwanzRF1FiA4z09TGlUvkeuAXHiNwvWiUHeVPUgNGmlbrx0tI/Q6wm7apxlZHIE1swYAwojOM5CL4ey/iShq4av9+dJltQIwMXwtE4yaKHut0/dsG/10iYLiqzqz/HCQZn5bZlHEg8x3h9ZT0rnCjuwdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(498600001)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ogyg171KiYXP3nKwYn24WOhZiBZ6tKLLK2GdqhJBGahy1pLsNl/Sdt0VrnKy?=
 =?us-ascii?Q?gPE0AIxPd2ZtPreUHJesoiLOE+tmzgkjiUG8r9yg3JqOgBuNtMLWKES5aOk1?=
 =?us-ascii?Q?QhQsqFg42hymRz8ZTbNGUTh/4o1s/4Q+EZ2hWxykXn7YKs7JxochBOgnrhRh?=
 =?us-ascii?Q?LMDfrdxt3ImClwD6SzpRUFYxCiyWyU73f8HBzQ324z/bZ9yxIE1TPThNvgKp?=
 =?us-ascii?Q?GdLkvfL6n/eaQq/qI+nKaXJpTlYzNEgrp/LYUYn2PlBTvsxsNxOQ2oXBEyyS?=
 =?us-ascii?Q?k4IZaG8Z11zQfqUJ4fTbQg/OhkfWENxLMYpDMLPZSN7hOOzJhaB2UXQfasLq?=
 =?us-ascii?Q?trCfRaLE/UxqVlIzLewc2tBUFPgj7bue6YHrw3hK1zCVdh4A/fUW+bsxaeKO?=
 =?us-ascii?Q?i86fqmOISkhlpa12p93lS8Yu1Mwu4tLieljZ3wFYs9npSSiWHMpDVDnVwcMs?=
 =?us-ascii?Q?Ub0gJhJRrijvhYAA7FHzffSabQWJ0Y4aa+hW7SJorxGZP2gMIvGHU8Bwz+m8?=
 =?us-ascii?Q?9jIcPOmGG83idW6TE6BySPpfWQx4o4jtIPO9pjRCxWmeLiV5tAoDcUnYwthI?=
 =?us-ascii?Q?9E5GCB3IiVNYeYSp7OzkvqaivQipKjfzc+B+AwdSMhucr5O8quULiIA88TgU?=
 =?us-ascii?Q?ggJXMnwZ7aXLm13es0cktJPXH5R9McWKIwGkbapZmXHo4IveOoPVso1eBzo9?=
 =?us-ascii?Q?8FHRA3ShCASK57rdIqr1vK3pyPNExXppKExMcU8J3dbvJQhT59Ourw1aTk3x?=
 =?us-ascii?Q?XyAIYSGs/eYa4TlMQUlOrjg4eu5eZZPvn2gcXjqv2D41HwlEwFk2mrjjxupZ?=
 =?us-ascii?Q?AghREBaLt1cRKlQ7gb31jvZaVhlXL1F0khcU49VGju0PMy5FGEExs8Rz7EWg?=
 =?us-ascii?Q?q525dB3TZH3vxWRhc4i1YjjPp90BP4VuG6C6S6ohjEOCvlYx8LVxB4ef1636?=
 =?us-ascii?Q?+vXHUa8AIMRj8tAERfa4A26aG1U73S8k9liJpnSk1KImBygsI9ZIRd9taGHG?=
 =?us-ascii?Q?e7bb3TP6usvBYKEXElwaRH5EAaUba88BSq0QECq2OHzeEbsRhL0EXvzxfZiV?=
 =?us-ascii?Q?qveWgZw5KaVYd0ihL6Ld5OE04qTp0phUe2IDtVPfUk0aJQ0cwa1qUUhH+KaM?=
 =?us-ascii?Q?0Li4M50uX3hZX0+0JlOIi5WN+s6HtBc1KLQWmO/oOw96ns7dKE53utZe+LdB?=
 =?us-ascii?Q?9g6/Rd0tPyJHVFRvl1AkPmKZmR6pgUS9OGDgNgM9eQmrHJLV3qjIYSBySXZn?=
 =?us-ascii?Q?TCgxG4fNarxQALUn0QrnjAGahNpOLOpQuEAEYKkY/FgenZdwnn0oLcnYENHI?=
 =?us-ascii?Q?5bqRlFM5x6j2M4+llAYn4rD/?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a4952f-88c8-4285-eeb6-08d931a9b736
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:24.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apOPJCC8StTxjWbQLhy5dgHgFHJYDMNnVB4ciT1L4HRG48xTHhdSwBBPpRuBBPSpqImmAHvq5GnDnhVIWKJUpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/reg/reg_lcu_common.h | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_lcu_common.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_lcu_common.h b/driver=
s/net/wireless/celeno/cl8k/reg/reg_lcu_common.h
new file mode 100644
index 000000000000..0f4695b7f66f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_lcu_common.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef REG_LCU_COMMON_H
+#define REG_LCU_COMMON_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "chip.h"
+
+#define REG_LCU_COMMON_BASE_ADDR 0x007CF000
+
+/*
+ * @brief LCU_COMMON_SW_RST register definition
+ *  Software reset register description
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    SW_RST                    0
+ * </pre>
+ */
+#define LCU_COMMON_SW_RST_ADDR        (REG_LCU_COMMON_BASE_ADDR + 0x000000=
48)
+#define LCU_COMMON_SW_RST_OFFSET      0x00000048
+#define LCU_COMMON_SW_RST_INDEX       0x00000012
+#define LCU_COMMON_SW_RST_RESET       0x00000000
+
+static inline void lcu_common_sw_rst_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, LCU_COMMON_SW_RST_ADDR, value);
+}
+
+#endif /* REG_LCU_COMMON_H */
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

