Return-Path: <linux-wireless+bounces-9532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2EF916CF9
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C369328B77D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0D170827;
	Tue, 25 Jun 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0UWZ99e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6016DEB3;
	Tue, 25 Jun 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329117; cv=none; b=BRVCv1K5/A6y0KwdgRCLFre2szcwNV4kGS20AyFMvOLbYxoHQakRRionAyyY8l6kWDqCVdo6Jbc4Cn7XNNGPdZwrYL4jdCbV02ZQXqWV1P/U6SC2fCeojzDfbcU7OG2ai4hmNywV051BR0bNt2ft5JplPMdh7h3tujB76G9sSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329117; c=relaxed/simple;
	bh=8pXLi0+NE2elKsEGz3Exeg1kDvY+fHABVyxjsl7HrNI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ODNvTAgKscX/o1EnIgH6VdqNReE2+4Hm11ZZSzxFWzwUF1PNe3mq+6VyCPbdH6oiZn9h2xWh4JgWezOzGnL2v2f/PVBNToqJSBDYaZwxC1zmUrVvm5J2edyK61s49OcfTxFXt837I5i2XE6dffpJQlaIWAlLyKjlcrqm5hKjSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0UWZ99e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42CBC32781;
	Tue, 25 Jun 2024 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719329117;
	bh=8pXLi0+NE2elKsEGz3Exeg1kDvY+fHABVyxjsl7HrNI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Y0UWZ99e81f92pCKDy/ylcK54a2iCMmLSB3RltsaGQs72cjZYgVQ9wGF7SKhM1LRE
	 6+jSqJQsQQASg4sy82IGvB8FlpAKrBeHjVaS/mnnHY6wu0AegRToWx4WD07pqBbKS3
	 tXIT9L/oMTdRWeoJyGjg68VZ4vQ6NA4BL9ZDihNaXQUMliXQCVNpCVHgIkfFNCI60B
	 26eja9WqGWkiQH67YTIAQwFvYfiKKfoiW4Xe6wafdM7zH1RBpayRmZ7jMI4TU6UT5y
	 P9yVqxDa8mBURa5b8OVPxiuyYw5uuGQtjWx23p4czraCfdxdiPSKfMHsH5arFGaywM
	 blOFXGQpi2lzw==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  Koen Vandeputte
 <koen.vandeputte@citymesh.com>,  <ath10k@lists.infradead.org>,
  linux-wireless <linux-wireless@vger.kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  <netdev@vger.kernel.org>,  Johannes Berg
 <johannes@sipsolutions.net>,  Kees Cook <keescook@chromium.org>
Subject: Re: ieee80211.h virtual_map splat
References: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
	<c470e4ff-3f70-40f6-844a-f9614286509f@quicinc.com>
	<87o77pik7w.fsf@kernel.org> <20240625080248.32c3e03d@kernel.org>
Date: Tue, 25 Jun 2024 18:25:12 +0300
In-Reply-To: <20240625080248.32c3e03d@kernel.org> (Jakub Kicinski's message of
	"Tue, 25 Jun 2024 08:02:48 -0700")
Message-ID: <87jzidhwo7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 25 Jun 2024 09:56:35 +0300 Kalle Valo wrote:
>> > Adding netdev to the initial message in the thread.
>> > https://lore.kernel.org/all/CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com/
>> >
>> > There was some discussion in the thread, with the observation that the splat 
>> > is fixed by:
>> > 2ae5c9248e06 ("wifi: mac80211: Use flexible array in struct ieee80211_tim_ie")
>> >
>> > Followed by discussion if this should be backported.
>> >
>> > Kees said that "netdev [...] maintainers have asked that contributors not 
>> > include "Cc: stable" tags, as they want to evaluate for themselves whether 
>> > patches should go to stable or not"  
>> 
>> BTW this rule doesn't apply to wireless subsystem. For wireless patches
>> it's ok to "Cc: stable" in patches or anyone can send a request to
>> stable maintainers to pick a patch.
>
> It's an old rule. Quoting documentation:
>
>   Stable tree
>   ~~~~~~~~~~~
>   
>   While it used to be the case that netdev submissions were not supposed
>   to carry explicit ``CC: stable@vger.kernel.org`` tags that is no longer
>   the case today. Please follow the standard stable rules in
>   :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`,
>   and make sure you include appropriate Fixes tags!
>   
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#stable-tree

Oh, I haven't noticed the change. Thanks for correcting.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

