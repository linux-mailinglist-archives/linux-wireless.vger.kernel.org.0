Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE9661604
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jan 2023 16:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjAHPIV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 10:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHPIT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 10:08:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66C1C775
        for <linux-wireless@vger.kernel.org>; Sun,  8 Jan 2023 07:08:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x10so6124356edd.10
        for <linux-wireless@vger.kernel.org>; Sun, 08 Jan 2023 07:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bfu9Do94+cSM7FBaTDR2jHk7+19bcJfDuKFB0Y2utw4=;
        b=pyVJI4ARZqSf+BYS76A3jgRVNTWWVNvsB48cqKbLyjjTqGovyFbfsClyIe9mD8B8PZ
         ZQkVtU4q4Q1XidRWhRvPySRARFJ4I44Wb0j0gh8uxbTHaJ2HEFNOVL4AWOhK06Rf4H3N
         6syDla3kI+ZnlpiMD2JNAeEpVnISmzOhdrKG/Y+UY//NGba/kfmwOR63A9QHGbnzgV5f
         pbVggFSX0xfs+db86AFZHhJgui6RpXkNKAUvofC5zHnVDADe14H7AVTfYhiMa7LPZ8xH
         iYJJbiQ/y946DEQgEiw3gIT2rG0nnJedT8R91VtNh4HjBHyfDHAH8nYNnVEqYWwUNBjr
         u5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bfu9Do94+cSM7FBaTDR2jHk7+19bcJfDuKFB0Y2utw4=;
        b=sXylAqywIanfO5lhy0RgUrZ7zL+BFhDwV4qi8h7KNx8RR7vKn9wbs3DvvsAoSWFeqS
         HCxcVpNj+LB2vJqJYQzZqIm4croMnsIc5Qk6t+ykCBDv8ygh3UuXUmLoSSL8o6M8LKMm
         3f4a90VcCTMGE93xYPaVJd9SFOIv68zEyBgZEYbjJD++CyAD4QLEBqtigm1xm9Ms2y3h
         sNsd34O+jQzckKK5xUVR2bKhs2hBGrMrFseuUSv8vGi/UVobx07b5ocVxIkxaSxLUoZr
         EAfFIOUh4tV0ni8xTed3Q/4J8qKRvCs0lSHHLuQGTWDRVd7791tBiGrlBOPX7J8sirSy
         2E1Q==
X-Gm-Message-State: AFqh2kpLcqKCODF/204D7QheZjdGp9pedNOm09rGIELSOQwG2wYK2H85
        Gp1NnCGEM4eINctTP2lbkafiPR/BL6Y=
X-Google-Smtp-Source: AMrXdXuSIB+G5UkEPnNRvPbMsjwDWx9m5YdlLdPckkuOISEOkMJ/d7CHCo8Qs6B17F2FdisVaFKl3Q==
X-Received: by 2002:a05:6402:2a08:b0:470:4d71:6d43 with SMTP id ey8-20020a0564022a0800b004704d716d43mr57338741edb.25.1673190497244;
        Sun, 08 Jan 2023 07:08:17 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id qw25-20020a1709066a1900b00781dbdb292asm2574331ejc.155.2023.01.08.07.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 07:08:16 -0800 (PST)
Message-ID: <477d745b-6bac-111d-403c-487fc19aa30d@gmail.com>
Date:   Sun, 8 Jan 2023 17:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 2/2] wifi: rtl8xxxu: Use a longer retry limit of 48
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <2aab4f3f-e914-4fe1-f29a-deac91774d05@gmail.com>
In-Reply-To: <2aab4f3f-e914-4fe1-f29a-deac91774d05@gmail.com>
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

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Use Cc tag instead of Fixes.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 4c76fad67150..ab4074caf191 100644
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
