Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF360E620
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 19:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiJZREj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 13:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiJZREh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 13:04:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC9E101D2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 10:04:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so3205324pjc.3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 10:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UZW3bFvb0DZzGaICsRWknazNXDYn0D2kpH6r7gdx2g=;
        b=b7dE1f8Ias+Y8p7Wem9D+ZrhTUBNMGVFusYLY4XYS3X98++3GoWaZb+Eers22PGg9t
         kZtRqYf9IpVCf8bSTxyWfR3Toxwbx52EmSB4I3KnuI2gzLjpzuPDwjtQ+203tDIgjGc0
         FZF81Sy72RlUaLHyy2EaPiSrCVQtSZEeEzvJ2VrBcLmmyCmaSOF1frbtSfuNVmC3M9/t
         2PPznCPZC7LzvPlCCDBvVhn72ojggwGdxGCQh3Vu87MzyBlOqmn2z/P0kmi6ZiDbV9Gt
         VH6yngh7JHCiyR00wVzHaLehdUiWI0RtPKs5Sp35hojPgzT1B6NVvszW0w2Fr5BETFRv
         kaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UZW3bFvb0DZzGaICsRWknazNXDYn0D2kpH6r7gdx2g=;
        b=8KrNn2YN9gQz/V37tyJBd6EQHJm6V9ERRztQ5Z5BspkJin70Qt1ppe4WO7J+x350Ju
         6UsyIDObXmadtkTWNK34ZU4NK+Rc/mVMfkt2dcT6hdzrvG2iVp89MwIiS4f6zfQbnUSP
         bFMcb/NdEsKU88rSY9bUHiFswZztVTAeWIOFYh0I1jjVvOqgo4t/DFs97mNXOVqJD7Vw
         XvqPaU37DXzi920gwHacOLetiv4mPFhBpSHWQgZfcD/Q42n9PAJDqCg/ryRmExjSWZ67
         SPLS5MujcoMIMs4AOPaUCuEqocHzelZ/ymOEoCXaOYcQSVdQBHa/BXhNHar7gGM7fYsj
         XlUA==
X-Gm-Message-State: ACrzQf0zEt8tsjFgamh6I64Yu5QhxIX8pXYn/8xWq6nu/eLWu3bCkOwg
        cQpDTi43WWfYAw2J5b0c4x50eWvWndE=
X-Google-Smtp-Source: AMsMyM5HnpgcdoIuZRa3lrY9uRcU/C+TnFgZmX2qd70Ho8jiLc25IijZyLKl+vunChOsUe3OMJ6f5Q==
X-Received: by 2002:a17:90b:224c:b0:213:5ccc:9733 with SMTP id hk12-20020a17090b224c00b002135ccc9733mr3349611pjb.110.1666803875188;
        Wed, 26 Oct 2022 10:04:35 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:1c5e:eaed:5c17:c765? ([2600:8802:b00:4a48:1c5e:eaed:5c17:c765])
        by smtp.gmail.com with ESMTPSA id j8-20020a632308000000b0043941566481sm3054115pgj.39.2022.10.26.10.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 10:04:34 -0700 (PDT)
Message-ID: <cba07be4-1afc-649f-a172-19f76d726232@gmail.com>
Date:   Wed, 26 Oct 2022 10:04:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: iwlwifi: intel ax210: module fail load firmware: Failed to start
 RT ucode: -110
Content-Language: en-US
To:     Florian Schmidt <florian@fls.name>,
        Greenman Gregory <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <91cad7f52fe275bf567cf5aa7aa6f7c0@mail.infomaniak.com>
 <28dfa897c38286b1cf9ae30631fb7438@mail.infomaniak.com>
 <59fe5bdc361fed71103ee159cdb5ab64@mail.infomaniak.com>
 <f351b0a31b536e7a29d63937a242d5de7e2552ca.camel@intel.com>
 <4077a7705bb86501a9cbbce86fe1ea8c@mail.infomaniak.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <4077a7705bb86501a9cbbce86fe1ea8c@mail.infomaniak.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/26/2022 8:56 AM, Florian Schmidt wrote:
> Hi Gregory,
> 
> Thank you for having a look at this. The .pnvm file was present in my test as shown by my original message:
>> md5sum /lib/firmware/*
>> 787381c60d907f81a3ddadc5c990a82b ./iwlwifi-ty-a0-gf-a0-71.ucode
>> d93cbdcc4bb5be69aac128e2fe291359 ./iwlwifi-ty-a0-gf-a0.pnvm
>> 33d13d236512466e71c81257209a356f ./regulatory.db
> 
> I just ran the test again, ensuring I have the .pnvm you mention and the result is indeed the same.
> 
> Any other ideas to solve this are welcome.

The driver indicated it wanted to load iwlwifi-ty-a0-gf-a0-72.ucode, 
which you do seem to have based upon the listing above?
-- 
Florian
