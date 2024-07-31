Return-Path: <linux-wireless+bounces-10755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B38E9433F2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B149282954
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2211BB6B2;
	Wed, 31 Jul 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4fqyeEn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19F1B29A7
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442443; cv=none; b=EGJD66SorJmzRAQ51y6ka6v+iPi2swBdHC0zigIDio17rRhw2HDcTVFhoy3/uFzD/RgApRmrncfGoJTEDq/bDKULOF6EHW5Jene02ptMS2sdiylUZ24pb+DY+46Wlsapn1HAMLX0ahi/ZFniI0whBUynUvHj5s5w0m2IHZM+pj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442443; c=relaxed/simple;
	bh=FI4to2s/kw3JnehGaIGMy9gv9Bjt9lTDL7rbCa8lSBo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hXC2mr9EMlu6fD1at3JYxDdIf9JPt1/qmo0UlqFC4PJuEHMx/XsBQoyx4QD11zhLF6NPvh9QJHurE4pL0Ua16st9MBrDH4ZW0lCVy1FPPy8dJ2KbUrJZIoEjt35LGchdrZlKyYnOjqiyDekZJPRHqSRiLdGFl5UpRasTWtT97U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4fqyeEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518FDC116B1;
	Wed, 31 Jul 2024 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722442443;
	bh=FI4to2s/kw3JnehGaIGMy9gv9Bjt9lTDL7rbCa8lSBo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=r4fqyeEn6UuM1nr5vTH369N+YnegkQy5R0JFuxZEoFG8HTWG7RVyBtnAwDY0c+b4j
	 EhxxD7O//qobp+G3A5VSFsYv97TFF3+SY1E8E+TKtGE/15rhBPG74sFinIDTBmNwek
	 5nfpzO0j5nwbWZM7cUrudF2nwV94C6CvM1V5qxF6L7ADSMhGoxeGn5tBqpSR0l6kaC
	 pJMD7K6p+L3ywN7FZFro4Owju8QWo/F3LE3orPER1muDlaCyBt7I4RrykNOU8/i5a1
	 4xhTFTD8UikIv6rE9h/Sb6+U+4Jw9hzcCt/kJVVL9frVuOCE5/AnVWFs71WiDNb91g
	 d1mqJJHfm1N7w==
From: Kalle Valo <kvalo@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Kees Cook" <kees@kernel.org>,  ath12k@lists.infradead.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC] wifi: ath12k: workaround fortify warnings in
 ath12k_wow_convert_8023_to_80211()
References: <20240704144341.207317-1-kvalo@kernel.org>
	<202407041551.1DC8C03D@keescook> <877cdvdgpz.fsf@kernel.org>
	<202407081226.94B1FB24@keescook>
	<973f9a20-0807-4302-a286-d3ff6478529f@app.fastmail.com>
	<87v81d9lk4.fsf@kernel.org>
Date: Wed, 31 Jul 2024 19:14:00 +0300
In-Reply-To: <87v81d9lk4.fsf@kernel.org> (Kalle Valo's message of "Wed, 10 Jul
	2024 20:57:47 +0300")
Message-ID: <87r0b98rp3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> "Arnd Bergmann" <arnd@arndb.de> writes:
>
>> On Mon, Jul 8, 2024, at 21:31, Kees Cook wrote:
>>> On Mon, Jul 08, 2024 at 06:51:52PM +0300, Kalle Valo wrote:
>>>
>>> I suspect this won't be the only place in the kernel where -Wrestrict
>>> will give weird results with GCC 11, and there are still plenty of folks
>>> using GCC 11. I think the best option would probably be to version-check
>>> GCC to gate the addition of -Wrestrict.
>>>
>>> Arnd, what do you think? This looks like a more extreme version of
>>> commit f9fc1ec28bae ("crypto: drivers - avoid memcpy size warning")
>>
>> The f9fc1ec28bae patch was the other way around, it showed up
>> in new compilers but not old ones. I don't think I've seen
>> more gcc-11 -Wrestrict warnings during testing, but I'm currently
>> not set up to do a thorough search. If it's the only one, then
>> Kalle's suggested workaround is probably best, but if there
>> are additional warnings on gcc-11, making the warning depend
>> newer compilers is also fine. 
>
> Honestly I was hoping that we could disable the warning for GCC 11 :)
>
> I feel bad making the code worse due to a compiler problem. For example,
> Intel's zero day bot doesn't seem to use GCC 11 that much anymore, so it
> might surprise more people than just us ath12k folks. (The bot said
> everything was fine but Johannes saw the warning when the code was
> pulled to wireless-next.)
>
>> I just don't want to give up the warning for new compilers altogether.
>
> Me neither. I'm just hoping that we could disable it for GCC 11. But of
> course if you think it's better to add the workaround to ath12k, I can
> submit a proper (non-RFC) patch to do that.

For the archives: Paolo found a nicer way which is now commited:

https://git.kernel.org/linus/b49991d83bba

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

