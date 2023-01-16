Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED3366C288
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 15:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjAPOpL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 09:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjAPOoX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 09:44:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DB122A16
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 06:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=5aXKx9ekDLY7c2V/bio1al5WwRNDxnxV3gmUny8Z1x0=; t=1673879058; x=1675088658; 
        b=ES5N4hiTQ5VNWW/J2OXQDM1HQFKmP7cgxP8zzVAf2w1cZlnq11skJUb05ypqBh0JR+BJ1LUx5MY
        dmXdCjmWGtz+mxB2uc+/XfkEqcHrhHy4bjb/E1+2FuoT6iMNy0VI2auLjbKscTHRN/rmMojjrvVUh
        LbQBOyrySN8Ws61HYcPchatgA7Cb8lrLOdPEpUxqK+Y10zWTlXx6u5hDVaNnQHiRgEfUBRYuieRUE
        czD+CQyh2xMMDIHKTaiLasCt/3WAkjmBgAUbWQkSomXBAEGYtxqEmIzy3lDI3AYm56YMiV0o3cZkC
        ADluBH3nQP8fakifYbGyp7FHmOigEC+aqK6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pHQPG-003fmf-2k;
        Mon, 16 Jan 2023 15:24:14 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: cfg80211: remove support for static WEP
Date:   Mon, 16 Jan 2023 15:24:11 +0100
Message-Id: <20230116152410.74d6e0b30855.I979e28022c78c3602d113a9237522dc16111f213@changeid>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This reverts commit b8676221f00d ("cfg80211: Add support for
static WEP in the driver") since no driver ever ended up using
it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h     | 9 ---------
 net/wireless/core.h        | 4 ++--
 net/wireless/ibss.c        | 5 ++---
 net/wireless/sme.c         | 6 +-----
 net/wireless/util.c        | 2 +-
 net/wireless/wext-compat.c | 2 +-
 net/wireless/wext-sme.c    | 2 +-
 7 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 03d4f4deadae..1f8f827290a2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1075,7 +1075,6 @@ struct survey_info {
 	s8 noise;
 };
 
-#define CFG80211_MAX_WEP_KEYS	4
 #define CFG80211_MAX_NUM_AKM_SUITES	10
 
 /**
@@ -1099,9 +1098,6 @@ struct survey_info {
  *	port frames over NL80211 instead of the network interface.
  * @control_port_no_preauth: disables pre-auth rx over the nl80211 control
  *	port for mac80211
- * @wep_keys: static WEP keys, if not NULL points to an array of
- *	CFG80211_MAX_WEP_KEYS WEP keys
- * @wep_tx_key: key index (0..3) of the default TX static WEP key
  * @psk: PSK (for devices supporting 4-way-handshake offload)
  * @sae_pwd: password for SAE authentication (for devices supporting SAE
  *	offload)
@@ -1134,8 +1130,6 @@ struct cfg80211_crypto_settings {
 	bool control_port_no_encrypt;
 	bool control_port_over_nl80211;
 	bool control_port_no_preauth;
-	struct key_params *wep_keys;
-	int wep_tx_key;
 	const u8 *psk;
 	const u8 *sae_pwd;
 	u8 sae_pwd_len;
@@ -4683,8 +4677,6 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_SUPPORTS_5_10_MHZ: Device supports 5 MHz and 10 MHz channels.
  * @WIPHY_FLAG_HAS_CHANNEL_SWITCH: Device supports channel switch in
  *	beaconing mode (AP, IBSS, Mesh, ...).
- * @WIPHY_FLAG_HAS_STATIC_WEP: The device supports static WEP key installation
- *	before connection.
  * @WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK: The device supports bigger kek and kck keys
  * @WIPHY_FLAG_SUPPORTS_MLO: This is a temporary flag gating the MLO APIs,
  *	in order to not have them reachable in normal drivers, until we have
@@ -4715,7 +4707,6 @@ enum wiphy_flags {
 	WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL	= BIT(21),
 	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
-	WIPHY_FLAG_HAS_STATIC_WEP		= BIT(24),
 };
 
 /**
diff --git a/net/wireless/core.h b/net/wireless/core.h
index af85d8909935..7c61752f6d83 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -278,8 +278,8 @@ struct cfg80211_event {
 };
 
 struct cfg80211_cached_keys {
-	struct key_params params[CFG80211_MAX_WEP_KEYS];
-	u8 data[CFG80211_MAX_WEP_KEYS][WLAN_KEY_LEN_WEP104];
+	struct key_params params[4];
+	u8 data[4][WLAN_KEY_LEN_WEP104];
 	int def;
 };
 
diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index edd062f104f4..e6fdb0b8187d 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -45,8 +45,7 @@ void __cfg80211_ibss_joined(struct net_device *dev, const u8 *bssid,
 	cfg80211_hold_bss(bss_from_pub(bss));
 	wdev->u.ibss.current_bss = bss_from_pub(bss);
 
-	if (!(wdev->wiphy->flags & WIPHY_FLAG_HAS_STATIC_WEP))
-		cfg80211_upload_connect_keys(wdev);
+	cfg80211_upload_connect_keys(wdev);
 
 	nl80211_send_ibss_bssid(wiphy_to_rdev(wdev->wiphy), dev, bssid,
 				GFP_KERNEL);
@@ -294,7 +293,7 @@ int cfg80211_ibss_wext_join(struct cfg80211_registered_device *rdev,
 		ck = kmemdup(wdev->wext.keys, sizeof(*ck), GFP_KERNEL);
 		if (!ck)
 			return -ENOMEM;
-		for (i = 0; i < CFG80211_MAX_WEP_KEYS; i++)
+		for (i = 0; i < 4; i++)
 			ck->params[i].key = ck->data[i];
 	}
 	err = __cfg80211_join_ibss(rdev, wdev->netdev,
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 4b5b6ee0fe01..123248b2c0be 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -855,8 +855,7 @@ void __cfg80211_connect_result(struct net_device *dev,
 			       ETH_ALEN);
 	}
 
-	if (!(wdev->wiphy->flags & WIPHY_FLAG_HAS_STATIC_WEP))
-		cfg80211_upload_connect_keys(wdev);
+	cfg80211_upload_connect_keys(wdev);
 
 	rcu_read_lock();
 	for_each_valid_link(cr, link) {
@@ -1462,9 +1461,6 @@ int cfg80211_connect(struct cfg80211_registered_device *rdev,
 				connect->crypto.ciphers_pairwise[0] = cipher;
 			}
 		}
-
-		connect->crypto.wep_keys = connkeys->params;
-		connect->crypto.wep_tx_key = connkeys->def;
 	} else {
 		if (WARN_ON(connkeys))
 			return -EINVAL;
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 8f403f9fe816..38d3b434c18c 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -934,7 +934,7 @@ void cfg80211_upload_connect_keys(struct wireless_dev *wdev)
 	if (!wdev->connect_keys)
 		return;
 
-	for (i = 0; i < CFG80211_MAX_WEP_KEYS; i++) {
+	for (i = 0; i < 4; i++) {
 		if (!wdev->connect_keys->params[i].cipher)
 			continue;
 		if (rdev_add_key(rdev, dev, -1, i, false, NULL,
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 8a24dfca75af..e3acfac7430a 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -439,7 +439,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 					  GFP_KERNEL);
 		if (!wdev->wext.keys)
 			return -ENOMEM;
-		for (i = 0; i < CFG80211_MAX_WEP_KEYS; i++)
+		for (i = 0; i < 4; i++)
 			wdev->wext.keys->params[i].key =
 				wdev->wext.keys->data[i];
 	}
diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index 191c6d98c700..f231207ca210 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -47,7 +47,7 @@ int cfg80211_mgd_wext_connect(struct cfg80211_registered_device *rdev,
 		ck = kmemdup(wdev->wext.keys, sizeof(*ck), GFP_KERNEL);
 		if (!ck)
 			return -ENOMEM;
-		for (i = 0; i < CFG80211_MAX_WEP_KEYS; i++)
+		for (i = 0; i < 4; i++)
 			ck->params[i].key = ck->data[i];
 	}
 
-- 
2.39.0

