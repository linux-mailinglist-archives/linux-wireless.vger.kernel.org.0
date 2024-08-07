Return-Path: <linux-wireless+bounces-11059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD47949FA8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 08:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651161F245E4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D847019D8BB;
	Wed,  7 Aug 2024 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdnzMYuZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CAC19D081;
	Wed,  7 Aug 2024 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010950; cv=none; b=XQkX1eHvadP0KUBjXaWizDBWvcreVpg23uICuof5SwT6qqERZ+yPj5gGVMSjuTV6kF9c2it0fSksRPTUPe0m/CpG3qkucw+QY2KEJSDqcsJm5qgl9q/AUVcvp+4YDFNpA4R5dDN3/hRRUP3ilSyFzloU+/7eRTvfnbtw5lNevW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010950; c=relaxed/simple;
	bh=SuxFkzjIjdP0NFpzTyDjZFERVPF4wIASkMgOigUWRKE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LyI1eYYEzeBNGfOmvP+ibft0a1haDzdRK+9KDWPP6Wsl9oar9g3bAKl8uXEfex3ByIv+J9c191fKI+TjIFGFdZPenBzoMfesD/BP5+kjtUpG8QQbPtJYRfj3hWrl84gVWYNH29Mwl/gRCay/mcStuvO9oVVy0t+Lwij+sPvOYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdnzMYuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B830C32782;
	Wed,  7 Aug 2024 06:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723010950;
	bh=SuxFkzjIjdP0NFpzTyDjZFERVPF4wIASkMgOigUWRKE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HdnzMYuZ4TZqqo6zRJqsZ1OqX4n9QZWmqMK2Ravq5beXVYX2GfvZ35zSAh7jRSFVa
	 5pFyfHVfZX267w/aCG2i7RGUcIa4O8csXTBfi1VYg9uWuYRZO7OiWPIzrghDRsLDOR
	 HD6DpjRfKcltql+7jDkgAEdzzW4qMztE/rbb6hAO6gY3w8zDgsqI8B3bDLT0KNvhB8
	 pWtzVlG4RvXK7ZZm8FyuQcZM7wR7o33tcDzWu1GFMabmr1j0sXo5aBVCTvSNxf8RqH
	 UYbBiy/FwgFlOExS3jscuP/9rhafdWSktC5YU8dSAE0uumyTgOU9US0NqxilIGIzJf
	 LPFzujPS4yH+w==
From: Kalle Valo <kvalo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  ath12k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: linux-next: request to include ath.git tree
References: <87ed7163yd.fsf@kernel.org>
	<20240807080423.45efb506@canb.auug.org.au>
Date: Wed, 07 Aug 2024 09:09:07 +0300
In-Reply-To: <20240807080423.45efb506@canb.auug.org.au> (Stephen Rothwell's
	message of "Wed, 7 Aug 2024 08:04:23 +1000")
Message-ID: <87wmks50fw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Kalle,
>
> On Tue, 06 Aug 2024 18:55:38 +0300 Kalle Valo <kvalo@kernel.org> wrote:
>>
>> ath.git is a tree for Atheros and Qualcomm Wi-Fi drivers residing under
>> drivers/net/wireless/ath/. Jeff and I are the maintainers. Over the
>> years multiple people have been requesting including the tree to
>> linux-next and finally we are biting the bullet.
>> 
>> So we are requesting to pull two branches from our ath.git tree to linux-next:
>> 
>> git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git for-current
>> git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git for-next
>> 
>> for-current feeds the wireless tree and for-next feeds the wireless-next
>> tree.
>
> Added from today.

Thanks!

> I have listed just you as a contect, should I list anyone else (or a
> mailing list)?

Please add Jeff and our ath10k list (all our build reports go to the
ath10k list):

Jeff Johnson <jjohnson@kernel.org>
ath10k@lists.infradead.org

>> Because our for-next branch is very active one problem with is that the
>> chances of having conflicts between the branches is high and that would
>> be extra work for you :/ Do you have any suggestions for this? For
>> example, should we create temporary merges for you or something like
>> that? Just for this reason we do try to keep the number of patches going
>> to for-current minimal and only take important fixes.
>
> Well, your for-next branch should only contain patches that are ready
> for integration i.e. reviewed and unit tested, so it should not be all
> that busy.  I expect you may also have a development branch for patches
> you are still testing.

Yeah, we do have a separate pending branch which is used for testing and
review.

> Otherwise, you should concentrate on your own tree and I will notify
> you of conflicts (and ask advice if the conflicts are too difficult
> for me to resolve).

Great, that sounds good.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

