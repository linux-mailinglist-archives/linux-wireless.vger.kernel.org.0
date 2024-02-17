Return-Path: <linux-wireless+bounces-3730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4F859298
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Feb 2024 21:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE431C2084B
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Feb 2024 20:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE20134BC;
	Sat, 17 Feb 2024 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9ygGRHF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DF6320E
	for <linux-wireless@vger.kernel.org>; Sat, 17 Feb 2024 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201187; cv=none; b=pP+2RpF18nSnD2rUPb26utQccENQiLavQDFP8V95hPuLAeW7Gord1/I0/vk+k8qJopqSBzPO+m72JSilbnRU+MIq/1Q+/nC/E3OQAshdrhkxW1TAqhBXVpSTWOQblYARLaz4lhNzpmmwBlkKlkgKv7JrkdvVy4L6yETnHPIw/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201187; c=relaxed/simple;
	bh=hPb4FZl/T3pmCBYp9ugPzC5Iz+xAE0CGMkZx4Mfzb4Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tJDG8Etk7WTJiS1iYT10syS3SH4SEolKfFeLJVGO631//ZXVxSXmc3uIM0krIjkeFo7pYqX5tzmjiIje9SKxzmzxOC7EBs5J3Ib115PXgCUIsg2FNjEnwvDhcaOnqOVpR4R8YaVrWyw+Zlt0+exJc09y72OJzWbh0NWdWtMjQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9ygGRHF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41260f946d9so601185e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 17 Feb 2024 12:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708201184; x=1708805984; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QP16I4Eg4fBq+C35kywoPdGn1esk8Vi4j1BhzgZtn0=;
        b=G9ygGRHF9Zo3UpHQJUSB0t1Qnct0xTXVFCxzRQNJfTknMQhXqQaOAzVrIvHp3knCu7
         0ZLy/6I3YFgegMxuvyF3/ABdyt5AC8ihAPa0TNDywZT9murGwYwvOaP7U52+yykozDwk
         p1ja7h6vlSsnivcrRlTDN/AyVpo9R003t8KjDQ1oMwDbUcaxEdFXrx3HQhemzTVlZYia
         srNO05DcuWhV98IMHzDelhWxrp/qEHABflpSHWdL3aMMTQ7LFN5gtfRw+IOiM1tgcJGO
         AYDAzmPoH+hE5N9GVbFjqnrmArtY9PZZWr0ZG8Ne378KEQvytDnxll3rwZqRdwWcs2mH
         wiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708201184; x=1708805984;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+QP16I4Eg4fBq+C35kywoPdGn1esk8Vi4j1BhzgZtn0=;
        b=Kcr09uoU5Yo7BbCglqzRDOCjnuVvjw9FNGENlMMOLx97GxchMmIqLFZimYjyZ2SuO4
         yAF3GFKoz0weSjW1bWXhuyvdl38R+R2OI15tZ5JqDak8z4toQ0zxibIVygVV2Ptl71tb
         9hj2KHhzdSlFZT1an30HCiUsKxqLDrI8Rqj7y4ZRkTsj3oaNrI7wTsUodU0M9YfQAYOk
         BXfLDy05YxlBvL1WyHH8ntBUiGMQGrg6uVD5RHoVRXYDdrACQ6RzgRanSW84P9jkxOW5
         FK6nsTcYE6H97cGcpdwjIHbxy8fFSxLg3/GoApREWnF1rG0KeJ9Jy5UiPhl6ybjKDrEV
         YSUw==
X-Gm-Message-State: AOJu0Yx82A/QMyl5aQWOEjpqDeeBPEdQOrbGWRl2v46fT8Rc0diiVR9J
	0X5smY1AzMDS3695W8X5r8WYZOuR9Gq18g/TkWas38UPUyB1q8J1K6hkb0qh
X-Google-Smtp-Source: AGHT+IFHWunlkqqSJegUvfCB3Z6uBIXdhkCf1TqkabNENdnK1tMAYAzFPHqAt83smpxXWH0QECZdew==
X-Received: by 2002:a5d:4e82:0:b0:33d:1352:3dc4 with SMTP id e2-20020a5d4e82000000b0033d13523dc4mr3683212wru.38.1708201184246;
        Sat, 17 Feb 2024 12:19:44 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600003c400b0033d22852483sm4498005wrg.62.2024.02.17.12.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 12:19:43 -0800 (PST)
Message-ID: <35165caf-337c-4da0-b55c-c1a7081a1456@gmail.com>
Date: Sat, 17 Feb 2024 22:19:41 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: Fix setting the basic rates
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8192CU transmits RTS frames at 48M instead of the expected 24M.
This is because rtlwifi never writes REG_INIRTS_RATE_SEL, because when
rtl_op_bss_info_changed() is called with BSS_CHANGED_BASIC_RATES (and
BSS_CHANGED_BSSID) it calls ieee80211_find_sta(), which returns NULL,
and the code skips over the part that handles BSS_CHANGED_BASIC_RATES.

A bit later rtl_op_bss_info_changed() is called with BSS_CHANGED_ASSOC.
At this point ieee80211_find_sta() works, so set the basic rates from
here.

Some of the code from BSS_CHANGED_BSSID which needs ieee80211_find_sta()
was already duplicated under BSS_CHANGED_ASSOC, so delete it from
BSS_CHANGED_BSSID.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---

I'm not sure if this is enough. Should we also handle
BSS_CHANGED_BASIC_RATES? But bss_conf->basic_rates is only 0xf (CCK
rates only) and the out-of-tree Realtek drivers want to use the 6, 12,
and 24M rates as well. If ieee80211_find_sta() returns NULL, how can we
know if OFDM rates are supported?

I'm also not sure if it's okay to set the basic rates later than
originally intended, but it's still better than never.
---
 drivers/net/wireless/realtek/rtlwifi/core.c | 103 ++++++--------------
 1 file changed, 32 insertions(+), 71 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 2e60a6991ca1..7a68c528bcd2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -1139,6 +1139,15 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 					mac->mode = WIRELESS_MODE_N_24G;
 				else
 					mac->mode = WIRELESS_MODE_N_5G;
+
+				mac->ht_enable = true;
+
+				/*
+				* for cisco 1252 bw20 it's wrong
+				* if (ht_cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
+				*	mac->bw_40 = true;
+				* }
+				* */
 			}
 
 			if (sta->deflink.vht_cap.vht_supported) {
@@ -1146,13 +1155,35 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 					mac->mode = WIRELESS_MODE_AC_5G;
 				else
 					mac->mode = WIRELESS_MODE_AC_24G;
+
+				mac->vht_enable = true;
 			}
 
-			if (vif->type == NL80211_IFTYPE_STATION)
+			if (vif->type == NL80211_IFTYPE_STATION) {
+				struct rtl_sta_info *sta_entry;
+
+				sta_entry = (struct rtl_sta_info *)sta->drv_priv;
+				/* Just station needs it, because ibss & ap mode
+				 * will set in sta_add, and will be NULL here.
+				 */
+				sta_entry->wireless_mode = mac->mode;
+
 				rtlpriv->cfg->ops->update_rate_tbl(hw, sta, 0,
 								   true);
+			}
+
+			/* for 5G must << RATE_6M_INDEX = 4,
+			 * because 5G have no cck rate*/
+			if (rtlhal->current_bandtype == BAND_ON_5G)
+				mac->basic_rates = sta->deflink.supp_rates[1] << 4;
+			else
+				mac->basic_rates = sta->deflink.supp_rates[0];
+
 			rcu_read_unlock();
 
+			rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_BASIC_RATE,
+						      (u8 *)(&mac->basic_rates));
+
 			/* to avoid AP Disassociation caused by inactivity */
 			rtlpriv->cfg->ops->set_hw_reg(hw,
 						      HW_VAR_KEEP_ALIVE,
@@ -1266,9 +1297,6 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_BSSID) {
-		u32 basic_rates;
-		struct ieee80211_sta *sta = NULL;
-
 		rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_BSSID,
 					      (u8 *)bss_conf->bssid);
 
@@ -1277,73 +1305,6 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 
 		mac->vendor = PEER_UNKNOWN;
 		memcpy(mac->bssid, bss_conf->bssid, ETH_ALEN);
-
-		rcu_read_lock();
-		sta = ieee80211_find_sta(vif, (u8 *)bss_conf->bssid);
-		if (!sta) {
-			rcu_read_unlock();
-			goto out;
-		}
-
-		if (rtlhal->current_bandtype == BAND_ON_5G) {
-			mac->mode = WIRELESS_MODE_A;
-		} else {
-			if (sta->deflink.supp_rates[0] <= 0xf)
-				mac->mode = WIRELESS_MODE_B;
-			else
-				mac->mode = WIRELESS_MODE_G;
-		}
-
-		if (sta->deflink.ht_cap.ht_supported) {
-			if (rtlhal->current_bandtype == BAND_ON_2_4G)
-				mac->mode = WIRELESS_MODE_N_24G;
-			else
-				mac->mode = WIRELESS_MODE_N_5G;
-		}
-
-		if (sta->deflink.vht_cap.vht_supported) {
-			if (rtlhal->current_bandtype == BAND_ON_5G)
-				mac->mode = WIRELESS_MODE_AC_5G;
-			else
-				mac->mode = WIRELESS_MODE_AC_24G;
-		}
-
-		/* just station need it, because ibss & ap mode will
-		 * set in sta_add, and will be NULL here */
-		if (vif->type == NL80211_IFTYPE_STATION) {
-			struct rtl_sta_info *sta_entry;
-
-			sta_entry = (struct rtl_sta_info *)sta->drv_priv;
-			sta_entry->wireless_mode = mac->mode;
-		}
-
-		if (sta->deflink.ht_cap.ht_supported) {
-			mac->ht_enable = true;
-
-			/*
-			 * for cisco 1252 bw20 it's wrong
-			 * if (ht_cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
-			 *	mac->bw_40 = true;
-			 * }
-			 * */
-		}
-
-		if (sta->deflink.vht_cap.vht_supported)
-			mac->vht_enable = true;
-
-		if (changed & BSS_CHANGED_BASIC_RATES) {
-			/* for 5G must << RATE_6M_INDEX = 4,
-			 * because 5G have no cck rate*/
-			if (rtlhal->current_bandtype == BAND_ON_5G)
-				basic_rates = sta->deflink.supp_rates[1] << 4;
-			else
-				basic_rates = sta->deflink.supp_rates[0];
-
-			mac->basic_rates = basic_rates;
-			rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_BASIC_RATE,
-					(u8 *)(&basic_rates));
-		}
-		rcu_read_unlock();
 	}
 out:
 	mutex_unlock(&rtlpriv->locks.conf_mutex);
-- 
2.43.0

