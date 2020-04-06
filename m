Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A233E19FE19
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 21:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDFTbV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 15:31:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40497 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgDFTbV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 15:31:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id s8so899982wrt.7
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2020 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/kQNHEDh/bkkqbhxX6IPyNiYGrUrfqMnrewiXgIbgrY=;
        b=vOhqM1ENZMUSvoDSwr8IPvnjPcY4EZTZOz2TArZVPVEmZcnFL/6n87z7FZCe9TJoLh
         SktLPibj1oFPhe972CrnBWs36xIUqo+mvJJLR0JTxOcg9H8gHy0g7h377Ur7zyrk1FDa
         nt19Ed0s2wQ2nLKWnqeS2SUOISnzzz3XvuaMWkyWzX+YWcf55v7+wAbgFh4arAV+N/Tl
         9tKWyzTQIgDFPR5njyDUwjm7EGnQl2Fs4N/xyTgEOJ510BGsHX7ILVMM6FCHcENh+3lH
         QwQ141HaIWKKv5203H3nizG2ltEaT0GKQUS6wr0IxizbQtvm7Fo68hhG37cN57E+5D8q
         ITsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/kQNHEDh/bkkqbhxX6IPyNiYGrUrfqMnrewiXgIbgrY=;
        b=QdVA3N/SmSgPFKVW9keZQRFNTj7yhrLiqRNg+5W+Fobl4fYAoMSp+17NQonMb77EmS
         RCmV3fdXy/JRvwWW5Kq/mtcLUYsgqwoupM1Dxbw6hjTWYQURWDYygRsLntlIwLH8U2VE
         QT/5W9OgpHtNQrStGo5ddBUavEjHq6PT+S2APxhiEJuYoSxbQ/eafaTUAgpa3V4AY/w5
         Sb2LoCM5YR+CbccXMenVRchYc7QVWw2EqhjyT16cRe+b5//gMjMp7271kI4ORfrraDM3
         Rrt39LbS0AOHBYrFHW++beVvsggL3sBymAs1cv5g10bNE4w6gu1wCb57zyaG6QB6OtJk
         psvQ==
X-Gm-Message-State: AGi0Puau/FRcp44UQVmWab19ka/HnBJbDfpYu8qC3p/LOMinB7SyoLmU
        w+cnyn6ERi7gXZVuOjovEhT68U86
X-Google-Smtp-Source: APiQypKOr55UPMB28HijqOsuCbtPXwZDrtdv/HyZ+iPOL1T8ySJhHx/bDOsRcklVbp4dpt+RB1hQ1A==
X-Received: by 2002:adf:e288:: with SMTP id v8mr774995wri.141.1586201478265;
        Mon, 06 Apr 2020 12:31:18 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.56.threembb.co.uk. [188.29.165.56])
        by smtp.gmail.com with ESMTPSA id f20sm648154wmc.35.2020.04.06.12.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 12:31:17 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/2 v2] staging: vt6556: vnt_rf_setpower convert to use
 ieee80211_channel.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <9eab9af8-fde9-1dc6-fced-95c7a36ecc01@gmail.com>
Date:   Mon, 6 Apr 2020 20:31:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_channel contains all the necessary information to change
power according to tx mode required.

vnt_rf_setpower is moved and so that vnt_rf_set_txpower the only
caller becomes static.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
v2
ARRAY_SIZE(priv->ofdm_pwr_tbl) pointing to wrong array.

 drivers/staging/vt6656/main_usb.c | 16 ++-----
 drivers/staging/vt6656/rf.c       | 79 +++++++++++++++----------------
 drivers/staging/vt6656/rf.h       |  3 +-
 drivers/staging/vt6656/wcmd.c     |  3 +-
 4 files changed, 43 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index dd89f98cc18c..3c76d3cb5bbe 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -685,15 +685,8 @@ static int vnt_config(struct ieee80211_hw *hw, u32 changed)
 			priv->bb_type = BB_TYPE_11G;
 	}
 
-	if (changed & IEEE80211_CONF_CHANGE_POWER) {
-		if (priv->bb_type == BB_TYPE_11B)
-			priv->current_rate = RATE_1M;
-		else
-			priv->current_rate = RATE_54M;
-
-		vnt_rf_setpower(priv, priv->current_rate,
-				conf->chandef.chan->hw_value);
-	}
+	if (changed & IEEE80211_CONF_CHANGE_POWER)
+		vnt_rf_setpower(priv, conf->chandef.chan);
 
 	return 0;
 }
@@ -747,9 +740,8 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 		vnt_update_pre_ed_threshold(priv, false);
 	}
 
-	if (changed & BSS_CHANGED_TXPOWER)
-		vnt_rf_setpower(priv, priv->current_rate,
-				conf->chandef.chan->hw_value);
+	if (changed & (BSS_CHANGED_TXPOWER | BSS_CHANGED_BANDWIDTH))
+		vnt_rf_setpower(priv, conf->chandef.chan);
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
 		dev_dbg(&priv->usb->dev,
diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index 4f9aba0f21b0..633e2b9aca7a 100644
--- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -537,42 +537,6 @@ int vnt_rf_write_embedded(struct vnt_private *priv, u32 data)
 	return true;
 }
 
-/* Set Tx power by rate and channel number */
-int vnt_rf_setpower(struct vnt_private *priv, u32 rate, u32 channel)
-{
-	u8 power = priv->cck_pwr;
-
-	if (channel == 0)
-		return -EINVAL;
-
-	switch (rate) {
-	case RATE_1M:
-	case RATE_2M:
-	case RATE_5M:
-	case RATE_11M:
-		channel--;
-
-		if (channel < sizeof(priv->cck_pwr_tbl))
-			power = priv->cck_pwr_tbl[channel];
-		break;
-	case RATE_6M:
-	case RATE_9M:
-	case RATE_12M:
-	case RATE_18M:
-	case RATE_24M:
-	case RATE_36M:
-	case RATE_48M:
-	case RATE_54M:
-		if (channel > CB_MAX_CHANNEL_24G)
-			power = priv->ofdm_a_pwr_tbl[channel - 15];
-		else
-			power = priv->ofdm_pwr_tbl[channel - 1];
-		break;
-	}
-
-	return vnt_rf_set_txpower(priv, power, rate);
-}
-
 static u8 vnt_rf_addpower(struct vnt_private *priv)
 {
 	s32 rssi = -priv->current_rssi;
@@ -600,7 +564,8 @@ static u8 vnt_rf_addpower(struct vnt_private *priv)
 }
 
 /* Set Tx power by power level and rate */
-int vnt_rf_set_txpower(struct vnt_private *priv, u8 power, u32 rate)
+static int vnt_rf_set_txpower(struct vnt_private *priv, u8 power,
+			      struct ieee80211_channel *ch)
 {
 	u32 power_setting = 0;
 	int ret = true;
@@ -620,7 +585,7 @@ int vnt_rf_set_txpower(struct vnt_private *priv, u8 power, u32 rate)
 
 		ret &= vnt_rf_write_embedded(priv, power_setting);
 
-		if (rate <= RATE_11M)
+		if (ch->flags & IEEE80211_CHAN_NO_OFDM)
 			ret &= vnt_rf_write_embedded(priv, 0x0001b400);
 		else
 			ret &= vnt_rf_write_embedded(priv, 0x0005a400);
@@ -630,7 +595,7 @@ int vnt_rf_set_txpower(struct vnt_private *priv, u8 power, u32 rate)
 
 		ret &= vnt_rf_write_embedded(priv, power_setting);
 
-		if (rate <= RATE_11M) {
+		if (ch->flags & IEEE80211_CHAN_NO_OFDM) {
 			ret &= vnt_rf_write_embedded(priv, 0x040c1400);
 			ret &= vnt_rf_write_embedded(priv, 0x00299b00);
 		} else {
@@ -640,7 +605,7 @@ int vnt_rf_set_txpower(struct vnt_private *priv, u8 power, u32 rate)
 		break;
 
 	case RF_AIROHA7230:
-		if (rate <= RATE_11M)
+		if (ch->flags & IEEE80211_CHAN_NO_OFDM)
 			ret &= vnt_rf_write_embedded(priv, 0x111bb900);
 		else
 			ret &= vnt_rf_write_embedded(priv, 0x221bb900);
@@ -670,8 +635,8 @@ int vnt_rf_set_txpower(struct vnt_private *priv, u8 power, u32 rate)
 		if (power >= VT3226_PWR_IDX_LEN)
 			return false;
 
-		if (rate <= RATE_11M) {
-			u16 hw_value = priv->hw->conf.chandef.chan->hw_value;
+		if (ch->flags & IEEE80211_CHAN_NO_OFDM) {
+			u16 hw_value = ch->hw_value;
 
 			power_setting = ((0x3f - power) << 20) | (0xe07 << 8);
 
@@ -716,6 +681,36 @@ int vnt_rf_set_txpower(struct vnt_private *priv, u8 power, u32 rate)
 	return ret;
 }
 
+/* Set Tx power by channel number type */
+int vnt_rf_setpower(struct vnt_private *priv,
+		    struct ieee80211_channel *ch)
+{
+	u16 channel;
+	u8 power = priv->cck_pwr;
+
+	if (!ch)
+		return -EINVAL;
+
+	/* set channel number to array number */
+	channel = ch->hw_value - 1;
+
+	if (ch->flags & IEEE80211_CHAN_NO_OFDM) {
+		if (channel < ARRAY_SIZE(priv->cck_pwr_tbl))
+			power = priv->cck_pwr_tbl[channel];
+	} else if (ch->band == NL80211_BAND_5GHZ) {
+		/* remove 14 channels to array size */
+		channel -= 14;
+
+		if (channel < ARRAY_SIZE(priv->ofdm_a_pwr_tbl))
+			power = priv->ofdm_a_pwr_tbl[channel];
+	} else {
+		if (channel < ARRAY_SIZE(priv->ofdm_pwr_tbl))
+			power = priv->ofdm_pwr_tbl[channel];
+	}
+
+	return vnt_rf_set_txpower(priv, power, ch);
+}
+
 /* Convert rssi to dbm */
 void vnt_rf_rssi_to_dbm(struct vnt_private *priv, u8 rssi, long *dbm)
 {
diff --git a/drivers/staging/vt6656/rf.h b/drivers/staging/vt6656/rf.h
index 7494546d71b8..493faaf4e2b5 100644
--- a/drivers/staging/vt6656/rf.h
+++ b/drivers/staging/vt6656/rf.h
@@ -41,8 +41,7 @@
 #define	VNT_RF_REG_LEN      0x17 /* 24 bit length */
 
 int vnt_rf_write_embedded(struct vnt_private *priv, u32 data);
-int vnt_rf_setpower(struct vnt_private *priv, u32 rate, u32 channel);
-int vnt_rf_set_txpower(struct vnt_private *priv, u8 power, u32 rate);
+int vnt_rf_setpower(struct vnt_private *priv, struct ieee80211_channel *ch);
 void vnt_rf_rssi_to_dbm(struct vnt_private *priv, u8 rssi, long *dbm);
 int vnt_rf_table_download(struct vnt_private *priv);
 
diff --git a/drivers/staging/vt6656/wcmd.c b/drivers/staging/vt6656/wcmd.c
index 2c5250ca2801..0ccc87da394e 100644
--- a/drivers/staging/vt6656/wcmd.c
+++ b/drivers/staging/vt6656/wcmd.c
@@ -122,8 +122,7 @@ void vnt_run_command(struct work_struct *work)
 
 	case WLAN_CMD_SETPOWER_START:
 
-		vnt_rf_setpower(priv, priv->current_rate,
-				priv->hw->conf.chandef.chan->hw_value);
+		vnt_rf_setpower(priv, priv->hw->conf.chandef.chan);
 
 		break;
 
-- 
2.25.1
