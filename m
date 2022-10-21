Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8800607548
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 12:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJUKop (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 06:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJUKon (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 06:44:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED03FA3B
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 03:44:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso4719100wma.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 03:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUmV9D7S6DNL4i2POW+8bktl/5t6qvSwc6uyB9wu3xk=;
        b=LHbCnO/dYR37I38sPqEtmzSX6qHP9n1UF26l/ZHnkaqc20g09vZGPi9BLIJalWd8vV
         lVbxUSzjva5Pj3QNZMiwyhoCHS1wCfbUMvIWKnHL9h9CBqYNaQ3ZJoQzC805RkC8X78L
         1N9akEuy5N3hIhctVOB1LU1PdiyZn5QBwyu1jHcWJ/KnYnal5YMxXc+WMLKYD2kZhemh
         y/gH0MZgblO7k2rdSgaK00U2+MRxVA9Ckix+pITnEWt+k6HR9HlRx0xCXrMy7oRCiEjo
         Z4Q7g7kivqEwfkihWgdDQvXbVhLw4ABAPS0t89J1n9ima2vGWWdopguVKXZXle5YaNQ0
         2rnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUmV9D7S6DNL4i2POW+8bktl/5t6qvSwc6uyB9wu3xk=;
        b=B1Pq635yCVv36s8S/VALIEUDgQxrFoDd/w4J+2Kih4T7JHHWTWwwcOAC9yBRDolwhA
         gHMhJRhEr+1EMbeDSPumtJ/pguBtZMkeJtC2Tw2mXh0GZHj/0ivtmPEzgw2hwin0M+Ms
         rnaEFilOYDAFlieq3kl2i7XydEUZ482+D6nXq9xcM28P027pAo2Fo1epj8ZgZ6kaAAgn
         5o/8eFGHYC8DUFa0kFx57LEp2+KY5osdsAhd7v4j7/gkyEi6XDt2bxeCCib8nraaXJnC
         HEb3w8KIyQM4leFH5rYC8muJr5+olmDO2+BdoPBAUlzUu3UOYaiKH8CWJ3W7hGCs2ipM
         D+Nw==
X-Gm-Message-State: ACrzQf1cAHiOTLDH5NAHCbzoXIntrV8O92Oxx1XJDtQQMSwK81pvqI1S
        41kysxz4pj7C9yR1ijQBL7wrLQG5jfk=
X-Google-Smtp-Source: AMsMyM4Nh4nrvfx0MrLGfVB3nXCghYIs1lkcp5SMj2qDd8rRHq3dNtQxd59AKEpeVdJRJtSx3t9LOQ==
X-Received: by 2002:a05:600c:1553:b0:3c6:e12d:6f32 with SMTP id f19-20020a05600c155300b003c6e12d6f32mr27506991wmg.109.1666349080597;
        Fri, 21 Oct 2022 03:44:40 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id bj19-20020a0560001e1300b002238ea5750csm1599478wrb.72.2022.10.21.03.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 03:44:40 -0700 (PDT)
Message-ID: <3d047bb4-276c-026a-e292-f0a1f011b9f4@gmail.com>
Date:   Fri, 21 Oct 2022 13:44:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [linux-next:master 637/2652]
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:432:7: warning:
 variable 'hw_ctrl_s1' is used uninitialized whenever 'if' condition is false
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-wireless@vger.kernel.org
References: <202210211531.zEaM6hBM-lkp@intel.com> <87edv1lhad.fsf@kernel.org>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <87edv1lhad.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21/10/2022 11:20, Kalle Valo wrote:
> + linux-wireless
> 
> kernel test robot <lkp@intel.com> writes:
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>> head:   4d48f589d294ddc5e01d3b0dc7cecc55324c05ca
>> commit: c888183b21f36a247bb166ca9365705611bea847 [637/2652] wifi: rtl8xxxu: Support new chip RTL8188FU
>> config: i386-allyesconfig
>> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c888183b21f36a247bb166ca9365705611bea847
>>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>         git fetch --no-tags linux-next master
>>         git checkout c888183b21f36a247bb166ca9365705611bea847
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/ drivers/net/wireless/ath/ath11k/ drivers/net/wireless/realtek/rtl8xxxu/
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:432:7: warning: variable 'hw_ctrl_s1' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>>                    if (hw_ctrl) {
>>                        ^~~~~~~
>>    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:440:7: note: uninitialized use occurs here
>>                    if (hw_ctrl_s1 || sw_ctrl_s1) {
>>                        ^~~~~~~~~~
>>    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:432:3: note: remove the 'if' if its condition is always true
>>                    if (hw_ctrl) {
>>                    ^~~~~~~~~~~~~
>>    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c:415:45: note: initialize the variable 'hw_ctrl_s1' to silence this warning
>>            bool do_notch, hw_ctrl, sw_ctrl, hw_ctrl_s1, sw_ctrl_s1;
>>                                                       ^
>>                                                        = 0
>>    1 warning generated.
> 
> Bitterblue, could you submit a patch to fix this, please?
> 
There is one from Colin Ian King:
https://lore.kernel.org/linux-wireless/20221020135709.1549086-1-colin.i.king@gmail.com/
