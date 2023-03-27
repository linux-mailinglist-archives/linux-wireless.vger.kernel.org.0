Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777BA6CA536
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 15:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjC0NKX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 09:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NKW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 09:10:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AFE1985
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 06:10:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so5267118wms.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679922618;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2jdRxlzolcHq9c8mXZnEDbkHWM3ktLSW9ZyWph7gb1w=;
        b=oyLMs7KbhTZlNV5mp8zX4jOgZ5zhu+n+a74OA7r012luoc1fqI+R+m//gkj5cGW8XP
         EeHcCRXjseXoHObdWi2E7lVtXdIGJeFyGoOAbKYI+KJUYdQuX9xT+kQWs7vzkGEgH4WD
         /8RUmN7ZVMDWnessG/T5SD1IdXTK5tI20xd3qD/K5Ne71Z0u6TEG3zN32FwexgPUhjwg
         orlO7NW8p3qn5FKuI/EG9QFDhF0qKz8gfnulKRWs3vnnd33qPyw51keTMmC1WwSIMIrf
         kL2DoG0bRAfo5SmMGndkJd16HB21lLc6FVC6bvUnlkDyMOwX16rtbt4IST8DI0yDMmAx
         lfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922618;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jdRxlzolcHq9c8mXZnEDbkHWM3ktLSW9ZyWph7gb1w=;
        b=31o7sGYQUp4MdscfZH7C2aSHuG6ve7VTNAUtDk8yC7XdqYchjVyTruV9lx4/jnRa6Y
         m3UgDjT27GUCIZ4kgBkpUjBSMOXjMNxU6kHFwmyvHttaeNdY3z7JhyuYWEN/bZAl7wEe
         zSN8cY4kuz2iiORNRJZkPraAhKKjTootslmTILq2tVAPrehAWGGgPfeXz4ovj1j7x2ry
         pn6GLns+fbNStZITB++SoM0ZAAYO/QIQ8EU6RqiAobCQPr8H88ZhHVW61u+5kU2lyMLL
         rF0TNxjwyFzlmdP1aaUWC8xcV1sLaKd1QY4cAe5+tLB7RjL20Srxnliyg6waZ9DvLntf
         mMyw==
X-Gm-Message-State: AO0yUKUvCH33vEApwnd1pty34Wz1Bcxs9MOS40X//uGXCuhCpzqegdII
        qWAylZCZQu6II7CtPRCAOys=
X-Google-Smtp-Source: AK7set+PCAhivtiGWtl1FzwnFT6LpkNoePLdeC2bunyt0ckyCz4aKHb4pbjySnKv+FzrK/D2jNMzJw==
X-Received: by 2002:a1c:7516:0:b0:3ef:3ce6:7c69 with SMTP id o22-20020a1c7516000000b003ef3ce67c69mr9141491wmc.8.1679922618225;
        Mon, 27 Mar 2023 06:10:18 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003ede3f5c81fsm8978607wms.41.2023.03.27.06.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:10:17 -0700 (PDT)
Message-ID: <62bf7fa9-e041-c8d8-c63e-42b3674fc9d8@gmail.com>
Date:   Mon, 27 Mar 2023 16:10:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [RFC PATCH 01/14] wifi: rtl8xxxu: Add start_ap() callback
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-2-martin.kaistra@linutronix.de>
Content-Language: en-US
In-Reply-To: <20230322171905.492855-2-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22/03/2023 19:18, Martin Kaistra wrote:
> This gets called at the start of AP mode operation. Set bssid, beacon
> interval and send a connect report to the HW.
> 

Hmm, but why send a connect report when you don't have anything
connected yet?

> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index c152b228606f1..90b98b9dcbd9d 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4899,6 +4899,20 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  	return;
>  }
>  
> +static int rtl8xxxu_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> +			     struct ieee80211_bss_conf *link_conf)
> +{
> +	struct rtl8xxxu_priv *priv = hw->priv;
> +	struct device *dev = &priv->udev->dev;
> +
> +	dev_dbg(dev, "Start AP mode\n");
> +	rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid);
> +	rtl8xxxu_write16(priv, REG_BCN_INTERVAL, vif->bss_conf.beacon_int);
> +	priv->fops->report_connect(priv, 0, true);
> +
> +	return 0;
> +}
> +
>  static u32 rtl8xxxu_80211_to_rtl_queue(u32 queue)
>  {
>  	u32 rtlqueue;
> @@ -7026,6 +7040,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
>  	.config = rtl8xxxu_config,
>  	.conf_tx = rtl8xxxu_conf_tx,
>  	.bss_info_changed = rtl8xxxu_bss_info_changed,
> +	.start_ap = rtl8xxxu_start_ap,
>  	.configure_filter = rtl8xxxu_configure_filter,
>  	.set_rts_threshold = rtl8xxxu_set_rts_threshold,
>  	.start = rtl8xxxu_start,

