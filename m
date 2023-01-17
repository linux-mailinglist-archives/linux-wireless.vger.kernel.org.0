Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF95466D65E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 07:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbjAQGhX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 01:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjAQGhW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 01:37:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA1A1E28A
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 22:37:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d8so201104pjc.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 22:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IswnaFn7cR4ZkSdf9jjOPE9ALLrECiM1CkBW098zMK4=;
        b=Hwq3JCVqHbksgwzF1n2KC4NM9H8CbNGLrWlhZ/s2xbnBadSNKbr592/YLYqR51OdlS
         nE9HZqlYdZ+yimozFk+f53Wat126xAqiz6FDZi1LwsFA/JlOv//LWpYzetyQnt8pTApL
         vyhmEsuWP4YQCsTrdptHJ4t5cil1jTQJh2954=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IswnaFn7cR4ZkSdf9jjOPE9ALLrECiM1CkBW098zMK4=;
        b=Ni1uaBqj01c9NfrzzjjvffASR6pMbqmTUvCiKjHLXMJjPelaqYXqiS64JNu3gO50PP
         hjjq8Q10Vzaa6NMkLAKv5G6n7BVpvmU1SiOpOt0lKtx2o6jEZJOxJyxLjNVuj9N1k8rd
         eQBQ3QrFTjxNKH8AhDm2M9OcTN2Zwjq7di49oE09ETYAYCA4rqqjy8B1QulKJzvCiABu
         Ek0gwj2QhOYvIg3G4Xb94cMN+1X7XvkqBCmDF04D+E29ysApfP1XENMCbTEfno7r+igz
         dR08pxB718YBu2sldFUu5Gt2NvhodXm4X75Bns0+22PyfdZSzoA9vQK33CZFCPMc1nXl
         FUCA==
X-Gm-Message-State: AFqh2kqBh6Tf9v0t0kGzQZSt8jDYeOadiVHRYFXP8BCMXqGGXSz8NAgZ
        r5UCVDGeh0QCD++7sP1+1FwaEg==
X-Google-Smtp-Source: AMrXdXu0ottuuiFGoJumE1YUuFKMjIxw/VEdlVjsUgyAMFsb3uU2qwF4vrTGQYZ6JAjJFK2A8+Zk5A==
X-Received: by 2002:a05:6a21:2d88:b0:ad:79bb:a417 with SMTP id ty8-20020a056a212d8800b000ad79bba417mr2169798pzb.9.1673937440887;
        Mon, 16 Jan 2023 22:37:20 -0800 (PST)
Received: from [192.168.1.33] ([192.183.212.197])
        by smtp.googlemail.com with ESMTPSA id h22-20020a17090acf1600b00228e0a8478csm10257616pju.41.2023.01.16.22.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 22:37:20 -0800 (PST)
Message-ID: <dc527fe5-d182-37fa-2ee2-8ee5ac9f4882@schmorgal.com>
Date:   Mon, 16 Jan 2023 22:37:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Dan Williams <dcbw@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        "libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230116202126.50400-1-doug@schmorgal.com>
 <20230116202126.50400-2-doug@schmorgal.com>
 <651627a8399f4cb49feb336e6f5bd9dc@realtek.com>
From:   Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v3 1/4] wifi: libertas: fix capitalization in mrvl_ie_data
 struct
In-Reply-To: <651627a8399f4cb49feb336e6f5bd9dc@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/16/2023 7:39 PM, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Doug Brown <doug@schmorgal.com>
>> Sent: Tuesday, January 17, 2023 4:21 AM
>> To: Kalle Valo <kvalo@kernel.org>; David S. Miller <davem@davemloft.net>; Eric Dumazet
>> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
>> Cc: Dan Williams <dcbw@redhat.com>; Simon Horman <simon.horman@corigine.com>;
>> libertas-dev@lists.infradead.org; linux-wireless@vger.kernel.org; netdev@vger.kernel.org; Doug Brown
>> <doug@schmorgal.com>
>> Subject: [PATCH v3 1/4] wifi: libertas: fix capitalization in mrvl_ie_data struct
>>
>> This struct is currently unused, but it will be used in future patches.
>> Fix the code style to not use camel case.
>>
>> Signed-off-by: Doug Brown <doug@schmorgal.com>
>> ---
>>   drivers/net/wireless/marvell/libertas/types.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/marvell/libertas/types.h
>> b/drivers/net/wireless/marvell/libertas/types.h
>> index cd4ceb6f885d..398e3272e85f 100644
>> --- a/drivers/net/wireless/marvell/libertas/types.h
>> +++ b/drivers/net/wireless/marvell/libertas/types.h
>> @@ -105,7 +105,7 @@ struct mrvl_ie_header {
>>
>>   struct mrvl_ie_data {
>>   	struct mrvl_ie_header header;
>> -	u8 Data[1];
>> +	u8 data[1];
> 
> data[]. see [1]
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Hi Ping-Ke,

Thanks for the link. There are several other cases of this same syntax
for flexible trailing arrays in this file, so I will update this patch
in the next version of the series to fix them all.

> 
>>   } __packed;
>>
>>   struct mrvl_ie_rates_param_set {
>> --
>> 2.34.1
> 
