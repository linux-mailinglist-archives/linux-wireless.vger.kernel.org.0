Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0735E7D9AF3
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 16:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbjJ0OPI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Oct 2023 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0OPH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Oct 2023 10:15:07 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5CB121;
        Fri, 27 Oct 2023 07:15:05 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cbd1d7e04so14521061cf.1;
        Fri, 27 Oct 2023 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698416104; x=1699020904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yg87veBdY0tY4XFSjr+wNPzOvhvzS0mNaVmWdiTVM3E=;
        b=AnekxiPujceLQ+lP8A75edKykmetdMFSK2a+5Az08YQa2nIT5i5tym2r4Cnh3HDBtc
         yIab7+zgKL/02k/sEseZ2JLx1122q+TbTC7OUXKD+R4Lcb2UpqcgqAUkqHIFdFcx/VgV
         lqQawXbNw2ceHFhLnvs1LFyPzmkEgyy1XyeA48RrU9bTnzJAiYTWrPWsjIvWp950HE4S
         x6zNZpOXEO2gT8Vb/IBMsNrjL8OsqJStj5i5sdiYG0O3nIrTXFJvxrgF06dFgja7SNBx
         LuKLoStMiE/Xasd3wJ/riPQyH1uUP7upxMC1X+H2NuwUrUZVQ+dv4r606BoocFobxSUi
         76Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416104; x=1699020904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg87veBdY0tY4XFSjr+wNPzOvhvzS0mNaVmWdiTVM3E=;
        b=nbU3xCo9WMM7I4n6VM+JwKgPmxZxcALTpWOBLqkyKRqFcS/D9NKaUt+Vbs/imtA/dN
         /Br4MRVI9peTGwKSD99IQBJSvUE4Ay/OwuRqdYKR4UBcsFXSRKluINMwV5dLZYYVPxNR
         kjh46oQeY8V5qvraAub9aIVnJJgYqf9jvND/X6OqaUilbAgYs1EcArD2BSg/6/+H7iVF
         lmZkHzYNaD3Iu6SYAp7iN0fE8s/Q4wf2FffenuWwJGlP2zE8QPv8sEDpWn10aNs8qF8y
         QXLYNEiwhjEAf/sO+TO5fiLJRhxzBViOHMfKe6n1zjflB1cjir60tYISlvsehhDwoOCB
         MJuA==
X-Gm-Message-State: AOJu0YxqL6vVwjANKaFRizAJty/NqIxlEA7AGIKGhBT5GmVOkAupDeO7
        T6xdFfINFzP/xxhjhHFAjC+NDnnyPJXbig==
X-Google-Smtp-Source: AGHT+IGx8EGswR918ba/TV6YTHRay0TxyRbnouvKN/xV7ldNfoBJMz8LuTJ4g2Z6olnHdFzPjLsEnA==
X-Received: by 2002:ac8:5882:0:b0:41c:d562:cee0 with SMTP id t2-20020ac85882000000b0041cd562cee0mr2951497qta.57.1698416104396;
        Fri, 27 Oct 2023 07:15:04 -0700 (PDT)
Received: from ?IPV6:2001:470:8:94a::251? ([2001:470:8:94a::251])
        by smtp.googlemail.com with ESMTPSA id s21-20020a05622a1a9500b0041b381b9833sm607923qtc.75.2023.10.27.07.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 07:15:03 -0700 (PDT)
Message-ID: <323e1669-e145-21bc-a124-923303ad2138@gmail.com>
Date:   Fri, 27 Oct 2023 10:15:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 1/4] net: fill in MODULE_DESCRIPTION()s in
 kuba@'s modules
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        linux-wireless@vger.kernel.org
References: <20231026190101.1413939-1-kuba@kernel.org>
 <20231026190101.1413939-2-kuba@kernel.org>
Content-Language: en-US
From:   Jonathan Bither <jonbither@gmail.com>
In-Reply-To: <20231026190101.1413939-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 10/26/23 15:00, Jakub Kicinski wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Fill it in for the modules I maintain.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: linux-wireless@vger.kernel.org
> ---
>   drivers/net/netdevsim/netdev.c              | 1 +
>   drivers/net/wireless/mediatek/mt7601u/usb.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 2eac92f49631..aecaf5f44374 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -470,4 +470,5 @@ static void __exit nsim_module_exit(void)
>   module_init(nsim_module_init);
>   module_exit(nsim_module_exit);
>   MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Simulated networking device for testing");
>   MODULE_ALIAS_RTNL_LINK(DRV_NAME);
> diff --git a/drivers/net/wireless/mediatek/mt7601u/usb.c b/drivers/net/wireless/mediatek/mt7601u/usb.c
> index cc772045d526..d2ee6540ebb2 100644
> --- a/drivers/net/wireless/mediatek/mt7601u/usb.c
> +++ b/drivers/net/wireless/mediatek/mt7601u/usb.c
> @@ -365,6 +365,7 @@ static int mt7601u_resume(struct usb_interface *usb_intf)
>   
>   MODULE_DEVICE_TABLE(usb, mt7601u_device_table);
>   MODULE_FIRMWARE(MT7601U_FIRMWARE);
> +MODULE_DESCRIPTION("MediaTek MT7601U USD Wireless LAN driver");
Did you mean USB?
>   MODULE_LICENSE("GPL");
>   
>   static struct usb_driver mt7601u_driver = {
