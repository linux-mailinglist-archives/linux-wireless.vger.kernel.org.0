Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10C049E633
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 16:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbiA0Ph4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 10:37:56 -0500
Received: from mail.toke.dk ([45.145.95.12]:45897 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbiA0Ph4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 10:37:56 -0500
X-Greylist: delayed 17247 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2022 10:37:56 EST
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1643297875; bh=2v+Sdt2P4fyJ2JOOJ+IrAZ0xSSOEk7jQrz0daLRnZk8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gtWUak93C8998RXhSZmisY54RPBWPhj0ckR6MKxJwtP2ouvMs7IALtMgGA7X07Xg1
         sD/OjaAy3PDu4CQ2QhpwbDeOUHkZlzJgHERhAx2BcNOltXntp64lDaM0dnrLN46S/1
         G8RyhrX4aeRmavZA0MA7dPHX7LoEIkrIe6I7eaywHyrLJetCHFPZDCFHyQEXPo9SKk
         4T+RW9iN6RsRroqWV3muUJqXO4owFZifSdISrjJ8fAtN/u8MTth3+Tfe09jVtyQWug
         JD9tdIQWprMe4seN1KZP2VwLd/5jkHcqEiUrWcx3hOewMdTJxIlAed9qq+JrsJ9C+Y
         sBzimGVYJ1jfQ==
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, loic.poulain@linaro.org
Subject: Re: [PATCH 3/4] MAINTAINERS: hand over ath9k maintainership to Toke
In-Reply-To: <87v8y5jslk.fsf@kernel.org>
References: <20220127092709.5203-1-kvalo@kernel.org>
 <20220127092709.5203-3-kvalo@kernel.org> <87sft91mh9.fsf@toke.dk>
 <87v8y5jslk.fsf@kernel.org>
Date:   Thu, 27 Jan 2022 16:37:54 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87mtjh1965.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>
>> Kalle Valo <kvalo@kernel.org> writes:
>>
>>> In practise I have been the only maintainer for ath9k for some time now=
 but I
>>> don't really have time for it. Luckily Toke is willing to look after so=
 mark
>>> him as maintainer. Thanks Toke!
>>>
>>> Signed-off-by: Kalle Valo <kvalo@kernel.org>
>>> ---
>>>  MAINTAINERS | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 2bf3b1f7442e..b1251fc9a71d 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -15899,9 +15899,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kerne=
l/git/kvalo/ath.git
>>>  F:	drivers/net/wireless/ath/ath11k/
>>>=20=20
>>>  QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
>>> -M:	ath9k-devel@qca.qualcomm.com
>>> +M:	toke@toke.dk
>>
>> Could I get my full name in there, please? :)
>>
>> I know it has weird unicode characters, but you can copy-paste it from
>> my other entry in MAINTAINERS
>
> Oh, sorry about that! I'll submit v2.

Great, thanks!

-Toke
