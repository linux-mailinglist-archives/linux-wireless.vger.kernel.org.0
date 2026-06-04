Return-Path: <linux-wireless+bounces-37372-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f3qeGkn2IGrC9wAAu9opvQ
	(envelope-from <linux-wireless+bounces-37372-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 05:51:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B617363CBA8
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 05:51:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infineon.com header.s=IFXMAIL header.b=RCvE4MPg;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37372-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37372-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=infineon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FEFD303BB2D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 03:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F735C19F;
	Thu,  4 Jun 2026 03:49:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27932749DC;
	Thu,  4 Jun 2026 03:49:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780544964; cv=none; b=dGIiVqoo6HUOYXnMoVywK84iFIOf7sJQx6IT22Rvm8mnCqnVrm+nIyiXM4eK2LVNh4mggM/NcVM7cAT4hm7HiBJZJaziDGZQ2LeAR54Am851jIFX+UJ9BAAzj8B7IL9RiOX/qDZi6PknkyaKNzVJSduiCgwdx4sjS4fi8POlwP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780544964; c=relaxed/simple;
	bh=u2/FyW0hPR97OWPqZG/B/F1yVnESRw3OzRnaupDdt0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLsiPydDjH0kBTpoa3S4QDoXssQn6P+QuBgBy9KfqdL1C2RrRLjTEnC0awGHDTZ+or0RNx16dfNVbg4rEcsz3iNXLh2ELIMggT6kv6Y3wdtwfFd7cdd8KTqz/xO+uJtiMsOHROPva+rF4alIRy2k8uvLz/vtk1njqDnwlH0Tv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=RCvE4MPg; arc=none smtp.client-ip=217.10.52.105
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1780544963; x=1812080963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u2/FyW0hPR97OWPqZG/B/F1yVnESRw3OzRnaupDdt0Y=;
  b=RCvE4MPgl+ykiAnhstcTOeRENe6ZjT4fW8cjmotFQEztUBjAgoK03XDk
   h8gobVyP4/sVjnX2n2RrRNLnOoO2wRSlnktz4MBivOnSMz+O9FR+t/lN5
   S94hx/lfqz1xxMsb8ftwmUUE4mPMdD14CSOpLlu+kEsgFBqS+5WMHJOcQ
   U=;
X-CSE-ConnectionGUID: LUJqbZJmRt+SaNzGIWKrUA==
X-CSE-MsgGUID: yTjs+Rn6RjarP+aoyH236g==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="145867107"
X-IronPort-AV: E=Sophos;i="6.24,186,1774306800"; 
   d="scan'208";a="145867107"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 05:48:11 +0200
Received: from MUCSE809.infineon.com (172.23.29.35) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 05:48:09 +0200
Received: from ISCN5CG5251XQT.infineon.com (10.161.6.196) by
 MUCSE809.infineon.com (172.23.29.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 05:48:07 +0200
From: Jason Huang <Jason.Huang2@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>,
	<linux-kernel@vger.kernel.org>, Kurt Lee <kurt.lee@cypress.com>, Jason Huang
	<jason.huang2@infineon.com>
Subject: [PATCH v2] wifi: brcmfmac: add DPP support and fix fw-supplicant/P2P interop
Date: Thu, 4 Jun 2026 11:42:29 +0800
Message-ID: <20260604034227.590951-1-Jason.Huang2@infineon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260603035722.145894-1-Jason.Huang2@infineon.com>
References: <20260603035722.145894-1-Jason.Huang2@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE805.infineon.com (172.23.29.31) To
 MUCSE809.infineon.com (172.23.29.35)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infineon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[infineon.com:s=IFXMAIL];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37372-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Jason.Huang2@infineon.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:kurt.lee@cypress.com,m:jason.huang2@infineon.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason.Huang2@infineon.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infineon.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cypress.com:email,infineon.com:mid,infineon.com:dkim,infineon.com:from_mime,infineon.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B617363CBA8

From: Kurt Lee <kurt.lee@cypress.com>

Add DPP support in brcmfmac and include follow-up fixes needed for
reliable operation with mixed security setups.

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

Changes in v2:
 - Fix the kernel test robot warning by removing the unused
   action_frame_len variable.
 - Use upstream WLAN_AKM_SUITE_WFA_DPP and WLAN_OUI_* constants instead
   of adding local DPP/P2P definitions.
 - Use get_unaligned_be24() and get_unaligned_be32() for OUI and AKM
   suite parsing.
 - Gate sup_wpa handling on BRCMF_FEAT_FWSUP.
 - Avoid stale firmware supplicant state when switching between DPP and
   non-DPP encrypted connections.
 - Preserve SAE password handling while avoiding incorrect PSK offload
   selection.
 - Track remain-on-channel completion with the correct wireless_dev.
 - Add NULL checks in P2P abort/search-channel paths.

Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
Signed-off-by: Jason Huang <jason.huang2@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 157 +++++++++++-------
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  70 ++++++--
 .../broadcom/brcm80211/brcmfmac/p2p.h         |   1 +
 .../broadcom/brcm80211/include/brcmu_wifi.h   |   2 +
 4 files changed, 151 insertions(+), 79 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 0b55d445895f..3df7af710a5f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/etherdevice.h>
 #include <linux/module.h>
+#include <linux/unaligned.h>
 #include <linux/vmalloc.h>
 #include <net/cfg80211.h>
 #include <net/netlink.h>
@@ -2174,6 +2175,9 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 			val = WPA2_AUTH_PSK | WPA2_AUTH_FT;
 			profile->is_ft = true;
 			break;
+		case WLAN_AKM_SUITE_WFA_DPP:
+			val = WFA_AUTH_DPP;
+			break;
 		default:
 			bphy_err(drvr, "invalid akm suite (%d)\n",
 				 sme->crypto.akm_suites[0]);
@@ -2483,43 +2487,56 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
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
+		u32 akm = sme->crypto.n_akm_suites ? sme->crypto.akm_suites[0] : 0;
+		bool is_sae_akm = akm == WLAN_AKM_SUITE_SAE ||
+			akm == WLAN_AKM_SUITE_FT_OVER_SAE;
+
+		if (sme->crypto.psk) {
+			if (is_sae_akm &&
+			    profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
+				profile->use_fwsup = BRCMF_PROFILE_FWSUP_NONE;
+			} else if (!is_sae_akm &&
+				   profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
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
+		else if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE &&
+			 (sme->crypto.sae_pwd && brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SAE))) {
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
@@ -4538,6 +4555,11 @@ static bool brcmf_valid_wpa_oui(u8 *oui, bool is_rsn_ie)
 	return (memcmp(oui, WPA_OUI, TLV_OUI_LEN) == 0);
 }
 
+static bool brcmf_valid_dpp_suite(u8 *oui)
+{
+	return get_unaligned_be32(oui) == WLAN_AKM_SUITE_WFA_DPP;
+}
+
 static s32
 brcmf_configure_wpaie(struct brcmf_if *ifp,
 		      const struct brcmf_vs_tlv *wpa_ie,
@@ -4651,42 +4673,47 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
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
 
@@ -4706,10 +4733,12 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
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
index 92c16a317328..db942e7eff18 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -6,6 +6,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/rtnetlink.h>
+#include <linux/unaligned.h>
 #include <net/cfg80211.h>
 
 #include <brcmu_wifi.h>
@@ -44,9 +45,6 @@
 
 #define BRCMF_SCB_TIMEOUT_VALUE	20
 
-#define P2P_VER			9	/* P2P version: 9=WiFi P2P v1.0 */
-#define P2P_PUB_AF_CATEGORY	0x04
-#define P2P_PUB_AF_ACTION	0x09
 #define P2P_AF_CATEGORY		0x7f
 #define P2P_OUI			"\x50\x6F\x9A"	/* P2P OUI */
 #define P2P_OUI_LEN		3		/* P2P OUI length */
@@ -143,10 +141,10 @@ struct brcmf_p2p_scan_le {
 /**
  * struct brcmf_p2p_pub_act_frame - WiFi P2P Public Action Frame
  *
- * @category: P2P_PUB_AF_CATEGORY
- * @action: P2P_PUB_AF_ACTION
+ * @category: WLAN_CATEGORY_PUBLIC
+ * @action: WLAN_PUB_ACTION_VENDOR_SPECIFIC
  * @oui: P2P_OUI
- * @oui_type: OUI type - P2P_VER
+ * @oui_type: OUI type - WLAN_OUI_TYPE_WFA_P2P
  * @subtype: OUI subtype - P2P_TYPE_*
  * @dialog_token: nonzero, identifies req/rsp transaction
  * @elts: Variable length information elements.
@@ -166,7 +164,7 @@ struct brcmf_p2p_pub_act_frame {
  *
  * @category: P2P_AF_CATEGORY
  * @oui: OUI - P2P_OUI
- * @type: OUI Type - P2P_VER
+ * @type: OUI Type - WLAN_OUI_TYPE_WFA_P2P
  * @subtype: OUI Subtype - P2P_AF_*
  * @dialog_token: nonzero, identifies req/resp tranaction
  * @elts: Variable length information elements.
@@ -228,10 +226,38 @@ static bool brcmf_p2p_is_pub_action(void *frame, u32 frame_len)
 	if (frame_len < sizeof(*pact_frm))
 		return false;
 
-	if (pact_frm->category == P2P_PUB_AF_CATEGORY &&
-	    pact_frm->action == P2P_PUB_AF_ACTION &&
-	    pact_frm->oui_type == P2P_VER &&
-	    memcmp(pact_frm->oui, P2P_OUI, P2P_OUI_LEN) == 0)
+	if (pact_frm->category == WLAN_CATEGORY_PUBLIC &&
+	    pact_frm->action == WLAN_PUB_ACTION_VENDOR_SPECIFIC &&
+	    pact_frm->oui_type == WLAN_OUI_TYPE_WFA_P2P &&
+	    get_unaligned_be24(pact_frm->oui) == WLAN_OUI_WFA)
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
+	    pact_frm->oui_type == WLAN_OUI_TYPE_WFA_DPP &&
+	    get_unaligned_be24(pact_frm->oui) == WLAN_OUI_WFA)
 		return true;
 
 	return false;
@@ -257,7 +283,7 @@ static bool brcmf_p2p_is_p2p_action(void *frame, u32 frame_len)
 		return false;
 
 	if (act_frm->category == P2P_AF_CATEGORY &&
-	    act_frm->type  == P2P_VER &&
+	    act_frm->type  == WLAN_OUI_TYPE_WFA_P2P &&
 	    memcmp(act_frm->oui, P2P_OUI, P2P_OUI_LEN) == 0)
 		return true;
 
@@ -993,6 +1019,8 @@ int brcmf_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
 	if (err)
 		goto exit;
 
+	p2p->remain_on_channel_wdev = wdev;
+
 	memcpy(&p2p->remain_on_channel, channel, sizeof(*channel));
 	*cookie = p2p->remain_on_channel_cookie;
 	cfg80211_ready_on_channel(wdev, *cookie, channel, duration, GFP_KERNEL);
@@ -1016,6 +1044,7 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
 {
 	struct brcmf_cfg80211_info *cfg = ifp->drvr->config;
 	struct brcmf_p2p_info *p2p = &cfg->p2p;
+	struct wireless_dev *wdev = p2p->remain_on_channel_wdev;
 
 	brcmf_dbg(TRACE, "Enter\n");
 	if (test_and_clear_bit(BRCMF_P2P_STATUS_DISCOVER_LISTEN,
@@ -1028,10 +1057,16 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
 			complete(&p2p->wait_next_af);
 		}
 
-		cfg80211_remain_on_channel_expired(&ifp->vif->wdev,
+		wdev = p2p->remain_on_channel_wdev ?
+			p2p->remain_on_channel_wdev :
+			&ifp->vif->wdev;
+
+		cfg80211_remain_on_channel_expired(wdev,
 						   p2p->remain_on_channel_cookie,
 						   &p2p->remain_on_channel,
 						   GFP_KERNEL);
+		p2p->remain_on_channel_wdev = NULL;
+
 	}
 	return 0;
 }
@@ -1283,6 +1318,9 @@ static s32 brcmf_p2p_abort_action_frame(struct brcmf_cfg80211_info *cfg)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+	if (!vif)
+		vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+
 	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe_abort", &int_val,
 					sizeof(s32));
 	if (err)
@@ -1782,7 +1820,9 @@ bool brcmf_p2p_send_action_frame(struct brcmf_if *ifp,
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
@@ -1819,6 +1859,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_if *ifp,
 	/* validate channel and p2p ies */
 	if (config_af_params.search_channel &&
 	    IS_P2P_SOCIAL_CHANNEL(le32_to_cpu(af_params->channel)) &&
+	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif &&
 	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->saved_ie.probe_req_ie_len) {
 		afx_hdl = &p2p->afx_hdl;
 		afx_hdl->peer_listen_chan = le32_to_cpu(af_params->channel);
@@ -2504,7 +2545,6 @@ s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced)
 
 	pri_ifp = brcmf_get_ifp(cfg->pub, 0);
 	p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif = pri_ifp->vif;
-
 	init_completion(&p2p->send_af_done);
 
 	if (p2pdev_forced) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
index 9f3f01ade2b7..ae159b9aef90 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
@@ -138,6 +138,7 @@ struct brcmf_p2p_info {
 	bool block_gon_req_tx;
 	bool p2pdev_dynamically;
 	bool wait_for_offchan_complete;
+	struct wireless_dev *remain_on_channel_wdev;
 };
 
 s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced);
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
 

base-commit: 6aded6c10490d5b24325e46f22b327876b669f72
-- 
2.25.1


