Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B67716B5C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 19:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjE3RmZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 13:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjE3RmY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 13:42:24 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDECB2
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 10:42:23 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-19e7008a20aso2105147fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685468543; x=1688060543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=M4nk/DiVaKq3nrnYejaxyUCwnlpA+NsM4gtCMchZHck=;
        b=cALBS0+KupXlQbezKmqTPQyWn+50g98y1laEUEyZ4b6NXV6qxAAYdcKp/HHNPY4OXB
         TVH6bRZgte1LyuU4IDpUqvS0x6HFwTaa653/uP5yFdagGkzG5CMboLYjUm8GHdxkdhqo
         RAa+b30cobe36ofBHQ2rqBeaml6PKy8CuJXO/DrUzh/FdsQ7H0RXrzR2bsQGdSkuNfhQ
         1YKUA4Q2oAYoL+ipQeSGH+H9PgoppJGPq+Tqb/e6HeCSqyNSRTk59bahQ74uiubc8QtD
         d+68WMUUcZodkn81d9h4MgMibvCuP+sSX+9xUQnX+J2xTbGd4sDsjidOqVJv+QVe5Rb9
         7L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685468543; x=1688060543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4nk/DiVaKq3nrnYejaxyUCwnlpA+NsM4gtCMchZHck=;
        b=HM3VpgYwHiATMGyndw8A42vVIxUcGJNibMvgOinnCKdt5innvkvPbwHXzQnEV6Kcw+
         9Gij+i6K/Otj5bhsuOM0lS6vvoTWGUSc1xwaW8YD0Njdp8kew+4cl7XR4wwAslwXDRaj
         i5XaRnzE5lMktmXVuvPkeQut3Vnh63DiX5UcylrYz2Ca4ZP9kAEbQXEF9II0T/q5HxjK
         xvJnwL0Oed48OhgAtYTlMBOUE4uCXD4GKhS7nZq5rpz0eByKY0+kKxkN9jU5mP1S45uJ
         erdPWzT9gcyhjv40bDXSg6J4KY9995wkCHwMKaKEOdyiWenXCJ1LLBpBbih0AAXtcnCN
         1wIg==
X-Gm-Message-State: AC+VfDwvZsLT+1W3hQ2ktgDdAXipy6kFaLUcNitL5BGi5e/fwWcWPhLc
        qsEusiQ1t0lg7NGO8xMmW1w=
X-Google-Smtp-Source: ACHHUZ7xEptipKmdeB9GS0lHvkCHN3Ii2oOIVumZt7YglUoxsBYuepptw66eqvJNa1lfMN4a63BhGw==
X-Received: by 2002:a05:6870:a444:b0:19f:4b8b:d2bf with SMTP id n4-20020a056870a44400b0019f4b8bd2bfmr1168523oal.3.1685468542697;
        Tue, 30 May 2023 10:42:22 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id n4-20020a056870a44400b0017ae1aede32sm5935785oal.46.2023.05.30.10.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 10:42:22 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <b747b45e-e176-4c55-0886-abfcb1e33717@lwfinger.net>
Date:   Tue, 30 May 2023 12:42:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] rtlwifi: rtl8188ee: drop RTX_POWER_BEFORE_IQK_A and
 RTX_POWER_AFTER_IQK_A reads
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Dmitriy Antipov <Dmitriy.Antipov@softline.com>
References: <20230530155446.555091-1-dmantipov@yandex.ru>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230530155446.555091-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/30/23 10:54, Dmitry Antipov wrote:
> Drop redundant reads from RTX_POWER_BEFORE_IQK_A and RTX_POWER_AFTER_IQK_A
> registers in _rtl88e_phy_path_a_rx_iqk().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitriy Antipov <Dmitriy.Antipov@softline.com>
> ---
>   drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
> index 12d0b3a87af7..380a813acda8 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
> @@ -1475,8 +1475,6 @@ static u8 _rtl88e_phy_path_a_rx_iqk(struct ieee80211_hw *hw, bool config_pathb)
>   	mdelay(IQK_DELAY_TIME);
>   
>   	reg_eac = rtl_get_bbreg(hw, RRX_POWER_AFTER_IQK_A_2, MASKDWORD);
> -	reg_e94 = rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A, MASKDWORD);
> -	reg_e9c = rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A, MASKDWORD);
>   	reg_ea4 = rtl_get_bbreg(hw, RRX_POWER_BEFORE_IQK_A_2, MASKDWORD);
>   
>   	if (!(reg_eac & BIT(27)) &&

I do not know the answer to this question either, but how does your tool know 
that the statements between the first read and the second have not caused the 
firmware to change the contents of the BB registers?

NACK for this patch

Larry

