Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C10637740
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 12:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiKXLLs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 06:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiKXLLq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 06:11:46 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDFF96F0CD
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 03:11:45 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id 3092A135628;
        Thu, 24 Nov 2022 11:11:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com 3092A135628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1669288305;
        bh=bkObiksh3YoC9jsws0Jv6IjY5lSEe8IaUbEBbfpEvCM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ktq5WrllAOOh8vZDopvtEPE6VfbBe8l+5jL1sl40u6dRb5b4OB5lfPGC2E0wvKyUu
         bqFVxQ4RP7DIzXzZJW8ESF+dv/gy2PO90neYBs6WQLP6BbgsU28WHIs4TrqVcSbheJ
         xXrY7DGJMasczO2MkmTulvCp4L7C/IX+FF+bIA8E=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 99BFF2A00C0;
        Thu, 24 Nov 2022 11:11:44 +0000 (GMT)
Message-ID: <e4bf8b7f-915e-5432-4a2d-c7467f64e1a4@warmcat.com>
Date:   Thu, 24 Nov 2022 11:11:43 +0000
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
 <48b3ca0a-c7a8-d5ee-796c-a239a8ca5a41@warmcat.com>
 <f2d334c3-cce1-09c8-8585-f1e668b8d24e@broadcom.com>
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <f2d334c3-cce1-09c8-8585-f1e668b8d24e@broadcom.com>
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



On 11/24/22 11:07, Arend van Spriel wrote:
> On 11/24/2022 12:04 PM, Andy Green wrote:

>>> Ok. Something is off there. Maybe I tried to be to smart. How does 
>>> that log statement look which you added?
>>
>> It's inline with the other logs, it seems to be coming before the 
>> actual NVRAM download part
>>
>>  >> [    3.694272] brcmfmac: Download NVRAM brcm/fw_bcm43752a2_pcie.txt
>>  >> [    3.694895] brcmfmac: brcmf_pcie_write_entropy_bytes: written 6040
>>  >> entropy bytes
> 
> Sorry. I meant how the source code look like. There should be 128 bytes 
> written. 6040 is length of nvram so I am a bit confused.

It's just my log is showing the wrong thing.  I was mainly wanting to 
make sure it went through there so I didn't look at what it was saying 
any closer.

         pr_err("%s: written %u entropy bytes\n", __func__, nvram_len);

Showing count instead

[    3.734102] brcmfmac: brcmf_pcie_write_entropy_bytes: written 128 
entropy bytes

-Andy
