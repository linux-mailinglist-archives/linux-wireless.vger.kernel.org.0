Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F16B1C24AC
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2020 13:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgEBLUR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 May 2020 07:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726741AbgEBLUR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 May 2020 07:20:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F88C061A0C
        for <linux-wireless@vger.kernel.org>; Sat,  2 May 2020 04:20:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so9793295wra.7
        for <linux-wireless@vger.kernel.org>; Sat, 02 May 2020 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zG92LUO0XKhl+2rKG8DLuLjU1DQt2zx+8L0OU1LdhEg=;
        b=CajDlDompy/b7v/KVRpoPSuTyFN6imZedHipJVWvDbARZcR7D4O4A8D+oyFNS4/4yl
         LEC7fkKEA9MiPWJ8fefGXvp9r8xfIGPwoX3YDJsM6geogeOiMFGpV5w8QCJAdIFinTkA
         XtIH31W+jf2kxGao58jqf9y6uZ2jTwxNv6TaMlYuFPuTS//lbrWP/nLZET73qo/anki5
         pQZzOpjqaj+sEp657osnWPMORd3l5ur0KA35vqIPdNltxllVhVBWxJxnFXyZgIrfPjgf
         joiPK4QrQbanEKg1dABYB+tF9+sER2yP6LwCjbpknWHRCxlSuMdjHFx3hiLkV3v9slr7
         kxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zG92LUO0XKhl+2rKG8DLuLjU1DQt2zx+8L0OU1LdhEg=;
        b=hcKfhX74gwnQJJ6X6mpEXWnidAyZe4XyDC6PQCC59FVHb+/3UnNFjHTQ7FgFC0pvG8
         qhSU637rhXmhwZPeYdBK/QHtSq2091iXkSb0U/oyQkV6CTXolm51zjWOzmQsS0IamkKa
         btuU01mSrI0UYX1UrZWodCzFgEgmsPifcxijJVeKEqdyYEzOIjcgxJQPThMMbnq0eR4Z
         yVEueCx+J7F8452XlHX5jW1586r0pCXBAVpqUXET83iBgaPulMzeaJ9ia2ynLUxa6F7g
         lLveBmDoL417gTMbuI6XDoGGbHSnIv+nyVIufIA273MZ9rgf+wYMRpy6ka0T0Hfy065M
         JA0g==
X-Gm-Message-State: AGi0PuasBJa7+Po8MyLyTtOu8MZicTu/jBBjL3W1Ja4aisX7OgA0ftLI
        QVShyD20Gw+tXr913IrXaEw=
X-Google-Smtp-Source: APiQypIq19iGDKSKYpeZF07PAnvlfWy0/zba4sLjDHej3+RyEDXWoQV9A4crYF20ogkLiGKD4TMVxw==
X-Received: by 2002:adf:f48a:: with SMTP id l10mr8514091wro.231.1588418415682;
        Sat, 02 May 2020 04:20:15 -0700 (PDT)
Received: from [192.168.43.18] (94.197.121.192.threembb.co.uk. [94.197.121.192])
        by smtp.gmail.com with ESMTPSA id s11sm8867679wrp.79.2020.05.02.04.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 04:20:15 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH v2] staging: vt6656: refactor power save operation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Message-ID: <5a188bd8-7049-8063-f24d-96768ce9a6ed@gmail.com>
Date:   Sat, 2 May 2020 12:20:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

At present the power save wake uses the listening interval and
the slow path to wake up.

The following using a beacon interval of 100 and
listen interval of 5.

The TBTT set at 100 wake-up sequence;
100 TBTT wake-up set to listen interval.
200 TBTT
300 TBTT
400 TBTT --> call vnt_next_tbtt_wakeup on slow path
	Beacon heard and passed through at the approx 500 interval.
500 TBTT
600 TBTT wake-up set to listen interval

The TBTT set at 500 wake-up sequence and always listen flagged on;
100 No TBTT
200 No TBTT
300 No TBTT
400 No TBTT
500 TBTT - beacon heard and passed through
600 No TBTT

A further enhancement because the TBTT is more precise
the dtim_period can be used instead.

When Power save is off the TBTT continues to run at the listen
interval but all the other beacons are passed.

The code in vnt_int_process_data is no longer required. 

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
v2 Corrected TTBT to TBTT
 
 drivers/staging/vt6656/device.h   |  2 --
 drivers/staging/vt6656/main_usb.c | 11 +++++++++--
 drivers/staging/vt6656/power.c    | 12 ++----------
 drivers/staging/vt6656/usbpipe.c  | 13 -------------
 4 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index 4d596853a3ee..d19d802b5d4f 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -383,8 +383,6 @@ struct vnt_private {
 	u8 bb_pre_ed_rssi;
 	u8 bb_pre_ed_index;
 
-	u16 wake_up_count;
-
 	/* command timer */
 	struct delayed_work run_command_work;
 
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 7db1e044ad26..b5790d4d7152 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -824,10 +824,17 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & (BSS_CHANGED_ASSOC | BSS_CHANGED_BEACON_INFO) &&
 	    priv->op_mode != NL80211_IFTYPE_AP) {
 		if (conf->assoc && conf->beacon_rate) {
+			u16 ps_beacon_int = conf->beacon_int;
+
+			if (conf->dtim_period)
+				ps_beacon_int *= conf->dtim_period;
+			else if (hw->conf.listen_interval)
+				ps_beacon_int *= hw->conf.listen_interval;
+
 			vnt_mac_reg_bits_on(priv, MAC_REG_TFTCTL,
 					    TFTCTL_TSFCNTREN);
 
-			vnt_mac_set_beacon_interval(priv, conf->beacon_int);
+			vnt_mac_set_beacon_interval(priv, ps_beacon_int);
 
 			vnt_reset_next_tbtt(priv, conf->beacon_int);
 
@@ -835,7 +842,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 				       conf->sync_tsf, priv->current_tsf);
 
 			vnt_update_next_tbtt(priv,
-					     conf->sync_tsf, conf->beacon_int);
+					     conf->sync_tsf, ps_beacon_int);
 		} else {
 			vnt_clear_current_tsf(priv);
 
diff --git a/drivers/staging/vt6656/power.c b/drivers/staging/vt6656/power.c
index d160a0773943..2f49c870272a 100644
--- a/drivers/staging/vt6656/power.c
+++ b/drivers/staging/vt6656/power.c
@@ -63,16 +63,8 @@ void vnt_enable_power_saving(struct vnt_private *priv, u16 listen_interval)
 	 */
 	vnt_mac_reg_bits_on(priv, MAC_REG_PSCTL, PSCTL_GO2DOZE);
 
-	if (listen_interval >= 2) {
-		/* clear always listen beacon */
-		vnt_mac_reg_bits_off(priv, MAC_REG_PSCTL, PSCTL_ALBCN);
-
-		/* first time set listen next beacon */
-		vnt_mac_reg_bits_on(priv, MAC_REG_PSCTL, PSCTL_LNBCN);
-	} else {
-		/* always listen beacon */
-		vnt_mac_reg_bits_on(priv, MAC_REG_PSCTL, PSCTL_ALBCN);
-	}
+	/* always listen beacon */
+	vnt_mac_reg_bits_on(priv, MAC_REG_PSCTL, PSCTL_ALBCN);
 
 	dev_dbg(&priv->usb->dev,  "PS:Power Saving Mode Enable...\n");
 }
diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index e8efdeadb1a7..5603f3cbb33c 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -202,19 +202,6 @@ static void vnt_int_process_data(struct vnt_private *priv)
 	if (int_data->isr0 & ISR_BNTX && priv->op_mode == NL80211_IFTYPE_AP)
 		vnt_schedule_command(priv, WLAN_CMD_BECON_SEND);
 
-	if (int_data->isr0 & ISR_TBTT &&
-	    priv->hw->conf.flags & IEEE80211_CONF_PS) {
-		if (!priv->wake_up_count)
-			priv->wake_up_count = priv->hw->conf.listen_interval;
-
-		if (priv->wake_up_count)
-			--priv->wake_up_count;
-
-		/* Turn on wake up to listen next beacon */
-		if (priv->wake_up_count == 1)
-			vnt_schedule_command(priv, WLAN_CMD_TBTT_WAKEUP);
-	}
-
 	priv->current_tsf = le64_to_cpu(int_data->tsf);
 
 	low_stats->dot11RTSSuccessCount += int_data->rts_success;
-- 
2.25.1
