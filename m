Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80486079F7
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 16:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJUOyH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 10:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUOyD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 10:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721991C7D67
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 07:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0452F61E9F
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 14:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C719C433C1;
        Fri, 21 Oct 2022 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666364041;
        bh=YkdKKhuQYAePU8PzS4XDhmnIRcGSwTseG/XT9dApCxQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Dfr1bx3Sv4GhOeT/1OFJWTAyAlQpainQkHiXoCxfJFzoxB6AYa9Bksoknx3KaQpHX
         DABVpJNIEEMl9j9zVan6t7FH32UQ0h5O3coqqPW2tDPQfj4o9AW6BYHex7YxJvx9gX
         4BTkyifhg6BCz145yH0gtA3lDCvP27FHlkyTgWNAsRjVy795Qe6Xfnj2JnoHWnGbsx
         MLb+tRTKITN8tM2s3zy1+tMmaBauJY23T6LuloG5TrMInvwH6g2nm/JkKK1iJoDBnf
         yCJ9/BqndasAtu9+dDifJVkTyzSZ4Dw90PtHKL73l1D92rheNNp/jL5PELLJQG/tzQ
         4RLfbKTlHty3w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend Van Spriel <aspriel@gmail.com>
Cc:     Dokyung Song <dokyung.song@gmail.com>,
        linux-wireless@vger.kernel.org,
        Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: Re: [PATCH v3] wifi: Fix potential buffer overflow in 'brcmf_fweh_event_worker'
References: <20221021061359.GA550858@laguna> <87v8od1x69.fsf@kernel.org>
        <10230673-8dbe-bf67-ba76-9f8cdc35faf3@gmail.com>
Date:   Fri, 21 Oct 2022 17:53:54 +0300
In-Reply-To: <10230673-8dbe-bf67-ba76-9f8cdc35faf3@gmail.com> (Arend Van
        Spriel's message of "Fri, 21 Oct 2022 10:38:20 +0200")
Message-ID: <87czali5x9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <aspriel@gmail.com> writes:

> On 10/21/2022 8:57 AM, Kalle Valo wrote:
>> Dokyung Song <dokyung.song@gmail.com> writes:
>>
>>> This patch fixes an intra-object buffer overflow in brcmfmac that occurs
>>> when the device provides a 'bsscfgidx' equal to or greater than the
>>> buffer size. The patch adds a check that leads to a safe failure if that
>>> is the case.
>>>
>>> This fixes CVE-2022-3628.
>>>
>>> UBSAN: array-index-out-of-bounds in
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
>>> index 52 is out of range for type 'brcmf_if *[16]'
>
> [...]
>
>>> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
>>> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
>>> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
>>> Reviewed-by: Arend van Spriel <aspriel@gmail.com>
>>> Signed-off-by: Dokyung Song <dokyung.song@gmail.com>
>>> ---
>>> v1->v2: Addressed review comments
>>> v2->v3: The subject now begins with 'wifi:' and add a reference to a CVE number
>>>
>>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>
>> Please include the driver name in the subject. And we prefer use
>> parenthesis with function names. So the subject should be:
>>
>> wifi: brcmfmac: Fix potential buffer overflow in brcmf_fweh_event_worker()
>>
>> I can fix that during commit.
>>
>> Should I queue this to v6.1?
>
> Please do. Probably good to add Cc: for stable. Should apply to older
> kernels as is.

Ok, I'll add that as well.

> btw. is there any formal way to reference CVE. There probably isn't as
> generally we don't require a CVE in kernel tree [1].

I'm not aware of any formal way to mark CVEs. If there are, please let
me know :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
