Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106F85BBDCF
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Sep 2022 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIRMlB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 08:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIRMlA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 08:41:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB771903C
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 05:40:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kr11so12672905ejc.8
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ol3m7tPzMVUdI+Aj6IXO2rMbqkG9zYPIL/c2H+8ACYo=;
        b=jX0YapcnH8bOld3HtGUAn8SLFJxXpTHwShWEQMhFRhQYYy6MfVPKsLOWp1VrcDpgAK
         teFbqCNf4ovn5NuacLeow21W/CUY7qoDFFHsO9YAYLDYlRo1euZAPdqxoLL0pSpkoKOJ
         IrF76TLJlFehrsnrkSIJ1kBj8JEvU/K3kIq2NBWo2KUOW5mUz21fwrv4L2h5HNBM6wh3
         AnOIXpOsFT4uX1ErpcHF92OWLCzCy6fYY0Ca++25eTRlyEgzKUbhT5dRcX4JIjCE0qaH
         +/COZ9KRNfeqVNjKJygGWdRZnHKhnbB8oDzMt24A0UMbotd/pbCDgPI9R7FtDkkh9nKj
         0/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ol3m7tPzMVUdI+Aj6IXO2rMbqkG9zYPIL/c2H+8ACYo=;
        b=f+hOB+5LuZT8pNynmM3bYD+9o6D81lbWjt9S1B/3xqdNvfC5N4a57FHHcSO+tPxXDR
         zYXOr2CDvdr5hhrGQ1JMFxmiv7tuHjz9wKD4RvEtmZt4ZCUurXoVXEMCelw3lQiijnUi
         w6cxypY3VOekZ5gBh7f6s4+WrA2OuvmMFz9WwSqCJSYuyVCkzBae/8fh64VW0B3FsZCs
         1Xti37TWhDQnWRT7DfZm9BI4xETsiNDq/sC9No1tHbviMUlaSc4sufJhXpdByM3WBuY7
         BN/in66bvTj7K/ufp32CMnX98gFf0yOJLX7Of+eZxXr5LXAvxu64XJYjgAApuL3Yku2i
         3LYw==
X-Gm-Message-State: ACrzQf3ldk/PHPWBCwNYjOAmRqTVeiizNXlCcEdOSYO6UbVTYh6FHiCE
        1AG5vb0ujGMbv+PskjTj18+j4e7lMro=
X-Google-Smtp-Source: AMsMyM6oeCWtGqqSyGvxFCSbIk747fV+QGAX2tAILbs2+Fo+K6ivKjyf6mJc0mFMMtKooXHplINF9g==
X-Received: by 2002:a17:906:8a77:b0:780:a02d:ca4a with SMTP id hy23-20020a1709068a7700b00780a02dca4amr8349357ejc.488.1663504857727;
        Sun, 18 Sep 2022 05:40:57 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id kx24-20020a170907775800b0073d5948855asm13695651ejc.1.2022.09.18.05.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 05:40:57 -0700 (PDT)
Message-ID: <3a950997-7580-8a6b-97a0-e0a81a135456@gmail.com>
Date:   Sun, 18 Sep 2022 15:40:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: [PATCH 2/4] wifi: rtl8xxxu: gen2: Enable 40 MHz channel width
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     linux-wireless@vger.kernel.org
References: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>, chris.chiu@canonical.com
In-Reply-To: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The module parameter ht40_2g was supposed to enable 40 MHz operation,
but it didn't.

Tell the firmware about the channel width when updating the rate mask.
This makes it work with my gen 2 chip RTL8188FU.

I'm not sure if anything needs to be done for the gen 1 chips, if 40
MHz channel width already works or not. They update the rate mask with
a different structure which doesn't have a field for the channel width.

Also set the channel width correctly for sta_statistics.

Fixes: f653e69009c6 ("rtl8xxxu: Implement basic 8723b specific update_rate_mask() function")
Fixes: bd917b3d28c9 ("rtl8xxxu: fill up txrate info for gen1 chips")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  6 +++---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 21 +++++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 501900c07fac..9950a2ee00aa 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1477,7 +1477,7 @@ struct rtl8xxxu_fileops {
 	void (*set_tx_power) (struct rtl8xxxu_priv *priv, int channel,
 			      bool ht40);
 	void (*update_rate_mask) (struct rtl8xxxu_priv *priv,
-				  u32 ramask, u8 rateid, int sgi);
+				  u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
 	void (*report_connect) (struct rtl8xxxu_priv *priv,
 				u8 macid, bool connect);
 	void (*fill_txdesc) (struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
@@ -1565,9 +1565,9 @@ void rtl8xxxu_gen2_config_channel(struct ieee80211_hw *hw);
 void rtl8xxxu_gen1_usb_quirks(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen2_usb_quirks(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
-			       u32 ramask, u8 rateid, int sgi);
+			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
 void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
-				    u32 ramask, u8 rateid, int sgi);
+				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
 void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
 				  u8 macid, bool connect);
 void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 7978d5dcc826..7724ee8033a8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4407,7 +4407,7 @@ static void rtl8xxxu_sw_scan_complete(struct ieee80211_hw *hw,
 }
 
 void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
-			       u32 ramask, u8 rateid, int sgi)
+			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
 {
 	struct h2c_cmd h2c;
 
@@ -4427,10 +4427,15 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
 }
 
 void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
-				    u32 ramask, u8 rateid, int sgi)
+				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
 {
 	struct h2c_cmd h2c;
-	u8 bw = RTL8XXXU_CHANNEL_WIDTH_20;
+	u8 bw;
+
+	if (txbw_40mhz)
+		bw = RTL8XXXU_CHANNEL_WIDTH_40;
+	else
+		bw = RTL8XXXU_CHANNEL_WIDTH_20;
 
 	memset(&h2c, 0, sizeof(struct h2c_cmd));
 
@@ -4717,7 +4722,11 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 						RATE_INFO_FLAGS_SHORT_GI;
 				}
 
-				rarpt->txrate.bw |= RATE_INFO_BW_20;
+				if (rtl8xxxu_ht40_2g &&
+				    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
+					rarpt->txrate.bw = RATE_INFO_BW_40;
+				else
+					rarpt->txrate.bw = RATE_INFO_BW_20;
 			}
 			bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
 			rarpt->bit_rate = bit_rate;
@@ -4726,7 +4735,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			priv->vif = vif;
 			priv->rssi_level = RTL8XXXU_RATR_STA_INIT;
 
-			priv->fops->update_rate_mask(priv, ramask, 0, sgi);
+			priv->fops->update_rate_mask(priv, ramask, 0, sgi, rarpt->txrate.bw == RATE_INFO_BW_40);
 
 			rtl8xxxu_write8(priv, REG_BCN_MAX_ERR, 0xff);
 
@@ -6440,7 +6449,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
 		}
 
 		priv->rssi_level = rssi_level;
-		priv->fops->update_rate_mask(priv, rate_bitmap, ratr_idx, sgi);
+		priv->fops->update_rate_mask(priv, rate_bitmap, ratr_idx, sgi, txbw_40mhz);
 	}
 }
 
-- 
2.37.2
