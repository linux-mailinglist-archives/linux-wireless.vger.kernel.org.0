Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB0262E45B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 19:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiKQSgO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 13:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiKQSgN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 13:36:13 -0500
Received: from node.akkea.ca (li1434-30.members.linode.com [45.33.107.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34A72AD0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 10:36:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B9AD14E2010;
        Thu, 17 Nov 2022 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1668710171; bh=QH1NxnTNb5JLasdRqa1geaUeebnNj0Rki90yx8WK2m4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=NG28lW2wHDOeLZAWpvd9PsFpclOpRQF3is9NpJY75OtnQOHlbDL7oPA0kwZBgOsVT
         BognxFRjSjnuIesu+Dgp1qLICQDOf2eVqBL/I7OOkQ+i0DmKrVIy/2m2vSo2v4zt/U
         Z2ljggzoSX4m1OQss6knOEiJJMD2Vo97h4utP+1c=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hJA6Rza76L1t; Thu, 17 Nov 2022 18:36:11 +0000 (UTC)
Received: from www.akkea.ca (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 1E72B4E2006;
        Thu, 17 Nov 2022 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1668710171; bh=QH1NxnTNb5JLasdRqa1geaUeebnNj0Rki90yx8WK2m4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=NG28lW2wHDOeLZAWpvd9PsFpclOpRQF3is9NpJY75OtnQOHlbDL7oPA0kwZBgOsVT
         BognxFRjSjnuIesu+Dgp1qLICQDOf2eVqBL/I7OOkQ+i0DmKrVIy/2m2vSo2v4zt/U
         Z2ljggzoSX4m1OQss6knOEiJJMD2Vo97h4utP+1c=
MIME-Version: 1.0
Date:   Thu, 17 Nov 2022 10:36:11 -0800
From:   Angus Ainslie <angus@akkea.ca>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Andy Green <andy@warmcat.com>, Shengyu Qu <wiagn233@outlook.com>,
        franky.lin@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
In-Reply-To: <18486ca8490.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
 <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com>
 <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com>
 <7bf5884906b1abc30adebd3c915a3259@akkea.ca>
 <18486ca8490.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Message-ID: <a25fbe81f6f5615a2cfb7fda80d6db9b@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.17
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022-11-17 10:12, Arend Van Spriel wrote:
> On November 17, 2022 5:06:25 PM Angus Ainslie <angus@akkea.ca> wrote:
> 
>> On 2022-11-17 04:01, Andy Green wrote:
>>> On 11/17/22 09:23, Arend van Spriel wrote:
>>>> On 11/16/2022 1:25 PM, Shengyu Qu wrote:
>>>>> Got a new version of downstream driver and firmware here:
>>>>> https://gitlab.com/rk3588_linux/linux/external/rkwifibt/-/tree/linux-5.10-gen-rkr3.4
>>>> 
>>>> Thanks for that. The firmware indeed seems to originate from 
>>>> Synaptics
>>>> and this module can be found on wifi-alliance product finder:
>>>> 
>>>> https://www.wi-fi.org/product-finder-results?sort_by=certified&sort_order=desc&keywords=ap6275
>>>> 
>>>> We have no known contacts there and they do not seem to have much
>>>> interest in open-source. In that gitlab repo I see they are 
>>>> providing
>>>> bcmdhd driver and I assume they consider that sufficient.
>>>> 
>>>> Will see what I can do. First have to think on how to approach this
>>>> failure to get most out of a debug effort. I do not have the module
>>>> over here so we would need to go back and forth. The fact that the
>>>> issue is seen on both SDIO and PCIe is somewhat encouraging.
>>> 
>>> Yes it seems that at some point with some firmware, SDIO has worked
>>> for, eg, Angus.  And, it should work well with bchdhd (but that does
>>> not seem to work for scan for me on v6.1-rc5 uplevel with the 
>>> firmware
>>> load changed to use kernel apis; but the firmware has no timeout on
>>> bcmdhd). So it doesn't feel a million miles away.
>> 
>> This is the firmware we have been using for SDIO. It was sent to us
>> directly by SparkLAN so not sure how it compares to other variants.
>> 
>> https://source.puri.sm/Librem5/firmware-brcm43752-nonfree/-/tree/master/firmware/brcm
> 
> It is a tad bit older:
> 
> $ strings brcmfmac43752-sdio.bin | grep FW-TAG
> <FW-TAG>4362a2-roml/config_sdio_ampak_release_he
> Version=18.35.387.23.7 (b328500@shgit) (wlan=r880297)
> Date=2020-07-13T10:34:00Z FWID=01-f50fdff0
> 

Currently it's broken for hotspot mode but I haven't had the chance to 
see if that is FW or something further up the stack.

Angus

> Thanks,
> Arend
> 
>> 
>> Angus
>> 
>>> I have the hw, and (paid) time to help with debugging this "pair of
>>> hands" style. I'm also a little familiar with the kernel code and can
>>> try jiggle things autonomously if you can prompt what is interesting.
>>> 
>>> -Andy
>>> 
>>>> Regards,
>>>> Arend
