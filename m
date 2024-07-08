Return-Path: <linux-wireless+bounces-10078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4029192A621
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 17:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50FEB20FE0
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3F3139568;
	Mon,  8 Jul 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G53aqs6p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F11EA6F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453915; cv=none; b=Eh2i2Ndy68wZW0PNY1eYmIr58cIz7hI+QGw194XeWX4GFDqPAdddNBDA1UAV2Hz1+FDv0Fx78WjmHYbW5UhkPpQNuEBS5bsZ1O4cX7P17u610XUTnSUkAUq5sGxzG0FOCq6FVr3ppfWNCWiVNHwG+mWzMEJijLb0lTzooVm0qaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453915; c=relaxed/simple;
	bh=VGT2Ll0BJ6zWJMZY1Uv8uMUUvBNnE0W8cZ1/Ln03WAc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gdEFZM3O63hq207bTsMX1UzgHPx2ZCxgeexOE+dZ3lo4/6hMEM9FsRglro38OcuBfIN0uakp/66oDqu/Br2NttCKABXpcFV2Sy8tYBrRSv3JlUVw2cWbv+zfGV8cHUgujlDa8VnfsxiVFSwTeBg4cMaMsvo21aL5h6jMdTkZ4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G53aqs6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A098C116B1;
	Mon,  8 Jul 2024 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720453915;
	bh=VGT2Ll0BJ6zWJMZY1Uv8uMUUvBNnE0W8cZ1/Ln03WAc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=G53aqs6pvr+E27anDXTsc3DQ93BiQ/wQUgGNZbayBnD8ooU5VY7HB9wYDSNp3Dyxo
	 vtviRHLFubYLrGXG5rwG2001IifslRPTGwfI8CSZlbB1TLW3+dlV/6nzHt9y/RVO3X
	 u14+U7Ydyaj9STh8ztCxv09L7F9eSgltA7dDcHlIhXaIHQP4Hfm3JJsY76e7P2Hco9
	 YMzb58CNm2jsdklDwqWZoDQSNAIqDa4Fie6uja54Kp+20J/xPtr46dYZ5E0T166HQP
	 jry23opEmjq0BOhURoApRLaDbmPtiV+orK7A436vvfGT/LAT8VHUgd3mRtIdYssREv
	 6Nct1iy8eMO+w==
From: Kalle Valo <kvalo@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC] wifi: ath12k: workaround fortify warnings in
 ath12k_wow_convert_8023_to_80211()
References: <20240704144341.207317-1-kvalo@kernel.org>
	<202407041551.1DC8C03D@keescook>
Date: Mon, 08 Jul 2024 18:51:52 +0300
In-Reply-To: <202407041551.1DC8C03D@keescook> (Kees Cook's message of "Thu, 4
	Jul 2024 16:25:03 -0700")
Message-ID: <877cdvdgpz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kees Cook <kees@kernel.org> writes:

> On Thu, Jul 04, 2024 at 05:43:41PM +0300, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>=20
>> Johannes reported with GCC 11.4 there's a fortify warning below. The war=
ning is
>> not seen with GCC 12.1 nor 13.2. Weirdly moving the other operand of sum=
 to the
>> other side the warning goes away. This is safe to do as the value of the
>> operand is check earlier. But the code looks worse with this so I'm not =
sure
>> what to do.
>
> FWIW, this isn't fortify, but -Wrestrict.

Ah, thanks for correcting. I just saw fortify-string.h and made the
wrong assumption.

> I would expect the same warnings even with CONFIG_FORTIFY_SOURCE
> disabled. Regardless, it's worth figuring out what's going on. It
> looks like this is GCC's value range tracker deciding it sees a way
> for things to go weird.
>
> I suspect they fixed -Wrestrict in later GCC versions. It might need to
> be version-limited...
>
>> In file included from ./include/linux/string.h:374,
>>                  from ./include/linux/bitmap.h:13,
>>                  from ./include/linux/cpumask.h:13,
>>                  from ./include/linux/sched.h:16,
>>                  from ./include/linux/delay.h:23,
>>                  from drivers/net/wireless/ath/ath12k/wow.c:7:
>> drivers/net/wireless/ath/ath12k/wow.c: In function
>> =E2=80=98ath12k_wow_convert_8023_to_80211.constprop=E2=80=99:
>> ./include/linux/fortify-string.h:114:33: error: =E2=80=98__builtin_memcp=
y=E2=80=99
>> accessing 18446744073709551611 or more bytes at offsets 0 and 0
>> overlaps 9223372036854775799 bytes at offset -9223372036854775804
>> [-Werror=3Drestrict]
>
> These huge negative values imply to me that GCC is looking at some
> signed values somewhere.
>
>> [...]
>> diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireles=
s/ath/ath12k/wow.c
>> index c5cba825a84a..e9588bb7561c 100644
>> --- a/drivers/net/wireless/ath/ath12k/wow.c
>> +++ b/drivers/net/wireless/ath/ath12k/wow.c
>> @@ -186,7 +186,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
>>  	if (eth_pkt_ofs < ETH_ALEN) {
>>  		pkt_ofs =3D eth_pkt_ofs + a1_ofs;
>>=20=20
>> -		if (eth_pkt_ofs + eth_pat_len < ETH_ALEN) {
>> +		if (eth_pat_len < ETH_ALEN - eth_pkt_ofs) {
>>  			memcpy(pat, eth_pat, eth_pat_len);
>>  			memcpy(bytemask, eth_bytemask, eth_pat_len);
>
> Both eth_pkt_ofs and eth_pat_len are size_t. ETH_ALEN isn't, but it
> would be promoted to size_t here. The value tracker should see that
> eth_pkt_ofs could be [0..ETH_ALEN). eth_pat_len is coming from an "int",
> though, so that might be the confusion. It may think eth_pat_len could
> be [0..UINT_MAX] (i.e. the full range of int within size_t).
>
> So [0..ETH_ALEN) + [0..UINT_MAX] < 6 might be doing something wrong in
> GCC 11.x, and it's not actually doing the size_t promotion correctly,
> or deciding something has wrapped and then thinking eth_pat_len could
> span a giant region of the address space, which freaks out -Wrestrict.
> i.e. it's seeing that for the "if" to be true, eth_pat_len could be large
> enough to wrap around the addition (though this shouldn't be possible
> for 64-bit size_t).
>
> So I could see how [0..UINT_MAX] < 6 - [0..ETH_ALEN) would make it
> happier: the right side is now [1..6], so eth_pat_len becomes [1..6).

Earlier I did some testing and I noticed that this if test also gives a
warning:

1 + eth_pat_len < ETH_ALEN

But this doesn't have any warning:

0 + eth_pat_len < ETH_ALEN

And I stopped my investigation there :)

> Reviewed-by: Kees Cook <kees@kernel.org>

So you think this should be applied? It's not really logical so I would
prefer to avoid taking it if possible. Or should we just ignore the
warning? It only happens on GCC 11 anyway.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

