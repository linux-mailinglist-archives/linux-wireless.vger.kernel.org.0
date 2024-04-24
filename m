Return-Path: <linux-wireless+bounces-6751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B28B00A2
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 06:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F2C1F25A7A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 04:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2D2152DE1;
	Wed, 24 Apr 2024 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df5hrn0g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C8985C59
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933555; cv=none; b=KdIz3Wawo0Rs7ZKSVhWd/FHGvS6YY+zoJCPi9ZqIRvwQZVaXGDyTrFau5JIdYz25JRTc3JXMVIYXO4qWQpdDOMAuHH3s1WHs1aQL4ALTJdAUyHqsfUsgEqg42D+A00J6VX7kAGM0DhotH00Im0vELGHflP7EdXNZeP1mSoVeD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933555; c=relaxed/simple;
	bh=3pgvSwtH0NW0tIEHpJ4id1LBP+PB/0JJc7zJuFsEEX0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aAQC1hC6g6VcpcDEH0N9mJMkPyKlzuVqhmD7d6rfxddeWOypAyUAD/WfvZFk9X+XsbfXnj72WNG+kmbTiBZpJGIFIGCYX5JQpxDZUE2pWEWhrn2ucYD7Jyded+U053lJHTEezcKETHzWVtV6ElWTrVngEKwEFDMnOJYvFxZJXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df5hrn0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF0AC113CE;
	Wed, 24 Apr 2024 04:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713933555;
	bh=3pgvSwtH0NW0tIEHpJ4id1LBP+PB/0JJc7zJuFsEEX0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Df5hrn0gIckq/xj+8dzLaC9fZXQ8bi8QXm+6KOXZL7DcYGn1HwdqystMEz0ceVdx/
	 LAim7BPedUoENeZKjXoYNeqgE+Mx+b4/G2Q3r/6wzBD7mNeje63jw+u8KW0Bm8tj/R
	 h0gvL6dhTbFXbtUaIyFsJiq92mvZe7eGF5NrT2fxxR3DcHcE16ZpJsMt4VDspuFbDz
	 TULZiRoAw4hh3Wx/wMYgw5tWnS+G6ZtPVbNrIyKDiKihsB5dHQOQUGAbYxggce16J0
	 OCcRStcrciLxIQ7MBO8iAYIQIr5o/pEPpUnXSaCmQHphg9/77Um1P5aQ2cWmTc5SeT
	 KTGQuHYIGKyXw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Harshitha Prem <quic_hprem@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/8] wifi: ath12k: Introduce device group abstraction
References: <20240420083750.1545670-1-quic_hprem@quicinc.com>
	<878r14v2o4.fsf@kernel.org>
	<57002bbf-2c85-4fa7-b249-4bd3f2ba1bcf@quicinc.com>
Date: Wed, 24 Apr 2024 07:39:11 +0300
In-Reply-To: <57002bbf-2c85-4fa7-b249-4bd3f2ba1bcf@quicinc.com> (Jeff
	Johnson's message of "Tue, 23 Apr 2024 14:24:12 -0700")
Message-ID: <8734rbidcg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>>> Depends-on:
>>>         [PATCH 0/3] wifi: ath12k: Refactor the hardware recovery
>>> procedures
>> 
>> Are you referring to this patchset:
>> 
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=821155&state=*&order=date
>> 
>> That was sent three months ago and at least I couldn't find a newer
>> version. So I'll just drop this patchset for now without even looking at
>> it.
>> 
>
> Yes, I'm stumped as well. the patch specifies:
>>base-commit: c416602943dd36fbd13af7496430723935c867a3
>>prerequisite-patch-id: a4d62344b11368fb7e549c03b6a31f7ba4c9e2bb
>>prerequisite-patch-id: b4a1e18a85d8c1e337fa133c2bd2956c33b11046
>>prerequisite-patch-id: b16edd310baa35e2500267e338f60c9a2e6594e1
>
> but lore is unable to find those prerequisite patch-ids, which leads me to
> believe that they were rebased internally but never posted.
>
> I tried to apply the January series on top of the base-commit:
> c416602943dd36fbd13af7496430723935c867a3 but it doesn't apply cleanly.
>
> So I think we need to have a rebased and updated "Refactor the hardware
> recovery procedures" first.

Yeah, it's waste of everyone's time to submit patches like this which
don't even apply at all due to missing dependencies. Please don't do
that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

