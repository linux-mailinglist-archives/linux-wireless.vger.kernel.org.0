Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2595F9D72
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 13:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiJJLS2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 07:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJJLS1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 07:18:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636375C961
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 04:18:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e18so15445319edj.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FytBB2S8p06TV+Va2RaevItd+CeLs7ZiR2jwfERllcM=;
        b=XQmidA1fkI/h9/S9WfFMk6d84ZOpm5mqCLgjOapfzpEOgC+tWq8EgLawyyMrPL8KHo
         GZjeFqagimlGGxf09tgLWJOb6+stisy9081zOsibJbkh4j2M+Op14nUM1cuLbMFgwWaX
         r3M+EDu0ZeQeGVuNN4qNnyEXUbkkG4UQGEpu1l93pKe/iy9J9qgNLNyTgzX7q9tZMas2
         6oSf+zLps9bfzNNdyJbZraHUW/N+lGwpIzoFzi0x5NYiZ7WmGNVJHkJT94ryrr8MPOpe
         fBuN1Jgr91Kk2zvPWjSE3+u1270DSiDNBB23xm9bggnNe3N3DRinosxPvXcWXMFz4ZQz
         WiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FytBB2S8p06TV+Va2RaevItd+CeLs7ZiR2jwfERllcM=;
        b=PSlgqkH7+pxyVNwtlUB9RZ0fmfeaA4neMqxWNhsCv4f1/EZVyt7K6jX6NUQIbuPJ4s
         dKdoL0fCBdhEFo34CeHUu0jEn+lpyor2NggpkLKGvojEFJTy3o8Q/MV0/PGjGRC2/T2y
         wP4800F6UfHI06USCkIDXSDc9r41C4Y1j7TO7ecHpyATO6ekU6+HWQvvOHKb0YLBRInI
         O015iaMmqNgd+8XGnYeHlv++7YP5TaXZmDM9Xez17P/06fcYTXQU1Rw+1FYFgWI2bX1o
         FdN6IUMHZkUYE5XuDkb8n0UMA++WyRw6WDZOZVWAUX4Xw4Rrx8uHQ3UoWYjFLuTluxqo
         u3cQ==
X-Gm-Message-State: ACrzQf35Z0wHoLV3jFkyK17Uab6KLd8H+pmP90jFSP8fBKSJbo2fUmIW
        LgxAbSMpe+QE7eZPffdAOtE=
X-Google-Smtp-Source: AMsMyM5CKfqP4S7+pyZzrjCRRMFMwP19Zsm7YzQLZ7aTIRhUM3biu3E3/5VUae30JI2ISphUhjimbA==
X-Received: by 2002:a05:6402:50d4:b0:459:6f54:40df with SMTP id h20-20020a05640250d400b004596f5440dfmr17508534edb.255.1665400703712;
        Mon, 10 Oct 2022 04:18:23 -0700 (PDT)
Received: from [10.176.50.211] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090631c400b0078135401b9csm5201016ejf.130.2022.10.10.04.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:18:22 -0700 (PDT)
Message-ID: <14e43fcd-cb25-abe6-feb5-b41327a1e6df@gmail.com>
Date:   Mon, 10 Oct 2022 13:18:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 4/5] brcmfmac: Update SSID of hidden AP while informing
 its bss to cfg80211 layer
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        Double.Lo@infineon.com
References: <20220927034138.20463-1-ian.lin@infineon.com>
 <20220927034138.20463-5-ian.lin@infineon.com> <874jwsrojr.fsf@kernel.org>
 <4e602611-aed5-dfe7-6ce7-42d1fc7ca53e@infineon.com>
 <b43d934d-f3e8-9459-0096-11908df27c15@infineon.com>
 <87y1tupuqy.fsf@kernel.org> <9e166687-1d35-4216-5c2c-a0e783ead406@gmail.com>
 <51236a0c-5210-533b-7755-94145e6c5a1d@infineon.com>
 <b7518fd9-fcd1-0ddb-e1cc-2bc7687d3ab7@gmail.com>
 <065a6cc23f5553fd6d7d98b1e9c533d3f4e544a6.camel@sipsolutions.net>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <065a6cc23f5553fd6d7d98b1e9c533d3f4e544a6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/10/2022 11:41 AM, Johannes Berg wrote:
> On Mon, 2022-10-10 at 11:23 +0200, Arend Van Spriel wrote:
>>   Maybe I am mistaken and the SSID element for the
>> Hidden-SSID scenarion is different. Will check the 802.11 spec.
>>
> 
> hidden SSID isn't in the spec, but these days is typically implemented
> by a zero-size SSID element:
> 
>   00 00
> 
> In the past, sometimes it would also be done by some APs with a zeroed
> SSID element, e.g. for the SSID "myAP" you could see
> 
>   00 04 00 00 00 00
> 
> instead.

Thanks, Johannes

If both species are out there than it still means blindly copying things 
into the TLV buffer is not the proper thing to do here.

Regards,
Arend

> johannes
