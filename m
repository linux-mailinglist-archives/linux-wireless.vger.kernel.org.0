Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E306626EA3
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Nov 2022 10:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiKMJDP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Nov 2022 04:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMJDO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Nov 2022 04:03:14 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C57E1004F
        for <linux-wireless@vger.kernel.org>; Sun, 13 Nov 2022 01:03:11 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id 5414813562B;
        Sun, 13 Nov 2022 09:03:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com 5414813562B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1668330190;
        bh=qo/8k1exoUluN9wb0M6poumR5Os/VU53hoB+SsldsFc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GvsK9MJ4XsmY7UtzkJyqt/91Vj3ONeFxOVgg6gEv4Zas+PECYM/09laWLaT/0oVce
         LLdJwviacf2+XA9A/a9di+yz9Qi/h1uupvOYJEEg5HHA1rvoYqQnB3hgM3eHhKQmE3
         B1SeMYBuJSd0hRY4Liqtlifo/+tc+iexf9HF2y80=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 4E8F92A00D9;
        Sun, 13 Nov 2022 09:03:09 +0000 (GMT)
Message-ID: <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
Date:   Sun, 13 Nov 2022 09:03:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
Content-Language: en-US
To:     Shengyu Qu <wiagn233@outlook.com>, arend.vanspriel@broadcom.com
Cc:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
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



On 11/13/22 08:26, Shengyu Qu wrote:

> Hello, I'm facing the same problem on sdio version of AP6275 module in mainline kernel. But I found a very old version from here could work with mainline brcmfmac driver.
> Link: https://bbs.t-firefly.com/forum.php?mod=viewthread&tid=3107

Thanks for the info.

The firmware on the firefly thread doesn't seem to have a CLM blob that 
the mainline driver wants, just two types of the ~900KB main firmware 
for AP mode support or not.

It also doesn't have _sdio or _pcie in the filenames... I tried it but 
although it's different in what it read after downloading NVRAM

[    3.775602] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr 
0xfa2c05d3

(the rockchip SDK firmware says 0xfa1a05e5)

it still times it out a few seconds later as unresponsive after the fw 
load... maybe it is for SDIO only, or the lack of CLM, present in the 
Rockchip fw, means it won't get anywhere.

> Besides who I should ask to make proper firmware for it into linux-firmware repo?

It would also be great to hear if the PCIe firmware from Rockchip aimed 
at the OOT driver was definitively incompatible with the mainline driver 
and we have to find a solution for that from Broadcom, or it is expected 
to basically work.  I realize it might not be easy to get an answer 
internally but this chipset is likely to appear in more RK3588 SBCs soon 
since it's the one on the evb.

-Andy

> Shengyu
