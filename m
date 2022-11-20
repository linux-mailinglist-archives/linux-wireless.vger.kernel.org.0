Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6A631669
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 21:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKTUqh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 15:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKTUqf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 15:46:35 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755F2E0CC
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 12:46:34 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n12so24397973eja.11
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 12:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCTmG3exk8M68SPAIsnNSMweYpuihWM+zIeEQu9RcrU=;
        b=lNdSPrgm3dQU36F2LFYmQljeB0cJPMJxAjhatjdtQWVoAukdBlSuubhNkIgjELSPIz
         RvYUmPAB9hl6JtnsIBrnTKm4Cf4hTtWov27K6cXDcy198eJ0zUpKrSH54qT92x62LmwL
         EIbA+eOmmpoUGUvs+cqweVhmwM2LDbOypZ1MLc1z1Hc7cxdlzNeQTEyswQhwrqXnWsth
         k1QkVzd121m2JfcVveMgrJAU1ec6yGLWGkBwvGYkjRdE53X8yIYv76NJrIBrOXFpuDKv
         8z3y1jRh9jGfaV9/QBh4pI6fba1fOszYWyOua7b/zeuhlhe1ED3wzJoC4C+nwXCBzfZY
         LLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pCTmG3exk8M68SPAIsnNSMweYpuihWM+zIeEQu9RcrU=;
        b=QoLXi4YIggIP+/tNbV/7MMPqFP8C8wJFO9W+HtOLk7Fn2kQz0k9x/TjqIDdrib4on5
         Th3MDcJeJxt3pGRm+/1FGxQloU9+KYuaSEfdwKPenzt7kijjHZS9JNL6D+9oj6K1Kl+I
         JYa09STwQHDb/Xh8AUKUQTsoVz0PrVMpNRTBHRjjaK77ZfWmi+CqWoPI/GfAW/THWvEm
         3IXMifqxo9dbxOCsMYGTcUyuOUURpcyFl5a0Z7R/wa0CZe7YM0FrF4yu0ml69koKffXa
         G6nSwCl5i8nkmezdYekpuJgYGQFziz6wjFuzPgjZqmI0vhLGRtZvF2z7bmZBbukKjx7O
         m9ow==
X-Gm-Message-State: ANoB5pkEgMZ3j0n12a5cAlSay4NcVthNEgAHBI0uT7husvR1omnbEdQN
        wej4llkdVBFt3m7uP+WzojVcDi5I/N4=
X-Google-Smtp-Source: AA0mqf4i15lNUw5euGrdmT944i7GwVqqD7JaabdAd4R62kWfe2KGhGjm/ShnMrysO6ca31WCA8CU/A==
X-Received: by 2002:a17:906:1498:b0:73f:40a9:62ff with SMTP id x24-20020a170906149800b0073f40a962ffmr13420150ejc.678.1668977192519;
        Sun, 20 Nov 2022 12:46:32 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id c20-20020a170906171400b007305d408b3dsm4307576eje.78.2022.11.20.12.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 12:46:32 -0800 (PST)
Message-ID: <a4c4f176-8903-6bf7-3b31-880ff7ebf195@gmail.com>
Date:   Sun, 20 Nov 2022 22:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Fix use after rcu_read_unlock()
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

... in rtl8xxxu_bss_info_changed().

Commit a8b5aef2cca1 ("wifi: rtl8xxxu: gen2: Enable 40 MHz channel width")
introduced a line where the pointer returned by ieee80211_find_sta() is
used after rcu_read_unlock().

Move rcu_read_unlock() a bit lower to fix this.

Fixes: a8b5aef2cca1 ("wifi: rtl8xxxu: gen2: Enable 40 MHz channel width")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
My bad. I'm not sure how serious this problem is because I've been using
this code all this time (2+ months) without any trouble. I only noticed
it when moving some of this code into a new function.
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
