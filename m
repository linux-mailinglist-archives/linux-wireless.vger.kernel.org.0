Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E784637718
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 12:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKXLEr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 06:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKXLEp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 06:04:45 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE82D5C0F5
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 03:04:43 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id D6A14135628;
        Thu, 24 Nov 2022 11:04:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com D6A14135628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1669287882;
        bh=CUNYxypo2FWLF5QX3WEPGzrmC/MgcVYKFY9DKM3UvLo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SLhOpg2jmRSxvljjhT03ef5wb1Fqb2og4c+1NSBbxvLFFj9+WKL7XHb2XWpKjywna
         XCVCUlDHKugdtzfUdBGp7BRbbN/wutrKKQKpzONbU1j4MXUnllBY05TGQXhjiB99bY
         051SzMtXhNJi/adriDzjyAApEJwS2QhOeTOdRI54=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 53BC32A00EB;
        Thu, 24 Nov 2022 11:04:42 +0000 (GMT)
Message-ID: <48b3ca0a-c7a8-d5ee-796c-a239a8ca5a41@warmcat.com>
Date:   Thu, 24 Nov 2022 11:04:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Shengyu Qu <wiagn233@outlook.com>
Cc:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
 <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com>
 <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com>
 <1848793db88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3a562a50-0cef-4879-3691-3258596f5213@warmcat.com>
 <1cbb3bf5-fd70-e9db-2405-640178862857@broadcom.com>
 <bea00730-5411-a3c4-0ead-bb73889c25f6@warmcat.com>
 <6774d660-eb2e-50be-0024-8faf9b3d4c4e@broadcom.com>
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <6774d660-eb2e-50be-0024-8faf9b3d4c4e@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/24/22 10:49, Arend van Spriel wrote:
> On 11/24/2022 11:20 AM, Andy Green wrote:

>>> Thanks for the log. Together with the dhd driver sources I could make 
>>> some sense of it. Perhaps you can try the following hack and see if 
>>> we make it over the first hurdle.
>>
>> Thanks, I tried it, but although it looks necessary, there's evidently 
>> something else since the result was the same.
>>
>>> +
>>> +    entropy_info.signture = cpu_to_le32(BRCMF_SEED_SIGNATURE);
>>
>> This should be ... .signature = ...
> 
> That's what you get if you get too confident... :-(

Just mention it in case anyone following along at home with the patches.

>> I added a log showing it sending the entropy bytes.
> 
> Ok. Something is off there. Maybe I tried to be to smart. How does that 
> log statement look which you added?

It's inline with the other logs, it seems to be coming before the actual 
NVRAM download part

 >> [    3.694272] brcmfmac: Download NVRAM brcm/fw_bcm43752a2_pcie.txt
 >> [    3.694895] brcmfmac: brcmf_pcie_write_entropy_bytes: written 6040
 >> entropy bytes

-Andy
