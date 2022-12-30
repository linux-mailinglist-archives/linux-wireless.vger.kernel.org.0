Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D931659AB4
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Dec 2022 17:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiL3QyE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Dec 2022 11:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3QyC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Dec 2022 11:54:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE88D12742
        for <linux-wireless@vger.kernel.org>; Fri, 30 Dec 2022 08:54:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o15so15494530wmr.4
        for <linux-wireless@vger.kernel.org>; Fri, 30 Dec 2022 08:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbMutnDCP2mWwK+UWi36FtnyyiiNOJn2fALfL+2HVj4=;
        b=Zt9WzavQ/A1jQZwGMsxuKNESvKfSuIa+zyx5GhJpGcy9dRNYq/0cFHF7vyuxVCsXJN
         SvV/JPtIrG1ZbNISpo3oXYJgUlyZ2FrPNwcMB3LdGiebn/Rh7kX7fw/mOYNQFBpd2Tqx
         +VdqwJyfQuT/6sIuUNr1MikyJ5i1zync4MfXUNTEtiM2SmLMeKnXCx1YeUTVnF7/dpE8
         k1k7uAUZdIQ8LnmQjflDyX5rU/FFxLNFckdavvzGViu27zcDOUfMQXGG+XchRoSJ7Smt
         251u2EXIiHb5ZgeasGdcI81+aBrPnUQnx6kDp/ALh8PGKo2Tu1+gUBIrpBtkAJbDf1LQ
         4NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbMutnDCP2mWwK+UWi36FtnyyiiNOJn2fALfL+2HVj4=;
        b=BY6no1WHd0aNuBLqNIN+eO4JIbmB+YwKda34eWnW+18qAXt1Quc4aUSmyzcUtKHBIR
         JISB6T/TLoNj4uPDd4uyyjg8BgPoCaVKdFeLEzV6pt3SZ7LDAgcwLLGngvBu5210Kp1h
         8L4OqB2PRD6nI3FmwZVAQXlZ5oBGGDKs3Be2cpqvUbkjo0pqR3HtOdihRfmED+AiGRk0
         zbItzABCGI6XkUneORfIQ8Ofur0TlydGFwIE/BICS3bn4Kpx/TVAahK8iRszGRh+Wi0J
         hydMBkjC7LhvvzktMmzLCZX+RzGz+FYIux9QThnmyrIjtVzjbpVQeraEaJvtBgAobCRr
         DqYQ==
X-Gm-Message-State: AFqh2ko/olhBeaS7Pa0DRM85Y4IZri+qdfXkNOD4M7WO+Oc+yESJfIPF
        kxUK61FxV2EMI51vgqs4albKcloGs6c=
X-Google-Smtp-Source: AMrXdXvTH2+ZYBZc6cxySZUMYQyUJxBlUm8s5zA31CFsj3xAj//UnUtqlOm4dlFDwpxIPWb9CeBXkg==
X-Received: by 2002:a05:600c:1509:b0:3d2:17a5:17fe with SMTP id b9-20020a05600c150900b003d217a517femr23219593wmg.18.1672419240490;
        Fri, 30 Dec 2022 08:54:00 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id hg24-20020a05600c539800b003cf71b1f66csm28259586wmb.0.2022.12.30.08.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 08:54:00 -0800 (PST)
Message-ID: <55813ec6-b99f-dd25-a1e2-7af9e3be3117@gmail.com>
Date:   Fri, 30 Dec 2022 18:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 2/2] wifi: rtl8xxxu: Use a longer retry limit of 48
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <6fcaaead-876c-68d1-a049-f1e7f7ff81e7@gmail.com>
In-Reply-To: <6fcaaead-876c-68d1-a049-f1e7f7ff81e7@gmail.com>
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

The Realtek rate control algorithm goes back and forth a lot between
the highest and the lowest rate it's allowed to use. This is due to
a lot of frames being dropped because the retry limits set by
IEEE80211_CONF_CHANGE_RETRY_LIMITS are too low. (Experimentally, they
are 4 for long frames and 7 for short frames.)

The vendor drivers hardcode the value 48 for both retry limits (for
station mode), which makes dropped frames very rare and thus the rate
control is more stable.

Because most Realtek chips handle the rate control in the firmware,
which can't be modified, ignore the limits set by
IEEE80211_CONF_CHANGE_RETRY_LIMITS and use the value 48 (set during
chip initialisation), same as the vendor drivers.

Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index f5fd3c448587..9bca5e837583 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6184,7 +6184,6 @@ static int rtl8xxxu_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
-	u16 val16;
 	int ret = 0, channel;
 	bool ht40;
 
@@ -6194,14 +6193,6 @@ static int rtl8xxxu_config(struct ieee80211_hw *hw, u32 changed)
 			 __func__, hw->conf.chandef.chan->hw_value,
 			 changed, hw->conf.chandef.width);
 
-	if (changed & IEEE80211_CONF_CHANGE_RETRY_LIMITS) {
-		val16 = ((hw->conf.long_frame_max_tx_count <<
-			  RETRY_LIMIT_LONG_SHIFT) & RETRY_LIMIT_LONG_MASK) |
-			((hw->conf.short_frame_max_tx_count <<
-			  RETRY_LIMIT_SHORT_SHIFT) & RETRY_LIMIT_SHORT_MASK);
-		rtl8xxxu_write16(priv, REG_RETRY_LIMIT, val16);
-	}
-
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		switch (hw->conf.chandef.width) {
 		case NL80211_CHAN_WIDTH_20_NOHT:
-- 
2.38.0
