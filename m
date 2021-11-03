Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC41443C38
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 05:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhKCEdc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 00:33:32 -0400
Received: from mail-ma1ind01olkn0164.outbound.protection.outlook.com ([104.47.100.164]:32992
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229650AbhKCEdc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 00:33:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIkjil7Qzd8UZj0LMXBtSc9ls3TfnVoOmKA0Vsua3ELw1+jgLmyiIhWVLr6gOQ2qvIWWC4fGkGPz6GPYBDTRdgsamDTz4BqGsfk5Ki8OtwosrO3gnWirYrxJXmA53/XABrgr+9cgPkD1CiveJSf/N8e/jZsNK+0V7lSKvSDg1uMrefLm9KOHQRc4fYJGNgafsukW/czmAMrtC8HyjsjqlOblwt9VinLk6RPleVVM2hfxt+qmqMDcSwILPx82LcsYWu26KWNA2cbxNFieVZbO5tOraIVlY90YVsGahVHqK3itd2aBRNYZbpXkbRR3WYG7w48pvZonw0gFou5BN2PG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFsz5X7wNM0BHGsvWHzzgKxbQuoSzO17daQUgeQQXi4=;
 b=mINdPu3dqm0sDcsFoOiYmErkJlDCiUfLnZehgZ4ph1N+q+dlNtpD28uebijvDX0iEt5VC1bxNjxUMLhWwzwHrtbI7A2ERYcExVwbxis5+4agedt2nzwZp/5XC5YDw8L76hFaqbCsuBxLkcaJZbcd9u9yIIXy+xB5mqw8gdttKYxEzkNZ9ZRP2l0+ftEOzIH2+9rdRoJQfNxCWSYs0qBrSHJ1fQwDQvgA3F64NY/1WKia2OOiOjsuNEScu8LWF8vrmE7I/bcTxtFpcgAWVP0bsx6oVwL/xj26v3vb70VkpKF4sX02Qv01g2f7CV//cGKti+0CnxZqfmSPn/AmBRAuCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFsz5X7wNM0BHGsvWHzzgKxbQuoSzO17daQUgeQQXi4=;
 b=ekF8R/NRz5WglMHI83xLeyCtZROuF4gEQkTAjRMURX4jLIJHZDwtN9dxsI76jmfPNKrds6eQNWP1SjIz9RrUkPiYJRSEF9OaX3P0ktZQKC4WRHC267QEvtAOKOvtHvjNKrV7+LS8mE2et+aP9hbBbHjQ9rsOwC4cl8ImDJZRB8YH1FUrYIpO+iYCGVogMCpQirx41GI0jHacJSa5M2vPnIH0FTkk2YYfmjOGxN+z22eapQkR1nPJIPNQ/dnN7HnBFu9qkYb/ZJBnkJ8aq5wOfadW02qm2TJnPCNByGEwJxWL9vssYIDvLAZTpSXByA3/QQ0ASZSrqKGWdYoNjc+fjQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN1PR01MB0669.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 04:30:49 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 04:30:49 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "aspriel@gmail.com" <aspriel@gmail.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "chi-hsien.lin@infineon.com" <chi-hsien.lin@infineon.com>,
        "wright.feng@infineon.com" <wright.feng@infineon.com>,
        "chung-hsien.hsu@infineon.com" <chung-hsien.hsu@infineon.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] brcmfmac: Add support for BCM4378 on Apple hardware
 (with their special OTP).
Thread-Topic: [PATCH v3 1/3] brcmfmac: Add support for BCM4378 on Apple
 hardware (with their special OTP).
Thread-Index: AQHX0GuUiUL76rO6qEm8DsgKHgtoeg==
Date:   Wed, 3 Nov 2021 04:30:49 +0000
Message-ID: <391FADA9-4C9D-42F5-97FA-B87D36BE901B@live.com>
References: <PNZPR01MB4415874CD530F2C305872F88B88A9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB44155DC40EAA3A13FCE85193B88A9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB44156C94263746D4EC592E96B88B9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PNZPR01MB44156C94263746D4EC592E96B88B9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [63Duv3aeNVnAgJK+Qm9/xXAmwDv0ypJSd6ho2EP1Je2cGqWYapkzgPIAXUSsQc0q]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d64ee4b-1e9f-470c-254a-08d99e82b6c0
x-ms-traffictypediagnostic: PN1PR01MB0669:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJZrGc/Boqox9KLC942JNASAcvj/a/l3I4ygu7QtJJ88iyGOaCWl1TtEywyf1V7Ub+cFuyTxsCo25v38Vj2f7HetMjEccBg049MZqjnT3JYR0w9eEFW7hnru3b03IUzCt0oHqVtgqv2tGFD44kQI1F0eTXOKqlXyz89xNHQ6yo5V/lKPvggGKEWet+HjNPRU8GFr3RaB7JUYEfrJ/9uzWEnbmePVCHoYvcwF2vJQ7vEjEzfIArN47AQFj8dBRY0LIwyNNdPVHV0G6qSUwXF384DzE8glKtjj5JUMsTVWhppBxV/MCjnDhMyLr3qMMUWUx2H73ywoCcNp87W7qaBujQqe2p7no+9lOlSz96fh0ZpYcp5mzjV80sckAB6d+rpvYmNOlHEOs4EsAUxxAb2ZqEbP37b1XIZ7SqfcIs1h4XZWZ0VwJAMtIN3KB0F/pHMm3iRt7MZ9mM+iPEbQtytfAA2BLgwtS1c2u8mTYtJBX78x3CoZNldZKSqUUSn7+TQfdx5xhYtDYGn3YoSqqKWqwULRhg5esq+tq+cmzgOdsQgC86b3cuOfBNURHq7Ddg+TZlJzYInY8MFzu3+XhCXWJw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: Ui925u8N75ji58QXB+LOXpAgDidvYvQ00lDuQiLzADKhl/fl7X3/8eTaeEOq0Ipkh/iaZxpNLaD34cKjOMlEGiueuDdsvX92zK6CD6f3J0KSWLbKh4+R6SwnlxEBRNPr0iclo6m7F7c8JvRhdNCMYQYkRUVm3Iav7a2hrNzstomgjoRn9kMZwXhx+hWwR8xTAh5lv8bVBQhAX+9zZ6XvSOtcZ4gT3U1iXKOEM39kI7CHC9HjZZ2FdKPj7P+72yzEcIWlVzaXhjr083RxGI6f0hXRZsGWhGt6xpbpclpcxsloD3+Yk/etFaeRziIlYAGKKP77w2I6CG90qwTGIxb+HenazRxht7M8k5RKxGghu4R66iuUCGL6RAPIlXtfyz0eRlCSn/6+HJUgmCxxPK70b7Y2XMWkXduxZ/jfPJ2zbZNQ7yzUxXfKEH5qOIOOM3Ze519Ghbni72DNV3f/FVCuwYtXiczLR8ordEz3plvSVW1xlnEeXrANsEKYG5xgCkQtBTbaJ73RtnsM8NhzCVEZJEn7AARsmn3cZehAabqTIsrweUn163PrJHeFP0OSv6y9lpPIS66emz4E6/ivzqXaVNNOSnzawM7kRrmDTrU9a7/JSGF73vXbrdN5ixqeu7/Btg7wAYuC1BMJdNI+VF4l9TW5fuTRMTyi86LEqz3/b/Y5uzdJIEmzye3K3ZknL6mVza9eJYFZ5lX+cglcwuZQpQlWCrAQ0YDw8ISvP9YtZ8i1Y15cwIYQ1LV7Q5dN7KvlFjvkr/BkSt2JrNCdIya0zQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45D79C563EA7904EAA430E3073FC56A4@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d64ee4b-1e9f-470c-254a-08d99e82b6c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 04:30:49.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PR01MB0669
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Stan Skowronek <stan@corellium.com>

This patch is the original one by Correlium to support wifi on Apple M1 Mac=
s given on https://github.com/corellium/linux-m1/commit/02ad06fbf2b35916ee3=
29a9bb80d73840d6e2973.patch?branch=3D02ad06fbf2b35916ee329a9bb80d73840d6e29=
73&diff=3Dunified. It has been edited to apply to 5.15

V3- Make plain text

Signed-off-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |   7 +-
 .../broadcom/brcm80211/brcmfmac/chip.c        |   4 +
 .../broadcom/brcm80211/brcmfmac/common.c      |  37 +--
 .../broadcom/brcm80211/brcmfmac/common.h      |  23 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c    |  38 ++-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  14 +-
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 286 ++++++++++++++++--
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |   2 +
 8 files changed, 344 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/=
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 0ee421f30aa24..8f7db434de111 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5136,8 +5136,13 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct w=
ireless_dev *wdev,
 		ie_offset =3D  DOT11_MGMT_HDR_LEN +
 			     DOT11_BCN_PRB_FIXED_LEN;
 		ie_len =3D len - ie_offset;
-		if (vif =3D=3D cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif)
+		if (vif =3D=3D cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif) {
 			vif =3D cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+			if (vif =3D=3D NULL) {
+				bphy_err(drvr, "No p2p device available for probe response\n");
+				return -ENODEV;
+			}
+		}
 		err =3D brcmf_vif_set_mgmt_ie(vif,
 					    BRCMF_VNDR_IE_PRBRSP_FLAG,
 					    &buf[ie_offset],
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 5bf11e46fc49a..4058edddbdc23 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -726,6 +726,8 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_pri=
v *ci)
 		return 0x160000;
 	case CY_CC_43752_CHIP_ID:
 		return 0x170000;
+	case BRCM_CC_4378_CHIP_ID:
+		return 0x352000;
 	default:
 		brcmf_err("unknown chip: %s\n", ci->pub.name);
 		break;
@@ -1425,5 +1427,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 		reg =3D chip->ops->read32(chip->ctx, addr);
 		return (reg & (PMU_RCTL_MACPHY_DISABLE_MASK |
 			       PMU_RCTL_LOGIC_DISABLE_MASK)) =3D=3D 0;
+	case BRCM_CC_4378_CHIP_ID:
+		return false;
 	}
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index e3758bd86acf0..4b91a04afdc34 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -50,11 +50,24 @@ static int brcmf_feature_disable;
 module_param_named(feature_disable, brcmf_feature_disable, int, 0);
 MODULE_PARM_DESC(feature_disable, "Disable features");
=20
-static char brcmf_firmware_path[BRCMF_FW_ALTPATH_LEN];
+char brcmf_firmware_path[BRCMF_FW_ALTPATH_LEN];
 module_param_string(alternative_fw_path, brcmf_firmware_path,
-		    BRCMF_FW_ALTPATH_LEN, 0400);
+		    BRCMF_FW_ALTPATH_LEN, 0600);
 MODULE_PARM_DESC(alternative_fw_path, "Alternative firmware path");
=20
+char brcmf_mac_addr[18];
+module_param_string(nvram_mac_addr, brcmf_mac_addr,
+			18, 0600);
+MODULE_PARM_DESC(nvram_mac_addr, "Set MAC address in NVRAM");
+
+char brcmf_otp_chip_id[BRCMF_OTP_VERSION_MAX];
+module_param_string(otp_chip_id, brcmf_otp_chip_id, BRCMF_OTP_VERSION_MAX,=
 0400);
+MODULE_PARM_DESC(otp_chip_id, "Chip ID and revision from OTP");
+
+char brcmf_otp_nvram_id[BRCMF_OTP_VERSION_MAX];
+module_param_string(otp_nvram_id, brcmf_otp_nvram_id, BRCMF_OTP_VERSION_MA=
X, 0400);
+MODULE_PARM_DESC(otp_chip_id, "NVRAM variant from OTP");
+
 static int brcmf_fcmode;
 module_param_named(fcmode, brcmf_fcmode, int, 0);
 MODULE_PARM_DESC(fcmode, "Mode of firmware signalled flow control");
@@ -75,7 +88,6 @@ MODULE_PARM_DESC(ignore_probe_fail, "always succeed probe=
 for debugging");
 #endif
=20
 static struct brcmfmac_platform_data *brcmfmac_pdata;
-struct brcmf_mp_global_t brcmf_mp_global;
=20
 void brcmf_c_set_joinpref_default(struct brcmf_if *ifp)
 {
@@ -376,22 +388,6 @@ void __brcmf_dbg(u32 level, const char *func, const ch=
ar *fmt, ...)
 }
 #endif
=20
-static void brcmf_mp_attach(void)
-{
-	/* If module param firmware path is set then this will always be used,
-	 * if not set then if available use the platform data version. To make
-	 * sure it gets initialized at all, always copy the module param version
-	 */
-	strlcpy(brcmf_mp_global.firmware_path, brcmf_firmware_path,
-		BRCMF_FW_ALTPATH_LEN);
-	if ((brcmfmac_pdata) && (brcmfmac_pdata->fw_alternative_path) &&
-	    (brcmf_mp_global.firmware_path[0] =3D=3D '\0')) {
-		strlcpy(brcmf_mp_global.firmware_path,
-			brcmfmac_pdata->fw_alternative_path,
-			BRCMF_FW_ALTPATH_LEN);
-	}
-}
-
 struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 					       enum brcmf_bus_type bus_type,
 					       u32 chip, u32 chiprev)
@@ -492,9 +488,6 @@ static int __init brcmfmac_module_init(void)
 	if (err =3D=3D -ENODEV)
 		brcmf_dbg(INFO, "No platform data available.\n");
=20
-	/* Initialize global module paramaters */
-	brcmf_mp_attach();
-
 	/* Continue the initialization by registering the different busses */
 	err =3D brcmf_core_init();
 	if (err) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
index 8b5f49997c8b5..3b6ba43af4d51 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
@@ -10,25 +10,12 @@
 #include "fwil_types.h"
=20
 #define BRCMF_FW_ALTPATH_LEN			256
+#define BRCMF_OTP_VERSION_MAX			64
=20
-/* Definitions for the module global and device specific settings are defi=
ned
- * here. Two structs are used for them. brcmf_mp_global_t and brcmf_mp_dev=
ice.
- * The mp_global is instantiated once in a global struct and gets initiali=
zed
- * by the common_attach function which should be called before any other
- * (module) initiliazation takes place. The device specific settings is pa=
rt
- * of the drvr struct and should be initialized on every brcmf_attach.
- */
-
-/**
- * struct brcmf_mp_global_t - Global module paramaters.
- *
- * @firmware_path: Alternative firmware path.
- */
-struct brcmf_mp_global_t {
-	char	firmware_path[BRCMF_FW_ALTPATH_LEN];
-};
-
-extern struct brcmf_mp_global_t brcmf_mp_global;
+extern char brcmf_firmware_path[BRCMF_FW_ALTPATH_LEN];
+extern char brcmf_mac_addr[18];
+extern char brcmf_otp_chip_id[BRCMF_OTP_VERSION_MAX];
+extern char brcmf_otp_nvram_id[BRCMF_OTP_VERSION_MAX];
=20
 /**
  * struct brcmf_mp_device - Device module paramaters.
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/=
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index d821a4758f8cf..c3a05e254c851 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -368,6 +368,35 @@ static void brcmf_fw_add_defaults(struct nvram_parser =
*nvp)
 	nvp->nvram_len++;
 }
=20
+static void brcmf_fw_set_macaddr(struct nvram_parser *nvp, const char *mac=
_addr)
+{
+	uint8_t mac[6] =3D { 0 };
+	size_t len =3D strlen("macaddr=3D") + 17 + 1; /* 17 =3D "aa:bb:cc:dd:ee:f=
f" */
+	unsigned i =3D 0;
+	unsigned long res =3D 0;
+	char tmp[3];
+
+	while(mac_addr[0] && mac_addr[1] && i < 6) {
+		tmp[0] =3D mac_addr[0];
+		tmp[1] =3D mac_addr[1];
+		tmp[2] =3D 0;
+		if(kstrtoul(tmp, 16, &res))
+			break;
+		mac[i] =3D res;
+		mac_addr +=3D 2;
+		i ++;
+		while(*mac_addr =3D=3D ':' || *mac_addr =3D=3D ' ' || *mac_addr =3D=3D '=
-')
+			mac_addr ++;
+	}
+	if(i < 6)
+		pr_warn("invalid MAC address supplied for brcmfmac!\n");
+
+	memmove(&nvp->nvram[len], &nvp->nvram[0], nvp->nvram_len);
+	nvp->nvram_len +=3D len;
+	sprintf(&nvp->nvram[0], "macaddr=3D%02x:%02x:%02x:%02x:%02x:%02x",
+		mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+}
+
 /* brcmf_nvram_strip :Takes a buffer of "<var>=3D<value>\n" lines read fro=
m a fil
  * and ending in a NUL. Removes carriage returns, empty lines, comment lin=
es,
  * and converts newlines to NULs. Shortens buffer as needed and pads with =
NULs.
@@ -404,8 +433,11 @@ static void *brcmf_fw_nvram_strip(const u8 *data, size=
_t data_len,
=20
 	brcmf_fw_add_defaults(&nvp);
=20
+	if(brcmf_mac_addr[0])
+		brcmf_fw_set_macaddr(&nvp, brcmf_mac_addr);
+
 	pad =3D nvp.nvram_len;
-	*new_length =3D roundup(nvp.nvram_len + 1, 4);
+	*new_length =3D roundup(nvp.nvram_len + 1, 8) + 4;
 	while (pad !=3D *new_length) {
 		nvp.nvram[pad] =3D 0;
 		pad++;
@@ -721,7 +753,7 @@ brcmf_fw_alloc_request(u32 chip, u32 chiprev,
 	brcmf_info("using %s for chip %s\n",
 		   mapping_table[i].fw_base, chipname);
=20
-	mp_path =3D brcmf_mp_global.firmware_path;
+	mp_path =3D brcmf_firmware_path;
 	mp_path_len =3D strnlen(mp_path, BRCMF_FW_ALTPATH_LEN);
 	if (mp_path_len)
 		end =3D mp_path[mp_path_len - 1];
@@ -732,7 +764,7 @@ brcmf_fw_alloc_request(u32 chip, u32 chiprev,
 		fwreq->items[j].path =3D fwnames[j].path;
 		fwnames[j].path[0] =3D '\0';
 		/* check if firmware path is provided by module parameter */
-		if (brcmf_mp_global.firmware_path[0] !=3D '\0') {
+		if (brcmf_firmware_path[0] !=3D '\0') {
 			strlcpy(fwnames[j].path, mp_path,
 				BRCMF_FW_NAME_LEN);
=20
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drive=
rs/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index ec6fc7a150a6a..1c1d5131c3f36 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -565,7 +565,8 @@ static s32 brcmf_p2p_deinit_discovery(struct brcmf_p2p_=
info *p2p)
=20
 	/* Set the discovery state to SCAN */
 	vif =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
-	(void)brcmf_p2p_set_discover_state(vif->ifp, WL_P2P_DISC_ST_SCAN, 0, 0);
+	if (vif !=3D NULL)
+		(void)brcmf_p2p_set_discover_state(vif->ifp, WL_P2P_DISC_ST_SCAN, 0, 0);
=20
 	/* Disable P2P discovery in the firmware */
 	vif =3D p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
@@ -1351,6 +1352,8 @@ brcmf_p2p_gon_req_collision(struct brcmf_p2p_info *p2=
p, u8 *mac)
 	 * if not (sa addr > da addr),
 	 * this device will process gon request and drop gon req of peer.
 	 */
+	if(p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif =3D=3D NULL)
+		return false;
 	ifp =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->ifp;
 	if (memcmp(mac, ifp->mac_addr, ETH_ALEN) < 0) {
 		brcmf_dbg(INFO, "Block transmit gon req !!!\n");
@@ -1559,6 +1562,10 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2=
p_info *p2p,
 	else
 		vif =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
=20
+	if (vif =3D=3D NULL) {
+		bphy_err(drvr, " no P2P interface available\n");
+		goto exit;
+	}
 	err =3D brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
 					sizeof(*af_params));
 	if (err) {
@@ -1734,8 +1741,11 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg802=
11_info *cfg,
 	uint delta_ms;
 	unsigned long dwell_jiffies =3D 0;
 	bool dwell_overflow =3D false;
-
 	u32 requested_dwell =3D le32_to_cpu(af_params->dwell_time);
+
+	if(p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif =3D=3D NULL)
+		goto exit;
+
 	action_frame =3D &af_params->action_frame;
 	action_frame_len =3D le16_to_cpu(action_frame->len);
=20
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 45bc502fcb341..2890b24a34d1d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -4,6 +4,7 @@
  */
=20
 #include <linux/kernel.h>
+#include <linux/random.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/pci.h>
@@ -58,6 +59,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
 BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
 BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
 BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
+BRCMF_FW_DEF(4378, "brcmfmac4378-pcie");
=20
 static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] =3D {
 	BRCMF_FW_ENTRY(BRCM_CC_43602_CHIP_ID, 0xFFFFFFFF, 43602),
@@ -79,6 +81,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwn=
ames[] =3D {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
+	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFFF, 4378),
 };
=20
 #define BRCMF_PCIE_FW_UP_TIMEOUT		5000 /* msec */
@@ -109,6 +112,12 @@ static const struct brcmf_firmware_mapping brcmf_pcie_=
fwnames[] =3D {
 #define BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_0	0x140
 #define BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_1	0x144
=20
+#define BRCMF_PCIE_64_PCIE2REG_INTMASK		0xC14
+#define BRCMF_PCIE_64_PCIE2REG_MAILBOXINT	0xC30
+#define BRCMF_PCIE_64_PCIE2REG_MAILBOXMASK	0xC34
+#define BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_0	0xA20
+#define BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_1	0xA24
+
 #define BRCMF_PCIE2_INTA			0x01
 #define BRCMF_PCIE2_INTB			0x02
=20
@@ -137,6 +146,40 @@ static const struct brcmf_firmware_mapping brcmf_pcie_=
fwnames[] =3D {
 						 BRCMF_PCIE_MB_INT_D2H3_DB0 | \
 						 BRCMF_PCIE_MB_INT_D2H3_DB1)
=20
+#define	BRCMF_PCIE_64_MB_INT_D2H0_DB0		1
+#define	BRCMF_PCIE_64_MB_INT_D2H0_DB1		2
+#define	BRCMF_PCIE_64_MB_INT_D2H1_DB0		4
+#define	BRCMF_PCIE_64_MB_INT_D2H1_DB1		8
+#define	BRCMF_PCIE_64_MB_INT_D2H2_DB0		0x10
+#define	BRCMF_PCIE_64_MB_INT_D2H2_DB1		0x20
+#define	BRCMF_PCIE_64_MB_INT_D2H3_DB0		0x40
+#define	BRCMF_PCIE_64_MB_INT_D2H3_DB1		0x80
+#define	BRCMF_PCIE_64_MB_INT_D2H4_DB0		0x100
+#define	BRCMF_PCIE_64_MB_INT_D2H4_DB1		0x200
+#define	BRCMF_PCIE_64_MB_INT_D2H5_DB0		0x400
+#define	BRCMF_PCIE_64_MB_INT_D2H5_DB1		0x800
+#define	BRCMF_PCIE_64_MB_INT_D2H6_DB0		0x1000
+#define	BRCMF_PCIE_64_MB_INT_D2H6_DB1		0x2000
+#define	BRCMF_PCIE_64_MB_INT_D2H7_DB0		0x4000
+#define	BRCMF_PCIE_64_MB_INT_D2H7_DB1		0x8000
+
+#define BRCMF_PCIE_64_MB_INT_D2H_DB		(BRCMF_PCIE_64_MB_INT_D2H0_DB0 | \
+						 BRCMF_PCIE_64_MB_INT_D2H0_DB1 | \
+						 BRCMF_PCIE_64_MB_INT_D2H1_DB0 | \
+						 BRCMF_PCIE_64_MB_INT_D2H1_DB1 | \
+						 BRCMF_PCIE_64_MB_INT_D2H2_DB0 | \
+						 BRCMF_PCIE_64_MB_INT_D2H2_DB1 | \
+						 BRCMF_PCIE_64_MB_INT_D2H3_DB0 | \
+						 BRCMF_PCIE_64_MB_INT_D2H3_DB1 | \
+						 BRCMF_PCIE_64_MB_INT_D2H4_DB0 | \
+						 BRCMF_PCIE_64_MB_INT_D2H4_DB1 | \
+						 BRCMF_PCIE_64_MB_INT_D2H5_DB0 | \
+						 BRCMF_PCIE_64_MB_INT_D2H5_DB1 | \
+						 BRCMF_PCIE_64_MB_INT_D2H6_DB0 | \
+						 BRCMF_PCIE_64_MB_INT_D2H6_DB1 | \
+						 BRCMF_PCIE_64_MB_INT_D2H7_DB0 | \
+						 BRCMF_PCIE_64_MB_INT_D2H7_DB1)
+
 #define BRCMF_PCIE_SHARED_VERSION_7		7
 #define BRCMF_PCIE_MIN_SHARED_VERSION		5
 #define BRCMF_PCIE_MAX_SHARED_VERSION		BRCMF_PCIE_SHARED_VERSION_7
@@ -351,6 +394,15 @@ brcmf_pcie_read_reg32(struct brcmf_pciedev_info *devin=
fo, u32 reg_offset)
 }
=20
=20
+static u16
+brcmf_pcie_read_reg16(struct brcmf_pciedev_info *devinfo, u32 reg_offset)
+{
+	void __iomem *address =3D devinfo->regs + reg_offset;
+
+	return (ioread16(address));
+}
+
+
 static void
 brcmf_pcie_write_reg32(struct brcmf_pciedev_info *devinfo, u32 reg_offset,
 		       u32 value)
@@ -528,6 +580,37 @@ brcmf_pcie_copy_dev_tomem(struct brcmf_pciedev_info *d=
evinfo, u32 mem_offset,
 }
=20
=20
+static u32
+brcmf_pcie_reg_map(struct brcmf_pciedev_info *devinfo, u32 reg)
+{
+	switch(reg) {
+	case BRCMF_PCIE_PCIE2REG_INTMASK:
+		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+			return BRCMF_PCIE_64_PCIE2REG_INTMASK;
+		return reg;
+	case BRCMF_PCIE_PCIE2REG_MAILBOXINT:
+		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+			return BRCMF_PCIE_64_PCIE2REG_MAILBOXINT;
+		return reg;
+	case BRCMF_PCIE_PCIE2REG_MAILBOXMASK:
+		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+			return BRCMF_PCIE_64_PCIE2REG_MAILBOXMASK;
+		return reg;
+	case BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_0:
+		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+			return BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_0;
+		return reg;
+	case BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_1:
+		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+			return BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_1;
+		return reg;
+	default:
+		return reg;
+	}
+}
+
+
+
 #define WRITECC32(devinfo, reg, value) brcmf_pcie_write_reg32(devinfo, \
 		CHIPCREGOFFS(reg), value)
=20
@@ -543,6 +626,7 @@ brcmf_pcie_select_core(struct brcmf_pciedev_info *devin=
fo, u16 coreid)
 	core =3D brcmf_chip_get_core(devinfo->ci, coreid);
 	if (core) {
 		bar0_win =3D core->base;
+
 		pci_write_config_dword(pdev, BRCMF_PCIE_BAR0_WINDOW, bar0_win);
 		if (pci_read_config_dword(pdev, BRCMF_PCIE_BAR0_WINDOW,
 					  &bar0_win) =3D=3D 0) {
@@ -615,11 +699,129 @@ static void brcmf_pcie_reset_device(struct brcmf_pci=
edev_info *devinfo)
 	}
 }
=20
+#define OTP_SIZE		64
+#define OTP_CORE_ID		BCMA_CORE_GCI
+#define OTP_CC_ADDR_4378	0x1120
+
+static void brcmf_pcie_process_otp_tuple(struct brcmf_pciedev_info *devinf=
o, u8 type, u8 size, u8 *data)
+{
+	char tmp[OTP_SIZE], t_chiprev[8] =3D "", t_module[8] =3D "", t_modrev[8] =
=3D "", t_vendor[8] =3D "", t_chip[8] =3D "";
+	unsigned i, len;
+
+	switch(type) {
+	case 0x15: /* system vendor OTP */
+		if(size < 4)
+			return;
+		if(*(u32 *)data !=3D 8)
+			dev_warn(&devinfo->pdev->dev, "system vendor OTP header unexpected: %d\=
n", *(u32 *)data);
+		size -=3D 4;
+		data +=3D 4;
+		while(size) {
+			if(data[0] =3D=3D 0xFF)
+				break;
+			for(len=3D0; len<size; len++)
+				if(data[len] =3D=3D 0x00 || data[len] =3D=3D ' ' || data[len] =3D=3D 0=
xFF)
+					break;
+			memcpy(tmp, data, len);
+			tmp[len] =3D 0;
+			data +=3D len;
+			size -=3D len;
+			if(size) {
+				data ++;
+				size --;
+			}
+			brcmf_dbg(PCIE, "system vendor OTP element '%s'\n", tmp);
+
+			if(len < 2)
+				continue;
+			if(tmp[1] =3D=3D '=3D' && len < 8)
+				switch(tmp[0]) {
+				case 's':
+					strcpy(t_chiprev, tmp + 2);
+					break;
+				case 'M':
+					strcpy(t_module, tmp + 2);
+					break;
+				case 'm':
+					strcpy(t_modrev, tmp + 2);
+					break;
+				case 'V':
+					strcpy(t_vendor, tmp + 2);
+					break;
+				}
+		}
+
+		sprintf(t_chip, (devinfo->ci->chip > 40000) ? "%05d" : "%04x", devinfo->=
ci->chip);
+		dev_info(&devinfo->pdev->dev, "module revision data: chip %s, chip rev %=
s, module %s, module rev %s, vendor %s\n", t_chip, t_chiprev, t_module, t_m=
odrev, t_vendor);
+
+		if(t_chiprev[0])
+			sprintf(brcmf_otp_chip_id, "C-%s__s-%s", t_chip, t_chiprev);
+		else
+			sprintf(brcmf_otp_chip_id, "C-%s", t_chip);
+		sprintf(brcmf_otp_nvram_id, "M-%s_V-%s__m-%s", t_module, t_vendor, t_mod=
rev);
+
+		break;
+	case 0x80: /* Broadcom CIS */
+		if(size < 1)
+			return;
+		switch(data[0]) {
+		case 0x83: /* serial number */
+			for(i=3D0; i<16 && i<size-1; i++)
+				sprintf(tmp + 2 * i, "%02x", data[i+1]);
+			dev_info(&devinfo->pdev->dev, "module serial number: %s\n", tmp);
+			break;
+		}
+		break;
+	}
+}
+
+static u32 brcmf_pcie_buscore_prep_addr(const struct pci_dev *pdev, u32 ad=
dr);
+
+static void brcmf_pcie_read_otp(struct brcmf_pciedev_info *devinfo)
+{
+	u8 otp[OTP_SIZE], type, size;
+	unsigned i;
+	struct brcmf_core *core;
+	u32 base;
+
+	if (devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID) {
+		/* for whatever reason, reading OTP works only once after reset */
+		if(brcmf_otp_chip_id[0])
+			return;
+
+		core =3D brcmf_chip_get_core(devinfo->ci, OTP_CORE_ID);
+		if(!core) {
+			dev_err(&devinfo->pdev->dev, "can't find core for OTP\n");
+			return;
+		}
+		base =3D brcmf_pcie_buscore_prep_addr(devinfo->pdev, core->base + OTP_CC=
_ADDR_4378);
+
+		for(i=3D0; i<OTP_SIZE; i+=3D2)
+			((u16 *)otp)[i/2] =3D brcmf_pcie_read_reg16(devinfo, base + i);
+
+		i =3D 0;
+		while(i < OTP_SIZE - 1) {
+			type =3D otp[i];
+			if(!type) { /* null tuple */
+				i ++;
+				continue;
+			}
+			size =3D otp[i + 1];
+			i +=3D 2;
+			if(i + size <=3D OTP_SIZE)
+				brcmf_pcie_process_otp_tuple(devinfo, type, size, otp + i);
+			i +=3D size;
+		}
+	}
+}
+
=20
 static void brcmf_pcie_attach(struct brcmf_pciedev_info *devinfo)
 {
 	u32 config;
=20
+	brcmf_pcie_read_otp(devinfo);
+
 	/* BAR1 window may not be sized properly */
 	brcmf_pcie_select_core(devinfo, BCMA_CORE_PCIE2);
 	brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_CONFIGADDR, 0x4e0);
@@ -809,30 +1011,34 @@ static void brcmf_pcie_bus_console_read(struct brcmf=
_pciedev_info *devinfo,
=20
 static void brcmf_pcie_intr_disable(struct brcmf_pciedev_info *devinfo)
 {
-	brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXMASK, 0);
+	brcmf_pcie_write_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRCMF_PCIE_PC=
IE2REG_MAILBOXMASK), 0);
 }
=20
=20
 static void brcmf_pcie_intr_enable(struct brcmf_pciedev_info *devinfo)
 {
-	brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXMASK,
-			       BRCMF_PCIE_MB_INT_D2H_DB |
-			       BRCMF_PCIE_MB_INT_FN0_0 |
-			       BRCMF_PCIE_MB_INT_FN0_1);
+	if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+		brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_64_PCIE2REG_MAILBOXMASK,
+				       BRCMF_PCIE_64_MB_INT_D2H_DB);
+	else
+		brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXMASK,
+				       BRCMF_PCIE_MB_INT_D2H_DB |
+				       BRCMF_PCIE_MB_INT_FN0_0 |
+				       BRCMF_PCIE_MB_INT_FN0_1);
 }
=20
 static void brcmf_pcie_hostready(struct brcmf_pciedev_info *devinfo)
 {
 	if (devinfo->shared.flags & BRCMF_PCIE_SHARED_HOSTRDY_DB1)
 		brcmf_pcie_write_reg32(devinfo,
-				       BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_1, 1);
+				       brcmf_pcie_reg_map(devinfo, BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_1),=
 1);
 }
=20
 static irqreturn_t brcmf_pcie_quick_check_isr(int irq, void *arg)
 {
 	struct brcmf_pciedev_info *devinfo =3D (struct brcmf_pciedev_info *)arg;
=20
-	if (brcmf_pcie_read_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXINT)) {
+	if (brcmf_pcie_read_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRCMF_PCIE=
_PCIE2REG_MAILBOXINT))) {
 		brcmf_pcie_intr_disable(devinfo);
 		brcmf_dbg(PCIE, "Enter\n");
 		return IRQ_WAKE_THREAD;
@@ -844,18 +1050,23 @@ static irqreturn_t brcmf_pcie_quick_check_isr(int ir=
q, void *arg)
 static irqreturn_t brcmf_pcie_isr_thread(int irq, void *arg)
 {
 	struct brcmf_pciedev_info *devinfo =3D (struct brcmf_pciedev_info *)arg;
-	u32 status;
+	u32 status, mask;
+
+	if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+		mask =3D BRCMF_PCIE_64_MB_INT_D2H_DB;
+	else
+		mask =3D BRCMF_PCIE_MB_INT_D2H_DB;
=20
 	devinfo->in_irq =3D true;
-	status =3D brcmf_pcie_read_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXINT)=
;
+	status =3D brcmf_pcie_read_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRC=
MF_PCIE_PCIE2REG_MAILBOXINT));
 	brcmf_dbg(PCIE, "Enter %x\n", status);
 	if (status) {
-		brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXINT,
+		brcmf_pcie_write_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRCMF_PCIE_P=
CIE2REG_MAILBOXINT),
 				       status);
 		if (status & (BRCMF_PCIE_MB_INT_FN0_0 |
 			      BRCMF_PCIE_MB_INT_FN0_1))
 			brcmf_pcie_handle_mb_data(devinfo);
-		if (status & BRCMF_PCIE_MB_INT_D2H_DB) {
+		if (status & mask) {
 			if (devinfo->state =3D=3D BRCMFMAC_PCIE_STATE_UP)
 				brcmf_proto_msgbuf_rx_trigger(
 							&devinfo->pdev->dev);
@@ -914,8 +1125,8 @@ static void brcmf_pcie_release_irq(struct brcmf_pciede=
v_info *devinfo)
 	if (devinfo->in_irq)
 		brcmf_err(bus, "Still in IRQ (processing) !!!\n");
=20
-	status =3D brcmf_pcie_read_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXINT)=
;
-	brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXINT, status);
+	status =3D brcmf_pcie_read_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRC=
MF_PCIE_PCIE2REG_MAILBOXINT));
+	brcmf_pcie_write_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRCMF_PCIE_PC=
IE2REG_MAILBOXINT), status);
=20
 	devinfo->irq_allocated =3D false;
 }
@@ -967,7 +1178,7 @@ static int brcmf_pcie_ring_mb_ring_bell(void *ctx)
=20
 	brcmf_dbg(PCIE, "RING !\n");
 	/* Any arbitrary value will do, lets use 1 */
-	brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_0, 1);
+	brcmf_pcie_write_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRCMF_PCIE_PC=
IE2REG_H2D_MAILBOX_0), 1);
=20
 	return 0;
 }
@@ -1543,6 +1754,8 @@ brcmf_pcie_init_share_ram_info(struct brcmf_pciedev_i=
nfo *devinfo,
 	return 0;
 }
=20
+#define RANDOMBYTES_SIZE        264
+#define CLEAR_SIZE              256
=20
 static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo=
,
 					const struct firmware *fw, void *nvram,
@@ -1553,15 +1766,16 @@ static int brcmf_pcie_download_fw_nvram(struct brcm=
f_pciedev_info *devinfo,
 	u32 sharedram_addr_written;
 	u32 loop_counter;
 	int err;
-	u32 address;
+	u32 address, clraddr;
 	u32 resetintr;
+	uint8_t randb[RANDOMBYTES_SIZE];
=20
 	brcmf_dbg(PCIE, "Halt ARM.\n");
 	err =3D brcmf_pcie_enter_download_state(devinfo);
 	if (err)
 		return err;
=20
-	brcmf_dbg(PCIE, "Download FW %s\n", devinfo->fw_name);
+	brcmf_dbg(PCIE, "Download FW %s 0x%x 0x%x\n", devinfo->fw_name, (unsigned=
)devinfo->ci->rambase, (unsigned)fw->size);
 	brcmf_pcie_copy_mem_todev(devinfo, devinfo->ci->rambase,
 				  (void *)fw->data, fw->size);
=20
@@ -1574,20 +1788,38 @@ static int brcmf_pcie_download_fw_nvram(struct brcm=
f_pciedev_info *devinfo,
 	brcmf_pcie_write_ram32(devinfo, devinfo->ci->ramsize - 4, 0);
=20
 	if (nvram) {
-		brcmf_dbg(PCIE, "Download NVRAM %s\n", devinfo->nvram_name);
 		address =3D devinfo->ci->rambase + devinfo->ci->ramsize -
 			  nvram_len;
+		brcmf_dbg(PCIE, "Download NVRAM %s 0x%x 0x%x\n", devinfo->nvram_name, ad=
dress, nvram_len);
 		brcmf_pcie_copy_mem_todev(devinfo, address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
+
+		address -=3D RANDOMBYTES_SIZE;
+		get_random_bytes(randb, RANDOMBYTES_SIZE - 8);
+		memcpy(randb + RANDOMBYTES_SIZE - 8, "\x00\x01\x00\x00\xde\xc0\xed\xfe",=
 8);
+		brcmf_pcie_copy_mem_todev(devinfo, address, randb, RANDOMBYTES_SIZE);
 	} else {
 		brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
 			  devinfo->nvram_name);
+		address =3D devinfo->ci->rambase + devinfo->ci->ramsize;
+	}
+
+	memset(randb, 0, CLEAR_SIZE);
+	clraddr =3D devinfo->ci->rambase + fw->size;
+	while(clraddr < address) {
+		u32 block =3D address - clraddr;
+		if(block > CLEAR_SIZE)
+			block =3D CLEAR_SIZE;
+		if(((clraddr + block - 1) ^ clraddr) & -CLEAR_SIZE)
+			block =3D (CLEAR_SIZE - clraddr) & (CLEAR_SIZE - 1);
+		brcmf_pcie_copy_mem_todev(devinfo, clraddr, randb, block);
+		clraddr +=3D block;
 	}
=20
 	sharedram_addr_written =3D brcmf_pcie_read_ram32(devinfo,
 						       devinfo->ci->ramsize -
 						       4);
-	brcmf_dbg(PCIE, "Bring ARM in running state\n");
+	brcmf_dbg(PCIE, "Bring ARM in running state (RAM sign: 0x%08x)\n", shared=
ram_addr_written);
 	err =3D brcmf_pcie_exit_download_state(devinfo, resetintr);
 	if (err)
 		return err;
@@ -1719,9 +1951,9 @@ static int brcmf_pcie_buscore_reset(void *ctx, struct=
 brcmf_chip *chip)
 	devinfo->ci =3D chip;
 	brcmf_pcie_reset_device(devinfo);
=20
-	val =3D brcmf_pcie_read_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXINT);
+	val =3D brcmf_pcie_read_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRCMF_=
PCIE_PCIE2REG_MAILBOXINT));
 	if (val !=3D 0xffffffff)
-		brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXINT,
+		brcmf_pcie_write_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRCMF_PCIE_P=
CIE2REG_MAILBOXINT),
 				       val);
=20
 	return 0;
@@ -1892,6 +2124,16 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct =
pci_device_id *id)
 		goto fail;
 	}
=20
+	if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID) {
+		brcmf_pcie_read_otp(devinfo);
+
+		if(!brcmf_mac_addr[0]) {
+			dev_info(&pdev->dev, "hardware discovery complete, not starting driver\=
n");
+			ret =3D -ENODEV;
+			goto exit;
+		}
+	}
+
 	pcie_bus_dev =3D kzalloc(sizeof(*pcie_bus_dev), GFP_KERNEL);
 	if (pcie_bus_dev =3D=3D NULL) {
 		ret =3D -ENOMEM;
@@ -1954,6 +2196,7 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct p=
ci_device_id *id)
 	kfree(bus);
 fail:
 	brcmf_err(NULL, "failed %x:%x\n", pdev->vendor, pdev->device);
+exit:
 	brcmf_pcie_release_resource(devinfo);
 	if (devinfo->ci)
 		brcmf_chip_detach(devinfo->ci);
@@ -2053,7 +2296,7 @@ static int brcmf_pcie_pm_leave_D3(struct device *dev)
 	brcmf_dbg(PCIE, "Enter, dev=3D%p, bus=3D%p\n", dev, bus);
=20
 	/* Check if device is still up and running, if so we are ready */
-	if (brcmf_pcie_read_reg32(devinfo, BRCMF_PCIE_PCIE2REG_INTMASK) !=3D 0) {
+	if (brcmf_pcie_read_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRCMF_PCIE=
_PCIE2REG_INTMASK)) !=3D 0) {
 		brcmf_dbg(PCIE, "Try to wakeup device....\n");
 		if (brcmf_pcie_send_mb_data(devinfo, BRCMF_H2D_HOST_D0_INFORM))
 			goto cleanup;
@@ -2119,6 +2362,7 @@ static const struct pci_device_id brcmf_pcie_devid_ta=
ble[] =3D {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_2G_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID),
 	{ /* end: all zeroes */ }
 };
=20
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h =
b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index c6c4be05159d4..083cc6927417e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -50,6 +50,7 @@
 #define BRCM_CC_43664_CHIP_ID		43664
 #define BRCM_CC_43666_CHIP_ID		43666
 #define BRCM_CC_4371_CHIP_ID		0x4371
+#define BRCM_CC_4378_CHIP_ID		0x4378
 #define CY_CC_4373_CHIP_ID		0x4373
 #define CY_CC_43012_CHIP_ID		43012
 #define CY_CC_43752_CHIP_ID		43752
@@ -83,6 +84,7 @@
 #define BRCM_PCIE_4366_2G_DEVICE_ID	0x43c4
 #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
 #define BRCM_PCIE_4371_DEVICE_ID	0x440d
+#define BRCM_PCIE_4378_DEVICE_ID	0x4425
=20
=20
 /* brcmsmac IDs */

