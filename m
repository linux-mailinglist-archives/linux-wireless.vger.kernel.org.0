Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587F5591C6F
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Aug 2022 21:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiHMTyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Aug 2022 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHMTyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Aug 2022 15:54:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583D711C21
        for <linux-wireless@vger.kernel.org>; Sat, 13 Aug 2022 12:54:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z2so5057836edc.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Aug 2022 12:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=JQXLpZ8DgBdQa36Cd/ldiogr0m33sflT491uuiFL70U=;
        b=gjvd7QZaD9nWHw8QKHcM+qmizCJTMCj68OQmqYTJolvsmqfWW/K+9phG7DduK1f/eV
         FIPcJKlSnEETtvMl+/XkirI9MaeNQUp1dqyxROJxInSkY6ePJpQv6ot3/bv81TiDzw5v
         sbE8f9YSBUYk7C+zvOydkMkT2vAu2RwoV0DooCCGCk4hHBY4YZsP3oZa46uEXlnlanU4
         yOWs90rj/qBkuxV9jT6nXRjCqRUYOqhaqGuEg2O33nzSisXvI2KvSb6E5fuuJZjXpnoO
         u9FPxM2NG+p650wIiKPG5EOWYrarlshx0zhvOftG32358MCE+PhzbEBBVBhyOBZ+vpZu
         rXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=JQXLpZ8DgBdQa36Cd/ldiogr0m33sflT491uuiFL70U=;
        b=uf7ALFGSOVMdWsaX94QCtF+QqGVVaifhkejHJuAiEwhpPDLebKk8OC3W8Bse4pif/n
         przSOM/tUjEJPH3jJjbt1AqOPicNtDGSXA4uETgyWrY4fp3JVvIVvxHGfIZsqBq6iS54
         P1Ws8kcdCeQeway7wY1bv2CurjEcSDCT0scHiZhZBXXTLGeR8/N7E5B5i1Qti8SV7Uyw
         pPPtAZQod3FxudEYh+aV2a4WY0/VvKxYv7E1GRFOLFW+lzoQfWDeqxuFWtk8R4+nQWxO
         xGdqcowtWDnrzO9yDN4IJ9Y9PfSKI1Yiwy2kowqXiX2NBeiMI2HFUTJLGonWTXnYJkEF
         1Llg==
X-Gm-Message-State: ACgBeo1jqz84MANJ5kTbzHPDOFgAuzjccxaEJAUAPSUW10HiWAcjWQnu
        2CGkIEApd14zGTkevBfm66eFQMdOVVUDhw==
X-Google-Smtp-Source: AA6agR4Aoh3E04dtgERjnFeySibeWp/0sBLbA7Q2fUJasG1cVxzBQdeDj2Wr1rXaKrKILNjem/cd4A==
X-Received: by 2002:aa7:cb83:0:b0:443:3f15:84fe with SMTP id r3-20020aa7cb83000000b004433f1584femr7081290edt.17.1660420451795;
        Sat, 13 Aug 2022 12:54:11 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id v1-20020aa7d641000000b004417eeff836sm3482478edr.53.2022.08.13.12.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 12:54:11 -0700 (PDT)
Message-ID: <59c7e9c6-9bf9-8287-9400-16244f769bf1@gmail.com>
Date:   Sat, 13 Aug 2022 22:54:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
Cc:     Jes.Sorensen@gmail.com
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Fix skb misuse in TX queue selection
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

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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

