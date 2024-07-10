Return-Path: <linux-wireless+bounces-10155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0454792D7D7
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 19:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B13281794
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F619539F;
	Wed, 10 Jul 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVs7nBHd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D3848E
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634271; cv=none; b=n39Zey2uDPT1GqC2VEuj3hlbI/C7MT2D8wl49GRPKh5n3AW9Xe5M/xQqoVIfTvbvx/h7KYKOwtyVza2eLe7aSCkkADbxIHsanNlXacVhAJ9+h+t0geTtMKEqhoGxrCJ4YENf7JTnVO637q/yowRNS4dzbImfE79a24O0FFEbA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634271; c=relaxed/simple;
	bh=gdLqjCpDLwxbDF582YXqZlohACs8bz6oUymsKUdbgG4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LaULoA8OUMgM4zUbZJmuBjK5woObiQt4CPLqp31sneYPYmIf2KKvzmDJGAcfo6ZgsUEiJyl5rrDJzlmx6+b2c38XRL8oo762sL5JZkS8jQTEke8wWCiGWOMhfffOESWc1+i5jZoJhnUg360VPv0W0JIR6UIUHbGkzNq/q3TOaIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVs7nBHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1829C32781;
	Wed, 10 Jul 2024 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720634270;
	bh=gdLqjCpDLwxbDF582YXqZlohACs8bz6oUymsKUdbgG4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DVs7nBHddK/GKjqTkSLRYtWLisEIEh3vZZZfKCFpDc0uHXZ7cXVwRNZa9mppcEW92
	 brpydQZjPolQiKrsmlnMuV1LwOtoaLoQkqkCMlgExgzXCopNfvKuLy//l1ogeuuFSH
	 +w0S/XfaC7cj5uNawweHZSldVk5pDaHozNkyeM1nlP7/W9qqcUex7qy3soUtCqh4xw
	 IdcWCG83l1MZmd1FqpcUsts5+fma+OEGPHw5VvxvIdZ/WHgfI7wlZTLFGV/Um7dvkO
	 81xT7dhBmETe3d57H2UrJ61okbfOGSrN4OazJW2E5n5L+17Tt8ZdDtV+0e4FCy+Dxk
	 yx5S0RZFG7xiw==
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
Date: Wed, 10 Jul 2024 20:57:47 +0300
In-Reply-To: <973f9a20-0807-4302-a286-d3ff6478529f@app.fastmail.com> (Arnd
	Bergmann's message of "Mon, 08 Jul 2024 21:47:44 +0200")
Message-ID: <87v81d9lk4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Mon, Jul 8, 2024, at 21:31, Kees Cook wrote:
>> On Mon, Jul 08, 2024 at 06:51:52PM +0300, Kalle Valo wrote:
>>
>> I suspect this won't be the only place in the kernel where -Wrestrict
>> will give weird results with GCC 11, and there are still plenty of folks
>> using GCC 11. I think the best option would probably be to version-check
>> GCC to gate the addition of -Wrestrict.
>>
>> Arnd, what do you think? This looks like a more extreme version of
>> commit f9fc1ec28bae ("crypto: drivers - avoid memcpy size warning")
>
> The f9fc1ec28bae patch was the other way around, it showed up
> in new compilers but not old ones. I don't think I've seen
> more gcc-11 -Wrestrict warnings during testing, but I'm currently
> not set up to do a thorough search. If it's the only one, then
> Kalle's suggested workaround is probably best, but if there
> are additional warnings on gcc-11, making the warning depend
> newer compilers is also fine. 

Honestly I was hoping that we could disable the warning for GCC 11 :)

I feel bad making the code worse due to a compiler problem. For example,
Intel's zero day bot doesn't seem to use GCC 11 that much anymore, so it
might surprise more people than just us ath12k folks. (The bot said
everything was fine but Johannes saw the warning when the code was
pulled to wireless-next.)

> I just don't want to give up the warning for new compilers altogether.

Me neither. I'm just hoping that we could disable it for GCC 11. But of
course if you think it's better to add the workaround to ath12k, I can
submit a proper (non-RFC) patch to do that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

