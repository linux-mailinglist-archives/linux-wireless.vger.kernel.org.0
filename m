Return-Path: <linux-wireless+bounces-3554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E006085350A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192EE1C20DCC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED025EE60;
	Tue, 13 Feb 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxLMcrzM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687315DF26
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839196; cv=none; b=RjNtMgVkOKLWguD4uw6zvVYM0RP6p1TSNvgYcAinTwV8C8f+f5vWbr+K2O3Qc5aW/sVD3EHtKoCd6VADtsQE9wvCwAYVgKgYeEtOrrBjO/IZmYzhvEk6dLChIq7StZdfegkQ4mcWYTJHhcSGn6BfqTCAQE2q2lX4K74K6KSgVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839196; c=relaxed/simple;
	bh=xUdwS92MD3/GfkK0phydV5JDfYZ1rSSFzUp70N76yGg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ae2PCi5hNLrvZGAEjd+IT/jlRvF/eToSCKdAC0cmJSGT5B4NiPdQ5Y8UmL3AnEbJCbk8R2LD6lTsOwo+a9S+DeOVP6O1XP/zgLFlpinKH5p4vzJ37vYcyQzsIB9gJzYIPwDVQW8PIQmaPrJ1dLCVIaFdUqpZ8YWXnpwO4uPhdF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxLMcrzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E111C433F1;
	Tue, 13 Feb 2024 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707839195;
	bh=xUdwS92MD3/GfkK0phydV5JDfYZ1rSSFzUp70N76yGg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=SxLMcrzMrfUok8ULTAn+Cj/BCUMF6EpGteLFYU+l9tGFEOR/xcOZIs/uurW94Gdh8
	 LnpVlL0TpqSOZSflhTfo+z6eJRoBKA6MpL5LuGdQ4cWqwd+8/hU9Jdz6Bd3jYmH/O0
	 IjB6K0odPOV53/jTZW7NJhIIcdVwCX2F1sxaBZn9kNbxDP7D48bIgpMqQYdFlhsHP+
	 qIXRxPrCmucg3f1maEyHaIuWI8za59cbEse5W43JYiYQn9GAeUv8OOaFuYAlaIp9T2
	 LBAnl/S4h9QBjkrl+nTW5x1KJGpolgg4BOGz/G7pjXdCIDn4Vki2pOkVF4UqbQ1FJF
	 tdxd7GEhFKu2Q==
From: Kalle Valo <kvalo@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: do not cast hidden SSID attribute value
 to boolean
References: <20240208085121.2430-1-a@bayrepo.ru>
	<170775233602.2851594.8173116143852900695.kvalo@kernel.org>
	<9667b492-d3d3-4b04-bef4-f507387a9261@broadcom.com>
	<87cyt1pt4x.fsf@kernel.org>
	<18d9e33a040.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<878r3opjx9.fsf@kernel.org>
	<bd282847-0408-45cc-a203-11e808ec5f39@broadcom.com>
Date: Tue, 13 Feb 2024 17:46:33 +0200
In-Reply-To: <bd282847-0408-45cc-a203-11e808ec5f39@broadcom.com> (Arend van
	Spriel's message of "Tue, 13 Feb 2024 15:01:08 +0100")
Message-ID: <87v86snz8m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

>> My bad, I misunderstood your intentions. Luckily this time it wasn't
>> serious.
>> BTW to make super clear to me I would prefer that you (Arend) use
>> Acked-by. It shows up in my script like the number '1' here:
>> *[  4] [next] wifi: carl9170: Remove redundant assignment t... 1 - -
>> 2   5d Colin Ian Ki Under Review
>> So if I don't see your Acked-by then I will not even look at the
>> patch :)
>
> Sure. I tend to use Acked-by if things look sane a quick glance. If I
> need to dig further I prefer to use Reviewed-by. If I have comments to
> revise the patch I will refrain using them. Is that ok or you really
> want it to be Acked-by?

Ah, now I understand better. My understanding is that the maintainer of
the driver uses Acked-by and others use Reviewed-by. This says the same:

https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

And yes, I would prefer if you could use Acked-by always. It's up to
your judgement if you do just a peek or in-depth review :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

