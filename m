Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3E36B79D2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 15:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjCMOCh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 10:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCMOCW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 10:02:22 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000FA6F63D
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 07:01:52 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id ks17so8239172qvb.6
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678716108;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5OMdyyS2k8KTXKiBlEWQ5ebVeIHAL4Kj+R7i/qhKLOY=;
        b=J1ATotfaGVvMggmgMO4L+4OyRGHcrWlfXmxm6nwn9uk/k3PurK/O251btBXYZfvT6n
         5oxyPDVFOyJ8AWO01AHhQwum1jP4h/Cb0Nj3j6q+3QG2Eh3fc2tBqwogMnoImvOcsGQJ
         b+0qCHhpbBnX1CcP97DfyU1zwleWXjVU1KDFByW3u8HIgDiJcNmm/z9Sc3056zfDgPCG
         24uqD9dqQx04Rou7i9XWrSjhOs8tu1DiQ/fLUZ9hfV8owSY60RQTDO3ZM38iN0xgDyte
         D2q+OrL4tnuRAD449RQ/9DEDqPrwmMwv9lOwkF29gHASI5K7Wud/MowiWvG4S63rLmhX
         iMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678716108;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OMdyyS2k8KTXKiBlEWQ5ebVeIHAL4Kj+R7i/qhKLOY=;
        b=5C3LA7g80GuMQG4KjPuWktRuE/YgM4KGycwWWCUlEcWTY3Xl8Rgpz4i+XvNSQ4iFGA
         vSxl2pOahx2jqRuzxwyIXHyqQ3hG/pmXIhQz4T75qPd9JuELOLhpJppIx3scHX4EoL5V
         T7RknsTcIy2NIbsY4enq9uVcgbLcQwTn+XttjZPdIY9QKWULnRNy/cbF6jN9WP7b/W6X
         cnjrTp4NiIubVdN/p0zZZ9utNKT+C/dvUFT5ZKAbQBAlrFxtsFf67ZcNvp+5QPB6HJNB
         M0Hqb36BKQtfDrzOS9FMMAk7vlXDUhJ+qwXGHaq59eJPalkjemfp8gMiHyoszVj3Db7K
         Sn1g==
X-Gm-Message-State: AO0yUKUz+J6veBPNruy/ahwDExh/1s76cY76sbIK75qbYvA3r03n4XR4
        hTtOyb9BGUCOkVSjbk+atUUiOP173pM=
X-Google-Smtp-Source: AK7set9zMKtLtJrJfyzmBruen8jZ1pULCeRyCFMoyzY47j9Ut+cqGgSH+5l7onlhmYOIlW+Aqk62Zw==
X-Received: by 2002:a05:6214:e81:b0:5aa:f39c:36b6 with SMTP id hf1-20020a0562140e8100b005aaf39c36b6mr754783qvb.3.1678716107222;
        Mon, 13 Mar 2023 07:01:47 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:1102::1004? ([2620:10d:c091:400::5:377])
        by smtp.gmail.com with ESMTPSA id x20-20020ac87014000000b003c03ae61af9sm5641731qtm.3.2023.03.13.07.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 07:01:46 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <9a0dbabf-6ec2-a211-3c31-5d5bdacd9e62@gmail.com>
Date:   Mon, 13 Mar 2023 10:01:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] wifi: rtl8xxxu: RTL8192EU always needs full init
Content-Language: en-US
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>
References: <4eb111a9-d4c4-37d0-b376-4e202de7153c@gmail.com>
In-Reply-To: <4eb111a9-d4c4-37d0-b376-4e202de7153c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/13/23 09:42, Bitterblue Smith wrote:
> Always run the entire init sequence (rtl8xxxu_init_device()) for
> RTL8192EU. It's what the vendor driver does too.
> 
> This fixes a bug where the device is unable to connect after
> rebooting:
> 
> wlp3s0f3u2: send auth to ... (try 1/3)
> wlp3s0f3u2: send auth to ... (try 2/3)
> wlp3s0f3u2: send auth to ... (try 3/3)
> wlp3s0f3u2: authentication with ... timed out
> 
> Rebooting leaves the device powered on (partially? at least the
> firmware is still running), but not really in a working state.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jes Sorensen <jes@trained-monkey.org>

> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
> index 0bd1b527b420..4498748164af 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
> @@ -1820,6 +1820,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
>  	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
>  	.has_s0s1 = 0,
>  	.gen2_thermal_meter = 1,
> +	.needs_full_init = 1,
>  	.adda_1t_init = 0x0fc01616,
>  	.adda_1t_path_on = 0x0fc01616,
>  	.adda_2t_path_on_a = 0x0fc01616,

