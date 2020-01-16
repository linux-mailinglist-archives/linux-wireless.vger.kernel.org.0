Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBE513DD86
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2020 15:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgAPOeK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jan 2020 09:34:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44114 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPOeK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jan 2020 09:34:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so19468795otj.11
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2020 06:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qY1aedJ9WTrAEW7dkZt0L6T8zx7Jkw6RwprSsEBKhGA=;
        b=va4s3fRvfLY8ddXmfghd6kKYK+Dahqrw/Sl+c9IXlnJ37yhn4sykEori8nEUeFLc6D
         vjnSyo6+Vq9b3zx1J8hKXaZgV0fawmEBxVPX2rxNcr5uSGqaW8a3VL1uKC3zIVVJy/38
         EnrmgIO6Y0NdRxh7z0d5JDt/iemq5Vu1XPKZd5+A6IP+HLmnmzpv7w0g2e6jjlChACzq
         qZcK9B/VGLta+CDBCfCGtw2hIgT6nGWTiLKmY62LP/u2EpASfTOU0O2UwbjBOAgc4tMP
         /LeisF0Kq2t5sNrugdSoSAnWnWDp0DJqR7ORqqnt/CgMLzxgMf7pcFS0mJVHTGot6w6V
         1Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qY1aedJ9WTrAEW7dkZt0L6T8zx7Jkw6RwprSsEBKhGA=;
        b=DXWcl2vdvb3U4juEuPePpvq1pfJy+QpGRncoJyr3E5o56PchQ6L8GHwQM84cnhhRZX
         l9MAsVvj8U6xAfkzgSnylZNzXYSAHxXrmb3dSBg83UNNt4Zw/IZiXz/MSgGAT0B/yXeI
         jamYJXs5YFGg7+qTjE6JnD1Dat+CLce3h4ic3gSEeC9rCf/0zSGmXPa6ERzVjokelYcn
         1OM/mSEJzLU8oTtTTP6MCdS+5ZShpFaS3TMjJ2KyyZSIJMCHFHimOplmt27Os5RnAR+o
         jUT1tTTDbaOH456ztHlWj22Cw//5+3+rc+RwLjo07Z0mqYpdUjlH58OsWqnMF748v2j7
         lG/Q==
X-Gm-Message-State: APjAAAXSyVVOejUD96DnY4Iu13LtSJdeUORZ/fKEBWzR4/m9OlKKtMwd
        U8XLRWJ5Dg8SmGm/bam+ZsTxXFv4T/g=
X-Google-Smtp-Source: APXvYqz2TsWPHdy3RWSYf69cFqM+iqrT/7HcUAf007S6agmfnMKAE28x3+K5enDCxlby7VsR1HCLKA==
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr2131688oth.145.1579185249759;
        Thu, 16 Jan 2020 06:34:09 -0800 (PST)
Received: from hari-Latitude-E6430.utdallas.edu (cpe-76-184-240-102.tx.res.rr.com. [76.184.240.102])
        by smtp.gmail.com with ESMTPSA id w6sm6705298oih.19.2020.01.16.06.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 06:34:09 -0800 (PST)
From:   Hari Nagalla <hnagalla@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     mailtalm@ti.com, kvalo@codeaurora.org, hnagalla@gmail.com
Subject: [[PATCH wireless-drivers-next] 1/1] wlcore: mesh: Add support for RX Boradcast Key
Date:   Thu, 16 Jan 2020 08:33:53 -0600
Message-Id: <20200116143353.7541-2-hnagalla@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116143353.7541-1-hnagalla@gmail.com>
References: <20200116143353.7541-1-hnagalla@gmail.com>
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

