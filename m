Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0668649E628
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 16:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbiA0PgU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 10:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbiA0PgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 10:36:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F288C061714
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 07:36:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B28761670
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 15:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125ADC340E4;
        Thu, 27 Jan 2022 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643297779;
        bh=EUU/17foXoYtaJnHWrihpvZQf01YyNKSi7B8SHHq1R8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AD2J2NtAhNMSvBtPPfV/kACNe4M+g/donsOllan4qDrwkklgIC8d67y2pC5x9wUVF
         fjJxYihw5CnXYkypxgZVJ0Wikhx3uI394ygjOrxdWKv0f8E/d6+vUV6kzX2z6k1678
         vuHEV4SEcqkSksewUPODslrz2Jw3+PdHHazMwfm1RE79kLDg1M7QxcV7Azqeerxg62
         voTSdPsxAjoglWJhe44nh3IGTBsvC/OPR+dlrKgmQK31LsabZtIZJ5K5lReAvJQytA
         ayEAZjf+k8klmSEi8v169E3u0eUxvFCrvdPOFkOLtW7TN9eTDZyp15alXsYGnaFMpI
         nHYFXs8tpckig==
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
        <87ee4tjp24.fsf@kernel.org>
        <82bf9633-ccd4-106f-89f5-921dd0534214@broadcom.com>
Date:   Thu, 27 Jan 2022 17:36:14 +0200
In-Reply-To: <82bf9633-ccd4-106f-89f5-921dd0534214@broadcom.com> (Arend van
        Spriel's message of "Thu, 27 Jan 2022 15:30:30 +0100")
Message-ID: <87y231i429.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 1/27/2022 2:17 PM, Kalle Valo wrote:
>> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>>
>>> On 1/27/2022 1:08 PM, Kalle Valo wrote:
>>>> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>>>>
>>>>> On 1/19/2022 9:53 AM, Phil Elwell wrote:
>>>>>> On 19/01/2022 06:01, Kalle Valo wrote:
>>>>>>> Phil Elwell <phil@raspberrypi.com> writes:
>>>>>>>
>>>>>>>> The call to brcm_alt_fw_path in brcmf_fw_get_firmwares is not protected
>>>>>>>> by a check to the validity of the fwctx->req->board_type pointer. This
>>>>>>>> results in a crash in strlcat when, for example, the WLAN chip is found
>>>>>>>> in a USB dongle.
>>>>>>>>
>>>>>>>> Prevent the crash by adding the necessary check.
>>>>>>>>
>>>>>>>> See: https://github.com/raspberrypi/linux/issues/4833
>>>>>>>>
>>>>>>>> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware
>>>>>>>> binaries")
>>>>>>>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>>>>>>>
>>>>>>> I think this should go to v5.17.
>>>>>>
>>>>>> Is that an Ack? Are you asking me to submit the patch in a different way?
>>>>>
>>>>> Similar/same patch was submitted by Hector Martin [1].
>>>
>>> Fine by me. Hector's subset series (fixes) is ready to be taken as
>>> well, right?
>>
>> I have not looked at Hector's patches yet, my plan is to take them to
>> wireless-next.
>
> Some of them are improvements so wireless-next is where those belong,
> but a few (patches #1-3, and #6) are actual bug fixes.

To avoid conflicts I'm keeping the bar high for patches going to
wireless, so it's mostly regression fixes or otherwise important fixes.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
