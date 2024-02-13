Return-Path: <linux-wireless+bounces-3553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DA2853495
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 16:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884A9B241CE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5284A58AB4;
	Tue, 13 Feb 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXaXDpWF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282D5EE62;
	Tue, 13 Feb 2024 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838043; cv=none; b=MwGC3WNgpvq/lvMMhU3PdZtwlJLWTsb43deX/CDX4DGCGU2oYyArTowAE50k3JJO7SzW6aOVDQWq7lwcseYKKiqeMkPRaS6FdvyqJ7vWyfTybZI02TE05erughUuVsGaNz8RnAyXQgkLZeP8v5JFxDJPc/EZsIoLFmOE+60jx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838043; c=relaxed/simple;
	bh=JVjbwYoXdew3kvQWCrF/DJvgpzuG4RWJZp9j/k373W4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uRxuuKpcz5zf4ejRQFO9gdCp3c3Tqe3VOmYGtZQJej0KwW+qR5f2V4rQyUKUzqaTwL0odHUNurzM2BRPIabWm4hHZOU2tBTax5jbO4JCEZYMFCUQAwFsvGj3cP1nTlfKbkGJZ9NgV96QdgHNFJh3lHfVPfoAUdMGwUE3BUaQpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXaXDpWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94979C433F1;
	Tue, 13 Feb 2024 15:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838042;
	bh=JVjbwYoXdew3kvQWCrF/DJvgpzuG4RWJZp9j/k373W4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YXaXDpWFRSuYK80xF7yQekFu6YFQwC+rlIV1Fpa57QEgd7f2IhSIWkVK1D1yqtgsF
	 oxmL5WnczQ/imvN0nu1PI3CGYyfAnMVIYbJZxGJDoSEbihdY1TnmoUtYbP1Ex/E8wp
	 rs8dl+K8qmb+NBmxxnT0lxv6ty7bNaWFpZJSPmNXFV0EIRygCrPbxBKXY4xIwOxNNP
	 OYQscyZ/9E/EG2m7XHqJAZYOTh9ADJidvN+pXSZ7RH8HlXKQ00StJGzkZRKlMbxI7w
	 G0vRm0cHbdJeiFHZAD8Pa3FeJpdsrnLEnLXHQMQ3ifOOmPLBh2FWJOgwFiI49Vztxz
	 GtZsQizV9AOWQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
  <netdev@vger.kernel.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: wireless-next-2024-01-25
References: <20240125104030.B6CA6C433C7@smtp.kernel.org>
	<20240125165128.7e43a1f3@kernel.org> <87r0i4zl92.fsf@kernel.org>
	<18d447cc0b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<877cjwz9ya.fsf@kernel.org> <20240126105255.5476cf85@kernel.org>
	<87mssrxf44.fsf@kernel.org> <20240129115505.76d35e31@kernel.org>
Date: Tue, 13 Feb 2024 17:27:19 +0200
In-Reply-To: <20240129115505.76d35e31@kernel.org> (Jakub Kicinski's message of
	"Mon, 29 Jan 2024 11:55:05 -0800")
Message-ID: <87zfw4o04o.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Sat, 27 Jan 2024 12:08:59 +0200 Kalle Valo wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> >> I don't run checkpatch except for ath10k/ath11k/ath12k, too much noise.
>> >> I ended up adding this to my script:  
>> >
>> > We run build with sparse and W=1 and then diff the number of warnings 
>> > to weed out the pre-existing ones, FWIW.   
>> 
>> So for wireless and wireless-next I now check W=1 warnings every time I
>> push. We are mostly warning free now but I'm not checking the linker
>> warnings, for example the current MODULE_DESCRIPTION() warnings.
>> 
>> It's really annoying, and extra work, that people enable new W=1
>> warnings before fixing them. Could we somehow push back on those and
>> require that warnings are fixed before enabling with W=1 level?
>
> My quite possibly incorrect understanding is that "giving people time
> to fix" is the main point of W=1 :( W=2 is for stuff which may false
> positive, W=1 is for stuff which does not false positive but we can't
> enable it in formal builds because the tree is full of it.

Ok, so keeping the code clean from W=1 warnings will be hard :/

>> In wireless there is a significant number of sparse warnings. I have
>> tried the cleanup people to fix them but it seems there's no interest,
>> instead we get to receive pointless cleanups wasting our time. <loud sigh>
>
> Tell me about it.. :)
>
>> BTW the 'no new line at end of file' warning is indeed from sparse, like
>> Arend suspected:
>> 
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c:432:49:
>> warning: no newline at end of file
>
> BTW I'd happy to help you set up an instance of our build testing bot,
> if you have a VM that can be used. It does take a bit of care and
> feeding, but seeing the build failures in patchwork pays the time back.

We have talked about setting up your build bot for linux-wireless
patchwork project but never found the time to do anything. Also we don't
have a VM for it right now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

