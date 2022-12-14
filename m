Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40C064CE92
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 18:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiLNRCl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 12:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbiLNRCj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 12:02:39 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B47C2AD3
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 09:02:36 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id m204so3117213oib.6
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=d39PwbrPFkZXwj52/kQuhWxKwtv8FOAsH4wYm2Lld+U=;
        b=k1igD3nVk+UEz0lxx6lfAX/HWgp4Nv9AsOxvyAvuY6yO1jTRMH0yb2zzzfKFqo2x5H
         zMx/RqyHVarsyVZkFDK8fcVSJNQ6FuDgosbYGhXqsBDGDeSraR/V4Fditcb0NXs71VS0
         YkeOMMr1QiqnSIG6f7uPKyyG0Y+GBrOtuJlsKKbOTmaVAq5Tm6sIqLaPZhMlchH9iN5p
         mWpzIRcbHpjUMyMgxq8iWq3QJktSglsVwdnblUHgpdpy5u0j61B5/AL/6rfo8a6nDgEl
         nwBuAUaDa4l6YVlcJEezGxw9SkEMZAV+lRw6R8L8mZ2GTLKeHZkza+WjvraN+vuz3eaa
         i3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d39PwbrPFkZXwj52/kQuhWxKwtv8FOAsH4wYm2Lld+U=;
        b=7LKGnus2BbKtgI8yWYnucKS0JjvdA41RM5irwtih9zfx38cTqO6+PZaoxAhvubA8Tr
         z4Wj+XcEderEfbBPWTnEIpLP2I0K3ZU0Gznjv9eLMfl5/CQmGWizj88FxQt8eG4RJ5tr
         CCv3TDkqcmMT4ajWMiDFVwxMSBdQFN4hmB2fQLgz6GM9M8pt43v63KWDYb391fs/NTOd
         fl0JIq9psY88XOmPBI++eEfa1PNONAqlrWG0nxgFAFgrUZ8nnL5zm7ye+mWEChSTMox+
         p8fMcBFiXbyw1YxWVT4lFYxZ5cE5S3Hm+6V5HXxu5Zwyajo4hTX3CxCjSFoXHepcTkIp
         c72w==
X-Gm-Message-State: ANoB5pmfgKfwNjHK+Df43dDipQPG0BpyfgdiZIerKBaY4TyZ+G0KuFlS
        1bW292c94O3w8DLfWhx1un+I1F57XtY=
X-Google-Smtp-Source: AA0mqf5Xekb2I1AsEAPlxbI+KzC+oiYWSAlKD2zJublRi2FSr2ye4eYAVMBlZgLgXuQ/nbeK4h5j0A==
X-Received: by 2002:a05:6808:189c:b0:35b:f7f3:42f3 with SMTP id bi28-20020a056808189c00b0035bf7f342f3mr13617395oib.8.1671037355865;
        Wed, 14 Dec 2022 09:02:35 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id c39-20020a05683034a700b00670461b8be4sm2615411otu.33.2022.12.14.09.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 09:02:35 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <2a1b8b59-845e-d3b2-6195-2c74ce818341@lwfinger.net>
Date:   Wed, 14 Dec 2022 11:02:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Realtek 1d3e:c826 not working
To:     James <bjlockie@lockie.ca>,
        Joshua Richenhagen <richenhagen@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CAJZ9B5tdZxqBG8pZhEKdzfaNqrR=8jGdNuMXJ7cYCitL7eatKw@mail.gmail.com>
 <27bdcf85-ed2f-40f6-a285-76879a8fbc6a@lockie.ca>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <27bdcf85-ed2f-40f6-a285-76879a8fbc6a@lockie.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/12/22 13:19, James wrote:
> https://askubuntu.com/questions/1412450/network-driver-for-realtek-10ecb852
> 
> Dec. 12, 2022 11:43:59 Joshua Richenhagen <richenhagen@gmail.com>:
> 
>> Hello,
>>
>> on my new Xiaomi Book Pro 14 Ryzen with Realtek b852 using newest
>> kernel Linux 6.1 Wifi is not recognized at all. Is the PCIe device ID
>> missing in the rtw89 driver?
>>
>> 01:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b852
>>          Subsystem: Device 1d3e:c826
>>          Flags: fast devsel, IRQ 255, IOMMU group 11
>>          I/O ports at 2000 [disabled] [size=256]
>>          Memory at c0900000 (64-bit, non-prefetchable) [disabled] [size=1M]
>>          Capabilities: [40] Power Management version 3
>>          Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>          Capabilities: [70] Express Endpoint, MSI 00
>>          Capabilities: [100] Advanced Error Reporting
>>          Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-88-52-01
>>          Capabilities: [158] Latency Tolerance Reporting
>>          Capabilities: [160] L1 PM Substates
>>
>> Kinds regards
>> Joshua Richenhagen

That driver will not be in the kernel until kernel 6.2, which is predicted to be 
released on Feb. 19, 2023.

In the meantime, clone the rtw89 repository at 
https://github.com/lwfinger/rtw89.git, and follow the instructions in README.md 
in the cloned repo. Pat particular attention to the last paragraph if you are 
running Ubuntu. For some reason, they have not included the firmware for this 
device even though it has been in the official linux-firmware repo since October.

Larry

