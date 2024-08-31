Return-Path: <linux-wireless+bounces-12287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9FB967085
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2024 11:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A77E281FA1
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2024 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3A16C854;
	Sat, 31 Aug 2024 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urJ325Y+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6416BE0D
	for <linux-wireless@vger.kernel.org>; Sat, 31 Aug 2024 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097173; cv=none; b=bMxfgPKGoRo+GX4mSbKMwFTQVqJlEjNw0NGJ7hMJhJ/FNLfg7s7QXwJzmUExK6iCUxPJWmDww3TjI/vPQFF/wUgjsbIGctaRnmU3smjiHpx1d1tDwQ5ZVb/77W6SuecugMns4/gXQPZEUPAU1WQ1IPYBkLHPoB0HpMyoweDdnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097173; c=relaxed/simple;
	bh=FI0gKYkPJkO4tP+tq0gaRf1Z+KPL1EhGoel9Ykvu2rg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mrN07sLkEBjo/djP+vXPpJw8tGQLFs/vnhqjbBmNBbG54lSd048QNoho0/DegLWPxz4qyL/62gi1o778lYEmszoNzAm/+UZuoOmy60fRl0rg56zSZNhZ4Co+iydLWHM8oMKhAvo7swOTEl2tJ520S7gESdQgdGgvpv4s0J623Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urJ325Y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F268C4CEC0;
	Sat, 31 Aug 2024 09:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725097173;
	bh=FI0gKYkPJkO4tP+tq0gaRf1Z+KPL1EhGoel9Ykvu2rg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=urJ325Y+X0yGXqiQiUH2N9pseEd6YrTRPGdR97q1RQ6nF5vMOimWXxC7fgkdJrlDm
	 B+PdHYkJUnWVEffEift0owri2DL5kJEHfGhCEJLjiWyad540O05mKBGXTLQFVQpdzi
	 lSTeg97BmVWuMremharL97XA+C/Mk44qnM1Po1ZOjeiLX5DABrIebpHsZeMR2YHOyG
	 4lJHAjndFS/Mu9WYOnGURM8vHYimb3NIxbro0QnJu3JqgNZIaCoJ8iQuNvn7piKD3/
	 vVvr7dDvy7/S7U8XQuBwB0KWiv3hWpXLY23uwevMM/5L4HjMAqPI/aCvixV4roY/bs
	 feTExTaDTJhkw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-current 2/2] Revert "wifi: ath11k: support hibernation"
References: <20240830073420.5790-1-quic_bqiang@quicinc.com>
	<20240830073420.5790-3-quic_bqiang@quicinc.com>
	<891d2bc3-9ace-4fed-92e3-192d8126c5c6@quicinc.com>
	<1e5c40f7-d8f4-4e62-af2d-216d6e02dd5b@quicinc.com>
Date: Sat, 31 Aug 2024 12:39:29 +0300
In-Reply-To: <1e5c40f7-d8f4-4e62-af2d-216d6e02dd5b@quicinc.com> (Jeff
	Johnson's message of "Fri, 30 Aug 2024 08:56:37 -0700")
Message-ID: <87plppkp4e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/30/2024 8:46 AM, Jeff Johnson wrote:
>> I think we need to add
>> Fixes: 166a490f59ac ("wifi: ath11k: support hibernation")
>> Cc: stable@vger.kernel.org # 6.10.x: <hash>: Revert "wifi: ath11k: restore
>> country code during resume"
>
> Re-reading https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
>
> I see that I messed up the Cc tag(s)
> I think there should be two Cc's
>
> Cc: <stable@vger.kernel.org> # 6.10.x: <hash>: Revert "wifi: ath11k: restore country code during resume"
> Cc: <stable@vger.kernel.org> # 6.10.x

Adding that hash is tricky as then I need to first apply patch 1, edit
patch 2 and then apply patch 2. I did also consider adding cc stable to
the first to keep things simple. But let's try adding the hash anyway as
I have never done that.

I didn't add the first the cc stable tag yet, I'll do it after I have
applied patch 1. This is what's currently in pending:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=d8535e2ae09212fbdd9330870814b62a231f8745

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

