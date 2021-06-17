Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1FD3AB8B5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhFQQJ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:56 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:25895
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231359AbhFQQIo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GB420Hug63GGBT+rZeARvs11yCNZZ3CqjinsgI8ztqGRTFXpJKUA0A/tq5IEoMBfoQ1oytlaZy4EyTifI5wODRXa+eJ1EvQM2vxipSoLcpC9Kr+qB/7HEJr1YakbfxUBuhXc9YpnlabwYRDi2ZZqjuZL9lKVwZK8zTeNGLaEvhsmAE0vZk7dEQTDEJ5tBQ4ZNQJEeQkAq+fIkB+zO/jQdfmVC0TKoDXPH/RHz7O+bd2ZR6OG44MrtQDZ1izbDJ/XTDgQ3pMao37d4Va4GxOgoHVcb6MFgW8QLLqZeOdraDGPbdhH/AiLq3Aeytyw4oito3lWLXB48oevwICXcrGK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGQnrjiPruHw668xAocl4HnllWb+EoZhdXPaTaTywq4=;
 b=mfWIFDsJc4YyVoq/wvgEphvIG2KCYgHGV2/Dvyof9+JeJX45jz2KH85QareBuKCfUdEobI7vHiVxrsHoZflAfifg5FQMbtlEYl/oZQMH4GQNnOZ6kkfluFB2zpZ1PmXJjORgn+u/ny3z9tieLv9C4X3hZ7/QqriBuknAkwMyzllcSkeTvh0V2o+rPRQQrlN4vkioMFEsySDOWK8eTq2l1P5DBM8N6ho5bZ7RQweEDWXSQ/cnBPb72TwyTR1xT1XWktQUExTj1MQMiphYJyqRCAllyJYbNW2bO1hL+6uLnA5+wmcjIwCw5ODQkOpkCzQG3gMtUE0woGoqcAN/xTGX1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGQnrjiPruHw668xAocl4HnllWb+EoZhdXPaTaTywq4=;
 b=eVyp4jXJ8fSrZG2N+o38/gOLxUXcf9PFld13cNpQRydNy3g7iGMtVU/ChZuZkWk64vObGKQADdPb6ue0Vnh7NEOX79qqRsruKjG7Ox0Ys+ZlpuF0NAdMQf7H9/b+2jspZpUO4b42gyMzRpOsd95iG811vx2hhHPRKe5hLj6UJ3g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1059.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:51 +0000
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
Subject: [RFC v1 143/256] cl8k: add rate_ctrl.c
Date:   Thu, 17 Jun 2021 16:00:30 +0000
Message-Id: <20210617160223.160998-144-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d590eb9-5275-425a-9e4b-08d931a9afcb
X-MS-TrafficTypeDiagnostic: AM8P192MB1059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1059ECED1686214E159AFD03F60E9@AM8P192MB1059.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hb7jgwHtF1T+6c1M+ieNdycLukvJKiNlSAuU2xqe26EC5WufKJAVZ4V08xlVI3CAbdccRyR3CrQuhbMLJLrTXC98+nUZrXez7cc8gpvhY3HzrN+s2aL2OPeleejZCaKhbeWPCjdNuTNKNOpRBPKtHEJWHhbKZerpM6NK6O4vUtQZ8Op1QWvqpVkt3s5PyOLpSEjCgxMFxzdowOJ399khImh26MUuQ4NPatNtdF/scIDYn6wLfgWL0hsWOEDI43co82frWHu3JXc32Wk1GJk0HOOiGtODqtpYRCcABZGmnROQY0VWKwWY4IG4/YWp7nkizkuoVhZ7wh6j41a2cKe1JIuDxrq3+HurouDd/diaZKh7ShdIKaZ8ef5qtyJE8MmUDD9upC2jnsskLHraEs5z0sXcQ0BMcl9m1lhqVYgPbNEJXb9vWmvFCNqD3AkVqcNIc8ognqPwh4imCSOdf13Fupg7F4Dwsb/q5QMty88ymsskWxGPmz86fFXsL62QYF7z6Dj0ENW96Kd7M3WGWJVLAtmjC1pY3/V85Nit3Ak2XwM6POXZZBPyFhUihqgdklkZLVJUrgLhrSEwgYJkTUOQ5SZgkiAu42qmG4BYWu9Kw+6+krlzmJ/pP83NF0SMCQVx0rt7diyDV6cpu8emQG/XDS2gmMm7mTuxVBizg14GCvFiOCp+paJgqh0Acicv26bU0ElxZE675DrnYs2EGUaG4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(26005)(956004)(498600001)(186003)(66556008)(16526019)(107886003)(66946007)(66476007)(8936002)(6916009)(2616005)(1076003)(2906002)(54906003)(6506007)(6666004)(4326008)(38100700002)(38350700002)(83380400001)(9686003)(6512007)(5660300002)(6486002)(86362001)(55236004)(36756003)(52116002)(8676002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pLdawf4SNSLBALghtSgmOSB80pqDL6bvraOZfM+S8sWTbxpg6WwLbZ0kD9TD?=
 =?us-ascii?Q?rgFgrjAI2uNrrxpRGVrMfwKmgyx2keARQhFeGKntTjW3Ur0wyN/XsD8EHp/f?=
 =?us-ascii?Q?sFkSW1Uv+zq0EEgXYRd12uQF4fSgqX2fBrvAOg8mWRpFkS9+USWGIZaJ/d7a?=
 =?us-ascii?Q?ao5VsKyRAUAON2iJeXk74BeNKnB2ICd3114Q/FrY7CrRZtIK/wDHgR2HKS7R?=
 =?us-ascii?Q?m5rH7njBZTAFtff49mRN7BAA+LLlsgpwobYomV/ne/Uae4KFBDwlUQtq19DA?=
 =?us-ascii?Q?I7sdBZtRBt/JRQ8z/V/dcRKuFOvhC36FyWK2xekZmPEO+hDZDzW+QSSmN2Nr?=
 =?us-ascii?Q?CA6VL9/sp3J2zez5reanyTs5Rq9i0pdf3QFn6iUnZ4E9fP+1fiyDRm2AET+T?=
 =?us-ascii?Q?lw1yG/ho1V5DzjohehNPEPur50Akqpl6u8bwVohZ3ZvCx0wliP5Ep2Mzs+sg?=
 =?us-ascii?Q?uUBDn+Mn1UN7MZhzqPlQJkytdb7ufKDu0vfs+rOE1Kh+ddNjAilccR3F+1Vy?=
 =?us-ascii?Q?1JI9qYvKmX6kAlt7DzN4l2dtrEKBFAIiCqDjipU43zUzOxPK+sf1DUv6if6g?=
 =?us-ascii?Q?XZGf9qkohuvNB3qZGeWGmVHiAVYVPmjFJQIKOkLhPOxNmeX0XObV0nyL9IDK?=
 =?us-ascii?Q?EDPCy3KrD9TBzxy5sEmg9OC08wFlKyJxSHOnr4J1LGWeBkJJPWeg2NM5hpsD?=
 =?us-ascii?Q?32Uc28cadm4Rezlm9vuWr5yTWr6N8ZBdhe+P5ZwM/oUM1SajnXI5XP6pZ+3L?=
 =?us-ascii?Q?HyWklH7e/g96szAwEZXqE9wjnVuJDx1NPHSU5AhVBcrLV8WcAhzP90kWDeFQ?=
 =?us-ascii?Q?4pGzPWxxAt2C9YebAG24qg1TecUZxeH0vqsLaismFqw1Crqyv9HjJciGp2/X?=
 =?us-ascii?Q?Rx6OJRNpj5KPpv0JoNGM8bnqfy+1mRW+NGBEsi+3+MpUqWvq2OegCC+qbpIc?=
 =?us-ascii?Q?UYxHKCGgHrJYd/cuysTOmi5XVzSZQcvoewQdQicDBRJPFAfrirYTN0VJ7MSd?=
 =?us-ascii?Q?FAjDeBtCxlwL6Nrs/db1kC50+plpjsFC/pS9XF4rV5+MxGNacOuUsJ7RtXBv?=
 =?us-ascii?Q?JobhaKBE+wL+maqQ392VHT9j2o/8O8ywS+WhhZmOhu6Jnpvc+BtjgbN1X8YQ?=
 =?us-ascii?Q?n6GzslF0socPOzyWzJWCK5B0Xl79DSJD0IFbuNR+ZeuRitZSDk5qSocgjfoR?=
 =?us-ascii?Q?zTPITKu1AMLQsxM9qKPN4/k8BeGSQ5blYS0EL6n2FmpFOOiNKVjvRLmHAxed?=
 =?us-ascii?Q?Pxnz6sNuRanHZ2565uF+mgCgE4zx86ydT3gmUimDPUN8nOyLUYggJdJbf/Lq?=
 =?us-ascii?Q?XlD+RKJ4DoeowNsSGTOVWEmB?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d590eb9-5275-425a-9e4b-08d931a9afcb
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:12.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gh8k3xg9ueZ5DpsmiJv7alN/I51FyCKbI19QQFIe8Doo26BbnkVNIgwi4TA31cOT52mxZSo6+NS5/mJ1HUjn4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rate_ctrl.c | 276 +++++++++++++++++++
 1 file changed, 276 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rate_ctrl.c

diff --git a/drivers/net/wireless/celeno/cl8k/rate_ctrl.c b/drivers/net/wir=
eless/celeno/cl8k/rate_ctrl.c
new file mode 100644
index 000000000000..960ca4ea4473
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rate_ctrl.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "rate_ctrl.h"
+#include "tx/tx.h"
+#include "band.h"
+#include "bf.h"
+#include "fw/msg_tx.h"
+#include "utils/utils.h"
+
+u32 cl_rate_ctrl_generate(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                         u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi,
+                         bool fallback_en)
+{
+       union cl_rate_ctrl_info rate_ctrl_info;
+
+       rate_ctrl_info.word =3D 0;
+
+       /* Format_mod + mcs_index */
+       if (mode =3D=3D WRS_MODE_HE) {
+               rate_ctrl_info.field.mcs_index =3D (nss << 4) | mcs;
+               rate_ctrl_info.field.format_mod =3D FORMATMOD_HE_SU;
+       } else if (mode =3D=3D WRS_MODE_VHT) {
+               rate_ctrl_info.field.mcs_index =3D (nss << 4) | mcs;
+               rate_ctrl_info.field.format_mod =3D FORMATMOD_VHT;
+       } else if (mode =3D=3D WRS_MODE_HT) {
+               rate_ctrl_info.field.mcs_index =3D (nss << 3) | mcs;
+               rate_ctrl_info.field.format_mod =3D FORMATMOD_HT_MF;
+       } else if (mode =3D=3D WRS_MODE_OFDM) {
+               rate_ctrl_info.field.mcs_index =3D mcs + RATE_CTRL_OFFSET_O=
FDM;
+               rate_ctrl_info.field.format_mod =3D
+                       (bw =3D=3D CHNL_BW_20) ? FORMATMOD_NON_HT : FORMATM=
OD_NON_HT_DUP_OFDM;
+       } else { /* WRS_MODE_CCK */
+               rate_ctrl_info.field.mcs_index =3D mcs;
+               rate_ctrl_info.field.format_mod =3D FORMATMOD_NON_HT;
+       }
+
+       /* Gi */
+       rate_ctrl_info.field.gi =3D convert_gi_format_wrs_to_fw(mode, gi);
+
+       /* Bw */
+       rate_ctrl_info.field.bw =3D bw;
+
+       /* Fallback */
+       rate_ctrl_info.field.fallback =3D fallback_en;
+
+       /* Tx_bf */
+       if (cl_sta && cl_bf_is_on(cl_hw, cl_sta, nss))
+               rate_ctrl_info.field.tx_bf =3D true;
+
+       /* Pre_type/stbc */
+       if (rate_ctrl_info.field.format_mod =3D=3D FORMATMOD_NON_HT)
+               rate_ctrl_info.field.pre_type_or_stbc =3D 1;
+
+       return rate_ctrl_info.word;
+}
+
+void cl_rate_ctrl_convert(union cl_rate_ctrl_info *rate_ctrl_info)
+{
+       u32 format_mod =3D rate_ctrl_info->field.format_mod;
+
+       /*
+        * Convert gi from firmware format to driver format
+        * !!! Must be done before converting the format mode !!!
+        */
+       rate_ctrl_info->field.gi =3D convert_gi_format_fw_to_wrs(format_mod=
,
+                                                              rate_ctrl_in=
fo->field.gi);
+
+       /* Convert format_mod from firmware format to WRS format */
+       if (format_mod >=3D FORMATMOD_HE_SU) {
+               rate_ctrl_info->field.format_mod =3D WRS_MODE_HE;
+       } else if (format_mod =3D=3D FORMATMOD_VHT) {
+               rate_ctrl_info->field.format_mod =3D WRS_MODE_VHT;
+       } else if (format_mod >=3D FORMATMOD_HT_MF) {
+               rate_ctrl_info->field.format_mod =3D WRS_MODE_HT;
+       } else if (format_mod =3D=3D FORMATMOD_NON_HT_DUP_OFDM) {
+               rate_ctrl_info->field.format_mod =3D WRS_MODE_OFDM;
+       } else {
+               if (rate_ctrl_info->field.mcs_index >=3D RATE_CTRL_OFFSET_O=
FDM)
+                       rate_ctrl_info->field.format_mod =3D WRS_MODE_OFDM;
+               else
+                       rate_ctrl_info->field.format_mod =3D WRS_MODE_CCK;
+       }
+}
+
+void cl_rate_ctrl_parse(union cl_rate_ctrl_info *rate_ctrl_info, u8 *nss, =
u8 *mcs)
+{
+       switch (rate_ctrl_info->field.format_mod) {
+       case WRS_MODE_HE:
+       case WRS_MODE_VHT:
+               *nss =3D (rate_ctrl_info->field.mcs_index >> 4);
+               *mcs =3D (rate_ctrl_info->field.mcs_index & 0xF);
+               break;
+       case WRS_MODE_HT:
+               *nss =3D (rate_ctrl_info->field.mcs_index >> 3);
+               *mcs =3D (rate_ctrl_info->field.mcs_index & 0x7);
+               break;
+       case WRS_MODE_OFDM:
+               *nss =3D 0;
+               *mcs =3D rate_ctrl_info->field.mcs_index - RATE_CTRL_OFFSET=
_OFDM;
+               break;
+       case WRS_MODE_CCK:
+               *nss =3D 0;
+               *mcs =3D rate_ctrl_info->field.mcs_index;
+               break;
+       default:
+               *nss =3D *mcs =3D 0;
+       }
+}
+
+void cl_rate_ctrl_set_default(struct cl_hw *cl_hw)
+{
+       u32 rate_ctrl =3D 0;
+       union cl_rate_ctrl_info_he rate_ctrl_he;
+
+       /* HE default */
+       rate_ctrl_he.word =3D 0;
+       rate_ctrl_he.field.spatial_conf =3D RATE_CNTRL_HE_SPATIAL_CONF_DEF;
+       rate_ctrl =3D cl_rate_ctrl_generate(cl_hw, NULL, WRS_MODE_HE,
+                                         0, 0, 0, 0, false);
+
+       cl_msg_tx_update_rate_dl(cl_hw, 0xff, rate_ctrl, 0, 0,
+                                RATE_OP_MODE_DEFAULT_HE, LTF_X4, 0, rate_c=
trl_he.word);
+
+       /* OFDM default */
+       rate_ctrl =3D cl_rate_ctrl_generate(cl_hw, NULL, WRS_MODE_OFDM, 0, =
0,
+                                         cl_hw->conf->ce_default_mcs_ofdm,=
 0, false);
+
+       cl_msg_tx_update_rate_dl(cl_hw, 0xff, rate_ctrl, 0, 0,
+                                RATE_OP_MODE_DEFAULT_OFDM, 0, 0, 0);
+
+       /* CCK default */
+       if (cl_band_is_24g(cl_hw)) {
+               rate_ctrl =3D cl_rate_ctrl_generate(cl_hw, NULL, WRS_MODE_C=
CK, 0, 0,
+                                                 cl_hw->conf->ce_default_m=
cs_cck, 0, false);
+
+               cl_msg_tx_update_rate_dl(cl_hw, 0xff, rate_ctrl, 0, 0,
+                                        RATE_OP_MODE_DEFAULT_CCK, 0, 0, 0)=
;
+       }
+}
+
+void cl_rate_ctrl_set_default_per_he_minrate(struct cl_hw *cl_hw, u8 bw,
+                                            u8 nss, u8 mcs, u8 gi)
+{
+       union cl_rate_ctrl_info_he rate_ctrl_he;
+       u32 rate_ctrl =3D 0;
+       u8 ltf =3D cl_map_gi_to_ltf(WRS_MODE_HE, gi);
+
+       rate_ctrl_he.word =3D 0;
+       rate_ctrl_he.field.spatial_conf =3D RATE_CNTRL_HE_SPATIAL_CONF_DEF;
+       rate_ctrl =3D cl_rate_ctrl_generate(cl_hw, NULL, WRS_MODE_HE, bw,
+                                         nss, mcs, gi, false);
+
+       cl_msg_tx_update_rate_dl(cl_hw, 0xff, rate_ctrl, 0, 0,
+                                RATE_OP_MODE_DEFAULT_HE, ltf,
+                                0, rate_ctrl_he.word);
+
+       cl_msg_tx_update_rate_dl(cl_hw, 0xff, rate_ctrl, 0, 0,
+                                RATE_OP_MODE_MCAST, ltf, 0, 0);
+
+       cl_msg_tx_update_rate_dl(cl_hw, 0xff, rate_ctrl, 0, 0,
+                                RATE_OP_MODE_BCAST, ltf, 0, 0);
+}
+
+bool cl_rate_ctrl_set_mcast(struct cl_hw *cl_hw, u8 mode, u8 mcs)
+{
+       u32 rate_ctrl_mcast =3D cl_rate_ctrl_generate(cl_hw, NULL, mode, 0,=
 0, mcs,
+                                                   WRS_GI_LONG, false);
+       u8 ltf =3D cl_map_gi_to_ltf(mode, WRS_GI_LONG);
+
+       if (cl_msg_tx_update_rate_dl(cl_hw, 0xff, rate_ctrl_mcast, 0, 0,
+                                    RATE_OP_MODE_MCAST, ltf, 0, 0))
+               return false;
+
+       return true;
+}
+
+bool cl_rate_ctrl_set_fixed(struct cl_hw *cl_hw, u32 rate_ctrl_he, u8 mode=
, u8 mcs, u8 nss,
+                           u8 bw, u8 gi, u8 ltf_field)
+{
+       u32 rate_ctrl_fixed =3D cl_rate_ctrl_generate(cl_hw, NULL, mode, bw=
, nss,
+                                                   mcs, gi, false);
+
+       if (cl_msg_tx_update_rate_dl(cl_hw, 0xff, rate_ctrl_fixed, 0, bw, R=
ATE_OP_MODE_FIXED,
+                                    ltf_field, 0, rate_ctrl_he))
+               return false;
+
+       return true;
+}
+
+bool cl_rate_ctrl_set_dbgfs(struct cl_hw *cl_hw, u8 sta_idx, u32 rate_ctrl=
, u32 rate_ctrl_he,
+                           u8 op_mode, u8 bw, u8 ltf_field)
+{
+       /*
+        * op_mode can be RATE_OP_MODE_FIXED or RATE_OP_MODE_STA_MU.
+        * Therefore rate_fallback should be 0.
+        */
+       if (cl_msg_tx_update_rate_dl(cl_hw, sta_idx, rate_ctrl, 0, bw, op_m=
ode,
+                                    ltf_field, 0, rate_ctrl_he))
+               return false;
+
+       return true;
+}
+
+void cl_rate_ctrl_set_ate_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       struct cl_ate_db *ate_db =3D &cl_hw->ate_db;
+       union cl_rate_ctrl_info rate_ctrl;
+       union cl_rate_ctrl_info_he rate_ctrl_he;
+       u8 ltf_mode =3D cl_map_gi_to_ltf(ate_db->mode, ate_db->gi);
+       u8 sta_idx =3D cl_sta->sta_idx;
+
+       rate_ctrl_he.word =3D 0;
+       rate_ctrl_he.field.spatial_conf =3D RATE_CNTRL_HE_SPATIAL_CONF_DEF;
+
+       rate_ctrl.word =3D cl_rate_ctrl_generate(cl_hw, cl_sta, ate_db->mod=
e, ate_db->bw,
+                                              ate_db->nss, ate_db->mcs, at=
e_db->gi, false);
+
+       cl_msg_tx_update_rate_dl(cl_hw, sta_idx, rate_ctrl.word, 0, ate_db-=
>bw,
+                                RATE_OP_MODE_STA_SU, ltf_mode, 0, rate_ctr=
l_he.word);
+}
+
+static u8 cl_rate_ctrl_get_min(struct cl_hw *cl_hw)
+{
+       if (cl_hw->conf->ci_min_he_en &&
+           cl_hw->conf->ce_wireless_mode =3D=3D WIRELESS_MODE_HE)
+               return RATE_CTRL_ENTRY_MIN_HE;
+
+       if (cl_hw_mode_is_b_or_bg(cl_hw))
+               return RATE_CTRL_ENTRY_MIN_CCK;
+
+       return RATE_CTRL_ENTRY_MIN_OFDM;
+}
+
+void cl_rate_ctrl_update_desc_single(struct cl_hw *cl_hw, struct tx_host_i=
nfo *info,
+                                    struct cl_sw_txhdr *sw_txhdr)
+{
+       struct ieee80211_hdr *mac_hdr =3D sw_txhdr->hdr80211;
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(sw_txhdr->sk=
b);
+       bool is_data =3D ieee80211_is_data(sw_txhdr->fc);
+
+       if (sw_txhdr->cl_sta && is_data) {
+               if (cl_tx_ctrl_is_eapol(tx_info)) {
+                       info->rate_ctrl_entry =3D cl_rate_ctrl_get_min(cl_h=
w);
+               } else {
+                       if (cl_hw->entry_fixed_rate)
+                               info->rate_ctrl_entry =3D RATE_CTRL_ENTRY_F=
IXED_RATE;
+                       else
+                               info->rate_ctrl_entry =3D RATE_CTRL_ENTRY_S=
TA;
+               }
+       } else {
+               if (sw_txhdr->is_bcn) {
+                       info->rate_ctrl_entry =3D cl_rate_ctrl_get_min(cl_h=
w);
+               } else if (is_multicast_ether_addr(mac_hdr->addr1) &&
+                          !is_broadcast_ether_addr(mac_hdr->addr1)) {
+                       info->rate_ctrl_entry =3D RATE_CTRL_ENTRY_MCAST;
+               } else if (is_broadcast_ether_addr(mac_hdr->addr1) &&
+                          !cl_hw->entry_fixed_rate) {
+                       info->rate_ctrl_entry =3D RATE_CTRL_ENTRY_BCAST;
+               } else {
+                       if (cl_hw->entry_fixed_rate && is_data)
+                               info->rate_ctrl_entry =3D RATE_CTRL_ENTRY_F=
IXED_RATE;
+                       else
+                               info->rate_ctrl_entry =3D cl_rate_ctrl_get_=
min(cl_hw);
+               }
+       }
+}
+
+void cl_rate_ctrl_update_desc_agg(struct cl_hw *cl_hw, struct tx_host_info=
 *info)
+{
+       /* For aggregation there are only two options - STA and FIXED_RATE =
*/
+       if (cl_hw->entry_fixed_rate)
+               info->rate_ctrl_entry =3D RATE_CTRL_ENTRY_FIXED_RATE;
+       else
+               info->rate_ctrl_entry =3D RATE_CTRL_ENTRY_STA;
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

