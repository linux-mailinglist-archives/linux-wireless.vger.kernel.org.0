Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAD03AB835
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhFQQFh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:37 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233599AbhFQQFX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGEfNT6kqpIy5kGLtei6mzmOmnmkGnIHk+WZyuSiTAW2xXplLo7nNWUczOUV0ESxUmE0QlsF0E6tn1uosoz8lnHspdKHKn6SRG5e1pwt17bqCO552m2ZbQbAaHbhXs58a/Yo4AIAVuME7nugyaxoavFhfxHUbYG774R3V5pDhPfvQot6hDdTj/zI4eY4AU0E/dBa2L6E3ZO2Nk/Ib7z/BAy4jLqZpFqiPoXVdcfbfGD6q9fuZKf0WfXR6H7fcZhrEpD6XZA4gODzUR8mUCEM4/binEiLV2pRfAe3rQsqPe416+Sheefq+i/sfJzN+Q7sqXFtajQXxviUe9eVX+rRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBX7/mdnrXKJy+EeZl9zTSBlAxgXS1O1usTZBLzowzg=;
 b=KiKMAJZovQWZV6H5mNqdbuh8SkTE4JPn6Kfy10/g7mahHrqb5QmCXTuxobivW5J6ehdTGP7H5eilxbYh0uPfVIo8XqBQn120mfzqZwLpy8R5HkDyXwme+Xkp1VWYWYHh6bNq9Kg5hZ3trupSP8eTUJQrbclLXOXaNbRtjhUuIHvaNLZo041UDCNJ8tTyB/w08SQDrjPZyQS9BtG0h4+MkEQ9sMAbHSzy76usIjH5vX/uRCF4f35ez1J6GWTXrDsE8yRpv8DtbVyBND2ALoNhRU55NRDJlkyND+FHdtb3MdNMTNlIR5bdjroR4edS5vuyOYWwB8gqSkjEas/t97Pjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBX7/mdnrXKJy+EeZl9zTSBlAxgXS1O1usTZBLzowzg=;
 b=yuRCDktoVd6dli8LUpHvwneYFF3wL8oSqS7mJQLNzfIvdPMDbTCUq4eYAsThX68tya8OGgxM1nXb3OBN6BxfpzW7P50meKl21xdTPczGS51RffZUzTQV9PRQY67N+U0LK7uxjXjcotLZ+uHs5zwkGasVBi+yQwGmPuneuZ+RxhA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:05 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:05 +0000
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
Subject: [RFC v1 028/256] cl8k: add calib.c
Date:   Thu, 17 Jun 2021 15:58:35 +0000
Message-Id: <20210617160223.160998-29-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78e47537-56f8-4055-c322-08d931a963e1
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499E9AEAD6518C62F89C1EDF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57Xik0t4sBCMAaMUwurwupzZ3yzPBjAZQGPfKVWD/FdaEW0D8fSbCnCF+wOC+sfTEONXknGFbSqpyrG4Et5Zgy1wKDL2iJXKfwjTsDZPDBMpJ36GFS4itbxV9/JGGUA+ztu1pKk+VOcgu//Ft0yfubOknEKrjQUzGjNgISTcqiQZvpYllP5ntdXeSjcKV5YcD4pBZcskDLnCZQ+3phPD7uzD0cLg2uOjZeCvmF5qnMNeER5W0No9fCMHLWMcz+WEWc258PUccugFXHptO56mjWS0T9tm588NJLuQEkeI47ewQ6TKbGUTAfoSzZiFCerb5got/EXvoBGL4poLZaZt4CIZl3EqdvT+anVMVknkVkBL69cIsOQhYWruWuBlIpwgR7AC5V4pO783CI9rfaZeeQc/46Mg5++yNU1MFN3RWD8Uu9rskQ/okGnRcP4SqQ3FZhiCoDpJNQ5ctPL023USdkdp48dKubRQRsefPw2dp8GnNUa9VsO7ja/jdpwGauRbUcnVdtS0X8Kb6ZOUmN+9/BsgszxXglEHdeOvZLLp5md4kxG24COognqKKINjGVSKcqE3resVeO4QrWf4dXiv650QuYS4IIab7xISx9gEknT5NxH4/YW+w28CYxE+l/FVuYxgGprbrEzzatl7cJ80Ab55LADm+HAVUad5cbM0EBCA/rDfC5AsLedHBLZPUMzaRg4eLK4VgT7fgmc67y/2x8MF1Xekk0DyYIlhKnRFeIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(30864003)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001)(559001)(579004)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HRW3zIoOgaWIUhLKIlyK1jROz/zLTVs6BCdHgb+Y+DF4E/4kaZnXudC1KD1P?=
 =?us-ascii?Q?X2eHeA6tR1fHypp6FPShq6PhlyCN/YCerC1VxLV7SVYbnZAarIUGwUq5sLW9?=
 =?us-ascii?Q?M+aw2DNBjhrjkY8tt5kXdDR+WpaECEZVi8Tm7RR6opHLGKS9dk/v9ZPcDypX?=
 =?us-ascii?Q?3SwNzp6C01ox5qfOCCvv2R+1Pmw2E3R6REZgZtuKs8lFW+s+tRGvmcgJPGhE?=
 =?us-ascii?Q?UoLcPUwxCIqQPTCtRu1aakyaGqAD/rXG0mMw9uQM7KBeIKmv1nVLOMQlSq60?=
 =?us-ascii?Q?nh76IFfmcxP+F9t7cqA1qEJDEcbVSrdZpGmx3SuDcJs8YgHtqngk98F79RBl?=
 =?us-ascii?Q?9/s+Px1Snejt55KMjBtDMAVWVO7lOPnB0V4/S6seFfQZVJ9SVVgvulRVw6NK?=
 =?us-ascii?Q?0T3TK41aqPKY9CC+BoF/jZikuT3vXDdvJezaspbaEFzpslmg3OTb5WHVAMtF?=
 =?us-ascii?Q?AWKpaUyb7i/3UHotdlI2T4gubrtNxFkUX+0kr5cTtGciGbe8Mo2YLvCPpZ5C?=
 =?us-ascii?Q?iqifKqV4y3AABpZBMqzpmE9Olkj9wc/PtswMg0UcENCXhFAtEmc1o1LXaFEh?=
 =?us-ascii?Q?C7OwcAYwUuid06rFMJQryaMwFyAcHBz2kSzEn5awEV2cbBRJGTn+nbrP5bkv?=
 =?us-ascii?Q?tlWBXV2IEO61Ii6Z7HV7AbQ/tWiXCPdHAlP57XrUaxut0cHIGDo6zQ9pI4Sp?=
 =?us-ascii?Q?nnXhr9vCv5DRMrvjZxRsd2oWjoH45E/z8g5fKQghSu5M10PBqFZYW4X5rkkP?=
 =?us-ascii?Q?hVArvfMXWiPCZF/LR0hbjveLD/l7JQP+BJ2tkuvhn4qux2tBKOJL/zZ+/IZY?=
 =?us-ascii?Q?Ug/VbkgRNRIVZ1To3h4iJuLrzzFF46gr4XjCXToH+Sin3sw4XyABpIp+3PMH?=
 =?us-ascii?Q?cydYsWOa9nrybDIO17UCe9ZCyzLeoVlPZG5N/cw+azN5+zDcObRN8FOwa10b?=
 =?us-ascii?Q?7KcmhPuo4viwZSjKfrGVYgyuJGja+NAppY65GLFK5/kFK1B6r/dYd4UxSzpg?=
 =?us-ascii?Q?283G1UD69kXYJNpabvR7llLHYUz8wTsZ0R0SByp7HrnC8+Eq44eCIg/T4zcv?=
 =?us-ascii?Q?wLag5YIZt2CV4Yzp/TGFVoVettMzkEVFkDfL52en2doK39BhcJ269Bp3ELSj?=
 =?us-ascii?Q?ax5JK9LOSsG+lcl6gYKhcujT1nQTioQAvw/Bqh501sb3vgO7YTAZIVP6w4LX?=
 =?us-ascii?Q?fnh9rgisQDL072MRdWlhVMqnsoHmH4aCiCZYST73ZI89sB9FQ1yTEisUSlLw?=
 =?us-ascii?Q?QvVc6w2HLQzGzmul+dznebOz+8LaFvvncK/nODsxvU2gtg7SYmuw7HgfwRhk?=
 =?us-ascii?Q?huIPBVdge5aknI68HLTt8Lmc?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e47537-56f8-4055-c322-08d931a963e1
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:04.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QmZ/D2zFQivifdTvk0YnZV/Bnco3enx2jLVT5vh8p3lBiMdztsI0yxOVtf+SJm09y3aw0AsB0BQAkE7Mu/8sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/calib.c | 1682 ++++++++++++++++++++++
 1 file changed, 1682 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/calib.c

diff --git a/drivers/net/wireless/celeno/cl8k/calib.c b/drivers/net/wireles=
s/celeno/cl8k/calib.c
new file mode 100644
index 000000000000..8861964e3aff
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/calib.c
@@ -0,0 +1,1682 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/string.h>
+#include <linux/bitops.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/buffer_head.h>
+
+#include "calib.h"
+#include "temperature.h"
+#include "utils/utils.h"
+#include "chip.h"
+#include "chandef.h"
+#include "fw/msg_cfm.h"
+#include "fw/msg_tx.h"
+#include "band.h"
+#include "e2p.h"
+#include "channel.h"
+#include "power.h"
+#include "afe.h"
+#include "radio.h"
+
+/*
+ * CL80x0: TCV0 - 5g, TCV1 - 24g
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * 50  48  46  44  42  40  38  36  --> Start 5g
+ * 100 64  62  60  58  56  54  52
+ * 116 114 112 110 108 106 104 102
+ * 134 132 128 126 124 122 120 118
+ * 153 151 149 144 142 140 138 136
+ * 3   2   1   165 161 159 157 155  --> Start 24g
+ * 11  10  9   8   7   6   5   4
+ *                     14  13  12
+ */
+
+/*
+ * CL80x6: TCV0 - 6g, TCV1 - 5g
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * 25  21  17  13  9   5   2   1   --> Start 6g
+ * 57  53  49  45  41  37  33  29
+ * 89  85  81  77  73  69  65  61
+ * 121 117 113 109 105 101 97  93
+ * 153 147 143 139 135 131 127 123
+ * 185 181 177 173 169 165 161 157
+ * 217 213 209 205 201 197 193 189
+ * 42  40  38  36  233 229 225 221 --> Start 5g
+ * 58  56  54  52  50  48  46  44
+ * 108 106 104 102 100 64  62  60
+ * 124 122 120 118 116 114 112 110
+ * 142 140 138 136 134 132 128 126
+ * 161 159 157 155 153 151 149 144
+ *                             165
+ */
+
+#define BITMAP_80X0_START_TCV0  0
+#define BITMAP_80X0_MAX_TCV0    NUM_CHANNELS_5G
+
+#define BITMAP_80X0_START_TCV1 NUM_CHANNELS_5G
+#define BITMAP_80X0_MAX_TCV1   (NUM_CHANNELS_5G + NUM_CHANNELS_24G)
+
+#define BITMAP_80X6_START_TCV0  0
+#define BITMAP_80X6_MAX_TCV0    NUM_CHANNELS_6G
+
+#define BITMAP_80X6_START_TCV1  NUM_CHANNELS_6G
+#define BITMAP_80X6_MAX_TCV1    (NUM_CHANNELS_6G + NUM_CHANNELS_5G)
+
+#define INVALID_ADDR 0xffff
+
+#define S12_S_BIT (0x00000800)
+#define U12_BIT_MASK (0x00000FFF)
+#define CAST_S12_TO_S32(i) ((~(i) & S12_S_BIT) ? (i) : ((i) | ~U12_BIT_MAS=
K))
+
+static const u8 calib_channels_24g[CALIB_CHAN_24G_MAX] =3D {
+       1, 6, 11
+};
+
+static const u8 calib_channels_5g[CALIB_CHAN_5G_MAX] =3D {
+       36, 52, 100, 116, 132, 149
+};
+
+static const u8 calib_channels_6g[CALIB_CHAN_6G_MAX] =3D {
+       1, 17, 33, 49, 65, 81, 97, 113, 129, 145, 161, 177, 193, 209, 225
+};
+
+static u8 tone_vector_arr[CHNL_BW_MAX][IQ_NUM_TONES_REQ] =3D {
+       {6, 10, 14, 18, 22, 24, 26, 27},
+       {10, 18, 26, 34, 41, 48, 53, 58},
+       {18, 34, 50, 66, 82, 98, 110, 122},
+       {18, 34, 66, 98, 130, 164, 224, 250}
+};
+
+static u8 get_bitmap_start_tcv1(struct cl_chip *chip)
+{
+       if (cl_chip_is_6g(chip))
+               return BITMAP_80X6_START_TCV1;
+       else
+               return BITMAP_80X0_START_TCV1;
+}
+
+static void get_bitmap_boundaries(struct cl_chip *chip, u8 tcv_idx, u8 *st=
art, u8 *max)
+{
+       if (cl_chip_is_6g(chip)) {
+               if (tcv_idx =3D=3D TCV0) {
+                       *start =3D BITMAP_80X6_START_TCV0;
+                       *max =3D BITMAP_80X6_MAX_TCV0;
+               } else {
+                       *start =3D BITMAP_80X6_START_TCV1;
+                       *max =3D BITMAP_80X6_MAX_TCV1;
+               }
+       } else {
+               if (tcv_idx =3D=3D TCV0) {
+                       *start =3D BITMAP_80X0_START_TCV0;
+                       *max =3D BITMAP_80X0_MAX_TCV0;
+               } else {
+                       *start =3D BITMAP_80X0_START_TCV1;
+                       *max =3D BITMAP_80X0_MAX_TCV1;
+               }
+       }
+}
+
+static u8 idx_to_arr_offset(u8 idx)
+{
+       /* Divide by 8 for array index */
+       return idx >> 3;
+}
+
+static u8 idx_to_bit_offset(u8 idx)
+{
+       /* Reminder is for bit index (assummed array of u8) */
+       return idx & 0x07;
+}
+
+static const u8 bits_cnt_table256[] =3D {
+       0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,
+       1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+       1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+       2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+       1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+       2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+       2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+       3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+       1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+       2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+       2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+       3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+       2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+       3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+       3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+       4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8
+};
+
+static u8 count_bits(const u8 *bitmap)
+{
+       /*
+        * Count bits in a given u8 array ASSUMED ARRAY SIZE IS BIT_MAP_SIZ=
E
+        * bitmap - pointer to u8 array (bitmap)
+        */
+       u8 i =3D 0, cnt =3D 0;
+
+       for (i =3D 0; i < BIT_MAP_SIZE; i++)
+               cnt +=3D bits_cnt_table256[bitmap[i]];
+
+       return cnt;
+}
+
+static bool is_vector_unset(const u8 *bitmap)
+{
+       /* Check bitmap is unset i.e. all values are CURR_BMP_UNSET */
+       u8 empty_bitmap[BIT_MAP_SIZE] =3D {0};
+
+       return !memcmp(bitmap, empty_bitmap, BIT_MAP_SIZE);
+}
+
+static bool bitmap_test_bit_idx(const u8 *bitmap, u8 idx)
+{
+       /* Check bit at a given index is set i.e. 1 */
+       u8 arr_idx =3D idx_to_arr_offset(idx), bit_idx =3D idx_to_bit_offse=
t(idx);
+
+       if (arr_idx >=3D BIT_MAP_SIZE)
+               return false;
+
+       /* Convert non-zero to true and zero to false */
+       return !!(bitmap[arr_idx] & BIT(bit_idx));
+}
+
+static void bitmap_shift(u8 *bitmap, u8 shft)
+{
+       /* Shifts an array of byte of size len by shft number of bits to th=
e left */
+       u8 bitmap_tmp[BIT_MAP_SIZE] =3D {0};
+       u8 msb_shifts =3D shft % 8;
+       u8 lsb_shifts =3D 8 - msb_shifts;
+       u8 byte_shift =3D shft / 8;
+       u8 last_byte =3D BIT_MAP_SIZE - byte_shift - 1;
+       u8 msb_idx;
+       u8 i;
+
+       memcpy(bitmap_tmp, bitmap, BIT_MAP_SIZE);
+       memset(bitmap, 0, BIT_MAP_SIZE);
+
+       for (i =3D 0;  i < BIT_MAP_SIZE; i++) {
+               if (i <=3D last_byte) {
+                       msb_idx =3D i + byte_shift;
+                       bitmap[i] =3D bitmap_tmp[msb_idx] >> msb_shifts;
+                       if (i !=3D last_byte)
+                               bitmap[i] |=3D bitmap_tmp[msb_idx + 1] << l=
sb_shifts;
+               }
+       }
+}
+
+static bool bitmap_set_bit_idx(struct cl_hw *cl_hw, u8 *bitmap, u8 idx)
+{
+       /* Set bit at a given index */
+       u8 arr_idx =3D idx_to_arr_offset(idx), bit_idx =3D idx_to_bit_offse=
t(idx);
+
+       if (arr_idx >=3D BIT_MAP_SIZE) {
+               cl_dbg_err(cl_hw, "invalid arr_idx (%u)\n", arr_idx);
+               return false;
+       }
+
+       bitmap[arr_idx] |=3D BIT(bit_idx);
+       return true;
+}
+
+static bool bitmap_clear_bit_idx(struct cl_hw *cl_hw, u8 *bitmap, u8 idx)
+{
+       /* Clear bit at a given index */
+       u8 arr_idx =3D idx_to_arr_offset(idx), bit_idx =3D idx_to_bit_offse=
t(idx);
+
+       if (arr_idx >=3D BIT_MAP_SIZE) {
+               cl_dbg_err(cl_hw, "invalid arr_idx (%u)\n", arr_idx);
+               return false;
+       }
+
+       bitmap[arr_idx] &=3D ~BIT(bit_idx);
+       return true;
+}
+
+static u16 bitmap_look_lsb_up(struct cl_hw *cl_hw, u8 *bitmap, u16 idx)
+{
+       /* Find closest ON(1) bit with index haigher than idx inside bitmap=
 */
+       u16 curr_idx =3D idx;
+       u8 curr =3D 0;
+
+       while (++curr_idx < cl_channel_num(cl_hw)) {
+               curr =3D bitmap[idx_to_arr_offset(curr_idx)];
+               if (curr & (1ULL << idx_to_bit_offset(curr_idx)))
+                       return curr_idx;
+       }
+
+       /* No matching bit found - return original index */
+       return idx;
+}
+
+static u16 bitmap_look_msb_down(struct cl_hw *cl_hw, u8 *bitmap, u16 idx)
+{
+       /* Find closest ON(1) bit with index lower than idx inside bitmap *=
/
+       u16 curr_idx =3D idx;
+       u8 curr =3D 0;
+
+       if (idx >=3D cl_channel_num(cl_hw)) {
+               cl_dbg_err(cl_hw, "Invalid channel index [%u]\n", idx);
+               return idx;
+       }
+
+       while (curr_idx-- !=3D 0) {
+               curr =3D bitmap[idx_to_arr_offset(curr_idx)];
+               if (curr & (1ULL << idx_to_bit_offset(curr_idx)))
+                       return curr_idx;
+       }
+
+       /* No matching bit found - return original index */
+       return idx;
+}
+
+static u8 address_offset_tcv1(struct cl_hw *cl_hw)
+{
+       /* Calculate eeprom calibration data offset for tcv1 */
+       struct cl_chip *chip =3D cl_hw->chip;
+       u8 i, cnt =3D 0;
+       u8 bitmap[BIT_MAP_SIZE] =3D {0};
+
+       if (cl_e2p_read(chip, bitmap, BIT_MAP_SIZE, ADDR_CALIB_CHAN_BMP))
+               return 0;
+
+       for (i =3D 0; i < get_bitmap_start_tcv1(chip); i++)
+               cnt +=3D bitmap_test_bit_idx(bitmap, i);
+
+       return cnt;
+}
+
+static int point_idx_to_address(struct cl_hw *cl_hw, u8 *bitmap, struct po=
int *pt)
+{
+       /* Calculate eeprom address for a given idx and phy (initiated poin=
t) */
+       u8 i, cnt =3D 0;
+
+       pt->addr =3D INVALID_ADDR;
+
+       if (!bitmap_test_bit_idx(bitmap, pt->idx))
+               return 0;
+
+       if (pt->phy >=3D MAX_ANTENNAS) {
+               cl_dbg_err(cl_hw, "Invalid phy number %u", pt->phy);
+               return -EINVAL;
+       }
+
+       for (i =3D 0; i < pt->idx; i++)
+               cnt +=3D bitmap_test_bit_idx(bitmap, i);
+
+       if (cl_hw_is_tcv1(cl_hw))
+               cnt +=3D address_offset_tcv1(cl_hw);
+
+       pt->addr =3D ADDR_CALIB_PHY +
+               sizeof(struct eeprom_phy_calib) * (cnt * MAX_ANTENNAS + pt-=
>phy);
+
+       return 0;
+}
+
+static bool linear_equation_signed(struct cl_hw *cl_hw, const u16 x, s8 *y=
,
+                                  const u16 x0, const s8 y0, const u16 x1,=
 const s8 y1)
+{
+       /* Calculate y given to points (x0,y0) and (x1,y1) and x */
+       s32 numerator =3D (x - x0) * (y1 - y0);
+       s32 denominator =3D x1 - x0;
+
+       if (unlikely(!denominator)) {
+               cl_dbg_err(cl_hw, "zero denominator\n");
+               return false;
+       }
+
+       *y =3D (s8)(y0 + DIV_ROUND_CLOSEST(numerator, denominator));
+
+       return true;
+}
+
+static bool calculate_calib(struct cl_hw *cl_hw, u8 *bitmap,
+                           struct point *p0, struct point *p1, struct poin=
t *p2)
+{
+       /* Main interpolation/extrapolation function */
+       bool calc_succsess =3D false;
+       u16 freq0, freq1, freq2;
+
+       if (unlikely(is_vector_unset(bitmap)))
+               return false;
+
+       p1->idx =3D bitmap_look_lsb_up(cl_hw, bitmap, p0->idx);
+       p2->idx =3D bitmap_look_msb_down(cl_hw, bitmap, p0->idx);
+
+       /* Invalid case */
+       if (p1->idx =3D=3D p0->idx && p2->idx =3D=3D p0->idx) {
+               cl_dbg_err(cl_hw, "Invalid index %u or bad bit map\n", p0->=
idx);
+               return false;
+       }
+
+       /* Extrapolation case */
+       if (p1->idx =3D=3D p0->idx)
+               p1->idx =3D bitmap_look_msb_down(cl_hw, bitmap, p2->idx);
+       if (p2->idx =3D=3D p0->idx)
+               p2->idx =3D bitmap_look_lsb_up(cl_hw, bitmap, p1->idx);
+
+       /* Address from index */
+       if (point_idx_to_address(cl_hw, bitmap, p1) || p1->addr =3D=3D INVA=
LID_ADDR) {
+               cl_dbg_err(cl_hw, "Point calculation failed\n");
+               return false;
+       }
+
+       if (point_idx_to_address(cl_hw, bitmap, p2) || p2->addr =3D=3D INVA=
LID_ADDR) {
+               cl_dbg_err(cl_hw, "Point calculation failed\n");
+               return false;
+       }
+
+       /* Read from eeprom */
+       if (cl_e2p_read(cl_hw->chip, (u8 *)&p1->calib, sizeof(struct eeprom=
_phy_calib), p1->addr))
+               return false;
+
+       /* No interpolation required */
+       if (p1->addr =3D=3D p2->addr) {
+               p0->calib =3D p1->calib;
+               return true;
+       }
+
+       /* Interpolation or extrapolation is required - read from eeprom */
+       if (cl_e2p_read(cl_hw->chip, (u8 *)&p2->calib, sizeof(struct eeprom=
_phy_calib), p2->addr))
+               return false;
+
+       freq0 =3D cl_channel_idx_to_freq(cl_hw, p0->idx);
+       freq1 =3D cl_channel_idx_to_freq(cl_hw, p1->idx);
+       freq2 =3D cl_channel_idx_to_freq(cl_hw, p2->idx);
+
+       /* Interpolate/extrapolate target power */
+       calc_succsess =3D linear_equation_signed(cl_hw,
+                                              freq0, &p0->calib.pow,
+                                              freq1, p1->calib.pow,
+                                              freq2, p2->calib.pow);
+
+       /* Interpolate/extrapolate power offset */
+       calc_succsess =3D calc_succsess && linear_equation_signed(cl_hw,
+                                                               freq0, &p0-=
>calib.offset,
+                                                               freq1, p1->=
calib.offset,
+                                                               freq2, p2->=
calib.offset);
+
+       /* Interpolate/extrapolate calibration temperature */
+       calc_succsess =3D calc_succsess && linear_equation_signed(cl_hw,
+                                                               freq0, &p0-=
>calib.tmp,
+                                                               freq1, p1->=
calib.tmp,
+                                                               freq2, p2->=
calib.tmp);
+
+       if (unlikely(!calc_succsess)) {
+               cl_dbg_err(cl_hw,
+                          "Calc failed: freq0 %u idx0 %u, freq1 %u idx1 %u=
, freq2 %u idx2 %u\n",
+                          freq0, p0->idx, freq1, p1->idx, freq2, p2->idx);
+               return false;
+       }
+
+       return true;
+}
+
+static int read_validate_vector_bitmap(struct cl_hw *cl_hw, u8 *bitmap)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       if (cl_e2p_read(chip, bitmap, BIT_MAP_SIZE, ADDR_CALIB_CHAN_BMP))
+               return -1;
+
+       /* Test if e2p was read succsefull since it is not ALL EMPTY */
+       if (is_vector_unset(bitmap)) {
+               cl_dbg_err(cl_hw, "Vector not ready\n");
+               return -EPERM;
+       }
+
+       if (cl_hw_is_tcv1(cl_hw)) {
+               u8 bitmap_start =3D get_bitmap_start_tcv1(chip);
+
+               bitmap_shift(bitmap, bitmap_start);
+       }
+
+       return 0;
+}
+
+static int e2p_prepare(struct cl_hw *cl_hw, struct point *data, u8 *bitmap=
)
+{
+       int ret =3D read_validate_vector_bitmap(cl_hw, bitmap);
+
+       if (ret) {
+               cl_dbg_err(cl_hw, "read_validate_vector_bitmap failed\n");
+               return ret;
+       }
+
+       data->idx =3D cl_channel_to_index(cl_hw, data->chan);
+
+       return point_idx_to_address(cl_hw, bitmap, data);
+}
+
+static int read_or_interpolate_point(struct cl_hw *cl_hw, u8 *bitmap, stru=
ct point *p0)
+{
+       struct point p1 =3D {.phy =3D p0->phy};
+       struct point p2 =3D {.phy =3D p0->phy};
+       struct point tmp_pt =3D *p0;
+
+       /* Invalid address =3D no physical address was allocated to this ch=
annel */
+       if (tmp_pt.addr !=3D INVALID_ADDR) {
+               if (cl_e2p_read(cl_hw->chip, (u8 *)&tmp_pt.calib,
+                               sizeof(struct eeprom_phy_calib), tmp_pt.add=
r))
+                       return -1;
+       } else {
+               /* Interpolate */
+               if (!calculate_calib(cl_hw, bitmap, &tmp_pt, &p1, &p2)) {
+                       cl_dbg_err(cl_hw, "Interpolation Error\n");
+                       return -EFAULT;
+               }
+       }
+
+       if (tmp_pt.calib.pow =3D=3D 0 && tmp_pt.calib.offset =3D=3D 0 && tm=
p_pt.calib.tmp =3D=3D 0) {
+               u16 freq =3D cl_channel_idx_to_freq(cl_hw, tmp_pt.idx);
+
+               cl_dbg_err(cl_hw, "Verify calibration point: addr %x, idx %=
u, freq %u, phy %u\n",
+                          tmp_pt.addr, tmp_pt.idx, freq, tmp_pt.phy);
+               /* *Uninitiated eeprom value */
+               return -EINVAL;
+       }
+
+       /* Now p0 will contain "Valid" calculations of calib" */
+       p0->calib =3D tmp_pt.calib;
+       return 0;
+}
+
+int cl_calib_get(struct wiphy *wiphy, struct wireless_dev *wdev,
+                            const void *data, int data_len)
+{
+       /* Kernel space callback for handling E2P_GET_CALIB vendor subcmd *=
/
+       int ret;
+       struct point *p0;
+       u8 e2p_bitmap[BIT_MAP_SIZE] =3D {0};
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       if (!data) {
+               cl_dbg_err(cl_hw, "data is null\n");
+               return -1;
+       }
+
+       p0 =3D (struct point *)data;
+
+       ret =3D e2p_prepare(cl_hw, p0, e2p_bitmap);
+       if (ret) {
+               cl_dbg_err(cl_hw, "Unable prepare e2p\n");
+               return ret;
+       }
+
+       ret =3D read_or_interpolate_point(cl_hw, e2p_bitmap, p0);
+       if (ret) {
+               cl_dbg_trace(cl_hw, "read_or_interpolate_point error\n");
+               return ret;
+       }
+
+       return cl_vendor_reply(cl_hw, &p0->calib, sizeof(p0->calib));
+}
+
+int cl_calib_set(struct wiphy *wiphy, struct wireless_dev *wdev,
+                            const void *data, int data_len)
+{
+       /* Kernel space callback for handling E2P_SET_CALIB vendor subcmd *=
/
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct point pt;
+       int ret;
+       u8 e2p_bitmap[BIT_MAP_SIZE] =3D {0};
+       u8 ch_idx =3D 0;
+
+       if (!data) {
+               cl_dbg_err(cl_hw, "data is null\n");
+               return -1;
+       }
+
+       pt =3D *(struct point *)data;
+
+       ret =3D e2p_prepare(cl_hw, &pt, e2p_bitmap);
+       if (ret) {
+               cl_dbg_err(cl_hw, "Unable prepare e2p\n");
+               return ret;
+       }
+
+       if (pt.addr =3D=3D INVALID_ADDR) {
+               cl_dbg_err(cl_hw, "Invalid address - permission denied\n");
+               return -EPERM;
+       }
+
+       if (pt.calib.pow < POWER_MIN_DB || pt.calib.pow > POWER_MAX_DB) {
+               cl_dbg_err(cl_hw, "Invalid power (%d). Valid range (%d - %d=
)\n",
+                          pt.calib.pow, POWER_MIN_DB, POWER_MAX_DB);
+               return -1;
+       }
+
+       if (pt.calib.offset < POWER_OFFSET_MIN_Q2 || pt.calib.offset > POWE=
R_OFFSET_MAX_Q2) {
+               cl_dbg_err(cl_hw, "Invalid power offset (%d). Valid range (=
%d - %d)\n",
+                          pt.calib.offset, POWER_OFFSET_MIN_Q2, POWER_OFFS=
ET_MAX_Q2);
+               return -1;
+       }
+
+       if (!bitmap_test_bit_idx(e2p_bitmap, pt.idx)) {
+               cl_dbg_err(cl_hw, "No permition to write to this channel %u=
\n", pt.idx);
+               return -EACCES;
+       }
+
+       /*
+        * Temperature is an optional argument for "e2p set calib" command.
+        * If value is 0x7f then temperature argument was not set, and it
+        * should be set by the driver.
+        */
+       if (pt.calib.tmp =3D=3D S8_MAX)
+               pt.calib.tmp =3D cl_temperature_read(cl_hw, TEMP_MODE_INTER=
NAL);
+
+       if (cl_e2p_write(cl_hw->chip, (u8 *)&pt.calib, sizeof(struct eeprom=
_phy_calib), pt.addr))
+               return -1;
+
+       ch_idx =3D cl_channel_to_index(cl_hw, pt.chan);
+
+       if (ch_idx < MAX_CHANNELS && pt.phy < MAX_ANTENNAS) {
+               cl_hw->tx_pow_info[ch_idx][pt.phy].power =3D pt.calib.pow;
+               cl_hw->tx_pow_info[ch_idx][pt.phy].offset =3D pt.calib.offs=
et;
+               cl_hw->tx_pow_info[ch_idx][pt.phy].temperature =3D pt.calib=
.tmp;
+               cl_hw->set_calib =3D true;
+       }
+
+       return 0;
+}
+
+static void cl_calib_power_reset(struct cl_hw *cl_hw)
+{
+       u8 ch_idx;
+       u16 phy;
+       static const struct cl_tx_power_info default_info =3D {
+               .power       =3D UNCALIBRATED_POWER,
+               .offset      =3D UNCALIBRATED_POWER_OFFSET,
+               .temperature =3D UNCALIBRATED_TEMPERATURE
+       };
+
+       /* Initiate tx_pow_info struct to default values */
+       for (ch_idx =3D 0; ch_idx < cl_channel_num(cl_hw); ch_idx++)
+               for (phy =3D 0; phy < MAX_ANTENNAS; phy++)
+                       cl_hw->tx_pow_info[ch_idx][phy] =3D default_info;
+}
+
+#define PHY0_OFFSET_FIX_Q2 -8 /* -2db */
+#define PHY3_OFFSET_FIX_Q2 14 /* +3.5db */
+
+void cl_calib_power_read(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       int ret;
+       u8 bitmap[BIT_MAP_SIZE] =3D {0};
+       struct point curr_point =3D {0};
+       u8 *phy =3D &curr_point.phy;
+       u8 *ch_idx =3D &curr_point.idx;
+
+       /* Initiate tx_pow_info struct to default values */
+       cl_calib_power_reset(cl_hw);
+
+       /* Vector not initiated set table to default values */
+       if (unlikely(read_validate_vector_bitmap(cl_hw, bitmap))) {
+               cl_dbg_trace(cl_hw, "initiate to default values\n");
+               return;
+       }
+
+       /* Perform only on calibrated boards - read_validate_vector_bitmap =
succeeded (0) */
+       for (*ch_idx =3D 0; *ch_idx < cl_channel_num(cl_hw); (*ch_idx)++)
+               for (*phy =3D 0; *phy < cl_hw->num_antennas; (*phy)++) {
+                       ret =3D point_idx_to_address(cl_hw, bitmap, &curr_p=
oint);
+
+                       if (ret) {
+                               /* *don't overwrite default values */
+                               cl_dbg_err(cl_hw, "point idx to address fai=
led\n");
+                               continue;
+                       }
+
+                       ret =3D read_or_interpolate_point(cl_hw, bitmap, &c=
urr_point);
+                       /* Unable to calculate new value =3D=3D> DON'T over=
write default values */
+                       if (unlikely(ret))
+                               continue;
+
+                       /*
+                        * Work around:
+                        * Add 3.5dB offset to PHY3 if EEPROM version is 0.
+                        * Decrease 2dB offset to all PHYs if EEPROM versio=
n is 1.
+                        */
+                       if (!cl_chip_is_6g(chip)) {
+                               u8 eeprom_version =3D chip->eeprom_cache->g=
eneral.version;
+
+                               if (cl_band_is_5g(cl_hw) && eeprom_version =
=3D=3D 0 && *phy =3D=3D 3)
+                                       curr_point.calib.offset +=3D PHY3_O=
FFSET_FIX_Q2;
+                               else if (cl_band_is_24g(cl_hw) && eeprom_ve=
rsion =3D=3D 1)
+                                       curr_point.calib.offset +=3D PHY0_O=
FFSET_FIX_Q2;
+                       }
+
+                       cl_hw->tx_pow_info[*ch_idx][*phy].power =3D curr_po=
int.calib.pow;
+                       cl_hw->tx_pow_info[*ch_idx][*phy].offset =3D curr_p=
oint.calib.offset;
+                       cl_hw->tx_pow_info[*ch_idx][*phy].temperature =3D c=
urr_point.calib.tmp;
+               }
+
+       cl_dbg_trace(cl_hw, "Created tx_pow_info\n");
+}
+
+void cl_calib_power_offset_fill(struct cl_hw *cl_hw, u8 channel,
+                                     u8 bw, u8 offset[MAX_ANTENNAS])
+{
+       u8 i;
+       u8 chan_idx =3D cl_channel_to_index(cl_hw, channel);
+       s8 signed_offset;
+       struct cl_ate_db *ate_db =3D &cl_hw->ate_db;
+
+       if (chan_idx =3D=3D INVALID_CHAN_IDX)
+               return;
+
+       /* In ATE mode, use values of 'ATE power_offset' if it was set */
+       if (ate_db->active && ate_db->tx_power_offset[0] !=3D S8_MAX) {
+               for (i =3D 0; i < MAX_ANTENNAS; i++) {
+                       s8 pow_offset =3D ate_db->tx_power_offset[i];
+
+                       signed_offset =3D cl_power_offset_check_margin(cl_h=
w, bw, i, pow_offset);
+                       offset[i] =3D cl_convert_signed_to_reg_value(signed=
_offset);
+               }
+
+               return;
+       }
+
+       for (i =3D 0; i < MAX_ANTENNAS; i++) {
+               s8 pow_offset =3D cl_hw->tx_pow_info[chan_idx][i].offset;
+
+               signed_offset =3D cl_power_offset_check_margin(cl_hw, bw, i=
, pow_offset);
+               offset[i] =3D cl_convert_signed_to_reg_value(signed_offset)=
;
+       }
+}
+
+static void pivot_channels_reset(struct cl_hw *cl_hw, u8 *bitmap)
+{
+       u8 i, start =3D 0, max =3D 0;
+
+       get_bitmap_boundaries(cl_hw->chip, cl_hw->tcv_idx, &start, &max);
+
+       for (i =3D start; i < max; i++)
+               bitmap_clear_bit_idx(cl_hw, bitmap, i);
+}
+
+static u8 count_num_pivots(struct cl_chip *chip, const u8 *bitmap, u8 tcv_=
idx)
+{
+       u8 i =3D 0, cnt =3D 0, start =3D 0, max =3D 0;
+
+       get_bitmap_boundaries(chip, tcv_idx, &start, &max);
+
+       for (i =3D start; i < max; i++)
+               if (bitmap_test_bit_idx(bitmap, i))
+                       cnt++;
+
+       return cnt;
+}
+
+int cl_calib_pivot_channels_set(struct cl_hw *cl_hw, const void *chan_list=
, u32 size)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       u8 bitmap[BIT_MAP_SIZE] =3D {0};
+       u8 num_pivots =3D 0;
+       u8 idx =3D 0;
+
+       if (cl_e2p_read(chip, bitmap, BIT_MAP_SIZE, ADDR_CALIB_CHAN_BMP))
+               return -1;
+
+       num_pivots =3D count_num_pivots(chip, bitmap, cl_hw->tcv_idx);
+
+       if (num_pivots > 0) {
+               cl_dbg_err(cl_hw, "Vector already set\n");
+               return -EACCES;
+       }
+
+       while (size--) {
+               idx =3D cl_channel_to_index(cl_hw, ((u32 *)chan_list)[size]=
);
+
+               if (idx =3D=3D INVALID_CHAN_IDX) {
+                       cl_dbg_err(cl_hw, "Bad channel index %u", idx);
+                       return -EINVAL;
+               }
+
+               if (cl_hw_is_tcv1(cl_hw))
+                       idx +=3D get_bitmap_start_tcv1(chip);
+
+               if (!bitmap_set_bit_idx(cl_hw, bitmap, idx)) {
+                       cl_dbg_err(cl_hw, "Bad channel index %u", idx);
+                       return -EINVAL;
+               }
+       }
+
+       if (count_bits(bitmap) > NUM_OF_PIVOTS) {
+               cl_dbg_err(cl_hw, "Too much pivot channels chosen\n");
+               return -EINVAL;
+       }
+
+       if (cl_e2p_write(chip, bitmap, BIT_MAP_SIZE, ADDR_CALIB_CHAN_BMP))
+               return -1;
+
+       /*
+        * Pivots of tcv0 are located before the pivots of tcv1.
+        * If calibration of tcv1 was done before calibration of tcv0, we m=
ust move the
+        * calibration data of tcv1 so that there is room for the tcv0 cali=
bration data.
+        */
+       if (cl_hw_is_tcv0(cl_hw)) {
+               u8 num_pivots_tcv0 =3D count_num_pivots(chip, bitmap, TCV0)=
;
+               u8 num_pivots_tcv1 =3D count_num_pivots(chip, bitmap, TCV1)=
;
+
+               if (num_pivots_tcv1 > 0) {
+                       struct eeprom_phy_calib phy_calib[NUM_PIVOT_PHYS] =
=3D { {0} };
+
+                       if (cl_e2p_read(chip, (u8 *)phy_calib, SIZE_CALIB_P=
HY, ADDR_CALIB_PHY))
+                               return -1;
+
+                       memmove(&phy_calib[num_pivots_tcv0 * MAX_ANTENNAS],
+                               &phy_calib[0],
+                               num_pivots_tcv1 * MAX_ANTENNAS * sizeof(str=
uct eeprom_phy_calib));
+                       memset(&phy_calib[0],
+                              0,
+                              num_pivots_tcv0 * MAX_ANTENNAS * sizeof(stru=
ct eeprom_phy_calib));
+
+                       if (cl_e2p_write(chip, (u8 *)phy_calib, SIZE_CALIB_=
PHY, ADDR_CALIB_PHY))
+                               return -1;
+               }
+       }
+
+       return 0;
+}
+
+int cl_calib_pivot_channels_reset(struct cl_hw *cl_hw)
+{
+       /* Both eeprom and efuse are being set to 0 for reset */
+       struct cl_chip *chip =3D cl_hw->chip;
+       u8 bitmap[BIT_MAP_SIZE] =3D {0};
+       struct eeprom_phy_calib phy_calib[NUM_PIVOT_PHYS] =3D { {0} };
+       u8 num_pivots_tcv0 =3D 0;
+       u8 num_pivots_tcv1 =3D 0;
+
+       if (sizeof(phy_calib) !=3D SIZE_CALIB_PHY) {
+               cl_dbg_err(cl_hw, "sizeof(phy_calib) !=3D SIZE_CALIB_PHY\n"=
);
+               return -1;
+       }
+
+       /* Read current bitmap and calibration data */
+       if (cl_e2p_read(chip, (u8 *)bitmap, BIT_MAP_SIZE, ADDR_CALIB_CHAN_B=
MP))
+               return -1;
+       if (cl_e2p_read(chip, (u8 *)phy_calib, SIZE_CALIB_PHY, ADDR_CALIB_P=
HY))
+               return -1;
+
+       /* Find number of pivots for each band */
+       num_pivots_tcv0 =3D count_num_pivots(chip, bitmap, TCV0);
+       num_pivots_tcv1 =3D count_num_pivots(chip, bitmap, TCV1);
+
+       /* Reset bitmap of this band */
+       pivot_channels_reset(cl_hw, bitmap);
+
+       /* Reset calibration data of this band */
+       if (cl_hw_is_tcv0(cl_hw)) {
+               if (num_pivots_tcv1 > 0) {
+                       /* For tcv0 shift calibration data of tcv1 to the b=
eginning */
+                       memcpy(&phy_calib[0], &phy_calib[num_pivots_tcv0 * =
MAX_ANTENNAS],
+                              num_pivots_tcv1 * MAX_ANTENNAS * sizeof(stru=
ct eeprom_phy_calib));
+                       memset(&phy_calib[num_pivots_tcv1 * MAX_ANTENNAS], =
0,
+                              num_pivots_tcv0 * MAX_ANTENNAS * sizeof(stru=
ct eeprom_phy_calib));
+               } else {
+                       memset(&phy_calib[0], 0,
+                              num_pivots_tcv0 * MAX_ANTENNAS * sizeof(stru=
ct eeprom_phy_calib));
+               }
+       } else {
+               memset(&phy_calib[num_pivots_tcv0 * MAX_ANTENNAS],
+                      0, num_pivots_tcv1 * MAX_ANTENNAS * sizeof(struct ee=
prom_phy_calib));
+       }
+
+       /* Write back modified bitmap and calibration data */
+       if (cl_e2p_write(chip, (u8 *)bitmap, BIT_MAP_SIZE, ADDR_CALIB_CHAN_=
BMP))
+               return -1;
+       if (cl_e2p_write(chip, (u8 *)phy_calib, SIZE_CALIB_PHY, ADDR_CALIB_=
PHY))
+               return -1;
+
+       /* Reset host calibration data */
+       cl_calib_power_reset(cl_hw);
+
+       return 0;
+}
+
+static void cl_calib_init_cfm(struct cl_iq_dcoc_data *iq_dcoc_data)
+{
+       int i;
+
+       for (i =3D 0; i < CALIB_CFM_MAX; i++)
+               iq_dcoc_data->dcoc_iq_cfm[i].status =3D CALIB_FAIL;
+}
+
+static void cl_calib_save_channel(struct cl_hw *cl_hw, struct cl_calib_res=
tore *calib_restore)
+{
+       calib_restore->bw =3D cl_hw->bw;
+       calib_restore->primary =3D cl_hw->primary_freq;
+       calib_restore->center =3D cl_hw->center_freq;
+       calib_restore->channel =3D ieee80211_frequency_to_channel(cl_hw->pr=
imary_freq);
+}
+
+static int cl_calib_set_idle(struct cl_hw *cl_hw, bool idle)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+       struct cl_hw *cl_hw_tcv1 =3D chip->cl_hw_tcv1;
+       u8 is_prod =3D chip->conf->ce_production_mode;
+       bool tcv0_en =3D (cl_radio_is_on(cl_hw_tcv0) || (is_prod && cl_hw_t=
cv0->ate_db.active));
+       bool tcv1_en =3D (cl_radio_is_on(cl_hw_tcv1) || (is_prod && cl_hw_t=
cv1->ate_db.active));
+
+       if (!idle) {
+               if (tcv1_en)
+                       cl_msg_tx_set_idle(cl_hw_tcv1, MAC_ACTIVE);
+
+               if (tcv0_en)
+                       cl_msg_tx_set_idle(cl_hw_tcv0, MAC_ACTIVE);
+
+               return 0;
+       }
+
+       if (tcv1_en)
+               cl_msg_tx_idle_async(cl_hw_tcv1);
+
+       if (tcv0_en)
+               cl_msg_tx_set_idle(cl_hw_tcv0, MAC_IDLE_SYNC);
+
+       if (wait_event_timeout(cl_hw->wait_queue, !cl_hw->idle_async_set,
+                              CL_MSG_CFM_TIMEOUT_JIFFIES))
+               return 0;
+
+       cl_dbg_err(cl_hw, "Timeout occurred - MM_IDLE_ASYNC_IND\n");
+
+       return -ETIMEDOUT;
+}
+
+static int _cl_calib_set_channel(struct cl_hw *cl_hw, u32 channel, u32 bw)
+{
+       u32 primary =3D 0;
+       u32 center =3D 0;
+       enum nl80211_chan_width width =3D NL80211_CHAN_WIDTH_20;
+
+       if (cl_chandef_calc(cl_hw, channel, bw, &width, &primary, &center))=
 {
+               cl_dbg_err(cl_hw, "cl_chandef_calc failed\n");
+               return -EINVAL;
+       }
+
+       cl_dbg_verbose(cl_hw, "Calibrate channel %u bw %u\n", channel, BW_T=
O_MHZ(bw));
+
+       return _cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center, =
SET_CHANNEL_MODE_CALIB);
+}
+
+static void cl_calib_channels_6g(struct cl_hw *cl_hw)
+{
+       int i;
+
+       /* Calibrate channels: 1, 33, 65, 97, 129, 161, 193, 225 */
+       for (i =3D 0; i < CALIB_CHAN_6G_MAX; i +=3D 2)
+               _cl_calib_set_channel(cl_hw, calib_channels_6g[i], CHNL_BW_=
160);
+
+       for (i =3D 0; i < CALIB_CHAN_6G_MAX; i++) {
+               _cl_calib_set_channel(cl_hw, calib_channels_6g[i], CHNL_BW_=
80);
+               _cl_calib_set_channel(cl_hw, calib_channels_6g[i], CHNL_BW_=
20);
+       }
+}
+
+static void cl_calib_channels_5g(struct cl_hw *cl_hw)
+{
+       int i;
+
+       _cl_calib_set_channel(cl_hw, 36, CHNL_BW_160);
+       _cl_calib_set_channel(cl_hw, 100, CHNL_BW_160);
+
+       for (i =3D 0; i < CALIB_CHAN_5G_MAX; i++) {
+               _cl_calib_set_channel(cl_hw, calib_channels_5g[i], CHNL_BW_=
80);
+               _cl_calib_set_channel(cl_hw, calib_channels_5g[i], CHNL_BW_=
20);
+       }
+}
+
+static void cl_calib_channels_24g(struct cl_hw *cl_hw)
+{
+       int i;
+
+       for (i =3D 0; i < CALIB_CHAN_24G_MAX; i++) {
+               _cl_calib_set_channel(cl_hw, calib_channels_24g[i], CHNL_BW=
_40);
+               _cl_calib_set_channel(cl_hw, calib_channels_24g[i], CHNL_BW=
_20);
+       }
+}
+
+static void cl_calib_scan_all_channels(struct cl_hw *cl_hw)
+{
+       if (cl_band_is_6g(cl_hw))
+               cl_calib_channels_6g(cl_hw);
+       else if (cl_band_is_5g(cl_hw))
+               cl_calib_channels_5g(cl_hw);
+       else
+               cl_calib_channels_24g(cl_hw);
+}
+
+static void cl_calib_restore_channel(struct cl_hw *cl_hw, struct cl_calib_=
restore *calib_restore)
+{
+       u8 bw =3D calib_restore->bw;
+       u32 primary =3D calib_restore->primary;
+       u32 center =3D calib_restore->center;
+       u8 channel =3D calib_restore->channel;
+
+       cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center);
+}
+
+static void cl_calib_print_errors(struct cl_hw *cl_hw)
+{
+       struct cl_calib_errors *errors =3D &cl_hw->chip->calib_db.errors[cl=
_hw->tcv_idx];
+
+       if (!errors->dcoc && !errors->lolc && !errors->iq_rx && !errors->iq=
_tx)
+               return;
+
+       pr_warn("Calibration errors: DCOC %u, LOLC %u, IQ RX %u, IQ TX %u\n=
",
+               errors->dcoc, errors->lolc, errors->iq_rx, errors->iq_tx);
+}
+
+static u8 cl_calib_channel_to_idx(struct cl_hw *cl_hw, u8 channel)
+{
+       u8 i =3D 0;
+
+       if (cl_band_is_6g(cl_hw)) {
+               for (i =3D 0; i < CALIB_CHAN_6G_MAX; i++)
+                       if (calib_channels_6g[i] =3D=3D channel)
+                               return i;
+       } else if (cl_band_is_5g(cl_hw)) {
+               for (i =3D 0; i < CALIB_CHAN_5G_MAX; i++)
+                       if (calib_channels_5g[i] =3D=3D channel)
+                               return i;
+       } else {
+               for (i =3D 0; i < CALIB_CHAN_24G_MAX; i++)
+                       if (calib_channels_24g[i] =3D=3D channel)
+                               return i;
+       }
+
+       return 0;
+}
+
+static void cl_calib_check_err_dcoc(struct cl_hw *cl_hw, s16 calib_tempera=
ture,
+                                   int channel, u8 bw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       int lna, ant;
+       struct cl_dcoc_report *dcoc_calib_report_dma;
+       u8 dcoc_threshold =3D chip->conf->ci_dcoc_mv_thr[bw];
+       s16 i, q;
+
+       for (lna =3D 0; lna < DCOC_LNA_GAIN_NUM; lna++) {
+               ant_for_each(ant) {
+                       dcoc_calib_report_dma =3D
+                               &cl_hw->iq_dcoc_data_info.iq_dcoc_data->rep=
ort.dcoc[lna][ant];
+                       i =3D (s16)le16_to_cpu(dcoc_calib_report_dma->i_dc)=
;
+                       q =3D (s16)le16_to_cpu(dcoc_calib_report_dma->q_dc)=
;
+
+                       if (abs(i) > dcoc_threshold) {
+                               chip->calib_db.errors[cl_hw->tcv_idx].dcoc+=
+;
+                               cl_dbg_info(cl_hw,
+                                           "DCOC Error: lna =3D %u, ant =
=3D %u, "
+                                           "i (|%d|) > threshold (%d)\n",
+                                           lna, ant, i, dcoc_threshold);
+                       } else {
+                               cl_dbg_info(cl_hw,
+                                           "DCOC Valid: lna =3D %u, ant =
=3D %u, "
+                                           "i (|%d|) < threshold (%d)\n",
+                                           lna, ant, i, dcoc_threshold);
+                       }
+
+                       if (abs(q) > dcoc_threshold) {
+                               chip->calib_db.errors[cl_hw->tcv_idx].dcoc+=
+;
+                               cl_dbg_info(cl_hw,
+                                           "DCOC Error: lna =3D %u, ant =
=3D %u, "
+                                           "q (|%d|) > threshold (%d)\n",
+                                           lna, ant, q, dcoc_threshold);
+                       } else {
+                               cl_dbg_info(cl_hw,
+                                           "DCOC Valid: lna =3D %u, ant =
=3D %u, "
+                                           "q (|%d|) < threshold (%d)\n",
+                                           lna, ant, q, dcoc_threshold);
+                       }
+               }
+       }
+}
+
+static void cl_calib_check_err_iq_lolc(struct cl_hw *cl_hw, s16 calib_temp=
erature,
+                                      int channel, u8 bw, u8 plan_bitmap)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_iq_dcoc_report *report =3D &cl_hw->iq_dcoc_data_info.iq_d=
coc_data->report;
+       int ant;
+       struct cl_lolc_report lolc_report_dma;
+       s16 lolc_threshold =3D chip->conf->ci_lolc_db_thr;
+       s32 lolc_qual =3D 0;
+
+       ant_for_each(ant) {
+               if ((plan_bitmap & (1 << ant)) =3D=3D 0)
+                       continue;
+
+               lolc_report_dma =3D report->lolc_report[ant];
+               lolc_qual =3D (s16)le16_to_cpu(lolc_report_dma.lolc_qual) >=
> 8;
+
+               if (lolc_qual > lolc_threshold) {
+                       chip->calib_db.errors[cl_hw->tcv_idx].lolc++;
+
+                       cl_dbg_info(cl_hw,
+                                   "LOLC Error: ant =3D %u, n_iter =3D %u,=
 "
+                                   "quality (%d) > threshold (%d)\n",
+                                   ant, lolc_report_dma.n_iter, lolc_qual,=
 lolc_threshold);
+               } else {
+                       cl_dbg_info(cl_hw,
+                                   "LOLC Valid: ant =3D %u, n_iter =3D %u,=
 "
+                                   "quality (%d) < threshold (%d)\n",
+                                   ant, lolc_report_dma.n_iter, lolc_qual,=
 lolc_threshold);
+               }
+       }
+}
+
+static void cl_calib_check_err_iq(struct cl_hw *cl_hw, s16 calib_temperatu=
re,
+                                 u8 ch, u8 bw, u8 plan_bitmap)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+       u8 ant =3D 0;
+       struct cl_iq_report iq_report_dma;
+       s8 iq_threshold =3D cl_hw->chip->conf->ci_iq_db_thr;
+
+       ant_for_each(ant) {
+               if ((plan_bitmap & (1 << ant)) =3D=3D 0)
+                       continue;
+
+               iq_report_dma =3D cl_hw->iq_dcoc_data_info.iq_dcoc_data->re=
port.iq_tx[ant];
+
+               if (iq_report_dma.ir_db_avg_post > iq_threshold) {
+                       chip->calib_db.errors[tcv_idx].iq_tx++;
+                       cl_dbg_info(cl_hw, "IQ TX Error: ant =3D %u, ir (%d=
) > threshold (%d)\n",
+                                   ant, iq_report_dma.ir_db_avg_post, iq_t=
hreshold);
+               } else {
+                       cl_dbg_info(cl_hw, "IQ TX Valid: ant =3D %u, ir (%d=
) < threshold (%d)\n",
+                                   ant, iq_report_dma.ir_db_avg_post, iq_t=
hreshold);
+               }
+
+               iq_report_dma =3D cl_hw->iq_dcoc_data_info.iq_dcoc_data->re=
port.iq_rx[ant];
+
+               if (iq_report_dma.ir_db_avg_post > iq_threshold) {
+                       chip->calib_db.errors[tcv_idx].iq_rx++;
+                       cl_dbg_info(cl_hw, "IQ RX Error: ant =3D %u, ir (%d=
) > threshold (%d)\n",
+                                   ant, iq_report_dma.ir_db_avg_post, iq_t=
hreshold);
+               } else {
+                       cl_dbg_info(cl_hw, "IQ RX Valid: ant =3D %u, ir (%d=
) < threshold (%d)\n",
+                                   ant, iq_report_dma.ir_db_avg_post, iq_t=
hreshold);
+               }
+       }
+}
+
+static u8 cl_calib_center_freq_to_idx(struct cl_hw *cl_hw, u32 center_freq=
)
+{
+       u8 i =3D 0;
+       u8 center_channel =3D ieee80211_frequency_to_channel(center_freq);
+
+       if (cl_band_is_6g(cl_hw)) {
+               for (i =3D 1; i < CALIB_CHAN_6G_MAX; i++)
+                       if (calib_channels_6g[i] > center_channel)
+                               return (i - 1);
+
+               return (CALIB_CHAN_6G_MAX - 1);
+       }
+
+       if (cl_band_is_5g(cl_hw)) {
+               for (i =3D 1; i < CALIB_CHAN_5G_MAX; i++)
+                       if (calib_channels_5g[i] > center_channel)
+                               return (i - 1);
+
+               return (CALIB_CHAN_5G_MAX - 1);
+       }
+
+       for (i =3D 0; i < CALIB_CHAN_24G_MAX; i++)
+               if (abs(calib_channels_24g[i] - center_channel) < 3)
+                       return i;
+
+       return (CALIB_CHAN_24G_MAX - 1);
+}
+
+static void cl_calib_fill_data_dcoc(struct cl_hw *cl_hw, struct cl_iq_dcoc=
_info *iq_dcoc_db)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       u8 lna =3D 0, ant =3D 0;
+       u8 channel_idx =3D cl_calib_center_freq_to_idx(cl_hw, cl_hw->center=
_freq);
+       u8 bw =3D cl_hw->bw;
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+       u8 sx =3D tcv_idx;
+
+       for (lna =3D 0; lna < DCOC_LNA_GAIN_NUM; lna++)
+               ant_for_each(ant)
+                       iq_dcoc_db->dcoc[lna][ant] =3D
+                               chip->calib_db.dcoc[tcv_idx][channel_idx][b=
w][sx][ant][lna];
+}
+
+static void cl_calib_fill_data_iq(struct cl_hw *cl_hw, struct cl_iq_calib =
*iq_data,
+                                 struct cl_iq_calib *iq_chip_data)
+{
+       u8 ant =3D 0;
+
+       ant_for_each(ant) {
+               iq_data[ant].coef0 =3D cpu_to_le32(iq_chip_data[ant].coef0)=
;
+               iq_data[ant].coef1 =3D cpu_to_le32(iq_chip_data[ant].coef1)=
;
+               iq_data[ant].coef2 =3D cpu_to_le32(iq_chip_data[ant].coef2)=
;
+               iq_data[ant].gain =3D cpu_to_le32(iq_chip_data[ant].gain);
+       }
+}
+
+static void cl_calib_fill_data_iq_lolc(struct cl_hw *cl_hw, __le32 *iq_lol=
c)
+{
+       struct cl_calib_db *calib_db =3D &cl_hw->chip->calib_db;
+       u8 ant =3D 0;
+       u8 chan_idx =3D cl_calib_center_freq_to_idx(cl_hw, cl_hw->center_fr=
eq);
+       u8 bw =3D cl_hw->bw;
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+       u8 sx =3D tcv_idx;
+
+       ant_for_each(ant)
+               iq_lolc[ant] =3D cpu_to_le32(calib_db->iq_tx_lolc[tcv_idx][=
chan_idx][bw][sx][ant]);
+}
+
+static void cl_calib_handle_cfm_dcoc(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_dcoc_calib *dcoc_calib;
+       struct cl_dcoc_calib *dcoc_calib_dma;
+       struct calib_cfm *dcoc_iq_cfm =3D
+               &cl_hw->iq_dcoc_data_info.iq_dcoc_data->dcoc_iq_cfm[CALIB_C=
FM_DCOC];
+       int lna, ant;
+       u16 raw_bits =3D (le16_to_cpu(dcoc_iq_cfm->raw_bits_data_0) +
+                       le16_to_cpu(dcoc_iq_cfm->raw_bits_data_1)) / 2;
+       s16 calib_temperature =3D cl_temperature_calib_calc(cl_hw, raw_bits=
);
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+       u8 sx =3D tcv_idx;
+       u8 channel =3D cl_hw->channel;
+       u8 bw =3D cl_hw->bw;
+       u8 channel_idx =3D cl_calib_channel_to_idx(cl_hw, channel);
+
+       for (lna =3D 0; lna < DCOC_LNA_GAIN_NUM; lna++) {
+               ant_for_each(ant) {
+                       dcoc_calib =3D &chip->calib_db.dcoc[tcv_idx][channe=
l_idx][bw][sx][ant][lna];
+                       dcoc_calib_dma =3D
+                               &cl_hw->iq_dcoc_data_info.iq_dcoc_data->iq_=
dcoc_db.dcoc[lna][ant];
+                       dcoc_calib->i =3D dcoc_calib_dma->i;
+                       dcoc_calib->q =3D dcoc_calib_dma->q;
+               }
+       }
+
+       cl_calib_check_err_dcoc(cl_hw, calib_temperature, channel, bw);
+
+       /*
+        * Set the default status to FAIL, to ensure FW is actually changin=
g the value,
+        * if the calibration succeeded.
+        */
+       cl_hw->iq_dcoc_data_info.iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_DCOC].=
status =3D CALIB_FAIL;
+}
+
+static void cl_calib_handle_cfm_iq(struct cl_hw *cl_hw, u8 plan_bitmap)
+{
+       struct calib_cfm *dcoc_iq_cfm =3D
+               &cl_hw->iq_dcoc_data_info.iq_dcoc_data->dcoc_iq_cfm[CALIB_C=
FM_IQ];
+       u16 raw_bits_data_0 =3D le16_to_cpu(dcoc_iq_cfm->raw_bits_data_0);
+       u16 raw_bits_data_1 =3D le16_to_cpu(dcoc_iq_cfm->raw_bits_data_1);
+       u16 raw_bits =3D (raw_bits_data_0 + raw_bits_data_1) / 2;
+       s16 calib_temperature =3D cl_temperature_calib_calc(cl_hw, raw_bits=
);
+       u8 channel =3D cl_hw->channel;
+       u8 bw =3D cl_hw->bw;
+       int ant;
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+       u8 sx =3D tcv_idx;
+       u8 channel_idx =3D cl_calib_channel_to_idx(cl_hw, channel);
+
+       ant_for_each(ant) {
+               if ((plan_bitmap & (1 << ant)) =3D=3D 0)
+                       continue;
+
+               cl_hw->chip->calib_db.iq_tx[tcv_idx][channel_idx][bw][sx][a=
nt] =3D
+                       cl_hw->iq_dcoc_data_info.iq_dcoc_data->iq_dcoc_db.i=
q_tx[ant];
+
+               cl_hw->chip->calib_db.iq_rx[tcv_idx][channel_idx][bw][sx][a=
nt] =3D
+                       cl_hw->iq_dcoc_data_info.iq_dcoc_data->iq_dcoc_db.i=
q_rx[ant];
+       }
+
+       cl_calib_check_err_iq(cl_hw, calib_temperature, channel, bw, plan_b=
itmap);
+
+       /*
+        * Set the default status to FAIL, to ensure FW is actually changin=
g the value,
+        * if the calibration succeeded.
+        */
+       dcoc_iq_cfm->status =3D CALIB_FAIL;
+}
+
+static void cl_calib_handle_cfm_iq_lolc(struct cl_hw *cl_hw, u8 plan_bitma=
p)
+{
+       struct calib_cfm *dcoc_iq_cfm =3D
+               &cl_hw->iq_dcoc_data_info.iq_dcoc_data->dcoc_iq_cfm[CALIB_C=
FM_IQ];
+       u16 raw_bits =3D (le16_to_cpu(dcoc_iq_cfm->raw_bits_data_0) +
+               le16_to_cpu(dcoc_iq_cfm->raw_bits_data_1)) / 2;
+       s16 calib_temperature =3D cl_temperature_calib_calc(cl_hw, raw_bits=
);
+       u8 channel =3D cl_hw->channel;
+       u8 channel_idx =3D cl_calib_channel_to_idx(cl_hw, channel);
+       u8 bw =3D cl_hw->bw;
+       u8 sx =3D cl_hw->tcv_idx;
+       int ant;
+
+       ant_for_each(ant) {
+               if ((plan_bitmap & (1 << ant)) =3D=3D 0)
+                       continue;
+
+               cl_hw->chip->calib_db.iq_tx_lolc[cl_hw->tcv_idx][channel_id=
x][bw][sx][ant] =3D
+                       cl_hw->iq_dcoc_data_info.iq_dcoc_data->iq_dcoc_db.i=
q_tx_lolc[ant];
+       }
+
+       cl_calib_check_err_iq_lolc(cl_hw, calib_temperature, channel, bw, p=
lan_bitmap);
+
+       /*
+        * Set the default status to FAIL, to ensure FW is actually changin=
g the value,
+        * if the calibration succeeded.
+        */
+       dcoc_iq_cfm->status =3D CALIB_FAIL;
+}
+
+static void cl_calib_set_channel_start_work(struct work_struct *ws)
+{
+       struct cl_calib_work *calib_work =3D container_of(ws, struct cl_cal=
ib_work, ws);
+       struct cl_hw *cl_hw =3D calib_work->cl_hw;
+       struct cl_hw *cl_hw_other =3D cl_hw_other_tcv(cl_hw);
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       cl_calib_start(cl_hw);
+
+       if (cl_chip_is_both_enabled(chip))
+               cl_calib_start(cl_hw_other);
+
+       chip->calib_db.scan_complete =3D true;
+}
+
+int cl_calib_start(struct cl_hw *cl_hw)
+{
+       u8 channel =3D cl_hw->conf->ha_channel;
+       u8 bw =3D cl_hw->conf->ce_channel_bandwidth;
+       enum nl80211_chan_width width =3D NL80211_CHAN_WIDTH_20;
+       u32 primary =3D 0;
+       u32 center =3D 0;
+
+       if (cl_chandef_calc(cl_hw, channel, bw, &width, &primary, &center))
+               return -EINVAL;
+
+       return cl_calib_set_channel(cl_hw, channel, bw, primary, center);
+}
+
+void cl_calib_fill_phy_data(struct cl_hw *cl_hw, struct cl_iq_dcoc_info *i=
q_dcoc_db, u8 flags)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       u8 channel_idx =3D cl_calib_center_freq_to_idx(cl_hw, cl_hw->center=
_freq);
+       u8 bw =3D cl_hw->bw;
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+
+       if (flags & SET_PHY_DATA_FLAGS_DCOC)
+               cl_calib_fill_data_dcoc(cl_hw, iq_dcoc_db);
+
+       if (flags & SET_PHY_DATA_FLAGS_IQ_TX_LOLC)
+               cl_calib_fill_data_iq_lolc(cl_hw, iq_dcoc_db->iq_tx_lolc);
+
+       if (flags & SET_PHY_DATA_FLAGS_IQ_TX)
+               cl_calib_fill_data_iq(cl_hw, iq_dcoc_db->iq_tx,
+                                     chip->calib_db.iq_tx[tcv_idx][channel=
_idx][bw][tcv_idx]);
+
+       if (flags & SET_PHY_DATA_FLAGS_IQ_RX)
+               cl_calib_fill_data_iq(cl_hw, iq_dcoc_db->iq_rx,
+                                     chip->calib_db.iq_rx[tcv_idx][channel=
_idx][bw][tcv_idx]);
+}
+
+int cl_calib_tables_alloc(struct cl_hw *cl_hw)
+{
+       struct cl_iq_dcoc_data *buf =3D NULL;
+       u32 len =3D sizeof(struct cl_iq_dcoc_data);
+       dma_addr_t phys_dma_addr;
+
+       buf =3D dma_alloc_coherent(cl_hw->chip->dev, len, &phys_dma_addr, G=
FP_KERNEL);
+
+       if (!buf)
+               return -1;
+
+       cl_hw->iq_dcoc_data_info.iq_dcoc_data =3D buf;
+       cl_hw->iq_dcoc_data_info.dma_addr =3D cpu_to_le32(phys_dma_addr);
+
+       cl_calib_init_cfm(cl_hw->iq_dcoc_data_info.iq_dcoc_data);
+
+       return 0;
+}
+
+void cl_calib_tables_free(struct cl_hw *cl_hw)
+{
+       struct cl_iq_dcoc_data_info *iq_dcoc_data_info =3D &cl_hw->iq_dcoc_=
data_info;
+       u32 len =3D sizeof(struct cl_iq_dcoc_data);
+       dma_addr_t phys_dma_addr =3D le32_to_cpu(iq_dcoc_data_info->dma_add=
r);
+
+       if (!iq_dcoc_data_info->iq_dcoc_data)
+               return;
+
+       dma_free_coherent(cl_hw->chip->dev, len, (void *)iq_dcoc_data_info-=
>iq_dcoc_data,
+                         phys_dma_addr);
+       iq_dcoc_data_info->iq_dcoc_data =3D NULL;
+}
+
+bool cl_calib_is_needed(struct cl_hw *cl_hw, u8 channel, u8 bw)
+{
+       u8 channel_idx;
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+       u8 ant;
+       u32 primary =3D 0;
+       u32 center_freq =3D 0;
+       enum nl80211_chan_width width =3D NL80211_CHAN_WIDTH_20;
+
+       if (cl_chandef_calc(cl_hw, channel, bw, &width, &primary, &center_f=
req)) {
+               cl_dbg_err(cl_hw, "cl_chandef_calc failed\n");
+               return false;
+       }
+
+       channel_idx =3D cl_calib_center_freq_to_idx(cl_hw, center_freq);
+
+       /* Check if we already calibrated */
+       ant_for_each(ant) {
+               if (cl_hw->chip->calib_db.iq_tx_lolc[tcv_idx][channel_idx][=
bw][tcv_idx][ant])
+                       return false;
+       }
+
+       return true;
+}
+
+int cl_calib_set_channel(struct cl_hw *cl_hw, u8 channel, u8 bw, u32 prima=
ry, u32 center)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_hw *cl_hw_other =3D cl_hw_other_tcv(cl_hw);
+       struct cl_calib_restore calib_restore;
+       int ret =3D 0;
+       u8 fem_mode =3D cl_hw->fem_system_mode;
+       bool save_ch_other =3D !!cl_hw_other->primary_freq;
+
+       if (save_ch_other)
+               cl_calib_save_channel(cl_hw_other, &calib_restore);
+
+       ret =3D cl_calib_set_idle(cl_hw, true);
+       if (ret)
+               return ret;
+
+       cl_fem_set_system_mode(cl_hw, FEM_MODE_LNA_BYPASS_ONLY, U8_MAX);
+       cl_afe_cfg_calib(chip);
+
+       if (chip->conf->ce_calib_scan_en && !chip->calib_db.scan_complete &=
& cl_hw->calib_ready)
+               cl_calib_scan_all_channels(cl_hw);
+       else
+               _cl_calib_set_channel(cl_hw, channel, bw);
+
+       cl_fem_set_system_mode(cl_hw, fem_mode, U8_MAX);
+       cl_afe_cfg_restore(chip);
+
+       _cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center, SET_CHA=
NNEL_MODE_OPERETIONAL);
+
+       if (save_ch_other)
+               cl_calib_restore_channel(cl_hw_other, &calib_restore);
+
+       cl_calib_set_idle(cl_hw, false);
+
+       return ret;
+}
+
+void cl_calib_start_work(struct cl_hw *cl_hw)
+{
+       struct cl_calib_work *calib_work =3D kzalloc(sizeof(*calib_work), G=
FP_ATOMIC);
+
+       if (!calib_work)
+               return;
+
+       calib_work->cl_hw =3D cl_hw;
+       INIT_WORK(&calib_work->ws, cl_calib_set_channel_start_work);
+       queue_work(cl_hw->drv_workqueue, &calib_work->ws);
+}
+
+int cl_calib_handle_cfm(struct cl_hw *cl_hw, u8 mode)
+{
+       struct cl_iq_dcoc_data *iq_dcoc_data =3D cl_hw->iq_dcoc_data_info.i=
q_dcoc_data;
+       struct cl_calib_errors *errors =3D &cl_hw->chip->calib_db.errors[cl=
_hw->tcv_idx];
+
+       /*
+        * In case any of the requested calibrations failed - no need to co=
py
+        * the other Calibration data, and fail the whole calibration proce=
ss.
+        */
+       if ((mode & SET_CHANNEL_MODE_CALIB_DCOC &&
+            iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_DCOC].status !=3D CALIB_SU=
CCESS) ||
+           (mode & SET_CHANNEL_MODE_CALIB_IQ &&
+            iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_IQ].status !=3D CALIB_SUCC=
ESS)) {
+               cl_dbg_err(cl_hw, "Calibration failed! mode =3D %u, DCOC_CF=
M_STATUS =3D %u, "
+                          "IQ_CFM_STATUS =3D %u\n",
+                          mode,
+                          iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_DCOC].status=
,
+                          iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_IQ].status);
+               /* Set status to CALIB_FAIL to ensure that FW is writing th=
e values. */
+               iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_DCOC].status =3D CALIB_=
FAIL;
+               iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_IQ].status =3D CALIB_FA=
IL;
+               return -1;
+       }
+
+       if (mode & SET_CHANNEL_MODE_CALIB_DCOC)
+               cl_calib_handle_cfm_dcoc(cl_hw);
+
+       if (mode & SET_CHANNEL_MODE_CALIB_IQ)
+               cl_calib_handle_cfm_iq(cl_hw, cl_hw->mask_num_antennas);
+
+       if (mode & SET_CHANNEL_MODE_CALIB_LOLC)
+               cl_calib_handle_cfm_iq_lolc(cl_hw, cl_hw->mask_num_antennas=
);
+
+       /* Print calibration errors counters */
+       cl_calib_print_errors(cl_hw);
+
+       memset(errors, 0, sizeof(*errors));
+
+       return 0;
+}
+
+int cl_calib_validate_ants(struct cl_hw *cl_hw)
+{
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       u8 ant =3D 0;
+       int ret =3D 0;
+
+       for (ant =3D 0; ant < cl_hw->num_antennas; ant++) {
+               if (conf->ci_calib_ant_tx[ant] < cl_hw->first_ant ||
+                   conf->ci_calib_ant_tx[ant] > cl_hw->last_ant) {
+                       CL_DBG_ERROR(cl_hw,
+                                    "TX: Antenna [%u] value is out of boun=
daries [%u].\n"
+                                    "Minimum value allowed is: %u\n"
+                                    "Maximum value allowed is: %u\n",
+                                    ant, conf->ci_calib_ant_tx[ant], cl_hw=
->first_ant,
+                                    cl_hw->last_ant);
+                       ret =3D -1;
+               }
+
+               if (conf->ci_calib_ant_rx[ant] < cl_hw->first_ant ||
+                   conf->ci_calib_ant_rx[ant] > cl_hw->last_ant) {
+                       CL_DBG_ERROR(cl_hw,
+                                    "RX: Antenna [%u] value is out of boun=
daries [%u]."
+                                    "Minimum value allowed is: %u\n"
+                                    "Maximum value allowed is: %u\n",
+                                    ant, conf->ci_calib_ant_tx[ant], cl_hw=
->first_ant,
+                                    cl_hw->last_ant);
+                       ret =3D -1;
+               }
+       }
+
+       return ret;
+}
+
+void cl_calib_iq_get_tone_vector(u8 bw, u16 *tone_vector)
+{
+       u8 tone =3D 0;
+
+       for (tone =3D 0; tone < IQ_NUM_TONES_REQ; tone++)
+               tone_vector[tone] =3D cpu_to_le16((u16)tone_vector_arr[bw][=
tone]);
+}
+
+static int cl_calib_print_dcoc(struct cl_hw *cl_hw)
+{
+       struct cl_calib_db *calib_db =3D &cl_hw->chip->calib_db;
+       struct cl_dcoc_calib *dcoc_calib;
+       u8 lna =3D 0;
+       u8 ant =3D 0;
+       u8 channel_idx =3D cl_calib_center_freq_to_idx(cl_hw, cl_hw->center=
_freq);
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+       u8 sx =3D tcv_idx;
+       u8 bw =3D cl_hw->bw;
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+       int len =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                       "DCOC:\n"
+                       "LNA GAIN   ANTENNA   I    Q\n"
+                       "----------------------------\n");
+
+       for (lna =3D 0; lna < DCOC_LNA_GAIN_NUM; lna++) {
+               ant_for_each(ant) {
+                       dcoc_calib =3D
+                               &calib_db->dcoc[tcv_idx][channel_idx][bw][s=
x][ant][lna];
+
+                       len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                                       "%-11u%-10u%-5d%-5d\n", lna,
+                                       ant, dcoc_calib->i, dcoc_calib->q);
+               }
+       }
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_calib_print_lolc(struct cl_hw *cl_hw)
+{
+       struct cl_calib_db *calib_db =3D &cl_hw->chip->calib_db;
+       u32 lolc_calib;
+       u8 ant =3D 0;
+       u8 channel_idx =3D cl_calib_center_freq_to_idx(cl_hw, cl_hw->center=
_freq);
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+       u8 sx =3D tcv_idx;
+       u8 bw =3D cl_hw->bw;
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+       int len =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                       "LOLC:\n"
+                       "ANTENNA   I     Q\n"
+                       "---------------------\n");
+
+       ant_for_each(ant) {
+               lolc_calib =3D calib_db->iq_tx_lolc[tcv_idx][channel_idx][b=
w][sx][ant];
+
+               len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                               "%-10u%-6d%-6d\n",
+                               ant, CAST_S12_TO_S32(lolc_calib & U12_BIT_M=
ASK),
+                               CAST_S12_TO_S32((lolc_calib >> 2) & U12_BIT=
_MASK));
+       }
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_calib_print_iq(struct cl_hw *cl_hw)
+{
+       struct cl_calib_db *calib_db =3D &cl_hw->chip->calib_db;
+       struct cl_iq_calib *iq;
+       u8 ant =3D 0;
+       u8 channel_idx =3D cl_calib_center_freq_to_idx(cl_hw, cl_hw->center=
_freq);
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+       u8 sx =3D tcv_idx;
+       u8 bw =3D cl_hw->bw;
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+       int len =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                       "IQ TX:\n"
+                       "ANTENNA COEF0      COEF1      COEF2      GAIN\n"
+                       "--------------------------------------------------=
-\n");
+
+       ant_for_each(ant) {
+               iq =3D &calib_db->iq_tx[tcv_idx][channel_idx][bw][sx][ant];
+
+               len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                               "%-7u 0x%08x 0x%08x 0x%08x 0x%08x\n",
+                               ant, iq->coef0, iq->coef1, iq->coef2, iq->g=
ain);
+       }
+
+       len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                       "IQ RX:\n"
+                       "ANTENNA COEF0      COEF1      COEF2      GAIN\n"
+                       "--------------------------------------------------=
-\n");
+
+       ant_for_each(ant) {
+               iq =3D &calib_db->iq_rx[tcv_idx][channel_idx][bw][sx][ant];
+
+               len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                               "%-7u 0x%08x 0x%08x 0x%08x 0x%08x\n",
+                               ant, iq->coef0, iq->coef1, iq->coef2, iq->g=
ain);
+       }
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_calib_common_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "calib usage:\n"
+                "-d : Print DCOC coefficients\n"
+                "-i : Print IQ coefficients\n"
+                "-l : Print LOLC coefficients\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+int cl_calib_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       switch (cli_params->option) {
+       case 'd':
+               return cl_calib_print_dcoc(cl_hw);
+       case 'i':
+               return cl_calib_print_iq(cl_hw);
+       case 'l':
+               return cl_calib_print_lolc(cl_hw);
+       case '?':
+               return cl_calib_common_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
",
+                          cli_params->option);
+               return 0;
+       }
+}
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

