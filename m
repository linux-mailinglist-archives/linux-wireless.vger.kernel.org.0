Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F86162DA18
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 13:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiKQMBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 07:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbiKQMBc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 07:01:32 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4928B5916B
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 04:01:29 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id C5648135627;
        Thu, 17 Nov 2022 12:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com C5648135627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1668686488;
        bh=bKDavZua7rJRrp9wCTDBym6whVVfRnpB/vUitGi2SNA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mRx1YavBoRQPxDHPijxvLahdhhJaEA02hf3eJUo/27JyCGjJ3rGqQOWcEy23FQI2P
         w/8OyoksJzOlm7jbpVC8ImAH/Ck+cKVlj6QtNdchhkwNw4sMvzK73nj1Rq85FFyO83
         +Phtfba7PjmvleYWjuRPOoMOJB7glUWyfB0IJF1M=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 45E1A2A010E;
        Thu, 17 Nov 2022 12:01:28 +0000 (GMT)
Message-ID: <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com>
Date:   Thu, 17 Nov 2022 12:01:26 +0000
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
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com>
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



On 11/17/22 09:23, Arend van Spriel wrote:
> On 11/16/2022 1:25 PM, Shengyu Qu wrote:
>> Got a new version of downstream driver and firmware here: 
>> https://gitlab.com/rk3588_linux/linux/external/rkwifibt/-/tree/linux-5.10-gen-rkr3.4
> 
> Thanks for that. The firmware indeed seems to originate from Synaptics 
> and this module can be found on wifi-alliance product finder:
> 
> https://www.wi-fi.org/product-finder-results?sort_by=certified&sort_order=desc&keywords=ap6275
> 
> We have no known contacts there and they do not seem to have much 
> interest in open-source. In that gitlab repo I see they are providing 
> bcmdhd driver and I assume they consider that sufficient.
> 
> Will see what I can do. First have to think on how to approach this 
> failure to get most out of a debug effort. I do not have the module over 
> here so we would need to go back and forth. The fact that the issue is 
> seen on both SDIO and PCIe is somewhat encouraging.

Yes it seems that at some point with some firmware, SDIO has worked for, 
eg, Angus.  And, it should work well with bchdhd (but that does not seem 
to work for scan for me on v6.1-rc5 uplevel with the firmware load 
changed to use kernel apis; but the firmware has no timeout on bcmdhd). 
So it doesn't feel a million miles away.

I have the hw, and (paid) time to help with debugging this "pair of 
hands" style. I'm also a little familiar with the kernel code and can 
try jiggle things autonomously if you can prompt what is interesting.

-Andy

> Regards,
> Arend
