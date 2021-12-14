Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5D3473CC9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 06:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhLNFzu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 00:55:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58332 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhLNFzu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 00:55:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DED8061335
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 05:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA860C34601;
        Tue, 14 Dec 2021 05:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639461349;
        bh=Af6OcrA2+TfGPtoNoUNj7eDNP6Lw4fy7hNVVwlCuYdE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JdbTEVtzgmya0xRQmCxCcS/wJ7YOGc6mwS4jgFMz9C6R+i37VzRlBtoCBy2iGLPaR
         f09RLOQxmUMH8Dcz74gW2NC+wAO0wRewvh7z1eaPFMEVPZT/pZh7xzWqxweX47Doyt
         BDu5FrlT49WN2M75F3zWy2cDL9cpCjpzZwIWM4aM8uMsLt4Ox+781gVRom0ZAsRPPZ
         55XCHGQ7VrEO2rYanP8UxSDqXB/DziVzkCAgerAahL3l4hryZ/GOeDQ8/M2I4/Mb7D
         16CBduJq3lD5DPQml+cUsR6btHUArNLfofyR6Xx2c0D0+u+Erm6PGGZIB454NVV1sd
         iZEWx/fp3zcMw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 05/10] iwlwifi: mvm: fix 32-bit build in FTM
References: <20211210091245.289008-1-luca@coelho.fi>
        <iwlwifi.20211210110539.4b397e664d44.Ib98004ccd2c7a55fd883a8ea7eebd810f406dec6@changeid>
        <87czm0kce3.fsf@codeaurora.org>
        <9f7d720988c7aa113b70386bae80dbcd46b9b274.camel@coelho.fi>
Date:   Tue, 14 Dec 2021 07:55:45 +0200
In-Reply-To: <9f7d720988c7aa113b70386bae80dbcd46b9b274.camel@coelho.fi> (Luca
        Coelho's message of "Mon, 13 Dec 2021 13:00:19 +0200")
Message-ID: <87zgp3ivby.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Mon, 2021-12-13 at 12:49 +0200, Kalle Valo wrote:
>> Luca Coelho <luca@coelho.fi> writes:
>> 
>> > From: Johannes Berg <johannes.berg@intel.com>
>> > 
>> > On a 32-bit build, the division here needs to be done
>> > using do_div(), otherwise the compiler will try to call
>> > a function that doesn't exist, thus failing to build.
>> > 
>> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> 
>> Fixes tag? And should this go to wireless-drivers?
>
> I just checked the patch that this claims to fix internally and it's
> rather old.  It went into v5.10:
>
> commit b68bd2e3143adbcbc7afd2bc4974c1b988b87211
> Author:     Ilan Peer <ilan.peer@intel.com>
> AuthorDate: Wed Sep 30 16:31:12 2020 +0300
> Commit:     Luca Coelho <luciano.coelho@intel.com>
> CommitDate: Thu Oct 1 22:00:55 2020 +0300
>
>     iwlwifi: mvm: Add FTM initiator RTT smoothing logic
>
>
> So, if nobody caught this before, I think neither a Fixes tag nor
> taking it to wireless-drivers is necessary.
>
> What do you think?

Weird that nobody else has reported it, maybe people don't test 32-bit
builds that much anymore? But I would prefer to have a Fixes tag, makes
it easier for backporters.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
