Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07734600272
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Oct 2022 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJPRbF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Oct 2022 13:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJPRay (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Oct 2022 13:30:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6B42873A
        for <linux-wireless@vger.kernel.org>; Sun, 16 Oct 2022 10:30:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r17so20294679eja.7
        for <linux-wireless@vger.kernel.org>; Sun, 16 Oct 2022 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iQ/vkDGV+7J1XKkoEXTuB0fdvNEnLi8impkyXuqlqY=;
        b=LWVe2wSqTciW26QbehXj1uX1Eq87jY5BNKLK2YDn+RlpJGPZypP1lHeKgDf8iSPs/j
         +DuADNpimDKmw6C35yRmnzkv7BtPvjFVTTCOGbrUgqmVDVa5p1vJ/nMHhY3UsKdfU1Y5
         3DY4jS151hJcQB7gFNOd6rVH8YJIo6AdT/UiP9aWYolQSQxoWLR4Fgd/dHXsbt4ROwVC
         pmHvwlGtT12tgSPn00mesXTij9vTC7YRtq+0eraSuOKyBbSjzOVu7xCvTZBJ34dm/M+H
         otgJ3WG0HJJTLQD/HgBod7SqcPEdmNddcn6/xLsS88lOeJF76qpWWC5h7tFDl+vp0r+T
         iqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iQ/vkDGV+7J1XKkoEXTuB0fdvNEnLi8impkyXuqlqY=;
        b=WERDE/8MMQlfOtfrj5jkC/r9Zotsp31HFi2GeTHqdrwjK8FQPpHFCLvpkdgabj8ZEV
         TcsMBwTteeFyDgJIWkbvaisPrw2Q12JekvAgNjKVcVdF9UEkRet/lN2/A0ujffqWX+Ff
         Iz1jva3Vaae1r5HXh207t/Lca1Gba76yS3Srrvnzm6V+hZ6T86qgvJ/DaD0f+90xHRNe
         M99gHQAE4nwwcpzUUlFFi6K5mkJeahLYRfihkQSARaW6hbs2qt2qCyzFbXXE0JEQtVnN
         2T+9YExChGILr8P6VCZb/Azg8avGQeaPAkKyHim+JUpvS2g/ZwAWcNtqvAg/jGqFm9FT
         fyQA==
X-Gm-Message-State: ACrzQf2wIU+abF/rVw2HlqoRa29F7iuSG/FNpuYNPQ+6uK5eZJ9koxRY
        TtnlHS+zZO5XPHtS7WwnB6BhfmNKEtI=
X-Google-Smtp-Source: AMsMyM4n4mgZZfXT6r1PaPP0qTLu3ROm4ufdNmA0/Ijts+heYBjMrWWTdTphaq3pSh1Tl1nltFplGg==
X-Received: by 2002:a17:907:724d:b0:78d:acf4:4c57 with SMTP id ds13-20020a170907724d00b0078dacf44c57mr5847459ejc.516.1665941442408;
        Sun, 16 Oct 2022 10:30:42 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id m13-20020a1709061ecd00b007305d408b3dsm4826680ejj.78.2022.10.16.10.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 10:30:42 -0700 (PDT)
Message-ID: <f39fa20c-6223-badc-b9e3-7357c5b9bcab@gmail.com>
Date:   Sun, 16 Oct 2022 20:30:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 4/5] wifi: rtl8xxxu: Set IEEE80211_HW_SUPPORT_FAST_XMIT
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <2b29b6d9-c17e-76d6-c32f-630f24b407b7@gmail.com>
In-Reply-To: <2b29b6d9-c17e-76d6-c32f-630f24b407b7@gmail.com>
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
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index a8914650815e..33169b836f2c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7012,6 +7012,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	 * The firmware handles rate control
 	 */
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
-- 
2.38.0
