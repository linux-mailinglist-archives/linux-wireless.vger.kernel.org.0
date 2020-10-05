Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C322283099
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgJEHJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 03:09:39 -0400
Received: from mail-bn8nam12on2107.outbound.protection.outlook.com ([40.107.237.107]:30945
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbgJEHJj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 03:09:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhYKyi1QXemFYofRly6ZwSDDN2NPS1UuJGtyUyLa7DKfz0XYTWgT1tpaQrWK01tqZoWGOX1NRHkHO9a4ABzFM9/Z8ukbb0nTHQeTVlfV5CAsGNM46WACmFURhrwK5IsGdV9s1fMRZxSLSKyIUu9ICsoVkyXVme5LwOsPF8/WHYrIsquogC89PmmdfKCO9hbyXmCcTnche20ktAcUlHKWd6139PlDBWZINgejDSkFztBp/vEUopomaiWA319Lii2JTH740icugk1nrTYGxyFKR6Lxfi5pRXtjs+snHyoDlpPTlld3P9MYuy2BiKazfnzi/daYkbrXk1yJ+nnLhjYPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUJD61fyPMDa+kUe3ZK1L9yg16WBN4Sc3fmlowjJ3fo=;
 b=JjMMV3P2dqTEPz4GguYmwe+ZQMLigX4LyOjapIBkSS9A6VeFiyRfb/5DD9NcRuCRkqHjXn8k2aTXeZ+RzwnEl/uWSDshBPScvuiqxcrCgO2B/DPR90j3MLzmgEzQ7RdVf6MpHmIFytlhQs7yjJx7TmmL874ZfO234UabNKcYIuhJv5NOfJHtNpWWH0COP86EPI/b8romfeBUsL9GvXxuecwS8quWwNPqbSJw2G7QgBREb3NcJxvj5nVCf6kFOvTe3Fmd3WyC/SLK3bv5234CV4pUSH21hUEkGV9XqNAD/DIodpP87+Tht0nJ9RBfNTTXYHsILSvda7KprntGzpRtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUJD61fyPMDa+kUe3ZK1L9yg16WBN4Sc3fmlowjJ3fo=;
 b=M6btDgbSGvVN5lFc1rCAzxk8uCIc1UhaMYRgI49gkWvM1SAklsRphYI/YydNrB2UwksettiilwW5uSI3wa3zY3tm58UyqRsD8GrtKrKIMEHKGNgsLwuwiNlKpmKI93LwiQ9oQnjx74NaoEPtk1nWsImpWEjawXKkayeLhkSd+7k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN7PR06MB3985.namprd06.prod.outlook.com (2603:10b6:406:8f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 07:09:05 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48%5]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 07:09:05 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Kurt Lee <kurt.lee@cypress.com>
Subject: [PATCH] brcmfmac: Support DPP feature
Date:   Mon,  5 Oct 2020 02:08:57 -0500
Message-Id: <20201005070857.83974-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [157.95.12.33]
X-ClientProxiedBy: BL0PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:208:51::25) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by BL0PR02CA0084.namprd02.prod.outlook.com (2603:10b6:208:51::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Mon, 5 Oct 2020 07:09:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2cfc2763-5766-4781-b841-08d868fd8b27
X-MS-TrafficTypeDiagnostic: BN7PR06MB3985:
X-LD-Processed: 011addfc-2c09-450d-8938-e0bbc2dd2376,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR06MB3985DF2289FF42E756117857FB0C0@BN7PR06MB3985.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tl/xneboQAS1tycGmtkCnv3WrYnRE6FqvVPM7js7Z6v0KLpJV+GNCUV8wIpLT7SL3R286h7+CCcSi5HenAhzrX1d8QUAZFIpoSQ6y440yKxGP29h8+pICVLSqxfjhSR2ovaHHaEsbC7M6K/q8NRQlPK6vyEMnWPgAz2aXlg1ekf0KjEOWmsoSomDvJW9E6CskVBy9nocQQihMQbyGYRtrISr7Q/fZiZFYBGaRfYcORtaEv+gN9lal3zPMw0tjNm7u/TVm+izZpzwHYsl5yi7HNX+Ad5Bh57sqIhuE+VKjKVe3+gafZVmzv2nWw6sEYt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(2616005)(26005)(186003)(956004)(4326008)(16526019)(5660300002)(52116002)(7696005)(66476007)(66556008)(66946007)(8676002)(316002)(54906003)(107886003)(478600001)(44832011)(36756003)(8936002)(6486002)(1076003)(83380400001)(30864003)(6666004)(86362001)(6916009)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /boW/duS1b8Yu9kT7b6au44FRBBD3l1Qto1AOSg0PfWyrGsZD6jQYSSu+EuPHpaJK+5NitZayqakRWauU4q+Kysay+Ncerq3Z/PpvemVXKBSNKRZpXifZOfEneeR3bEeE4BoaEOl7T4nccieAu8/dUz5/9+89HHjszfFFgQlIhEZaZ+qAdrw7LiU+zHeUvod/Os5a81BWYtLWJIeFPUEhJlzI7M8ExW34wT/Gegty4R+SnemzRJvA+YjJ58t8Ed/3+wRMs2V0NQpuAQi2olvDvWx8Yoin25r5Nx2CY+6OouwguxnpWlxQTmREJWzav+1V13xLyoPE8DYh1qDkoySBcgBAy6cU9/k0T3+q+Ey4r6nAgjgpBKXJVCWEAfKpnSRf04TsjdaiSbEDb7u+RhhBEBdI0HU8WibqDgx60YEplJ+7EOuuyZ79BdTTHWwfV17U29U2s/BsEn2PVIAI+KAGc2d1J1IaXEwTrSUdmzsSxPzuIfXNm3pZNgG5kknaLnnr9VN/Adl+SUUndDgiRYe9PYW+tdcHwa212jZvp5cziOTKOGadRQ/XM/9M15E8j4mi4KHyvA7YsKAreI+Ar6jrhDrQYaS14JXwXQEqvVtuzDsoTYplQKKHdoXZnJl82J5xEmETqi7wapMWnUp1IrQOw==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfc2763-5766-4781-b841-08d868fd8b27
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 07:09:05.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDxXjdUr3UlRZw1Au6CJyRp8KuZ7s6eZlwZsEf66YOGletQUiNNIa890o2/oZpJjKurKReAAYXefONvQ+fY60w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB3985
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kurt Lee <kurt.lee@cypress.com>

Let driver parse DPP frames from upper layer and do corresponding
configuration to firmware.

Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 153 ++++++++++--------
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  77 +++++++--
 .../broadcom/brcm80211/brcmfmac/p2p.h         |   4 +-
 .../broadcom/brcm80211/include/brcmu_wifi.h   |   5 +
 4 files changed, 159 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a2dbbb977d0c..e8b6cdf328eb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -63,6 +63,9 @@
 #define RSN_CAP_MFPC_MASK		BIT(7)
 #define RSN_PMKID_COUNT_LEN		2
 
+#define DPP_AKM_SUITE_TYPE		2
+#define WLAN_AKM_SUITE_DPP		SUITE(WLAN_OUI_WFA, DPP_AKM_SUITE_TYPE)
+
 #define VNDR_IE_CMD_LEN			4	/* length of the set command
 						 * string :"add", "del" (+ NUL)
 						 */
@@ -1815,6 +1818,9 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 			val = WPA2_AUTH_PSK | WPA2_AUTH_FT;
 			profile->is_ft = true;
 			break;
+		case WLAN_AKM_SUITE_DPP:
+			val = WFA_AUTH_DPP;
+			break;
 		default:
 			bphy_err(drvr, "invalid cipher group (%d)\n",
 				 sme->crypto.cipher_group);
@@ -2113,43 +2119,50 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
 		goto done;
 	}
 
-	if (sme->crypto.psk &&
-	    profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
-		if (WARN_ON(profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE)) {
-			err = -EINVAL;
-			goto done;
+	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_FWSUP)) {
+		if (sme->crypto.psk) {
+			if (profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
+				if (WARN_ON(profile->use_fwsup !=
+					BRCMF_PROFILE_FWSUP_NONE)) {
+					err = -EINVAL;
+					goto done;
+				}
+				brcmf_dbg(INFO, "using PSK offload\n");
+				profile->use_fwsup = BRCMF_PROFILE_FWSUP_PSK;
+			}
+		} else {
+			profile->use_fwsup = BRCMF_PROFILE_FWSUP_NONE;
 		}
-		brcmf_dbg(INFO, "using PSK offload\n");
-		profile->use_fwsup = BRCMF_PROFILE_FWSUP_PSK;
-	}
 
-	if (profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE) {
-		/* enable firmware supplicant for this interface */
-		err = brcmf_fil_iovar_int_set(ifp, "sup_wpa", 1);
-		if (err < 0) {
-			bphy_err(drvr, "failed to enable fw supplicant\n");
-			goto done;
+		if (profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE) {
+			/* enable firmware supplicant for this interface */
+			err = brcmf_fil_iovar_int_set(ifp, "sup_wpa", 1);
+			if (err < 0) {
+				bphy_err(drvr, "failed to enable fw supplicant\n");
+				goto done;
+			}
+		} else {
+			err = brcmf_fil_iovar_int_set(ifp, "sup_wpa", 0);
 		}
-	}
 
-	if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK)
-		err = brcmf_set_pmk(ifp, sme->crypto.psk,
-				    BRCMF_WSEC_MAX_PSK_LEN);
-	else if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE) {
-		/* clean up user-space RSNE */
-		if (brcmf_fil_iovar_data_set(ifp, "wpaie", NULL, 0)) {
-			bphy_err(drvr, "failed to clean up user-space RSNE\n");
-			goto done;
-		}
-		err = brcmf_set_sae_password(ifp, sme->crypto.sae_pwd,
-					     sme->crypto.sae_pwd_len);
-		if (!err && sme->crypto.psk)
+		if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK)
 			err = brcmf_set_pmk(ifp, sme->crypto.psk,
 					    BRCMF_WSEC_MAX_PSK_LEN);
+		else if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE) {
+			/* clean up user-space RSNE */
+			if (brcmf_fil_iovar_data_set(ifp, "wpaie", NULL, 0)) {
+				bphy_err(drvr, "failed to clean up user-space RSNE\n");
+				goto done;
+			}
+			err = brcmf_set_sae_password(ifp, sme->crypto.sae_pwd,
+						     sme->crypto.sae_pwd_len);
+			if (!err && sme->crypto.psk)
+				err = brcmf_set_pmk(ifp, sme->crypto.psk,
+						    BRCMF_WSEC_MAX_PSK_LEN);
+		}
+		if (err)
+			goto done;
 	}
-	if (err)
-		goto done;
-
 	/* Join with specific BSSID and cached SSID
 	 * If SSID is zero join based on BSSID only
 	 */
@@ -4101,6 +4114,12 @@ static bool brcmf_valid_wpa_oui(u8 *oui, bool is_rsn_ie)
 	return (memcmp(oui, WPA_OUI, TLV_OUI_LEN) == 0);
 }
 
+static bool brcmf_valid_dpp_suite(u8 *oui)
+{
+	return (memcmp(oui, WFA_OUI, TLV_OUI_LEN) == 0 &&
+		*(oui + TLV_OUI_LEN) == DPP_AKM_SUITE_TYPE);
+}
+
 static s32
 brcmf_configure_wpaie(struct brcmf_if *ifp,
 		      const struct brcmf_vs_tlv *wpa_ie,
@@ -4214,43 +4233,47 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
 		goto exit;
 	}
 	for (i = 0; i < count; i++) {
-		if (!brcmf_valid_wpa_oui(&data[offset], is_rsn_ie)) {
+		if (brcmf_valid_dpp_suite(&data[offset])) {
+			wpa_auth |= WFA_AUTH_DPP;
+			offset += TLV_OUI_LEN;
+		} else if (brcmf_valid_wpa_oui(&data[offset], is_rsn_ie)) {
+			offset += TLV_OUI_LEN;
+			switch (data[offset]) {
+			case RSN_AKM_NONE:
+				brcmf_dbg(TRACE, "RSN_AKM_NONE\n");
+				wpa_auth |= WPA_AUTH_NONE;
+				break;
+			case RSN_AKM_UNSPECIFIED:
+				brcmf_dbg(TRACE, "RSN_AKM_UNSPECIFIED\n");
+				is_rsn_ie ?
+					(wpa_auth |= WPA2_AUTH_UNSPECIFIED) :
+					(wpa_auth |= WPA_AUTH_UNSPECIFIED);
+				break;
+			case RSN_AKM_PSK:
+				brcmf_dbg(TRACE, "RSN_AKM_PSK\n");
+				is_rsn_ie ? (wpa_auth |= WPA2_AUTH_PSK) :
+					    (wpa_auth |= WPA_AUTH_PSK);
+				break;
+			case RSN_AKM_SHA256_PSK:
+				brcmf_dbg(TRACE, "RSN_AKM_MFP_PSK\n");
+				wpa_auth |= WPA2_AUTH_PSK_SHA256;
+				break;
+			case RSN_AKM_SHA256_1X:
+				brcmf_dbg(TRACE, "RSN_AKM_MFP_1X\n");
+				wpa_auth |= WPA2_AUTH_1X_SHA256;
+				break;
+			case RSN_AKM_SAE:
+				brcmf_dbg(TRACE, "RSN_AKM_SAE\n");
+				wpa_auth |= WPA3_AUTH_SAE_PSK;
+				break;
+			default:
+				bphy_err(drvr, "Invalid key mgmt info\n");
+			}
+		} else {
 			err = -EINVAL;
 			bphy_err(drvr, "ivalid OUI\n");
 			goto exit;
 		}
-		offset += TLV_OUI_LEN;
-		switch (data[offset]) {
-		case RSN_AKM_NONE:
-			brcmf_dbg(TRACE, "RSN_AKM_NONE\n");
-			wpa_auth |= WPA_AUTH_NONE;
-			break;
-		case RSN_AKM_UNSPECIFIED:
-			brcmf_dbg(TRACE, "RSN_AKM_UNSPECIFIED\n");
-			is_rsn_ie ? (wpa_auth |= WPA2_AUTH_UNSPECIFIED) :
-				    (wpa_auth |= WPA_AUTH_UNSPECIFIED);
-			break;
-		case RSN_AKM_PSK:
-			brcmf_dbg(TRACE, "RSN_AKM_PSK\n");
-			is_rsn_ie ? (wpa_auth |= WPA2_AUTH_PSK) :
-				    (wpa_auth |= WPA_AUTH_PSK);
-			break;
-		case RSN_AKM_SHA256_PSK:
-			brcmf_dbg(TRACE, "RSN_AKM_MFP_PSK\n");
-			wpa_auth |= WPA2_AUTH_PSK_SHA256;
-			break;
-		case RSN_AKM_SHA256_1X:
-			brcmf_dbg(TRACE, "RSN_AKM_MFP_1X\n");
-			wpa_auth |= WPA2_AUTH_1X_SHA256;
-			break;
-		case RSN_AKM_SAE:
-			brcmf_dbg(TRACE, "RSN_AKM_SAE\n");
-			wpa_auth |= WPA3_AUTH_SAE_PSK;
-			break;
-		default:
-			bphy_err(drvr, "Invalid key mgmt info\n");
-		}
-		offset++;
 	}
 
 	mfp = BRCMF_MFP_NONE;
@@ -4269,10 +4292,12 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
 				 */
 				if (!(wpa_auth & (WPA2_AUTH_PSK_SHA256 |
 						  WPA2_AUTH_1X_SHA256 |
+						  WFA_AUTH_DPP |
 						  WPA3_AUTH_SAE_PSK))) {
 					err = -EINVAL;
 					goto exit;
 				}
+
 				/* Firmware has requirement that WPA2_AUTH_PSK/
 				 * WPA2_AUTH_UNSPECIFIED be set, if SHA256 OUI
 				 * is to be included in the rsn ie.
@@ -5181,7 +5206,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 			  *cookie, le16_to_cpu(action_frame->len), freq);
 
 		ack = brcmf_p2p_send_action_frame(cfg, cfg_to_ndev(cfg),
-						  af_params);
+						  af_params, vif);
 
 		cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
 					GFP_KERNEL);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index ec6fc7a150a6..12b938a29a7d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -231,7 +231,35 @@ static bool brcmf_p2p_is_pub_action(void *frame, u32 frame_len)
 	if (pact_frm->category == P2P_PUB_AF_CATEGORY &&
 	    pact_frm->action == P2P_PUB_AF_ACTION &&
 	    pact_frm->oui_type == P2P_VER &&
-	    memcmp(pact_frm->oui, P2P_OUI, P2P_OUI_LEN) == 0)
+	    memcmp(pact_frm->oui, WFA_OUI, P2P_OUI_LEN) == 0)
+		return true;
+
+	return false;
+}
+
+/**
+ * brcmf_p2p_is_dpp_pub_action() - true if dpp public type frame.
+ *
+ * @frame: action frame data.
+ * @frame_len: length of action frame data.
+ *
+ * Determine if action frame is dpp public action type
+ */
+static bool brcmf_p2p_is_dpp_pub_action(void *frame, u32 frame_len)
+{
+	struct brcmf_p2p_pub_act_frame *pact_frm;
+
+	if (!frame)
+		return false;
+
+	pact_frm = (struct brcmf_p2p_pub_act_frame *)frame;
+	if (frame_len < sizeof(struct brcmf_p2p_pub_act_frame) - 1)
+		return false;
+
+	if (pact_frm->category == WLAN_CATEGORY_PUBLIC &&
+	    pact_frm->action == WLAN_PUB_ACTION_VENDOR_SPECIFIC &&
+	    pact_frm->oui_type == DPP_VER &&
+	    memcmp(pact_frm->oui, WFA_OUI, TLV_OUI_LEN) == 0)
 		return true;
 
 	return false;
@@ -991,6 +1019,8 @@ int brcmf_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
 	if (err)
 		goto exit;
 
+	p2p->remin_on_channel_wdev = wdev;
+
 	memcpy(&p2p->remain_on_channel, channel, sizeof(*channel));
 	*cookie = p2p->remain_on_channel_cookie;
 	cfg80211_ready_on_channel(wdev, *cookie, channel, duration, GFP_KERNEL);
@@ -1014,6 +1044,7 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
 {
 	struct brcmf_cfg80211_info *cfg = ifp->drvr->config;
 	struct brcmf_p2p_info *p2p = &cfg->p2p;
+	struct wireless_dev *wdev = p2p->remin_on_channel_wdev;
 
 	brcmf_dbg(TRACE, "Enter\n");
 	if (test_and_clear_bit(BRCMF_P2P_STATUS_DISCOVER_LISTEN,
@@ -1026,10 +1057,16 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
 			complete(&p2p->wait_next_af);
 		}
 
-		cfg80211_remain_on_channel_expired(&ifp->vif->wdev,
+		wdev = p2p->remin_on_channel_wdev ?
+			p2p->remin_on_channel_wdev :
+			&ifp->vif->wdev;
+
+		cfg80211_remain_on_channel_expired(wdev,
 						   p2p->remain_on_channel_cookie,
 						   &p2p->remain_on_channel,
 						   GFP_KERNEL);
+		p2p->remin_on_channel_wdev = NULL;
+
 	}
 	return 0;
 }
@@ -1281,6 +1318,10 @@ static s32 brcmf_p2p_abort_action_frame(struct brcmf_cfg80211_info *cfg)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+
+	if (!vif)
+		vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+
 	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe_abort", &int_val,
 					sizeof(s32));
 	if (err)
@@ -1531,6 +1572,7 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
  *
  * @p2p: p2p info struct for vif.
  * @af_params: action frame data/info.
+ * @vif: vif to send
  *
  * Send an action frame immediately without doing channel synchronization.
  *
@@ -1539,12 +1581,17 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
  * frame is transmitted.
  */
 static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
-				     struct brcmf_fil_af_params_le *af_params)
+				     struct brcmf_fil_af_params_le *af_params,
+				     struct brcmf_cfg80211_vif *vif
+				     )
 {
 	struct brcmf_pub *drvr = p2p->cfg->pub;
-	struct brcmf_cfg80211_vif *vif;
-	struct brcmf_p2p_action_frame *p2p_af;
 	s32 err = 0;
+	struct brcmf_fil_action_frame_le *action_frame;
+	u16 action_frame_len;
+
+	action_frame = &af_params->action_frame;
+	action_frame_len = le16_to_cpu(action_frame->len);
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -1552,13 +1599,6 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
 	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
 	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
 
-	/* check if it is a p2p_presence response */
-	p2p_af = (struct brcmf_p2p_action_frame *)af_params->action_frame.data;
-	if (p2p_af->subtype == P2P_AF_PRESENCE_RSP)
-		vif = p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif;
-	else
-		vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
-
 	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
 					sizeof(*af_params));
 	if (err) {
@@ -1714,10 +1754,13 @@ static bool brcmf_p2p_check_dwell_overflow(u32 requested_dwell,
  * @cfg: driver private data for cfg80211 interface.
  * @ndev: net device to transmit on.
  * @af_params: configuration data for action frame.
+ * @vif: virtual interface to send
  */
 bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 				 struct net_device *ndev,
-				 struct brcmf_fil_af_params_le *af_params)
+				 struct brcmf_fil_af_params_le *af_params,
+				 struct brcmf_cfg80211_vif *vif
+				 )
 {
 	struct brcmf_p2p_info *p2p = &cfg->p2p;
 	struct brcmf_if *ifp = netdev_priv(ndev);
@@ -1789,7 +1832,9 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 			goto exit;
 		}
 	} else if (brcmf_p2p_is_p2p_action(action_frame->data,
-					   action_frame_len)) {
+					   action_frame_len) ||
+		   brcmf_p2p_is_dpp_pub_action(action_frame->data,
+					       action_frame_len)) {
 		/* do not configure anything. it will be */
 		/* sent with a default configuration     */
 	} else {
@@ -1826,6 +1871,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 	/* validate channel and p2p ies */
 	if (config_af_params.search_channel &&
 	    IS_P2P_SOCIAL_CHANNEL(le32_to_cpu(af_params->channel)) &&
+	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif &&
 	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->saved_ie.probe_req_ie_len) {
 		afx_hdl = &p2p->afx_hdl;
 		afx_hdl->peer_listen_chan = le32_to_cpu(af_params->channel);
@@ -1857,7 +1903,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 		if (af_params->channel)
 			msleep(P2P_AF_RETRY_DELAY_TIME);
 
-		ack = !brcmf_p2p_tx_action_frame(p2p, af_params);
+		ack = !brcmf_p2p_tx_action_frame(p2p, af_params, vif);
 		tx_retry++;
 		dwell_overflow = brcmf_p2p_check_dwell_overflow(requested_dwell,
 								dwell_jiffies);
@@ -2504,6 +2550,7 @@ s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced)
 
 	pri_ifp = brcmf_get_ifp(cfg->pub, 0);
 	p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif = pri_ifp->vif;
+	init_completion(&p2p->send_af_done);
 
 	if (p2pdev_forced) {
 		err_ptr = brcmf_p2p_create_p2pdev(p2p, NULL, NULL);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
index d2ecee565bf2..bbc455238707 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
@@ -138,6 +138,7 @@ struct brcmf_p2p_info {
 	bool block_gon_req_tx;
 	bool p2pdev_dynamically;
 	bool wait_for_offchan_complete;
+	struct wireless_dev *remin_on_channel_wdev;
 };
 
 s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced);
@@ -170,7 +171,8 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
 					void *data);
 bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 				 struct net_device *ndev,
-				 struct brcmf_fil_af_params_le *af_params);
+				 struct brcmf_fil_af_params_le *af_params,
+				 struct brcmf_cfg80211_vif *vif);
 bool brcmf_p2p_scan_finding_common_channel(struct brcmf_cfg80211_info *cfg,
 					   struct brcmf_bss_info_le *bi);
 s32 brcmf_p2p_notify_rx_mgmt_p2p_probereq(struct brcmf_if *ifp,
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
index 7552bdb91991..3a9cad3730b8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
@@ -233,6 +233,11 @@ static inline bool ac_bitmap_tst(u8 bitmap, int prec)
 
 #define WPA3_AUTH_SAE_PSK	0x40000	/* SAE with 4-way handshake */
 
+#define WFA_AUTH_DPP		0x200000 /* WFA DPP AUTH */
+
+#define WFA_OUI			"\x50\x6F\x9A"	/* WFA OUI */
+#define DPP_VER			0x1A	/* WFA DPP v1.0 */
+
 #define DOT11_DEFAULT_RTS_LEN		2347
 #define DOT11_DEFAULT_FRAG_LEN		2346
 
-- 
2.25.0

