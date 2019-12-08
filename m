Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B7811619B
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2019 14:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfLHNVS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Dec 2019 08:21:18 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45186 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfLHNVS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Dec 2019 08:21:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id v10so3970881oiv.12
        for <linux-wireless@vger.kernel.org>; Sun, 08 Dec 2019 05:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qY1aedJ9WTrAEW7dkZt0L6T8zx7Jkw6RwprSsEBKhGA=;
        b=HhnqnSVnPHdwlHvQfd2Zp8wg1ITNYiZ7YsW6ihh4fb59n6IOiH+biHb3MG6aqJIYK1
         1gDZEWZnjpHjV6YGZCIrtso4GgjLamFhxoagZxjOPf/UMTUy9+yzu+TRIFnXewGkx4Px
         JqptU92qUZJQR1TA69JJFOc1SGaqSOK2F2oUSLlLPR4DMqEwkkoNdQWI9pINjyvR8X/3
         c/EAUWZJgwTh4kFIWAqY3j9Hf3Grm7rQ6VkdPk3Jwki1/fowzj8vlvcsg3ozMy5jn/I1
         tp8JmcPisDQKUCbQBHe5yTcl7qsrk343xTb7H6zh69vYWq4VJK9V9wfO1KL6Fv6UEb/y
         kRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qY1aedJ9WTrAEW7dkZt0L6T8zx7Jkw6RwprSsEBKhGA=;
        b=S3x54eX6PBz9VPjLav3/ePsmPh59JXlkkTnSgbMwMu+64nEiMUNPTN0NVHaTzvDeUl
         UpJhDhwMXRM9y/rd/6FFI4zkHcNxvX3aZp6SZo9StYJqZK8GpLNbD6PPWHBpPmvNFiZH
         0+2Xp+8g2QV7qG2TUopmBNCfkoRo1rHOh4f6ApdAfxtlTWtqvQF9tBr3pMvZkBt2CgiZ
         F9Rzobee92hLC4so4X4Z6UpQTVMPm+/IwyZgPcmGj6ClzalqX3JQBxSJx9y6Ht2IXKou
         e/n+hVmrcSgdx+RrGk28OSLpm7VwevILVTfhauhGJhvv958iFY6reFGbsVAB1YtJBte6
         uA0g==
X-Gm-Message-State: APjAAAWhjA6ON54FlCuw0eN1FnB0/v9IE8OIbACbDZmV0B6JSJ4f7Nm/
        Q15q/XDkylLTpvUpNPbBUUo=
X-Google-Smtp-Source: APXvYqyBuWvWKZ+sT8e+0/K1vmUTXWmxxP3xQxev87FuP73DlT5ln4m1DircK2wNsxCaF6hhvJvDDg==
X-Received: by 2002:aca:5c03:: with SMTP id q3mr19598566oib.173.1575811277021;
        Sun, 08 Dec 2019 05:21:17 -0800 (PST)
Received: from hari-Latitude-E6430.utdallas.edu (cpe-76-184-237-208.tx.res.rr.com. [76.184.237.208])
        by smtp.gmail.com with ESMTPSA id u11sm7361510oie.53.2019.12.08.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 05:21:16 -0800 (PST)
From:   Hari Nagalla <hnagalla@gmail.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, maitalm@ti.com, hnagalla@gmail.com
Subject: [[PATCH wireless-drivers] 1/1] wlcore: mesh: Add support for RX Boradcast Key
Date:   Sun,  8 Dec 2019 07:20:57 -0600
Message-Id: <20191208132058.5588-1-hnagalla@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Maital Hahn <maitalm@ti.com>

In order to support authentication of equals peers,
need to save RX Broadcast key per peer (on top of 1 TX broadcast key
and unicast key per peer).


Signed-off-by: Maital Hahn <maitalm@ti.com>
Acked-by: Guy Mishol <guym@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@gmail.com>
---
 drivers/net/wireless/ti/wlcore/cmd.c      |  6 ++++--
 drivers/net/wireless/ti/wlcore/cmd.h      |  2 +-
 drivers/net/wireless/ti/wlcore/main.c     | 23 +++++++++++++++--------
 drivers/net/wireless/ti/wlcore/wlcore_i.h |  1 +
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index 903968735a74..874b7ecac65f 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -1443,7 +1443,7 @@ int wl1271_cmd_set_sta_key(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 int wl1271_cmd_set_ap_key(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 			  u16 action, u8 id, u8 key_type,
 			  u8 key_size, const u8 *key, u8 hlid, u32 tx_seq_32,
-			  u16 tx_seq_16)
+			  u16 tx_seq_16, bool is_pairwise)
 {
 	struct wl1271_cmd_set_keys *cmd;
 	int ret = 0;
@@ -1458,8 +1458,10 @@ int wl1271_cmd_set_ap_key(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 			lid_type = WEP_DEFAULT_LID_TYPE;
 		else
 			lid_type = BROADCAST_LID_TYPE;
-	} else {
+	} else if (is_pairwise) {
 		lid_type = UNICAST_LID_TYPE;
+	} else {
+		lid_type = BROADCAST_LID_TYPE;
 	}
 
 	wl1271_debug(DEBUG_CRYPT, "ap key action: %d id: %d lid: %d type: %d"
diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
index 52c3b4860461..c27f1b58030c 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.h
+++ b/drivers/net/wireless/ti/wlcore/cmd.h
@@ -79,7 +79,7 @@ int wl1271_cmd_set_sta_key(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 int wl1271_cmd_set_ap_key(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 			  u16 action, u8 id, u8 key_type,
 			  u8 key_size, const u8 *key, u8 hlid, u32 tx_seq_32,
-			  u16 tx_seq_16);
+			  u16 tx_seq_16, bool is_pairwise);
 int wl12xx_cmd_set_peer_state(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 			      u8 hlid);
 int wl12xx_roc(struct wl1271 *wl, struct wl12xx_vif *wlvif, u8 role_id,
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 2ca5658bbc2a..36f6b95fc703 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -3287,7 +3287,7 @@ static void wl1271_op_configure_filter(struct ieee80211_hw *hw,
 static int wl1271_record_ap_key(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 				u8 id, u8 key_type, u8 key_size,
 				const u8 *key, u8 hlid, u32 tx_seq_32,
-				u16 tx_seq_16)
+				u16 tx_seq_16, bool is_pairwise)
 {
 	struct wl1271_ap_key *ap_key;
 	int i;
@@ -3325,6 +3325,7 @@ static int wl1271_record_ap_key(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 	ap_key->hlid = hlid;
 	ap_key->tx_seq_32 = tx_seq_32;
 	ap_key->tx_seq_16 = tx_seq_16;
+	ap_key->is_pairwise = is_pairwise;
 
 	wlvif->ap.recorded_keys[i] = ap_key;
 	return 0;
@@ -3360,7 +3361,7 @@ static int wl1271_ap_init_hwenc(struct wl1271 *wl, struct wl12xx_vif *wlvif)
 					    key->id, key->key_type,
 					    key->key_size, key->key,
 					    hlid, key->tx_seq_32,
-					    key->tx_seq_16);
+					    key->tx_seq_16, key->is_pairwise);
 		if (ret < 0)
 			goto out;
 
@@ -3383,7 +3384,8 @@ static int wl1271_ap_init_hwenc(struct wl1271 *wl, struct wl12xx_vif *wlvif)
 static int wl1271_set_key(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 		       u16 action, u8 id, u8 key_type,
 		       u8 key_size, const u8 *key, u32 tx_seq_32,
-		       u16 tx_seq_16, struct ieee80211_sta *sta)
+		       u16 tx_seq_16, struct ieee80211_sta *sta,
+		       bool is_pairwise)
 {
 	int ret;
 	bool is_ap = (wlvif->bss_type == BSS_TYPE_AP_BSS);
@@ -3410,12 +3412,12 @@ static int wl1271_set_key(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 			ret = wl1271_record_ap_key(wl, wlvif, id,
 					     key_type, key_size,
 					     key, hlid, tx_seq_32,
-					     tx_seq_16);
+					     tx_seq_16, is_pairwise);
 		} else {
 			ret = wl1271_cmd_set_ap_key(wl, wlvif, action,
 					     id, key_type, key_size,
 					     key, hlid, tx_seq_32,
-					     tx_seq_16);
+					     tx_seq_16, is_pairwise);
 		}
 
 		if (ret < 0)
@@ -3515,6 +3517,7 @@ int wlcore_set_key(struct wl1271 *wl, enum set_key_cmd cmd,
 	u16 tx_seq_16 = 0;
 	u8 key_type;
 	u8 hlid;
+	bool is_pairwise;
 
 	wl1271_debug(DEBUG_MAC80211, "mac80211 set key");
 
@@ -3564,12 +3567,14 @@ int wlcore_set_key(struct wl1271 *wl, enum set_key_cmd cmd,
 		return -EOPNOTSUPP;
 	}
 
+	is_pairwise = key_conf->flags & IEEE80211_KEY_FLAG_PAIRWISE;
+
 	switch (cmd) {
 	case SET_KEY:
 		ret = wl1271_set_key(wl, wlvif, KEY_ADD_OR_REPLACE,
 				 key_conf->keyidx, key_type,
 				 key_conf->keylen, key_conf->key,
-				 tx_seq_32, tx_seq_16, sta);
+				 tx_seq_32, tx_seq_16, sta, is_pairwise);
 		if (ret < 0) {
 			wl1271_error("Could not add or replace key");
 			return ret;
@@ -3595,7 +3600,7 @@ int wlcore_set_key(struct wl1271 *wl, enum set_key_cmd cmd,
 		ret = wl1271_set_key(wl, wlvif, KEY_REMOVE,
 				     key_conf->keyidx, key_type,
 				     key_conf->keylen, key_conf->key,
-				     0, 0, sta);
+				     0, 0, sta, is_pairwise);
 		if (ret < 0) {
 			wl1271_error("Could not remove key");
 			return ret;
@@ -6236,6 +6241,7 @@ static int wl1271_init_ieee80211(struct wl1271 *wl)
 
 	ieee80211_hw_set(wl->hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(wl->hw, CHANCTX_STA_CSA);
+	ieee80211_hw_set(wl->hw, SUPPORTS_PER_STA_GTK);
 	ieee80211_hw_set(wl->hw, QUEUE_CONTROL);
 	ieee80211_hw_set(wl->hw, TX_AMPDU_SETUP_IN_HW);
 	ieee80211_hw_set(wl->hw, AMPDU_AGGREGATION);
@@ -6280,7 +6286,8 @@ static int wl1271_init_ieee80211(struct wl1271 *wl)
 
 	wl->hw->wiphy->flags |= WIPHY_FLAG_AP_UAPSD |
 				WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
-				WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+				WIPHY_FLAG_HAS_CHANNEL_SWITCH |
++				WIPHY_FLAG_IBSS_RSN;
 
 	wl->hw->wiphy->features |= NL80211_FEATURE_AP_SCAN;
 
diff --git a/drivers/net/wireless/ti/wlcore/wlcore_i.h b/drivers/net/wireless/ti/wlcore/wlcore_i.h
index 32ec121ccac2..7ebcb563bc20 100644
--- a/drivers/net/wireless/ti/wlcore/wlcore_i.h
+++ b/drivers/net/wireless/ti/wlcore/wlcore_i.h
@@ -226,6 +226,7 @@ struct wl1271_ap_key {
 	u8 hlid;
 	u32 tx_seq_32;
 	u16 tx_seq_16;
+	bool is_pairwise;
 };
 
 enum wl12xx_flags {
-- 
2.17.1

