Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD54E3AB885
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhFQQIn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:43 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:19069
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230217AbhFQQHy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBnTNxXML5ES00l0EMX53896alZQ7H1mC+uYhynUMoM5CFR2UFsEkNA5ICUIohbY2xIfqzng3bj7lRkLdsDtMJgGtomSK0bqQI9ACWRfpDqLDF0YFy/4aoI7SdZ2AFThWY73QPUPQI68U0C4rAzwy4xtdvAkUI7iBZuqZG3SCaf0QNkaM0dxCHSJ/9VdcxkN4S17cgfYnKidFlbQxJaTUd70B/TRIBdV8r9ef27hRXYdroJVhAXXC6J4OOhhgIQAVYT0O2aHN7ic4GkjkSTfSc9Cy2zECKCwL18Q+5dgIRTdrN6Z/R0DPwmwyJ8boR+cFZqL8B/ALIwkOH56H9VZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y459JWZUVgJ+oSej1wfEN6QH0mADRdFePTwL005T65c=;
 b=nwV+pUvwAhqxSjF9bo+TAF7zdWxWlQONhzRi5+l1EwUWm9gJCOJ/BkaPNxgJhIFz+qmSG9tZYV5+cs8qAEjGLK7TZtINEXeUB5NTeMwdh4TlJI80YPyHNWZ0mTXbUtG8b2rYe9zv/2+MW9xAMmzvlnENhbkO6kfClIRNowqmqF5NozLSvp8yk3bIa55dt8xQ3Mfj4/xLiSom1oWr7kAx0pzPTKNKZRCplRlFZJe5L+GfRAduenFk74dBJNjYed8+KHdcU6hHangHtJ47MzyKXrQrfujx3M42zaU7sFvj7RfEEcngaSyNihbb5B9TACoUQFfJCnF7JUEtJqQec3FdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y459JWZUVgJ+oSej1wfEN6QH0mADRdFePTwL005T65c=;
 b=j34RTmw9/4wmwEUhxyihB/MkW5S4LXMO5HuH0ZUE3DqZvwQZHSkVtcJ6uNks8xl1eUkoVR9pd33/pMiw4nTSwNWKVSofCk3W/32xXB1/H8hI5VnQ6KrtWHC0cR7T4Ay4jW1AXiZ/0a6jXjomaVmAAS5DRet69bo6R6/BGoEOoJQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:03 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:02 +0000
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
Subject: [RFC v1 098/256] cl8k: add hw.c
Date:   Thu, 17 Jun 2021 15:59:45 +0000
Message-Id: <20210617160223.160998-99-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff2c8a7e-c0a5-435e-7b44-08d931a9923f
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0887BBDC380713D072CEFC38F60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6cDXN0DYfpaZSBcFyxqLCXa0gp3thvX8OtN/4mXORhjub0pG+EalDztNDbDPb2hnjZacR8riS7EjZvx3Ky68B+unUslHAbqA08lZl2povn9odtHDsRkjYT04ve1miFrxr9wvvq3+6C5Co5pvXZ6r6vAAgZEw7EgLEgymXGtIKtR/gPSuHSRydMlGB/4+a4Gv4ArJBplywnvHYH6wGEWgP19bgrxymgnppGmRyaIj67uJ7PbaHBTdwhzJrVt/uE83XQEzaEABv3LXuJBkGhXMpAMPJCG3rYMK2yRaSFeZ0io2k6fHVlUlL1JvIsHrRaOu9fHAhID69BqqwdtFi6/YDmtTUgftE1zREGzwquTtBC+R45bjppBlVKogoH5Osn0wd6AqPN++ObqccnsiYfgAmotnbkp7a+vC5QnYTwojtFAXdD/5Fge71JaJ0z6nFsw85uNnBZKfwd9OODzpcjtVkW5bxjcj+CtVHtQuVw2ecyLC06V/t5JiTwX9JrGTm+e0U/D9tDaIXohvZTnnH0MuoC4/YLF11LcWtwJZXUssgxuM8DaBgmPNQzOfszPGXJA3/vfgHpSvWhxJ6f5ljw1tR6yV8F5KwlDf2Yq10dATGO8TiX+X5seQMqNhMopioHM3A0DNE4aCIcQqQMuj4hDEjj56/HKhgDeUL6yfd5Qf6BDeGEGC5h6BaPbBgekP8TaVFo48pqK9q1vv/vUvDjZWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p+RKBf/OYOcYA9OlTTyyXH/Z2WaSeuYdfz2+IfdfzLvicpmliAicMpLmYIf/?=
 =?us-ascii?Q?kxiwDLLnvUiRHxCkV8Ipp6wXOj1KkOpZjLmH0gnH8fj8bTcuwmq9CeZGWeoL?=
 =?us-ascii?Q?0jEni7UQrrpubIDmxbFy7Y79TZAMayy1MgmQJfO6EfquhQzE8A4ToydKzzUa?=
 =?us-ascii?Q?7RGPwqiyus4SBE/f6JhUjh4y/EQSnSk0iWlkxWqkQwL6QT51k00mfA+Xqxoc?=
 =?us-ascii?Q?kD+8Iu71+PslwolOLFpTawf3v908hPTGbbCIxRSMGYNz+FsmcjjMLM5mzSWU?=
 =?us-ascii?Q?njyxluvh45CY1sTcELysZZCANlKKXLcD3AO1icEJEoZCbzUqnDnoBhG8UFFF?=
 =?us-ascii?Q?h4wlJ1TtnPSXw3lwHH5CJK8JCLkYARwI24/PHVm8wbEepTuP5NNdew43xLqM?=
 =?us-ascii?Q?u+DmjsQfBXhUJj3c2wW2VmSuPS9U9LknT3OLlg+Un9fgqz75LWnSmTUkgzzB?=
 =?us-ascii?Q?LKfMO10FjOJ6pQcZWhT4p90m4Sn8Bn9hALP/n4atXvACSgmIq9AXs85LFW+t?=
 =?us-ascii?Q?8+q+CIV//CJbOM9bgyuLN8NU+DxiOQtgvPsDhFkg/7SbUJvLo5JCt1QdbHOI?=
 =?us-ascii?Q?KDRWRJeUtdB/NlHIc1xdnxuhSceHpbIQQLF77JYFw9X4fL/dez5c5qSVfYy9?=
 =?us-ascii?Q?tMENtZZ4vvkg4dHwdm0PlLewfqIG2BUGScwIkBCpTQRMniYQHbjzCX0F9Yr6?=
 =?us-ascii?Q?av0aICNS4pbpSQCqaXCItiovRtYA7rPEBCCRDOgnnlvHVxSvejgiU5UDp7JN?=
 =?us-ascii?Q?lcQryCrPDTwZesEuYQt9JLKRtMFT7ANJ7fNhiFeJ+mX5/IP/T9HykAQlYmz6?=
 =?us-ascii?Q?jgtoY+rDXLqZwXfSzEs6MsqBHjYgfjMqbwbtNeAn3kC3meVnBQ1BpD3IMo1b?=
 =?us-ascii?Q?ZyWAmqEFQ9/cJtK3VGDUdzrc5ENHkEaVVKQV3A/TsU6rNK5JZEKoiIsf3VIY?=
 =?us-ascii?Q?an/Rj0xt6YF+ECm0E7DoyWKdH/34hpToEZvVKR30QK1zmGHIKi8QLqmwbtJU?=
 =?us-ascii?Q?LC4wfFiCcdADfURrlkA+GQJCX3vWxFqXmtLdkxkdCk6ORuN0A/05CxhmT3a5?=
 =?us-ascii?Q?FX+1xYOgDZAnD+oVYxmDMM9Iz8EXgkW7npTvR3LZhUuZp8PUGpHixpm4rzyQ?=
 =?us-ascii?Q?5XMpiIMQIkeErkOSWnYt8veULnUoCwW0Lz3RpUnVxEAOl2yb6rQ3fs4i5WG6?=
 =?us-ascii?Q?rEewYxyu9hGnRAQrBWMZN1BBTmbf5KRezjPFERQj8s/pKnR53FDbNcIQ+GEX?=
 =?us-ascii?Q?of1GTJNDjH4Vk37SY8+z9O3b/bicAtBdztebVyV4lY2PeVB3SPFezDM+qLzE?=
 =?us-ascii?Q?R51DrmxCdMl9L1DLYhROSOrq?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2c8a7e-c0a5-435e-7b44-08d931a9923f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:22.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ShJW4NQql5ZskRfVkWbJei8smGK9R/5lKVvd/tDWu9Hc0iVwy2nUwOhMkHOTxeWgDFa4fv7QcJplWCSZj7WaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/hw.c | 166 ++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw.c

diff --git a/drivers/net/wireless/celeno/cl8k/hw.c b/drivers/net/wireless/c=
eleno/cl8k/hw.c
new file mode 100644
index 000000000000..0f7e7dcc659d
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/hw.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "hw.h"
+#include "rate_ctrl.h"
+#include <linux/spinlock.h>
+#include "reg/reg_access.h"
+
+static void cl_hw_init_tcv0(struct cl_hw *cl_hw)
+{
+       struct cl_controller_reg *controller_reg =3D &cl_hw->controller_reg=
;
+
+       cl_hw->fw_dst_kern_id =3D KERN_LMAC;
+       cl_hw->fw_prefix =3D 'l';
+
+       controller_reg->breset =3D LMAC_BRESET;
+       controller_reg->debug_enable =3D LMAC_DEBUG_ENABLE;
+       controller_reg->dreset =3D LMAC_DRESET;
+       controller_reg->ocd_halt_on_reset =3D LMAC_OCD_HALT_ON_RESET;
+       controller_reg->run_stall =3D LMAC_RUN_STALL;
+
+       cl_hw->mac_hw_regs_offset =3D 0;
+       cl_hw->phy_regs_offset =3D 0;
+}
+
+static void cl_hw_init_tcv1(struct cl_hw *cl_hw)
+{
+       struct cl_controller_reg *controller_reg =3D &cl_hw->controller_reg=
;
+
+       cl_hw->fw_dst_kern_id =3D KERN_SMAC;
+       cl_hw->fw_prefix =3D 's';
+
+       controller_reg->breset =3D SMAC_BRESET;
+       controller_reg->debug_enable =3D SMAC_DEBUG_ENABLE;
+       controller_reg->dreset =3D SMAC_DRESET;
+       controller_reg->ocd_halt_on_reset =3D SMAC_OCD_HALT_ON_RESET;
+       controller_reg->run_stall =3D SMAC_RUN_STALL;
+
+       cl_hw->mac_hw_regs_offset =3D REG_MAC_HW_SMAC_OFFSET;
+       cl_hw->phy_regs_offset =3D REG_PHY_SMAC_OFFSET;
+}
+
+void cl_hw_init(struct cl_chip *chip, struct cl_hw *cl_hw, u8 tcv_idx)
+{
+       write_lock(&chip->cl_hw_lock);
+       chip->cl_hw_lut[tcv_idx] =3D cl_hw;
+       write_unlock(&chip->cl_hw_lock);
+
+       if (tcv_idx =3D=3D TCV0)
+               cl_hw_init_tcv0(cl_hw);
+       else
+               cl_hw_init_tcv1(cl_hw);
+}
+
+void cl_hw_deinit(struct cl_hw *cl_hw, u8 tcv_idx)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       write_lock(&chip->cl_hw_lock);
+       chip->cl_hw_lut[tcv_idx] =3D NULL;
+       write_unlock(&chip->cl_hw_lock);
+}
+
+void cl_hw_lock(struct cl_hw *cl_hw)
+{
+       read_lock(&cl_hw->chip->cl_hw_lock);
+}
+
+void cl_hw_unlock(struct cl_hw *cl_hw)
+{
+       read_unlock(&cl_hw->chip->cl_hw_lock);
+}
+
+struct cl_hw *cl_hw_other_tcv(struct cl_hw *cl_hw)
+{
+       /* This function must be called after read lock is taken */
+       return cl_hw->chip->cl_hw_lut[1 - cl_hw->tcv_idx];
+}
+
+bool cl_hw_is_tcv0(struct cl_hw *cl_hw)
+{
+       return (cl_hw->tcv_idx =3D=3D TCV0);
+}
+
+bool cl_hw_is_tcv1(struct cl_hw *cl_hw)
+{
+       return (cl_hw->tcv_idx =3D=3D TCV1);
+}
+
+int cl_hw_set_antennas(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       u8 ant_shift =3D cl_hw_ant_shift(cl_hw);
+
+       /* Set num_antennas and max_antennas + masks for both. */
+       switch (chip->fem.wiring_id) {
+       case FEM_WIRING_0_TCV0_6_TCV1_6:
+       case FEM_WIRING_1_TCV0_6_TCV1_6:
+       case FEM_WIRING_2_TCV0_6_TCV1_6:
+       case FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2:
+               cl_hw->max_antennas =3D 6;
+               break;
+       case FEM_WIRING_7_TCV0_4_TCV1_4:
+       case FEM_WIRING_8_TCV0_4_TCV1_4:
+       case FEM_WIRING_9_TCV0_4_TCV1_4:
+       case FEM_WIRING_10_TCV0_4_TCV1_4:
+       case FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY:
+       case FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY:
+       case FEM_WIRING_15_CHAMELEON_4TX_4RX:
+       case FEM_WIRING_18_TCV0_4_TCV1_4:
+       case FEM_WIRING_19_TCV0_2_TCV1_2_SWAPPED:
+               cl_hw->max_antennas =3D 4;
+               break;
+       case FEM_WIRING_13_SENSING_4RX_2TX:
+       case FEM_WIRING_14_SENSING_4TX_2RX:
+       case FEM_WIRING_20_TCV0_4_TCV1_2:
+       case FEM_WIRING_21_TCV0_4_TCV1_2:
+               cl_hw->max_antennas =3D cl_hw_is_tcv0(cl_hw) ? 4 : 2;
+               break;
+       case FEM_WIRING_17_TCV0_4_TCV1_0:
+               cl_hw->max_antennas =3D cl_hw_is_tcv0(cl_hw) ? 4 : 0;
+               break;
+       case FEM_WIRING_16_TCV0_2_TCV1_2:
+               cl_hw->max_antennas =3D 2;
+               break;
+       default:
+               if (chip->conf->ce_production_mode)
+                       cl_hw->max_antennas =3D chip->max_antennas / 2;
+               else
+                       return -1;
+               break;
+       }
+
+       cl_hw->num_antennas =3D cl_hw->conf->ce_num_antennas;
+       cl_hw->mask_num_antennas =3D ANT_MASK(cl_hw->num_antennas);
+       cl_hw->first_ant =3D ant_shift;
+       cl_hw->last_ant =3D cl_hw->num_antennas + ant_shift - 1;
+
+       cl_dbg_trace(cl_hw, "num_antennas =3D %u, max_antennas =3D %u\n",
+                    cl_hw->num_antennas, cl_hw->max_antennas);
+
+       if (cl_hw->num_antennas > cl_hw->max_antennas) {
+               CL_DBG_ERROR(cl_hw, "num_antennas (%u) > max_antennas (%u)\=
n",
+                            cl_hw->num_antennas, cl_hw->max_antennas);
+               return -1;
+       }
+
+       return 0;
+}
+
+u8 cl_hw_ant_shift(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       /* CL808x uses chains 0 - 3 for both bands */
+       if (cl_chip_is_8ant(chip))
+               return 0;
+
+       /* CL804x uses chains 0 - 1 for TCV0 and chains 2 - 3 for TCV1 */
+       /* CL806x uses chains 0 - 3 for TCV0 and chains 2 - 3 for TCV1 */
+       return cl_hw_is_tcv0(cl_hw) ? 0 : 2;
+}
+
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

