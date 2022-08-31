Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB35A82C7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Aug 2022 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiHaQMl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Aug 2022 12:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiHaQMk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Aug 2022 12:12:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65252910B5
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 09:12:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb36so8509554ejc.10
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=VxrF9E74uRVnPoXcdbe+5HFxEc3dhBDcblzIs6+f7Jc=;
        b=TeknayFmbpmKTQJeDqPB407JNGoCrl7I/Q3B2umv6i3sFDElOZEj/OurWrW9D/tSF6
         980MTFgRpSFV48E02AF0foqGXqu/Sy2gzhi4TGfdHIeJnq5lLkG0IB9H06y/rG6OmRmS
         M4KIFR6Wivp1joCbDirGdEsbva5cXwN25wQysrhtZ2BEaSO6JyUtZ8RUCtLs444mMtOj
         a4BwMDl5I79YbkYay128+5C90sF1kySAEJObRkyJz+/hYD0lgA5nOR5FGwZibsXcSe29
         vnrvP6BhyTrcDB5oujfU1cbSBkhU01uqabO35eMTnWvuZ2f8DoW4xAK821xOjykb7z23
         QKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=VxrF9E74uRVnPoXcdbe+5HFxEc3dhBDcblzIs6+f7Jc=;
        b=TlfM4+dySvSD7ooRyFtb9MVV4khIHoUKXXCNMAeF7DYwUjMx34CUWogIKq7wPIHLUS
         PpVYuXsrSP9HbAJnAB3PTkIA5qVOn9KM17CM3ZrhiSPhslM+ko3G5Eb1Jr/9v4qFzB1G
         c+n/wOgEX0PZ6UIt3EkUdyKRGpiiO+wZ9APfMOByiLJ0l9L2dQKx6MQral+1g1wLX2RQ
         nxIHulpNNDJyJTHBVon9fO6Jwi0sH9wqHWRYinUghfbDJ17k9mHxL+8IZCm2UFOcUXMu
         6hdz9heg5ePkZaYIquWOgqBmvmw1FIXGYxhg1eHHUNp1QnWMa+Stpb40QmVDqjGB+0Ja
         tfLg==
X-Gm-Message-State: ACgBeo2Lm4VPl72hquwmxaFioUcRtjkLw+S+VRg4j8/Z+TlNMoJLqFoF
        WqrHzZyOinYbWk9l1O4/L3nlX8Q9pnHGNg==
X-Google-Smtp-Source: AA6agR5mxNYubh68eQW3CxKjZaLuIa+PIq8J97x6d9R5TVls8345pjbcDzRczeC1otBY3geUAtwcjw==
X-Received: by 2002:a17:907:272a:b0:741:855c:8875 with SMTP id d10-20020a170907272a00b00741855c8875mr10773731ejl.575.1661962357693;
        Wed, 31 Aug 2022 09:12:37 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id r5-20020a17090638c500b0073c0b87ba34sm7190326ejd.198.2022.08.31.09.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 09:12:37 -0700 (PDT)
Message-ID: <7fa4819a-4f20-b2af-b7a6-8ee01ac49295@gmail.com>
Date:   Wed, 31 Aug 2022 19:12:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
Cc:     Jes.Sorensen@gmail.com
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtl8xxxu: Fix skb misuse in TX queue selection
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

rtl8xxxu_queue_select() selects the wrong TX queues because it's
reading memory from the wrong address. It expects to find ieee80211_hdr
at skb->data, but that's not the case after skb_push(). Move the call
to rtl8xxxu_queue_select() before the call to skb_push().

Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
  Add Fixes tag.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 52240e945b58..8d6f693bf60b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5177,6 +5177,8 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	if (control && control->sta)
 		sta = control->sta;
 
+	queue = rtl8xxxu_queue_select(hw, skb);
+
 	tx_desc = skb_push(skb, tx_desc_size);
 
 	memset(tx_desc, 0, tx_desc_size);
@@ -5189,7 +5191,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
 		tx_desc->txdw0 |= TXDESC_BROADMULTICAST;
 
-	queue = rtl8xxxu_queue_select(hw, skb);
 	tx_desc->txdw1 = cpu_to_le32(queue << TXDESC_QUEUE_SHIFT);
 
 	if (tx_info->control.hw_key) {
-- 
2.36.1
