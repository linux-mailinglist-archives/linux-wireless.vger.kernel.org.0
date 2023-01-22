Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B714A676F11
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jan 2023 16:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjAVPRV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Jan 2023 10:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjAVPRV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Jan 2023 10:17:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BEA2202A
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 07:17:20 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m15so7281825wms.4
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 07:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/6oN4D8UHBheOYlrv/F0Sa+XoeGmTo/qs5t3v+lNTQ=;
        b=eAFosRXzCHYlCEvB2pNRxA/9RgX/v1f/Dr30T/d+HMRRplH/A46iV4cSMT1QPqUWVO
         5tYrAqQt1QJiUt3c08Gg44+gSHpWqg4lMY7SKXlBvbdAqFGonhCa26PMpBNItuj48Dvg
         P2fJMQ01J702oAkmpdBHRuSJJNM+/P+DrYMFGEh3PpN0nR2gHLW1FcfCISzX6UXDy2yU
         qg2yEI9KPMbskgQRVhU6NR8cfEmmGocj8a00ZSP42BPW1kjBOM6GTpHM+ZxQZlLdAj4O
         e4xEXZO6+dQz/tzd18S5mLGq6WLYwOTkX7ddrLBFL40VvcL/6/ODqpTuc+12gTZY+9Cv
         OnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/6oN4D8UHBheOYlrv/F0Sa+XoeGmTo/qs5t3v+lNTQ=;
        b=6D2N1ZKKBeC2HYOAYqDWrGWS/4lDAR3uTd2lurhE0vzMxzZ4wLkGbm4k9QqYRIUSjo
         00By+gs6X8oYFpkgrRdjihAugX6RAFSD5dTyDpsgGtU1I7vB/jds5fxcOKc6pd59msCQ
         zwfiXVZMDKUUT1R9e1z5mb4xCu71R0kqDuajfkeBciP4nVN+Z0KoMX1paAnbVEXKUx5a
         yzu14MjuQB27A+uVbAFhGDR3xPdoisAwHIMz1lJUjoFvMCKJQgQ51RezRWvYc6GzMFui
         vEPiQ5VDYGO3SL4Gt7w9J594xkLfcjjVwi8Hqzv2n5Q6JrracFZSTGS+NIh83Oq4ccol
         6mvg==
X-Gm-Message-State: AFqh2kobNEmFJpYroBx56Siv0s8nWkX6ebUSAoS3M6aBcy3hQEooclCZ
        SNDcBryycMj/AKVWNg9uhqyWo3c/Lts=
X-Google-Smtp-Source: AMrXdXs0ai6y//eJgL3ouxVoxthtD9/hMRe875GxVqG+hMjVT7lPYEjeFHafgRuV2ZPCQONrK01fvw==
X-Received: by 2002:a1c:ed0a:0:b0:3d3:4a47:52e9 with SMTP id l10-20020a1ced0a000000b003d34a4752e9mr20861057wmh.15.1674400638701;
        Sun, 22 Jan 2023 07:17:18 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id e17-20020adfe7d1000000b0024cb961b6aesm2814826wrn.104.2023.01.22.07.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 07:17:17 -0800 (PST)
Message-ID: <03b0a8ab-c4d7-81a4-fb97-a6278525a694@gmail.com>
Date:   Sun, 22 Jan 2023 17:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] wifi: rtl8xxxu: fix txdw7 assignment of TX DESC v3
To:     Ping-Ke Shih <pkshih@realtek.com>, Jes.Sorensen@gmail.com,
        kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org
References: <20230119113146.9640-1-pkshih@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20230119113146.9640-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/01/2023 13:31, Ping-Ke Shih wrote:
> Type of txdw7 is __le16, so assign __le32 is wrong. Also, the
> TXDESC_ANTENNA_SELECT_C is defined for __le32, so shift 16 bits to fit
> the value. Compile test only.
> 
> sparse warnings: (new ones prefixed by >>)
>>> rtl8xxxu_core.c:5198:24: sparse: sparse: invalid assignment: |=
>>> rtl8xxxu_core.c:5198:24: sparse:    left side has type restricted __le16
>>> rtl8xxxu_core.c:5198:24: sparse:    right side has type restricted __le32
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 35dc777c1fba8..0869b95f1b3f3 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -5250,7 +5250,7 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
>  
>  	tx_desc->txdw2 |= cpu_to_le32(TXDESC_ANTENNA_SELECT_A |
>  				      TXDESC_ANTENNA_SELECT_B);
> -	tx_desc->txdw7 |= cpu_to_le32(TXDESC_ANTENNA_SELECT_C);
> +	tx_desc->txdw7 |= cpu_to_le16(TXDESC_ANTENNA_SELECT_C >> 16);
>  }
>  
>  static void rtl8xxxu_tx(struct ieee80211_hw *hw,

Tested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
