Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFCE7C4AAE
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfJBJbU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 05:31:20 -0400
Received: from mail-eopbgr780090.outbound.protection.outlook.com ([40.107.78.90]:44656
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfJBJbU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 05:31:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1zdiht1ZwYah5FUIYJQbEZ85tR4Mdau77q8PqMxRV6K8JUjVk2YY0ja1jtNKft59OF0M2qRaGsZbd49aYMfZsUMkTIgHOfz56/NGXu/ZLk3NSSU+svKsqcl+xehx01NFhFnzxjD7EvC8wDTshjetXNVBcX0KWGDZwETGP7SuyCv+acMUwNonpcHZtPaSe1ooIU8RpPX5vShHwWw1CdyzxkjJVFc1nqz3Ob3ZbdEdpqo1shy9qMwNT2EYavKQSeziQfdNyF6Oepnmb3R/8Q0zJ18bxRDFJG6OzMNJpcG6iK+48UjXsDQSDmpM4A3uApitLA0OBae/Va01TdJhRR82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4sb/USG1Rrh6Tz3gnm6xfRIYeXyIYoFoKe7NA5jEdM=;
 b=Fa0qQKXmDuqM+9c1PwmqkafXrbsRLzbHYuxhftAizkDGKr0HyLon480o9ukPiNPG5jI4bT2u58WmoTUXp2ShhncXsen5LjB8LAGX7Bdjj+KKUwUYYi+zrt80wXUpSsQiB4icy6LUUHP0Oj4V498LDvkI0uS0KFsQzK36eBiOLLRQiMOO75Scb/mukyMgJRV/eq0GqTVKh5tEUif9SM7Z+yQiuVbZtM6J8PClxAse144yp28od61h03fh0Alx6GS5oj2UHivxqoSG3lgLIOeCzKeGDQu3DBxSyJMT570xmM3XjChf0CKwzsAJikCNkUz2Lk5TTqXPi7n1PRMc26oUgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4sb/USG1Rrh6Tz3gnm6xfRIYeXyIYoFoKe7NA5jEdM=;
 b=EA0yVS0gRUqIcG6UT/dPVBJZsqpRGDhjtp8ueNOzTuXVSviR2cgWA1t8eaoK0vy0RUgjHom82yNt36Oi0tChLmMfreI5o/AiSNGaElYLdjNUyAvlmdOfsx0H/cJmB1TJvjvQnySVPEJkWCCa8OhpXxiIlL4UoI97BNf7114vmVY=
Received: from DM6PR06MB5804.namprd06.prod.outlook.com (20.179.161.141) by
 DM6PR06MB5755.namprd06.prod.outlook.com (20.179.160.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 09:31:12 +0000
Received: from DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::78f8:b2dd:fe3e:324c]) by DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::78f8:b2dd:fe3e:324c%5]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 09:31:12 +0000
From:   Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanley Hsu <Stanley.Hsu@cypress.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Subject: [PATCH V3] brcmfmac: add support for SAE authentication offload
Thread-Topic: [PATCH V3] brcmfmac: add support for SAE authentication offload
Thread-Index: AQHVeQQhI0a5ySRfM0aaABZLxNbqqA==
Date:   Wed, 2 Oct 2019 09:31:12 +0000
Message-ID: <1570008643-113848-1-git-send-email-chi-hsien.lin@cypress.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [12.110.209.245]
x-clientproxiedby: BL0PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:207:17::37) To DM6PR06MB5804.namprd06.prod.outlook.com
 (2603:10b6:5:1a6::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ebb0293-815b-44da-4b17-08d7471b4387
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR06MB5755:|DM6PR06MB5755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR06MB5755BE5B891C047001F9627FBB9C0@DM6PR06MB5755.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(189003)(54534003)(50226002)(305945005)(8936002)(7736002)(66946007)(8676002)(64756008)(81166006)(81156014)(66556008)(66476007)(66446008)(6512007)(66066001)(14454004)(256004)(4326008)(5660300002)(107886003)(14444005)(6116002)(3846002)(6916009)(2501003)(2351001)(99286004)(5640700003)(36756003)(6436002)(102836004)(52116002)(386003)(6506007)(316002)(26005)(478600001)(86362001)(71200400001)(54906003)(71190400001)(486006)(476003)(2616005)(2906002)(25786009)(6486002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB5755;H:DM6PR06MB5804.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HG1FjUtUZF28e5PUiqPYZNDLgH7aRUAiIuQWDKsP8qKJ86X4xT4y6WQKu2bkGvBzEcohzfDRar/6I0OxITnKlg5AJgnRkPa98s/gMoE981Yb1WxL2OW+XvFQVEDSFTew80MCUZPume0RGJGhx7lh63fO5JL9oCAYyg9fSxGET8jdBB3AWg78baufi/qrQSkwoKwFRqCJz4xRs5+e/fP3bjvuhrqAxKe5dhWoXpLmM4sDS18fM6RbnxR1177ut4qCjx5i6rmyxjdTx+UUz0icB/4JOnGqx4LGA7HzcpIqt4eUjHYA933jUaIQvzuYwedWvLHpiS1h02U99MUio6T4LU0mzr8bArnBpizH90vNsbzn6lZRCkDzPSq2ufLiuvT6F4DIoHn7Lrr9U77PHqdpPYAIVL8m6T4DT72KZo+swaE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebb0293-815b-44da-4b17-08d7471b4387
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 09:31:12.4160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5sRQuFpgXmMZ6YCwPPZEg6ZWi2o1dNMeGB7YL61zebP0xWaGO2MMPEh6xfZLIUe1E0BZNctXdNw4dLULJu0sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5755
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chung-Hsien Hsu <stanley.hsu@cypress.com>

The firmware may have SAE authentication code built-in. This is
detected by the driver and indicated in the wiphy features flags.
User-space can use this flag to determine whether or not to provide
the password material for SAE authentication in the nl80211 CONNECT
command.

Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---

Changelog:
V3:
  - V2 1/3 and 2/3 are already in wt-2019-10-01 nl80211 code.
  - Rebase V2 3/3 to wt-2019-10-01.
V2:
  - Change sae_pwd_len from u16 to u8.
  - Move the new attribute to bottom.

---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 73 ++++++++++++++++++=
++--
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |  3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c |  3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/feature.h |  4 +-
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       | 13 ++++
 .../broadcom/brcm80211/include/brcmu_wifi.h        |  2 +
 6 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/=
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index e3ebb7abbdae..25f2b9e125cd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1282,6 +1282,31 @@ static int brcmf_set_pmk(struct brcmf_if *ifp, const=
 u8 *pmk_data, u16 pmk_len)
 	return err;
 }
=20
+static int brcmf_set_sae_password(struct brcmf_if *ifp, const u8 *pwd_data=
,
+				  u16 pwd_len)
+{
+	struct brcmf_pub *drvr =3D ifp->drvr;
+	struct brcmf_wsec_sae_pwd_le sae_pwd;
+	int err;
+
+	if (pwd_len > BRCMF_WSEC_MAX_SAE_PASSWORD_LEN) {
+		bphy_err(drvr, "sae_password must be less than %d\n",
+			 BRCMF_WSEC_MAX_SAE_PASSWORD_LEN);
+		return -EINVAL;
+	}
+
+	sae_pwd.key_len =3D cpu_to_le16(pwd_len);
+	memcpy(sae_pwd.key, pwd_data, pwd_len);
+
+	err =3D brcmf_fil_iovar_data_set(ifp, "sae_password", &sae_pwd,
+				       sizeof(sae_pwd));
+	if (err < 0)
+		bphy_err(drvr, "failed to set SAE password in firmware (len=3D%u)\n",
+			 pwd_len);
+
+	return err;
+}
+
 static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason)
 {
 	struct brcmf_cfg80211_info *cfg =3D wiphy_to_cfg(vif->wdev.wiphy);
@@ -1505,6 +1530,8 @@ static s32 brcmf_set_wpa_version(struct net_device *n=
dev,
 		val =3D WPA_AUTH_PSK | WPA_AUTH_UNSPECIFIED;
 	else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2)
 		val =3D WPA2_AUTH_PSK | WPA2_AUTH_UNSPECIFIED;
+	else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_3)
+		val =3D WPA3_AUTH_SAE_PSK;
 	else
 		val =3D WPA_AUTH_DISABLED;
 	brcmf_dbg(CONN, "setting wpa_auth to 0x%0x\n", val);
@@ -1537,6 +1564,10 @@ static s32 brcmf_set_auth_type(struct net_device *nd=
ev,
 		val =3D 1;
 		brcmf_dbg(CONN, "shared key\n");
 		break;
+	case NL80211_AUTHTYPE_SAE:
+		val =3D 3;
+		brcmf_dbg(CONN, "SAE authentication\n");
+		break;
 	default:
 		val =3D 2;
 		brcmf_dbg(CONN, "automatic, auth type (%d)\n", sme->auth_type);
@@ -1702,6 +1733,16 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct c=
fg80211_connect_params *sme)
 				 sme->crypto.cipher_group);
 			return -EINVAL;
 		}
+	} else if (val & WPA3_AUTH_SAE_PSK) {
+		switch (sme->crypto.akm_suites[0]) {
+		case WLAN_AKM_SUITE_SAE:
+			val =3D WPA3_AUTH_SAE_PSK;
+			break;
+		default:
+			bphy_err(drvr, "invalid cipher group (%d)\n",
+				 sme->crypto.cipher_group);
+			return -EINVAL;
+		}
 	}
=20
 	if (profile->use_fwsup =3D=3D BRCMF_PROFILE_FWSUP_1X)
@@ -1773,7 +1814,8 @@ brcmf_set_sharedkey(struct net_device *ndev,
 	brcmf_dbg(CONN, "wpa_versions 0x%x cipher_pairwise 0x%x\n",
 		  sec->wpa_versions, sec->cipher_pairwise);
=20
-	if (sec->wpa_versions & (NL80211_WPA_VERSION_1 | NL80211_WPA_VERSION_2))
+	if (sec->wpa_versions & (NL80211_WPA_VERSION_1 | NL80211_WPA_VERSION_2 |
+				 NL80211_WPA_VERSION_3))
 		return 0;
=20
 	if (!(sec->cipher_pairwise &
@@ -1980,7 +2022,13 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct n=
et_device *ndev,
 		goto done;
 	}
=20
-	if (sme->crypto.psk) {
+	if (sme->crypto.sae_pwd) {
+		brcmf_dbg(INFO, "using SAE offload\n");
+		profile->use_fwsup =3D BRCMF_PROFILE_FWSUP_SAE;
+	}
+
+	if (sme->crypto.psk &&
+	    profile->use_fwsup !=3D BRCMF_PROFILE_FWSUP_SAE) {
 		if (WARN_ON(profile->use_fwsup !=3D BRCMF_PROFILE_FWSUP_NONE)) {
 			err =3D -EINVAL;
 			goto done;
@@ -1998,12 +2046,23 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct =
net_device *ndev,
 		}
 	}
=20
-	if (profile->use_fwsup =3D=3D BRCMF_PROFILE_FWSUP_PSK) {
+	if (profile->use_fwsup =3D=3D BRCMF_PROFILE_FWSUP_PSK)
 		err =3D brcmf_set_pmk(ifp, sme->crypto.psk,
 				    BRCMF_WSEC_MAX_PSK_LEN);
-		if (err)
+	else if (profile->use_fwsup =3D=3D BRCMF_PROFILE_FWSUP_SAE) {
+		/* clean up user-space RSNE */
+		if (brcmf_fil_iovar_data_set(ifp, "wpaie", NULL, 0)) {
+			bphy_err(drvr, "failed to clean up user-space RSNE\n");
 			goto done;
+		}
+		err =3D brcmf_set_sae_password(ifp, sme->crypto.sae_pwd,
+					     sme->crypto.sae_pwd_len);
+		if (!err && sme->crypto.psk)
+			err =3D brcmf_set_pmk(ifp, sme->crypto.psk,
+					    BRCMF_WSEC_MAX_PSK_LEN);
 	}
+	if (err)
+		goto done;
=20
 	/* Join with specific BSSID and cached SSID
 	 * If SSID is zero join based on BSSID only
@@ -5359,7 +5418,8 @@ static bool brcmf_is_linkup(struct brcmf_cfg80211_vif=
 *vif,
 	if (event =3D=3D BRCMF_E_SET_SSID && status =3D=3D BRCMF_E_STATUS_SUCCESS=
) {
 		brcmf_dbg(CONN, "Processing set ssid\n");
 		memcpy(vif->profile.bssid, e->addr, ETH_ALEN);
-		if (vif->profile.use_fwsup !=3D BRCMF_PROFILE_FWSUP_PSK)
+		if (vif->profile.use_fwsup !=3D BRCMF_PROFILE_FWSUP_PSK &&
+		    vif->profile.use_fwsup !=3D BRCMF_PROFILE_FWSUP_SAE)
 			return true;
=20
 		set_bit(BRCMF_VIF_STATUS_ASSOC_SUCCESS, &vif->sme_state);
@@ -6664,6 +6724,9 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, str=
uct brcmf_if *ifp)
 				      NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK);
 		wiphy_ext_feature_set(wiphy,
 				      NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_1X);
+		if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SAE))
+			wiphy_ext_feature_set(wiphy,
+					      NL80211_EXT_FEATURE_SAE_OFFLOAD);
 	}
 	wiphy->mgmt_stypes =3D brcmf_txrx_stypes;
 	wiphy->max_remain_on_channel_duration =3D 5000;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/=
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index 14d5bbad1db1..411457a4f85d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -107,7 +107,8 @@ struct brcmf_cfg80211_security {
 enum brcmf_profile_fwsup {
 	BRCMF_PROFILE_FWSUP_NONE,
 	BRCMF_PROFILE_FWSUP_PSK,
-	BRCMF_PROFILE_FWSUP_1X
+	BRCMF_PROFILE_FWSUP_1X,
+	BRCMF_PROFILE_FWSUP_SAE
 };
=20
 /**
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/d=
rivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 2c3526aeca6f..1c9c74cc958e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -39,7 +39,8 @@ static const struct brcmf_feat_fwcap brcmf_fwcap_map[] =
=3D {
 	{ BRCMF_FEAT_P2P, "p2p" },
 	{ BRCMF_FEAT_MONITOR, "monitor" },
 	{ BRCMF_FEAT_MONITOR_FMT_RADIOTAP, "rtap" },
-	{ BRCMF_FEAT_DOT11H, "802.11h" }
+	{ BRCMF_FEAT_DOT11H, "802.11h" },
+	{ BRCMF_FEAT_SAE, "sae" },
 };
=20
 #ifdef DEBUG
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h b/d=
rivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
index 736a8179f62f..280a1f6412d4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
@@ -26,6 +26,7 @@
  * MONITOR_FMT_RADIOTAP: firmware provides monitor packets with radiotap h=
eader
  * MONITOR_FMT_HW_RX_HDR: firmware provides monitor packets with hw/ucode =
header
  * DOT11H: firmware supports 802.11h
+ * SAE: simultaneous authentication of equals
  */
 #define BRCMF_FEAT_LIST \
 	BRCMF_FEAT_DEF(MBSS) \
@@ -45,7 +46,8 @@
 	BRCMF_FEAT_DEF(MONITOR) \
 	BRCMF_FEAT_DEF(MONITOR_FMT_RADIOTAP) \
 	BRCMF_FEAT_DEF(MONITOR_FMT_HW_RX_HDR) \
-	BRCMF_FEAT_DEF(DOT11H)
+	BRCMF_FEAT_DEF(DOT11H) \
+	BRCMF_FEAT_DEF(SAE)
=20
 /*
  * Quirks:
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index 37c512036e0e..de0ef1b545c4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -61,6 +61,8 @@
 #define BRCMF_WSEC_MAX_PSK_LEN		32
 #define	BRCMF_WSEC_PASSPHRASE		BIT(0)
=20
+#define BRCMF_WSEC_MAX_SAE_PASSWORD_LEN 128
+
 /* primary (ie tx) key */
 #define BRCMF_PRIMARY_KEY		(1 << 1)
 #define DOT11_BSSTYPE_ANY		2
@@ -518,6 +520,17 @@ struct brcmf_wsec_pmk_le {
 	u8 key[2 * BRCMF_WSEC_MAX_PSK_LEN + 1];
 };
=20
+/**
+ * struct brcmf_wsec_sae_pwd_le - firmware SAE password material.
+ *
+ * @key_len: number of octets in key materials.
+ * @key: SAE password material.
+ */
+struct brcmf_wsec_sae_pwd_le {
+	__le16 key_len;
+	u8 key[BRCMF_WSEC_MAX_SAE_PASSWORD_LEN];
+};
+
 /* Used to get specific STA parameters */
 struct brcmf_scb_val_le {
 	__le32 val;
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h b=
/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
index 7b31c212694d..7552bdb91991 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
@@ -231,6 +231,8 @@ static inline bool ac_bitmap_tst(u8 bitmap, int prec)
 #define WPA2_AUTH_FT		0x4000	/* Fast BSS Transition */
 #define WPA2_AUTH_PSK_SHA256	0x8000	/* PSK with SHA256 key derivation */
=20
+#define WPA3_AUTH_SAE_PSK	0x40000	/* SAE with 4-way handshake */
+
 #define DOT11_DEFAULT_RTS_LEN		2347
 #define DOT11_DEFAULT_FRAG_LEN		2346
=20
--=20
2.1.0

