Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587CA5BBDD5
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Sep 2022 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiIRMrR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 08:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIRMrP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 08:47:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F6EA188
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 05:47:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b35so37619468edf.0
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 05:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LRwYL58HAnjxk9G8kl1uP4zRdBTb2psEF3KiRecpy20=;
        b=cHjjfYwNK1M9BpoBkNJ9AJsjZSXd7d+ldpm83reGZoE0WIMDyZXR8i16e+DXyQ3JkM
         b+5F4MTnFfYQnq0HPOfyr9VL+DLsOG2y5Bn0ztymWANzMXuHKKcx1fMeRUTTYUS2Oj9X
         rff/5RrL0DdpEsPQDqWcZ2rh9hXuKAi/uu3a/R2vA4cURB0TWVROQJo0yYrdAmDc2AaZ
         RSnQuTLiQqI1Nfv/XRWpKQq5jV0ZOEfcydRXfwc7OaZfduWcdIG/NhV7NrNRB1xIY1sq
         TmCeGHRPT5cDQxq3s/2I0IM3tHp5cDeP6BdYCvb0audu3Bpa9hKgTolisvILz/0ZFioq
         20gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LRwYL58HAnjxk9G8kl1uP4zRdBTb2psEF3KiRecpy20=;
        b=rvLRjhq+uCfKwYS1YM2eElVLFajmRjE2XsdXdwfsBtej/idyD6zA14vILGRE8GqQnn
         OExfgzcZHP/lA7m7f8m+J5La9SGzQAkluUgBLD7H7YA0pkNMx6tVjQTNjAtd4E7p/zyQ
         H5WCbBYVh4dOmA8Bc2vyjq60mQw/xx60m5M4dKNI3pdVlphQTxnzWrfB+Smt6CBttJZ9
         g3DzC5DzsHej2LHQBgVpj1veJE8PvMB26fP3OnsM0kemzy0P33ts4BUu8vSJWgQBFb8y
         eGwmq/nmToiDURb2swZOa9eg3k0U7h44FD0lAEWmnXatwTVVnaKiqY4t5Q17dtYOX6zy
         15sw==
X-Gm-Message-State: ACrzQf07oqm4XTE0HqYcHNa1SvTwlcr3ae10D/4r0qcdWtAayLdA2D8J
        1SZqEh9pMpgyhUbr7iWxvhn9a1yDe9U=
X-Google-Smtp-Source: AMsMyM4IpoobaBoM4Eoz6vKpPMfCFbd6+wjHAb5gqrQuh3nXH7XEd5k1Wma9muSQP3eM9ZN0w2QT5Q==
X-Received: by 2002:aa7:c44b:0:b0:44e:e6aa:1558 with SMTP id n11-20020aa7c44b000000b0044ee6aa1558mr11911629edr.263.1663505231838;
        Sun, 18 Sep 2022 05:47:11 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id d19-20020a50fe93000000b0044e6802623dsm17849403edt.18.2022.09.18.05.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 05:47:11 -0700 (PDT)
Message-ID: <2af44c28-1c12-46b9-85b9-011560bf7f7e@gmail.com>
Date:   Sun, 18 Sep 2022 15:47:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: [PATCH 4/4] wifi: rtl8xxxu: Improve rtl8xxxu_queue_select
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

Remove the unused ieee80211_hw* parameter, and pass ieee80211_hdr*
instead of relying on skb->data having the right value at the time
the function is called.

This doesn't change the functionality at all.

Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 9ddff43b5cfc..7715680d8bea 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4863,9 +4863,8 @@ static u32 rtl8xxxu_80211_to_rtl_queue(u32 queue)
 	return rtlqueue;
 }
 
-static u32 rtl8xxxu_queue_select(struct ieee80211_hw *hw, struct sk_buff *skb)
+static u32 rtl8xxxu_queue_select(struct ieee80211_hdr *hdr, struct sk_buff *skb)
 {
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	u32 queue;
 
 	if (ieee80211_is_mgmt(hdr->frame_control))
@@ -5215,7 +5214,7 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	if (control && control->sta)
 		sta = control->sta;
 
-	queue = rtl8xxxu_queue_select(hw, skb);
+	queue = rtl8xxxu_queue_select(hdr, skb);
 
 	tx_desc = skb_push(skb, tx_desc_size);
 
-- 
2.37.2
