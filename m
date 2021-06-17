Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C153AB911
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhFQQMR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:17 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:64640
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233902AbhFQQLG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDbRo6Z5gPCLnC89+ILqXBSo/vMZrhQP+PjQbTqOyV+jk9fxWlg3OptN4fujLRToWjnbeiMw3H82/gilnfxDmhZIEJ/v2gNSkpqXuurMo0TtrkjrK2p0r37MbV5v6lR4GdW5/9mp6hH/OvgZzilcjy1KB3hIen93dUBuAMO+umq1L05IDQ735GhlNldZmEy+3ljVDVxht2nfpv1Mj198SzKpk8c+12/p8et0r2R81GcHIWLQDoCr6fCXdiTdE8pFTZpqemtp8IhKRS4O6hHRTlb7la5WDeizM//LL4FiyeRihhoF6V6vvu1hRjWOe5EalUuOouhiMt2RMwtMYlpc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z04eZkGej6RoOakkXddCrvwX6vOaTHBia6S40sysGsM=;
 b=CDFe7bEp5aJArW0ybuSGO6KAijLNVwgJxz4H7a5/GslgSbfj1Yofuu2tnzqT7r/v58/uLdhZeKf3sB8k4f5vlVLcKNunUI6s/KamTWO0hsOR5pY1sLVS+Szi9xoatdZDMYfe/h3u3Iku0NCcDP8TIftsEjnjrUBQ/x3YYW29keSIRt3ZVMyHOPduoEjx7v23cO5e/8la77hnHIupxtgcIv+i4DEQCqsYE78VSmiK9pTfsSzEEMPw0p+FKtKwfA2u6Ye9iPgck+nKQAcK114nn8W20yedu7+rAyjq1torHIaXoH2k7NyeyQQAtefzY7ip3MjxA3ALSIzRlbRDL0RsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z04eZkGej6RoOakkXddCrvwX6vOaTHBia6S40sysGsM=;
 b=pzriuBOb808lZcepBkNCatDitE6VWpJtKsET19XwQHxYkzQ1AtLxizq0ABTRqm8dF9jpSelG9Phyh4y7my71qB41C68bGLmAXgsdYMdpn1qZ/K5UY8OUOZE2ws8WAnp402r6R4l32KDibJa+6xh8u0w+aFF+qNCXZaRVeKUFzlA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0515.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:58 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:58 +0000
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
Subject: [RFC v1 233/256] cl8k: add version.c
Date:   Thu, 17 Jun 2021 16:02:00 +0000
Message-Id: <20210617160223.160998-234-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d1bea0b-e576-4f54-51e7-08d931a9ecb4
X-MS-TrafficTypeDiagnostic: AM0P192MB0515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0515D4C77293DFD89B77E9D0F60E9@AM0P192MB0515.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLXsNd+k1qAwz+4yP+9r+4dOpwb+76pYV/bCyJzVh7U1aF5cPCxH3pIr8n/BOsY2+/vpTBeYyJoV1FC3qy9O9qI2RcnH88iCE59868szHowbo8trDfwLWoGBY72XYGRrWecUMUDbhOlqhYn2OuHB3ZglXggdZA36cOGYWA2uofijiSUvzzMYE60bJLJcb+JAbtJadblp9xJdEwKnSKFh/nVerDUaW9dAD7gdolvKIcO4eVgiN1dlkcABAOfUOHIYi5+y3rvXew4tG1ic2gCdSZZDHSGXkhPHJGmQ6j6f5z26oo1ikAFiA/MObPhu1kX4efw6Fs2qRaiVr20iEG8sQWq0hlltspTNx8IFD7jdPHEak8zCUtQUvLyt1km6GE77DHuCloGV8tw4za95Etd9fiZduIEEogoqQx+N+yCdkkIwai5hAOA0Ia8ieZQpeRySDKqz1Tc/O/sv7kkTh7akFpAdn1HgqsO0VOIXYO0N3r4+Ig00kJUvKjInViFlDnp4V7xvlUI/PwGYxhp+rozmwruA3hlO1qytsgp4QZ1SxB7ZoOwkSWiGk7RpTX8jUMzVhw1vRuzqFDnLhOh0XWtnEvoZHCNx0JYcvLECJn0x7dh635YMftAZ28ZqRvz+o59Y/rDxfAhM0ZZWsMvOO7MeRroMxui5IrLDFgHp29DstNb6nJcoEIz8gumBOvwwqW9/HtajZjCbk9VEpX8GIxV4EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(376002)(39850400004)(136003)(366004)(346002)(4326008)(16526019)(83380400001)(1076003)(8676002)(9686003)(55236004)(6666004)(36756003)(478600001)(8936002)(956004)(186003)(6486002)(38350700002)(6512007)(6916009)(52116002)(86362001)(5660300002)(2906002)(38100700002)(66946007)(2616005)(316002)(6506007)(26005)(54906003)(66476007)(107886003)(66556008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZSW1jS2vxn/gXwrccZXGelwZdgI8x4ogvt4dcABjBWW4VV3ef/+fukR7j7gk?=
 =?us-ascii?Q?UpipYaJKwErLrX6Sq2FKrvSoMdg9wi1WYfdA+HiKpzSehuIlsfmIBUKvIABm?=
 =?us-ascii?Q?ruNJ5zuDR9wCNChihWW0w1WdsmijXHgwMMLsnak5o3fFyRtUAQaglSzYstjD?=
 =?us-ascii?Q?2CjCFXz8xuYZpPbgFhyTjku6AKPXJwHAcfyLOANzktsArD4yS5AXzSttJ5Jx?=
 =?us-ascii?Q?8oA5gY+Qsn3KDqzIiWXDN9ySvyCaL1/2AF2n+THKjBr9QuJhBciTmM3R9W8T?=
 =?us-ascii?Q?B8AihUUnFAYSwmgA78sHT5N/dLtfBp7CQGhFca1LV2hgwmOmPE6s5rWK5h1i?=
 =?us-ascii?Q?dmxFzfB9L7lVQjmL9REvnJFt/ZsPq7HNoj5Tx2xMP3TdXEIVuq/uF0XDVBbL?=
 =?us-ascii?Q?UL4+bBsrszWVmYzbe+S3xDNqHAZFepQEIrTe2XZ1J+gqwiJl+8QSagt1E1Kb?=
 =?us-ascii?Q?sGn+KDyvWeaQrCtBkCHjOJroBB1JnWTwLIcLo29KIDmTco+hDIS3rZFbgbk8?=
 =?us-ascii?Q?6IYkmwC1f0HP2AKjHCgIHK0AA0ivVyQo/+0wxvEEQAalHQ98mSNryBrOpQL5?=
 =?us-ascii?Q?/ZL3Sapp9ci0sYDKZzEkDC8u9PCyU2atK0iOAA8sXyfake3hEc6RT4Q1VWAe?=
 =?us-ascii?Q?GZNSUGM+LW8ho5OTHAMBf/p4+2+whngNTyexwavyK/3LJBITVC5rYX1C8j4E?=
 =?us-ascii?Q?m9sAtU+bd1XoTpZubJD0PPWk2sQyEj9fa7NERMKNc9U0ppilMczrDGmGGC0h?=
 =?us-ascii?Q?1+6ipR20817zKCt9Z7d1b3HoliA5fmzKFhYEpuV3HFUocwy9x+ii/J1FN0fq?=
 =?us-ascii?Q?xe/R5eu2o1jWXCBpQJIWToOogwCXvG04/vof0ErViuVlViFiEUSreY+mrFuC?=
 =?us-ascii?Q?9iKLyuTTcJP65pT28V0cxjs5siJ02U2amC0hB7DU/+73PFpnK0RayDVlAQl7?=
 =?us-ascii?Q?32Knrxt3UzX9ISJHw+O5awKST4f7YiOrOImOX6uq9oCNpIyeMJqSVQlN0qLa?=
 =?us-ascii?Q?DjFkiG2ifNPn/rIrKHQIEWOXsOTucBYO8XskE9jFZeVoC4ThSAuTWcOUQ+sm?=
 =?us-ascii?Q?xNi3N2Sm79rIgheLMB4hPShai1GFadS0IhuVQEMJB9t/S4Cny9GOSB6Eqmqy?=
 =?us-ascii?Q?SF521nfAL2WhOGWbahhyhcrYRaw/yv7GxCS9PbcNAjpd0bR6XR+wH4+PmzsP?=
 =?us-ascii?Q?JUlX6PV5FxlEJintK6+zfn/SLOlBqwNAyBDCbsmtM0WCBkZiu+c30FYxrkl5?=
 =?us-ascii?Q?ApRxmTXOWInY71rOKopPyUrDtd2JghjJPZtkrQAfs5SofpaYD/9wKrVvA3el?=
 =?us-ascii?Q?NaGHSgmoeGwZq1frVv2Pb1Vp?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1bea0b-e576-4f54-51e7-08d931a9ecb4
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:54.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfMnc8djZRyiukMwlSU7D1DjkP6jiqwzQXyQWq0nTLNvcr+nzNH7+Tnwk/2qJEJKODYaZEzXGpAmHKQBkdc2mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0515
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/version.c | 129 +++++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/version.c

diff --git a/drivers/net/wireless/celeno/cl8k/version.c b/drivers/net/wirel=
ess/celeno/cl8k/version.c
new file mode 100644
index 000000000000..4ac0bea0ae62
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/version.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "version.h"
+#include "fw/msg_tx.h"
+#include "debug.h"
+#include "chip.h"
+#include "utils/utils.h"
+
+/*
+ * Don't move this define to a different file, and
+ * don't change the default version.
+ */
+#define HP_VERSION "8.0.0.0.0.0"
+
+static int cl_version_request(struct cl_hw *cl_hw)
+{
+       struct mm_version_cfm *cfm =3D NULL;
+       struct cl_version_db *vd =3D &cl_hw->version_db;
+       int ret =3D 0;
+
+       ret =3D cl_msg_tx_version(cl_hw);
+       if (ret)
+               return ret;
+
+       cfm =3D (struct mm_version_cfm *)cl_hw->msg_cfm_params[MM_VERSION_C=
FM];
+       if (!cfm)
+               return -ENOMSG;
+
+       vd->last_update =3D jiffies;
+       vd->dsp =3D le32_to_cpu(cfm->versions.dsp);
+       vd->rfic_sw =3D le32_to_cpu(cfm->versions.rfic_sw);
+       vd->rfic_hw =3D le32_to_cpu(cfm->versions.rfic_hw);
+       vd->agcram =3D le32_to_cpu(cfm->versions.agcram);
+
+       cl_hw->rf_crystal_mhz =3D cfm->rf_crystal_mhz;
+
+       strncpy(vd->fw, cfm->versions.fw, sizeof(vd->fw));
+       vd->fw[sizeof(vd->fw) - 1] =3D '\0';
+
+       strncpy(vd->drv, HP_VERSION, sizeof(vd->drv));
+       vd->drv[sizeof(vd->drv) - 1] =3D '\0';
+
+       cl_msg_tx_free_cfm_params(cl_hw, MM_VERSION_CFM);
+
+       return ret;
+}
+
+int cl_version_read(struct cl_hw *cl_hw, bool reply)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_version_db *vd =3D &cl_hw->version_db;
+       int ret =3D 0;
+       struct cl_agc_profile *agc_profile1 =3D &cl_hw->phy_data_info.data-=
>agc_params.profile1;
+       struct cl_agc_profile *agc_profile2 =3D &cl_hw->phy_data_info.data-=
>agc_params.profile2;
+       char *buf =3D NULL;
+       ssize_t bufsz;
+       int len =3D 0;
+       u32 version_agcram, major, minor, internal;
+
+       /* Request data if existing is not actual */
+       if (!vd->last_update && (ret =3D cl_version_request(cl_hw)))
+               return ret;
+
+       /* PHY components specifics */
+       cl_snprintf(&buf, &len, &bufsz, "DRV VERSION: %s\n", vd->drv);
+       cl_snprintf(&buf, &len, &bufsz, "FW VERSION: %s\n", vd->fw);
+       cl_snprintf(&buf, &len, &bufsz, "DSP VERSION: 0x%-.8X\n", vd->dsp);
+       cl_snprintf(&buf, &len, &bufsz, "RFIC SW VERSION: %u\n", vd->rfic_s=
w);
+       cl_snprintf(&buf, &len, &bufsz, "RFIC HW VERSION: 0x%X\n", vd->rfic=
_hw);
+
+       version_agcram =3D vd->agcram;
+       major =3D (version_agcram >> 16) & 0xffff;
+       minor =3D (version_agcram >> 8) & 0xff;
+       internal =3D version_agcram & 0xff;
+       cl_snprintf(&buf, &len, &bufsz,
+                   "AGC RAM VERSION: B.%x.%x.%x\n",
+                   major, minor, internal);
+
+       cl_agc_params_print_profile(&buf, &len, &bufsz, agc_profile1,
+                                   "AGC PARAMS PROFILE:");
+       cl_agc_params_print_profile(&buf, &len, &bufsz, agc_profile2,
+                                   "AGC PARAMS PROFILE (Elastic):");
+       cl_snprintf(&buf, &len, &bufsz, "TX POWER VERSION: %u\n", cl_hw->tx=
_power_version);
+
+       if (IS_PHY_OLYMPUS(chip))
+               cl_snprintf(&buf, &len, &bufsz, "RFIC TYPE: OLYMPUS\n");
+       else
+               cl_snprintf(&buf, &len, &bufsz, "RFIC TYPE: ATHOS\n");
+
+       cl_snprintf(&buf, &len, &bufsz, "RF CRYSTAL: %uMHz\n",
+                   cl_hw->rf_crystal_mhz);
+
+       if (reply)
+               ret =3D cl_vendor_reply(cl_hw, buf, len);
+       else
+               pr_debug("%s\n", buf);
+
+       kfree(buf);
+
+       return ret;
+}
+
+int cl_version_update(struct cl_hw *cl_hw)
+{
+       int ret =3D 0;
+
+       /* Force logic to update versions */
+       cl_hw->version_db.last_update =3D 0;
+
+       ret =3D cl_version_read(cl_hw, false);
+
+       /* Share version info */
+       if (ret =3D=3D 0)
+               cl_version_sync_wiphy(cl_hw, cl_hw->hw->wiphy);
+
+       return ret;
+}
+
+void cl_version_sync_wiphy(struct cl_hw *cl_hw, struct wiphy *wiphy)
+{
+       strncpy(wiphy->fw_version, cl_hw->version_db.fw, sizeof(wiphy->fw_v=
ersion));
+       wiphy->fw_version[sizeof(wiphy->fw_version) - 1] =3D '\0';
+}
+
+int cl_version_cli(struct cl_hw *cl_hw)
+{
+       return cl_version_read(cl_hw, true);
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

