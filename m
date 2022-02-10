Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167854B0FCF
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 15:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbiBJOKw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 09:10:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbiBJOKv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 09:10:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DE7C1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 06:10:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00B47B82542
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 14:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198BAC340E5;
        Thu, 10 Feb 2022 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644502249;
        bh=57h6WjSvQDH7N/EXvBi+p1F8GSrZ+sQ8yCam1Jz4vG0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oVRssXTSjitddYghYBWuLvjDSRBHy4nU48t7QLn9CSvhhGU2BNQSaW5n6h4RJR35i
         4jTszpR/PxO124NIxwFsokNiz90Fu6VjeCxbC7Gk5EkPVYjYC+hQ3kzxugV0uCWB4C
         +gf++H8dP2FoCgpwk/LVU+iYglxOuvHzp+4Y/bUfxqTVB/mSQkFhZ6pcvscWgrmeLs
         EIBzDMvGQi7cZuvkVxDiHmmn7jfPJUyKkOMGUEehf1GUD2/vCKiiGSGrJPKbfG2kuZ
         mfSYQki4w1XkMdDvZpLJWSepGUGbbdvKQmVz10tigcD49BhfxMqiHedycm2MY6iTPU
         P5pi5DDz6nK5g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Wright Feng <wright.feng@infineon.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Subject: Re: [PATCH] MAINTAINERS: update maintainer list for Infineon
References: <20211228061315.11126-1-wright.feng@infineon.com>
        <87czk8djtl.fsf@kernel.org>
        <17eb3f987f0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date:   Thu, 10 Feb 2022 16:10:42 +0200
In-Reply-To: <17eb3f987f0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        (Arend Van Spriel's message of "Tue, 01 Feb 2022 07:29:42 +0100")
Message-ID: <87v8xm3j8d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On January 31, 2022 4:08:29 PM Kalle Valo <kvalo@kernel.org> wrote:
>
>> Wright Feng <wright.feng@infineon.com> writes:
>>
>>> From: Chi-Hsien Lin <chi-hsien.lin@infineon.com>
>>>
>>> Add new maintainer and remove old maintainers.
>>>
>>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@infineon.com>
>>> Signed-off-by: Wright Feng <wright.feng@infineon.com>
>>> ---
>>> MAINTAINERS | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 5ebfc9de0caf..845058803f95 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -3759,9 +3759,9 @@ BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
>>> M: Arend van Spriel <aspriel@gmail.com>
>>> M: Franky Lin <franky.lin@broadcom.com>
>>> M: Hante Meuleman <hante.meuleman@broadcom.com>
>>> -M: Chi-hsien Lin <chi-hsien.lin@infineon.com>
>>> M: Wright Feng <wright.feng@infineon.com>
>>> -M: Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
>>> +M: Double Lo <double.lo@infineon.com>
>>> +M: Kurt Lee <kurt.lee@infineon.com>
>>
>> I'm not really a fan of having too many maintainers, I would say max is
>> 3 and even that needs good justification. And most importantly, is
>> anyone else than Arend even doing any maintainer work for brcmfmac and
>> brcmsmac?
>
> Guess it should be clear what falls under the term "maintainer work".

From my point of view most important tasks of a maintainer are reviewing
patches and addressessing regressions (both runtime and build issues).
Of course there are others tasks as well, but these I consider crucial.

> Infineon does a better job these days when it comes to contributions
> adding features and new chip support, but that doesn't fall under the
> category although maintainers do submit their own patches. It's good
> to have a go-to guy at Infineon as they independently work on firmware
> and it's APIs. On our side I can probably remove Hante from the list.

Anyone can submit patches, and there can be a contact person from a
company even if it's not mentioned in MAINTAINERS.

I want to see that a maintainer really cares about upstream and works
with the community, like you Arend do. I do not want to add persons to
MAINTAINERS file and never hear from them again, that's just wasting
everyone's time.

To give a positive example, Ping does a great job maintaining Realtek's
rtw88 and rtw89 drivers. So if a company wants to learn how to become a
good maintainer, follow what Ping does :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
