Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D9460BD87
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 00:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiJXWhD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiJXWgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 18:36:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6594B4AD
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 13:59:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x2so6225327edd.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 13:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+HorgRdrODfDYUGY+yxjc+8GNMUFjJj7dpFTHYT7wk=;
        b=M5hzDjWcXZoob3z9DPHKcnnOgfmMCK0q3u8rPHmMRghEhjx7W5U/mWN7oMqi7Om72B
         5lN5h72TatdSdiO3F5Yj1bZKgXG9ywTsmZgDyTXfuIvEYydGgD59mIzqmHT12/GCjoRK
         Dq20etdBwAmXx2zVxcu2q5OrA3Jjt99PofjxhzycNJySiq5Hub4QPnJZ3WKcLc0KphbD
         q7OgItwhDd+M8g2MX3kYtsQSANXKIrQ175B4dmidcnof8/7QKDBYov7ol2TKx3PJs0xh
         VbJPDIKG8al4gjmyUVchtsAmN7R+gjYr+HeYwAwEYTgW+tUhslhmt4ikVN8qbAh+xmFx
         5zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+HorgRdrODfDYUGY+yxjc+8GNMUFjJj7dpFTHYT7wk=;
        b=J8Bv5tnL8ZzS8hUUJ7CHD7D5aJz+5QcTpJHiC3OQ9kfclGDf4fni1vzzWIg9C66vJl
         xIwD9pKQxl6H+o4MNVeIoekUOlZBEOZWxyFwXXnDOYqzbgfdJSyhfSx3LaD8LovYxMVh
         UOIzoP+u5YunNHqd5kXirR0SWuOyynAgctPTfiJUzaJee5Fn3qnDpKCXRbEn2cnbBZ/C
         5OKt0WYeRUrTBL4WZuAvocI64hBjfgXEL09gwXkVhOCyXjU09A/c8nrfIePAweLD0dRV
         l3k3EkPIlph9RZUbTkuKE+Os8SvG6B4an5X/yd6aQr2RjnvTGHfLIHOmN/M2yp3Tmu+I
         JrYg==
X-Gm-Message-State: ACrzQf1cQ4fi5l9zP/An/6A7dI0RDYTGEtl/c4IPsb64LxI1hN0+NIH2
        jSxeHwb/p9WTrKnZPkGa45/aKNRl9qc=
X-Google-Smtp-Source: AMsMyM4T0GsTjzncveb8k4zkW7oxcjpGA0HUi5r7ibQp7bEk1jmvHqxWZdfUueS+C+MKC7u+oVIkMg==
X-Received: by 2002:a05:6402:2486:b0:460:8f86:1fca with SMTP id q6-20020a056402248600b004608f861fcamr22281586eda.70.1666645069144;
        Mon, 24 Oct 2022 13:57:49 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b00780982d77d1sm355982ejb.154.2022.10.24.13.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:57:48 -0700 (PDT)
Message-ID: <0dd519e3-45f7-de43-3e09-29c3d63af1f8@gmail.com>
Date:   Mon, 24 Oct 2022 23:57:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 4/5] wifi: rtl8xxxu: Set IEEE80211_HW_SUPPORT_FAST_XMIT
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
In-Reply-To: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
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

According to commit 60d7900dcb98 ("wlcore: enable
IEEE80211_HW_SUPPORT_FAST_XMIT"), we can use this because all the chips
have hardware rate control.

This is one of the things mac80211 requires before it will handle MSDU
aggregation for us.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 7c587b5d554e..8bab7247460d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7005,6 +7005,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	 * The firmware handles rate control
 	 */
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
-- 
2.38.0
