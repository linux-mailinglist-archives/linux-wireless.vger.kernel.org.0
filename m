Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7828649E1FE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 13:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiA0MIQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 07:08:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42940 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiA0MIP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 07:08:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C5BAB821C0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 12:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB44C340E6;
        Thu, 27 Jan 2022 12:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643285293;
        bh=ljSbvHeJmF3ZuifdYikk1Qo28pM/YkC0/0ar/NPr0vM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rxO0XkjalEneDOA6O9oczCx+HZYUyFhjKJURER1CsByO5jwKZCMa/aFJXE7vvqAsW
         27wXEsTJVPl82kw8CzAV7TffTUT88nVpcAw82ixXYBwJuGRNCWBlcx6PPlTqaoVDyF
         1jMl19wCKx14X+5NA0o3KFLp3/2okaltuXnh7EUvAXQHXeGL/30Pil6A4vrrl/EjPQ
         AKc25YmAn8Z0ltyWmqfJCIwZhuKeRu6YRfyibsVf6XjuMSn33yJNuYgOfwfD/GbJDr
         xgz2tk1JdaisGEo0PsnGABIDqC5RCPZYAge8RyIRgxJkC0+hbpPJbujIjU46ID6rR8
         Fjg2b6lRZ2pNw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        Arend van Spriel <aspriel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH] brcmfmac: firmware: Fix crash in brcm_alt_fw_path
References: <20220118154514.3245524-1-phil@raspberrypi.com>
        <87h7a0gt7f.fsf@kernel.org>
        <07dbaff1-bc12-d782-ed14-ef3f33d3c041@raspberrypi.com>
        <ebe36c68-cdf9-b005-6d02-f72c3917d292@broadcom.com>
Date:   Thu, 27 Jan 2022 14:08:07 +0200
In-Reply-To: <ebe36c68-cdf9-b005-6d02-f72c3917d292@broadcom.com> (Arend van
        Spriel's message of "Wed, 19 Jan 2022 16:48:44 +0100")
Message-ID: <87r18tjs9k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 1/19/2022 9:53 AM, Phil Elwell wrote:
>> On 19/01/2022 06:01, Kalle Valo wrote:
>>> Phil Elwell <phil@raspberrypi.com> writes:
>>>
>>>> The call to brcm_alt_fw_path in brcmf_fw_get_firmwares is not protected
>>>> by a check to the validity of the fwctx->req->board_type pointer. This
>>>> results in a crash in strlcat when, for example, the WLAN chip is found
>>>> in a USB dongle.
>>>>
>>>> Prevent the crash by adding the necessary check.
>>>>
>>>> See: https://github.com/raspberrypi/linux/issues/4833
>>>>
>>>> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware
>>>> binaries")
>>>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>>>
>>> I think this should go to v5.17.
>>
>> Is that an Ack? Are you asking me to submit the patch in a different way?
>
> Similar/same patch was submitted by Hector Martin [1].
>
> Regards,
> Arend
>
> [1]
> https://patchwork.kernel.org/project/linux-wireless/patch/20220117142919.207370-4-marcan@marcan.st/

I would prefer to take this patch to wireless tree and drop Hector's
version. Is that ok?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
