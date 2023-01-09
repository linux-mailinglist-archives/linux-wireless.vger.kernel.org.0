Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A22662A5E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 16:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjAIPqa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 10:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbjAIPpw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 10:45:52 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE37765C4
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 07:43:25 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id m7-20020a9d73c7000000b00683e2f36c18so5428702otk.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jan 2023 07:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dk0DIf3m8mAbPrZmJ7FA4rKsFWKveZQh5DZJPWwG10Q=;
        b=IvAS/2RRpoD6HLWNsjz2sTSejxq0r/thJ5+JV6cxos4fYHyqvgXt0BFuKhqKfSygXc
         ik2SkgMH/+LSCEid9NlwBm0vxzOI/fQOPay0w7H4Qq+xAgVPU6GFOr8evqemOAgFB/hv
         gR+jzFOpNifkTCpMqjdzcgqVynYm97YzCwuSgLpHldHNsa2fipVWyOyNg0MAxLYnMu7i
         ipqDnrkkPIwGbP6MF593t/G52b/CmuQbQjYRFC4r2nScENsvbv6Mn3EYCjwcztejKOCU
         BfrzFCvn5kp3dyKsRFa5g1R+OH1o9L4PztArVj+W68Jyo29AMRag4MPpeOuPZNwJk/IY
         lvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dk0DIf3m8mAbPrZmJ7FA4rKsFWKveZQh5DZJPWwG10Q=;
        b=e7V7HG3f1FIb3U2Th39tc2kpCx5H3qQgZa/SBVDVaonftcP9PQL0Nt0uHzogd7ELk6
         K/pfV58Sy2fhdf2tXWvsN0E5UPTlxyRnT2UzbJvWW1dKeDn3UutqN5ctvrGapKc8hZgd
         0ziBacx47otzAaYoyU+10dIByuB+BzcGHHBfqiHSAH9G14uKYVwA038KVGArOXC4omMc
         ye1tAWS9BjictxSorGy8ru5AgbvIjb2cG5+QD0VvI/pxfnKF+QDS61csPOCtrXqVanpn
         HVTyeMV4iSGtswYAnIqFL9wsXN+szICKO2oNxWIx3slsiv6EUXPV8z1mvcxhbfOh8yIJ
         W/Eg==
X-Gm-Message-State: AFqh2koNjynRIr/T8OnFXAkSee8bB0O/zSQE9GXtE/GHI1FQBJRhEefv
        RL7I5J2c/xMm6XsVRZk42sssGtdRUtM=
X-Google-Smtp-Source: AMrXdXsCo9IbAIuhu0R12wYIv4CfWGyRJgXt+ImyWl7YfAeRdnCTZZcHIHRqdD9kJ0JuUJUfuWezpg==
X-Received: by 2002:a9d:674c:0:b0:66e:6d33:fb32 with SMTP id w12-20020a9d674c000000b0066e6d33fb32mr29729864otm.26.1673278997558;
        Mon, 09 Jan 2023 07:43:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d6e12000000b006849b445543sm159134otr.18.2023.01.09.07.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 07:43:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <065cf0e5-2c64-56c6-ee66-a6b61be2dddf@roeck-us.net>
Date:   Mon, 9 Jan 2023 07:43:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] wifi: mac80211: change initialize for sk_buff in
 ieee80211_tx_dequeue()
Content-Language: en-US
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Wen Gong <quic_wgong@quicinc.com>
Cc:     johannes@sipsolutions.net, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20221212083607.21536-1-quic_wgong@quicinc.com>
 <20230105052647.GA2477583@roeck-us.net>
 <d28c6340-7ad2-d7f6-939d-3a1a057cb7da@wetzel-home.de>
 <3372b42f-b9bf-20e8-35f9-5370571a9e35@wetzel-home.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <3372b42f-b9bf-20e8-35f9-5370571a9e35@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/9/23 06:22, Alexander Wetzel wrote:
> On 09.01.23 15:05, Alexander Wetzel wrote:
>> On 05.01.23 06:26, Guenter Roeck wrote:
>>> On Mon, Dec 12, 2022 at 03:36:07AM -0500, Wen Gong wrote:
>>>> The sk_buff is only set to NULL when initialize, sometimes it will goto
>>>> label "begin" after ieee80211_free_txskb(), then it points to a sk_buff
>>>> which is already freed. If it run into the "goto out" after arrived to
>>>> label "begin", then it will return a sk_buff which is freed, it is a
>>>> risk for use-after-free.
>>>>
>>>> Fixes: ded4698b58cb ("mac80211: run late dequeue late tx handlers without holding fq->lock")
>>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>>>
>>> I don't see any progress on this patch. Is there a problem with it ?
>>> Did it get lost ?
>>>
>>
>> Looks ok for me. But I just noticed that my patch
>> https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
>>
>> should also fix the issue as an unintended side effect.
> 
> Sorry that statement was incomplete: It's only fixed when
> https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
> and
> https://patchwork.kernel.org/project/linux-wireless/patch/20230106223141.98696-1-alexander@wetzel-home.de/
> 
> are applied.
> 

Ah, yes. That is indeed correct. Let's just hope those patches will apply (and are
going to be applied) to stable releases since this is a real problem there which
does cause UAF and crashes.

Guenter

