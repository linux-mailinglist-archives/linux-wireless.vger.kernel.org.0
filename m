Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CB13AB8AD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhFQQJr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:47 -0400
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:44832
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232021AbhFQQIa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmaYjZqz7+XU1kXhkjHdVuIUTHw0J53R+Nvs2DSglOvndJk5g/DW9vrx+7nVTCz3nclU30Uk9USKzgCYDOdL14Q2vscOLLrQc6id9S04uG8uv1zCWeSmjsCkFsCwamJxdmclwBVStf3rq1bz1XGPhuGEUIpRZBpSw71HahzjoR1GNpXntocOC018bK/MThwV4M1Rj+nnbyRoRWU9C04KPvrL8t7Mkxzz4gmN6lpcv2/8SW6BPNI30vR9g7EthD9NOsZijp+sXzXw5EO/JGwWQpr8fNxZpjoIHD64LvrEyDkRDCAvYVAnWDLT3MMQbIvuEGzRb0y9BtM59a0QZFczBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Agf7G62pd7Iku3lSzr1o+QYBmwkv4rPPSkwE0Rxja7s=;
 b=AWyrbn7wG6+/XF045CLNNPYXLU/IGzuIrLid5OFcgmB3sDQ8LrDyYWHNghvuLhap9gutlYtoy8uLe55m+cS9cdQye2HcFS+PgFnHabhuEvQs71qNsI6WZHSH9PWpscFGNxsPgyR+F/BWnYrJ08SGvXpxbDCoF3LfT1VFif+ydtlYEG3hSKPWQrug9xOC9VVylm/V+QMolbo6mk8VaGtrGSrNIrJaynv4rcUXOzFoDvFoF58JjAP98fA3rkTvzvM836SxQ5jmjfviFyllCdjseShCfyM5wHsmJ7gUqW93a5aMPBnb4krwbj0S6NMe4yc7ZBXRCHpWTvzS29ANAAMGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Agf7G62pd7Iku3lSzr1o+QYBmwkv4rPPSkwE0Rxja7s=;
 b=TcoQHOM/4au2wrJ8uGGun35wNpAAqOisHNi3xe/cKZttgdEjZFsl2ix/RXWy8n0Ku2OswXDqG5WreflHoc79SrAwKjib5x2c1RXe+oplI6Z2FS8kXkfTI+TJi6MaJbP5VlSAp05rF/nFXh/i6jPOKY4T3vmXeaBNpJRftsDsSzE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1314.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:44 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:44 +0000
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
Subject: [RFC v1 125/256] cl8k: add phy/phy.c
Date:   Thu, 17 Jun 2021 16:00:12 +0000
Message-Id: <20210617160223.160998-126-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 586c96e5-3d50-425d-6f75-08d931a9a3bc
X-MS-TrafficTypeDiagnostic: AM9P192MB1314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1314EAF181AF7B0F90B18F6DF60E9@AM9P192MB1314.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHqr9KE+B9CphE1FuHWLzq7SX7mtvlRlf/a3tApEHOJ5R2ZEiecf4P3IDEXmK3F1wPUIun89JEaRx66VqMdXOMvRrcnRb4BRjsXjz+pR/0zfQzBN04n0claSTHzkzD3GGBbyP10g73bm/2SMUfKNkW3ayFBbC03K5sDUnPzlHsS+jk+3w8fCZ4jcMekchEP4u12M60/ySr1rsyXYZyEJcgTiC2kp9O0hXtKmX/3jIW+VmRCSmCdRkQRFsnVnm1cbTaQcTao4fcQsO8kGmGl/nQkCt/PiyjayQmX5iFd/IIVgRQ7eeHfPRJvF4cpEta4IVM1fFjel6rM3SBbYnqSepCeG/AxFokd0jGuFj+NwiwJq6J/PMXHS9f3CEpolokk3lg/PxtVrXdp6voUXO9ETL24TeBffnrZXnlHA8ftGm2ucN5ZS67Ojz7rdJq3CK2lbaY9YunGbKobVvpckhKBF3M4+lRIbY1AkD4gFC//F05gtZl9pUXbx51JyKAhqdSCSIEQYWgCQhr1KCvDBytRjB6b4w7fjGFGL8J0+U79O9wF9Rg9dFd68CMqFO3WDPLKsuVXobFWZp3FGZ5EmD3q0vSkYWSDvihoYSfSW2iENGJ49QduyFFAxHPOiNitBN6i0srYkoq2RyVDFOJvgbv3IT0x2z7jV9UyNQUYf0rxSJJB2g/89oPFUOyy/bsEWytnGZVQlXF8UprbWOs/ODrnFEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(376002)(136003)(346002)(8936002)(66946007)(83380400001)(186003)(5660300002)(26005)(36756003)(86362001)(8676002)(55236004)(1076003)(6916009)(2906002)(6506007)(66476007)(478600001)(6666004)(30864003)(38350700002)(52116002)(66556008)(956004)(4326008)(107886003)(54906003)(38100700002)(6486002)(2616005)(316002)(16526019)(6512007)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUswOTPEgmLA7AVfQowT7EZ9Qp2I4RuBM7ki9ddlx55uZTP9WxaLWyM7bWCf?=
 =?us-ascii?Q?68n+YrgooAgpfaauaaQByGG4mqsXD1LhI/HwQy5f7JX6E1EA1dz4Kd7ca20Q?=
 =?us-ascii?Q?H7YwM5APk4JhH9EkTYTLigEZ4IWZWUwASOmF3XUYVcj1U0P29jkBkD9ZOVRX?=
 =?us-ascii?Q?uVrftdv/Gm3b5E2W0BKO6jldWUvtCMe+1YN3ETOsxOI+opI/RkjRtc7xSVbR?=
 =?us-ascii?Q?eZKMhh/5p8FsgW+k/f0VB18MVFCgusmKYQYIzbpWv179jcNVVs+Lb4Wcr3Oz?=
 =?us-ascii?Q?OirZwygw99YmQurjdQdvUauyQX5RNX5cf+2l+/BRUPgVj1wsfg49BrTsZk0W?=
 =?us-ascii?Q?bOSXHiysehGHyPf/ns8b9CWBf38Mlilwj7DFaT5h1w3ARJB2SuUlIkPeCNtQ?=
 =?us-ascii?Q?NkPTe9NA1U/TSgYywM1CAx5/r8o65saAFiBNdK1W9RAQTXBN+r5Pf6z6w8IF?=
 =?us-ascii?Q?QnjbeGheDgRziTfc8EKxW+zRyK19L/FjYlFd+puT4lGq2i4egwurDeca9VUe?=
 =?us-ascii?Q?7LWhhivC+1TKhxxWvdnGLSg3SqjCoMpGHrJEfP/az1tK4aYelkqjb8pr1L7Z?=
 =?us-ascii?Q?Fv+DG5at+Oy5UZmGab+U0Cu8Bo31fL8sJOeHfDmTxJbgqvRdahA7arsRRYPz?=
 =?us-ascii?Q?6d6t2Mw4IwnxinfUoYXHDa1GfBKcrpex91PnMWdRRPMHQlLVAHzFh05AeSIW?=
 =?us-ascii?Q?/eSf0vZvecyzAqBBp15XlBJOgnzF3cdR4ygCaTTdwTsmuuoRlZiDbWyYH3Ke?=
 =?us-ascii?Q?EpXvNAfAV6Km3lV2TZsKDmnsvnXQ22xTQBFcMyojzdlhifphjlGIcURiwda0?=
 =?us-ascii?Q?I9dE+vC75I9L+bfUITmm+bIry+yP/xhxw9JZPuOu8/kH2+9RyuOJYLrrGXqj?=
 =?us-ascii?Q?+WOXv5QkIlAf3SbRdJqn6/IeAw62N3+e6IFJ2Fir+a87JKTE0R55QL+KNUyW?=
 =?us-ascii?Q?sGuBxPrgU0oT/0GBO3nkip8CvHPagt4NxpD4r+OOZr8oCT9GXy9kArkEHDJq?=
 =?us-ascii?Q?H9fF4t/+DJHS0mty2XKFmfaPW1GkpmtoSeHgwB/4aOihVEXzxXB/sbvoHp+7?=
 =?us-ascii?Q?gNaMWw0WeEukPlfn0pr+0AFBkzLyOaFgzEuHrzfG3n/cgjLWwL9K637IqRY4?=
 =?us-ascii?Q?6sA1AzUyizDLsMnHJjerQ6AZgYNiy91qR8LfCLREgdEyv6aaWWVh5mgJkhd1?=
 =?us-ascii?Q?iW441yG7SbYQvLQmFrySFQ4w+0zbQ9BjAj4By8wvjM4d0jK+CaeCmgUllSeS?=
 =?us-ascii?Q?rPjdCRzpesD5+ZR0eaL75gX300/XhhCIY1wMaeXbhsxPn0HjqlTEeZiESfEd?=
 =?us-ascii?Q?hiBh5B2A9jYaoupoCEQP4wUz?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586c96e5-3d50-425d-6f75-08d931a9a3bc
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:51.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yr0Vyi+TX/m8+71nutoSa1TTSfNTO+bL8z8A08SMUi54pYxopJlh8NUCRK1vI2e1t3UfCmPmnXgj8byoMZZ2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1314
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/phy/phy.c | 272 +++++++++++++++++++++
 1 file changed, 272 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy.c

diff --git a/drivers/net/wireless/celeno/cl8k/phy/phy.c b/drivers/net/wirel=
ess/celeno/cl8k/phy/phy.c
new file mode 100644
index 000000000000..f58c7f83f600
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/phy/phy.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "phy/phy.h"
+#include "reg/reg_modem_gcu.h"
+#include "reg/reg_cmu.h"
+#include "reg/reg_mac_hw.h"
+#include "reg/reg_mac_hw_mu.h"
+#include "reg/reg_macsys_gcu.h"
+#include "reg/reg_lcu_phy.h"
+#include "rf_boot.h"
+#include "dsp.h"
+
+static void ceva_disable(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       if (cl_hw_is_tcv0(cl_hw)) {
+               cmu_phy_0_rst_ceva_0_global_rst_n_setf(chip, 0);
+               cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 0);
+       } else {
+               cmu_phy_1_rst_ceva_1_global_rst_n_setf(chip, 0);
+               cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 0);
+       }
+}
+
+static void ceva_reset(struct cl_hw *cl_hw)
+{
+       if (cl_hw_is_tcv0(cl_hw))
+               cmu_phy_0_rst_set(cl_hw->chip, CMU_PHY0_RST_EN);
+       else
+               cmu_phy_1_rst_set(cl_hw->chip, CMU_PHY1_RST_EN);
+}
+
+static void phy_disable(struct cl_hw *cl_hw)
+{
+       /* Modem GCU modules - Reset */
+
+       /* Disable clocks (reset is not asserted) */
+       modem_gcu_mpu_set(cl_hw, MODEM_GCU_MPU_RST_N_BIT | MODEM_GCU_MPU_RE=
G_RST_N_BIT);
+       modem_gcu_bpu_set(cl_hw, MODEM_GCU_BPU_RST_N_BIT | MODEM_GCU_BPU_RX=
_RST_N_BIT |
+                         MODEM_GCU_BPU_TX_RST_N_BIT | MODEM_GCU_BPU_REG_RS=
T_N_BIT);
+       modem_gcu_tfu_set(cl_hw, MODEM_GCU_TFU_RST_N_BIT | MODEM_GCU_TFU_RE=
G_RST_N_BIT);
+       modem_gcu_smu_set(cl_hw, MODEM_GCU_SMU_RST_N_BIT | MODEM_GCU_SMU_RE=
G_RST_N_BIT);
+       modem_gcu_spu_set(cl_hw, MODEM_GCU_SPU_RST_N_BIT | MODEM_GCU_SPU_RE=
G_RST_N_BIT);
+       modem_gcu_bf_set(cl_hw, MODEM_GCU_BF_RST_N_BIT | MODEM_GCU_BF_REG_R=
ST_N_BIT);
+       modem_gcu_epa_set(cl_hw, MODEM_GCU_EPA_RST_N_BIT | MODEM_GCU_EPA_RE=
G_RST_N_BIT);
+       modem_gcu_lcu_set(cl_hw, MODEM_GCU_LCU_HLF_RST_N_BIT | MODEM_GCU_LC=
U_RST_N_BIT |
+                         MODEM_GCU_LCU_REG_RST_N_BIT);
+       modem_gcu_mux_fic_set(cl_hw, MODEM_GCU_MUX_FIC_SOFT_RST_N_BIT |
+                             MODEM_GCU_MUX_FIC_RST_N_BIT);
+       modem_gcu_riu_clk_set(cl_hw, 0);
+       modem_gcu_riu_clk_1_set(cl_hw, 0);
+
+       /* Assert reset (clocks already disabled) */
+       modem_gcu_mpu_set(cl_hw, 0);
+       modem_gcu_bpu_set(cl_hw, 0);
+       modem_gcu_tfu_set(cl_hw, 0);
+       modem_gcu_smu_set(cl_hw, 0);
+       modem_gcu_spu_set(cl_hw, 0);
+       modem_gcu_bf_set(cl_hw, 0);
+       modem_gcu_epa_set(cl_hw, 0);
+       modem_gcu_lcu_set(cl_hw, 0);
+       modem_gcu_mux_fic_set(cl_hw, MODEM_GCU_MUX_FIC_SOFT_RST_N_BIT);
+       modem_gcu_riu_rst_set(cl_hw, 0);
+}
+
+static void phy_reset(struct cl_hw *cl_hw)
+{
+       /* Isolate FIC bus in case CEVA reset is not required */
+       modem_gcu_mux_fic_config_fic_isolate_setf(cl_hw, 1);
+       while (modem_gcu_mux_fic_config_fic_isolated_getf(cl_hw) =3D=3D 0)
+               ;
+       modem_gcu_mux_fic_config_fic_isolate_setf(cl_hw, 0);
+
+       /*
+        * Stop the LCU recording.
+        * Stop on one channel actually stops the recording on all channels=
.
+        * This stop is required because PHY LCU is going to be reset.
+        */
+       if (cl_hw_is_tcv0(cl_hw))
+               lcu_phy_lcu_ch_0_stop_set(cl_hw, 1);
+       else
+               lcu_phy_lcu_ch_1_stop_set(cl_hw, 1);
+
+       /* PHY reset sequence */
+       phy_disable(cl_hw);
+}
+
+static void phy0_off(struct cl_chip *chip)
+{
+       /* Disable APB0 clock but keep other clocks (main clock and DSP0 cl=
ock) active */
+       cmu_phy_0_clk_en_pack(chip, 1, 0, 1);
+       /* DSP0, MPIF0, APB0 reset */
+       cmu_phy_0_rst_set(chip, CMU_PHY_0_RST_N_BIT);
+       /* DSP0, MPIF0 are still in reset, but take APB0 out of reset to al=
low writing to GCU */
+       cmu_phy_0_rst_set(chip, CMU_PHY_0_RST_N_BIT | CMU_PHY_0_PRESET_N_BI=
T);
+       /* Enable APB0 clock (all other clocks are already active) */
+       cmu_phy_0_clk_en_phy_0_apb_clk_en_setf(chip, 1);
+}
+
+static void phy1_off(struct cl_chip *chip)
+{
+       /* Disable APB0 clock but keep other clocks (main clock and DSP0 cl=
ock) active */
+       cmu_phy_1_clk_en_pack(chip, 1, 0, 1);
+       /* DSP0, MPIF0, APB0 reset */
+       cmu_phy_1_rst_set(chip, CMU_PHY_0_RST_N_BIT);
+       /* DSP0, MPIF0 are still in reset, but take APB0 out of reset to al=
low writing to GCU */
+       cmu_phy_1_rst_set(chip, CMU_PHY_0_RST_N_BIT | CMU_PHY_0_PRESET_N_BI=
T);
+       /* Enable APB0 clock (all other clocks are already active) */
+       cmu_phy_1_clk_en_phy_1_apb_clk_en_setf(chip, 1);
+}
+
+static void phy_off(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       if (cl_hw_is_tcv0(cl_hw))
+               phy0_off(chip);
+       else
+               phy1_off(chip);
+
+       phy_disable(cl_hw);
+}
+
+static void system_ctrl_reg_reset(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       u32 regval =3D macsys_gcu_xt_control_get(chip);
+       u8 i;
+
+       /* Set XMAC_RUN_STALL */
+       regval |=3D cl_hw->controller_reg.run_stall;
+       /* Clear XMAC_OCD_HALT_ON_RESET and clear XMAC_BRESET */
+       regval &=3D ~(cl_hw->controller_reg.ocd_halt_on_reset | cl_hw->cont=
roller_reg.breset);
+
+       /* Reset MACHW */
+       macsys_gcu_xt_control_set(chip, regval);
+
+       for (i =3D 0; i < cl_hw->max_mu_cnt; i++)
+               mac_hw_mu_mac_cntrl_2_set(cl_hw, 1, i);
+}
+
+void cl_phy_off(struct cl_hw *cl_hw)
+{
+       system_ctrl_reg_reset(cl_hw);
+       phy_off(cl_hw);
+       ceva_disable(cl_hw);
+}
+
+static void save_ela_state(struct cl_hw *cl_hw)
+{
+       struct cl_recovery_db *recovery_db =3D &cl_hw->recovery_db;
+
+       /* Save eLA state before MAC-HW reset */
+       recovery_db->ela_en =3D mac_hw_debug_port_en_get(cl_hw);
+
+       if (recovery_db->ela_en) {
+               recovery_db->ela_sel_a =3D mac_hw_debug_port_sel_a_get(cl_h=
w);
+               recovery_db->ela_sel_b =3D mac_hw_debug_port_sel_b_get(cl_h=
w);
+               recovery_db->ela_sel_c =3D mac_hw_debug_port_sel_c_get(cl_h=
w);
+       }
+}
+
+void cl_phy_reset(struct cl_hw *cl_hw)
+{
+       save_ela_state(cl_hw);
+       system_ctrl_reg_reset(cl_hw);
+       phy_reset(cl_hw);
+       ceva_reset(cl_hw);
+}
+
+int cl_phy_load_recovery(struct cl_hw *cl_hw)
+{
+       int ret =3D cl_rf_boot_recovery(cl_hw);
+
+       if (ret) {
+               cl_dbg_err(cl_hw, "cl_rf_boot_recovery failed %d\n", ret);
+               return ret;
+       }
+
+       /* Load DSP */
+       ret =3D cl_dsp_load_recovery(cl_hw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "cl_dsp_load_recovery failed %d\n", ret);
+               return ret;
+       }
+
+       /*
+        * FIXME: It looks like there is a bug in the DSP. If we poll REG_C=
FG_SPACE
+        * (0x600018) at this point to verify that DSP has been initialized
+        * successfully, we read '1' and continue.
+        * However, the calibration fails.
+        *
+        * Please note that this is a WORKAROUND, not a final fix.
+        * The problem should be investigated
+        * further by the DSP team.
+        */
+       msleep(500);
+       return 0;
+}
+
+int cl_phy_data_alloc(struct cl_hw *cl_hw)
+{
+       struct cl_phy_data *buf =3D NULL;
+       u32 len =3D (u32)PAGE_SIZE;
+       dma_addr_t phys_dma_addr;
+
+       buf =3D dma_alloc_coherent(cl_hw->chip->dev, len, &phys_dma_addr, G=
FP_KERNEL);
+
+       if (!buf)
+               return -1;
+
+       cl_hw->phy_data_info.data =3D buf;
+       cl_hw->phy_data_info.dma_addr =3D cpu_to_le32(phys_dma_addr);
+
+       return 0;
+}
+
+void cl_phy_data_free(struct cl_hw *cl_hw)
+{
+       dma_addr_t phys_dma_addr =3D le32_to_cpu(cl_hw->phy_data_info.dma_a=
ddr);
+
+       if (!cl_hw->phy_data_info.data)
+               return;
+
+       dma_free_coherent(cl_hw->chip->dev, PAGE_SIZE,
+                         (void *)cl_hw->phy_data_info.data, phys_dma_addr)=
;
+       cl_hw->phy_data_info.data =3D NULL;
+}
+
+void cl_phy_enable(struct cl_hw *cl_hw)
+{
+       /* Modem GCU modules - De-assert Reset */
+
+       /* De-assert reset (clocks disabled) */
+       modem_gcu_mpu_set(cl_hw, MODEM_GCU_MPU_RST_N_BIT | MODEM_GCU_MPU_RE=
G_RST_N_BIT);
+       modem_gcu_bpu_set(cl_hw, MODEM_GCU_BPU_RST_N_BIT | MODEM_GCU_BPU_RX=
_RST_N_BIT |
+                         MODEM_GCU_BPU_TX_RST_N_BIT | MODEM_GCU_BPU_REG_RS=
T_N_BIT);
+       modem_gcu_tfu_set(cl_hw, MODEM_GCU_TFU_RST_N_BIT | MODEM_GCU_TFU_RE=
G_RST_N_BIT);
+       modem_gcu_smu_set(cl_hw, MODEM_GCU_SMU_RST_N_BIT | MODEM_GCU_SMU_RE=
G_RST_N_BIT);
+       modem_gcu_spu_set(cl_hw, MODEM_GCU_SPU_RST_N_BIT | MODEM_GCU_SPU_RE=
G_RST_N_BIT);
+       modem_gcu_bf_set(cl_hw, MODEM_GCU_BF_RST_N_BIT | MODEM_GCU_BF_REG_R=
ST_N_BIT);
+       modem_gcu_epa_set(cl_hw, MODEM_GCU_EPA_RST_N_BIT | MODEM_GCU_EPA_RE=
G_RST_N_BIT);
+       modem_gcu_lcu_set(cl_hw, MODEM_GCU_LCU_HLF_RST_N_BIT | MODEM_GCU_LC=
U_RST_N_BIT |
+                         MODEM_GCU_LCU_REG_RST_N_BIT);
+       modem_gcu_mux_fic_set(cl_hw, MODEM_GCU_MUX_FIC_SOFT_RST_N_BIT |
+                             MODEM_GCU_MUX_FIC_RST_N_BIT);
+       modem_gcu_riu_rst_set(cl_hw, MODEM_GCU_RIU_FE_RST_N_BIT | MODEM_GCU=
_RIU_AGC_RST_N_BIT |
+                             MODEM_GCU_RIU_MDM_B_RST_N_BIT | MODEM_GCU_RIU=
_LB_RST_N_BIT |
+                             MODEM_GCU_RIU_RC_RST_N_BIT | MODEM_GCU_RIU_RA=
DAR_RST_N_BIT |
+                             MODEM_GCU_RIU_RST_N_BIT | MODEM_GCU_RIU_REG_R=
ST_N_BIT);
+
+       /* Enable clocks */
+       modem_gcu_mpu_set(cl_hw, 0xFFFFFFFF);
+       modem_gcu_bpu_set(cl_hw, 0xFFFFFFFF);
+       modem_gcu_tfu_set(cl_hw, 0xFFFFFFFF);
+       modem_gcu_smu_set(cl_hw, 0xFFFFFFFF);
+       modem_gcu_spu_set(cl_hw, 0xFFFFFFFF);
+       modem_gcu_bf_set(cl_hw, 0xFFFFFFFF);
+       modem_gcu_epa_set(cl_hw, 0xFFFFFFFF);
+       modem_gcu_lcu_set(cl_hw, 0xFFFFFFFF);
+       modem_gcu_mux_fic_set(cl_hw, 0xFFFFFFFF);
+       modem_gcu_riu_clk_set(cl_hw, 0xFFFFFFFF);
+       modem_gcu_riu_clk_1_set(cl_hw, 0xFFFFFFFF);
+
+       /*
+        * Configure minimum latency between 2 masters connected
+        * to same FIC, Read/Write transaction
+        */
+       modem_gcu_mux_fic_config_set(cl_hw, 0x00000808);
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

