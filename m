Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F7F3AB8B7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhFQQJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:58 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:64066
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233602AbhFQQIr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUO3xhDDpIffeOZicj8sDpQnZxTu9jKefv/O5eEaak9l7Knt+/OplDHa2UC4JqypfVp1eaGeZmfoBVX+VOyo5wHfVuwU85pcYuuvG87JYXw5sR9NlujOfUdHltEl8zIqGuPtY2TwxFJXdOx0pbVL/PN08f8PEibBnGttcCAhqgnl5Yw1FAZZBCV7r2c3NETyXSHLyOyVfjVDU2RN5TuZPvuEzWtqAHqyUT9QAZw+/aMZkwn7m+m4J/fUIjr8hya7BKYVSq/0T8nqnOqhwj8HM95vtNw09YNEEv6KmPjiTRcz3xWrQfE8jpwvrR96rVjHO61QSIWpsTYE7bQmNfPwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9snMzudNiWm0TGNUhu4gEWEKzghH2YyfWybTUyg7bQ=;
 b=IxGdCR6VwyqaTIJix/MJuBqnds4i/W2m5jW+KWQmwrqnM/C83Duje39/zLYqeER7eSYiQz0eP4GYKPMG16BBh36xuJgtmU9ZDTl3YI0Pp/nNNs8OwZYgaGLIh+bx4hwcYuQTZPocQ2d3BIo5mJev12Q/3sy0bb/Cs06kmEB3j5kGa5DOwmGVGf7k6D/wOSHZXv0+PJyF+KRuORWNMmvyppuk1AX6NMiT/p7EScdnQGneIoTz4gGSeLjdo042E18J4hTk29OJ/PPJvEYYGakK8u14l3ayyG/dr8qLXpbd1s+e3ksSekJD4XtQd7AKPTS0u3VytwbSrmpEx7rK6cDvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9snMzudNiWm0TGNUhu4gEWEKzghH2YyfWybTUyg7bQ=;
 b=UARXMdv6I8XyOTkH48zH1D5CBPRPa1FMM8fKczyiAubjfgZafrJT4pOVpI2B0bVZ4v6TSsm/ZKTF0H6y76p+3nr5l/LTuQTJK7fothjh5UUYXspxS6ThqT2Nu/xLBeUFsg4OMUzzbS4JABlE9QOsQ8m/hkk+uM1x3Y1oks2+NLw=
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
Subject: [RFC v1 154/256] cl8k: add reg/reg_ipc.h
Date:   Thu, 17 Jun 2021 16:00:41 +0000
Message-Id: <20210617160223.160998-155-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d93760ba-c997-4718-36b1-08d931a9b69b
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1187D6070FF5A66FA7DAE16AF60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hr5dcNZPuy6LOlwi8oP9uySZYUMtGL8clo1xhIJ9/PNjpaUbTAyLK6mHhtzHmcMQZG0CPUD/PvgU2DMyYb0J4QWVW+YPfW3j7XwFbZh5n+7/Z266V7Tm0k04U/XrPThZG9gmh23cLeq2hXzA5hwwKD4+uh7relff8SUDeq6y6rQx8QXSMM/4nof4IT+E/SF2Lz0AHn7/aJqeC+0fMDN49CQwfFnJokKLebotPL+uWyTUKK36x4dykp8C/wJbdeJhKeKKX4DuGpKx763jHIPB1rVWpk5YBESUGHvd8qhm2LN3eLB5ahsXx8AYquji8FQiD+EuzdSI/HvxBqsVes6XT7BAQaxOFzWrdWXmBxDkDcepRa1QJTJnlwsApUBu4ukaEaI8LKbUhYh05ixwREAlhWw1xtr7ExVRwGxXSUKkM5uL556/sONcVRb3bm0VgPp3r07QtSRLvufsQe8brdfTKyvRQKl7kY1clku24MGMhO6tF+ftg+I9/wrKQuhIr8uFnLzLcrXceqXLP4OikqilprnodZYzpEr2TxrQaJ5lRkabhqz9B+ooicSMnYyxzpDdjenkArHVTVFpVevPP8QUf/8bD7iwlwGjbcNSI+8Z4yZoiwE7Dv9zruAn0fEDTWHbyi7OtNv/ppzQ9wiuUuBWfQF82PMBwb0OUvSFj/Ys+RaY9/zcrfVRhs+JuNUJYTxZ6TxRUAn7BciCNWsuoriung==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(498600001)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XRMjLIUm/JnBzXhBJAZWTR4KwQcWjTg669o40jcgwSHx0Db/ruB8EMxQQcQk?=
 =?us-ascii?Q?F5uBxNvkBWFKHZoqTu91dN/wnzK62joavGwor1yRjA/eOJt+Dk00YoWy2uio?=
 =?us-ascii?Q?pcpBD2AHDRZL7I1TL3biYKbdzTJcvIsfrbiza0gSrz+tBZ9wAa0P2KsnO4b+?=
 =?us-ascii?Q?3clk8c8/bEorxr79Aduvndubys2FMbvF2MY2YlDeIUcO7M5jCNZ7jSqVwSf7?=
 =?us-ascii?Q?nx/qoPnyU2csEDwpZXsWkMhiUc0FaK7y0Es4oGjXzx+hOpQAgza6k0A/KxAr?=
 =?us-ascii?Q?YnNDlni9nk4sU32TmHtJZWusbzwei19WTY4FtmU8SAwQXZbNdkbSeXOtcuoD?=
 =?us-ascii?Q?EIOlFQ+FHNORPW82UKRP1Q5LhjQkO3ywW4wN4NHFFeELVLFqUwN3GtQ7Zb0C?=
 =?us-ascii?Q?DbANIdwPYOZ+N0rEaHdWnm8jMV5Eg5w3RbMLQjfbAIMBF1MnM4ME0KkA1ow2?=
 =?us-ascii?Q?3h252m4WU6md8LbV+ZCUM8bQKlTVIHDx6gmsU1o/zoj5f11iNiXCRGTNLpuh?=
 =?us-ascii?Q?cJLIlfFA08VvTrbqaZb6kGH3x6lou6IQzyu8hqIuajNw97OeeyOsj5GgqHuq?=
 =?us-ascii?Q?zsykGiWH5qJ8BUK2uXgnzsR6YK3dYyMwIBY/N3GUapshhUO+p9QlLKpepFAO?=
 =?us-ascii?Q?ppa5OWfz1aMODod/yi93Qe+zkL2VW7HQoTTqGNrC3rT16303CtF9vub02zq6?=
 =?us-ascii?Q?43rBsitDkfRe3khV1HhYUoGLXyJkyswDcZSboCYBQO09gMLAYck2xhqHYk7z?=
 =?us-ascii?Q?2RWw13sQKgEPDe+pjAE7QysDXCCWBaPUuzfX5pEzdW1zjoKAraMr+73gnc67?=
 =?us-ascii?Q?nV5b5SASFwOQUoY5Ie/aeKgMjt2wnmgVs6pCojZz97xUaZrBLnQaSixOFxTd?=
 =?us-ascii?Q?ev5EEM2R87k8RmEy0trW5S6ZB/vTBGKFZSy4eLlBPchzwd89xeheA0tv++UF?=
 =?us-ascii?Q?HYcVmXgwQjti2UszRqYRHEs+o1QDkmKWzWXaN04po5z76TohKmh1WOfkWlhh?=
 =?us-ascii?Q?TZ7wL0FCxwcjuP4psVllv4lE8EFP8QrHCd4beSJcSFscn5pYHcTsCw7WwwUr?=
 =?us-ascii?Q?wT2v3eUfLCAM34xY01PCWFM8Y9Cr32CkpMdyFHfhqz3dcxZMYFJP/i04CQey?=
 =?us-ascii?Q?M1Z0lf+76+qR8I5cEXfROVPxGKFYHpxR2jFGuUYY2WHxxJfG0TUUjoRxRYee?=
 =?us-ascii?Q?CJXBYUdEK54p0y4nZGKYc751Ky86UY/tQoiX09XEiG6zXtsDwy3/D24NhgRR?=
 =?us-ascii?Q?XWCutDPd3hEHKPzse3UPDVSIGeFkgkgqpm/gps4PXxOjexPPTBE9KDvVxYyT?=
 =?us-ascii?Q?D6rxgcywo/KeUTYvmIRtb3R5?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93760ba-c997-4718-36b1-08d931a9b69b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:23.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZnC8UAQhsJ7RY5IVzGztAZ5Kf8r+4wpVQ1XWghTd7EuvRElxxqKgeNvQXY3Kmirk2TT0fsOxHDbgMt9NmYUEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/reg/reg_ipc.h    | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_ipc.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_ipc.h b/drivers/net/w=
ireless/celeno/cl8k/reg/reg_ipc.h
new file mode 100644
index 000000000000..d825b8559aae
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_ipc.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_IPC_H
+#define CL_REG_IPC_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "chip.h"
+
+#define REG_IPC_BASE_ADDR 0x007C4000
+
+/*
+ * @brief XMAC_2_HOST_RAW_STATUS register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 xmac2host_raw_status      0x0
+ * </pre>
+ */
+#define IPC_XMAC_2_HOST_RAW_STATUS_ADDR        (REG_IPC_BASE_ADDR + 0x0000=
0004)
+#define IPC_XMAC_2_HOST_RAW_STATUS_OFFSET      0x00000004
+#define IPC_XMAC_2_HOST_RAW_STATUS_INDEX       0x00000001
+#define IPC_XMAC_2_HOST_RAW_STATUS_RESET       0x00000000
+
+static inline u32 ipc_xmac_2_host_raw_status_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, IPC_XMAC_2_HOST_RAW_STATUS_ADDR);
+}
+
+/*
+ * @brief XMAC_2_HOST_ACK register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 xmac2host_trigger_clr     0x0
+ * </pre>
+ */
+#define IPC_XMAC_2_HOST_ACK_ADDR        (REG_IPC_BASE_ADDR + 0x00000008)
+#define IPC_XMAC_2_HOST_ACK_OFFSET      0x00000008
+#define IPC_XMAC_2_HOST_ACK_INDEX       0x00000002
+#define IPC_XMAC_2_HOST_ACK_RESET       0x00000000
+
+static inline void ipc_xmac_2_host_ack_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IPC_XMAC_2_HOST_ACK_ADDR, value);
+}
+
+/*
+ * @brief XMAC_2_HOST_ENABLE_SET register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 xmac2host_enable_set      0x0
+ * </pre>
+ */
+#define IPC_XMAC_2_HOST_ENABLE_SET_ADDR        (REG_IPC_BASE_ADDR + 0x0000=
000C)
+#define IPC_XMAC_2_HOST_ENABLE_SET_OFFSET      0x0000000C
+#define IPC_XMAC_2_HOST_ENABLE_SET_INDEX       0x00000003
+#define IPC_XMAC_2_HOST_ENABLE_SET_RESET       0x00000000
+
+static inline void ipc_xmac_2_host_enable_set_set(struct cl_chip *chip, u3=
2 value)
+{
+       cl_reg_write_chip(chip, IPC_XMAC_2_HOST_ENABLE_SET_ADDR, value);
+}
+
+/*
+ * @brief XMAC_2_HOST_ENABLE_CLEAR register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 xmac2host_enable_clear    0x0
+ * </pre>
+ */
+#define IPC_XMAC_2_HOST_ENABLE_CLEAR_ADDR        (REG_IPC_BASE_ADDR + 0x00=
000010)
+#define IPC_XMAC_2_HOST_ENABLE_CLEAR_OFFSET      0x00000010
+#define IPC_XMAC_2_HOST_ENABLE_CLEAR_INDEX       0x00000004
+#define IPC_XMAC_2_HOST_ENABLE_CLEAR_RESET       0x00000000
+
+static inline void ipc_xmac_2_host_enable_clear_set(struct cl_chip *chip, =
u32 value)
+{
+       cl_reg_write_chip(chip, IPC_XMAC_2_HOST_ENABLE_CLEAR_ADDR, value);
+}
+
+/*
+ * @brief XMAC_2_HOST_STATUS register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 xmac2host_status          0x0
+ * </pre>
+ */
+#define IPC_XMAC_2_HOST_STATUS_ADDR        (REG_IPC_BASE_ADDR + 0x00000014=
)
+#define IPC_XMAC_2_HOST_STATUS_OFFSET      0x00000014
+#define IPC_XMAC_2_HOST_STATUS_INDEX       0x00000005
+#define IPC_XMAC_2_HOST_STATUS_RESET       0x00000000
+
+static inline u32 ipc_xmac_2_host_status_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, IPC_XMAC_2_HOST_STATUS_ADDR);
+}
+
+/*
+ * @brief HOST_GLOBAL_INT_EN register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    master_int_enable         0
+ * </pre>
+ */
+#define IPC_HOST_GLOBAL_INT_EN_ADDR        (REG_IPC_BASE_ADDR + 0x00000030=
)
+#define IPC_HOST_GLOBAL_INT_EN_OFFSET      0x00000030
+#define IPC_HOST_GLOBAL_INT_EN_INDEX       0x0000000C
+#define IPC_HOST_GLOBAL_INT_EN_RESET       0x00000000
+
+static inline void ipc_host_global_int_en_set(struct cl_chip *chip, u32 va=
lue)
+{
+       cl_reg_write_chip(chip, IPC_HOST_GLOBAL_INT_EN_ADDR, value);
+}
+
+/*
+ * @brief HOST_2_LMAC_TRIGGER register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 host2lmac_trigger         0x0
+ * </pre>
+ */
+#define IPC_HOST_2_LMAC_TRIGGER_ADDR        (REG_IPC_BASE_ADDR + 0x0000008=
0)
+#define IPC_HOST_2_LMAC_TRIGGER_OFFSET      0x00000080
+#define IPC_HOST_2_LMAC_TRIGGER_INDEX       0x00000020
+#define IPC_HOST_2_LMAC_TRIGGER_RESET       0x00000000
+
+static inline void ipc_host_2_lmac_trigger_set(struct cl_chip *chip, u32 v=
alue)
+{
+       cl_reg_write_chip(chip, IPC_HOST_2_LMAC_TRIGGER_ADDR, value);
+}
+
+/*
+ * @brief HOST_2_SMAC_TRIGGER register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 host2smac_trigger         0x0
+ * </pre>
+ */
+#define IPC_HOST_2_SMAC_TRIGGER_ADDR        (REG_IPC_BASE_ADDR + 0x0000008=
8)
+#define IPC_HOST_2_SMAC_TRIGGER_OFFSET      0x00000088
+#define IPC_HOST_2_SMAC_TRIGGER_INDEX       0x00000022
+#define IPC_HOST_2_SMAC_TRIGGER_RESET       0x00000000
+
+static inline void ipc_host_2_smac_trigger_set(struct cl_chip *chip, u32 v=
alue)
+{
+       cl_reg_write_chip(chip, IPC_HOST_2_SMAC_TRIGGER_ADDR, value);
+}
+
+#endif /* CL_REG_IPC_H */
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

