Return-Path: <linux-wireless+bounces-7177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702E8BBF32
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBA91F216A0
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 04:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCD0184D;
	Sun,  5 May 2024 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVDPvqmj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E891849
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714883342; cv=none; b=ntfdZ19vG4LhC9yxvSH6P5J9dX0fotJP14xw0eKgWZ9BNyD1IXLW5veAQJ72G9EP1tZnycAGhP0ZjjREwEofGBQMZ2FcawaqGHWjmW+zGxV6F8b5ZERe3yT4uyC2K+jYjXlIYOnrr6NaWTX9bTJpOhLn9b/a5nEw0s1dhJj4t+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714883342; c=relaxed/simple;
	bh=VLRH04vsduxAGYWjE9Re6yBEECuJ74ZnUcOjFULKtwc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=C+fbZ4tIgPXcdU/sXyFjVlZyOmeQI6DqOXRbZ44Ka27JrsYlL9SZzDucXzpDOWGfOySaK5O5nrVQv1GwTJ7TpkiZgaHRYsWvEjb3D5skD/Md77jrZowtfzUnJwwQWzuYtfEA0g3JkZMdoCegHbhZxqm/vFCi0ah7ca6tKUnEyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVDPvqmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910BDC113CC;
	Sun,  5 May 2024 04:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714883342;
	bh=VLRH04vsduxAGYWjE9Re6yBEECuJ74ZnUcOjFULKtwc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=bVDPvqmj2ff31jfd71q/NKIIqcvm6Gq9uks09VdGDrgTAnR3HTY2ryx8AR3ms/RA1
	 8SDCJ8urbcSjevBWMmu0lEv7ZD9mS9MWF3YcdHWKoEzMPhsaTWntnrReK8cBA4daId
	 fz1pL4uBWlF7Y/H3aPH2FODB6okv47dTP1XpggzzMxtWjrmxwYmrzoVNVpEUzbyDQB
	 6qrjpHwggatZcUSf7SQ/NaeNhw8dO0zPcT9p4B/5j3KVAOkX1sHQ6RQKoCZZbaLT3K
	 gTZhH9U2+NInNmFI5GqBkyTyQhM16gwk0TSkDbgi3oh5Sa2LoNcjCBrZY2eIrtl0yw
	 e+RhW8EHz2Ccw==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: rtw-next-2024-05-04
References: <333d56f0-ef24-4946-958d-e804cf9c733b@RTEXMBS04.realtek.com.tw>
	<171480660387.2072516.10612946227059882367.kvalo@kernel.org>
	<03e00a7f47c86323f34748853ba38859b4d52695.camel@realtek.com>
	<87seyxn1dw.fsf@kernel.org>
	<6df3012b6edb9aa8bffa170c1d9144750494bee8.camel@realtek.com>
Date: Sun, 05 May 2024 07:28:59 +0300
In-Reply-To: <6df3012b6edb9aa8bffa170c1d9144750494bee8.camel@realtek.com>
	(Ping-Ke Shih's message of "Sun, 5 May 2024 02:22:36 +0000")
Message-ID: <87o79knapg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> On Sat, 2024-05-04 at 16:38 +0300, Kalle Valo wrote:
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > On Sat, 2024-05-04 at 07:10 +0000, Kalle Valo wrote:
>> > > drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c:986:2:
>> > > ./include/linux/bitfield.h:189:15: warning: 'rate_mask' is used
>> > > uninitialized [-Wuninitialized]
>> > > 
>> > 
>> > I have updated gcc to 13.2.1 (local build), but still can't see this warning.
>> 
>> I'm not sure if you aware that crosstool provides an easy way to test
>> different compilers. More info here:
>> 
>> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/codingstyle#tools
>
>
> I didn't know that before, and I use that convenient cross build now. :-)

There are also similar packages for clang:

https://mirrors.edge.kernel.org/pub/tools/llvm/

> A question about GNUmakefile, it seems miss
>
>   include Makefile
>
> Otherwise, 'make' told me no rules to make.

Indeed, thanks for reporting that. I fixed now the wiki.

>> > Then, I force to add -Wuninitialized and delete -Wno-maybe-uninitialized
>> > locally, and I can see this warning (but -Wmaybe-uninitialized instead).
>> > 
>> > I did suspect wireless-next tree does more compiler options, so I also
>> > tried to merge the tree, but still the same.
>> 
>> Weird, maybe it's due to different kconfig options? I have attached my
>> .config which I use to compile test wireless trees.
>
> Using your .config can reproduce the symptom, and then I try to bisect CONFIG_xxx.
> The cause is "CONFIG_DEBUG_SECTION_MISMATCH=y". My .config didn't have that.
>
> I also tried my original compiler that can also see the warning with
> new .config.

Ah, I would not have never guessed that option could cause something
like this. Very good to know.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

