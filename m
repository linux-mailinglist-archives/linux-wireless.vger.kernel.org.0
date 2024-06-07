Return-Path: <linux-wireless+bounces-8674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 985368FFFC7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 11:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2080DB230EF
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF6415AACA;
	Fri,  7 Jun 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTtxPuYS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E975C823B8;
	Fri,  7 Jun 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753352; cv=none; b=oWapHTdEEEg4493s36/VE2yB8WiYLVKg5snBXPQ1W2r2wDvtCVkywOS+AS33bM6ZbO+WS7XQC0X8NMlmVz9OXXDdI2CP0rLwlR2BCDgaqxezIrA24lkJUmRq2GMrCSEL0Fs00k4PcYDQgeGxDTPCZuWK3JDUT4zmiaapiFm0UqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753352; c=relaxed/simple;
	bh=rzOTK7iTzJL4x7eQJVFwNhkGCeHEwZpsX4KoQt/lygM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rehSIkVnK0yqZQ1ENRdD7e8eBhqQmu6tzQasAEn0tRjSt4PrJr+xO/wQNtXvV1yHjZEqY5RKczo4VGFyUhrymcSw7LVZZF6cd7qGGWOjJASru8iokDLwg/toX+dwWn3iim8I3/DRRUHiwzXu258Fw8/CAdMoC96/z1u6Itp1DJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTtxPuYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B90C2BBFC;
	Fri,  7 Jun 2024 09:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717753350;
	bh=rzOTK7iTzJL4x7eQJVFwNhkGCeHEwZpsX4KoQt/lygM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eTtxPuYSubQIllceNgJdQ6PcGD4v61ot/XfnTW017iHKhAjVe5PjFLLDoJume3mGb
	 2WelaFx5o6w5yBf8Yi/MGRMlci2shoTltOf8xZfL9TIavL/NtXU39FdXhl7yWFhrob
	 +craVAwNJ4f4L6Z+eoV1EMUWUSN+i/D/1sb6YrcMK2MNHIi3cG2brTYsnA/Iw3Mj4f
	 FxDkkkEl2QZb9v5Wwswh5gSNVID43Mea3q94TMDnjJc9JjYo6+PuhFO7OGv61leYCA
	 jiu43Cjxhu5tNNt0D7ySkUOhkZBLvKK2bA2lLnwISv4wenwWyh6qR0Fh9KHhIpJ4Ce
	 EjAo20lA0zloQ==
From: Kalle Valo <kvalo@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2024-06-07
References: <20240607093517.41394C2BBFC@smtp.kernel.org>
Date: Fri, 07 Jun 2024 12:42:27 +0300
In-Reply-To: <20240607093517.41394C2BBFC@smtp.kernel.org> (Kalle Valo's
	message of "Fri, 7 Jun 2024 09:35:17 +0000 (UTC)")
Message-ID: <87wmn1ks1o.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Hi,
>
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
>
> Kalle
>
> The following changes since commit 83127ecada257e27f4740dbca9644dd0e838bc36:
>
>   Merge tag 'wireless-next-2024-05-08' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2024-05-08 19:09:38 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-06-07
>
> for you to fetch changes up to a46300b1b09ba260c2c2b00f06f6e34482a8ec01:
>
>   Merge tag 'ath-next-20240605' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath (2024-06-05 21:29:56 +0300)
>
> ----------------------------------------------------------------
> wireless-next patches for v6.11
>
> The first "new features" pull request for v6.11 with changes both in
> stack and in drivers. Nothing out of ordinary, except that we have two
> conflicts this time:
>
> CONFLICT (content): Merge conflict in net/mac80211/cfg.c
> CONFLICT (content): Merge conflict in drivers/net/wireless/microchip/wilc1000/netdev.c

The wilc1000 conflict is too complex for my liking and I want to
apologize for that. Here's a direct link to linux-next code, hopefully
it helps fixing it:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/net/wireless/microchip/wilc1000/netdev.c#n964

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

