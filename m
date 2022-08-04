Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728F6589F83
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 18:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiHDQrb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 12:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiHDQra (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 12:47:30 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488AF1B7B6
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 09:47:29 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i84so125012ioa.6
        for <linux-wireless@vger.kernel.org>; Thu, 04 Aug 2022 09:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=13zAhPFqYptAMYO+yTsXCLsMUg9Bk2fdg2na4GDfxbQ=;
        b=SJD6PEmywG7k8htfKj53McptRoCw7aNrP9I37H7+teKTx9yYH+vltEgO8kMbLfYjMy
         SFtoC007QTcSKbouRrk6xczrYkTgL/L8TvzLL6GFc485SjDY0dGcJ/0Ry9/dVJgmgI7t
         ekykioGdU+8P/EsORNtvSMJpDnMYiT7ALKUzqlyt9a5ddMnvr7E8c3VeSOfD4PV1XqXf
         7LQ8fbShzCb788pIqFpzMPLV7VS4DnnEiDbzdRfyJ6Yia2JaFAbwjlL2XvnOj6zOL0Ii
         0ZCSrLrHLtB4mkTsweJnSNpBnBLwH3VAMOMh900rrPbEaQeug2a54Rh4EVrmHnSW0mL1
         XBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=13zAhPFqYptAMYO+yTsXCLsMUg9Bk2fdg2na4GDfxbQ=;
        b=5zGY86qmkuWNpdG3M50cDxDk8z9OAmGvjqrwQk2n8EM0btBxV3nGBJVBrkgJ89kYBd
         yNHJJwcJOw7aiK0qBptTWEcPAc6zs5XMtC7mU04XI2CkSjh4xj8HeJg0mkl/8DbOvCtr
         vnNHACwOJa/2q74jMa2BNeOP1AK27zxVqzhKMB0u+dG8ekR0CeLWwkOk97pjDv+ADgew
         d4ZrL6mtlu5kRk2mRcyw1K/MGsMPYWCIGwUKZxmvMA5c8e5idFiBg99bcOxv7QZroYOk
         XYCGBN25arZQAqTZobnz14S15tjdFdTODM3LegVqsNCThxhOqMGOAYj/7dAhXWYeNs0S
         Wj/Q==
X-Gm-Message-State: ACgBeo0cyvUgxuBHt7u2Dqp50CdI/nzHJf1IwTOad+tHeSzcDrcruyn7
        BIOBqSCPQ84L1EYGzvr3q6yeuUxnIBMJOQ==
X-Google-Smtp-Source: AA6agR4ci8+5UPj/KsIGC34fst8dsDiMJ745KPArRfp8uD/gVXH7fraxmeOWHoZ/AU7SnU2IkuU3vw==
X-Received: by 2002:a05:6638:d8c:b0:341:4d9a:7d43 with SMTP id l12-20020a0566380d8c00b003414d9a7d43mr1283467jaj.126.1659631648578;
        Thu, 04 Aug 2022 09:47:28 -0700 (PDT)
Received: from ?IPV6:2604:2d80:0:d300:e347:f842:8fae:579b? ([2604:2d80:0:d300:e347:f842:8fae:579b])
        by smtp.gmail.com with ESMTPSA id c7-20020a92cf07000000b002de990656f5sm603111ilo.32.2022.08.04.09.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 09:47:28 -0700 (PDT)
Message-ID: <8155d519-8ae3-6fb2-ca44-552541b3fedf@gmail.com>
Date:   Thu, 4 Aug 2022 11:47:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
        gregory.greenman@intel.com
From:   dmkgrim80 <dmkgrim80@gmail.com>
Subject: intel ax200 problem after iwlwifi source change from 5.6 to
 5.7,current
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello I have a issue I would like resolved


            Hi, I have a intel AX200 m.2 installed in a old Acer Aspire 
E15 E5-553-11PT

I am having some issues with kernels newer than 5.4 and possibly 5.6.

I am using  longterm 5.4.x kernel and it works I have examined the code 
for longterm and stable kernels.

Some kernels give me ADVANCED_SYSASSERT which if I understand is 
firmware crash.


Willing to try and do testing to get my intel AX200 on my laptop till 
its working.

I have tried using git for kernel code but the kernel code seems bugged 
or something.

I can compile kernels on my slackware 15 and debian 11.3 that wont 
compile in git for some reason.

using longterm kernel 5.4.x at moment which the intel AX200 on my laptop 
likes.

git bisect kernels is time consuming been trying it with previous 
unsuccessful results.

I also have a desktop Asus motherboard with built in intel AX200 same 
revision and model 01a and

0x2723, 0x0084 the desktop works with differing results it works on 
5.10,5.15 and newer

though I recently got ahold of 0x0080 and 0x4080 hardware a netel and 
deal4go manufacture intel AX200 with same results on laptop so its 
either code or my laptop or both. Dont have financial means to test 
other laptops with m.2 wifi/bluetooth. as is sending back 2 
wifi/bluetooth adapters.


Im no good with git and bisect nor am I a programmer though took some 
classes. tried git clone couldnt get kernel 5.6 to either make or 
install modules. the kernel code in drv.c of 
kernel/drivers/net/wireless/intel/iwlwifi/pcie/


Works in Windows 10,linux kernel 5.4.x and iwlwifi code is same from 5.4 
to 5.6 and longterm 5.4.x has the good code.Differs starting 5.7 till 
mainline or stable and my Laptop with intel AX200 m.2 installed will not 
work.


I have intel 7265 m.2 card and a old original m.2 wifi/bluetooth device 
qualcom atheros card the laptop came with.

both work kernels 5.10.x,5.15.x,5.18.x

https://bugzilla.kernel.org/show_bug.cgi?id=216058

https://www.linuxquestions.org/questions/debian-26/wifi-problems-intel-ax200-bullseye-11-3-a-4175711770/

https://community.intel.com/t5/Wireless/problem-with-intel-ax200-rev-1a-and-linux/m-p/1384652

https://www.linuxquestions.org/questions/linux-networking-3/trying-to-get-intel-ax200-wifi-card-to-work-in-debian-11-a-4175704711/

intel ax200 m.2 key E stops working after kernel 5.4.x longterm which 
uses the same iwlwifi code

as 5.6.x kernel after that kernel wifi will either give 
ADVANCED_SYSASSERT or mac address issues and the ax200 wifi adapter will 
not work. tried multiple ax200


Thanks for your time.
