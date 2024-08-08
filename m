Return-Path: <linux-wireless+bounces-11126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B67994BC6A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 13:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08291F211FE
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D57813A257;
	Thu,  8 Aug 2024 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeqQQj93"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDAF12C7FD
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117239; cv=none; b=mSGeg2o+tGhRMpSsISOqhkZEfCm6i40oZq/aB12cCsOvaV30wYM86bqLtSc45l36wrTlDi//N29WP7R6aRRzukCUd8UDWgeDtwz5rGV1SARUyw5nfqFQaEJLYuYeUTox7AZ8F6v/Mv5RIevY9XR2KSkC4bRn54FI0DJ+Q4sNzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117239; c=relaxed/simple;
	bh=4jDsPyOWe7EkT+2mk6kcIQSKChhzeOPX87tIlQr6qHw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DOk7KHkWNW0uaJ+iJzVN0ex/O7As2l7KMnMHCI8mCe2RuB/hU9jyrTV/QfHs/MLV6ML7UB43iv+AbmLvw+xM2H0Nv3LULBvMyt+mvsAoyciSSJojX1OlaIZMi3JZrJsnff6BpgwLsWILRgkb3GHD4uOjdX84L9fRFFIWf9Wpf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeqQQj93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58226C32782;
	Thu,  8 Aug 2024 11:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723117239;
	bh=4jDsPyOWe7EkT+2mk6kcIQSKChhzeOPX87tIlQr6qHw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OeqQQj93wRVNE45A68BEpJ2sYfUKrFRAFRlQ+DmlwTQdfpZF2LPmn4VMgEH67MVgW
	 GqmstX+pduXXdjFgtigIPfDAVo/x+lu1WZQNkCpY7vSXP59uX0OS2tlcOYqd0y4e75
	 4K8FjHPs0nICUW8kIYhDkSDhXPxk+kadhFXGCR7c1xsMNNTR3eAQBMC71gEEF0NqEM
	 Jc/c3bc+E3l7kuztbNP6Zz7Qlo2LPY8xeBePhVD0clnGYov9cRvWRI6WbWAWGCXSsN
	 Bd4IfHpWlhzcYCpx4WosjkWIfEx11uIPT6uq/szgK25WEw9ifIqV/h7JOKH8nKHtoY
	 LHUbOUTE+9fdw==
From: Kalle Valo <kvalo@kernel.org>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>,  Rosen Penev <rosenp@gmail.com>,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net: ath9k: use devm for request_irq
References: <20240731210243.7467-1-rosenp@gmail.com>
	<201f06b6-14f5-41bb-8897-49665cf14b66@nbd.name>
	<CAKxU2N9r3Y=Z+rtPbCteWA8-5fRb2NTy2e4xG+=7JvhtzHPg7A@mail.gmail.com>
	<5dfa4b5a-d8eb-42a8-92bb-81e713fe3395@nbd.name>
	<CAKxU2N_9naiGUk8uOwWNUNbzf8SFPdYPt-Wzg93pksjau2tLLA@mail.gmail.com>
	<48cdd408-ab33-4b2e-83e3-73a89c10e368@nbd.name>
	<87plqjpds4.fsf@toke.dk> <87zfpn2ua8.fsf@kernel.org>
	<87jzgrpaf9.fsf@toke.dk>
Date: Thu, 08 Aug 2024 14:40:36 +0300
In-Reply-To: <87jzgrpaf9.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Thu, 08 Aug 2024 12:37:46 +0200")
Message-ID: <87o7632qff.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org> writes:

>> But honestly more and more I'm starting to think that we should just
>> reject all these "drive-by cleanups". We have better things to do than
>> fixing unnecessary their bugs. Thoughts?
>
> Hmm, yeah, maybe. I do kinda like the fact that people send patches to
> improve small things, though. We all started out as new to the kernel,
> and I appreciate the fact that people try to improve our "commons" in
> this way even if it's small things.

Yeah, you have a point. It's just that the extra work from cleanups
feels so unnecessary compared to the practical benefits. And most of the
time we don't hear from these people ever again, that's why I call them
"drive-by cleanup".

> I do try to be critical of things that can break stuff before ack'ing
> these fixes, but I'll admit that it seems like I don't have that great
> of a track record for judging "correct" in this context (cf this one,
> and that debugfs regression). So I guess you're right that I should at
> least raise the bar somewhat; will try to recalibrate and say no more :)

You are doing a great job :) Nobody can catch all bugs in review, I
would say there is a small percentage (5%?) of all cleanup patches that
cause issues. Though it would be cool to see some real statistics.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

