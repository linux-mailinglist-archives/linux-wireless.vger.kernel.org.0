Return-Path: <linux-wireless+bounces-7990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 811DE8CCE0E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AE61F21071
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 08:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F8413C912;
	Thu, 23 May 2024 08:14:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91714267
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452079; cv=none; b=tULktU6qoks81VeDBxe1No3uQmMWhYnqa/GDZYNNvCrENER32L+9nAVbgIpd/Iop/TGfkXleSVhfsNJcRnmVjT69K1S6X+tJusl6BQKIAryjXLhC2ZLQhx/sT3Xu9eLsJE4hcf8Rx80AjiRO0weEm1SDeZnL6gIyNWMY/X1tZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452079; c=relaxed/simple;
	bh=5qprRG3/otVo+YE28OqT+Rg3v9sHirT21jPOKsYV0UU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T8LaWFau/A58g4pmcTr5ZT0BDzw1NAj4r22joHx52hJzrlcj6q0aEnLwEMrEbeaMPM95d97JyXb1bVluNlBUyTlS4yPBcjJ9wD8CDDyhuip7fsOGFe2o23lcRaoJKaXh+RztjAx0gJ62wWmQ5+nWWk6aQhbEBWGbpKeFiHQCFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sA3as-0007kE-Fg; Thu, 23 May 2024 10:14:34 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sA3ar-002dSg-QI; Thu, 23 May 2024 10:14:33 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sA3ar-00ByL3-2E;
	Thu, 23 May 2024 10:14:33 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] wifi: mwifiex: fix parsing of more than two AKM suites
Date: Thu, 23 May 2024 10:14:28 +0200
Message-Id: <20240523081428.2852276-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

params->crypto.n_akm_suites seems to be limited to two AKM suites. Once
there are more they will be passed as extra elements of type WLAN_EID_RSN
or WLAN_EID_VENDOR_SPECIFIC.

This takes some snippets from the downstream vendor driver to parse
these elements and to set the correct protocol and key_mgmt bits to
enable the desired key managements algorithms in the hardware.

This patch is not a request for inclusion, more a heads up that there's
something missing and the question if the approach taken is the right
one or if there are other preferred ways to fix this issue.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/fw.h     |   3 +
 .../net/wireless/marvell/mwifiex/uap_cmd.c    | 149 +++++++++++++++---
 2 files changed, 132 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 3adc447b715f6..d576b2d71a6b9 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -415,6 +415,9 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define KEY_MGMT_NONE               0x04
 #define KEY_MGMT_PSK                0x02
 #define KEY_MGMT_EAP                0x01
+#define KEY_MGMT_PSK_SHA256         0x100
+#define KEY_MGMT_OWE                0x200
+#define KEY_MGMT_SAE                0x400
 #define CIPHER_TKIP                 0x04
 #define CIPHER_AES_CCMP             0x08
 #define VALID_CIPHER_BITMAP         0x0c
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 491e366119096..4b21626e2dd7f 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -9,6 +9,112 @@
 #include "11ac.h"
 #include "11n.h"
 
+struct wpa_suite_ucast {
+        /* count */
+        u16 count;
+        /** wpa_suite list */
+	__be32 suite[1];
+} __packed;
+
+struct IEEEtypes_Rsn_t {
+        /** Rsn : version */
+        u16 version;
+        /** Rsn : group cipher */
+        __be32 group_cipher;
+        /** Rsn : pairwise cipher */
+        struct wpa_suite_ucast pairwise_cipher;
+} __packed;
+
+static void woal_check_rsn_ie(const struct IEEEtypes_Rsn_t *rsn_ie, int len,
+			      struct mwifiex_uap_bss_param *bss_config, u8 *pairwise_cipher)
+{
+	int left, count, i;
+	struct wpa_suite_ucast *key_mgmt;
+
+	left = len;
+	if (left < (int)sizeof(struct IEEEtypes_Rsn_t))
+		return;
+
+	bss_config->wpa_cfg.group_cipher = 0;
+	*pairwise_cipher = 0;
+	bss_config->key_mgmt = 0;
+
+	/* check the group cipher */
+	switch (be32_to_cpu(rsn_ie->group_cipher)) {
+	case WLAN_CIPHER_SUITE_TKIP:
+		bss_config->wpa_cfg.group_cipher = CIPHER_TKIP;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+		bss_config->wpa_cfg.group_cipher = CIPHER_AES_CCMP;
+		break;
+	default:
+		break;
+	}
+
+	count = le16_to_cpu(rsn_ie->pairwise_cipher.count);
+	for (i = 0; i < count; i++) {
+		switch (be32_to_cpu(rsn_ie->pairwise_cipher.suite[i])) {
+		case WLAN_CIPHER_SUITE_TKIP:
+			*pairwise_cipher |= CIPHER_TKIP;
+			break;
+		case WLAN_CIPHER_SUITE_CCMP:
+			*pairwise_cipher |= CIPHER_AES_CCMP;
+			break;
+		default:
+			break;
+		}
+	}
+	left -= sizeof(struct IEEEtypes_Rsn_t) + (count - 1) * sizeof(__be32);
+	if (left < (int)sizeof(struct wpa_suite_ucast))
+		return;
+
+	key_mgmt = ((void *)rsn_ie + sizeof(struct IEEEtypes_Rsn_t) + (count - 1) * sizeof(__be32));
+	count = le16_to_cpu(key_mgmt->count);
+	if (left < (int)(sizeof(struct wpa_suite_ucast) +
+			 (count - 1) * sizeof(__be32)))
+		return;
+
+	for (i = 0; i < count; i++) {
+		switch (be32_to_cpu(key_mgmt->suite[i])) {
+		case WLAN_AKM_SUITE_8021X:
+			bss_config->key_mgmt |= KEY_MGMT_EAP;
+			break;
+		case WLAN_AKM_SUITE_PSK:
+			bss_config->key_mgmt |= KEY_MGMT_PSK;
+			break;
+		case WLAN_AKM_SUITE_PSK_SHA256:
+			bss_config->key_mgmt |= KEY_MGMT_PSK_SHA256;
+			break;
+		case WLAN_AKM_SUITE_SAE:
+			bss_config->key_mgmt |= KEY_MGMT_SAE;
+			break;
+		case WLAN_AKM_SUITE_OWE:
+			bss_config->key_mgmt |= KEY_MGMT_OWE;
+			break;
+		}
+	}
+}
+
+static void woal_find_wpa_ies(const void *ie, int len, struct mwifiex_uap_bss_param *bss_config)
+{
+	const struct element *e;
+
+	e = cfg80211_find_elem(WLAN_EID_RSN, ie, len);
+	if (e) {
+		woal_check_rsn_ie((void *)e->data, e->datalen, bss_config,
+				  &bss_config->wpa_cfg.pairwise_cipher_wpa2);
+
+		bss_config->protocol |= PROTOCOL_WPA2;
+	}
+
+	e = cfg80211_find_vendor_elem(WLAN_EID_VENDOR_SPECIFIC, 0x1, ie, len);
+	if (e) {
+		woal_check_rsn_ie((void *)e->data, e->datalen, bss_config,
+				  &bss_config->wpa_cfg.pairwise_cipher_wpa);
+		bss_config->protocol |= PROTOCOL_WPA;
+	}
+}
+
 /* This function parses security related parameters from cfg80211_ap_settings
  * and sets into FW understandable bss_config structure.
  */
@@ -17,6 +123,11 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 			      struct cfg80211_ap_settings *params) {
 	int i;
 	struct mwifiex_wep_key wep_key;
+	const u8 *ie = NULL;
+	int ie_len;
+
+	ie = params->beacon.tail;
+	ie_len = params->beacon.tail_len;
 
 	if (!params->privacy) {
 		bss_config->protocol = PROTOCOL_NO_SECURITY;
@@ -46,36 +157,34 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 
 	bss_config->key_mgmt_operation |= KEY_MGMT_ON_HOST;
 
+	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
+		bss_config->protocol |= PROTOCOL_WPA;
+	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
+		bss_config->protocol |= PROTOCOL_WPA2;
+
+	woal_find_wpa_ies(ie, ie_len, bss_config);
+
 	for (i = 0; i < params->crypto.n_akm_suites; i++) {
+		mwifiex_dbg(priv->adapter, MSG, "suite%d: 0x%08x\n", i, params->crypto.akm_suites[i]);
+
 		switch (params->crypto.akm_suites[i]) {
 		case WLAN_AKM_SUITE_8021X:
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_1) {
-				bss_config->protocol = PROTOCOL_WPA;
-				bss_config->key_mgmt = KEY_MGMT_EAP;
-			}
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_2) {
-				bss_config->protocol |= PROTOCOL_WPA2;
-				bss_config->key_mgmt = KEY_MGMT_EAP;
-			}
+			bss_config->key_mgmt |= KEY_MGMT_EAP;
 			break;
 		case WLAN_AKM_SUITE_PSK:
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_1) {
-				bss_config->protocol = PROTOCOL_WPA;
-				bss_config->key_mgmt = KEY_MGMT_PSK;
-			}
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_2) {
-				bss_config->protocol |= PROTOCOL_WPA2;
-				bss_config->key_mgmt = KEY_MGMT_PSK;
-			}
+			bss_config->key_mgmt |= KEY_MGMT_PSK;
+			break;
+		case WLAN_AKM_SUITE_PSK_SHA256:
+			bss_config->key_mgmt |= KEY_MGMT_PSK_SHA256;
 			break;
 		default:
 			break;
 		}
 	}
+
+	mwifiex_dbg(priv->adapter, MSG, "protocol: 0x%08x key_mgmt: 0x%08x\n",
+		    bss_config->protocol, bss_config->key_mgmt);
+
 	for (i = 0; i < params->crypto.n_ciphers_pairwise; i++) {
 		switch (params->crypto.ciphers_pairwise[i]) {
 		case WLAN_CIPHER_SUITE_WEP40:
-- 
2.39.2


