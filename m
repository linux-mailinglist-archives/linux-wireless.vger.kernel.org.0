Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B8C4D7852
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 22:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiCMVGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 17:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiCMVGq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 17:06:46 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9008D63522
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 14:05:37 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id j83so15439877oih.6
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3FzPBHoeEWSzvGJri+hD2pXKsnadUImHhvFi1YeE69g=;
        b=LHL2XGxGlpk7SAjCc0Vc+QsNflKqWwsTPhPGXWgYC7l/9e/d5SL+4sDFA3u11R9aXv
         4AleWN+VjIkGTDFHL5EiMTTYXE2KWO4+ZM36HC6WeOAxTLQ5WTUarb2UUt5NQPidmD15
         51pJyXcYoek0NPUuZozx3RNaMmcmpkFfBQdbxAe756k8u3f76khMJyJVFiqsh3snV0lO
         dsitelThQ+K6px52JXDyx7oajL4GITZGL+slxNYwcg9dtRderLkarD79ExxLZLV4tJjI
         yIa4btPDjbOgxz7wPEb9U58xRqyIqcHDVdnDOuyYdMEE5Yyue5JjjaQe5gBkTqnTzT3F
         U9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3FzPBHoeEWSzvGJri+hD2pXKsnadUImHhvFi1YeE69g=;
        b=OKiMNxNnUWCye+l5qAa7bY5sRfGvxvtho+EGUO9T/clzclphGFVBGQGyaki4h8wBnO
         pxfH8IQ5RobbpagLSiRE6JBqJ1XppNHAJdLa0p7vYW605LuAzUoy7bSSAs4xd/PXflSC
         DNbPN2GdSXCoW3K6Cr9ybShRJKK2JBUJFJoHb6gf0CpkmVvxhoaCf9k9vnn56JRfSUwN
         Eiz0bNbKqdi6UvKjCNKdKJxxb2qja/r9Ce1hsqJnZASn6O5Vc/jeQXXRqSiJBKgI0mdR
         QNxZvGY9eGl1elmWA1g7KuSQ/8mD/m0Mj4fGMFaCDIBRJtp/gZp+68peMyx6JIkccPq+
         omQQ==
X-Gm-Message-State: AOAM532Zbobjkj+BwLfWE/Zn6Cuc4M/BMS/OXtSn1dxJA8bjxQKwHcEW
        UVB8pXvantU70gCqmADuaUkovVXbkww=
X-Google-Smtp-Source: ABdhPJzFYRL2aoV7FDBHpAqdArj7/vvL0M0jG7vB06bmu5bkqaaQkAyL5agwnvAfl4YRaEyzSD2mGg==
X-Received: by 2002:a05:6808:55:b0:2ec:a4ae:fdde with SMTP id v21-20020a056808005500b002eca4aefddemr6846255oic.106.1647205536927;
        Sun, 13 Mar 2022 14:05:36 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1064? (2603-8090-2005-39b3-0000-0000-0000-1064.res6.spectrum.com. [2603:8090:2005:39b3::1064])
        by smtp.gmail.com with ESMTPSA id g105-20020a9d12f2000000b005c961f9e119sm623489otg.35.2022.03.13.14.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 14:05:36 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <296556b0-e58e-31f3-566f-86ea33fc02f6@lwfinger.net>
Date:   Sun, 13 Mar 2022 16:05:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] rtlwifi: rtl8192cu: Add On Networks N150
Content-Language: en-US
To:     Jonathan Teh <jonathan.teh@outlook.com>,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>
References: <DBAPR04MB7366E8014ECA839E1F5CCE29920E9@DBAPR04MB7366.eurprd04.prod.outlook.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <DBAPR04MB7366E8014ECA839E1F5CCE29920E9@DBAPR04MB7366.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/13/22 15:10, Jonathan Teh wrote:
> This is an RTL8188CUS device, identifies as model N150MA-199WWS.
> 
> Signed-off-by: Jonathan Teh <jonathan.teh@outlook.com>
> ---

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry

>   drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
> index b53daf1b29f7..876c14d46c2f 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
> @@ -334,6 +334,7 @@ static const struct usb_device_id rtl8192c_usb_ids[] = {
>   	{RTL_USB_DEVICE(0x04f2, 0xaff7, rtl92cu_hal_cfg)}, /*Xavi*/
>   	{RTL_USB_DEVICE(0x04f2, 0xaff9, rtl92cu_hal_cfg)}, /*Xavi*/
>   	{RTL_USB_DEVICE(0x04f2, 0xaffa, rtl92cu_hal_cfg)}, /*Xavi*/
> +	{RTL_USB_DEVICE(0x0846, 0x9042, rtl92cu_hal_cfg)}, /*On Netwrks N150MA*/
>   
>   	/****** 8188CUS Slim Combo ********/
>   	{RTL_USB_DEVICE(0x04f2, 0xaff8, rtl92cu_hal_cfg)}, /*Xavi*/

