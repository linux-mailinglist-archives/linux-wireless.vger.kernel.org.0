Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0F73FE70
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 16:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjF0Ojg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjF0OjN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 10:39:13 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8F3C0F
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 07:38:41 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a1e6022b93so1311340b6e.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876720; x=1690468720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=i6aIzahldBfrr+lsTEHcYUlv3JrLHJ10EvDhR4InKus=;
        b=POy7m/L2HlMKI10Qyre14+jnqQr78Cp9rwuCiANP+sHkOro4AaQQfVruJ419HFUA3T
         /PjI9AOTbt3kP45w3vnjXKLWYq5xRooYMedfMi07ekalRagQ+nr0rg6cyyT/8henVS0H
         sLdBcpizfpXu+cttlwWwhtvr45v+gs1WXgkyWHmCEd9KjR5PUoV2GMkfFEACnaaKbkLa
         VGJo5CAAKylO6X4C79fZIUc8OdpVWv/7YIZ9Hd8XmRD1Ghqmc5bI0zyviUuvvarJBeGg
         D+SH5YA+YN40ACexRzi+f34FkzKsimS+pucWdKjhWgoHBd8mCyYTXi3pYH2vFZDcYA70
         +iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876720; x=1690468720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6aIzahldBfrr+lsTEHcYUlv3JrLHJ10EvDhR4InKus=;
        b=fLIqZIOG106KbcJ6puJ6SQM6l5bl9I8JUhnFm/bRarrStOQ97Ol1LQ6vBTRpgiNYoa
         SrhoaBq/pb8AxdvCsv94fLRVsLux/h4ZLAmanc9QGS0EH78cqB4H6Qc/GHBdYeCWjsEA
         8ByqR2tg2yi8c7mlRM1V3n2zsGkazOiQsKhUu8BqwJ/Oz15Z4ybc8KshBLjJvU2N+K49
         SQlw2F938AVrfEEolL2HcoCr8QKH9wVyfvy8AyICaXVyjCaF9IvLOqwp9yG0CAu1y8W3
         KVpEcLxq8hFnkrZ8ibGssQwBKh4vyHV8t9uhFHneQEpOWnoVcB0JTzjrYkImmmUqLP17
         gWSA==
X-Gm-Message-State: AC+VfDyqtEJ24mbkvPmdpabg5qFG3UfondYEP8PRouZStyqopaFu2a8+
        yDbJ0IX9fsDK3SEnUNKEl/qSPpJSf14=
X-Google-Smtp-Source: ACHHUZ7yE9hGP6R1Ns2Inkw+Yc2kYEyk2n+KyNV8c0DlHCyndSfkTNFL7x9X13I4u99cK+Clb3O8Qg==
X-Received: by 2002:a05:6808:13c6:b0:39a:b1e4:ef28 with SMTP id d6-20020a05680813c600b0039ab1e4ef28mr41983058oiw.47.1687876719908;
        Tue, 27 Jun 2023 07:38:39 -0700 (PDT)
Received: from [192.168.1.128] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id e19-20020a05680809b300b003a05636f4a8sm3655178oig.29.2023.06.27.07.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 07:38:39 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <ef4750f8-8de5-dbfc-2c0b-3400d30d83e5@lwfinger.net>
Date:   Tue, 27 Jun 2023 09:38:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] wifi: b43: fix cordic arithmetic
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Jonas Gorski <jonas.gorski@gmail.com>,
        lvc-project@linuxtesting.org
References: <20230627130102.63665-1-dmantipov@yandex.ru>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230627130102.63665-1-dmantipov@yandex.ru>
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

On 6/27/23 08:00, Dmitry Antipov wrote:
> In 'lpphy_start_tx_tone()', 'CORDIC_FLOAT((sample.i * max) & 0xFF)'
> is invalid because it is (<32-bit> & 0xff) shifted right by 15 bits
> and so always evaluates to zero. Looking through brcmsmac's
> 'wlc_lcnphy_start_tx_tone()', the result should be masked instead,
> i. e. 'CORDIC_FLOAT(sample[i].max) & 0xFF'.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   drivers/net/wireless/broadcom/b43/phy_lp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/b43/phy_lp.c b/drivers/net/wireless/broadcom/b43/phy_lp.c
> index 0e5c076e7544..e8ef04e509aa 100644
> --- a/drivers/net/wireless/broadcom/b43/phy_lp.c
> +++ b/drivers/net/wireless/broadcom/b43/phy_lp.c
> @@ -1788,8 +1788,8 @@ static void lpphy_start_tx_tone(struct b43_wldev *dev, s32 freq, u16 max)
>   	for (i = 0; i < samples; i++) {
>   		sample = cordic_calc_iq(CORDIC_FIXED(theta));
>   		theta += rotation;
> -		buf[i] = CORDIC_FLOAT((sample.i * max) & 0xFF) << 8;
> -		buf[i] |= CORDIC_FLOAT((sample.q * max) & 0xFF);
> +		buf[i] = (u16)((CORDIC_FLOAT(sample.i * max) & 0xFF) << 8);
> +		buf[i] |= (u16)(CORDIC_FLOAT(sample.q * max) & 0xFF);
>   	}
>   
>   	b43_lptab_write_bulk(dev, B43_LPTAB16(5, 0), samples, buf);

This has not yet been tested, but it does need a "Fixes:" tag, and a Cc for stable.

Larry

