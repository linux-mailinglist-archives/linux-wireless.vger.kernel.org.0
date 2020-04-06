Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36D419FD70
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 20:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgDFSrq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 14:47:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39518 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDFSrp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 14:47:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id y20so532589wma.4
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2020 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lzcBKkjxp8VNlvoc55S9INhyKVtvaQvjMFisDWaOmFc=;
        b=o4Zp5hm1A5OMVJwq3HaaoVe/Hp6/rIZDguvsv1FczUTBbCXJ0lLy6SuwpJ2TLBtzcR
         HWs6DsaynG8OSkjTfL3UrZ8zvPRfoixj6zSoIYVrK9e/SxRYsRv5JrZ7WeMVadTnJ6o0
         VemPZEYzSu7OAbHvwVycndthAzG3ueht8RBHLvCYF441m6ezQBXbfrEk8CRLoQj7Fk3u
         KfFZleagosmWEB9x0wPaYeE1/DKNLXirQsDpSBKRO5WgUQMVbiu4VELvVFqn1dOp52cj
         s5V8ptdyQnT7aG2P20BqkZ51VEBfIi68HpHjEWInTKvxkoVyy2sb+yFyFLoLMrkEb14n
         mChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lzcBKkjxp8VNlvoc55S9INhyKVtvaQvjMFisDWaOmFc=;
        b=Zg0LlKPxIZ1+EVMUZpTFQtt6t86jak+2BvH2dP5+DylrYa/CmaKY8fiuev2bJ7jUMS
         k/cMNYt/1t8wbkjtQwO9eKZ4M8OZD87sqBLb0SxL12mTjGIij3C2TBa5bLEySaXibxVm
         KcZeMK+8mRXQEKx4MYPpj0LZUGxF2o5ITuU5raT3sSRHhXCzH7A9quEqUDRQhn9+/9J2
         0FVi7AwmufZvB9+a5lGf4sSg2IRZZnnpxuNJl4sKsxoozrF5bqs72SI4dGkh79eBbbJP
         Us4QejovlDdZoWHyayGikLPRStm9KhDoQ/xqqrm8ALhPmQH77wnEU5Ive1zwZ200dPur
         yNOA==
X-Gm-Message-State: AGi0Pub7WLnw8pNOxSAwEJtK6K09ZtEL/j29LG9lAa9K/v01CllHi3xL
        oGZbUWt35H8LA9Em75YzY1z87B2k
X-Google-Smtp-Source: APiQypIEskwnx2I6rgoRkJY8/pDXIBx7JaLmEjxKhwWKhLvk5gVbRv+/hqq4h22JUaR5eOA51Cxrog==
X-Received: by 2002:a7b:c012:: with SMTP id c18mr459851wmb.22.1586198862626;
        Mon, 06 Apr 2020 11:47:42 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.56.threembb.co.uk. [188.29.165.56])
        by smtp.gmail.com with ESMTPSA id f1sm29161144wrv.37.2020.04.06.11.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 11:47:42 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/2] staging: vt6556: vnt_rf_setpower convert to use
 ieee80211_channel.
Message-ID: <6e9ffe4d-a651-d17e-ebf2-2bd6f766e6dd@gmail.com>
Date:   Mon, 6 Apr 2020 19:47:40 +0100
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
+		if (channel < ARRAY_SIZE(priv->ofdm_a_pwr_tbl))
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
