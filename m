Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA66584DAA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 10:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiG2Ivt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jul 2022 04:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiG2Ivs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jul 2022 04:51:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF0E82F99
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 01:51:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l23so7361382ejr.5
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sXyFwqv0iqJuiLeWnyuN03PxHI0aJD4V1vIUpZUTo1E=;
        b=JQxSCJvWOAHljCC1UyWUj/t+l6GM3YJNIrOvubG7c0FktV3QLrX09KOSyhwvEvel36
         Npy9+Tf87W3UBfscLsV7/oW9N+iSKM1VFIiTu7f6FRxQSV3arke1PQ6if2YFw1o+Ve28
         N/RbZfSUZNp3GA/3GR4erhnjeUTdJIDCxyGzh0C54UHo5qJ+w72oZpbA0KYWCt5awUz1
         P5R+z2Gr8W6FEqq/uYM9+iEjlSX28GlHw9JekY6TvzrXW++HZyf1iHS7WtpSkSp8ALJk
         6dc0Mt13fImO1C+dQw8KnCFq1nsySO2+wemJm0zl+1cO74e6HE3Oe2jgwnvH7oi+tsbv
         jjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sXyFwqv0iqJuiLeWnyuN03PxHI0aJD4V1vIUpZUTo1E=;
        b=XKC4nF+uc0O+eaY/MSmRw5TzWFaGOUVMh4xPP2IDjewKs88k3gSEf6GC1At+b+alMq
         rkvEbm0/6fR3ktAPwuWm1TFaxcn8aC4SuCZuf3aw1wlZ0z32wovUAWmVgyDl3UKKCgG3
         pDUFTfzPV0q6gz/8EwuNZ9AqqvegkQHmiuUR8Y0oe5vn1UzokXEBL2Q+vBEKwB77Z5Nv
         q9uGTSWer7JxcMtSqf1C9x4Y3HF6xKJ9P448D/MzMlMMc2laiOtGAmyrz8Dx23IweFgY
         Co8JVGalovPxtQFU9L4ntuMpAFU9FjRfFaWyDEzDSXKYNJaNkXknIB0kOLjyIcDWS0bU
         b3iQ==
X-Gm-Message-State: AJIora818QXAkEIx0QOCpxI4X/vOht8TxU2fEqvZQ22NvxpaaK24yzzv
        5+2JInkLuUajs98xQRneA4A=
X-Google-Smtp-Source: AGRyM1sm/avV3UlNWGNNRQNCmFy9vHiZGJcY9BZ7AJUX2TkjMVoy69irH7mxj3t1ojlIGYxHXLLi/A==
X-Received: by 2002:a17:907:7f05:b0:72f:550c:69f3 with SMTP id qf5-20020a1709077f0500b0072f550c69f3mr2105611ejc.744.1659084703358;
        Fri, 29 Jul 2022 01:51:43 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090630cf00b0073022b796a7sm895984ejb.93.2022.07.29.01.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 01:51:42 -0700 (PDT)
Message-ID: <428a96cf-1072-8bbd-937a-6e3558e9448e@gmail.com>
Date:   Fri, 29 Jul 2022 10:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/7] brcmfmac: support devices from multiple vendors
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
References: <CAJ65rDxwRshw4Qwte9bU4K+xifcS0Yo7TjCKJ2aNPg4wBLeg5w@mail.gmail.com>
 <87wnbxoa37.fsf@kernel.org>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <87wnbxoa37.fsf@kernel.org>
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

On 7/28/2022 11:33 AM, Kalle Valo wrote:
> aspriel@gmail.com writes:
> 
>> The bcm43xx family of wifi chipsets found its way to different
>> groups inside and outside Broadcom. For the fullmac devices this
>> means that in those difference groups firmware is being developed
>> and the firmware api is bound to diverge. This series introduces
>> a design change to accomodate supporting multiple firmware api's.
>> The vender-specific support can be compiled in brcmfmac or
>> built as a separate module. Currently the vendor-specific support
>> does not have any real effect. At the momemt looking into SAE support
>> which appear to be different for Cypress devices so that might be a
>> first use-case. Meanwhile wanted to put this series out there and
>> get feedback on it. Some ideas were taken from iwlwifi which does
>> similar things for iwlmvm, iwldvm, etc.
>>
>> The patches apply to the main branch of the wireless-next repository.
>>
>> Arend van Spriel (7):
>>    brcmfmac: add function to unbind device to bus layer api
>>    brcmfmac: add firmware vendor info in driver data
>>    brcmfmac: add support for vendor-specific firmware api
>>    brcmfmac: add support for Cypress firmware api
>>    brcmfmac: add support Broadcom BCA firmware api
>>    brcmfmac: add vendor name in revinfo debugfs file
>>    brcmfmac: introduce BRCMFMAC exported symbols namespace
> 
> I think there's something wrong in mail formatting, tried to apply just
> for a test and it failed:
> 
> error: git diff header lacks filename information when removing 1 leading pathname component (line 7)
> error: could not build fake ancestor
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> Applying: brcmfmac: add function to unbind device to bus layer api
> Patch failed at 0001 brcmfmac: add function to unbind device to bus layer api

Hi Kalle,

Looks strange indeed. I will look into it and resend the whole series.

Gr. AvS
