Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9463563F287
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 15:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiLAORJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 09:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiLAOQz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 09:16:55 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C366C772E
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 06:16:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n21so4503487ejb.9
        for <linux-wireless@vger.kernel.org>; Thu, 01 Dec 2022 06:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STb+sPRtYWrwfCr/0tHysWYugsD8ylDQo+47qVzVecE=;
        b=k2oClJXUSNuu+qb3t+Q92hx/T/GSNcULDQzlFewr+cGazX/+cESA4plcQxiOT3oOrv
         7SBXxlKumuxAwB7NkLEkt7bkbI/KGSxVskWm3ptA0by/rjC5QEpXeNqmn0knEiFuMCTh
         Sv09i5mVPLnuwUGxDc9LxbViwDnj/hD/FfkTgy3SfxNmwk0gxrxPYPm5nV4A6wNhJbtU
         L1qJSSPg4wZ3rxvZKcBj6/cDmfvPU+u8yJMo9lfDOc4ggsS63FUpiljiaUF0jak+0C2j
         wIbb45wuIUALRxFBGEvlvZK5aS88LW/uHdDNpbSKB0ngDWiAsHdYznZJoSQtzdRr0i6l
         slwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STb+sPRtYWrwfCr/0tHysWYugsD8ylDQo+47qVzVecE=;
        b=ZqU9rVBe8rG7nk7FAT0A4sMbgV+segbzJ3kM0AbTWr89pJk06ZAd0IWLJT3Y9LGAEb
         OVhBuUCd5ikcs2xkFuJ569Bo0GnbO75v3G4v6aA/8sxTDuuhv1hOgeAhdMWMzxJJw1oK
         SY8498gHWd4ayNnzUf7ugUuqQOt3zJqNWF+8HkuDzYTMlrwFwvB5qqn56/5uwOXepTU2
         RfVywFPUG2KbIs/G861D04GZ4j1liS54AUXDqB2I2GNHQrUJ04C2Zc6vy1wXWQ+p2x71
         YcED77za5XVgSlrMJhU7OrUwV0yPU8OBw4I03ZF128JjZzF+LA1PT5xR1cDpUTaPXp3s
         iKEg==
X-Gm-Message-State: ANoB5pnyhOQ2liml0+jf2zTqNymz16703EDtcjHxLNyJ5d7y56yMTxG/
        eVSp2QuuqaRh1Ugf20D8Oa8ygwTW3p8=
X-Google-Smtp-Source: AA0mqf7hIkODKIbvW/qs6F3UWEKQ3Sj3dlQNy6svExBXGhTADmkwZHHPSWtlgNJ2O2aDSVgEI/fyFg==
X-Received: by 2002:a17:906:a11a:b0:7c0:9cb9:bac8 with SMTP id t26-20020a170906a11a00b007c09cb9bac8mr7652840ejy.25.1669904207066;
        Thu, 01 Dec 2022 06:16:47 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id j3-20020a170906410300b0077a201f6d1esm1821403ejk.87.2022.12.01.06.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:16:46 -0800 (PST)
Message-ID: <0777ad35-fe03-473c-2e02-e3390bef5dd0@gmail.com>
Date:   Thu, 1 Dec 2022 16:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v4 3/3] wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com>
In-Reply-To: <1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com>
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
v4:
 - No change.

v3:
 - No change.

v2:
 - Compare against DESC_RATE_54M instead of DESC_RATE_MCS0.
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 105 ++++++++----------
 1 file changed, 45 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 7ca46fb77a3b..3ed435401e57 100644
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
-				if (skb->len >= offsetofend(typeof(*c2h), ra_report.bw)) {
-					if (c2h->ra_report.bw == RTL8XXXU_CHANNEL_WIDTH_40)
-						bw = RATE_INFO_BW_40;
-					else
-						bw = RATE_INFO_BW_20;
-					rarpt->txrate.bw = bw;
-				}
+			if (skb->len >= offsetofend(typeof(*c2h), ra_report.bw)) {
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
