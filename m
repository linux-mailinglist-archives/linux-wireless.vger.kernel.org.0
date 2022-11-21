Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB3C632E41
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 21:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiKUU5G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 15:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKUU5E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 15:57:04 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5A3D08B6
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 12:57:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bs21so21669976wrb.4
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 12:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTd30YK/ndNhc2JUcwma2+6/k1BhlViOKiNWVRhMlrM=;
        b=bP446rL7jauaeRbyXQ5dFGXnm3LufjkC3lw+v4I070gZpCu/U9yMvhqXIMS5WDdJvi
         WvkZ8MviewfBy/JwhNPvojoMF32F/oNZwsH+Q/EGjR92IEm4HupynTaz8UyJ2echdU1z
         8UonEwle4aTN8x3b1z/J3J2nO8fT+WfKo4+uZFhJjtk+HjDrFXm468ypgiW4Mvjcds/l
         1w0/EzRE9nQZ0CXvjlr/7cwYNT66EPVGgNq5mVMz5rfC4ZZnHeRoc61W+QjxHj0DJ8bX
         NaF1gg05U6tgA6c7Y5uOFAucvgixNqMPvsMvSM6rAQCPKnAsx2o24gT7ZlATDhZLt5ma
         yqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gTd30YK/ndNhc2JUcwma2+6/k1BhlViOKiNWVRhMlrM=;
        b=yGxXCADDIauBYXaLYHB+z6rXcgsmqSg94HylNhPL+mlENcO2trEcKNv3e476PUoMwG
         X+bczE4Clz8EEDrtaSirwXCSK+EV3jdbl7YOTvPyE4XCywrgO+sbclV9QnRUbwPmZSI+
         QhUHWdUzab6NhkMuxm2JvSinRIuF1NQU+kRQwDGYgv5qc5p+ZrshdC2o1A48bUzSsPmk
         nOhUi31I2YBd5BjQ60lIvtKaxr56Uo05hJQidlgbDExJvLgxAk5tCyViZvqKbCfVq4Lw
         V2uHHLduJJqFKZo5Ewfh7KpdI2rhM3o2x2oszcLEADksPvawTLjXsqAcyV+WvTozO9Ix
         pKCw==
X-Gm-Message-State: ANoB5pnRy4G+AslaTB7Zvl9chXcWzhqklTvnMLUhpmmiTNGjtsQ8HXXT
        04079U9axPVII5+JrO7CdZa/LB+54Is=
X-Google-Smtp-Source: AA0mqf742RR/DYWM8uJZH9819Kc7LqStK2nrmGCWrnEs4innnyKMCy1wS4KEZycGEwyAyvd6wv7o3w==
X-Received: by 2002:adf:f90d:0:b0:236:6efd:ed6a with SMTP id b13-20020adff90d000000b002366efded6amr13028974wrr.32.1669064220296;
        Mon, 21 Nov 2022 12:57:00 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d45c6000000b0022e3538d305sm14496912wrs.117.2022.11.21.12.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 12:56:59 -0800 (PST)
Message-ID: <3c82ad09-7593-3be1-1d2c-e58505fb43cb@gmail.com>
Date:   Mon, 21 Nov 2022 22:56:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtl8xxxu: Fix use after rcu_read_unlock in
 rtl8xxxu_bss_info_changed
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

Commit a8b5aef2cca1 ("wifi: rtl8xxxu: gen2: Enable 40 MHz channel width")
introduced a line where the pointer returned by ieee80211_find_sta() is
used after rcu_read_unlock().

Move rcu_read_unlock() a bit lower to fix this.

Fixes: a8b5aef2cca1 ("wifi: rtl8xxxu: gen2: Enable 40 MHz channel width")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Adjust the commit message.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index e8fcd531c437..28f136064297 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4645,7 +4645,6 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			if (sta->deflink.ht_cap.cap &
 			    (IEEE80211_HT_CAP_SGI_40 | IEEE80211_HT_CAP_SGI_20))
 				sgi = 1;
-			rcu_read_unlock();
 
 			highest_rate = fls(ramask) - 1;
 			if (highest_rate < DESC_RATE_MCS0) {
@@ -4670,6 +4669,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				else
 					rarpt->txrate.bw = RATE_INFO_BW_20;
 			}
+			rcu_read_unlock();
 			bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
 			rarpt->bit_rate = bit_rate;
 			rarpt->desc_rate = highest_rate;
-- 
2.38.0
