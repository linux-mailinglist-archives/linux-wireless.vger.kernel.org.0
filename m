Return-Path: <linux-wireless+bounces-7762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F129F8C8098
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 07:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263EE1C20B06
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 05:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003610A12;
	Fri, 17 May 2024 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXP8l53j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D910A0B;
	Fri, 17 May 2024 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715923507; cv=none; b=Jc4OWxhN4L2VP5BXHxk1xiStQsVXJybyXSBJJxUpkuAnt+FqnYfe0QQyzJD5NOCwRVVgEaBSaQ0q+MlB0WnKdtQ/+6s58Z+U69l1KEKLRMCpwwHqe61iyt5KdpdCZ7GflrjcyRORhCR5QG1rWdTTqxvQ9pw2EmtfvVFCnjVN1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715923507; c=relaxed/simple;
	bh=JsSl2F7J/c445ieKgv25hBESUFKNpCr7HFqx+pdPKWI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oLort9fM8wrP1bR7Iu3+TTI1QEmfaz9fVtKrghkShafZCN2owlGGuZhkuSQ172Att1O7bAweONRkcdlrVfm22V51NBmJnqoT/b1AVM4q0ucaVwJlS6UBbpaqnkMbTx8FrK90ljXC2wY4K2NfTjrzsJL8IwwOjIhC400K1920WWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXP8l53j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE5DC32781;
	Fri, 17 May 2024 05:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715923506;
	bh=JsSl2F7J/c445ieKgv25hBESUFKNpCr7HFqx+pdPKWI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PXP8l53jSj/nOjJPOhRj152DaY6Ap4MFn4SnQubV5Gj8fmZfN44npd+UAEyMUnykr
	 NN6mDimXQOlJkvcJLA2oE8Pe62n5gPcXnba4X9HzSSKTT0IEj39xd51uQDldooM92N
	 DRWabe5IybEXYu6plWGaQ1RNSyGVxIqTtPoK7sahIe6DKH7sQWjrBNelkPIC3drHge
	 dWBN9JyDpIK1UP+5e+mguh22bKfmfbq/7ATs1XKZRnfR7WKM33kKxKjuTXlD68HD8Z
	 wuYAEDCQZA2EksuyOqMbQVsA5XKOaJeKgzAV7GMtaoAG6HQwN1CX4XS4sO+0PrMWlj
	 T6uWEhgXSlguw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,  Carl
 Huang <quic_cjhuang@quicinc.com>,  Luca Weiss <luca.weiss@fairphone.com>,
  <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
	<20230714023801.2621802-2-quic_cjhuang@quicinc.com>
	<D15TIIDIIESY.D1EKKJLZINMA@fairphone.com> <87jzk2km0g.fsf@kernel.org>
	<93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com>
	<871q69lqh5.fsf@kernel.org>
	<4e21e556-527f-4d1e-aa29-cacec14155af@quicinc.com>
	<a53e2188-b982-44b7-9dfe-f5dfd6b802ca@leemhuis.info>
	<4d72f74a-b2eb-43d3-92a2-1311081ce72c@quicinc.com>
Date: Fri, 17 May 2024 08:25:03 +0300
In-Reply-To: <4d72f74a-b2eb-43d3-92a2-1311081ce72c@quicinc.com> (Jeff
	Johnson's message of "Thu, 16 May 2024 07:11:31 -0700")
Message-ID: <87fruhggcw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 5/16/2024 4:45 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 11.05.24 05:12, Carl Huang wrote:
>>> I'll send out the formal patch next week.
>> 
>> Hmmm, from here it looks like this did not happen. Did I miss something,
>> is there some reason to reevaluate things again, or did this maybe
>> simply fall through the cracks?
>
> Formal patch is still under internal review

BTW I'm also experimenting with regzbot to help me track regressions in
wireless and to avoid missing important fixes.

Thorsten, I don't know if you take wishes but it would be nice to have
in regzbot some kind of filtering per subsystem or label. Maybe
something like this:

https://linux-regtracking.leemhuis.info/regzbot/mainline/?subsystem=wireless

And then a have command for regzbot setting the subsystem (or a label).
That way I could easily see only the wireless related regressions, now
it's harder to find them from the list.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

