Return-Path: <linux-wireless+bounces-12872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5732B9796F5
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 16:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B5282385
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009231C68A7;
	Sun, 15 Sep 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CBh0bwdQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8DA1C57BC
	for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726408883; cv=none; b=Pnc8UY+w+cyqkpm7zhGwxxyG/i3rLJLidIDOCiaRtwstisZTT/7iNVL3cDj3tpxmgA7xYm7+d3WlArMvvfTOGmLTcmCVMtMQUHSZ1M43TKvyFg1GWn1+ONlyjvluqdZMN5NigyMA9kaC2d0MnjvaqXoxdsrcBiSFUPHi3mtDOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726408883; c=relaxed/simple;
	bh=L46VkFbuFr5pdEtYB5do6Y3kx08hLj261OhgY+nypwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLccAIqVj0qgrNrVSIlTbZEUvoIz6O7S2D/4GMhEk/Fof9eBX2KD9RZa0meR5pmvRsAR0KCZeZCoVRB/Pf0BzGVFCLmWFLa5XFGjjKnARs3/0pIhuex/P14MabCHLoZUQkZ5ivN+jkRn84rEJ3m/TYTxqrKHZI4fqAtacejpOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CBh0bwdQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso3317680b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726408881; x=1727013681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+qC3o/y18ly8NRwj8G9n3FaVLwR9nXeFBXQPV+GvCs=;
        b=CBh0bwdQ81egtH/BblML5iwfWFDcMIwM5KVQ594jk9Wk1QbK2PU/PlUNJfuvX9nATe
         mKRy0O/7M6wXn+aht2Wpui0v8qIU4+x/Vcl2Q+o3yZr9gDDcOvZ1xdnFy2LuwZel1zWM
         N2pVYoLOxg4oo/n1zBk3uegTfsvcx/3Az0bVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726408881; x=1727013681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+qC3o/y18ly8NRwj8G9n3FaVLwR9nXeFBXQPV+GvCs=;
        b=hqLwJpD/rk3QJs13mcutT+R2rQDEJRRD+wOUZUwpOSUkm7z9mvuJiYbWybcEhZCG6N
         IFbV1go3RAaCctdE8fIDF4poZv/w1voGLannOR772cTHErlOumRWA3wTx8BhWK7wfe5K
         AJENeKf5Pr7luTZh2L27+kf9fzJjVDdYga+mi2vcoOp6Ijc0vmM5z8o3Aksh7ct5LwbE
         035Dr/ligCposPAgZrEyeFHMpFPlgHFkDnymUFP8Kn3La5F94QjbmYNeY6UUVJFRc0SC
         3skvdpSJ3YeT4AUrVSMIhbJBivIziq3/R59otYCXz9eFVGxZktahHZXtD0zRdwf1OoKf
         0uoA==
X-Gm-Message-State: AOJu0YxrMzvV2l21K4GUusAg/yr9bURnf/0iI0FUeoUD69CeCWIBBn09
	nqi9b/22jnOHDUeTb/+kZuZv1ANyInoetvqiySZ9FIoprHiyYHbeJH1V366xHA==
X-Google-Smtp-Source: AGHT+IHFV5LUvEA04PZii+GYWntNRu0tnNBktixh6gnTxxAJ00URcQ406Ou9AbPvKKhLlh+wFP8HqA==
X-Received: by 2002:a05:6a00:1884:b0:710:591e:b52f with SMTP id d2e1a72fcca58-719260656fcmr21157351b3a.5.1726408880372;
        Sun, 15 Sep 2024 07:01:20 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab50d6sm2233511b3a.75.2024.09.15.07.01.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2024 07:01:19 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
	Chi-hsien Lin <chi-hsien.lin@infineon.com>
Subject: [RFT 3/3] wifi: brcmfmac: cyw: support external SAE authentication in station mode
Date: Sun, 15 Sep 2024 16:00:49 +0200
Message-Id: <20240915140049.181380-4-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240915140049.181380-1-arend.vanspriel@broadcom.com>
References: <20240915140049.181380-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware has SME functionality but would like the userspace to handle
SAE authentication. This patch adds support for such an external SAE
authentication mechanism in station mode.

Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
[arend: rework patch for per-vendor framework]
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  42 ++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  25 ++
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 308 ++++++++++++++++++
 .../brcm80211/brcmfmac/cyw/fwil_types.h       |  84 +++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |   3 +-
 .../broadcom/brcm80211/brcmfmac/feature.h     |   4 +-
 .../broadcom/brcm80211/brcmfmac/fweh.c        |   5 +-
 .../broadcom/brcm80211/brcmfmac/fweh.h        |   6 +-
 .../broadcom/brcm80211/brcmfmac/fwvid.h       |  11 +
 9 files changed, 466 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 92e310f7f2ce..667e1e11a49a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -74,7 +74,6 @@
 #define VNDR_IE_HDR_SIZE		12
 #define VNDR_IE_PARSE_LIMIT		5
 
-#define	DOT11_MGMT_HDR_LEN		24	/* d11 management header len */
 #define	DOT11_BCN_PRB_FIXED_LEN		12	/* beacon/probe fixed length */
 
 #define BRCMF_SCAN_JOIN_ACTIVE_DWELL_TIME_MS	320
@@ -1941,17 +1940,22 @@ static s32 brcmf_set_wpa_version(struct net_device *ndev,
 	struct brcmf_cfg80211_profile *profile = ndev_to_prof(ndev);
 	struct brcmf_pub *drvr = ifp->drvr;
 	struct brcmf_cfg80211_security *sec;
-	s32 val = 0;
-	s32 err = 0;
+	s32 val;
+	s32 err;
 
-	if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_1)
+	if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_1) {
 		val = WPA_AUTH_PSK | WPA_AUTH_UNSPECIFIED;
-	else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2)
-		val = WPA2_AUTH_PSK | WPA2_AUTH_UNSPECIFIED;
-	else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_3)
+	} else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2) {
+		if (drvr->bus_if->fwvid == BRCMF_FWVENDOR_CYW &&
+		    sme->crypto.akm_suites[0] == WLAN_AKM_SUITE_SAE)
+			val = WPA3_AUTH_SAE_PSK;
+		else
+			val = WPA2_AUTH_PSK | WPA2_AUTH_UNSPECIFIED;
+	} else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_3) {
 		val = WPA3_AUTH_SAE_PSK;
-	else
+	} else {
 		val = WPA_AUTH_DISABLED;
+	}
 	brcmf_dbg(CONN, "setting wpa_auth to 0x%0x\n", val);
 	err = brcmf_fil_bsscfg_int_set(ifp, "wpa_auth", val);
 	if (err) {
@@ -2159,28 +2163,25 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 		switch (sme->crypto.akm_suites[0]) {
 		case WLAN_AKM_SUITE_SAE:
 			val = WPA3_AUTH_SAE_PSK;
-			if (sme->crypto.sae_pwd) {
-				brcmf_dbg(INFO, "using SAE offload\n");
-				profile->use_fwsup = BRCMF_PROFILE_FWSUP_SAE;
-			}
 			break;
 		case WLAN_AKM_SUITE_FT_OVER_SAE:
 			val = WPA3_AUTH_SAE_PSK | WPA2_AUTH_FT;
 			profile->is_ft = true;
-			if (sme->crypto.sae_pwd) {
-				brcmf_dbg(INFO, "using SAE offload\n");
-				profile->use_fwsup = BRCMF_PROFILE_FWSUP_SAE;
-			}
 			break;
 		default:
 			bphy_err(drvr, "invalid akm suite (%d)\n",
 				 sme->crypto.akm_suites[0]);
 			return -EINVAL;
 		}
+		if (sme->crypto.sae_pwd) {
+			profile->use_fwsup = BRCMF_PROFILE_FWSUP_SAE;
+		}
 	}
 
 	if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_1X)
 		brcmf_dbg(INFO, "using 1X offload\n");
+	if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE)
+		brcmf_dbg(INFO, "using SAE offload\n");
 
 	if (!brcmf_feat_is_enabled(ifp, BRCMF_FEAT_MFP))
 		goto skip_mfp_config;
@@ -2217,7 +2218,7 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 	brcmf_fil_bsscfg_int_set(netdev_priv(ndev), "mfp", mfp);
 
 skip_mfp_config:
-	brcmf_dbg(CONN, "setting wpa_auth to %d\n", val);
+	brcmf_dbg(CONN, "setting wpa_auth to 0x%0x\n", val);
 	err = brcmf_fil_bsscfg_int_set(netdev_priv(ndev), "wpa_auth", val);
 	if (err) {
 		bphy_err(drvr, "could not set wpa_auth (%d)\n", err);
@@ -5501,7 +5502,7 @@ brcmf_cfg80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
 }
 
 
-static int
+int
 brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       struct cfg80211_mgmt_tx_params *params, u64 *cookie)
 {
@@ -5608,6 +5609,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 exit:
 	return err;
 }
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_cfg80211_mgmt_tx);
 
 static int brcmf_cfg80211_set_cqm_rssi_range_config(struct wiphy *wiphy,
 						    struct net_device *ndev,
@@ -6001,6 +6003,7 @@ struct brcmf_cfg80211_vif *brcmf_alloc_vif(struct brcmf_cfg80211_info *cfg,
 
 	vif->wdev.wiphy = cfg->wiphy;
 	vif->wdev.iftype = type;
+	init_completion(&vif->mgmt_tx);
 
 	brcmf_init_prof(&vif->profile);
 
@@ -7340,6 +7343,7 @@ brcmf_txrx_stypes[NUM_NL80211_IFTYPES] = {
 	[NL80211_IFTYPE_STATION] = {
 		.tx = 0xffff,
 		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+		      BIT(IEEE80211_STYPE_AUTH >> 4) |
 		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4)
 	},
 	[NL80211_IFTYPE_P2P_CLIENT] = {
@@ -7645,6 +7649,8 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, struct brcmf_if *ifp)
 			wiphy_ext_feature_set(wiphy,
 					      NL80211_EXT_FEATURE_SAE_OFFLOAD_AP);
 	}
+	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SAE_EXT))
+		wiphy->features |= NL80211_FEATURE_SAE;
 	wiphy->mgmt_stypes = brcmf_txrx_stypes;
 	wiphy->max_remain_on_channel_duration = 5000;
 	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_PNO)) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index dc3a6a537507..ae6a3d55e66d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -13,6 +13,8 @@
 #include "fwil_types.h"
 #include "p2p.h"
 
+#define	DOT11_MGMT_HDR_LEN		24	/* d11 management header len */
+
 #define BRCMF_SCAN_IE_LEN_MAX		2048
 
 #define WL_NUM_SCAN_MAX			10
@@ -141,6 +143,21 @@ enum brcmf_profile_fwauth {
 	BRCMF_PROFILE_FWAUTH_SAE
 };
 
+/**
+ * enum brcmf_mgmt_tx_status - mgmt frame tx status
+ *
+ * @BRCMF_MGMT_TX_ACK: mgmt frame acked
+ * @BRCMF_MGMT_TX_NOACK: mgmt frame not acked
+ * @BRCMF_MGMT_TX_OFF_CHAN_COMPLETED: off-channel complete
+ * @BRCMF_MGMT_TX_SEND_FRAME: mgmt frame tx is in progres
+ */
+enum brcmf_mgmt_tx_status {
+	BRCMF_MGMT_TX_ACK,
+	BRCMF_MGMT_TX_NOACK,
+	BRCMF_MGMT_TX_OFF_CHAN_COMPLETED,
+	BRCMF_MGMT_TX_SEND_FRAME
+};
+
 /**
  * struct brcmf_cfg80211_profile - profile information.
  *
@@ -211,6 +228,9 @@ struct vif_saved_ie {
  * @profile: profile information.
  * @sme_state: SME state using enum brcmf_vif_status bits.
  * @list: linked list.
+ * @mgmt_tx: completion for management frame transmit.
+ * @mgmt_tx_status: status of last management frame sent to firmware.
+ * @mgmt_tx_id:
  * @mgmt_rx_reg: registered rx mgmt frame types.
  * @mbss: Multiple BSS type, set if not first AP (not relevant for P2P).
  * @cqm_rssi_low: Lower RSSI limit for CQM monitoring
@@ -224,6 +244,9 @@ struct brcmf_cfg80211_vif {
 	unsigned long sme_state;
 	struct vif_saved_ie saved_ie;
 	struct list_head list;
+	struct completion mgmt_tx;
+	unsigned long mgmt_tx_status;
+	u32 mgmt_tx_id;
 	u16 mgmt_rx_reg;
 	bool mbss;
 	int is_11d;
@@ -469,5 +492,7 @@ void brcmf_abort_scanning(struct brcmf_cfg80211_info *cfg);
 void brcmf_cfg80211_free_netdev(struct net_device *ndev);
 
 int brcmf_set_wsec(struct brcmf_if *ifp, const u8 *key, u16 key_len, u16 flags);
+int brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
+			   struct cfg80211_mgmt_tx_params *params, u64 *cookie);
 
 #endif /* BRCMFMAC_CFG80211_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index 9a4837881486..f32a73e1fa9e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -8,11 +8,21 @@
 #include <bus.h>
 #include <fwvid.h>
 #include <fwil.h>
+#include <fweh.h>
 
 #include "vops.h"
+#include "fwil_types.h"
 
+/* event definitions */
+#define BRCMF_CYW_E_EXT_AUTH_REQ	187
+#define BRCMF_CYW_E_EXT_AUTH_FRAME_RX	188
+#define BRCMF_CYW_E_MGMT_FRAME_TXS	189
+#define BRCMF_CYW_E_MGMT_FRAME_TXS_OC	190
 #define BRCMF_CYW_E_LAST		197
 
+#define MGMT_AUTH_FRAME_DWELL_TIME	4000
+#define MGMT_AUTH_FRAME_WAIT_TIME	(MGMT_AUTH_FRAME_DWELL_TIME + 100)
+
 static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
 				 struct cfg80211_crypto_settings *crypto)
 {
@@ -39,6 +49,19 @@ static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
 	return err;
 }
 
+static const struct brcmf_fweh_event_map brcmf_cyw_event_map = {
+	.items = {
+		{ BRCMF_E_EXT_AUTH_REQ, BRCMF_CYW_E_EXT_AUTH_REQ },
+		{ BRCMF_E_EXT_AUTH_FRAME_RX, BRCMF_CYW_E_EXT_AUTH_FRAME_RX },
+		{ BRCMF_E_MGMT_FRAME_TXSTATUS, BRCMF_CYW_E_MGMT_FRAME_TXS },
+		{
+			BRCMF_E_MGMT_FRAME_OFFCHAN_DONE,
+			BRCMF_CYW_E_MGMT_FRAME_TXS_OC
+		},
+	},
+	.n_items = 1
+};
+
 static int brcmf_cyw_alloc_fweh_info(struct brcmf_pub *drvr)
 {
 	struct brcmf_fweh_info *fweh;
@@ -53,7 +76,292 @@ static int brcmf_cyw_alloc_fweh_info(struct brcmf_pub *drvr)
 	return 0;
 }
 
+static int brcmf_cyw_activate_events(struct brcmf_if *ifp)
+{
+	struct brcmf_fweh_info *fweh = ifp->drvr->fweh;
+	struct brcmf_eventmsgs_ext *eventmask_msg;
+	u32 msglen;
+	int err;
+
+	msglen = sizeof(*eventmask_msg) + fweh->event_mask_len;
+	eventmask_msg = kzalloc(msglen, GFP_KERNEL);
+	if (!eventmask_msg)
+		return -ENOMEM;
+	eventmask_msg->ver = EVENTMSGS_VER;
+	eventmask_msg->command = CYW_EVENTMSGS_SET_MASK;
+	eventmask_msg->len = fweh->event_mask_len;
+	memcpy(eventmask_msg->mask, fweh->event_mask, fweh->event_mask_len);
+
+	err = brcmf_fil_iovar_data_set(ifp, "event_msgs_ext", eventmask_msg,
+				       msglen);
+	kfree(eventmask_msg);
+	return err;
+}
+
+static
+int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
+		      struct cfg80211_mgmt_tx_params *params, u64 *cookie)
+{
+	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct ieee80211_channel *chan = params->chan;
+	struct brcmf_pub *drvr = cfg->pub;
+	const u8 *buf = params->buf;
+	size_t len = params->len;
+	const struct ieee80211_mgmt *mgmt;
+	struct brcmf_cfg80211_vif *vif;
+	s32 err = 0;
+	bool ack = false;
+	s32 chan_nr;
+	u32 freq;
+	struct brcmf_mf_params_le *mf_params;
+	u32 mf_params_len;
+	s32 timeout;
+
+	brcmf_dbg(TRACE, "Enter\n");
+
+	mgmt = (const struct ieee80211_mgmt *)buf;
+
+	if (!ieee80211_is_auth(mgmt->frame_control))
+		return brcmf_cfg80211_mgmt_tx(wiphy, wdev, params, cookie);
+
+	*cookie = 0;
+	vif = container_of(wdev, struct brcmf_cfg80211_vif, wdev);
+
+	reinit_completion(&vif->mgmt_tx);
+	clear_bit(BRCMF_MGMT_TX_ACK, &vif->mgmt_tx_status);
+	clear_bit(BRCMF_MGMT_TX_NOACK, &vif->mgmt_tx_status);
+	clear_bit(BRCMF_MGMT_TX_OFF_CHAN_COMPLETED,
+		  &vif->mgmt_tx_status);
+	mf_params_len = offsetof(struct brcmf_mf_params_le, data) +
+			(len - DOT11_MGMT_HDR_LEN);
+	mf_params = kzalloc(mf_params_len, GFP_KERNEL);
+	if (!mf_params)
+		return -ENOMEM;
+
+	mf_params->dwell_time = cpu_to_le32(MGMT_AUTH_FRAME_DWELL_TIME);
+	mf_params->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
+	mf_params->frame_control = mgmt->frame_control;
+
+	if (chan)
+		freq = chan->center_freq;
+	else
+		brcmf_fil_cmd_int_get(vif->ifp, BRCMF_C_GET_CHANNEL,
+				      &freq);
+	chan_nr = ieee80211_frequency_to_channel(freq);
+	mf_params->channel = cpu_to_le32(chan_nr);
+	memcpy(&mf_params->da[0], &mgmt->da[0], ETH_ALEN);
+	memcpy(&mf_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
+	mf_params->packet_id = cpu_to_le32(*cookie);
+	memcpy(mf_params->data, &buf[DOT11_MGMT_HDR_LEN],
+	       le16_to_cpu(mf_params->len));
+
+	brcmf_dbg(TRACE, "Auth frame, cookie=%d, fc=%04x, len=%d, channel=%d\n",
+		  le32_to_cpu(mf_params->packet_id),
+		  le16_to_cpu(mf_params->frame_control),
+		  le16_to_cpu(mf_params->len),
+		  le32_to_cpu(mf_params->channel));
+
+	vif->mgmt_tx_id = le32_to_cpu(mf_params->packet_id);
+	set_bit(BRCMF_MGMT_TX_SEND_FRAME, &vif->mgmt_tx_status);
+
+	err = brcmf_fil_bsscfg_data_set(vif->ifp, "mgmt_frame",
+					mf_params, mf_params_len);
+	if (err) {
+		bphy_err(drvr, "Failed to send Auth frame: err=%d\n",
+			 err);
+		goto tx_status;
+	}
+
+	timeout =
+		wait_for_completion_timeout(&vif->mgmt_tx,
+					    MGMT_AUTH_FRAME_WAIT_TIME);
+	if (test_bit(BRCMF_MGMT_TX_ACK, &vif->mgmt_tx_status)) {
+		brcmf_dbg(TRACE, "TX Auth frame operation is success\n");
+		ack = true;
+	} else {
+		bphy_err(drvr, "TX Auth frame operation is failed: status=%ld)\n",
+			 vif->mgmt_tx_status);
+	}
+
+tx_status:
+	cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
+				GFP_KERNEL);
+	kfree(mf_params);
+	return err;
+}
+
+static int
+brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
+			struct cfg80211_external_auth_params *params)
+{
+	struct brcmf_if *ifp;
+	struct brcmf_pub *drvr;
+	struct brcmf_auth_req_status_le auth_status;
+	int ret = 0;
+
+	brcmf_dbg(TRACE, "Enter\n");
+
+	ifp = netdev_priv(dev);
+	drvr = ifp->drvr;
+	if (params->status == WLAN_STATUS_SUCCESS) {
+		auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_SUCCESS);
+	} else {
+		bphy_err(drvr, "External authentication failed: status=%d\n",
+			 params->status);
+		auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_FAIL);
+	}
+
+	memcpy(auth_status.peer_mac, params->bssid, ETH_ALEN);
+	auth_status.ssid_len = cpu_to_le32(min_t(u8, params->ssid.ssid_len,
+						 IEEE80211_MAX_SSID_LEN));
+	memcpy(auth_status.ssid, params->ssid.ssid, auth_status.ssid_len);
+
+	ret = brcmf_fil_iovar_data_set(ifp, "auth_status", &auth_status,
+				       sizeof(auth_status));
+	if (ret < 0)
+		bphy_err(drvr, "auth_status iovar failed: ret=%d\n", ret);
+
+	return ret;
+}
+
+static void brcmf_cyw_get_cfg80211_ops(struct brcmf_pub *drvr)
+{
+	drvr->ops->mgmt_tx = brcmf_cyw_mgmt_tx;
+	drvr->ops->external_auth = brcmf_cyw_external_auth;
+}
+
+static s32
+brcmf_cyw_notify_ext_auth_req(struct brcmf_if *ifp,
+			      const struct brcmf_event_msg *e, void *data)
+{
+	struct brcmf_pub *drvr = ifp->drvr;
+	struct cfg80211_external_auth_params params;
+	struct brcmf_auth_req_status_le *auth_req =
+		(struct brcmf_auth_req_status_le *)data;
+	s32 err = 0;
+
+	brcmf_dbg(INFO, "Enter: event %s (%d) received\n",
+		  brcmf_fweh_event_name(e->event_code), e->event_code);
+
+	if (e->datalen < sizeof(*auth_req)) {
+		bphy_err(drvr, "Event %s (%d) data too small. Ignore\n",
+			 brcmf_fweh_event_name(e->event_code), e->event_code);
+		return -EINVAL;
+	}
+
+	memset(&params, 0, sizeof(params));
+	params.action = NL80211_EXTERNAL_AUTH_START;
+	params.key_mgmt_suite = ntohl(WLAN_AKM_SUITE_SAE);
+	params.status = WLAN_STATUS_SUCCESS;
+	params.ssid.ssid_len = min_t(u32, 32, le32_to_cpu(auth_req->ssid_len));
+	memcpy(params.ssid.ssid, auth_req->ssid, params.ssid.ssid_len);
+	memcpy(params.bssid, auth_req->peer_mac, ETH_ALEN);
+
+	err = cfg80211_external_auth_request(ifp->ndev, &params, GFP_ATOMIC);
+	if (err)
+		bphy_err(drvr, "Ext Auth request to supplicant failed (%d)\n",
+			 err);
+
+	return err;
+}
+
+static s32
+brcmf_notify_auth_frame_rx(struct brcmf_if *ifp,
+			   const struct brcmf_event_msg *e, void *data)
+{
+	struct brcmf_pub *drvr = ifp->drvr;
+	struct brcmf_cfg80211_info *cfg = drvr->config;
+	struct wireless_dev *wdev;
+	u32 mgmt_frame_len = e->datalen - sizeof(struct brcmf_rx_mgmt_data);
+	struct brcmf_rx_mgmt_data *rxframe = (struct brcmf_rx_mgmt_data *)data;
+	u8 *frame = (u8 *)(rxframe + 1);
+	struct brcmu_chan ch;
+	struct ieee80211_mgmt *mgmt_frame;
+	s32 freq;
+
+	brcmf_dbg(INFO, "Enter: event %s (%d) received\n",
+		  brcmf_fweh_event_name(e->event_code), e->event_code);
+
+	if (e->datalen < sizeof(*rxframe)) {
+		bphy_err(drvr, "Event %s (%d) data too small. Ignore\n",
+			 brcmf_fweh_event_name(e->event_code), e->event_code);
+		return -EINVAL;
+	}
+
+	wdev = &ifp->vif->wdev;
+	WARN_ON(!wdev);
+
+	ch.chspec = be16_to_cpu(rxframe->chanspec);
+	cfg->d11inf.decchspec(&ch);
+
+	mgmt_frame = kzalloc(mgmt_frame_len, GFP_KERNEL);
+	if (!mgmt_frame)
+		return -ENOMEM;
+
+	mgmt_frame->frame_control = cpu_to_le16(IEEE80211_STYPE_AUTH);
+	memcpy(mgmt_frame->da, ifp->mac_addr, ETH_ALEN);
+	memcpy(mgmt_frame->sa, e->addr, ETH_ALEN);
+	brcmf_fil_cmd_data_get(ifp, BRCMF_C_GET_BSSID, mgmt_frame->bssid,
+			       ETH_ALEN);
+	frame += offsetof(struct ieee80211_mgmt, u);
+	memcpy(&mgmt_frame->u, frame,
+	       mgmt_frame_len - offsetof(struct ieee80211_mgmt, u));
+
+	freq = ieee80211_channel_to_frequency(ch.control_ch_num,
+					      ch.band == BRCMU_CHAN_BAND_2G ?
+					      NL80211_BAND_2GHZ :
+					      NL80211_BAND_5GHZ);
+
+	cfg80211_rx_mgmt(wdev, freq, 0, (u8 *)mgmt_frame, mgmt_frame_len,
+			 NL80211_RXMGMT_FLAG_EXTERNAL_AUTH);
+	kfree(mgmt_frame);
+	return 0;
+}
+
+static s32
+brcmf_notify_mgmt_tx_status(struct brcmf_if *ifp,
+			    const struct brcmf_event_msg *e, void *data)
+{
+	struct brcmf_cfg80211_vif *vif = ifp->vif;
+	u32 *packet_id = (u32 *)data;
+
+	brcmf_dbg(INFO, "Enter: event %s (%d), status=%d\n",
+		  brcmf_fweh_event_name(e->event_code), e->event_code,
+		  e->status);
+
+	if (!test_bit(BRCMF_MGMT_TX_SEND_FRAME, &vif->mgmt_tx_status) ||
+	    (*packet_id != vif->mgmt_tx_id))
+		return 0;
+
+	if (e->event_code == BRCMF_E_MGMT_FRAME_TXSTATUS) {
+		if (e->status == BRCMF_E_STATUS_SUCCESS)
+			set_bit(BRCMF_MGMT_TX_ACK, &vif->mgmt_tx_status);
+		else
+			set_bit(BRCMF_MGMT_TX_NOACK, &vif->mgmt_tx_status);
+	} else {
+		set_bit(BRCMF_MGMT_TX_OFF_CHAN_COMPLETED, &vif->mgmt_tx_status);
+	}
+
+	complete(&vif->mgmt_tx);
+	return 0;
+}
+
+static void brcmf_cyw_register_event_handlers(struct brcmf_pub *drvr)
+{
+	brcmf_fweh_register(drvr, BRCMF_E_EXT_AUTH_REQ,
+			    brcmf_cyw_notify_ext_auth_req);
+	brcmf_fweh_register(drvr, BRCMF_E_EXT_AUTH_FRAME_RX,
+			    brcmf_notify_auth_frame_rx);
+	brcmf_fweh_register(drvr, BRCMF_E_MGMT_FRAME_TXSTATUS,
+			    brcmf_notify_mgmt_tx_status);
+	brcmf_fweh_register(drvr, BRCMF_E_MGMT_FRAME_OFFCHAN_DONE,
+			    brcmf_notify_mgmt_tx_status);
+}
+
 const struct brcmf_fwvid_ops brcmf_cyw_ops = {
 	.set_sae_password = brcmf_cyw_set_sae_pwd,
 	.alloc_fweh_info = brcmf_cyw_alloc_fweh_info,
+	.activate_events = brcmf_cyw_activate_events,
+	.get_cfg80211_ops = brcmf_cyw_get_cfg80211_ops,
+	.register_event_handlers = brcmf_cyw_register_event_handlers,
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
new file mode 100644
index 000000000000..18129adb5dc2
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ */
+
+#ifndef CYW_FWIL_TYPES_H_
+#define CYW_FWIL_TYPES_H_
+
+#include <fwil_types.h>
+
+enum brcmf_event_msgs_ext_command {
+	CYW_EVENTMSGS_NONE	= 0,
+	CYW_EVENTMSGS_SET_BIT	= 1,
+	CYW_EVENTMSGS_RESET_BIT	= 2,
+	CYW_EVENTMSGS_SET_MASK	= 3,
+};
+
+#define EVENTMSGS_VER 1
+#define EVENTMSGS_EXT_STRUCT_SIZE	offsetof(struct eventmsgs_ext, mask[0])
+
+/**
+ * struct brcmf_eventmsgs_ext - structure used with "eventmsgs_ext" iovar.
+ *
+ * @ver: version.
+ * @command: requested operation (see &enum event_msgs_ext_command).
+ * @len: length of the @mask array.
+ * @maxgetsize: indicates maximum mask size that may be returned by firmware
+ *	upon iovar GET.
+ * @mask: array where each bit represents firmware event.
+ */
+struct brcmf_eventmsgs_ext {
+	u8	ver;
+	u8	command;
+	u8	len;
+	u8	maxgetsize;
+	u8	mask[] __counted_by(len);
+};
+
+#define BRCMF_EXTAUTH_START		1
+#define BRCMF_EXTAUTH_ABORT		2
+#define BRCMF_EXTAUTH_FAIL		3
+#define BRCMF_EXTAUTH_SUCCESS		4
+
+/**
+ * struct brcmf_auth_req_status_le - external auth request and status update
+ *
+ * @flags: flags for external auth status
+ * @peer_mac: peer MAC address
+ * @ssid_len: length of ssid
+ * @ssid: ssid characters
+ */
+struct brcmf_auth_req_status_le {
+	__le16 flags;
+	u8 peer_mac[ETH_ALEN];
+	__le32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+};
+
+/**
+ * struct brcmf_mf_params_le - management frame parameters for mgmt_frame iovar
+ *
+ * @version: version of the iovar
+ * @dwell_time: dwell duration in ms
+ * @len: length of frame data
+ * @frame_control: frame control
+ * @channel: channel
+ * @da: peer MAC address
+ * @bssid: BSS network identifier
+ * @packet_id: packet identifier
+ * @data: frame data
+ */
+struct brcmf_mf_params_le {
+	__le32 version;
+	__le32 dwell_time;
+	__le16 len;
+	__le16 frame_control;
+	__le16 channel;
+	u8 da[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	__le32 packet_id;
+	u8 data[] __counted_by(len);
+};
+
+#endif /* CYW_FWIL_TYPES_H_ */
\ No newline at end of file
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 0d9ae197fa1e..488364ef8ff2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -42,8 +42,9 @@ static const struct brcmf_feat_fwcap brcmf_fwcap_map[] = {
 	{ BRCMF_FEAT_MONITOR_FLAG, "rtap" },
 	{ BRCMF_FEAT_MONITOR_FMT_RADIOTAP, "rtap" },
 	{ BRCMF_FEAT_DOT11H, "802.11h" },
-	{ BRCMF_FEAT_SAE, "sae" },
+	{ BRCMF_FEAT_SAE, "sae " },
 	{ BRCMF_FEAT_FWAUTH, "idauth" },
+	{ BRCMF_FEAT_SAE_EXT, "sae_ext" },
 };
 
 #ifdef DEBUG
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
index 7f4f0b3e4a7b..31f8695ca417 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
@@ -31,6 +31,7 @@
  * FWAUTH: Firmware authenticator
  * DUMP_OBSS: Firmware has capable to dump obss info to support ACS
  * SCAN_V2: Version 2 scan params
+ * SAE_EXT: SAE authentication handled by user-space supplicant
  */
 #define BRCMF_FEAT_LIST \
 	BRCMF_FEAT_DEF(MBSS) \
@@ -57,7 +58,8 @@
 	BRCMF_FEAT_DEF(DUMP_OBSS) \
 	BRCMF_FEAT_DEF(SCAN_V2) \
 	BRCMF_FEAT_DEF(PMKID_V2) \
-	BRCMF_FEAT_DEF(PMKID_V3)
+	BRCMF_FEAT_DEF(PMKID_V3) \
+	BRCMF_FEAT_DEF(SAE_EXT)
 
 /*
  * Quirks:
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index 4f76e812a860..c2d98ee6652f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -450,11 +450,14 @@ int brcmf_fweh_activate_events(struct brcmf_if *ifp)
 	brcmf_dbg(EVENT, "enable event IF\n");
 	setbit(fweh->event_mask, BRCMF_E_IF);
 
+	/* allow per-vendor method to activate firmware events */
+	if (!brcmf_fwvid_activate_events(ifp))
+		return 0;
+
 	err = brcmf_fil_iovar_data_set(ifp, "event_msgs", fweh->event_mask,
 				       fweh->event_mask_len);
 	if (err)
 		bphy_err(fweh->drvr, "Set event_msgs error (%d)\n", err);
-
 	return err;
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
index b8c773db8158..0cf933970bd1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
@@ -94,7 +94,11 @@ struct brcmf_cfg80211_info;
 	BRCMF_ENUM_DEF(FIFO_CREDIT_MAP, 74) \
 	BRCMF_ENUM_DEF(ACTION_FRAME_RX, 75) \
 	BRCMF_ENUM_DEF(TDLS_PEER_EVENT, 92) \
-	BRCMF_ENUM_DEF(BCMC_CREDIT_SUPPORT, 127)
+	BRCMF_ENUM_DEF(BCMC_CREDIT_SUPPORT, 127) \
+	BRCMF_ABSTRACT_ENUM_DEF(EXT_AUTH_REQ, 0) \
+	BRCMF_ABSTRACT_ENUM_DEF(EXT_AUTH_FRAME_RX, 1) \
+	BRCMF_ABSTRACT_ENUM_DEF(MGMT_FRAME_TXSTATUS, 2) \
+	BRCMF_ABSTRACT_ENUM_DEF(MGMT_FRAME_OFFCHAN_DONE, 3)
 
 #define BRCMF_ENUM_DEF(id, val) \
 	BRCMF_E_##id = (val),
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
index 7fe78d41f291..f3e011d090f2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
@@ -15,6 +15,7 @@ struct brcmf_fwvid_ops {
 	void (*feat_attach)(struct brcmf_if *ifp);
 	int (*set_sae_password)(struct brcmf_if *ifp, struct cfg80211_crypto_settings *crypto);
 	int (*alloc_fweh_info)(struct brcmf_pub *drvr);
+	int (*activate_events)(struct brcmf_if *ifp);
 	void (*get_cfg80211_ops)(struct brcmf_pub *drvr);
 	void (*register_event_handlers)(struct brcmf_pub *drvr);
 };
@@ -58,6 +59,16 @@ static inline int brcmf_fwvid_alloc_fweh_info(struct brcmf_pub *drvr)
 	return drvr->vops->alloc_fweh_info(drvr);
 }
 
+static inline int brcmf_fwvid_activate_events(struct brcmf_if *ifp)
+{
+	const struct brcmf_fwvid_ops *vops = ifp->drvr->vops;
+
+	if (!vops || !vops->activate_events)
+		return -EOPNOTSUPP;
+
+	return vops->activate_events(ifp);
+}
+
 static inline void brcmf_fwvid_get_cfg80211_ops(struct brcmf_pub *drvr)
 {
 	if (!drvr->vops || !drvr->vops->get_cfg80211_ops)
-- 
2.32.0


