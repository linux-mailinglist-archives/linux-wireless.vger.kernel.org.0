Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F4449E32C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 14:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241599AbiA0NRb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 08:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiA0NRb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 08:17:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1387C061714
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 05:17:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEF1AB82233
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 13:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DB5C340E4;
        Thu, 27 Jan 2022 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643289448;
        bh=RgSVK++gwmccAXy1rj/PMibVPfJadssKJGZw3Jglr2o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nXzB9ktjDtDkEECbFK4IwC2hFfPAA6xvwNHPNM9zZSo6p1BT8b2y9vQoAUYNkMXg/
         BUp0rFKxC+Z8RMZSHpHzl9/sgeTGT7ELgnkoN0l7/MQydzXo0CIOkIDEUO9GL5WKFG
         pdJAxQVOmn+nTj9Mg7+tyowQfPgOHsp+MwfVRqT+QKDbTGrJhPyPMiNslTenguz/FU
         a5FGFQ46x2+zQ5NwtxroI/YkbiA1patpKwgilTtv/AvhAUANXp0BrrTowxuyeKkLRS
         WZ2NJCqXRsvvl7QjbBn29YJGnxZbYFWcbV9pBe/QmAHI3Xvt+caK3jrefeXFAjtYPv
         IYBJANaK6S1/w==
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
        <87r18tjs9k.fsf@kernel.org>
        <a0179a36-0daa-06ca-6d54-ace6b6eceeb8@broadcom.com>
Date:   Thu, 27 Jan 2022 15:17:23 +0200
In-Reply-To: <a0179a36-0daa-06ca-6d54-ace6b6eceeb8@broadcom.com> (Arend van
        Spriel's message of "Thu, 27 Jan 2022 13:59:58 +0100")
Message-ID: <87ee4tjp24.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 1/27/2022 1:08 PM, Kalle Valo wrote:
>> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>>
>>> On 1/19/2022 9:53 AM, Phil Elwell wrote:
>>>> On 19/01/2022 06:01, Kalle Valo wrote:
>>>>> Phil Elwell <phil@raspberrypi.com> writes:
>>>>>
>>>>>> The call to brcm_alt_fw_path in brcmf_fw_get_firmwares is not protected
>>>>>> by a check to the validity of the fwctx->req->board_type pointer. This
>>>>>> results in a crash in strlcat when, for example, the WLAN chip is found
>>>>>> in a USB dongle.
>>>>>>
>>>>>> Prevent the crash by adding the necessary check.
>>>>>>
>>>>>> See: https://github.com/raspberrypi/linux/issues/4833
>>>>>>
>>>>>> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware
>>>>>> binaries")
>>>>>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>>>>>
>>>>> I think this should go to v5.17.
>>>>
>>>> Is that an Ack? Are you asking me to submit the patch in a different way?
>>>
>>> Similar/same patch was submitted by Hector Martin [1].
>
> Fine by me. Hector's subset series (fixes) is ready to be taken as
> well, right?

I have not looked at Hector's patches yet, my plan is to take them to
wireless-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
