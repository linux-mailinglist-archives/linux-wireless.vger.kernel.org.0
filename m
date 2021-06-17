Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4F33AB8F1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhFQQLS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:18 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:64640
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233594AbhFQQKH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfWJCn01JTNlGChaXZo/aB4LmBtEf9hBfOTPjZ32XBnzqUexfzvllHzrJOy2QIEtp0YYTDRjOjLrFhrHb/hkd9vTX1365fWFbUUV9k2SQhTmQ0mHHLRfbkFoBRLssbfvZgagROquFXzKohixtSxzj8wcN+PV3oCSldkd2Iq8sQqNOBGKys5SFdWODjPjpXSIKLacZfUq1flifZi2f7YevWTQSYr983/Cd7mTp3xDQEcK0OEPkhcP0X8tIKUM4kcRPqUzKwllVLeToRIJqYHQByJTYGhg2Ftk+jrj1pyS4AkRQ8QvoRBFl0tRX/KKW5dAHVmD+docAL1rJiPtmjnY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlFUXudKfigqF8NuTl7BLqfJKPJVdnATWkgl+sW9umA=;
 b=dMPpBSlyNnAUJqKFtOlNF6BLx6jr2btc/O1HcDS61mbdd5YQC/IIEgiMIykeJR8YJpAsK/hrUDsjin7TI4XHAr1Q5DTaOvfVjz3JDXD+kKILcWPgMkZLMW+Pis6VQl4gRKpBjxzYVQ4ygDR14XxsEZ4gaIoXIMKxmsUWEJNt0+cp9u/sqGG1T1/G/65ujTdtTpX5S0m9LQkOGaU5YF3JwutB0n2iOC5LGRKY56WCRuSbysxpDgfQ7xexxAE7F0Jx26a4k8YAXDeBlmhYRkdT2jgHrsPUUdjUUWDDyGja+D17MyuAJspInniEjuCGRQLkgDS3yKeL7FVV/aVbrNj/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlFUXudKfigqF8NuTl7BLqfJKPJVdnATWkgl+sW9umA=;
 b=2W9KalOfVVbWZMXlbZzZmnqWO4QEQNQEX0ZfOUw2gWKYkh7rvc70KstdGOv4k2BFTzDl+x2eYNb2LvMaygtflzTfQaJ9UQuXuoYXEBz6chF4yxuFT7O0oczg/wBBANp5qsRPVKJpJo2BZuksdlwIHQaVcO/ytcF+K1OpSXqEjvE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0515.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:57 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:57 +0000
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
Subject: [RFC v1 229/256] cl8k: add utils/utils.c
Date:   Thu, 17 Jun 2021 16:01:56 +0000
Message-Id: <20210617160223.160998-230-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fa6f399-a8e3-42a7-57aa-08d931a9ea41
X-MS-TrafficTypeDiagnostic: AM0P192MB0515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0515BAFC75771BEE44354E73F60E9@AM0P192MB0515.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMy0ja2FNmKCUBsWXlMKLm9FNsV0ep+OoFa43NsY+mrIiK5dboBmLaVSl7goZbYrDvn09y6qbfIzAxClmlws+SfR4OCWdbXcdrcXRzjpt4HLXm7mJopqiNBmT3avIHLjfu6pSVA+UC9OnHwFDxho5ZoxLs5B5N8jpoEaV19qk4i3XE8Jq1sfPRw+oy2sXzUzvbDshQQNkYGm45tdie4ljqF7z+J/dn7dyIsmeFlYgV5d+OPETBB9CV0k6zV14qxbrPxZTb3H+1GlgTohYs/4beljPL9Ti8coCnwr371nmlfVT2PfOFTI60ZBEUM5BoOBcjxu8JX8dRjq34nbe7r6vMzn/oSR1pp9WDR41yYZdhK6Gk5IgSCQqPeHqIeEBhJHCXpXQg8ql2vLiUZUZPJOm3Mj0es95pu0IjRk0xLRjMFqWHA+6G1g/vt32IKvKXehyjx8L4r51KsAjVIog9GuuLHcNmjc5ucQi/BYIzEJFlpGY3t2KKWMN6zcnT/g0fkaVWhEQ++qiI3fHfcGRGg6MkA1DfBEOdeIdF+iX1XhMmbqH27B3vGi8qWiQLrmpleTUGFPwPUMnOPErcmdHArRSnBP2eodngLjTx67FPNOtAv0b8WlENm1QNTF4I1yh1PAToBRYK2JnPUIN85stDqZQsx2i0xImts/tEJF2h3hqhPFHl0agWKbKYQOkTazfNxN2LX38Xl3lFav1qO2UH/xeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(376002)(39850400004)(136003)(366004)(346002)(4326008)(16526019)(83380400001)(1076003)(8676002)(9686003)(55236004)(6666004)(36756003)(478600001)(8936002)(956004)(186003)(6486002)(38350700002)(6512007)(6916009)(52116002)(86362001)(5660300002)(2906002)(38100700002)(66946007)(2616005)(316002)(6506007)(30864003)(26005)(54906003)(66476007)(107886003)(66556008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uC/jkwiEUrSxl0dhJdBcEqwWwlRfUvB9c6U8eYbSCqCUdZCw03r1yi8Melad?=
 =?us-ascii?Q?aXXUSyIFzGZp3enwzN2PCUr7s9X67PPyDFyBXdgeMl9O5X+dSdhbDmBaE06J?=
 =?us-ascii?Q?b/Qob8o9p5kMjVOtCRSDdFjQjfENwRek4ZxCNenjRqbpMx2Q2mjqC3S6AFum?=
 =?us-ascii?Q?hW/tNMb1CpsGthURammCl7vM/d2VJ535rsNZGd3GcmRtM+pM+MMh8qeTdtsx?=
 =?us-ascii?Q?lXvF83CG+sMw4JS+HLxDpe1SvnQeWPvo/KTtbhOGr+sfC9KM2tKlBAZOaR26?=
 =?us-ascii?Q?NdwFFK8Q1vObJfNUAWn53BxYixQVOWVwdpae8h8P+bpTpjeKG0kpSVjvsEa1?=
 =?us-ascii?Q?RufdAAZ0KL/qlk1HFkhKFS0Ap1snSay3Q+5A1cqmWUHA6wJVcHFwuMpCTBOU?=
 =?us-ascii?Q?V4ZyEYYg27D5Qc2nXCYB9iJexwEI/7jkHSJ/PWjdfhYkf3MgxDiTiz3XOL9Z?=
 =?us-ascii?Q?iG7sUssY1rwN11gYX/4jLd/KH+FEjxCpBom2LNAMMOBjGMTjw4OrRW8pXxFK?=
 =?us-ascii?Q?X8wYJWJmkNFTzx5bzlgdc8/0SWWNmDBuOjAZOCAJDJZLM4Ib/vVp4Yw60G5f?=
 =?us-ascii?Q?4UB1ZzfKb1Bd0j5Gd/jaggiuRqCb4onOJxyj7ZQxWjGfpHEeBBR2eR4xOHm9?=
 =?us-ascii?Q?nHb/+ZVjH2VJsT8Oh3q1GuDSZ5IZrqYAsa+jExFZoH0aG7M8FhWaLr82m9WL?=
 =?us-ascii?Q?iONnNXEacDk7twFNQnTh8OfygoTpbtAESR7VHaoWBMJ6SZ2gg8wouX9odtiZ?=
 =?us-ascii?Q?wSOzkbODN6QhLnc9OYAEthQrabtR7TGLQcZ4LySOgkcXrLyH1XRreRncPWvc?=
 =?us-ascii?Q?8Pew7ZhHiHa1D5WAOlsr7pO4yWknNa8tmQ27h9KCc7h3gSt7PFTIPKsOn0um?=
 =?us-ascii?Q?Fe85MEE14w4sSISW2NRk7aChaz6aesFGQHlBPeYfiIpz+B6yBNEIsOfT+G7D?=
 =?us-ascii?Q?X5v+nIiqI5S1zy8KLrvUBfOpRvy/vhWbTLhMMHllaxUWiYrM/a3VMbUE+20S?=
 =?us-ascii?Q?qo5j6ROH7r7Qc7laPiIwGpF6+8wpfTj+xfnzbaxaBWwoqB7J939vNaiufpM5?=
 =?us-ascii?Q?5jmfMVYPWVlgK1SVh50fiiu20Hz4WSoi9z5Vd4YOnuTSkFTN1lVfD/wjv8vP?=
 =?us-ascii?Q?gsKdoPs7hs8OZgm2r3/zinwh8R+GZcZVJvy5gFKMBGmEC40GtitovpccGQJM?=
 =?us-ascii?Q?8AUCIr9+CmADIeNqoH+TCf/uVG+6r1DJwHKsFujz+1JjYWHZVC1lZlviWutE?=
 =?us-ascii?Q?J9tG3eAwLYiVmb3XKrgu5lrcB+IEE7W9385VHI1Xox95JmsJck+PdL/LOapW?=
 =?us-ascii?Q?5TquF9zx1yMT3pegMegcatRr?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa6f399-a8e3-42a7-57aa-08d931a9ea41
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:50.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwnHE6WZwpLvN94MakPTRbIhq8Az8Kazy06QM5LZck0r4tVjDQYbJr7zfiD0EhhxUwtxZjYnDdt4ZQoM4ziKdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0515
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/utils/utils.c    | 388 ++++++++++++++++++
 1 file changed, 388 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/utils.c

diff --git a/drivers/net/wireless/celeno/cl8k/utils/utils.c b/drivers/net/w=
ireless/celeno/cl8k/utils/utils.c
new file mode 100644
index 000000000000..6d6f913ae95a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils/utils.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/dma-mapping.h>
+#include <linux/list.h>
+#include <linux/jiffies.h>
+#include <linux/kthread.h>
+#include <net/mac80211.h>
+#include <linux/sched/signal.h>
+
+#include "utils/utils.h"
+#include "rx/rx.h"
+#include "tx/tx.h"
+#include "fw/msg_tx.h"
+#include "debugfs.h"
+#include "ipc_shared.h"
+#include "rssi.h"
+#include "traffic.h"
+#include "reg/reg_riu.h"
+#include "reg/reg_mac_hw.h"
+#include "utils/ip.h"
+
+#define GI_08  0
+#define GI_16  1
+#define GI_32  2
+#define GI_04  3
+
+#define GI_MAX_FW 4
+#define GI_MAX_HE 3
+#define GI_MAX_HT_VHT 2
+
+#define CL_TSF_LOW_MIGHT_OVERFLOW_TH 0xFFFFF000
+
+static u8 conv_wrs_gi_ht_vht[GI_MAX_HT_VHT] =3D {
+       [WRS_GI_LONG] =3D GI_08,
+       [WRS_GI_SHORT] =3D GI_04
+};
+
+static u8 conv_wrs_gi_he[GI_MAX_HE] =3D {
+       [WRS_GI_LONG] =3D GI_32,
+       [WRS_GI_SHORT] =3D GI_16,
+       [WRS_GI_VSHORT] =3D GI_08
+};
+
+static u8 conv_fw_gi_ht_vht[GI_MAX_FW] =3D {
+       [GI_08] =3D WRS_GI_LONG,
+       [GI_16] =3D 0,
+       [GI_32] =3D 0,
+       [GI_04] =3D WRS_GI_SHORT,
+};
+
+static u8 conv_fw_gi_he[GI_MAX_FW] =3D {
+       [GI_08] =3D WRS_GI_VSHORT,
+       [GI_16] =3D WRS_GI_SHORT,
+       [GI_32] =3D WRS_GI_LONG,
+       [GI_04] =3D 0,
+};
+
+void cl_hex_dump(char *caption, u8 *buffer, u32 length, u32 offset, bool i=
s_byte)
+{
+       u8 *pt =3D buffer;
+       u32 i;
+       bool end_nl =3D false;
+       char buf[STR_LEN_256B] =3D {0};
+       int len =3D 0;
+
+       if (caption)
+               pr_debug("%s: %p, len =3D %u\n", caption, buffer, length);
+
+       if (is_byte) {
+               for (i =3D 0; i < length; i++) {
+                       if (i % 16 =3D=3D 0)
+                               len +=3D snprintf(buf + len, sizeof(buf) - =
len,
+                                               "0x%04x : ", i + offset);
+                       len +=3D snprintf(buf + len, sizeof(buf) - len,
+                                       "%02x ", ((u8)pt[i]));
+                       end_nl =3D true;
+                       if (i % 16 =3D=3D 15) {
+                               pr_debug("%s", buf);
+                               len =3D 0;
+                               end_nl =3D false;
+                       }
+               }
+       } else {
+               for (i =3D 0; i < (length / sizeof(u32)); i++) {
+                       if (i % 4 =3D=3D 0)
+                               len +=3D snprintf(buf + len, sizeof(buf) - =
len,
+                                               "0x%04x : ",
+                                               (u32)(i * sizeof(u32) + off=
set));
+                       len +=3D snprintf(buf + len, sizeof(buf) - len,
+                                       "%08x ", *((u32 *)(pt + i * sizeof(=
u32))));
+                       end_nl =3D true;
+                       if (i % 4 =3D=3D 3) {
+                               pr_debug("%s", buf);
+                               len =3D 0;
+                               end_nl =3D false;
+                       }
+               }
+       }
+
+       if (end_nl)
+               pr_debug("%s", buf);
+}
+
+u8 convert_gi_format_wrs_to_fw(u8 wrs_mode, u8 gi)
+{
+       if (wrs_mode =3D=3D WRS_MODE_HE && gi < GI_MAX_HE)
+               return conv_wrs_gi_he[gi];
+       else if (wrs_mode > WRS_MODE_OFDM && gi < GI_MAX_HT_VHT)
+               return conv_wrs_gi_ht_vht[gi];
+       else
+               return 0;
+}
+
+u8 convert_gi_format_fw_to_wrs(u8 format_mode, u8 gi)
+{
+       if (gi < GI_MAX_FW) {
+               if (format_mode >=3D FORMATMOD_HE_SU)
+                       return conv_fw_gi_he[gi];
+               else if (format_mode >=3D FORMATMOD_HT_MF)
+                       return conv_fw_gi_ht_vht[gi];
+       }
+
+       return 0;
+}
+
+static u8 map_gi_to_ltf[WRS_GI_MAX] =3D {
+       [WRS_GI_LONG] =3D LTF_X4,
+       [WRS_GI_SHORT] =3D LTF_X2,
+       [WRS_GI_VSHORT] =3D LTF_X2,
+};
+
+u8 cl_map_gi_to_ltf(u8 mode, u8 gi)
+{
+       if (mode =3D=3D WRS_MODE_HE && gi < WRS_GI_MAX)
+               return map_gi_to_ltf[gi];
+
+       return 0;
+}
+
+/* This table holds 10^(-110 -> 0) Q39 values for rx RSSI and noise floor =
calculations */
+#define CL_EXP_TBL_SIZE 111 /* 10^x table size (-110 -> 0dBm) */
+
+static u64 CL_EXP_10[CL_EXP_TBL_SIZE] =3D {
+       0x7FFFFFFFFF, 0x65AC8C2F36, 0x50C335D3DB, 0x4026E73CCD, 0x32F52CFEE=
A, 0x287A26C490,
+       0x2026F30FBB, 0x198A13577C, 0x144960C577, 0x101D3F2D96, 0x0CCCCCCCC=
D, 0x0A2ADAD185,
+       0x08138561FC, 0x066A4A52E1, 0x0518847FE4, 0x040C3713A8, 0x0337184E5=
F, 0x028DCEBBF3,
+       0x0207567A25, 0x019C86515C, 0x0147AE147B, 0x01044914F4, 0x00CEC089C=
C, 0x00A43AA1E3,
+       0x008273A664, 0x00679F1B91, 0x00524F3B0A, 0x0041617932, 0x0033EF0C3=
7, 0x002940A1BC,
+       0x0020C49BA6, 0x001A074EE5, 0x0014ACDA94, 0x00106C4364, 0x000D0B90A=
4, 0x000A5CB5F5,
+       0x00083B1F81, 0x000689BF52, 0x0005318139, 0x000420102C, 0x000346DC5=
D, 0x00029A54B1,
+       0x000211490F, 0x0001A46D24, 0x00014DF4DD, 0x0001094565, 0x0000D2B65=
A, 0x0000A75FEF,
+       0x000084F352, 0x0000699B38, 0x000053E2D6, 0x000042A212, 0x000034EDB=
5, 0x00002A0AEA,
+       0x0000216549, 0x00001A86F1, 0x000015123C, 0x000010BCCB, 0x00000D4B8=
8, 0x00000A8F86,
+       0x000008637C, 0x000006A9CF, 0x0000054AF8, 0x000004344B, 0x00000356E=
E, 0x000002A718,
+       0x0000021B6C, 0x000001AC7B, 0x000001545A, 0x0000010E5A, 0x000000D6C=
0, 0x000000AA95,
+       0x000000877F, 0x0000006BA1, 0x000000557E, 0x00000043E9, 0x00000035F=
1, 0x0000002AD9,
+       0x0000002209, 0x0000001B09, 0x000000157A, 0x000000110F, 0x0000000D8=
D, 0x0000000AC3,
+       0x000000088D, 0x00000006CA, 0x0000000565, 0x0000000449, 0x000000036=
7, 0x00000002B4,
+       0x0000000226, 0x00000001B5, 0x000000015B, 0x0000000114, 0x00000000D=
B, 0x00000000AE,
+       0x000000008A, 0x000000006E, 0x0000000057, 0x0000000045, 0x000000003=
7, 0x000000002C,
+       0x0000000023, 0x000000001C, 0x0000000016, 0x0000000011, 0x000000000=
E, 0x000000000B,
+       0x0000000009, 0x0000000007, 0x0000000005
+};
+
+static s8 cl_eng_to_noise_floor(u64 eng)
+{
+       s8 i =3D 0;
+       s8 noise =3D 0;
+       s64 min_delta =3D S64_MAX;
+
+       for (i =3D ARRAY_SIZE(CL_EXP_10) - 1; i >=3D 0; i--) {
+               if (abs((s64)(((s64)eng) - ((s64)CL_EXP_10[i]))) < min_delt=
a) {
+                       min_delta =3D abs((s64)(((s64)eng) - ((s64)CL_EXP_1=
0[i])));
+                       noise =3D i;
+               }
+       }
+
+       return (-noise);
+}
+
+static void cl_read_reg_noise(struct cl_hw *cl_hw, s8 res[4])
+{
+       u32 reg_val =3D riu_agcinbdpow_20_pnoisestat_get(cl_hw);
+       u8 i =3D 0;
+
+       for (i =3D 0; i < 4; i++) {
+               u8 curr_val =3D (reg_val >> (i * 8)) & 0xFF;
+               /* Convert reg value to real value */
+               res[i] =3D curr_val - 0xFF;
+       }
+}
+
+s8 cl_calc_noise_floor(struct cl_hw *cl_hw, const s8 *reg_noise_floor)
+{
+       s8 noise_floor[4] =3D {0};
+       u64 noise_floor_eng =3D 0;
+
+       if (reg_noise_floor)
+               memcpy(noise_floor, reg_noise_floor, sizeof(noise_floor));
+       else
+               cl_read_reg_noise(cl_hw, noise_floor);
+
+       noise_floor[0] =3D abs(noise_floor[0]);
+       noise_floor[1] =3D abs(noise_floor[1]);
+       noise_floor[2] =3D abs(noise_floor[2]);
+       noise_floor[3] =3D abs(noise_floor[3]);
+
+       BUILD_BUG_ON(CL_EXP_TBL_SIZE > S8_MAX);
+       noise_floor_eng =3D (CL_EXP_10[min_t(s8, noise_floor[0], CL_EXP_TBL=
_SIZE - 1)] +
+                          CL_EXP_10[min_t(s8, noise_floor[1], CL_EXP_TBL_S=
IZE - 1)] +
+                          CL_EXP_10[min_t(s8, noise_floor[2], CL_EXP_TBL_S=
IZE - 1)] +
+                          CL_EXP_10[min_t(s8, noise_floor[3], CL_EXP_TBL_S=
IZE - 1)]);
+
+       noise_floor_eng =3D div64_u64(noise_floor_eng, 4);
+
+       return cl_eng_to_noise_floor(noise_floor_eng);
+}
+
+u8 cl_convert_signed_to_reg_value(s8 val)
+{
+       bool sign =3D (val < 0 ? true : false);
+       u8 res =3D abs(val);
+
+       if (sign)
+               res |=3D (1 << 7);
+
+       return res;
+}
+
+static const int nl_width_to_phy_bw[] =3D {
+       [NL80211_CHAN_WIDTH_20_NOHT] =3D CHNL_BW_20,
+       [NL80211_CHAN_WIDTH_20]      =3D CHNL_BW_20,
+       [NL80211_CHAN_WIDTH_40]      =3D CHNL_BW_40,
+       [NL80211_CHAN_WIDTH_80]      =3D CHNL_BW_80,
+       [NL80211_CHAN_WIDTH_80P80]   =3D CHNL_BW_20,
+       [NL80211_CHAN_WIDTH_160]     =3D CHNL_BW_160,
+       [NL80211_CHAN_WIDTH_5]       =3D CHNL_BW_20,
+       [NL80211_CHAN_WIDTH_10]      =3D CHNL_BW_20,
+};
+
+u8 width_to_bw(enum nl80211_chan_width width)
+{
+       if (width <=3D NL80211_CHAN_WIDTH_10)
+               return nl_width_to_phy_bw[width];
+
+       return NL80211_CHAN_WIDTH_20;
+}
+
+static const int phy_bw_to_nl_width[] =3D {
+       [CHNL_BW_20]  =3D NL80211_CHAN_WIDTH_20,
+       [CHNL_BW_40]  =3D NL80211_CHAN_WIDTH_40,
+       [CHNL_BW_80]  =3D NL80211_CHAN_WIDTH_80,
+       [CHNL_BW_160] =3D NL80211_CHAN_WIDTH_160,
+};
+
+enum nl80211_chan_width bw_to_width(u8 bw)
+{
+       if (bw < CHNL_BW_MAX)
+               return phy_bw_to_nl_width[bw];
+
+       return CHNL_BW_20;
+}
+
+bool cl_is_valid_auth_mode(bool is_wpa, u8 auth_mode)
+{
+       return is_wpa ? (auth_mode <=3D CL_AKM_SUITE_PSK) :
+               (auth_mode <=3D CL_AKM_SUITE_FT_FILS_SHA384);
+}
+
+bool cl_is_open_auth_mode(u8 auth_mode)
+{
+       return auth_mode =3D=3D CL_AKM_SUITE_OPEN;
+}
+
+u64 cl_get_tsf_u64(struct cl_hw *cl_hw)
+{
+       u32 tsf_low =3D mac_hw_tsf_lo_get(cl_hw);
+       u32 tsf_high =3D mac_hw_tsf_hi_get(cl_hw);
+       u64 tsf;
+
+       if (tsf_low > CL_TSF_LOW_MIGHT_OVERFLOW_TH) {
+               u32 tmp_tsf_low =3D mac_hw_tsf_lo_get(cl_hw);
+
+               /* Overflow of tsf_low occurred */
+               if (tmp_tsf_low < 0xFFFFF000)
+                       tsf_high++;
+       }
+
+       tsf =3D ((u64)tsf_high << 32) | (u64)tsf_low;
+
+       return tsf;
+}
+
+u8 cl_center_freq_offset(u8 bw)
+{
+       if (bw =3D=3D CHNL_BW_160)
+               return 70;
+
+       if (bw =3D=3D CHNL_BW_80)
+               return 30;
+
+       if (bw =3D=3D CHNL_BW_40)
+               return 10;
+
+       return 0;
+}
+
+u8 max_bw_idx(u8 wrs_mode, bool is_24g)
+{
+       if (wrs_mode < WRS_MODE_HT)
+               return CHNL_BW_20 + 1;
+
+       if (wrs_mode =3D=3D WRS_MODE_HT || is_24g)
+               return CHNL_BW_40 + 1;
+
+       return CHNL_BW_MAX;
+}
+
+bool cl_hw_mode_is_b_or_bg(struct cl_hw *cl_hw)
+{
+       return (cl_hw->conf->ha_hw_mode =3D=3D HW_MODE_B ||
+               cl_hw->conf->ha_hw_mode =3D=3D HW_MODE_BG);
+}
+
+void cl_snprintf(char **buf, int *offset, size_t *size, const char *fmt, .=
..)
+{
+       void *new_buf =3D NULL;
+       va_list args;
+       u16 str_len =3D strlen(fmt);
+       u16 new_size;
+
+       if (!*buf) {
+               *size =3D PAGE_SIZE;
+               *buf =3D kzalloc(*size, GFP_KERNEL);
+               if (!*buf) {
+                       pr_err("Buffer allocation failed (%u)\n", (u32)*siz=
e);
+                       return;
+               }
+       }
+
+       /* Additional space is required */
+       if (str_len > *size - *offset) {
+               new_size =3D *size * 2;
+               new_buf =3D kvzalloc(new_size, GFP_KERNEL);
+               if (new_buf) {
+                       *size =3D new_size;
+                       memcpy(new_buf, *buf, strlen(*buf));
+                       kvfree(*buf);
+                       *buf =3D new_buf;
+               } else {
+                       pr_err("Buffer allocation failed (%u)\n", (u32)*siz=
e);
+                       return;
+               }
+       }
+
+       va_start(args, fmt);
+       *offset +=3D vsnprintf(*buf + *offset, *size, fmt, args);
+       va_end(args);
+}
+
+bool cl_is_eapol(struct sk_buff *skb)
+{
+       struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
+       __le16 fc =3D hdr->frame_control;
+       unsigned int hdrlen =3D 0;
+       unsigned short ethertype =3D 0;
+       u8 *temp =3D NULL;
+
+       /* Find the wireless header size */
+       hdrlen =3D ieee80211_has_a4(fc) ? 30 : 24;
+
+       if (ieee80211_is_data_qos(fc)) {
+               hdrlen +=3D IEEE80211_QOS_CTL_LEN;
+
+               if (ieee80211_has_order(fc))
+                       hdrlen +=3D IEEE80211_HT_CTL_LEN;
+       }
+
+       /* Skip wireless header */
+       temp =3D (u8 *)(skb->data + hdrlen);
+
+       /* Skip LLC and SNAP header */
+       if (PKT_HAS_LLC_HDR(temp))
+               ethertype =3D get_ether_type(LENGTH_LLC + LENGTH_SSNAP - 2,=
 temp);
+
+       return (ethertype =3D=3D ETH_P_PAE) ? true : false;
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

