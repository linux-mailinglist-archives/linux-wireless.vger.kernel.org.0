Return-Path: <linux-wireless+bounces-37319-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ygDBCp2mH2rAoQAAu9opvQ
	(envelope-from <linux-wireless+bounces-37319-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 05:59:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B2634100
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 05:59:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infineon.com header.s=IFXMAIL header.b=gqKX8KiJ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37319-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37319-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=infineon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DA65300FFA6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 03:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507F63644C7;
	Wed,  3 Jun 2026 03:57:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143826ED3E
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 03:57:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780459066; cv=none; b=At3ttkxSBVX8q9pRmHdCxgplVI81SbmTqNoEvqDiCTBEp0YTXaG0oO+Y70cKD5YthKZRpLS2zEZL2MewDxYHW6rtDYp1Dph6y1sA3Z4HK/eVykBgvky86Pj04WFBoxWquaaKYbQk6hdMRKWN4Xa+OxUG+tIoT4nZvl+gyfJeb1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780459066; c=relaxed/simple;
	bh=puG/Ybsl2/UaSy0RAJYDbmOaZh+vWV5W2ATCst66ab8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p4ee6cV3YMUMgvVi4fqZfSLqLk/m7Nqe0bKRl2hl6p9AzwwkI4DnwrJYYiK/jrpwD+9G5N7ZmGtxvkt6tcicGwJfyG2Xyw0odjfSdoA5bQ7EZlNQNlcNeOnGlBW0mJpUy/kE+t8u9stGLgnFFibSM2UAnMZBWVOtD0aYOkAwFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=gqKX8KiJ; arc=none smtp.client-ip=217.10.52.18
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1780459064; x=1811995064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=puG/Ybsl2/UaSy0RAJYDbmOaZh+vWV5W2ATCst66ab8=;
  b=gqKX8KiJnWcaai9ren+4+OUk080BogwIv0TnGTp3WAufc+IAgaksbWMc
   r2ZhtzAYg/qs/BN2fh/IveojXxNe8tg609TivP30iR3akNTOBkJmSgXDP
   DynmB2I7wloEpBaA+XTnREEO+zezG5l1hQZOQ1UP/Il/TCTc6Nmxiac8C
   w=;
X-CSE-ConnectionGUID: OZsp8ULHQMS4kba4cRM5bA==
X-CSE-MsgGUID: 7DkvqkFXTXqXLc0m8Xy3yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="160491359"
X-IronPort-AV: E=Sophos;i="6.24,184,1774306800"; 
   d="scan'208";a="160491359"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 05:57:41 +0200
Received: from MUCSE809.infineon.com (172.23.29.35) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 05:57:41 +0200
Received: from ISCN5CG5251XQT.infineon.com (10.161.6.196) by
 MUCSE809.infineon.com (172.23.29.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 05:57:38 +0200
From: Jason Huang <Jason.Huang2@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: <wlan-kernel-dev-list@infineon.com>, Johannes Berg
	<johannes@sipsolutions.net>, Kurt Lee <kurt.lee@cypress.com>, Jason Huang
	<jason.huang2@infineon.com>
Subject: [PATCH] wifi: brcmfmac: add DPP support and fix fw-supplicant/P2P interop
Date: Wed, 3 Jun 2026 11:57:22 +0800
Message-ID: <20260603035722.145894-1-Jason.Huang2@infineon.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
 MUCSE809.infineon.com (172.23.29.35)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infineon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[infineon.com:s=IFXMAIL];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37319-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Jason.Huang2@infineon.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:wlan-kernel-dev-list@infineon.com,m:johannes@sipsolutions.net,m:kurt.lee@cypress.com,m:jason.huang2@infineon.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason.Huang2@infineon.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infineon.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infineon.com:mid,infineon.com:dkim,infineon.com:from_mime,infineon.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC8B2634100

From: Kurt Lee <kurt.lee@cypress.com>

Add DPP support in brcmfmac and include follow-up fixes needed for reliable operation with mixed security setups.

Main changes:
- add DPP AKM handling in key-mgmt and RSN parsing
- map DPP to WFA_AUTH_DPP and allow it in MFP-required checks
- recognize DPP public action frames in the P2P TX path
- pass the transmitting vif explicitly for action frame TX
- track the correct ROC wdev for remain-on-channel expiry
- gate sup_wpa iovar usage by firmware FWSUP capability
- avoid stale fw supplicant state that can break DPP/EAPOL handling
- add missing NULL checks in P2P abort/search-channel paths

Together these changes enable DPP while preventing regressions when
switching between DPP and non-DPP encrypted connections.

Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
Signed-off-by: Jason Huang <jason.huang2@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 151 ++++++++++--------
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  58 ++++++-
 .../broadcom/brcm80211/brcmfmac/p2p.h         |   1 +
 .../broadcom/brcm80211/include/brcmu_wifi.h   |   5 +
 4 files changed, 148 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 0b55d445895f..482abee11987 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -65,6 +65,9 @@
 #define RSN_CAP_MFPC_MASK		BIT(7)
 #define RSN_PMKID_COUNT_LEN		2
 
+#define DPP_AKM_SUITE_TYPE		2
+#define WLAN_AKM_SUITE_DPP		SUITE(WLAN_OUI_WFA, DPP_AKM_SUITE_TYPE)
+
 #define VNDR_IE_CMD_LEN			4	/* length of the set command
 						 * string :"add", "del" (+ NUL)
 						 */
@@ -2174,6 +2177,9 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 			val = WPA2_AUTH_PSK | WPA2_AUTH_FT;
 			profile->is_ft = true;
 			break;
+		case WLAN_AKM_SUITE_DPP:
+			val = WFA_AUTH_DPP;
+			break;
 		default:
 			bphy_err(drvr, "invalid akm suite (%d)\n",
 				 sme->crypto.akm_suites[0]);
@@ -2483,43 +2489,47 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
 		goto done;
 	}
 
-	if (sme->crypto.psk &&
-	    profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
-		if (WARN_ON(profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE)) {
-			err = -EINVAL;
-			goto done;
-		}
-		brcmf_dbg(INFO, "using PSK offload\n");
-		profile->use_fwsup = BRCMF_PROFILE_FWSUP_PSK;
-	}
-
-	if (profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE) {
-		/* enable firmware supplicant for this interface */
-		err = brcmf_fil_iovar_int_set(ifp, "sup_wpa", 1);
-		if (err < 0) {
-			bphy_err(drvr, "failed to enable fw supplicant\n");
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
-	}
-
-	if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK)
-		err = brcmf_set_pmk(ifp, sme->crypto.psk,
-				    BRCMF_WSEC_MAX_PSK_LEN);
-	else if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE) {
-		/* clean up user-space RSNE */
-		err = brcmf_fil_iovar_data_set(ifp, "wpaie", NULL, 0);
-		if (err) {
-			bphy_err(drvr, "failed to clean up user-space RSNE\n");
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
-		err = brcmf_fwvid_set_sae_password(ifp, &sme->crypto);
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
+			err = brcmf_fwvid_set_sae_password(ifp, &sme->crypto);
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
@@ -4538,6 +4548,12 @@ static bool brcmf_valid_wpa_oui(u8 *oui, bool is_rsn_ie)
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
@@ -4651,42 +4667,47 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
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
 			bphy_err(drvr, "invalid OUI\n");
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
 		offset++;
 	}
 
@@ -4706,10 +4727,12 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index e1752a513c73..72869219dd6b 100644
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
@@ -1532,6 +1573,7 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
  * @ifp: interface to transmit on.
  * @p2p: p2p info struct for vif.
  * @af_params: action frame data/info.
+ * @vif: vif to send
  *
  * Send an action frame immediately without doing channel synchronization.
  *
@@ -1545,6 +1587,11 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_if *ifp,
 {
 	struct brcmf_pub *drvr = p2p->cfg->pub;
 	s32 err = 0;
+	struct brcmf_fil_action_frame_le *action_frame;
+	u16 action_frame_len;
+
+	action_frame = &af_params->action_frame;
+	action_frame_len = le16_to_cpu(action_frame->len);
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -1706,6 +1753,7 @@ static bool brcmf_p2p_check_dwell_overflow(u32 requested_dwell,
  *
  * @ifp: interface to transmit on.
  * @af_params: configuration data for action frame.
+ * @vif: virtual interface to send
  */
 bool brcmf_p2p_send_action_frame(struct brcmf_if *ifp,
 				 struct brcmf_fil_af_params_le *af_params)
@@ -1780,7 +1828,9 @@ bool brcmf_p2p_send_action_frame(struct brcmf_if *ifp,
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
@@ -1817,6 +1867,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_if *ifp,
 	/* validate channel and p2p ies */
 	if (config_af_params.search_channel &&
 	    IS_P2P_SOCIAL_CHANNEL(le32_to_cpu(af_params->channel)) &&
+	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif &&
 	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->saved_ie.probe_req_ie_len) {
 		afx_hdl = &p2p->afx_hdl;
 		afx_hdl->peer_listen_chan = le32_to_cpu(af_params->channel);
@@ -2502,6 +2553,7 @@ s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced)
 
 	pri_ifp = brcmf_get_ifp(cfg->pub, 0);
 	p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif = pri_ifp->vif;
+	init_completion(&p2p->send_af_done);
 
 	init_completion(&p2p->send_af_done);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
index d3137ebd7158..2a74e3036ce3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
@@ -138,6 +138,7 @@ struct brcmf_p2p_info {
 	bool block_gon_req_tx;
 	bool p2pdev_dynamically;
 	bool wait_for_offchan_complete;
+	struct wireless_dev *remin_on_channel_wdev;
 };
 
 s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced);
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
2.25.1


