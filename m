Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766923AB8E7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhFQQLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:05 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:64066
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233614AbhFQQJ5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ou5+3vB6fNV71v6rCkyqvJWYgvcuiHQt66ubvaMgx70+pGxqSbPnRxcYwQJQd5xM40/c/X3hBE/a+p+YLCNgX/ajnLkDyP19u7vtiHYOD3JEM6DTb8gJEG1uZw3pWZG3jiVLXFwsy0aju8//MSG02TosYdqHqM/VPpekNiXcOb2fPgzYXn5h7ulsj1kRiicuh2L9b+7Zotly9SIHVASu3hx2VSjKjUuEmQzis4RiOdBqxccdR5humO//Ruqrc8ox2e4mxqfROEs+GM1Wo1lP9BugknWLoj4e/tFG0CnVobbiHDBaeNLHrr4GLkqsslVzop8ZD9+srSv4riiqo48Ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10BMgkutdWr07lSYNJbOPiY7EwWERiqzztOipad4sP8=;
 b=Rs4g0y5id9wK1/EPNLG8OsltReoJUayBdXaSvLVFeczYEJkJxWsb1pcpWF4VQEq5Rg1U4n9rAs5cBsBUv9YfhL//kLAqHqL2fOhaAJkdKx4szVaYOOLvkgkAdKOe2L5FIyQaBRThjWLP24K+c43sn6lS5/bgsYJO+7O+lZoB3TWMZLVb1GD5NgL5U61PTZAG9UdJ/XqnsYqbWl/m88deLhTp2I6ehHbMdK3SwcKg+6d2XICFuDwfDxc+s9WLbgGxJPxnnVu4PYegpJOgi8WQg736Qbyfxa+W7yEQrU16OZKNRf7g6cdM20ir56zwxJOUChb/wls1b/2jHshhT58jMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10BMgkutdWr07lSYNJbOPiY7EwWERiqzztOipad4sP8=;
 b=SgbNcLOHOtkRFZ8Btp/U29SqCnGxYGLHySyeNwKLwxTg7TP6e/7z+dSGbtvUMT4t1UZoonde+imjg1cOdakZjgFn0d67xYPW0rhDO5vRL5QNnQRzJtXvZ6kNAcWkyYqY5XglAEvoMJY1cebxQxdc8od9AugrwyO0brOsUA3/XLU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:28 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:28 +0000
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
Subject: [RFC v1 162/256] cl8k: add reg/reg_otp_pvt.h
Date:   Thu, 17 Jun 2021 16:00:49 +0000
Message-Id: <20210617160223.160998-163-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbd764e0-def6-441f-4b91-08d931a9bb83
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB118779B71C20041414B4239BF60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mg1fei2DAIyXr26sJSTTphVuL460HnUnULVsgKPuWODrHzDQDZZ71+uTpcKLKUVi5Y7JDUnGUh5KWgmq1YKb/di1aLZYkeQXt7ZedIdhyrHEuZxBAztRZ31/BCzPrGAtTc8E5IGJLBPBYO1ym3k5WgkKvt2YUvFzDQcB2UTctyr2g+QdJSXrIuTjGPqIKwzBRXgcPnaWlgxd7fav/+CvSGEhLtfl5XZd92FWILa/53Rywc1UVztpwt6xpAHK7LSDNHuym272cf4Sr0BptSEHvQVzG3EqLJLzPLpeBRyCoLShgtuV9Bo3OqWjZ45UB77AKV5RUFwLa5usEnklgKrsHh5oOyMH5XOlUYvmi9hzGp763ASYZPfKbd1VmOYEnd5xi8su98NpgBE7DFoo058mMXw0UsEPm5KPDUgIzZzHegqZAf/GovU4bAH1t2T2gdQ/3v9zgisO/PstlQeK27H3NczME6i+QLuvJ/T/E4ocKuS+kXY3sgS75za+44viNqJ1WdftY8x1fGFGdZXLYGCldx02U7HthM1oooD3m2BW/P0lMuo0Avf6t3TGxJWpnGhRhXzs/qEekyyrEQUIE24TSuIQ4sZv6OFjAyUl2lkuqjMX0HWp/OGYyvweeICnla3adtROo+vHmmQcQZScBo52ulvWzyWOBRMENZmgH+Mtv5XDsG3Ivgf4Ws8APVYhgmqUlZn7kX28fzLclA0nNVOLNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ss4TCfvhd8AyDFP2CeNlRr4rwIDK1v+wTOBsPkaDCVDIx3qiac4TEANfI47Y?=
 =?us-ascii?Q?Jl00XrSMKpkNc5Q5spBueQKEaBAhR0BHfGEQMTg0AV7jS+dV5EYhj5TcS7rq?=
 =?us-ascii?Q?JkK1L/DqPQnbJT14zGftXTHnVnhwDlqz4EhWbOFbtU1H/S400RBkjnEQyuoS?=
 =?us-ascii?Q?LfVQfIO+jU4WP8TZwEoL/BBAR/GD6qbYqk9jhzmfSdRpaT8AsZ2loU4veyuJ?=
 =?us-ascii?Q?XqBeXYFizgqaMuK71/555vUDRyS/5tNxHDgSgUEBHtFFxIGz1s0WtmxCTT4+?=
 =?us-ascii?Q?1vHJL9x1+OoQkO4MYWfhgTxxqJDatz1ZeZCWGwt/1Wy8k4rIye8WoMA6CD3l?=
 =?us-ascii?Q?m/DFJnRZ/wfyCod7IwKbBa/V0zCvJTOH7fZQUUWsCGwyhHIVBpfA3l2W5o9j?=
 =?us-ascii?Q?xy+bhdoI+c8xBa5wpCqnU9M2cD46AYdVeAjEOnA4PbBbnlpVg7CyLm1mfiE/?=
 =?us-ascii?Q?r1BfycP3aOnR9Q4x0nrGhfasIH9Q2MFJ4JXXgOjRcfZqY1yG8OCZ6Uwbz0KW?=
 =?us-ascii?Q?SHTi7V9IqEza3H/FHM+I86Vi60cm8AVGZrx1czcaWuEZQwGgXfjyC3XfgqN9?=
 =?us-ascii?Q?qgEEfQPMyX64tLXu2MGuAFoWk05ik3mWJsN7GAryDw3O51TYL2feqEvy0QNv?=
 =?us-ascii?Q?jn58ElznLm7z7F6vPXe7AAO1ayoKYkzEyFWfCwoMqfs8fYvIHCsPUUQSo94N?=
 =?us-ascii?Q?M4ZDpvcYXq9AIyOzyBPCuWiMthER1DFiKZ6LII9J6ggKbyRn7L9647w7h4rV?=
 =?us-ascii?Q?Qds5X/YSCw8+SrBgxuzSOzGdUmae7OD1LGF5f6vhSe3J9tv781z1MmWJx5zt?=
 =?us-ascii?Q?khUKm0x92CMV5DJpZZSzlW8t8VLzY8S07uvkhGygDtL//HW9A7pK3P7vaYys?=
 =?us-ascii?Q?ETyUb5+weBj4sUmzSlo2NgbvpvShMP2y/eW5nJ3OFQ+uh+1BPaciIklzQDD+?=
 =?us-ascii?Q?89C4szwZdsFwcpOjz3NSWD6J4f7v6Jp3tVGZi1XiVHUz0Poj1vQm94mzqU+F?=
 =?us-ascii?Q?nlRV3kGsn0Zt7kW339Lr+qT9bRqFQiEBRfbb/M8+3N54KLfdraBcQZxwQwIe?=
 =?us-ascii?Q?lPF8d1bsTFK7P72k18c7wciF61dYO1gmExpgFKCB340KNJKqvE0rHJYeaEum?=
 =?us-ascii?Q?Gdpl/w1hF0EkPgMRz2zIYotyaIFyyiIS5drME7lSlCuJYgYKtapRjOyidHzv?=
 =?us-ascii?Q?wy54/OSWEPft5UflCZJfILK2ba3tolpcJOeTxHBYGEu1kPg2kQTPKVXgJS4G?=
 =?us-ascii?Q?7nzY2afcXQE8DIncxurpX2743T6JE6sw8HKDHYkjY7Ntkebr6XnAi5nZ8vTG?=
 =?us-ascii?Q?4RGCwcYZm60l1Xi90m9Gc0PP?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd764e0-def6-441f-4b91-08d931a9bb83
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:31.6247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C84xIRO8DniN8PIzCqPAtnQbjo49raZLbmWZbky1geUXhCqQu0TiHvFmeWdbW1L+PiE4URrIzb7hiPPecbeHPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/reg/reg_otp_pvt.h    | 219 ++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_otp_pvt.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_otp_pvt.h b/drivers/n=
et/wireless/celeno/cl8k/reg/reg_otp_pvt.h
new file mode 100644
index 000000000000..18866c1c3710
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_otp_pvt.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_OTP_PVT
+#define CL_REG_OTP_PVT
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "chip.h"
+
+#define REG_OTP_PVT_BASE_ADDR 0x007C9000
+
+/*
+ * @brief OTP_CMD register definition
+ *  OTP command register description
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    28    OTP_PR_ACC                0
+ *    24    OTP_ABORT_CLR             0
+ *    16    OTP_READY                 1
+ *    12    OTP_WRITE_FAILED          0
+ *    01:00 OTP_CMD                   0x0
+ * </pre>
+ */
+#define OTP_PVT_OTP_CMD_ADDR        (REG_OTP_PVT_BASE_ADDR + 0x00000000)
+#define OTP_PVT_OTP_CMD_OFFSET      0x00000000
+#define OTP_PVT_OTP_CMD_INDEX       0x00000000
+#define OTP_PVT_OTP_CMD_RESET       0x00010000
+
+static inline u8 otp_pvt_otp_cmd_otp_pr_acc_getf(struct cl_chip *chip)
+{
+       u32 local_val =3D cl_reg_read_chip(chip, OTP_PVT_OTP_CMD_ADDR);
+
+       return ((local_val & ((u32)0x10000000)) >> 28);
+}
+
+static inline u8 otp_pvt_otp_cmd_otp_ready_getf(struct cl_chip *chip)
+{
+       u32 local_val =3D cl_reg_read_chip(chip, OTP_PVT_OTP_CMD_ADDR);
+
+       return ((local_val & ((u32)0x00010000)) >> 16);
+}
+
+static inline u8 otp_pvt_otp_cmd_otp_write_failed_getf(struct cl_chip *chi=
p)
+{
+       u32 local_val =3D cl_reg_read_chip(chip, OTP_PVT_OTP_CMD_ADDR);
+
+       return ((local_val & ((u32)0x00001000)) >> 12);
+}
+
+static inline void otp_pvt_otp_cmd_otp_cmd_setf(struct cl_chip *chip, u8 o=
tpcmd)
+{
+       ASSERT_ERR_CHIP((((u32)otpcmd << 0) & ~((u32)0x00000003)) =3D=3D 0)=
;
+       cl_reg_write_chip(chip, OTP_PVT_OTP_CMD_ADDR,
+                         (cl_reg_read_chip(chip, OTP_PVT_OTP_CMD_ADDR) & ~=
((u32)0x00000003)) | ((u32)otpcmd << 0));
+}
+
+/*
+ * @brief OTP_READ_VAL register definition
+ *  OTP read value register description
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 OTP_READ_VAL              0x0
+ * </pre>
+ */
+#define OTP_PVT_OTP_READ_VAL_ADDR        (REG_OTP_PVT_BASE_ADDR + 0x000000=
04)
+#define OTP_PVT_OTP_READ_VAL_OFFSET      0x00000004
+#define OTP_PVT_OTP_READ_VAL_INDEX       0x00000001
+#define OTP_PVT_OTP_READ_VAL_RESET       0x00000000
+
+static inline u32 otp_pvt_otp_read_val_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, OTP_PVT_OTP_READ_VAL_ADDR);
+}
+
+/*
+ * @brief OTP_ADDR register definition
+ *  OTP address register description
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    12:00 OTP_ADDR                  0x0
+ * </pre>
+ */
+#define OTP_PVT_OTP_ADDR_ADDR        (REG_OTP_PVT_BASE_ADDR + 0x00000008)
+#define OTP_PVT_OTP_ADDR_OFFSET      0x00000008
+#define OTP_PVT_OTP_ADDR_INDEX       0x00000002
+#define OTP_PVT_OTP_ADDR_RESET       0x00000000
+
+static inline void otp_pvt_otp_addr_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, OTP_PVT_OTP_ADDR_ADDR, value);
+}
+
+/*
+ * @brief OTP_TIMINGS_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:25 otp_t_CPH                 0xa
+ *    24:18 t_PES                     0xa
+ *    17:16 t_UT                      0x0
+ *    15:08 t_RW                      0x15
+ *    07:00 t_CSRT                    0x29
+ * </pre>
+ */
+#define OTP_PVT_OTP_TIMINGS_1_ADDR        (REG_OTP_PVT_BASE_ADDR + 0x00000=
00C)
+#define OTP_PVT_OTP_TIMINGS_1_OFFSET      0x0000000C
+#define OTP_PVT_OTP_TIMINGS_1_INDEX       0x00000003
+#define OTP_PVT_OTP_TIMINGS_1_RESET       0x14281529
+
+static inline void otp_pvt_otp_timings_1_set(struct cl_chip *chip, u32 val=
ue)
+{
+       cl_reg_write_chip(chip, OTP_PVT_OTP_TIMINGS_1_ADDR, value);
+}
+
+/*
+ * @brief OTP_TIMINGS_2 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:26 t_RD                      0x5
+ *    25:16 t_PW                      0x50
+ *    15:08 t_PEH                     0x20
+ *    07:00 t_CPS                     0x20
+ * </pre>
+ */
+#define OTP_PVT_OTP_TIMINGS_2_ADDR        (REG_OTP_PVT_BASE_ADDR + 0x00000=
010)
+#define OTP_PVT_OTP_TIMINGS_2_OFFSET      0x00000010
+#define OTP_PVT_OTP_TIMINGS_2_INDEX       0x00000004
+#define OTP_PVT_OTP_TIMINGS_2_RESET       0x14502020
+
+static inline void otp_pvt_otp_timings_2_set(struct cl_chip *chip, u32 val=
ue)
+{
+       cl_reg_write_chip(chip, OTP_PVT_OTP_TIMINGS_2_ADDR, value);
+}
+
+/*
+ * @brief OTP_WRITE_VAL register definition
+ *  OTP write value register description
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    OTP_WRITE_VAL             0
+ * </pre>
+ */
+#define OTP_PVT_OTP_WRITE_VAL_ADDR        (REG_OTP_PVT_BASE_ADDR + 0x00000=
014)
+#define OTP_PVT_OTP_WRITE_VAL_OFFSET      0x00000014
+#define OTP_PVT_OTP_WRITE_VAL_INDEX       0x00000005
+#define OTP_PVT_OTP_WRITE_VAL_RESET       0x00000000
+
+static inline void otp_pvt_otp_write_val_set(struct cl_chip *chip, u32 val=
ue)
+{
+       cl_reg_write_chip(chip, OTP_PVT_OTP_WRITE_VAL_ADDR, value);
+}
+
+/*
+ * @brief OTP_KEY register definition
+ *  OTP key register description
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 OTP_KEY                   0x0
+ * </pre>
+ */
+#define OTP_PVT_OTP_KEY_ADDR        (REG_OTP_PVT_BASE_ADDR + 0x00000018)
+#define OTP_PVT_OTP_KEY_OFFSET      0x00000018
+#define OTP_PVT_OTP_KEY_INDEX       0x00000006
+#define OTP_PVT_OTP_KEY_RESET       0x00000000
+
+static inline void otp_pvt_otp_key_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, OTP_PVT_OTP_KEY_ADDR, value);
+}
+
+/*
+ * @brief OTP_CLK_DIV register definition
+ *  OTP clock divisor register description
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    08:00 OTP_CLK_DIV               0x1
+ * </pre>
+ */
+#define OTP_PVT_OTP_CLK_DIV_ADDR        (REG_OTP_PVT_BASE_ADDR + 0x0000001=
C)
+#define OTP_PVT_OTP_CLK_DIV_OFFSET      0x0000001C
+#define OTP_PVT_OTP_CLK_DIV_INDEX       0x00000007
+#define OTP_PVT_OTP_CLK_DIV_RESET       0x00000001
+
+static inline void otp_pvt_otp_clk_div_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, OTP_PVT_OTP_CLK_DIV_ADDR, value);
+}
+
+/*
+ * @brief OTP_PROTECT register definition
+ *  OTP address protection register description
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    01    OTP_PR_DIS                0
+ *    00    OTP_PR_SEL                0
+ * </pre>
+ */
+#define OTP_PVT_OTP_PROTECT_ADDR        (REG_OTP_PVT_BASE_ADDR + 0x0000002=
4)
+#define OTP_PVT_OTP_PROTECT_OFFSET      0x00000024
+#define OTP_PVT_OTP_PROTECT_INDEX       0x00000009
+#define OTP_PVT_OTP_PROTECT_RESET       0x00000000
+
+static inline void otp_pvt_otp_protect_otp_pr_dis_setf(struct cl_chip *chi=
p, u8 otpprdis)
+{
+       ASSERT_ERR_CHIP((((u32)otpprdis << 1) & ~((u32)0x00000002)) =3D=3D =
0);
+       cl_reg_write_chip(chip, OTP_PVT_OTP_PROTECT_ADDR,
+                         (cl_reg_read_chip(chip, OTP_PVT_OTP_PROTECT_ADDR)=
 & ~((u32)0x00000002)) | ((u32)otpprdis << 1));
+}
+
+#endif /* CL_REG_OTP_PVT */
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

