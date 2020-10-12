Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A7D28B084
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 10:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgJLIpd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 04:45:33 -0400
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:16993
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgJLIpc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 04:45:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3xREwDq0/1CgIlBJZLU+ZD+Pb6IQQTCrsMgCqsv5PNsPpdRqbpZftNMs9QLEHq4ck8Lu08usvjH55UyibBrh4K6zO9bnb8qYSZOX3bK+MvFi6lZ1377PG79YeUZFrYHmAndR6JB9wfWzxir0c1fmB600cXbR3hPmDSpkNrtry7tHVfNiAA7CNVDwD05vC/LECnSup3ZtVaHkyoOIq4IiFMjOqDCCHUhp7x+Gkwyi/mnWyEuhj3cvFGIpNaTEGiL8exBORqUJ1uWMXe3wOo0iKiV9lmDA8nb3xU493KYKR2BGAnZKP4xSElYnjuhZ5/DkjsuLAaJHKesd4njXYDdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VbxYEDND2ohOiUybdjGblO19vahBB0ohtDUpE7+7RU=;
 b=QAwBZ4HzWRQXocmNgb3pedK52ChxXMmCXst42nWp+Jow+nD3gihRZk569f3FJ/vOAqaVo03Xcea3nJ+zGnAYn63BRivhsoNfvlE0tAli0+c6sa9vUmz9d3X6IM3xkqiwsVwPXq/OEM/V7J97luyNvnPnvHRT17T2QjTQ8y3us1MxJaWY8gbB0SEgKAz37MENZVl9ajPcn6ZHcnrG+jQWhmngRidinzUzB6wiov8RJUmnXSPu7Pt9meipZNvoeQ72NIIrE8plp9+yX9dGaC9hY6EOu0+RI2++BmM1yTB/NTmd+pwRoulpxreOruHaSHBGYw6rUs+5EiNxzCXxSQf/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VbxYEDND2ohOiUybdjGblO19vahBB0ohtDUpE7+7RU=;
 b=TOJMcIX3CawTSTf6Egg/3npK0BeQ3bmSuZUVrJcQNeHc4Kl3PnH0la26NRHT3H0eCZhsdT77H8eiu2wPZS3C+UPFa473f+1yH1TM/CXi98paCxek4aAT7fG5LdeD0oE3nOgrdXTafcWWSpG4S6sMLuQh6fnHtm3uUA0Zq/IVpIc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN8PR06MB5380.namprd06.prod.outlook.com (2603:10b6:408:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 08:45:19 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48%5]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 08:45:19 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kurt Lee <kurt.lee@cypress.com>
Subject: [PATCH v2 2/2] brcmfmac: Support DPP feature
Date:   Mon, 12 Oct 2020 03:43:47 -0500
Message-Id: <20201012084347.121557-3-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201012084347.121557-1-wright.feng@cypress.com>
References: <20201012084347.121557-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [157.95.12.33]
X-ClientProxiedBy: MN2PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:208:d4::46) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR04CA0033.namprd04.prod.outlook.com (2603:10b6:208:d4::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 08:45:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b98707f5-70d6-4c0c-b6c4-08d86e8b25aa
X-MS-TrafficTypeDiagnostic: BN8PR06MB5380:
X-LD-Processed: 011addfc-2c09-450d-8938-e0bbc2dd2376,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR06MB538003A1D1AC4071D617ED69FB070@BN8PR06MB5380.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+Q7FUTM/+O8tN4yAuOlR3QDWOQ0tG+oHxXlt8NkthqBuH1ijoxDDR6OafjZQMf5nghnfRfPkZe5ubPkbBuL6lKlZIVjhGB0OJZ+KDq9WNE7cHIRCa52/IWVQPjqHqtoSG8lXpDmdvVM566N65geuc3pLlHgYW8NT+P4Y8WxiAfrBGHxR0+RjNXYpxFixGx7RdZA39C4TtbEIahnaJRBxkStJyZOp96oBAjF8lcX48FrRQd8g7StUbAwaWBO4ED2seFn0VVCCbUDAIXnAwnNYLatyxbWc6FLN/tFGAmvN9OGeKCpNJQFdpzu/BOxUoh7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(2616005)(83380400001)(956004)(4326008)(86362001)(316002)(16526019)(107886003)(52116002)(7696005)(5660300002)(26005)(186003)(8676002)(44832011)(8936002)(6666004)(30864003)(36756003)(66946007)(66556008)(66476007)(6486002)(2906002)(1076003)(478600001)(110136005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: j/vZAg1GwkuW1N+0agtbez0WfwiLCFMb1Nk7G4TCr8yoWR4Lim2X1ezjHxDskT51Ubn7bP6Uqu5SXPgd1KOa6LqDm649vQe79/azVh8PzqwAt9KDBFzg018QL3OCOWiQm91qXosofpXk5edOWPA17JEwNvsA+87kxLJiE9mxPWcQEKaLrZZUvaLjl8w/48gz2DBBmXCj2AKNQLbZ8wb8OgL1LwfTDncy5yHGZkmi5YCLWYk87qQ0rhLImntsLcwKzG23XFxEK3viktHqkcYSPb60/V4i6P9eNGENLI6OmOe7hSN94jFNHWgHfLgzxqmUx5Ggyn0Ya6nM+BrFHFTIVVIsL353PfSPT27Op/WrOkDzuFLtapckRUIcYCYkqDPXeYZLTec5SYES3Kz3F0hUzNp2gOJx3GyEwQ+MTj8qdVE3xPuT7HsvYT5gHdficqiZa2zlmjI9M3F/MAFOYXjHiqRvAjKVg7fLFFUJRdHQ15W0KeGOGBWGUZseO+YoFSi4N7sGX8O//TAufUGgPtst7x8FSJbJnFkd541aRge62w7MP9dLlSNl5Db9FQzhiFTady4HVvyd6NFt/J/dh6X6Y85akYvNLOFm8Cp2kmd1PS9DxCdZCXD7Ooe91PbGC4/S+y76oOyzjEQo34/2otOJLA==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98707f5-70d6-4c0c-b6c4-08d86e8b25aa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 08:45:19.3004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQEnnhDUiPuVCVHZ6TGO0cV8Zb5sLWRWwwnFXLNkGBtiQzbNnryOHsoxeagMnAzSUo46nono6A8XPzugCncKuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5380
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kurt Lee <kurt.lee@cypress.com>

Let driver parse DPP(Device Provisioning Protocol) frames from upper
layer and do corresponding configuration to firmware.

Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 150 ++++++++++--------
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  81 ++++++++--
 .../broadcom/brcm80211/brcmfmac/p2p.h         |   4 +-
 .../broadcom/brcm80211/include/brcmu_wifi.h   |   2 +
 4 files changed, 157 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a2dbbb977d0c..dbaa6f4a3029 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1815,6 +1815,9 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 			val = WPA2_AUTH_PSK | WPA2_AUTH_FT;
 			profile->is_ft = true;
 			break;
+		case WLAN_AKM_SUITE_WFA_DPP:
+			val = WFA_AUTH_DPP;
+			break;
 		default:
 			bphy_err(drvr, "invalid cipher group (%d)\n",
 				 sme->crypto.cipher_group);
@@ -2113,43 +2116,50 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
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
@@ -4101,6 +4111,13 @@ static bool brcmf_valid_wpa_oui(u8 *oui, bool is_rsn_ie)
 	return (memcmp(oui, WPA_OUI, TLV_OUI_LEN) == 0);
 }
 
+static bool brcmf_valid_dpp_suite(u8 *oui)
+{
+	u32 akm_suite = (*(oui + 3)) | (*(oui + 2) << 8) | (*(oui + 1) << 16) | (*(oui) << 24);
+
+	return (akm_suite == WLAN_AKM_SUITE_WFA_DPP);
+}
+
 static s32
 brcmf_configure_wpaie(struct brcmf_if *ifp,
 		      const struct brcmf_vs_tlv *wpa_ie,
@@ -4214,43 +4231,47 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
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
@@ -4269,6 +4290,7 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
 				 */
 				if (!(wpa_auth & (WPA2_AUTH_PSK_SHA256 |
 						  WPA2_AUTH_1X_SHA256 |
+						  WFA_AUTH_DPP |
 						  WPA3_AUTH_SAE_PSK))) {
 					err = -EINVAL;
 					goto exit;
@@ -5181,7 +5203,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 			  *cookie, le16_to_cpu(action_frame->len), freq);
 
 		ack = brcmf_p2p_send_action_frame(cfg, cfg_to_ndev(cfg),
-						  af_params);
+						  af_params, vif);
 
 		cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
 					GFP_KERNEL);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index ec6fc7a150a6..b879f4d6a5c3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -220,6 +220,8 @@ struct brcmf_config_af_params {
 static bool brcmf_p2p_is_pub_action(void *frame, u32 frame_len)
 {
 	struct brcmf_p2p_pub_act_frame *pact_frm;
+	u8 wfa_oui[] = { (WLAN_OUI_WFA >> 16) & 0xff,
+			(WLAN_OUI_WFA >> 8) & 0xff, (WLAN_OUI_WFA) & 0xff };
 
 	if (frame == NULL)
 		return false;
@@ -231,7 +233,37 @@ static bool brcmf_p2p_is_pub_action(void *frame, u32 frame_len)
 	if (pact_frm->category == P2P_PUB_AF_CATEGORY &&
 	    pact_frm->action == P2P_PUB_AF_ACTION &&
 	    pact_frm->oui_type == P2P_VER &&
-	    memcmp(pact_frm->oui, P2P_OUI, P2P_OUI_LEN) == 0)
+	    memcmp(pact_frm->oui, wfa_oui, P2P_OUI_LEN) == 0)
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
+	u8 wfa_oui[] = { (WLAN_OUI_WFA >> 16) & 0xff,
+			(WLAN_OUI_WFA >> 8) & 0xff, (WLAN_OUI_WFA) & 0xff };
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
+	    pact_frm->oui_type == WLAN_OUI_TYPE_WFA_DPP &&
+	    memcmp(pact_frm->oui, wfa_oui, TLV_OUI_LEN) == 0)
 		return true;
 
 	return false;
@@ -991,6 +1023,8 @@ int brcmf_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
 	if (err)
 		goto exit;
 
+	p2p->remin_on_channel_wdev = wdev;
+
 	memcpy(&p2p->remain_on_channel, channel, sizeof(*channel));
 	*cookie = p2p->remain_on_channel_cookie;
 	cfg80211_ready_on_channel(wdev, *cookie, channel, duration, GFP_KERNEL);
@@ -1014,6 +1048,7 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
 {
 	struct brcmf_cfg80211_info *cfg = ifp->drvr->config;
 	struct brcmf_p2p_info *p2p = &cfg->p2p;
+	struct wireless_dev *wdev = p2p->remin_on_channel_wdev;
 
 	brcmf_dbg(TRACE, "Enter\n");
 	if (test_and_clear_bit(BRCMF_P2P_STATUS_DISCOVER_LISTEN,
@@ -1026,10 +1061,16 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
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
@@ -1281,6 +1322,10 @@ static s32 brcmf_p2p_abort_action_frame(struct brcmf_cfg80211_info *cfg)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+
+	if (!vif)
+		vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+
 	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe_abort", &int_val,
 					sizeof(s32));
 	if (err)
@@ -1531,6 +1576,7 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
  *
  * @p2p: p2p info struct for vif.
  * @af_params: action frame data/info.
+ * @vif: vif to send
  *
  * Send an action frame immediately without doing channel synchronization.
  *
@@ -1539,12 +1585,17 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
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
 
@@ -1552,13 +1603,6 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
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
@@ -1714,10 +1758,13 @@ static bool brcmf_p2p_check_dwell_overflow(u32 requested_dwell,
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
@@ -1789,7 +1836,9 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
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
@@ -1826,6 +1875,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 	/* validate channel and p2p ies */
 	if (config_af_params.search_channel &&
 	    IS_P2P_SOCIAL_CHANNEL(le32_to_cpu(af_params->channel)) &&
+	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif &&
 	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->saved_ie.probe_req_ie_len) {
 		afx_hdl = &p2p->afx_hdl;
 		afx_hdl->peer_listen_chan = le32_to_cpu(af_params->channel);
@@ -1857,7 +1907,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 		if (af_params->channel)
 			msleep(P2P_AF_RETRY_DELAY_TIME);
 
-		ack = !brcmf_p2p_tx_action_frame(p2p, af_params);
+		ack = !brcmf_p2p_tx_action_frame(p2p, af_params, vif);
 		tx_retry++;
 		dwell_overflow = brcmf_p2p_check_dwell_overflow(requested_dwell,
 								dwell_jiffies);
@@ -2504,6 +2554,7 @@ s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced)
 
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
index 7552bdb91991..c465208c4331 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
@@ -233,6 +233,8 @@ static inline bool ac_bitmap_tst(u8 bitmap, int prec)
 
 #define WPA3_AUTH_SAE_PSK	0x40000	/* SAE with 4-way handshake */
 
+#define WFA_AUTH_DPP		0x200000 /* WFA DPP AUTH */
+
 #define DOT11_DEFAULT_RTS_LEN		2347
 #define DOT11_DEFAULT_FRAG_LEN		2346
 
-- 
2.25.0

