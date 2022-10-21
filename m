Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE571607E4D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 20:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJUScW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 14:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJUScU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 14:32:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006C924FEEF
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 11:32:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b12so9099303edd.6
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZAZVGYhW6HvwLCdXq1rGEiN3HSsczjQdN1No7lh5zI=;
        b=DYcJ3+w62jJHN4iEJMSVtJb4EAK3DzOt6El5cQpqRL1jQAv88q0dhhI7K/hbo/z+yb
         AMOCuAEEssnAvbz58V83HXuYUiph43JFIaiB0D91Iw56RruGJnzkVt4IdBeE3AcsFYJ0
         IJ0M4vSK5cuATnQQTj9EJ0bAvJZPTR8a3JnVSBcTyGvCrdKywdFHbxhMTG9bzrMHvkjj
         rmV3/CGMl8rgSRTcVcd8Gyv2zMDDp+akyyrJD9XJtS+crtIm1b/35HiEzfttBeNsErua
         coAMRvMscfcPGGyIlGIVduenv5haVONDSpt/hMcflzES1ysK0VKfUwCj9VL24SGuq7d5
         Ru/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZAZVGYhW6HvwLCdXq1rGEiN3HSsczjQdN1No7lh5zI=;
        b=l1bBAnf1YgYnd4TB6sx8ImWqgZUPY1G+gkSD8UAhsyM2nVboVZyWTsrf+u6bPMOjsc
         g1hw3K7tRh6Umdut/0MAEnt3JuTAqiBYfOZWS1qO13JqrAlQRRV900LHet7zXw3q1+/Q
         UU9SgAHzWHYvfSLLXlA9S4mLK+wqWf/um7Z4lQlIChV1HY4zyp1Xh8/z9kaKHsP7TC+1
         TeO8mrmLmgR0o849JUFgKSV92Z3Ahx3v9rUJ/cQQ+NydPdKVmHzjRo8BFBTtnBMPc5P3
         8EflZpfMmnp7Ld2A2omJ5RySWbIJW57/1Nl6ykuFYEDWFogAD3s4PWoabT352ORm7u+V
         vOLQ==
X-Gm-Message-State: ACrzQf38eG3QQl9qY/F2gNBTG0PW4a4FuXtunhj+7g7J73ysRUcYSYJW
        wRCR2ZZOjrA3lGzPNyPf6oU=
X-Google-Smtp-Source: AMsMyM4dk3vFJdENp2bywtLCtJUhERUueBc6qz6TbHpxupal+XAYZn17kiYfkAmN1UitdUhfiQzP7A==
X-Received: by 2002:a17:907:75c8:b0:78d:b646:e768 with SMTP id jl8-20020a17090775c800b0078db646e768mr16594912ejc.432.1666377137473;
        Fri, 21 Oct 2022 11:32:17 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id m3-20020a170906160300b0078194737761sm11828824ejd.124.2022.10.21.11.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 11:32:16 -0700 (PDT)
Message-ID: <c3540f87-b124-2642-f53e-aa15704a54e8@gmail.com>
Date:   Fri, 21 Oct 2022 21:32:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/5] wifi: rtl8xxxu: Add central frequency offset tracking
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <2b29b6d9-c17e-76d6-c32f-630f24b407b7@gmail.com>
 <6a91fd1b8d5e4bf3910366121ed92f3b@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <6a91fd1b8d5e4bf3910366121ed92f3b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21/10/2022 08:47, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Monday, October 17, 2022 1:27 AM
[...]
>> +
>> +	val32 &= ~0x007ff800;
>> +	val32 |= (crystal_cap | (crystal_cap << 6)) << 11;
>> +	rtl8xxxu_write32(priv, REG_AFE_XTAL_CTRL, val32);
> 
> This could be clear:
> 
> #define XTAL1 GENMASK(22, 17)
> #define XTAL0 GENMASK(16, 11)
> 
> val32 &= ~(XTAL1 | XTAL2)
> val32 |= FIELD_PREP(XTAL1, crystal_cap) |
>          FIELD_PREP(XTAL0, crystal_cap);
> 

Ah, so that's what FIELD_PREP does.

>> +			if (priv->cfo_tracking.packet_count == 0xffffffff)
>> +				priv->cfo_tracking.packet_count = 0;
>> +			else
>> +				priv->cfo_tracking.packet_count++;
> 
> 'packet_count' is u32, so 0xffffffff + 1 will become 0. Then, just
> 
>    priv->cfo_tracking.packet_count++;
> 

I thought so, but I'm not *that* familiar with the C standard,
so I left it how I found it in one of the Realtek drivers.

>> +
>> +	if (crystal_cap > 0x3f)
>> +		crystal_cap = 0x3f;
>> +	else if (crystal_cap < 0)
>> +		crystal_cap = 0;
> 
> crystal_cap = clamp(crystal_cap, 0, 0x3f);
> 

Right, that's better.

Thanks for the reviews. I'll implement your suggestions.
