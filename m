Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4D5BBDD1
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Sep 2022 14:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIRMmb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 08:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIRMma (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 08:42:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EB61903C
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 05:42:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x94so20261177ede.11
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Pe+lKAHTh4S8T/+iKIxBR+/8tWoiFnTfIU4oElFDrk0=;
        b=qWc/AekKv5S/6PwX7lKVMHHCkiYVKB3SjuaoXqz6c83Nz0fMOQOaUnXTtXLc122Z/Q
         FkdDZGh19ompP9G6dcQo2ToiYs5jYsVVqscqlqot+BDcYlqace1I+G/YP3JmWoqMiWOa
         KBt7SfEOPgrdH0sGT4pm4bbOwIByv0JNzwwdhrwyTQvQHFbh4/czazA2Lnd7vNlSKUJN
         nNG0cHmcAh8ejcz5aEJvP9v+ocGl6V0w+Hp+96DSuHE3Z8CgWAO+JcDTnljl2aYMBvA4
         X14FII+o64zWSo8MNXwn16+97DpViOICghizmBn+H3EqsWRrKS3JJcMu5/SCINLZOV3a
         seAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Pe+lKAHTh4S8T/+iKIxBR+/8tWoiFnTfIU4oElFDrk0=;
        b=sFJULxQh/TxnOPFWBfMV0HyPuD5ZjPSUlzYKWoxgM95ra9gP91+iZZ+VNMneVSsQI8
         1xY+M+FpEvZ/fw1Hezbu5+ME88+BcJQ5BQ2veKwvRWA+ExyCbtgW2PG0oZcT3FrIK6rw
         CQoUIECuRaVeYE+/byhGHWCjZLdR5a1pEVSOl2LuAQpvpgmm1uH8iEGOVBJPjCwK16CT
         WBpVww+y14XtuggCn9WOY78wQd/bQyzn3R8g/6ZmJbFMTIZIzl16CWdnW7w3Yrm+GYvv
         OABA8lRAsFKOyMBj/DZptrQxwuxcABT+0GbJrL05w8//usCRGnXSKWI2f1n6lIROz5Gn
         8BdA==
X-Gm-Message-State: ACrzQf15jIeJOrrXZzvNBZ6vq4MWk8L/Ux8Y1mbKJIv1ZdQUWG75oDHN
        PSEB+HoZAgZckxyHDVYtRYMmnjVZIPg=
X-Google-Smtp-Source: AMsMyM67POi1tJ90WqmJRaCnRoJoO6uzAr6Cwme45iuCyBXl0iUWwp3dUIcPpGeQJS4dsu92Rz8a+Q==
X-Received: by 2002:a05:6402:448b:b0:43b:5ec6:8863 with SMTP id er11-20020a056402448b00b0043b5ec68863mr11328628edb.377.1663504947567;
        Sun, 18 Sep 2022 05:42:27 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id d12-20020aa7d5cc000000b0044e937ddcabsm17872402eds.77.2022.09.18.05.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 05:42:27 -0700 (PDT)
Message-ID: <038cc03f-3567-77ba-a7bd-c4930e3b2fad@gmail.com>
Date:   Sun, 18 Sep 2022 15:42:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: [PATCH 3/4] wifi: rtl8xxxu: Fix AIFS written to REG_EDCA_*_PARAM
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

ieee80211_tx_queue_params.aifs is not supposed to be written directly
to the REG_EDCA_*_PARAM registers. Instead process it like the vendor
drivers do. It's kinda hacky but it works.

This change boosts the download speed and makes it more stable.

Tested with RTL8188FU but all the other supported chips should also
benefit.

Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 7724ee8033a8..9ddff43b5cfc 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4656,6 +4656,53 @@ rtl8xxxu_wireless_mode(struct ieee80211_hw *hw, struct ieee80211_sta *sta)
 	return network_type;
 }
 
+static void rtl8xxxu_set_aifs(struct rtl8xxxu_priv *priv, u8 slot_time)
+{
+	u32 reg_edca_param[IEEE80211_NUM_ACS] = {
+		[IEEE80211_AC_VO] = REG_EDCA_VO_PARAM,
+		[IEEE80211_AC_VI] = REG_EDCA_VI_PARAM,
+		[IEEE80211_AC_BE] = REG_EDCA_BE_PARAM,
+		[IEEE80211_AC_BK] = REG_EDCA_BK_PARAM,
+	};
+	u32 val32;
+	u16 wireless_mode = 0;
+	u8 aifs, aifsn, sifs;
+	int i;
+
+	if (priv->vif) {
+		struct ieee80211_sta *sta;
+
+		rcu_read_lock();
+		sta = ieee80211_find_sta(priv->vif, priv->vif->bss_conf.bssid);
+		if (sta)
+			wireless_mode = rtl8xxxu_wireless_mode(priv->hw, sta);
+		rcu_read_unlock();
+	}
+
+	if (priv->hw->conf.chandef.chan->band == NL80211_BAND_5GHZ ||
+	    (wireless_mode & WIRELESS_MODE_N_24G))
+		sifs = 16;
+	else
+		sifs = 10;
+
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		val32 = rtl8xxxu_read32(priv, reg_edca_param[i]);
+
+		/* It was set in conf_tx. */
+		aifsn = val32 & 0xff;
+
+		/* aifsn not set yet or already fixed */
+		if (aifsn < 2 || aifsn > 15)
+			continue;
+
+		aifs = aifsn * slot_time + sifs;
+
+		val32 &= ~0xff;
+		val32 |= aifs;
+		rtl8xxxu_write32(priv, reg_edca_param[i], val32);
+	}
+}
+
 static void
 rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *bss_conf, u64 changed)
@@ -4775,6 +4822,8 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		else
 			val8 = 20;
 		rtl8xxxu_write8(priv, REG_SLOT, val8);
+
+		rtl8xxxu_set_aifs(priv, val8);
 	}
 
 	if (changed & BSS_CHANGED_BSSID) {
-- 
2.37.2
