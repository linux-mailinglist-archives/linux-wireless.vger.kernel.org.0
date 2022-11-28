Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C7B63B250
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 20:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiK1TcR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 14:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiK1TcD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 14:32:03 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C52CE3A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 11:31:53 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id e27so28427796ejc.12
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 11:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPtWop0zQR7b6iubkYm91IKzEzaXliBDnDgM8lzYTmY=;
        b=kFU1lXRi65sTHjc8JlvI/dOGg/S5nfnzcFHjYrMeB8mlBytAW48Yk24Ab3UIYHxl+5
         UyRxmV/8u/L1RvaOC5/OhAAf3ZUAkr3hCDn20Mkpk/8QVZiqfKYOBgNiqKlJ+bRTso2V
         RoTZlBmyy5EYUVSfCWG9IbO7e0P60mIweuWozmj6/xOJKB1UTuqerxgcO7jdTY4SEcqs
         oZEo4rQOcvI9tjHmKmCvBqWqiBKjU08bPNb8gYiP5dUJ331J32TL+A8cjW3rYTjoXKdD
         L+vqKuF+TuRNs9uh9pULyng8blIgfyjtKzFWlZUESJsaFtE3Tslmd7XMi3CFRoT7Zyym
         Psdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPtWop0zQR7b6iubkYm91IKzEzaXliBDnDgM8lzYTmY=;
        b=ZWims/PLo4QleWnAzB+T4tS8QNbMpUMKoR4iobpBn05fDYhkdXil29TxaDHJOshHNJ
         3hh7fxESCab8I7CMQ/8Hl2SAz9alOY82vQtvv5Tp/N6+LLm1ycbfq3e4brTqClUNS+Ua
         WRx+MDKziAQkBPVXdxuxkVN9EwQRdhb3S5usLtEKarJjYY1TOTxjJbtGyeA7lO5PO0Oc
         aF/pSjCc07i1OLXaqRcGguOYt0e6e2TjbvTH6C1RbC5F1Nz1U00MBXtQT3ROpAj6UcYo
         BV6wIXLIUnk7cjLja5qHoT/oh46i9H5D0JcBD42fen8EZSM6wIj3z4B8Vpua4FbI1Kje
         sp0w==
X-Gm-Message-State: ANoB5pk2enZTHVXHPbNj3GunuD46uU0kNvqd2fzhQdxt/D7RhKewJuuL
        h1oWfRMakhEMzFqDoXSkOiMwz2zaM/w=
X-Google-Smtp-Source: AA0mqf5Gf/PQ4qylFcOqmNzTNlzKgw9o/Sq5CrG827TVAWRLEl4ACDfAPAMDJZGs0adnUvCeWVyJbQ==
X-Received: by 2002:a17:906:81cd:b0:7ad:beb3:91b6 with SMTP id e13-20020a17090681cd00b007adbeb391b6mr29215468ejx.159.1669663911900;
        Mon, 28 Nov 2022 11:31:51 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id hz13-20020a1709072ced00b007c00323cc23sm1571112ejc.27.2022.11.28.11.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 11:31:51 -0800 (PST)
Message-ID: <7d6ac89d-0144-1508-439a-bc8ff35c086f@gmail.com>
Date:   Mon, 28 Nov 2022 21:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 3/3] wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <d3018e30-92c6-1e73-3b63-311fc472a41f@gmail.com>
In-Reply-To: <d3018e30-92c6-1e73-3b63-311fc472a41f@gmail.com>
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
v2:
 - Compare against DESC_RATE_54M instead of DESC_RATE_MCS0.
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 107 ++++++++----------
 1 file changed, 46 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 352779fe4b78..4d067e9b9c8a 100644
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
+	if (rate <= DESC_RATE_54M) {
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
@@ -5566,37 +5570,18 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
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
-				if (skb->len > RTL8XXXU_C2H_HDR_LEN +
-					       offsetof(typeof(c2h->ra_report), bw)) {
-					if (c2h->ra_report.bw == RTL8XXXU_CHANNEL_WIDTH_40)
-						bw = RATE_INFO_BW_40;
-					else
-						bw = RATE_INFO_BW_20;
-					rarpt->txrate.bw = bw;
-				}
+			if (skb->len > RTL8XXXU_C2H_HDR_LEN +
+				       offsetof(typeof(c2h->ra_report), bw)) {
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
