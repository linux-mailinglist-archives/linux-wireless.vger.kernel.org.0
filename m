Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B873AB906
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhFQQMA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:00 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:64066
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231455AbhFQQKo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azRdw3RMpzE58/dMHOmaGXwN/LraPbVXVRUi6w/Shphn6MEueuGi75nevjYiCPIcPI+SMcMXj7tn0LN+7/JoYcvXjoZwa7FP7r8VGD3rRly3QRaVE+oj77qTnQuxeDh7jBhJjzVl3VkUkUeJXeBFZftSpBRbBNBXZe40J5hshF07jPDeJumIZ6+PqfFAxliooBgJhIUNDjwQW56Z/c1Y+ne/y/bBvmqKJOFnwQOKtpx+m+yXACR5ra2GX6OImFs8lIn09eKnEjvXj8FS6AhyvIDdU+RMLReFjND5I3caAnxXpzPLqeZLHL54lGJBCw/+HQUxEm3UfIgWH2yt9l3lLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+LFlL72JcIHEZRkNIRjT3aQzwUkQfeiHWGgMfpGTxA=;
 b=MnUTtgZUVJGsyhYSpu0/B85uPVxw6IaAlpRL7cov0nC3dGaKhHcvPrKTIlRCLKbHkLC4I2TQz8UNhhN+VBv2OUX9PkBZcV9ZfS46gjNANKgoqBcakO0cOIWnon0SNh6nT5ZGiaqSHss9CfnHtqdZHuquct0BtQVNLibrynXh2e9o4qhXmUjxrgxSLxfd8fnvTk9I4fzOAmFs739rkwTLCO/458BIzM6ML29hntG10PODBRXlPniX2hkp18agZtTLT6SYPbUT2d1L2E0rompS4SFVWZW7zoZ/jWK/LnFDM/dVJypBMhI3sFjxzNDWP4YoPYpGzkhL1ADCWfFaCjDfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+LFlL72JcIHEZRkNIRjT3aQzwUkQfeiHWGgMfpGTxA=;
 b=qhVzsTsULf6E5gFwKTqyR6dTl7qC6ayD1OuBtqXanxWgm0aw9o29Q0sRiBsgMt/iuZMZgG+2AATXNRVareG3W9wXA2268Re0wKrPdGG9OBhzLu3Rt5JG8u4Qzh83t3AbJW/cERfD+Tk3bDB3jYDLgSyeTBY2r4KvxFW+UIY93+Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:30 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:30 +0000
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
Subject: [RFC v1 166/256] cl8k: add rf_boot.c
Date:   Thu, 17 Jun 2021 16:00:53 +0000
Message-Id: <20210617160223.160998-167-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7268f07c-aae8-4232-6be9-08d931a9be39
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB118755A5F647BAC1B0C0D04FF60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqVFKQbLcOfT617yw/uW6LOF2N3eIoUYpxz3bx+VUkzMFNrJp+NSz5pwheBMaVkkWBC3RaG1Eq4f+8d6BdaDIzSEVExOEipGxKz7oNtYOOzhuse0Qtfx864UiRWODJ/3jmPH4mV1rny3U3boQ2xKigO6DKBe2WM/5EYflzeOHkTCvuFR1BZ4VB2Z0vb05fv22oVlEhvw+DGQiVw/B850SmNRczNuxtnyVccAoHSZmA9pb+QdkXlplkbBwJuB17V9yamWqD9lyynZMXaC3sfeBWwyiVK3wWfD6u2PeF8ER/7DbDLew8cCldrok/xls4mSp0IatnVrffihmIZhhP9vfC/RrbV0LClwJlZ4x+Q96cxhgAc+D/RS+qHbYPyakQFfUq/2apspC6nWVlddUc9RvygisiuQivIf2NeHhS8wSECDQI7hnUdtNusuRbaU661X2qwuEmYEFjcq5VJc0FIXnSWteNw4BURcQNOVO/xoscLLbkkCrzrv7L0cBpbO+yS6oVuu0RWr+n4YK80D5NwEIQbtQ5o/O/Rr/5UcjY65E7BUSKXeZtSZob6lru3Mjt3Zg7+x0KJc/1GhQ2JZ6K3rQgo/m2kRBSkAXBrqHx6UbKrvWoCnO7u9PmnKK3TO2ajxV2QZzzTOQutSRf7djg5mSMIv1ke+oo6TevJeJ39GddK8f6vBJezo9K2MWuYjd0ZZvkYMRyXfOXbjOpUbH1J1Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(30864003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p+hq8vmmeVXlH8sghDPRparkVdB8GZXcbnWOz3NPB0GbpzQtrvbuN3XQjHdE?=
 =?us-ascii?Q?Yc5OVmplVNa2uQ5oLDPADD3DBTA/nwSJKddFRRzMgt3bN6H7jsf08dOPaHi6?=
 =?us-ascii?Q?KAPrVCQT91Z2DorNc5xJWoeKwSoCUvOiGK0hsIjPc198TIZlqG9oMN189OT4?=
 =?us-ascii?Q?ZqpTpb7Z+mmXDQJWdqxKzlg1/mGhFI5WLtZFvSDLQDQc3RUdM6upeAnpWAJQ?=
 =?us-ascii?Q?sK5SwwkVx7tdMvEFAYCF9jDJ5v4dFdsoPB+IISImydq4VCpmAveH4ZqybqAG?=
 =?us-ascii?Q?qC5oRZ04KIv8PpJ1FP7wKmX60C27EtAaG+qGYD40nZm1KOxcXJNgNyafdXaO?=
 =?us-ascii?Q?zxt1pwAbyDkfNnP20mr5Z+zAJO9WmvLasUCOLVH1a9V5qbZ+VGsjOWtTgpsW?=
 =?us-ascii?Q?r2n3EO1I7E6iZv0DHQsSl0Mc9WyLD/91ua9vn6jQi57Zip7Djs5QyCVYwUav?=
 =?us-ascii?Q?bM6Ko/rfnbAhmf/wybS5t2GvNDw4ZuSMW/4RcKmIjAOG7+2h2AfbELsuai0h?=
 =?us-ascii?Q?VvrrGnwfxbDcAr6fK/8/U6yWl0badPMIBqGWCezKsb+rwkNaDBgIjVt9gba6?=
 =?us-ascii?Q?cQ9n5q+3aljGdEc5OeEvmdGr8cA9Tejy30x7Vo03UU0YJsl/YJeaCm37FJJm?=
 =?us-ascii?Q?/PPx9domaTmzXk/O+qMd/NXj6PhciZxUHM/rlTjX0Ox9c/SWXdeUE19GRqkO?=
 =?us-ascii?Q?qbBcvmMtCdSv5aXOvfvGo919mL87op+SLcQ+RKJ9lGjL765rZWNkROmU/XNs?=
 =?us-ascii?Q?pFD1qESykQGBCZ4du4HH9lnJxC4mERt33Zb/FAJ2sLfFwmKPA821NbHaTe22?=
 =?us-ascii?Q?PQnCoE7JLqtEj/SCkUnBbPvT17ZCqRnA5cDObzJBr+3//hjY8YjniQRTpbe3?=
 =?us-ascii?Q?r5fmdWbmC8KRzD4RmC6+68u/tWEMfqpc6ZX6oM/+YFFWYM7BSOBVU1tmzJdz?=
 =?us-ascii?Q?OoskuiQh3ZwOPiP4/GBZALwd1Ml6IL1PHifOn/REsZ7sLB1vshXLq+iid/VY?=
 =?us-ascii?Q?exq38AIGIftCkQ98lTsijGuu54hgD9+2QTALJT4Ja49YKcFPR0yOz1KG11ut?=
 =?us-ascii?Q?VvB5ujOlFXecocYnpv5Oxv4woE+e6HYtA3Fc3YUHxjoH5Qxm8Uu44WSx9Z9A?=
 =?us-ascii?Q?NxppiA8/nfyCsIhw32a77uU2jbu4rk9Epb5hLC55CoI2MncBUPmXLDZaN64v?=
 =?us-ascii?Q?Hyq1pSBuQNL2EV1IGpOqAdo/4P8OM8RAssXA20ZgK94s66oi2mPE2h5jhy3R?=
 =?us-ascii?Q?RA0L7SVS7Cp/z1BWh5xepE/T+PxH8pBVLgufKYel21Ptph5Sf7YZpQk+K4r2?=
 =?us-ascii?Q?jOIHQ2NivwOdC9QxwmmPxci4?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7268f07c-aae8-4232-6be9-08d931a9be39
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:36.1658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6E3nUFF1qxCMzNilP8xKO6XkZQ8RAtYvm5oW7+nSWNNpXF1LkXtmgC6ncyG7r3131eOmFXtiHUQlCz7joeHEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rf_boot.c | 354 +++++++++++++++++++++
 1 file changed, 354 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rf_boot.c

diff --git a/drivers/net/wireless/celeno/cl8k/rf_boot.c b/drivers/net/wirel=
ess/celeno/cl8k/rf_boot.c
new file mode 100644
index 000000000000..4202c153661b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rf_boot.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "rf_boot.h"
+#include "hw.h"
+#include "afe.h"
+#include "utils/file.h"
+#include "phy/phy.h"
+#include "reg/reg_access.h"
+#include "reg/reg_cmu.h"
+#include "reg/reg_modem_gcu.h"
+#include "reg/reg_ricu.h"
+#include "reg/reg_riu.h"
+#include "reg/reg_mac_hw.h"
+#include "reg/reg_lcu_phy.h"
+
+static void cl_clk_init(struct cl_chip *chip)
+{
+       cmu_clk_en_set(chip, CMU_MAC_ALL_CLK_EN);
+
+       cmu_phy_0_clk_en_set(chip, CMU_PHY_0_APB_CLK_EN_BIT | CMU_PHY_0_MAI=
N_CLK_EN_BIT);
+       cmu_phy_1_clk_en_set(chip, CMU_PHY_1_APB_CLK_EN_BIT | CMU_PHY_1_MAI=
N_CLK_EN_BIT);
+
+       cmu_phy_0_rst_ceva_0_global_rst_n_setf(chip, 0);
+       modem_gcu_ceva_ctrl_external_wait_setf(chip->cl_hw_tcv0, 1);
+       cmu_phy_0_rst_ceva_0_global_rst_n_setf(chip, 1);
+
+       cmu_phy_1_rst_ceva_1_global_rst_n_setf(chip, 0);
+       modem_gcu_ceva_ctrl_external_wait_setf(chip->cl_hw_tcv1, 1);
+       cmu_phy_1_rst_ceva_1_global_rst_n_setf(chip, 1);
+
+       cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 1);
+       cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 1);
+}
+
+static int cl_pll1_init(struct cl_chip *chip)
+{
+       int retry =3D 0;
+
+       /* Verify pll is locked */
+       while (!cmu_pll_1_stat_pll_lock_getf(chip) && (++retry < 10)) {
+               cl_dbg_chip_verbose(chip, "retry=3D%d\n", retry);
+               usleep_range(100, 200);
+       }
+
+       /* Pll is not locked - fatal error */
+       if (retry =3D=3D 10) {
+               cl_dbg_chip_err(chip, "retry limit reached - pll is not loc=
ked !!!\n");
+               return -1;
+       }
+
+       return 0;
+}
+
+static int cl_cmu_init(struct cl_chip *chip)
+{
+       if (cl_pll1_init(chip))
+               return -1;
+
+       /* Set gl_mux_sel bit to work with pll1 instead of crystal */
+       cmu_control_gl_mux_sel_setf(chip, 1);
+
+       cmu_rst_n_ricurst_setf(chip, 1);
+
+       cmu_phy_0_rst_set(chip, CMU_PHY0_RST_EN);
+       cmu_phy_1_rst_set(chip, CMU_PHY1_RST_EN);
+       cmu_phy_0_rst_set(chip, 0x0);
+       cmu_phy_1_rst_set(chip, 0x0);
+       cmu_rst_n_ricurst_setf(chip, 1);
+       cmu_phy_0_rst_set(chip, CMU_PHY0_RST_EN);
+       cmu_phy_1_rst_set(chip, CMU_PHY1_RST_EN);
+
+       return 0;
+}
+
+static void cl_riu_clk_bw_init(struct cl_hw *cl_hw)
+{
+       u32 regval;
+
+       switch (cl_hw->conf->ce_channel_bandwidth) {
+       case CHNL_BW_20:
+               regval =3D 0x00000100;
+               break;
+       case CHNL_BW_40:
+               regval =3D 0x00000555;
+               break;
+       case CHNL_BW_160:
+               regval =3D 0x00000dff;
+               break;
+       case CHNL_BW_80:
+       default:
+               regval =3D 0x000009aa;
+               break;
+       }
+
+       /* Set RIU modules clock BW */
+       modem_gcu_riu_clk_bw_set(cl_hw, regval);
+}
+
+static int cl_load_riu_rsf_memory(struct cl_chip *chip, const char *filena=
me)
+{
+       struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+       struct cl_hw *cl_hw_tcv1 =3D chip->cl_hw_tcv1;
+       char *buf =3D NULL;
+       loff_t size, i =3D 0;
+       int ret =3D 0;
+
+       size =3D cl_file_open_and_read(chip, filename, &buf);
+
+       if (!buf)
+               return -ENOMEM;
+
+       if (size > RIU_RSF_FILE_SIZE) {
+               ret =3D -EFBIG;
+               goto out;
+       }
+
+       /* Enable re-sampling filter init. */
+       riu_rsf_control_rsf_init_en_setf(cl_hw_tcv0, 0x1);
+       if (cl_hw_tcv1)
+               riu_rsf_control_rsf_init_en_setf(cl_hw_tcv1, 0x1);
+
+       while (i < size) {
+               riu_rsf_init_set(cl_hw_tcv0, *(u32 *)&buf[i]);
+               if (cl_hw_tcv1)
+                       riu_rsf_init_set(cl_hw_tcv1, *(u32 *)&buf[i]);
+               i +=3D 4;
+       }
+
+out:
+       kfree(buf);
+       return ret;
+}
+
+static int cl_load_riu_rsf_memory_recovery(struct cl_hw *cl_hw, const char=
 *filename)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       char *buf =3D NULL;
+       loff_t size, i =3D 0;
+       int ret =3D 0;
+
+       size =3D cl_file_open_and_read(chip, filename, &buf);
+
+       if (!buf)
+               return -ENOMEM;
+
+       if (size > RIU_RSF_FILE_SIZE) {
+               ret =3D -EFBIG;
+               goto out;
+       }
+
+       /* Enable re-sampling filter init. */
+       riu_rsf_control_rsf_init_en_setf(cl_hw, 0x1);
+
+       while (i < size) {
+               riu_rsf_init_set(cl_hw, *(u32 *)&buf[i]);
+               i +=3D 4;
+       }
+
+out:
+       kfree(buf);
+       return ret;
+}
+
+static int cl_load_agc_data(struct cl_hw *cl_hw, const char *filename)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       char *buf =3D NULL;
+       loff_t size, i =3D 0;
+
+       size =3D cl_file_open_and_read(chip, filename, &buf);
+
+       if (!buf)
+               return -ENOMEM;
+
+       /* Enable AGC FSM ram init state */
+       riu_agcfsm_ram_init_1_agc_fsm_ram_init_en_setf(cl_hw, 0x1);
+       /* Start writing the firmware from WPTR=3D0 */
+       riu_agcfsm_ram_init_1_agc_fsm_ram_init_wptr_setf(cl_hw, 0x0);
+       /* Allow WPTR register to be writable */
+       riu_agcfsm_ram_init_1_agc_fsm_ram_init_wptr_set_setf(cl_hw, 0x1);
+       /* Enable auto increment WPTR by 1 upon any write */
+       riu_agcfsm_ram_init_1_agc_fsm_ram_init_ainc_1_setf(cl_hw, 0x1);
+
+       while (i < size) {
+               riu_agcfsm_ram_init_2_set(cl_hw, *(u32 *)&buf[i]);
+               i +=3D 4;
+       }
+
+       /* Disable AGC FSM ram init state */
+       riu_agcfsm_ram_init_1_agc_fsm_ram_init_en_setf(cl_hw, 0x0);
+
+       kfree(buf);
+
+       return 0;
+}
+
+static int cl_load_agc_fw(struct cl_hw *cl_hw, const char *filename)
+{
+       int ret =3D 0;
+
+       /* Switch AGC to programming mode */
+
+       /* Disable RIU Modules clocks (RC,LB,ModemB,FE,ADC,Regs,AGC,Radar) =
*/
+       modem_gcu_riu_clk_set(cl_hw, 0);
+
+       /* Switch AGC MEM clock to 480MHz */
+       modem_gcu_riu_clk_bw_agc_mem_clk_bw_setf(cl_hw, 3);
+
+       /* Enable RIU Modules clocks (RC,LB,ModemB,FE,ADC,Regs,AGC,Radar) *=
/
+       modem_gcu_riu_clk_set(cl_hw, 0xFFFFFFFF);
+
+       /* Assert AGC FSM reset */
+       riu_rwnxagccntl_agcfsmreset_setf(cl_hw, 1);
+
+       /* Load AGC RAM data */
+       ret =3D cl_load_agc_data(cl_hw, filename);
+       if (ret)
+               goto out;
+
+       /* Switch AGC back to operational mode */
+
+       /* Disable RIU Modules clocks (RC, LB, ModemB, FE, ADC, Regs, AGC, =
Radar) */
+       modem_gcu_riu_clk_set(cl_hw, 0);
+       /* Switch AGC MEM clock back to 80M */
+       modem_gcu_riu_clk_bw_agc_mem_clk_bw_setf(cl_hw, 1);
+       /* Enable RIU Modules clocks (RC, LB, ModemB, FE, ADC, Regs, AGC, R=
adar) */
+       modem_gcu_riu_clk_set(cl_hw, 0xFFFFFFFF);
+
+       /* Release AGC FSM reset */
+       riu_rwnxagccntl_agcfsmreset_setf(cl_hw, 0);
+
+out:
+       return ret;
+}
+
+int cl_rf_boot(struct cl_chip *chip)
+{
+       int ret =3D 0;
+       struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+       struct cl_hw *cl_hw_tcv1 =3D chip->cl_hw_tcv1;
+
+       /* Call only once per chip after ASIC reset - configure both phys *=
/
+       ret =3D cl_cmu_init(chip);
+       if (ret !=3D 0)
+               goto out;
+
+       cl_clk_init(chip);
+       cmu_phase_sel_set(chip, (CMU_GP_CLK_PHASE_SEL_BIT |
+                                CMU_DAC_CDB_CLK_PHASE_SEL_BIT |
+                                CMU_DAC_CLK_PHASE_SEL_BIT) &
+                                ~(CMU_ADC_CDB_CLK_PHASE_SEL_BIT |
+                                CMU_ADC_CLK_PHASE_SEL_BIT));
+
+       mac_hw_mac_cntrl_1_active_clk_gating_setf(cl_hw_tcv0, 1); /* Disabl=
e MPIF clock */
+       mac_hw_state_cntrl_next_state_setf(cl_hw_tcv0, 2);        /* Move t=
o doze */
+
+       mac_hw_mac_cntrl_1_active_clk_gating_setf(cl_hw_tcv1, 1); /* Disabl=
e MPIF clock */
+       mac_hw_state_cntrl_next_state_setf(cl_hw_tcv1, 2);        /* Move t=
o doze */
+
+       /* Enable all PHY modules */
+       cl_phy_enable(cl_hw_tcv0);
+       cl_phy_enable(cl_hw_tcv1);
+
+       mac_hw_doze_cntrl_2_wake_up_sw_setf(cl_hw_tcv0, 1); /* Exit from do=
ze */
+       mac_hw_state_cntrl_next_state_setf(cl_hw_tcv0, 0);  /* Move to idle=
 */
+
+       mac_hw_doze_cntrl_2_wake_up_sw_setf(cl_hw_tcv1, 1); /* Exit from do=
ze */
+       mac_hw_state_cntrl_next_state_setf(cl_hw_tcv1, 0);  /* Move to idle=
 */
+
+       cl_riu_clk_bw_init(cl_hw_tcv0);
+       cl_riu_clk_bw_init(cl_hw_tcv1);
+
+       /* Load RIU re-sampling filter memory with coefficients */
+       ret =3D cl_load_riu_rsf_memory(chip, "riu_rsf.bin");
+       if (ret !=3D 0) {
+               pr_err("cl_load_riu_rsf_memory failed with error code %d.\n=
", ret);
+               goto out;
+       }
+
+       /* Load AGC FW */
+       ret =3D cl_load_agc_fw(cl_hw_tcv0, "agcram.bin");
+       if (ret) {
+               pr_err("cl_load_agc_fw failed for tcv0 with error code %d.\=
n", ret);
+               goto out;
+       }
+
+       ret =3D cl_load_agc_fw(cl_hw_tcv1, "agcram.bin");
+       if (ret) {
+               pr_err("cl_load_agc_fw failed for tcv1 with error code %d.\=
n", ret);
+               goto out;
+       }
+
+       /* AFE Registers configuration */
+       ret =3D cl_afe_cfg(chip);
+
+out:
+       return ret;
+}
+
+static void restore_ela_state(struct cl_hw *cl_hw)
+{
+       struct cl_recovery_db *recovery_db =3D &cl_hw->recovery_db;
+
+       /* Restore eLA state after MAC-HW reset */
+       if (recovery_db->ela_en) {
+               mac_hw_debug_port_sel_a_set(cl_hw, recovery_db->ela_sel_a);
+               mac_hw_debug_port_sel_b_set(cl_hw, recovery_db->ela_sel_b);
+               mac_hw_debug_port_sel_c_set(cl_hw, recovery_db->ela_sel_c);
+       }
+
+       mac_hw_debug_port_en_set(cl_hw, recovery_db->ela_en);
+}
+
+int cl_rf_boot_recovery(struct cl_hw *cl_hw)
+{
+       int ret =3D 0;
+
+       mac_hw_mac_cntrl_1_active_clk_gating_setf(cl_hw, 1); /* Disable MPI=
F clock */
+       mac_hw_state_cntrl_next_state_setf(cl_hw, 2);        /* Move to doz=
e */
+
+       /* Enable all PHY modules */
+       cl_phy_enable(cl_hw);
+
+       /* Restart LCU recording */
+       if (cl_hw_is_tcv0(cl_hw))
+               lcu_phy_lcu_ch_0_stop_set(cl_hw, 0);
+       else
+               lcu_phy_lcu_ch_1_stop_set(cl_hw, 0);
+
+       restore_ela_state(cl_hw);
+
+       mac_hw_doze_cntrl_2_wake_up_sw_setf(cl_hw, 1); /* Exit from doze */
+       mac_hw_state_cntrl_next_state_setf(cl_hw, 0);  /* Move to idle */
+
+       cl_riu_clk_bw_init(cl_hw);
+
+       /* Load RIU re-sampling filter memory with coefficients */
+       ret =3D cl_load_riu_rsf_memory_recovery(cl_hw, "riu_rsf.bin");
+       if (ret !=3D 0) {
+               pr_err("cl_load_riu_rsf_memory failed with error code %d.\n=
", ret);
+               goto out;
+       }
+
+       /* Load AGC FW */
+       ret =3D cl_load_agc_fw(cl_hw, "agcram.bin");
+       if (ret) {
+               pr_err("cl_load_agc_fw failed for with error code %d.\n", r=
et);
+               goto out;
+       }
+
+out:
+       return ret;
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

