Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613A05ED97F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiI1Jw4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 05:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiI1Jwv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 05:52:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1DDAA3D0
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 02:52:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 23so3647420edw.5
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dvvSZiZge4VYqu9UqdGhF+OKcZfu+P5LLz8GD/vQ0TE=;
        b=dUr2xq6AMgqbP/gxypD4QpeIQQ4HAmd6UXZG74HVjvTPBL6wpqUns9NwIJm8z9/nds
         CAZv/PiUrxC9L/Mlotp03QFUCfmRWIgvx2lRPLhX3+vaXAkbfL/Q7pLZ3LGmC8KmLmGH
         X9fOn1w7t+7ZnClVuAPn5pU0jG1/Hr265++ZK6oKBtofAfGOR0svsgK90/muxx0z+VaZ
         dpkfBFrUwkPK1Bobg61y7t9LdBC76/eC0/rjoZMIiOEZnADN/ijhKmLcSimLWqpVxA7X
         roaaNeKgo0aiA/0dgDxW1DjstrtGMwOdlQX5SyVqJRjGi1exdc8lxR+D9BNBQ3BNBtEy
         1Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dvvSZiZge4VYqu9UqdGhF+OKcZfu+P5LLz8GD/vQ0TE=;
        b=Bsp+TBL/8BVous+q6FXE8JEd91xIXkgLlCRYK+farFHR8oaLh/Ozl8AI6CAXKThxZp
         L4gz/zJw5stedqoxKK0gD0ItSN0xcpb7MjJ387dSSIw4mpNrDkJQOxnAHgDlGSF2G1vk
         fdS8vDSDcospNTf2ZCIxNLI3WLQbnbO5Z9n4Itj0Crpcn+OPiTu0PEj2ICI2McQM/x7Y
         slXjcuExbkxiFMtwPD9FwKMRQb1+eXoNcxHtmEy5dtIHrADfBKlONnAb3YlchFTZ27wi
         6l9hDBiATIpkub5O6ie0QfD3X9msUPDxwVBsLqO5SjwPXkgOVNUpCpJoEH4q5DVfG+Fl
         5Kvg==
X-Gm-Message-State: ACrzQf36s7/GJfM+8HMaQ2HeqrSU4Sjr6LnKzdoRjBcT0WvSqEbqHBxS
        ssz8nk9JcjfTZ7SRFvq/jXU=
X-Google-Smtp-Source: AMsMyM7e1Jac/gcZieEIdk6LNZmwBhycFJja+0ATwwiz3xMFopdGBLXAh+Bm+wgeQGicgqxXicQYEQ==
X-Received: by 2002:aa7:db0f:0:b0:457:d595:5f65 with SMTP id t15-20020aa7db0f000000b00457d5955f65mr4689184eds.139.1664358750599;
        Wed, 28 Sep 2022 02:52:30 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id d14-20020a50fe8e000000b0044e1b4bca41sm3070082edt.79.2022.09.28.02.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 02:52:29 -0700 (PDT)
Message-ID: <25f998e2-20e9-fcb5-2518-8aef1033ecc0@gmail.com>
Date:   Wed, 28 Sep 2022 12:52:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] wifi: rtl8xxxu: gen2: Turn on the rate control
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        linux-wireless@vger.kernel.org, chris.chiu@canonical.com,
        Barry Day <briselec@gmail.com>
References: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
 <78cec57b-2678-acf3-99b3-271e0f9bdbad@gmail.com>
 <ac73924f-4c52-b8e6-1628-e34fc673a35d@gmail.com>
 <5ba1e0f4-6eda-43bb-d426-e2a9447cd06e@gmail.com> <8735cb7v0c.fsf@kernel.org>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <8735cb7v0c.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 28/09/2022 11:39, Kalle Valo wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
> 
>> On 25/09/2022 19:53, Jes Sorensen wrote:
>>> On 9/18/22 08:35, Bitterblue Smith wrote:
>>>> Inform the firmware when connecting to a network. This makes the
>>>> firmware enable the rate control, which makes the upload faster.
>>>>
>>>> Don't inform the firmware when disconnecting from a network, because
>>>> that makes reconnecting impossible for some reason:
>>>
>>> Have you dug through the vendor driver to see what it does here?
>>>
>>> Thanks,
>>> Jes
>>>
>>
>> I hadn't investigated, but since you asked :) I looked into it today.
>>
>> The vendor driver doesn't do anything weird. Our report_connect
>> function *should* work.
>>
>> And it turns out it does work! I restored the original form of the
>> function to test something and reconnecting worked. I couldn't
>> reproduce the problem anymore. Not much has changed in rtl8xxxu since
>> the last time I tried this, so it was easy to find the reason: fixing
>> the queue selection [0] fixed the reconnecting problem. Before, it was
>> sending the auth attempts using queue 0x7 (TXDESC_QUEUE_VO). With the
>> queue selection fix it uses queue 0x12 (TXDESC_QUEUE_MGNT). Perhaps
>> queue 0x7 is not functional when the firmware knows it's not connected
>> to a network?
>>
>> I guess I have to send a different patch for this now.
> 
> So what should I do with this patchset? Can I take patches 2-4?
> 

Yes, please. They're all independent.
