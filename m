Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882F1636C6A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 22:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbiKWVd7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 16:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiKWVd5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 16:33:57 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AC7A4163
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 13:33:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b8so54751edf.11
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 13:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9bTz8VHgeo8q8URZijCaaS1KYFG/IcZr1qltyg9JV4=;
        b=UVZMCKDsLbGKZ/LBcCYT9Sn3yF7BQzx7Uwph+xf/xr8v6nFC7PEvO3n/D5gpVb4FST
         5EG7kIhYVuVhkaGVsUtF+XC50IvvZQHhB7BkSRzGbXvwYFc4arly2kfgwzgGg9sorPCk
         2h9jaG1NsmVscv0+ZnHN1A5D/NQgYhuME+tbZoisZWcB8GmVtTVepQS6lLpNsz3FhXyU
         2otno6csO5uxX8/jYmUPEOL4lAE1a31sPfPlhjoAKWlmdOkS+YPw8Rhd+5R0R/GKm0NY
         KCB3aO30qDrpGLTvcyIMiid2neJ8GXgY0/qX88ppCpIXz3x7jM8EtstoEzVZEhSroWDu
         ftTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9bTz8VHgeo8q8URZijCaaS1KYFG/IcZr1qltyg9JV4=;
        b=nv3vskoD2wTAFtlqqrXPi55mYA6C9quWl24zM/2HI3ZOBm08I6G92zvSYZDvudhK+x
         +Fx1gJ9F+zKeAmU9DwZnsJxGYAiLgWuhatghYrh1vJDee3JZ4nzSgRIdO3CJzkZUeBeA
         CJ9M/1MYNLwFykHDOfl/nJmSu3P6dCMS7a+WFm6VlGmggyu4cWNQAhSZssQYMQh9eCz1
         nmhwOGsEFc2xFeytTyj3cpI27v+uYem1WcrsRuy7PmDjXjDRSaJReOPuZxt9ZNmafjvh
         jBfRBhVgIc6L6+0eL3aBYKyLscvBuYoCVOohAX8PCqQNw0NvkUqVcA9UGAQqiL8V5ZYp
         NO4w==
X-Gm-Message-State: ANoB5pnZVYR0bcrr8D6sYthJapDIOIhAwQebV8g2mRoisFZLUUMr37QQ
        uoKpmYiuMXwjvFCbpaMhnrE35dI55BU=
X-Google-Smtp-Source: AA0mqf6PTJRAbdeuKwLGlFYMC48YrcpPul7ybuZh/JzF8lCCWh2F/Hm6CQ5YBs0rJYMJ5Z3MqJKUTg==
X-Received: by 2002:aa7:c941:0:b0:469:172:4f46 with SMTP id h1-20020aa7c941000000b0046901724f46mr24670803edt.130.1669239234914;
        Wed, 23 Nov 2022 13:33:54 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id x2-20020a170906296200b00782539a02absm7600420ejd.194.2022.11.23.13.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 13:33:54 -0800 (PST)
Message-ID: <ee44c114-e7ba-797e-f7a8-8a8dde7d098a@gmail.com>
Date:   Wed, 23 Nov 2022 23:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 2/2] wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <00489244-ba7c-797a-28f0-8788a40f7974@gmail.com>
In-Reply-To: <00489244-ba7c-797a-28f0-8788a40f7974@gmail.com>
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

The ra_report struct is used for reporting the TX rate via
sta_statistics. The code which fills it out is duplicated in two
places, and the RTL8188EU will need it in a third place. Move this
code into a new function rtl8xxxu_update_ra_report.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
This patch should be applied after my other patch:
"[PATCH v2] wifi: rtl8xxxu: Fix use after rcu_read_unlock in rtl8xxxu_bss_info_changed"
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 105 ++++++++----------
 1 file changed, 45 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 1c29d0bf09e2..2c8798cb3b4b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4598,6 +4598,32 @@ static void rtl8xxxu_set_aifs(struct rtl8xxxu_priv *priv, u8 slot_time)
 	}
 }
 
+static void rtl8xxxu_update_ra_report(struct rtl8xxxu_ra_report *rarpt,
+				      u8 rate, u8 sgi, u8 bw)
+{
+	u8 mcs, nss;
+
+	rarpt->txrate.flags = 0;
+
+	if (rate < DESC_RATE_MCS0) {
+		rarpt->txrate.legacy = rtl8xxxu_legacy_ratetable[rate].bitrate;
+	} else {
+		rtl8xxxu_desc_to_mcsrate(rate, &mcs, &nss);
+		rarpt->txrate.flags |= RATE_INFO_FLAGS_MCS;
+
+		rarpt->txrate.mcs = mcs;
+		rarpt->txrate.nss = nss;
+
+		if (sgi)
+			rarpt->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+		rarpt->txrate.bw = bw;
+	}
+
+	rarpt->bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
+	rarpt->desc_rate = rate;
+}
+
 static void
 rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *bss_conf, u64 changed)
@@ -4620,9 +4646,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			u32 ramask;
 			int sgi = 0;
 			u8 highest_rate;
-			u8 mcs = 0, nss = 0;
-			u32 bit_rate;
-
+			u8 bw;
 
 			rcu_read_lock();
 			sta = ieee80211_find_sta(vif, bss_conf->bssid);
@@ -4647,37 +4671,19 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				sgi = 1;
 
 			highest_rate = fls(ramask) - 1;
-			if (highest_rate < DESC_RATE_MCS0) {
-				rarpt->txrate.legacy =
-				rtl8xxxu_legacy_ratetable[highest_rate].bitrate;
-			} else {
-				rtl8xxxu_desc_to_mcsrate(highest_rate,
-							 &mcs, &nss);
-				rarpt->txrate.flags |= RATE_INFO_FLAGS_MCS;
-
-				rarpt->txrate.mcs = mcs;
-				rarpt->txrate.nss = nss;
-
-				if (sgi) {
-					rarpt->txrate.flags |=
-						RATE_INFO_FLAGS_SHORT_GI;
-				}
-
-				if (rtl8xxxu_ht40_2g &&
-				    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
-					rarpt->txrate.bw = RATE_INFO_BW_40;
-				else
-					rarpt->txrate.bw = RATE_INFO_BW_20;
-			}
+			if (rtl8xxxu_ht40_2g &&
+			    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
+				bw = RATE_INFO_BW_40;
+			else
+				bw = RATE_INFO_BW_20;
 			rcu_read_unlock();
-			bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
-			rarpt->bit_rate = bit_rate;
-			rarpt->desc_rate = highest_rate;
+
+			rtl8xxxu_update_ra_report(rarpt, highest_rate, sgi, bw);
 
 			priv->vif = vif;
 			priv->rssi_level = RTL8XXXU_RATR_STA_INIT;
 
-			priv->fops->update_rate_mask(priv, ramask, 0, sgi, rarpt->txrate.bw == RATE_INFO_BW_40);
+			priv->fops->update_rate_mask(priv, ramask, 0, sgi, bw == RATE_INFO_BW_40);
 
 			rtl8xxxu_write8(priv, REG_BCN_MAX_ERR, 0xff);
 
@@ -5538,9 +5544,7 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 	u8 bt_info = 0;
 	struct rtl8xxxu_btcoex *btcoex;
 	struct rtl8xxxu_ra_report *rarpt;
-	u8 rate, sgi, bw;
-	u32 bit_rate;
-	u8 mcs = 0, nss = 0;
+	u8 bw;
 
 	priv = container_of(work, struct rtl8xxxu_priv, c2hcmd_work);
 	btcoex = &priv->bt_coex;
@@ -5566,36 +5570,17 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 			rtl8723bu_handle_bt_info(priv);
 			break;
 		case C2H_8723B_RA_REPORT:
-			rarpt->txrate.flags = 0;
-			rate = c2h->ra_report.rate;
-			sgi = c2h->ra_report.sgi;
-
-			if (rate < DESC_RATE_MCS0) {
-				rarpt->txrate.legacy =
-					rtl8xxxu_legacy_ratetable[rate].bitrate;
-			} else {
-				rtl8xxxu_desc_to_mcsrate(rate, &mcs, &nss);
-				rarpt->txrate.flags |= RATE_INFO_FLAGS_MCS;
+			bw = rarpt->txrate.bw;
 
-				rarpt->txrate.mcs = mcs;
-				rarpt->txrate.nss = nss;
-
-				if (sgi) {
-					rarpt->txrate.flags |=
-						RATE_INFO_FLAGS_SHORT_GI;
-				}
-
-				if (skb->len >= 2 + 7) {
-					if (c2h->ra_report.bw == RTL8XXXU_CHANNEL_WIDTH_40)
-						bw = RATE_INFO_BW_40;
-					else
-						bw = RATE_INFO_BW_20;
-					rarpt->txrate.bw = bw;
-				}
+			if (skb->len >= 2 + 7) {
+				if (c2h->ra_report.bw == RTL8XXXU_CHANNEL_WIDTH_40)
+					bw = RATE_INFO_BW_40;
+				else
+					bw = RATE_INFO_BW_20;
 			}
-			bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
-			rarpt->bit_rate = bit_rate;
-			rarpt->desc_rate = rate;
+
+			rtl8xxxu_update_ra_report(rarpt, c2h->ra_report.rate,
+						  c2h->ra_report.sgi, bw);
 			break;
 		default:
 			break;
-- 
2.38.0
