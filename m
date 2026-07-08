Return-Path: <linux-wireless+bounces-38776-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Dq5JDHLTWoP+QEAu9opvQ
	(envelope-from <linux-wireless+bounces-38776-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 05:59:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AA7721859
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 05:59:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infineon.com header.s=IFXMAIL header.b=Qr8Njc0E;
	dmarc=pass (policy=quarantine) header.from=infineon.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38776-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38776-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA46F300A271
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 03:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A23382388;
	Wed,  8 Jul 2026 03:59:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5993115AF;
	Wed,  8 Jul 2026 03:59:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483175; cv=none; b=n49k2TdmcY57WNrR7sdwdWV5wLccMbdD/xmIiyHqpd3U/PxOGMjxmVj8kMu73nW7XBnWVVbjseAaPLUJ69cekatcdfSP1fxWPhi6LmE1IcmwdjcM8ntZNXW20vGVNlKjx93RLHLff9HrsuvtoC+I5u8T0KlWVwUH2Du6y+GEMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483175; c=relaxed/simple;
	bh=Tv6oXcmaXTctyQPQWY0ZQCzn0tuZDaMQS6KIOtjvqos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rY6ZGkENzO6td1WEfdmaJcMx891fwBlNtilxWfstqQSQZCz9NDDsuPg1Ky2TuIJwcqqkgZLYyJ8WcLy00m0bkoMuxrCypxOQFi/57KZOtKR6VvQAEk2U0lSLxft8MO7tqJ3INxSOgAGyLmGpkLJiVd0vI2y3rr95f/3e/87PEcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Qr8Njc0E; arc=none smtp.client-ip=217.10.52.105
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1783483173; x=1815019173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tv6oXcmaXTctyQPQWY0ZQCzn0tuZDaMQS6KIOtjvqos=;
  b=Qr8Njc0EGnJIiwOnCrBOoHSXdbMuyGoPg+AJslZoI9L8rOwuAdOGzHTn
   4ilQSJxvS45Y4htiBVhw6aZV147ret0qqHUx/DOwZH0d8eunv0+ayUtgr
   xv/7seL/g1XfMi53JrIg+V/jLPXorOmnwr9YIyd+5sy5nXLnWG+rLCFQe
   A=;
X-CSE-ConnectionGUID: c98Pr7BnS4aC2LeDEvC9cw==
X-CSE-MsgGUID: AebWueA1T9WLW3+zGbBzHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="150696006"
X-IronPort-AV: E=Sophos;i="6.25,153,1779141600"; 
   d="scan'208";a="150696006"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 05:59:25 +0200
Received: from MUCSE809.infineon.com (172.23.29.35) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 8 Jul
 2026 05:59:25 +0200
Received: from ISCN5CG5251XQT.infineon.com (10.161.6.196) by
 MUCSE809.infineon.com (172.23.29.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 05:59:22 +0200
From: Jason Huang <Jason.Huang2@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>,
	<linux-kernel@vger.kernel.org>, <arend.vanspriel@broadcom.com>, Jason Huang
	<jason.huang2@infineon.com>, Kurt Lee <kurt.lee@cypress.com>, Copilot
	<223556219+Copilot@users.noreply.github.com>
Subject: [PATCH v3] wifi: brcmfmac: add DPP support
Date: Wed, 8 Jul 2026 11:58:43 +0800
Message-ID: <20260708035843.312554-1-Jason.Huang2@infineon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260604034227.590951-1-Jason.Huang2@infineon.com>
References: <20260604034227.590951-1-Jason.Huang2@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE814.infineon.com (172.23.29.40) To
 MUCSE809.infineon.com (172.23.29.35)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infineon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infineon.com:s=IFXMAIL];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Jason.Huang2@infineon.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38776-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:arend.vanspriel@broadcom.com,m:jason.huang2@infineon.com,m:kurt.lee@cypress.com,m:223556219+Copilot@users.noreply.github.com,m:223556219@users.noreply.github.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[infineon.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason.Huang2@infineon.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,Copilot];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cypress.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89AA7721859

From: Jason Huang <jason.huang2@infineon.com>

Add DPP AKM handling and RSN parsing support. Map DPP to the
firmware wpa_auth value and recognize DPP public action frames in the
P2P action-frame TX path.

Allow non-P2P public action frames such as DPP to use the primary vif
when a P2P device vif is not present. Guard P2P-device IE access for
the same case.

Gate sup_wpa programming on firmware supplicant capability. Disable it
only when the selected connection mode does not use firmware supplicant.
This keeps pure SAE and 802.1X firmware-supplicant paths intact while
avoiding stale firmware supplicant state for DPP.

Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
Signed-off-by: Jason Huang <jason.huang2@infineon.com>
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 151 ++++++++++--------
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  59 +++++--
 .../broadcom/brcm80211/include/brcmu_wifi.h   |   2 +
 3 files changed, 134 insertions(+), 78 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4b70845e1a26..d61c3e03a106 100644
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
@@ -2154,6 +2155,9 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 			val = WPA2_AUTH_PSK | WPA2_AUTH_FT;
 			profile->is_ft = true;
 			break;
+		case WLAN_AKM_SUITE_WFA_DPP:
+			val = WFA_AUTH_DPP;
+			break;
 		default:
 			bphy_err(drvr, "invalid akm suite (%d)\n",
 				 sme->crypto.akm_suites[0]);
@@ -2466,43 +2470,50 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
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
+		if (sme->crypto.psk && !is_sae_akm &&
+		    profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
+			if (WARN_ON(profile->use_fwsup !=
+				    BRCMF_PROFILE_FWSUP_NONE)) {
+				err = -EINVAL;
+				goto done;
+			}
+			brcmf_dbg(INFO, "using PSK offload\n");
+			profile->use_fwsup = BRCMF_PROFILE_FWSUP_PSK;
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
+			 sme->crypto.sae_pwd &&
+			 brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SAE)) {
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
@@ -4519,6 +4530,11 @@ static bool brcmf_valid_wpa_oui(u8 *oui, bool is_rsn_ie)
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
@@ -4632,42 +4648,47 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
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
 
@@ -4687,10 +4708,12 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
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
index 6e0c90f4718b..2c1f52ed5138 100644
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
 
@@ -1281,6 +1307,9 @@ static s32 brcmf_p2p_abort_action_frame(struct brcmf_cfg80211_info *cfg)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+	if (!vif)
+		vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+
 	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe_abort", &int_val,
 					sizeof(s32));
 	if (err)
@@ -1789,7 +1818,9 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
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
@@ -1826,6 +1857,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 	/* validate channel and p2p ies */
 	if (config_af_params.search_channel &&
 	    IS_P2P_SOCIAL_CHANNEL(le32_to_cpu(af_params->channel)) &&
+	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif &&
 	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->saved_ie.probe_req_ie_len) {
 		afx_hdl = &p2p->afx_hdl;
 		afx_hdl->peer_listen_chan = le32_to_cpu(af_params->channel);
@@ -2543,4 +2575,3 @@ void brcmf_p2p_detach(struct brcmf_p2p_info *p2p)
 	/* just set it all to zero */
 	memset(p2p, 0, sizeof(*p2p));
 }
-
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
 

base-commit: 3737936e2be920977aea7d9f7eb8cb4468d700d7
-- 
2.25.1


