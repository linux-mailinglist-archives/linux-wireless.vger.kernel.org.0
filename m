Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC48637B7B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 15:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKXOcc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 09:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKXOcb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 09:32:31 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C38131120
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 06:32:29 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id E68AB13562B;
        Thu, 24 Nov 2022 14:32:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com E68AB13562B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1669300348;
        bh=tWhOHTTrBfQHOcbVG1t8VU7h8eyWpk4F7iFuHrFepCs=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=c3CdL+LGcDt2HB8dKtXTg721XyGUUHzBkXX08oWJiHIzFr22pRqN5OuKIB05G7nie
         SwP3MjITqcwaHOZIQe5RGlYP++tUGrA1SJKb3uDXZiEIGUk4H8onmkIEpxb5WG4758
         Kb871et+B6dcufRY2Npyiwf9204OaHx+mvY22Hlk=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 5D9322A00C0;
        Thu, 24 Nov 2022 14:32:28 +0000 (GMT)
Message-ID: <7a34b52c-0e75-2f9d-c9ab-9073a5b02cdf@warmcat.com>
Date:   Thu, 24 Nov 2022 14:32:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
Content-Language: en-US
From:   Andy Green <andy@warmcat.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Shengyu Qu <wiagn233@outlook.com>
Cc:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com>
 <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com>
 <1848793db88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3a562a50-0cef-4879-3691-3258596f5213@warmcat.com>
 <1cbb3bf5-fd70-e9db-2405-640178862857@broadcom.com>
 <6c3f592e-3e20-edef-ce7a-cde8988eef2d@warmcat.com>
 <9fe8caec-453a-28c1-04d3-5966200b8db1@broadcom.com>
 <f80c4a64-d987-0f59-418d-adf419fcb054@warmcat.com>
 <56fbcc03-b5dc-34b2-f15a-13c46447ffa0@broadcom.com>
 <d04547d3-4081-4047-3206-6d7c750720dc@warmcat.com>
 <41158f1f-b281-8d77-c5f3-f67adb0b2fde@broadcom.com>
 <3448c815-f077-dcfe-9eaa-10ae9be2a8df@warmcat.com>
In-Reply-To: <3448c815-f077-dcfe-9eaa-10ae9be2a8df@warmcat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/24/22 14:16, Andy Green wrote:

>> diverge on firmware API level. I already had a patch on the shelf 
>> supporting version 2, but it does not match the API your firmware 
>> expects.
>>
>> I was working on supporting multiple vendors, but I need some rework. 
>> The scanning issue confirms the need for per-vendor support. Hopefully 
>> I can spend some time on it.
> 
> If it makes sense for you, I'm willing take a look at your alpha patch 
> with the idea to align with what the OOT driver does for scan, but I'm 
> not sure how intricate wading in there is going to get.
> 
> I'd need at least some guidance about how to detect which api stack it 
> wants dynamically if there's more than one "version 2" and likely some 
> hand-holding about firmware or soc-specific things in places.

... there's the additional quirk that my rebase on mainline of the OOT 
driver starts up like mainline now, but doesn't return any scan results 
as it is.

So aligning to that may only take us so far without some possibly 
non-open knowledge about what the firmware really wants from its 
perspective directly without referencing dhd.

-Andy
