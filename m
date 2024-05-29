Return-Path: <linux-wireless+bounces-8276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 299148D3D46
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C623D1F24002
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1523F18411B;
	Wed, 29 May 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFoF1E2S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55892181BA7
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003193; cv=none; b=E9YVx1JBegAQAAl89k9ofE6BFhRouU43zQnpvDCNwHvjzaG9mSGr1eN815dvP/1Sgk5VGWqG8ZF19YcRb4lzWRLH/mXccHlj/zutcnuoRnA9+MSASw56sUxLAmqnb0DDTPxzSGT9HBsOz86fTj4Yo0rw0aRl0zx1UKlek1Stxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003193; c=relaxed/simple;
	bh=yzDlb2K9GOJX4b/rbPSddZksJxFPkFJ10lX1ihaa8gI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=d34IodFzLaxq01A4+iNFg+a51qjlEperVoOiqBt3laTRRvwN1Y/cUrT8EbJiEtK6jV3J8GvuRxaB3uls2Yhn9OCixmbsME/y79r8uZ6PhCOhzhzpXHWS2OmBQIK1T3oc8fKQSlQgEdEmfOQ7A3ulWY+TN321C3JV53PUeradVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFoF1E2S; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e9819a630fso7325661fa.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717003189; x=1717607989; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQQgutpygXeQONeREe2XDCyMeaUSbf5Z899Y64KQCRQ=;
        b=SFoF1E2S89fingQaoG2RpnPbnnQHwqtdTiXgrHV0SE330RpFeKyzlbfSV3nADOfH2m
         TztSxfNMAmt2iPO4OqHlwcHpoTdsdV3T1PDSsYFJDzbC5B1XkyW7Qz2v0cRX7RSAVDfw
         hvb8oVOH9dY2bi/o0c6UyjHYa4yMWoRslJd+SjCSyf3976/u0M1sbgEbNrKqBn7vmSmm
         +deJ3UsKd+z4q25Cgj7fXp3kL4gMHlTTHEYzVQqkJfFiXTUxP87F8OZLRweS6k9qMXIR
         wEDdBKOpZpHm34qvQN/Idf56feCniRvRnOAH1O6ECOw5tE6GtZvx1D4cwMFBn2vgHaTq
         vCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717003189; x=1717607989;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WQQgutpygXeQONeREe2XDCyMeaUSbf5Z899Y64KQCRQ=;
        b=CvQewy3UsezGKuHzsppssHihpfd5ee7IzVU2mYUnGaR0eRoTizpZ99mnFboIaLi2kd
         C3tT3ypFjc3gxoVaWuOb/WoX6UffT6B3OD99icafwAVhDrwqenk63XXFnBATg3L2Ssz7
         O5xzGBk2dhhuJJJ88tnANuZCK81OTIfHsAPmEsWG5sWcYLiKWKvr+oCkRa1qQtlb1UKp
         h0g0fRfskG6JsxXFW6vK8D0G4belT166aPBLVBCVYzszyuuazfzV1ElOfMQpHn8B6w0Z
         BevmFPU4fcanFcLAy0DrE3snfEcm5aGfbwAVpy1vUOY2rvSdLfavm7KDvWq/nzv16+vP
         UzPg==
X-Gm-Message-State: AOJu0Yy///GH3keKMCCEnO4BfdUe4WcQLMNCLhGLaKqsYT0SJPHcBLvg
	yp0FnoXK4QQtLtqf32apeUAxeqTOB7JhPZ+vcGECkc1KY2w7ytTqaiFaAg==
X-Google-Smtp-Source: AGHT+IG0dKXrk5ngGq05NZd4WkJn0Jbe/cOVmHFDrZl8bivfR2cdj82KK3nJ9BFEXEy+ocAyUml0HA==
X-Received: by 2002:a2e:a556:0:b0:2e0:298d:65ec with SMTP id 38308e7fff4ca-2e95b096e0emr148484001fa.17.1717003189085;
        Wed, 29 May 2024 10:19:49 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cd83a1csm730137166b.182.2024.05.29.10.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 10:19:48 -0700 (PDT)
Message-ID: <1fabb8e4-adf3-47ae-8462-8aea963bc2a5@gmail.com>
Date: Wed, 29 May 2024 20:19:47 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since commit 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx
drivers") ieee80211_hw_config() is no longer called with changed = ~0.
rtlwifi relied on ~0 in order to ignore the default retry limits of
4/7, preferring 48/48 in station mode and 7/7 in AP/IBSS.

RTL8192DU has a lot of packet loss with the default limits from
mac80211. Fix it by ignoring IEEE80211_CONF_CHANGE_RETRY_LIMITS
completely, because it's the simplest solution.

Link: https://lore.kernel.org/linux-wireless/cedd13d7691f4692b2a2fa5a24d44a22@realtek.com/
Cc: stable@vger.kernel.org # 6.9.x
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 2e60a6991ca1..42b7db12b1bd 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -633,21 +633,6 @@ static int rtl_op_config(struct ieee80211_hw *hw, u32 changed)
 		}
 	}
 
-	if (changed & IEEE80211_CONF_CHANGE_RETRY_LIMITS) {
-		rtl_dbg(rtlpriv, COMP_MAC80211, DBG_LOUD,
-			"IEEE80211_CONF_CHANGE_RETRY_LIMITS %x\n",
-			hw->conf.long_frame_max_tx_count);
-		/* brought up everything changes (changed == ~0) indicates first
-		 * open, so use our default value instead of that of wiphy.
-		 */
-		if (changed != ~0) {
-			mac->retry_long = hw->conf.long_frame_max_tx_count;
-			mac->retry_short = hw->conf.long_frame_max_tx_count;
-			rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_RETRY_LIMIT,
-				(u8 *)(&hw->conf.long_frame_max_tx_count));
-		}
-	}
-
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL &&
 	    !rtlpriv->proximity.proxim_on) {
 		struct ieee80211_channel *channel = hw->conf.chandef.chan;
-- 
2.45.1


