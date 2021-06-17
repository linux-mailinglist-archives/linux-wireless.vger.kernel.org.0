Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B9E3AB8FF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhFQQLr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:47 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:4749
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232129AbhFQQKa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1FEWzYfOyjnd17c+1/9M3WgMfS+teIuzhftIkRheiXc/Vx2MbeqVdq7S5fMxS8JHD+UuoO0RbJVXEdcM2n+lnqeiDYS2zm1u1GpOBAi3HLzIXLxw2rUz3yJM4JALdBnOuBPbt1HF4TxgWupS4BcsWR5+PPzNj7EZg+UcJibgmgKnUkfksSZ8NSGC/gEZshcBac342SGuTiopRMGNegz2w6nmcZ90xaHxodIxW0nmvvv7z48/4Meg3yOiJDC4Z6jYAvGXrLJnY4dXdOFGb3nfuVJ22AU7It+NrxRwJ68tBMDXLGo7XN3b+cu02oplLAexwLI1loRDrjOftb4jftzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fU2rhD4z+EepFi4xqi6qkxyiLsYUAg/bo+zPqts/HY=;
 b=jEOkEDdjZzwoFR6ZkAwsXc1xL7dgDwOaTZpl0lrW00eS44B8cAyfjEkmgmyf46WplIeiuiktzhZm5Ctd2ODVCHut83QKzEpZnWI3zkV89srZ72W1nrFv1cXT27NuO3jYQwBzGDjLM9X+GN/WTUdkQ2ZB1GwqS6ymUjFJs4fKbzFpw3yPspwWLvr8wQwQUNx5929nvAljhNqvzaVudCX9CG+bGIiLhtNpgiVj6mrDvhwYQcU5WkRHG+cgqsHOjNJYaUg+aVqX9z4A0PIUC3V5wv1UldJA7zkpGcpbJg1yCnp14MBXC3Xi0LPZ+xNelcuap342hDzfa56WOY/gLa9O5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fU2rhD4z+EepFi4xqi6qkxyiLsYUAg/bo+zPqts/HY=;
 b=FGb2/UbNobtoxJlrzQKy3wHINGWA8Uhju8gjaUOSrNuLOq+bjll+P67MlHaDo745gc8y2OKhtwvF80Ze1SD+Es04lee+4FtFv4k1/jZssAv5p5FnspbCTw0yPW47XhnG8TKMo1yOVmj4lSQnfMlBCLmaoScB55U0UStNNRulj2Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:29 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:29 +0000
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
Subject: [RFC v1 163/256] cl8k: add reg/reg_ricu.h
Date:   Thu, 17 Jun 2021 16:00:50 +0000
Message-Id: <20210617160223.160998-164-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c476d5b-0ef7-42b7-7846-08d931a9bc1f
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1187C29F14C20A9ED02684E7F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBxgudPxn1uJLmLrg82RJh95rr0IDr4og838ciowW5ozKK/P6CAAXOuKUddWJFgW+l00XHTwsk98SecEz6ukxVmVBEGBGGhD5m3JNndVi7pHzagb1BA3UCFZH3ibfiRBNx3DB39zkvS1wu7OvJXemTc48x7B4cYye4AkqCWGMZwaHVusN1zZSmT4YF2SZcqj4fp6CHLHCqtSUw6/utkvzA11yc5iiCAqwYhjM/hw6pfTZNCP6aMYF9N26J1lF+rTKQVfGksdEuQ0ukObtkYbMAP4x5I9899+em6PVPYDgjFZmUnWRagadLutmLRaSbOlKsSnDNqcTuDybEKzRmgxgRpw5MfGXXJlz4lftkpBm6GJ83/+L/gHVMVZYWGD0yCDDrZPAvmHQJK1a0s51x/y4bF/YnjME4/Ny6AK8j1gBURJG2X6An0eaLrTlgIsNpCgbOnMb2rjZNs3WxBlWha7uovbym0TNRZZbP69Bou33w8nYTAKXUwyi2kWHjf+k8ecinVO7sr3JmU4U3g45EhOHQKS/dKuhmdqHjJhYuNr2y3WQyt5Z1gfcxiuMYEGqLgU/dhGpu2hhA3e3FIFw7RK5kWl5ZAIb7Z7dRcSXrQLsLiOr0KIAAPxuIwURxZBYUliM7dJFaejMbYgENwmr0Ef5ByVDR5Ux2wbsq6CMrlMCg4T2jPYeDsfpK/6uPILhc86uJLyMg0XcyrSa/TjayN7AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(66574015)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(30864003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q+IST03J3C0FD25XiZ+t17BBOwOICwZjLKMTg6Ly9OVoecroEYSdXyDKLEGC?=
 =?us-ascii?Q?OzwiPDnBVpwMKzBTdb26gjdKq4bMDa86ZncO0qZBkLxxV/yBMZtJ9a56ZBz2?=
 =?us-ascii?Q?XmEzaafFlFoCmCTrKB0MBFzRswwVX9zDLl518sOSsfcEGDAHU2rHdvOwFZaz?=
 =?us-ascii?Q?TsE0WXxNeRbEQx2mRurWFjpqMM45DGy+yb19ObX4sGZsPYub2t6p8RBCsEu5?=
 =?us-ascii?Q?jVAZyZaCsY5/t6FPsjnnbMpn/G+CvkfwHGye6jOyGoGNaElypepDE3fq0HmT?=
 =?us-ascii?Q?IaonBPEUDpkjmmFbRxtYqwMFCKZcWuTexsIj5B4sHMtL5ZHxl/ZYcGeOwrdh?=
 =?us-ascii?Q?AnDyh3lnvptWTZdNbvJ/iHJwQCW8mTnbJNVhesuhisgFql4sEkRU0Ubs/mc9?=
 =?us-ascii?Q?DNC3nTvSP0F3EE5LwOjJZ5tsCJO9pQPBJ86i2/L40ABV7VudnlPJcCCf7+Wr?=
 =?us-ascii?Q?/fQ6MV+PbT33FUSGjyhsIAyi99eFDQyq8OAmg1Nyb1+MnDu5GiyXp4UkOhSU?=
 =?us-ascii?Q?tRHwwVGqGx+z9uhIrFW5L7w9oIpP6XeEb4hKKI8X12wN8k98c8jGlTDPm5Gq?=
 =?us-ascii?Q?FNalLTVKlmdivXsb0XHaAk2oaSxlMAclme/jzpEmffC6NIUnYAB552etiMYn?=
 =?us-ascii?Q?DFQA1cINl606tmRGT/lLrF3tXhB2B+v9u85mXB3wykkN2A/qkyYJE+KMz1BN?=
 =?us-ascii?Q?J2Gh64IfFMueWWy3RT+1wat//Isy4o3CaiIBUNRaGjnB/dhok67POU4q4WGp?=
 =?us-ascii?Q?HU1gErNTBQ+2m90iWEeGa4jPlq0iReHlrzGQetI/6Gygj/4+7oYcyJXxAJFp?=
 =?us-ascii?Q?aUBQg8bD80PBgSqui23Hr3X9f+PogbKPmPJJtGkcfU6QnPz7/bLAOIn5fKeN?=
 =?us-ascii?Q?+gjNrMt6srIO81uIeVwHMTEPvLBDFVNFmMquDKG287Zq6QFWqQkU/7htP6jH?=
 =?us-ascii?Q?pPXmgvREPwnOxU+2naRFKQpS+cqluwZVzajaEAawqhoLGVN7I1NidUzGd2mX?=
 =?us-ascii?Q?IgcWh7nzyCASAmdkn8YSwfATUuzAV565ifYcWv1Ay/ffggwI7c/az5M3bTm+?=
 =?us-ascii?Q?4+dtHunuT9Wg4PwBpbvLywX6GViHB3rQ+f0TwVpPy6MSTw6j4i6yta1ucyOA?=
 =?us-ascii?Q?eCIzFkNCZ+2LiPY7oCmfSzdP4A6uuT9prQ99zhuwe87KZpFI4V0mu4xcWF+7?=
 =?us-ascii?Q?LuCZxJQWRRDzc/ILLhupV26j5NFzytBgDcq9W3HpxWfQDp9bX7lvIpg5jnRr?=
 =?us-ascii?Q?PwRLad3lJ/nL5TwQwz0nfR2bWBuQVCg93GZ1AW+7HtSEBcqOdtBHgsd+FGKt?=
 =?us-ascii?Q?+XBUtKHOxcWcLaMtG9A1lQAa?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c476d5b-0ef7-42b7-7846-08d931a9bc1f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:32.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ljIh9zcI7u3AakxfSShWcyqMdG+A+0iek2tDrf4fqbGS8huQVbI4ymy4V6BG2uwwICtAnYJnkcSgOCqEuDv5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/reg/reg_ricu.h   | 1326 +++++++++++++++++
 1 file changed, 1326 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_ricu.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_ricu.h b/drivers/net/=
wireless/celeno/cl8k/reg/reg_ricu.h
new file mode 100644
index 000000000000..00e4759db751
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_ricu.h
@@ -0,0 +1,1326 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_RICU_H
+#define CL_REG_RICU_H
+
+#include "reg/reg_access.h"
+#include "chip.h"
+
+/*
+ * @brief STATIC_CONF_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30    ARB_ONESHOT_BYPASS        1
+ *    28    BTC_SEL                   0
+ *    27    CLK_SAVE_MODE             0
+ *    26    RF_RST_N_DEFAULT          0
+ *    25    RF_RST_N_REQ              0
+ *    24    FORCE_RSSI_ON             0
+ *    23:20 RSSI_M                    0x2
+ *    19:16 RSSI_N                    0x6
+ *    03:00 CDB_MODE_MAJ              0x0
+ * </pre>
+ */
+#define RICU_STATIC_CONF_0_ADDR        (REG_RICU_BASE_ADDR + 0x00000004)
+#define RICU_STATIC_CONF_0_OFFSET      0x00000004
+#define RICU_STATIC_CONF_0_INDEX       0x00000001
+#define RICU_STATIC_CONF_0_RESET       0x40260000
+
+static inline void ricu_static_conf_0_btc_sel_setf(struct cl_chip *chip, u=
8 btcsel)
+{
+       ASSERT_ERR_CHIP((((u32)btcsel << 28) & ~((u32)0x10000000)) =3D=3D 0=
);
+       cl_reg_write_chip(chip, RICU_STATIC_CONF_0_ADDR, (cl_reg_read_chip(=
chip, RICU_STATIC_CONF_0_ADDR) & ~((u32)0x10000000)) | ((u32)btcsel << 28))=
;
+}
+
+static inline void ricu_static_conf_0_rf_rst_n_req_setf(struct cl_chip *ch=
ip, u8 rfrstnreq)
+{
+       ASSERT_ERR_CHIP((((u32)rfrstnreq << 25) & ~((u32)0x02000000)) =3D=
=3D 0);
+       cl_reg_write_chip(chip, RICU_STATIC_CONF_0_ADDR, (cl_reg_read_chip(=
chip, RICU_STATIC_CONF_0_ADDR) & ~((u32)0x02000000)) | ((u32)rfrstnreq << 2=
5));
+}
+
+static inline u8 ricu_static_conf_0_cdb_mode_maj_getf(struct cl_chip *chip=
)
+{
+       u32 local_val =3D cl_reg_read_chip(chip, RICU_STATIC_CONF_0_ADDR);
+
+       return ((local_val & ((u32)0x0000000F)) >> 0);
+}
+
+static inline void ricu_static_conf_0_cdb_mode_maj_setf(struct cl_chip *ch=
ip, u8 cdbmodemaj)
+{
+       ASSERT_ERR_CHIP((((u32)cdbmodemaj << 0) & ~((u32)0x0000000F)) =3D=
=3D 0);
+       cl_reg_write_chip(chip, RICU_STATIC_CONF_0_ADDR, (cl_reg_read_chip(=
chip, RICU_STATIC_CONF_0_ADDR) & ~((u32)0x0000000F)) | ((u32)cdbmodemaj << =
0));
+}
+
+/*
+ * @brief AFE_CTL_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    PBIAS_CTRL_EN_LC          0
+ *    30    PBIAS_CTRL_EN             0
+ *    29    LRD_EN_LC                 0
+ *    28    LRD_EN                    0
+ *    27    LOCK_EN_LC                0
+ *    26    LOCK_EN                   1
+ *    25    EN_GPADC_CLK              0
+ *    24    EN_GPADC                  0
+ *    23    FEED_EN_LC                0
+ *    22    FEED_EN                   0
+ *    21    EN_CS                     1
+ *    20    EN_CML_GEN                1
+ *    18    EN_AFE_LDO                1
+ *    17    EN_ADC_CLK                1
+ *    15    AFC_ENB_LC                0
+ *    14    AFC_ENB                   0
+ *    13    CP_MODE_LC                1
+ *    12    BYPASS_LC                 0
+ *    11    BYPASS                    0
+ *    10    AFCINIT_SEL_LC            1
+ *    09    AFCINIT_SEL               1
+ *    08    EN_CLK_MON                0
+ *    07    EN_DAC_CLK                1
+ *    06    EN_CDB_DAC_CLK            0
+ *    05    EN_CDB_ADC_CLK            0
+ *    03    EN_CDB_GEN                0
+ *    02    DACCLK_PHASESEL           0
+ *    01    ADCCLK_PHASESEL           0
+ *    00    CDB_CLK_RESETB            0
+ * </pre>
+ */
+#define RICU_AFE_CTL_0_ADDR        (REG_RICU_BASE_ADDR + 0x00000010)
+#define RICU_AFE_CTL_0_OFFSET      0x00000010
+#define RICU_AFE_CTL_0_INDEX       0x00000004
+#define RICU_AFE_CTL_0_RESET       0x04362680
+
+static inline u32 ricu_afe_ctl_0_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, RICU_AFE_CTL_0_ADDR);
+}
+
+static inline void ricu_afe_ctl_0_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_0_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTL_0_PBIAS_CTRL_EN_LC_BIT    ((u32)0x80000000)
+#define RICU_AFE_CTL_0_PBIAS_CTRL_EN_LC_POS    31
+#define RICU_AFE_CTL_0_PBIAS_CTRL_EN_BIT    ((u32)0x40000000)
+#define RICU_AFE_CTL_0_PBIAS_CTRL_EN_POS    30
+#define RICU_AFE_CTL_0_LRD_EN_LC_BIT        ((u32)0x20000000)
+#define RICU_AFE_CTL_0_LRD_EN_LC_POS        29
+#define RICU_AFE_CTL_0_LRD_EN_BIT           ((u32)0x10000000)
+#define RICU_AFE_CTL_0_LRD_EN_POS           28
+#define RICU_AFE_CTL_0_LOCK_EN_LC_BIT       ((u32)0x08000000)
+#define RICU_AFE_CTL_0_LOCK_EN_LC_POS       27
+#define RICU_AFE_CTL_0_LOCK_EN_BIT          ((u32)0x04000000)
+#define RICU_AFE_CTL_0_LOCK_EN_POS          26
+#define RICU_AFE_CTL_0_EN_GPADC_CLK_BIT     ((u32)0x02000000)
+#define RICU_AFE_CTL_0_EN_GPADC_CLK_POS     25
+#define RICU_AFE_CTL_0_EN_GPADC_BIT         ((u32)0x01000000)
+#define RICU_AFE_CTL_0_EN_GPADC_POS         24
+#define RICU_AFE_CTL_0_FEED_EN_LC_BIT       ((u32)0x00800000)
+#define RICU_AFE_CTL_0_FEED_EN_LC_POS       23
+#define RICU_AFE_CTL_0_FEED_EN_BIT          ((u32)0x00400000)
+#define RICU_AFE_CTL_0_FEED_EN_POS          22
+#define RICU_AFE_CTL_0_EN_CS_BIT            ((u32)0x00200000)
+#define RICU_AFE_CTL_0_EN_CS_POS            21
+#define RICU_AFE_CTL_0_EN_CML_GEN_BIT       ((u32)0x00100000)
+#define RICU_AFE_CTL_0_EN_CML_GEN_POS       20
+#define RICU_AFE_CTL_0_EN_AFE_LDO_BIT       ((u32)0x00040000)
+#define RICU_AFE_CTL_0_EN_AFE_LDO_POS       18
+#define RICU_AFE_CTL_0_EN_ADC_CLK_BIT       ((u32)0x00020000)
+#define RICU_AFE_CTL_0_EN_ADC_CLK_POS       17
+#define RICU_AFE_CTL_0_AFC_ENB_LC_BIT       ((u32)0x00008000)
+#define RICU_AFE_CTL_0_AFC_ENB_LC_POS       15
+#define RICU_AFE_CTL_0_AFC_ENB_BIT          ((u32)0x00004000)
+#define RICU_AFE_CTL_0_AFC_ENB_POS          14
+#define RICU_AFE_CTL_0_CP_MODE_LC_BIT       ((u32)0x00002000)
+#define RICU_AFE_CTL_0_CP_MODE_LC_POS       13
+#define RICU_AFE_CTL_0_BYPASS_LC_BIT        ((u32)0x00001000)
+#define RICU_AFE_CTL_0_BYPASS_LC_POS        12
+#define RICU_AFE_CTL_0_BYPASS_BIT           ((u32)0x00000800)
+#define RICU_AFE_CTL_0_BYPASS_POS           11
+#define RICU_AFE_CTL_0_AFCINIT_SEL_LC_BIT    ((u32)0x00000400)
+#define RICU_AFE_CTL_0_AFCINIT_SEL_LC_POS    10
+#define RICU_AFE_CTL_0_AFCINIT_SEL_BIT      ((u32)0x00000200)
+#define RICU_AFE_CTL_0_AFCINIT_SEL_POS      9
+#define RICU_AFE_CTL_0_EN_CLK_MON_BIT       ((u32)0x00000100)
+#define RICU_AFE_CTL_0_EN_CLK_MON_POS       8
+#define RICU_AFE_CTL_0_EN_DAC_CLK_BIT       ((u32)0x00000080)
+#define RICU_AFE_CTL_0_EN_DAC_CLK_POS       7
+#define RICU_AFE_CTL_0_EN_CDB_DAC_CLK_BIT    ((u32)0x00000040)
+#define RICU_AFE_CTL_0_EN_CDB_DAC_CLK_POS    6
+#define RICU_AFE_CTL_0_EN_CDB_ADC_CLK_BIT    ((u32)0x00000020)
+#define RICU_AFE_CTL_0_EN_CDB_ADC_CLK_POS    5
+#define RICU_AFE_CTL_0_EN_CDB_GEN_BIT       ((u32)0x00000008)
+#define RICU_AFE_CTL_0_EN_CDB_GEN_POS       3
+#define RICU_AFE_CTL_0_DACCLK_PHASESEL_BIT    ((u32)0x00000004)
+#define RICU_AFE_CTL_0_DACCLK_PHASESEL_POS    2
+#define RICU_AFE_CTL_0_ADCCLK_PHASESEL_BIT    ((u32)0x00000002)
+#define RICU_AFE_CTL_0_ADCCLK_PHASESEL_POS    1
+#define RICU_AFE_CTL_0_CDB_CLK_RESETB_BIT    ((u32)0x00000001)
+#define RICU_AFE_CTL_0_CDB_CLK_RESETB_POS    0
+
+static inline void ricu_afe_ctl_0_pbias_ctrl_en_lc_setf(struct cl_chip *ch=
ip, u8 pbiasctrlenlc)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_0_ADDR, (cl_reg_read_chip(chip=
, RICU_AFE_CTL_0_ADDR) & ~((u32)0x80000000)) | ((u32)pbiasctrlenlc << 31));
+}
+
+static inline void ricu_afe_ctl_0_cdb_clk_resetb_setf(struct cl_chip *chip=
, u8 cdbclkresetb)
+{
+       ASSERT_ERR_CHIP((((u32)cdbclkresetb << 0) & ~((u32)0x00000001)) =3D=
=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTL_0_ADDR, (cl_reg_read_chip(chip=
, RICU_AFE_CTL_0_ADDR) & ~((u32)0x00000001)) | ((u32)cdbclkresetb << 0));
+}
+
+/*
+ * @brief AFE_CTL_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    14    VCO_BOOST                 0
+ *    13    SYS_ADCCLK_SEL            0
+ *    12    SOC_PHASE_SEL             1
+ *    11    SOC_CLK_SEL               1
+ *    10    RESETB_LC                 0
+ *    09    RESETB                    1
+ *    08    PBIAS_CTRL_LC             0
+ *    07    PBIAS_CTRL                0
+ *    06    GP_CLK_PHASESEL           0
+ *    05    FSEL_LC                   0
+ *    04    FSEL                      0
+ *    03    FOUT_MASK_LC              0
+ *    02    FOUT_MASK                 0
+ *    01    EXTCLK_SEL                0
+ *    00    EN_PLL_LDO                0
+ * </pre>
+ */
+#define RICU_AFE_CTL_1_ADDR        (REG_RICU_BASE_ADDR + 0x00000014)
+#define RICU_AFE_CTL_1_OFFSET      0x00000014
+#define RICU_AFE_CTL_1_INDEX       0x00000005
+#define RICU_AFE_CTL_1_RESET       0x00001A00
+
+static inline void ricu_afe_ctl_1_resetb_lc_setf(struct cl_chip *chip, u8 =
resetblc)
+{
+       ASSERT_ERR_CHIP((((u32)resetblc << 10) & ~((u32)0x00000400)) =3D=3D=
 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTL_1_ADDR, (cl_reg_read_chip(chip=
, RICU_AFE_CTL_1_ADDR) & ~((u32)0x00000400)) | ((u32)resetblc << 10));
+}
+
+static inline void ricu_afe_ctl_1_en_pll_ldo_setf(struct cl_chip *chip, u8=
 enpllldo)
+{
+       ASSERT_ERR_CHIP((((u32)enpllldo << 0) & ~((u32)0x00000001)) =3D=3D =
0);
+       cl_reg_write_chip(chip, RICU_AFE_CTL_1_ADDR, (cl_reg_read_chip(chip=
, RICU_AFE_CTL_1_ADDR) & ~((u32)0x00000001)) | ((u32)enpllldo << 0));
+}
+
+/*
+ * @brief AFE_CTL_2 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    23:22 LOCK_CON_REV_LC           0x0
+ *    21:20 LOCK_CON_REV              0x0
+ *    19:18 LOCK_CON_OUT_LC           0x3
+ *    17:16 LOCK_CON_OUT              0x3
+ *    15:14 LOCK_CON_IN_LC            0x3
+ *    13:12 LOCK_CON_IN               0x3
+ *    11:10 LOCK_CON_DLY_LC           0x3
+ *    09:08 LOCK_CON_DLY              0x3
+ *    07:06 ICP                       0x1
+ *    03:02 CTRL_IB                   0x2
+ *    01:00 CLK_MON_SEL               0x0
+ * </pre>
+ */
+#define RICU_AFE_CTL_2_ADDR        (REG_RICU_BASE_ADDR + 0x00000018)
+#define RICU_AFE_CTL_2_OFFSET      0x00000018
+#define RICU_AFE_CTL_2_INDEX       0x00000006
+#define RICU_AFE_CTL_2_RESET       0x000FFF48
+
+static inline void ricu_afe_ctl_2_lock_con_rev_lc_setf(struct cl_chip *chi=
p, u8 lockconrevlc)
+{
+       ASSERT_ERR_CHIP((((u32)lockconrevlc << 22) & ~((u32)0x00C00000)) =
=3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTL_2_ADDR, (cl_reg_read_chip(chip=
, RICU_AFE_CTL_2_ADDR) & ~((u32)0x00C00000)) | ((u32)lockconrevlc << 22));
+}
+
+/*
+ * @brief AFE_CTL_3 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:28 RSEL                      0x0
+ *    27:24 I_CSEL_LC                 0xc
+ *    23:20 GM_LC                     0xf
+ *    19:16 CSEL_LC                   0x3
+ *    15:12 CML_SEL                   0x9
+ *    11:09 S_LC                      0x0
+ *    08:06 S                         0x0
+ *    05:03 LBW_LC                    0x7
+ *    02:00 ICP_LC                    0x7
+ * </pre>
+ */
+#define RICU_AFE_CTL_3_ADDR        (REG_RICU_BASE_ADDR + 0x0000001C)
+#define RICU_AFE_CTL_3_OFFSET      0x0000001C
+#define RICU_AFE_CTL_3_INDEX       0x00000007
+#define RICU_AFE_CTL_3_RESET       0x0CF3903F
+
+static inline void ricu_afe_ctl_3_cml_sel_setf(struct cl_chip *chip, u8 cm=
lsel)
+{
+       ASSERT_ERR_CHIP((((u32)cmlsel << 12) & ~((u32)0x0000F000)) =3D=3D 0=
);
+       cl_reg_write_chip(chip, RICU_AFE_CTL_3_ADDR, (cl_reg_read_chip(chip=
, RICU_AFE_CTL_3_ADDR) & ~((u32)0x0000F000)) | ((u32)cmlsel << 12));
+}
+
+/*
+ * @brief AFE_CTL_5 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    23:18 MAIN_SEL_7_2              0x0
+ *    17:12 P_LC                      0x1
+ *    11:06 P                         0xA
+ *    05:00 CAP_BIAS_CODE_LC          0x4
+ * </pre>
+ */
+#define RICU_AFE_CTL_5_ADDR        (REG_RICU_BASE_ADDR + 0x00000024)
+#define RICU_AFE_CTL_5_OFFSET      0x00000024
+#define RICU_AFE_CTL_5_INDEX       0x00000009
+#define RICU_AFE_CTL_5_RESET       0x00001284
+
+static inline void ricu_afe_ctl_5_main_sel_7_2_setf(struct cl_chip *chip, =
u8 mainsel72)
+{
+       ASSERT_ERR_CHIP((((u32)mainsel72 << 18) & ~((u32)0x00FC0000)) =3D=
=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTL_5_ADDR, (cl_reg_read_chip(chip=
, RICU_AFE_CTL_5_ADDR) & ~((u32)0x00FC0000)) | ((u32)mainsel72 << 18));
+}
+
+/*
+ * @brief AFE_CTL_8 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    EN_REF7                   0
+ *    30    EN_REF6                   0
+ *    29    EN_REF5                   0
+ *    28    EN_REF4                   0
+ *    27    EN_REF3                   0
+ *    26    EN_REF2                   0
+ *    25    EN_REF1                   0
+ *    24    EN_REF0                   0
+ *    23    EN_EXT_LOAD7              0
+ *    22    EN_EXT_LOAD6              0
+ *    21    EN_EXT_LOAD5              0
+ *    20    EN_EXT_LOAD4              0
+ *    19    EN_EXT_LOAD3              0
+ *    18    EN_EXT_LOAD2              0
+ *    17    EN_EXT_LOAD1              0
+ *    16    EN_EXT_LOAD0              0
+ *    15    CH_CML_SEL7               0
+ *    14    CH_CML_SEL6               0
+ *    13    CH_CML_SEL5               0
+ *    12    CH_CML_SEL4               0
+ *    11    CH_CML_SEL3               0
+ *    10    CH_CML_SEL2               0
+ *    09    CH_CML_SEL1               0
+ *    08    CH_CML_SEL0               0
+ *    07    EN_BGR7                   0
+ *    06    EN_BGR6                   0
+ *    05    EN_BGR5                   0
+ *    04    EN_BGR4                   0
+ *    03    EN_BGR3                   0
+ *    02    EN_BGR2                   0
+ *    01    EN_BGR1                   0
+ *    00    EN_BGR0                   0
+ * </pre>
+ */
+#define RICU_AFE_CTL_8_ADDR        (REG_RICU_BASE_ADDR + 0x00000030)
+#define RICU_AFE_CTL_8_OFFSET      0x00000030
+#define RICU_AFE_CTL_8_INDEX       0x0000000C
+#define RICU_AFE_CTL_8_RESET       0x00000000
+
+static inline u32 ricu_afe_ctl_8_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, RICU_AFE_CTL_8_ADDR);
+}
+
+static inline void ricu_afe_ctl_8_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_8_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTL_8_EN_REF_7_BIT         ((u32)0x80000000)
+#define RICU_AFE_CTL_8_EN_REF_7_POS         31
+#define RICU_AFE_CTL_8_EN_REF_6_BIT         ((u32)0x40000000)
+#define RICU_AFE_CTL_8_EN_REF_6_POS         30
+#define RICU_AFE_CTL_8_EN_REF_5_BIT         ((u32)0x20000000)
+#define RICU_AFE_CTL_8_EN_REF_5_POS         29
+#define RICU_AFE_CTL_8_EN_REF_4_BIT         ((u32)0x10000000)
+#define RICU_AFE_CTL_8_EN_REF_4_POS         28
+#define RICU_AFE_CTL_8_EN_REF_3_BIT         ((u32)0x08000000)
+#define RICU_AFE_CTL_8_EN_REF_3_POS         27
+#define RICU_AFE_CTL_8_EN_REF_2_BIT         ((u32)0x04000000)
+#define RICU_AFE_CTL_8_EN_REF_2_POS         26
+#define RICU_AFE_CTL_8_EN_REF_1_BIT         ((u32)0x02000000)
+#define RICU_AFE_CTL_8_EN_REF_1_POS         25
+#define RICU_AFE_CTL_8_EN_REF_0_BIT         ((u32)0x01000000)
+#define RICU_AFE_CTL_8_EN_REF_0_POS         24
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_7_BIT    ((u32)0x00800000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_7_POS    23
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_6_BIT    ((u32)0x00400000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_6_POS    22
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_5_BIT    ((u32)0x00200000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_5_POS    21
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_4_BIT    ((u32)0x00100000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_4_POS    20
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_3_BIT    ((u32)0x00080000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_3_POS    19
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_2_BIT    ((u32)0x00040000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_2_POS    18
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_1_BIT    ((u32)0x00020000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_1_POS    17
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_0_BIT    ((u32)0x00010000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_0_POS    16
+#define RICU_AFE_CTL_8_CH_CML_SEL_7_BIT     ((u32)0x00008000)
+#define RICU_AFE_CTL_8_CH_CML_SEL_7_POS     15
+#define RICU_AFE_CTL_8_CH_CML_SEL_6_BIT     ((u32)0x00004000)
+#define RICU_AFE_CTL_8_CH_CML_SEL_6_POS     14
+#define RICU_AFE_CTL_8_CH_CML_SEL_5_BIT     ((u32)0x00002000)
+#define RICU_AFE_CTL_8_CH_CML_SEL_5_POS     13
+#define RICU_AFE_CTL_8_CH_CML_SEL_4_BIT     ((u32)0x00001000)
+#define RICU_AFE_CTL_8_CH_CML_SEL_4_POS     12
+#define RICU_AFE_CTL_8_CH_CML_SEL_3_BIT     ((u32)0x00000800)
+#define RICU_AFE_CTL_8_CH_CML_SEL_3_POS     11
+#define RICU_AFE_CTL_8_CH_CML_SEL_2_BIT     ((u32)0x00000400)
+#define RICU_AFE_CTL_8_CH_CML_SEL_2_POS     10
+#define RICU_AFE_CTL_8_CH_CML_SEL_1_BIT     ((u32)0x00000200)
+#define RICU_AFE_CTL_8_CH_CML_SEL_1_POS     9
+#define RICU_AFE_CTL_8_CH_CML_SEL_0_BIT     ((u32)0x00000100)
+#define RICU_AFE_CTL_8_CH_CML_SEL_0_POS     8
+#define RICU_AFE_CTL_8_EN_BGR_7_BIT         ((u32)0x00000080)
+#define RICU_AFE_CTL_8_EN_BGR_7_POS         7
+#define RICU_AFE_CTL_8_EN_BGR_6_BIT         ((u32)0x00000040)
+#define RICU_AFE_CTL_8_EN_BGR_6_POS         6
+#define RICU_AFE_CTL_8_EN_BGR_5_BIT         ((u32)0x00000020)
+#define RICU_AFE_CTL_8_EN_BGR_5_POS         5
+#define RICU_AFE_CTL_8_EN_BGR_4_BIT         ((u32)0x00000010)
+#define RICU_AFE_CTL_8_EN_BGR_4_POS         4
+#define RICU_AFE_CTL_8_EN_BGR_3_BIT         ((u32)0x00000008)
+#define RICU_AFE_CTL_8_EN_BGR_3_POS         3
+#define RICU_AFE_CTL_8_EN_BGR_2_BIT         ((u32)0x00000004)
+#define RICU_AFE_CTL_8_EN_BGR_2_POS         2
+#define RICU_AFE_CTL_8_EN_BGR_1_BIT         ((u32)0x00000002)
+#define RICU_AFE_CTL_8_EN_BGR_1_POS         1
+#define RICU_AFE_CTL_8_EN_BGR_0_BIT         ((u32)0x00000001)
+#define RICU_AFE_CTL_8_EN_BGR_0_POS         0
+
+/*
+ * @brief AFE_CTL_9 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    EN_SIN2_BIAS7             1
+ *    30    EN_SIN2_BIAS6             1
+ *    29    EN_SIN2_BIAS5             1
+ *    28    EN_SIN2_BIAS4             1
+ *    27    EN_SIN2_BIAS3             1
+ *    26    EN_SIN2_BIAS2             1
+ *    25    EN_SIN2_BIAS1             1
+ *    24    EN_SIN2_BIAS0             1
+ *    23    EN_DAC_REF7               0
+ *    22    EN_DAC_REF6               0
+ *    21    EN_DAC_REF5               0
+ *    20    EN_DAC_REF4               0
+ *    19    EN_DAC_REF3               0
+ *    18    EN_DAC_REF2               0
+ *    17    EN_DAC_REF1               0
+ *    16    EN_DAC_REF0               0
+ * </pre>
+ */
+#define RICU_AFE_CTL_9_ADDR        (REG_RICU_BASE_ADDR + 0x00000034)
+#define RICU_AFE_CTL_9_OFFSET      0x00000034
+#define RICU_AFE_CTL_9_INDEX       0x0000000D
+#define RICU_AFE_CTL_9_RESET       0xFF000000
+
+static inline u32 ricu_afe_ctl_9_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, RICU_AFE_CTL_9_ADDR);
+}
+
+static inline void ricu_afe_ctl_9_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_9_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_7_BIT    ((u32)0x80000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_7_POS    31
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_6_BIT    ((u32)0x40000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_6_POS    30
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_5_BIT    ((u32)0x20000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_5_POS    29
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_4_BIT    ((u32)0x10000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_4_POS    28
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_3_BIT    ((u32)0x08000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_3_POS    27
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_2_BIT    ((u32)0x04000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_2_POS    26
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_1_BIT    ((u32)0x02000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_1_POS    25
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_0_BIT    ((u32)0x01000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_0_POS    24
+#define RICU_AFE_CTL_9_EN_DAC_REF_7_BIT     ((u32)0x00800000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_7_POS     23
+#define RICU_AFE_CTL_9_EN_DAC_REF_6_BIT     ((u32)0x00400000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_6_POS     22
+#define RICU_AFE_CTL_9_EN_DAC_REF_5_BIT     ((u32)0x00200000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_5_POS     21
+#define RICU_AFE_CTL_9_EN_DAC_REF_4_BIT     ((u32)0x00100000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_4_POS     20
+#define RICU_AFE_CTL_9_EN_DAC_REF_3_BIT     ((u32)0x00080000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_3_POS     19
+#define RICU_AFE_CTL_9_EN_DAC_REF_2_BIT     ((u32)0x00040000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_2_POS     18
+#define RICU_AFE_CTL_9_EN_DAC_REF_1_BIT     ((u32)0x00020000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_1_POS     17
+#define RICU_AFE_CTL_9_EN_DAC_REF_0_BIT     ((u32)0x00010000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_0_POS     16
+
+/*
+ * @brief AFE_CTL_10 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    VC_LD7                    0
+ *    30    VC_LD6                    0
+ *    29    VC_LD5                    0
+ *    28    VC_LD4                    0
+ *    27    VC_LD3                    0
+ *    26    VC_LD2                    0
+ *    25    VC_LD1                    0
+ *    24    VC_LD0                    0
+ *    23    TWOS7                     0
+ *    22    TWOS6                     0
+ *    21    TWOS5                     0
+ *    20    TWOS4                     0
+ *    19    TWOS3                     0
+ *    18    TWOS2                     0
+ *    17    TWOS1                     0
+ *    16    TWOS0                     0
+ *    07    MINV7                     1
+ *    06    MINV6                     1
+ *    05    MINV5                     1
+ *    04    MINV4                     1
+ *    03    MINV3                     1
+ *    02    MINV2                     1
+ *    01    MINV1                     1
+ *    00    MINV0                     1
+ * </pre>
+ */
+#define RICU_AFE_CTL_10_ADDR        (REG_RICU_BASE_ADDR + 0x00000038)
+#define RICU_AFE_CTL_10_OFFSET      0x00000038
+#define RICU_AFE_CTL_10_INDEX       0x0000000E
+#define RICU_AFE_CTL_10_RESET       0x000000FF
+
+static inline void ricu_afe_ctl_10_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_10_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_12 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:30 EOC_CTRL7                 0x0
+ *    29:28 EOC_CTRL6                 0x0
+ *    27:26 EOC_CTRL5                 0x0
+ *    25:24 EOC_CTRL4                 0x0
+ *    23:22 EOC_CTRL3                 0x0
+ *    21:20 EOC_CTRL2                 0x0
+ *    19:18 EOC_CTRL1                 0x0
+ *    17:16 EOC_CTRL0                 0x0
+ *    15:14 IC_REFSSF7                0x1
+ *    13:12 IC_REFSSF6                0x1
+ *    11:10 IC_REFSSF5                0x1
+ *    09:08 IC_REFSSF4                0x1
+ *    07:06 IC_REFSSF3                0x1
+ *    05:04 IC_REFSSF2                0x1
+ *    03:02 IC_REFSSF1                0x1
+ *    01:00 IC_REFSSF0                0x1
+ * </pre>
+ */
+#define RICU_AFE_CTL_12_ADDR        (REG_RICU_BASE_ADDR + 0x00000040)
+#define RICU_AFE_CTL_12_OFFSET      0x00000040
+#define RICU_AFE_CTL_12_INDEX       0x00000010
+#define RICU_AFE_CTL_12_RESET       0x00005555
+
+static inline void ricu_afe_ctl_12_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_12_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_17 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:28 VC_REF7                   0x1
+ *    26:24 VC_REF6                   0x1
+ *    22:20 VC_REF5                   0x1
+ *    18:16 VC_REF4                   0x1
+ *    14:12 VC_REF3                   0x1
+ *    10:08 VC_REF2                   0x1
+ *    06:04 VC_REF1                   0x1
+ *    02:00 VC_REF0                   0x1
+ * </pre>
+ */
+#define RICU_AFE_CTL_17_ADDR        (REG_RICU_BASE_ADDR + 0x00000054)
+#define RICU_AFE_CTL_17_OFFSET      0x00000054
+#define RICU_AFE_CTL_17_INDEX       0x00000015
+#define RICU_AFE_CTL_17_RESET       0x11111111
+
+static inline void ricu_afe_ctl_17_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_17_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_19 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:28 COMP_CTRL7                0x4
+ *    27:24 COMP_CTRL6                0x4
+ *    23:20 COMP_CTRL5                0x4
+ *    19:16 COMP_CTRL4                0x4
+ *    15:12 COMP_CTRL3                0x4
+ *    11:08 COMP_CTRL2                0x4
+ *    07:04 COMP_CTRL1                0x4
+ *    03:00 COMP_CTRL0                0x4
+ * </pre>
+ */
+#define RICU_AFE_CTL_19_ADDR        (REG_RICU_BASE_ADDR + 0x0000005C)
+#define RICU_AFE_CTL_19_OFFSET      0x0000005C
+#define RICU_AFE_CTL_19_INDEX       0x00000017
+#define RICU_AFE_CTL_19_RESET       0x44444444
+
+static inline void ricu_afe_ctl_19_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_19_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_23 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:28 VC_LD_AVDI7               0x3
+ *    26:24 VC_LD_AVDI6               0x3
+ *    22:20 VC_LD_AVDI5               0x3
+ *    18:16 VC_LD_AVDI4               0x3
+ *    14:12 VC_LD_AVDI3               0x3
+ *    10:08 VC_LD_AVDI2               0x3
+ *    06:04 VC_LD_AVDI1               0x3
+ *    02:00 VC_LD_AVDI0               0x3
+ * </pre>
+ */
+#define RICU_AFE_CTL_23_ADDR        (REG_RICU_BASE_ADDR + 0x0000006C)
+#define RICU_AFE_CTL_23_OFFSET      0x0000006C
+#define RICU_AFE_CTL_23_INDEX       0x0000001B
+#define RICU_AFE_CTL_23_RESET       0x33333333
+
+static inline void ricu_afe_ctl_23_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_23_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_24 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:28 VC_LD_AVDQ7               0x3
+ *    26:24 VC_LD_AVDQ6               0x3
+ *    22:20 VC_LD_AVDQ5               0x3
+ *    18:16 VC_LD_AVDQ4               0x3
+ *    14:12 VC_LD_AVDQ3               0x3
+ *    10:08 VC_LD_AVDQ2               0x3
+ *    06:04 VC_LD_AVDQ1               0x3
+ *    02:00 VC_LD_AVDQ0               0x3
+ * </pre>
+ */
+#define RICU_AFE_CTL_24_ADDR        (REG_RICU_BASE_ADDR + 0x00000070)
+#define RICU_AFE_CTL_24_OFFSET      0x00000070
+#define RICU_AFE_CTL_24_INDEX       0x0000001C
+#define RICU_AFE_CTL_24_RESET       0x33333333
+
+static inline void ricu_afe_ctl_24_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_24_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_25 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL0                    0
+ *    14:08 RO_CTRLQ0                 0x7
+ *    06:00 RO_CTRLI0                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTL_25_ADDR        (REG_RICU_BASE_ADDR + 0x00000074)
+#define RICU_AFE_CTL_25_OFFSET      0x00000074
+#define RICU_AFE_CTL_25_INDEX       0x0000001D
+#define RICU_AFE_CTL_25_RESET       0x00000707
+
+static inline void ricu_afe_ctl_25_pack(struct cl_chip *chip, u8 rosel0, u=
8 roctrlq0, u8 roctrli0)
+{
+       ASSERT_ERR_CHIP((((u32)rosel0 << 16) & ~((u32)0x00010000)) =3D=3D 0=
);
+       ASSERT_ERR_CHIP((((u32)roctrlq0 << 8) & ~((u32)0x00007F00)) =3D=3D =
0);
+       ASSERT_ERR_CHIP((((u32)roctrli0 << 0) & ~((u32)0x0000007F)) =3D=3D =
0);
+       cl_reg_write_chip(chip, RICU_AFE_CTL_25_ADDR, ((u32)rosel0 << 16) |=
 ((u32)roctrlq0 << 8) | ((u32)roctrli0 << 0));
+}
+
+/*
+ * @brief AFE_CTL_26 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL1                    0
+ *    14:08 RO_CTRLQ1                 0x7
+ *    06:00 RO_CTRLI1                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTL_26_ADDR        (REG_RICU_BASE_ADDR + 0x00000078)
+#define RICU_AFE_CTL_26_OFFSET      0x00000078
+#define RICU_AFE_CTL_26_INDEX       0x0000001E
+#define RICU_AFE_CTL_26_RESET       0x00000707
+
+static inline void ricu_afe_ctl_26_pack(struct cl_chip *chip, u8 rosel1, u=
8 roctrlq1, u8 roctrli1)
+{
+       ASSERT_ERR_CHIP((((u32)rosel1 << 16) & ~((u32)0x00010000)) =3D=3D 0=
);
+       ASSERT_ERR_CHIP((((u32)roctrlq1 << 8) & ~((u32)0x00007F00)) =3D=3D =
0);
+       ASSERT_ERR_CHIP((((u32)roctrli1 << 0) & ~((u32)0x0000007F)) =3D=3D =
0);
+       cl_reg_write_chip(chip, RICU_AFE_CTL_26_ADDR, ((u32)rosel1 << 16) |=
 ((u32)roctrlq1 << 8) | ((u32)roctrli1 << 0));
+}
+
+/*
+ * @brief AFE_CTL_27 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL2                    0
+ *    14:08 RO_CTRLQ2                 0x7
+ *    06:00 RO_CTRLI2                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTL_27_ADDR        (REG_RICU_BASE_ADDR + 0x0000007C)
+#define RICU_AFE_CTL_27_OFFSET      0x0000007C
+#define RICU_AFE_CTL_27_INDEX       0x0000001F
+#define RICU_AFE_CTL_27_RESET       0x00000707
+
+static inline void ricu_afe_ctl_27_pack(struct cl_chip *chip, u8 rosel2, u=
8 roctrlq2, u8 roctrli2)
+{
+       ASSERT_ERR_CHIP((((u32)rosel2 << 16) & ~((u32)0x00010000)) =3D=3D 0=
);
+       ASSERT_ERR_CHIP((((u32)roctrlq2 << 8) & ~((u32)0x00007F00)) =3D=3D =
0);
+       ASSERT_ERR_CHIP((((u32)roctrli2 << 0) & ~((u32)0x0000007F)) =3D=3D =
0);
+       cl_reg_write_chip(chip, RICU_AFE_CTL_27_ADDR, ((u32)rosel2 << 16) |=
 ((u32)roctrlq2 << 8) | ((u32)roctrli2 << 0));
+}
+
+/*
+ * @brief AFE_CTL_29 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:28 VC_CML7_I                 0x5
+ *    26:24 VC_CML6_I                 0x5
+ *    22:20 VC_CML5_I                 0x5
+ *    18:16 VC_CML4_I                 0x5
+ *    14:12 VC_CML3_I                 0x5
+ *    10:08 VC_CML2_I                 0x5
+ *    06:04 VC_CML1_I                 0x5
+ *    02:00 VC_CML0_I                 0x5
+ * </pre>
+ */
+#define RICU_AFE_CTL_29_ADDR        (REG_RICU_BASE_ADDR + 0x00000084)
+#define RICU_AFE_CTL_29_OFFSET      0x00000084
+#define RICU_AFE_CTL_29_INDEX       0x00000021
+#define RICU_AFE_CTL_29_RESET       0x55555555
+
+static inline void ricu_afe_ctl_29_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_29_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_30 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:28 VC_CML7_Q                 0x5
+ *    26:24 VC_CML6_Q                 0x5
+ *    22:20 VC_CML5_Q                 0x5
+ *    18:16 VC_CML4_Q                 0x5
+ *    14:12 VC_CML3_Q                 0x5
+ *    10:08 VC_CML2_Q                 0x5
+ *    06:04 VC_CML1_Q                 0x5
+ *    02:00 VC_CML0_Q                 0x5
+ * </pre>
+ */
+#define RICU_AFE_CTL_30_ADDR        (REG_RICU_BASE_ADDR + 0x00000088)
+#define RICU_AFE_CTL_30_OFFSET      0x00000088
+#define RICU_AFE_CTL_30_INDEX       0x00000022
+#define RICU_AFE_CTL_30_RESET       0x55555555
+
+static inline void ricu_afe_ctl_30_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTL_30_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_33 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL3                    0
+ *    14:08 RO_CTRL3_Q                0x7
+ *    06:00 RO_CTRL3_I                0x7
+ * </pre>
+ */
+#define RICU_AFE_CTL_33_ADDR        (REG_RICU_BASE_ADDR + 0x00000094)
+#define RICU_AFE_CTL_33_OFFSET      0x00000094
+#define RICU_AFE_CTL_33_INDEX       0x00000025
+#define RICU_AFE_CTL_33_RESET       0x00000707
+
+static inline void ricu_afe_ctl_33_pack(struct cl_chip *chip, u8 rosel3, u=
8 roctrl3q, u8 roctrl3i)
+{
+       ASSERT_ERR_CHIP((((u32)rosel3 << 16) & ~((u32)0x00010000)) =3D=3D 0=
);
+       ASSERT_ERR_CHIP((((u32)roctrl3q << 8) & ~((u32)0x00007F00)) =3D=3D =
0);
+       ASSERT_ERR_CHIP((((u32)roctrl3i << 0) & ~((u32)0x0000007F)) =3D=3D =
0);
+       cl_reg_write_chip(chip, RICU_AFE_CTL_33_ADDR, ((u32)rosel3 << 16) |=
 ((u32)roctrl3q << 8) | ((u32)roctrl3i << 0));
+}
+
+/*
+ * @brief AFE_CTRL_34_PHY_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    06    PHY0_ADC_SB_IGNORE_FIFO_INDICATION 0
+ *    05:02 PHY0_ADC_SB_RD_DELAY      0x4
+ *    01:00 PHY0_ADC_SB_MODE          0x0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_34_PHY_0_ADDR        (REG_RICU_BASE_ADDR + 0x0000009=
C)
+#define RICU_AFE_CTRL_34_PHY_0_OFFSET      0x0000009C
+#define RICU_AFE_CTRL_34_PHY_0_INDEX       0x00000027
+#define RICU_AFE_CTRL_34_PHY_0_RESET       0x00000010
+
+static inline void ricu_afe_ctrl_34_phy_0_adc_sb_ignore_fifo_indication_se=
tf(struct cl_chip *chip, u8 phy0adcsbignorefifoindication)
+{
+       ASSERT_ERR_CHIP((((u32)phy0adcsbignorefifoindication << 6) & ~((u32=
)0x00000040)) =3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_34_PHY_0_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_34_PHY_0_ADDR) & ~((u32)0x00000040)) | ((u32)phy0ad=
csbignorefifoindication << 6));
+}
+
+static inline void ricu_afe_ctrl_34_phy_0_adc_sb_rd_delay_setf(struct cl_c=
hip *chip, u8 phy0adcsbrddelay)
+{
+       ASSERT_ERR_CHIP((((u32)phy0adcsbrddelay << 2) & ~((u32)0x0000003C))=
 =3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_34_PHY_0_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_34_PHY_0_ADDR) & ~((u32)0x0000003C)) | ((u32)phy0ad=
csbrddelay << 2));
+}
+
+/*
+ * @brief AFE_CTRL_36_PHY_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    07    PHY0_ADC_ALWAYS_EN_LD_IR  0
+ *    06    PHY0_ADC_ALWAYS_EN_LD_AVDQ 0
+ *    05    PHY0_ADC_ALWAYS_EN_LD_AVDI 0
+ *    04    PHY0_ADC_ALWAYS_EN_ADCQ   0
+ *    03    PHY0_ADC_ALWAYS_EN_ADCI   0
+ *    01    PHY0_HW_MODE_DAC          0
+ *    00    PHY0_HW_MODE_ADC          0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_36_PHY_0_ADDR        (REG_RICU_BASE_ADDR + 0x000000A=
0)
+#define RICU_AFE_CTRL_36_PHY_0_OFFSET      0x000000A0
+#define RICU_AFE_CTRL_36_PHY_0_INDEX       0x00000028
+#define RICU_AFE_CTRL_36_PHY_0_RESET       0x00000000
+
+static inline u32 ricu_afe_ctrl_36_phy_0_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR);
+}
+
+static inline void ricu_afe_ctrl_36_phy_0_set(struct cl_chip *chip, u32 va=
lue)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_IR_BIT    ((u32)0x00000080=
)
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_IR_POS    7
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDQ_BIT    ((u32)0x000000=
40)
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDQ_POS    6
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDI_BIT    ((u32)0x000000=
20)
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDI_POS    5
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCQ_BIT    ((u32)0x00000010)
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCQ_POS    4
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCI_BIT    ((u32)0x00000008)
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCI_POS    3
+#define RICU_AFE_CTRL_36_PHY_0_HW_MODE_DAC_BIT    ((u32)0x00000002)
+#define RICU_AFE_CTRL_36_PHY_0_HW_MODE_DAC_POS    1
+#define RICU_AFE_CTRL_36_PHY_0_HW_MODE_ADC_BIT    ((u32)0x00000001)
+#define RICU_AFE_CTRL_36_PHY_0_HW_MODE_ADC_POS    0
+
+static inline void ricu_afe_ctrl_36_phy_0_hw_mode_dac_setf(struct cl_chip =
*chip, u8 phy0hwmodedac)
+{
+       ASSERT_ERR_CHIP((((u32)phy0hwmodedac << 1) & ~((u32)0x00000002)) =
=3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR) & ~((u32)0x00000002)) | ((u32)phy0hw=
modedac << 1));
+}
+
+static inline void ricu_afe_ctrl_36_phy_0_hw_mode_adc_setf(struct cl_chip =
*chip, u8 phy0hwmodeadc)
+{
+       ASSERT_ERR_CHIP((((u32)phy0hwmodeadc << 0) & ~((u32)0x00000001)) =
=3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR) & ~((u32)0x00000001)) | ((u32)phy0hw=
modeadc << 0));
+}
+
+/*
+ * @brief AFE_CTRL_34_PHY_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    06    PHY1_ADC_SB_IGNORE_FIFO_INDICATION 0
+ *    05:02 PHY1_ADC_SB_RD_DELAY      0x4
+ *    01:00 PHY1_ADC_SB_MODE          0x0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_34_PHY_1_ADDR        (REG_RICU_BASE_ADDR + 0x000000A=
4)
+#define RICU_AFE_CTRL_34_PHY_1_OFFSET      0x000000A4
+#define RICU_AFE_CTRL_34_PHY_1_INDEX       0x00000029
+#define RICU_AFE_CTRL_34_PHY_1_RESET       0x00000010
+
+static inline void ricu_afe_ctrl_34_phy_1_adc_sb_ignore_fifo_indication_se=
tf(struct cl_chip *chip, u8 phy1adcsbignorefifoindication)
+{
+       ASSERT_ERR_CHIP((((u32)phy1adcsbignorefifoindication << 6) & ~((u32=
)0x00000040)) =3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_34_PHY_1_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_34_PHY_1_ADDR) & ~((u32)0x00000040)) | ((u32)phy1ad=
csbignorefifoindication << 6));
+}
+
+static inline void ricu_afe_ctrl_34_phy_1_adc_sb_rd_delay_setf(struct cl_c=
hip *chip, u8 phy1adcsbrddelay)
+{
+       ASSERT_ERR_CHIP((((u32)phy1adcsbrddelay << 2) & ~((u32)0x0000003C))=
 =3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_34_PHY_1_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_34_PHY_1_ADDR) & ~((u32)0x0000003C)) | ((u32)phy1ad=
csbrddelay << 2));
+}
+
+/*
+ * @brief AFE_CTRL_35_PHY_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    06    PHY0_DAC_SB_IGNORE_FIFO_INDICATION 0
+ *    05:02 PHY0_DAC_SB_RD_DELAY      0x1
+ *    01:00 PHY0_DAC_SB_MODE          0x0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_35_PHY_0_ADDR        (REG_RICU_BASE_ADDR + 0x000000A=
8)
+#define RICU_AFE_CTRL_35_PHY_0_OFFSET      0x000000A8
+#define RICU_AFE_CTRL_35_PHY_0_INDEX       0x0000002A
+#define RICU_AFE_CTRL_35_PHY_0_RESET       0x00000004
+
+static inline void ricu_afe_ctrl_35_phy_0_dac_sb_ignore_fifo_indication_se=
tf(struct cl_chip *chip, u8 phy0dacsbignorefifoindication)
+{
+       ASSERT_ERR_CHIP((((u32)phy0dacsbignorefifoindication << 6) & ~((u32=
)0x00000040)) =3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_35_PHY_0_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_35_PHY_0_ADDR) & ~((u32)0x00000040)) | ((u32)phy0da=
csbignorefifoindication << 6));
+}
+
+static inline void ricu_afe_ctrl_35_phy_0_dac_sb_rd_delay_setf(struct cl_c=
hip *chip, u8 phy0dacsbrddelay)
+{
+       ASSERT_ERR_CHIP((((u32)phy0dacsbrddelay << 2) & ~((u32)0x0000003C))=
 =3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_35_PHY_0_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_35_PHY_0_ADDR) & ~((u32)0x0000003C)) | ((u32)phy0da=
csbrddelay << 2));
+}
+
+/*
+ * @brief AFE_CTRL_35_PHY_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    06    PHY1_DAC_SB_IGNORE_FIFO_INDICATION 0
+ *    05:02 PHY1_DAC_SB_RD_DELAY      0x1
+ *    01:00 PHY1_DAC_SB_MODE          0x0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_35_PHY_1_ADDR        (REG_RICU_BASE_ADDR + 0x000000A=
C)
+#define RICU_AFE_CTRL_35_PHY_1_OFFSET      0x000000AC
+#define RICU_AFE_CTRL_35_PHY_1_INDEX       0x0000002B
+#define RICU_AFE_CTRL_35_PHY_1_RESET       0x00000004
+
+static inline void ricu_afe_ctrl_35_phy_1_dac_sb_ignore_fifo_indication_se=
tf(struct cl_chip *chip, u8 phy1dacsbignorefifoindication)
+{
+       ASSERT_ERR_CHIP((((u32)phy1dacsbignorefifoindication << 6) & ~((u32=
)0x00000040)) =3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_35_PHY_1_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_35_PHY_1_ADDR) & ~((u32)0x00000040)) | ((u32)phy1da=
csbignorefifoindication << 6));
+}
+
+static inline void ricu_afe_ctrl_35_phy_1_dac_sb_rd_delay_setf(struct cl_c=
hip *chip, u8 phy1dacsbrddelay)
+{
+       ASSERT_ERR_CHIP((((u32)phy1dacsbrddelay << 2) & ~((u32)0x0000003C))=
 =3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_35_PHY_1_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_35_PHY_1_ADDR) & ~((u32)0x0000003C)) | ((u32)phy1da=
csbrddelay << 2));
+}
+
+/*
+ * @brief AFE_CTRL_37_PHY_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    05    PHY0_EN_DAC5              0
+ *    04    PHY0_EN_DAC4              0
+ *    03    PHY0_EN_DAC3              0
+ *    02    PHY0_EN_DAC2              0
+ *    01    PHY0_EN_DAC1              0
+ *    00    PHY0_EN_DAC0              0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_37_PHY_0_ADDR        (REG_RICU_BASE_ADDR + 0x000000B=
C)
+#define RICU_AFE_CTRL_37_PHY_0_OFFSET      0x000000BC
+#define RICU_AFE_CTRL_37_PHY_0_INDEX       0x0000002F
+#define RICU_AFE_CTRL_37_PHY_0_RESET       0x00000000
+
+static inline u32 ricu_afe_ctrl_37_phy_0_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, RICU_AFE_CTRL_37_PHY_0_ADDR);
+}
+
+static inline void ricu_afe_ctrl_37_phy_0_set(struct cl_chip *chip, u32 va=
lue)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_37_PHY_0_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_5_BIT    ((u32)0x00000020)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_5_POS    5
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_4_BIT    ((u32)0x00000010)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_4_POS    4
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_3_BIT    ((u32)0x00000008)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_3_POS    3
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_2_BIT    ((u32)0x00000004)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_2_POS    2
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_1_BIT    ((u32)0x00000002)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_1_POS    1
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_0_BIT    ((u32)0x00000001)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_0_POS    0
+
+/*
+ * @brief AFE_CTRL_37_PHY_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    05    PHY1_EN_DAC5              0
+ *    04    PHY1_EN_DAC4              0
+ *    03    PHY1_EN_DAC3              0
+ *    02    PHY1_EN_DAC2              0
+ *    01    PHY1_EN_DAC1              0
+ *    00    PHY1_EN_DAC0              0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_37_PHY_1_ADDR        (REG_RICU_BASE_ADDR + 0x000000C=
0)
+#define RICU_AFE_CTRL_37_PHY_1_OFFSET      0x000000C0
+#define RICU_AFE_CTRL_37_PHY_1_INDEX       0x00000030
+#define RICU_AFE_CTRL_37_PHY_1_RESET       0x00000000
+
+static inline u32 ricu_afe_ctrl_37_phy_1_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, RICU_AFE_CTRL_37_PHY_1_ADDR);
+}
+
+static inline void ricu_afe_ctrl_37_phy_1_set(struct cl_chip *chip, u32 va=
lue)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_37_PHY_1_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_5_BIT    ((u32)0x00000020)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_5_POS    5
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_4_BIT    ((u32)0x00000010)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_4_POS    4
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_3_BIT    ((u32)0x00000008)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_3_POS    3
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_2_BIT    ((u32)0x00000004)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_2_POS    2
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_1_BIT    ((u32)0x00000002)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_1_POS    1
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_0_BIT    ((u32)0x00000001)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_0_POS    0
+
+/*
+ * @brief AFE_CTRL_39 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL4                    0
+ *    14:08 RO_CTRLQ4                 0x7
+ *    06:00 RO_CTRLI4                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTRL_39_ADDR        (REG_RICU_BASE_ADDR + 0x000000CC)
+#define RICU_AFE_CTRL_39_OFFSET      0x000000CC
+#define RICU_AFE_CTRL_39_INDEX       0x00000033
+#define RICU_AFE_CTRL_39_RESET       0x00000707
+
+static inline void ricu_afe_ctrl_39_pack(struct cl_chip *chip, u8 rosel4, =
u8 roctrlq4, u8 roctrli4)
+{
+       ASSERT_ERR_CHIP((((u32)rosel4 << 16) & ~((u32)0x00010000)) =3D=3D 0=
);
+       ASSERT_ERR_CHIP((((u32)roctrlq4 << 8) & ~((u32)0x00007F00)) =3D=3D =
0);
+       ASSERT_ERR_CHIP((((u32)roctrli4 << 0) & ~((u32)0x0000007F)) =3D=3D =
0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_39_ADDR, ((u32)rosel4 << 16) =
| ((u32)roctrlq4 << 8) | ((u32)roctrli4 << 0));
+}
+
+/*
+ * @brief AFE_CTRL_40 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL5                    0
+ *    14:08 RO_CTRLQ5                 0x7
+ *    06:00 RO_CTRLI5                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTRL_40_ADDR        (REG_RICU_BASE_ADDR + 0x000000D0)
+#define RICU_AFE_CTRL_40_OFFSET      0x000000D0
+#define RICU_AFE_CTRL_40_INDEX       0x00000034
+#define RICU_AFE_CTRL_40_RESET       0x00000707
+
+static inline void ricu_afe_ctrl_40_pack(struct cl_chip *chip, u8 rosel5, =
u8 roctrlq5, u8 roctrli5)
+{
+       ASSERT_ERR_CHIP((((u32)rosel5 << 16) & ~((u32)0x00010000)) =3D=3D 0=
);
+       ASSERT_ERR_CHIP((((u32)roctrlq5 << 8) & ~((u32)0x00007F00)) =3D=3D =
0);
+       ASSERT_ERR_CHIP((((u32)roctrli5 << 0) & ~((u32)0x0000007F)) =3D=3D =
0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_40_ADDR, ((u32)rosel5 << 16) =
| ((u32)roctrlq5 << 8) | ((u32)roctrli5 << 0));
+}
+
+/*
+ * @brief AFE_CTRL_41 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL6                    0
+ *    14:08 RO_CTRLQ6                 0x7
+ *    06:00 RO_CTRLI6                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTRL_41_ADDR        (REG_RICU_BASE_ADDR + 0x000000D4)
+#define RICU_AFE_CTRL_41_OFFSET      0x000000D4
+#define RICU_AFE_CTRL_41_INDEX       0x00000035
+#define RICU_AFE_CTRL_41_RESET       0x00000707
+
+static inline void ricu_afe_ctrl_41_pack(struct cl_chip *chip, u8 rosel6, =
u8 roctrlq6, u8 roctrli6)
+{
+       ASSERT_ERR_CHIP((((u32)rosel6 << 16) & ~((u32)0x00010000)) =3D=3D 0=
);
+       ASSERT_ERR_CHIP((((u32)roctrlq6 << 8) & ~((u32)0x00007F00)) =3D=3D =
0);
+       ASSERT_ERR_CHIP((((u32)roctrli6 << 0) & ~((u32)0x0000007F)) =3D=3D =
0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_41_ADDR, ((u32)rosel6 << 16) =
| ((u32)roctrlq6 << 8) | ((u32)roctrli6 << 0));
+}
+
+/*
+ * @brief AFE_CTRL_42 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL7                    0
+ *    14:08 RO_CTRLQ7                 0x7
+ *    06:00 RO_CTRLI7                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTRL_42_ADDR        (REG_RICU_BASE_ADDR + 0x000000D8)
+#define RICU_AFE_CTRL_42_OFFSET      0x000000D8
+#define RICU_AFE_CTRL_42_INDEX       0x00000036
+#define RICU_AFE_CTRL_42_RESET       0x00000707
+
+static inline void ricu_afe_ctrl_42_pack(struct cl_chip *chip, u8 rosel7, =
u8 roctrlq7, u8 roctrli7)
+{
+       ASSERT_ERR_CHIP((((u32)rosel7 << 16) & ~((u32)0x00010000)) =3D=3D 0=
);
+       ASSERT_ERR_CHIP((((u32)roctrlq7 << 8) & ~((u32)0x00007F00)) =3D=3D =
0);
+       ASSERT_ERR_CHIP((((u32)roctrli7 << 0) & ~((u32)0x0000007F)) =3D=3D =
0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_42_ADDR, ((u32)rosel7 << 16) =
| ((u32)roctrlq7 << 8) | ((u32)roctrli7 << 0));
+}
+
+/*
+ * @brief AFE_CTRL_43 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    01:00 FREQ_SEL                  0x3
+ * </pre>
+ */
+#define RICU_AFE_CTRL_43_ADDR        (REG_RICU_BASE_ADDR + 0x000000DC)
+#define RICU_AFE_CTRL_43_OFFSET      0x000000DC
+#define RICU_AFE_CTRL_43_INDEX       0x00000037
+#define RICU_AFE_CTRL_43_RESET       0x00000003
+
+static inline void ricu_afe_ctrl_43_freq_sel_setf(struct cl_chip *chip, u8=
 freqsel)
+{
+       ASSERT_ERR_CHIP((((u32)freqsel << 0) & ~((u32)0x00000003)) =3D=3D 0=
);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_43_ADDR, (u32)freqsel << 0);
+}
+
+/*
+ * @brief AFE_CTRL_44 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    01:00 CDB_FREQ_SEL              0x3
+ * </pre>
+ */
+#define RICU_AFE_CTRL_44_ADDR        (REG_RICU_BASE_ADDR + 0x000000E0)
+#define RICU_AFE_CTRL_44_OFFSET      0x000000E0
+#define RICU_AFE_CTRL_44_INDEX       0x00000038
+#define RICU_AFE_CTRL_44_RESET       0x00000003
+
+static inline void ricu_afe_ctrl_44_cdb_freq_sel_setf(struct cl_chip *chip=
, u8 cdbfreqsel)
+{
+       ASSERT_ERR_CHIP((((u32)cdbfreqsel << 0) & ~((u32)0x00000003)) =3D=
=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_44_ADDR, (u32)cdbfreqsel << 0=
);
+}
+
+/*
+ * @brief SPI_CLK_CTRL register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    05:00 SPI_CLK_BITMAP            0xE
+ * </pre>
+ */
+#define RICU_SPI_CLK_CTRL_ADDR        (REG_RICU_BASE_ADDR + 0x000000E4)
+#define RICU_SPI_CLK_CTRL_OFFSET      0x000000E4
+#define RICU_SPI_CLK_CTRL_INDEX       0x00000039
+#define RICU_SPI_CLK_CTRL_RESET       0x0000000E
+
+static inline void ricu_spi_clk_ctrl_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_SPI_CLK_CTRL_ADDR, value);
+}
+
+/*
+ * @brief FEM_CONF_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    23:20 FEM5_CTL_SEL              0x5
+ *    19:16 FEM4_CTL_SEL              0x4
+ *    15:12 FEM3_CTL_SEL              0x3
+ *    11:08 FEM2_CTL_SEL              0x2
+ *    07:04 FEM1_CTL_SEL              0x1
+ *    03:00 FEM0_CTL_SEL              0x0
+ * </pre>
+ */
+#define RICU_FEM_CONF_0_ADDR        (REG_RICU_BASE_ADDR + 0x000000F0)
+#define RICU_FEM_CONF_0_OFFSET      0x000000F0
+#define RICU_FEM_CONF_0_INDEX       0x0000003C
+#define RICU_FEM_CONF_0_RESET       0x00543210
+
+static inline void ricu_fem_conf_0_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_FEM_CONF_0_ADDR, value);
+}
+
+/*
+ * @brief FEM_CONF_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    23:20 FEM11_CTL_SEL             0xd
+ *    19:16 FEM10_CTL_SEL             0xc
+ *    15:12 FEM9_CTL_SEL              0xb
+ *    11:08 FEM8_CTL_SEL              0xa
+ *    07:04 FEM7_CTL_SEL              0x9
+ *    03:00 FEM6_CTL_SEL              0x8
+ * </pre>
+ */
+#define RICU_FEM_CONF_1_ADDR        (REG_RICU_BASE_ADDR + 0x000000F4)
+#define RICU_FEM_CONF_1_OFFSET      0x000000F4
+#define RICU_FEM_CONF_1_INDEX       0x0000003D
+#define RICU_FEM_CONF_1_RESET       0x00DCBA98
+
+static inline void ricu_fem_conf_1_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, RICU_FEM_CONF_1_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTRL_36_PHY_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    07    PHY1_ADC_ALWAYS_EN_LD_IR  0
+ *    06    PHY1_ADC_ALWAYS_EN_LD_AVDQ 0
+ *    05    PHY1_ADC_ALWAYS_EN_LD_AVDI 0
+ *    04    PHY1_ADC_ALWAYS_EN_ADCQ   0
+ *    03    PHY1_ADC_ALWAYS_EN_ADCI   0
+ *    01    PHY1_HW_MODE_DAC          0
+ *    00    PHY1_HW_MODE_ADC          0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_36_PHY_1_ADDR        (REG_RICU_BASE_ADDR + 0x000000F=
8)
+#define RICU_AFE_CTRL_36_PHY_1_OFFSET      0x000000F8
+#define RICU_AFE_CTRL_36_PHY_1_INDEX       0x0000003E
+#define RICU_AFE_CTRL_36_PHY_1_RESET       0x00000000
+
+static inline u32 ricu_afe_ctrl_36_phy_1_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR);
+}
+
+static inline void ricu_afe_ctrl_36_phy_1_set(struct cl_chip *chip, u32 va=
lue)
+{
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_IR_BIT    ((u32)0x00000080=
)
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_IR_POS    7
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDQ_BIT    ((u32)0x000000=
40)
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDQ_POS    6
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDI_BIT    ((u32)0x000000=
20)
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDI_POS    5
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCQ_BIT    ((u32)0x00000010)
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCQ_POS    4
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCI_BIT    ((u32)0x00000008)
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCI_POS    3
+#define RICU_AFE_CTRL_36_PHY_1_HW_MODE_DAC_BIT    ((u32)0x00000002)
+#define RICU_AFE_CTRL_36_PHY_1_HW_MODE_DAC_POS    1
+#define RICU_AFE_CTRL_36_PHY_1_HW_MODE_ADC_BIT    ((u32)0x00000001)
+#define RICU_AFE_CTRL_36_PHY_1_HW_MODE_ADC_POS    0
+
+static inline void ricu_afe_ctrl_36_phy_1_hw_mode_dac_setf(struct cl_chip =
*chip, u8 phy1hwmodedac)
+{
+       ASSERT_ERR_CHIP((((u32)phy1hwmodedac << 1) & ~((u32)0x00000002)) =
=3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR) & ~((u32)0x00000002)) | ((u32)phy1hw=
modedac << 1));
+}
+
+static inline void ricu_afe_ctrl_36_phy_1_hw_mode_adc_setf(struct cl_chip =
*chip, u8 phy1hwmodeadc)
+{
+       ASSERT_ERR_CHIP((((u32)phy1hwmodeadc << 0) & ~((u32)0x00000001)) =
=3D=3D 0);
+       cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR, (cl_reg_read_c=
hip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR) & ~((u32)0x00000001)) | ((u32)phy1hw=
modeadc << 0));
+}
+
+/*
+ * @brief AFE_ADC_CH_ALLOC register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    07:00 AFE_ADC_CH_ALLOC          0xFF
+ * </pre>
+ */
+#define RICU_AFE_ADC_CH_ALLOC_ADDR        (REG_RICU_BASE_ADDR + 0x000000FC=
)
+#define RICU_AFE_ADC_CH_ALLOC_OFFSET      0x000000FC
+#define RICU_AFE_ADC_CH_ALLOC_INDEX       0x0000003F
+#define RICU_AFE_ADC_CH_ALLOC_RESET       0x000000FF
+
+/* Field definitions */
+#define RICU_AFE_ADC_CH_ALLOC_AFE_ADC_CH_ALLOC_MASK    ((u32)0x000000FF)
+#define RICU_AFE_ADC_CH_ALLOC_AFE_ADC_CH_ALLOC_LSB    0
+#define RICU_AFE_ADC_CH_ALLOC_AFE_ADC_CH_ALLOC_WIDTH    ((u32)0x00000008)
+
+static inline void ricu_afe_adc_ch_alloc_afe_adc_ch_alloc_setf(struct cl_c=
hip *chip, u8 afeadcchalloc)
+{
+       cl_reg_write_chip(chip, RICU_AFE_ADC_CH_ALLOC_ADDR, (u32)afeadcchal=
loc << 0);
+}
+
+#endif /*CL_REG_RICU_H */
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

