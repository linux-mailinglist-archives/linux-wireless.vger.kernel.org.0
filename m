Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD444937DC
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 11:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345824AbiASKAR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 05:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiASKAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 05:00:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96232C061574
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jan 2022 02:00:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 339B761535
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jan 2022 10:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFEAC004E1;
        Wed, 19 Jan 2022 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642586415;
        bh=MN6e0XnGDJ3IHgXQgi3zjN2BIx62Wsfwxq8ZtCGuGM4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bDieBct2B1PvYxsHwB5RYhnqxJEzlwd+epqBxaSE1m6pGk7+F/MHUN/ZDGXpd0Znq
         Ob/j+r45hJdC2lkGFhiMd63A2GpZU9RimMdGKvuEb5gg+VQ1Mq0cFu6h8X8n810MhI
         kfLzWTUSwryAYEX9TTTCYgRzSD8cYyZCMcNU664V5axit+jPBFVeS2Y5saGxv5Dax7
         n2JOxvAZBv8Jz6A/aaXww0h6xfwm7PujyfFPf4GG5ZZzQ6j38pwYXCH4SEZ1zDF/U0
         Z/SbFZicZrtc4Ba+8UJw0QO85i7gB3fhYJAvXy1cKbRLW6PEi1dzV1y1l2M6tNJygn
         FpbcofSFUdqwA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
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
Date:   Wed, 19 Jan 2022 12:00:08 +0200
In-Reply-To: <07dbaff1-bc12-d782-ed14-ef3f33d3c041@raspberrypi.com> (Phil
        Elwell's message of "Wed, 19 Jan 2022 08:53:46 +0000")
Message-ID: <878rvcgi53.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Phil Elwell <phil@raspberrypi.com> writes:

> On 19/01/2022 06:01, Kalle Valo wrote:
>> Phil Elwell <phil@raspberrypi.com> writes:
>>
>>> The call to brcm_alt_fw_path in brcmf_fw_get_firmwares is not protected
>>> by a check to the validity of the fwctx->req->board_type pointer. This
>>> results in a crash in strlcat when, for example, the WLAN chip is found
>>> in a USB dongle.
>>>
>>> Prevent the crash by adding the necessary check.
>>>
>>> See: https://github.com/raspberrypi/linux/issues/4833
>>>
>>> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
>>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>>
>> I think this should go to v5.17.
>
> Is that an Ack? 

It's a note to myself and other maintainers/reviewers that I'm planning
to take this to the wireless tree. At the moment I'm waiting for other
people to comment.

> Are you asking me to submit the patch in a different way?

No need, unless something is found during review.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
