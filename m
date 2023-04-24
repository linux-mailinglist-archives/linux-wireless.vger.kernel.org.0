Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAB86ED604
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 22:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjDXUQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 16:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXUQ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 16:16:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8E6AB
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 13:16:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f19a80a330so16395395e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682367385; x=1684959385;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Zfj4drzBZISodVVEvLVzE/tLnnPKzm7ZXU8ovVtXfw=;
        b=WifsAsW2OqgW7jMATbtGZPsO9WpDVfNkuYdCsNkxZw2qj9ExYDYtgS8bcb16TXbdxq
         5P2LFcEaJ72BE24sQUSs/OYoefJ0Z5qE97vjDbZDlg4pau3g3/TpJz1w3hUCykldSVgo
         +4OxP2X0mC9MIi+/1jBAsQa595RpecnxlH5iz8ttjUg0nAP3duX9TPyWf2C7nqoyzzny
         neL6DIpYpbuJvUZmplAKCZ4W0G/gS6Y21qKpsrdCKHtoVHu3y2PeCz5w4N9JFMi9ANXx
         YeOpIH4mtcBIWD3tleBLAKKjcd7g8T+5dh8MPst8xkr+a0tuDfSrt26gu+2Hi7cMrHH4
         0SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682367385; x=1684959385;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zfj4drzBZISodVVEvLVzE/tLnnPKzm7ZXU8ovVtXfw=;
        b=MDhStj/oJ7/60vfWITi/IkE5PAR8/f2qiedgG4f0gcMqazrnqGam4g+x/I9c2zaIh/
         JXjwfxuMEpL2tVKBuN4RN61J7hJGQw7H4RWuwcLAWZdeokNCWy2I52E7BBxNz4HNoBAf
         3rsFSIqOrFREcsD3JoNPmh+RWmc8Q+HPQUeIj+/ocgTf4gSiTkN5+wtSYoNwvbcTl4+5
         xERcmN7ECKVYg2jXjA9iXMdbiDX5gH0b+TMypCwUU3ztax2zNRic3DFEb+ohv8STn5hg
         X9X/DxQ5wj043e6dHXWXgIe4u3zs1KxnmvsXmAZqkOYG4nNegjb0TaIs0b74WznDhtum
         99cw==
X-Gm-Message-State: AAQBX9egxaqNNgGqkLWxMKnEpgguqVYTqk1d35s3xG7ybDvWG2mSsy/s
        TZ0AQ2B+MfATKdCOek0BSi0wZe0vNZY=
X-Google-Smtp-Source: AKy350aBcn3WlSGMijeCtBN6Y35PzZiQwhv8MCMSz1zK2byidfa0uiPk7ayL4O/r90J8cRDieRunvg==
X-Received: by 2002:a5d:6690:0:b0:2fb:703d:1915 with SMTP id l16-20020a5d6690000000b002fb703d1915mr10580078wru.43.1682367385305;
        Mon, 24 Apr 2023 13:16:25 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id k3-20020a7bc403000000b003f1745c7df3sm13047952wmi.23.2023.04.24.13.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 13:16:24 -0700 (PDT)
Message-ID: <98355d5e-ac45-c522-3b8a-8cdc243b87cb@gmail.com>
Date:   Mon, 24 Apr 2023 23:16:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v2 18/18] wifi: rtl8xxxu: Set maximum number of supported
 stations
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
 <20230419100145.159191-19-martin.kaistra@linutronix.de>
Content-Language: en-US
In-Reply-To: <20230419100145.159191-19-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/04/2023 13:01, Martin Kaistra wrote:
> Set maximum number of associated stations supported in AP mode. For
> 8188f, the maximum number of supported macids is 16, reserve one for
> broadcast/multicast frames.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h       | 1 +
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 1 +
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index 64e823f216967..e996168d0bfd1 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -1946,6 +1946,7 @@ struct rtl8xxxu_fileops {
>  	u8 ampdu_max_time;
>  	u8 ustime_tsf_edca;
>  	u8 supports_ap:1;
> +	u16 max_sta_num;
>  	u32 adda_1t_init;
>  	u32 adda_1t_path_on;
>  	u32 adda_2t_path_on_a;
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> index 7dc2fd8aa5317..085721c734ae2 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
> @@ -1752,6 +1752,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
>  	.ampdu_max_time = 0x70,
>  	.ustime_tsf_edca = 0x28,
>  	.supports_ap = 1,
> +	.max_sta_num = 16,
>  	.adda_1t_init = 0x03c00014,
>  	.adda_1t_path_on = 0x03c00014,
>  	.trxff_boundary = 0x3f7f,
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index bf471c3f98b86..6d0c775244274 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -7464,6 +7464,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>  
>  	hw->wiphy->max_scan_ssids = 1;
>  	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
> +	if (priv->fops->max_sta_num)
> +		hw->wiphy->max_ap_assoc_sta = priv->fops->max_sta_num - 1;

The way you use it, "max_macid_num" would be a more accurate name.

>  	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
>  	if (priv->fops->supports_ap)
>  		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);

