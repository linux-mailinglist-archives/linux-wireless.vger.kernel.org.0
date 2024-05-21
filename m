Return-Path: <linux-wireless+bounces-7864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B718CA78F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 07:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC4CBB2232F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 05:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC09F43AB0;
	Tue, 21 May 2024 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzZjeT0q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049B433DF;
	Tue, 21 May 2024 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716268328; cv=none; b=mylmSt0jlH0hsjrlT3NdWbfJ8RoF68u831qTYp3wC0y2/n2KAUjQIrQxYbCHgatVSJi3Y4hweDS89nv1azvY7Dda/6kXphgdjpGXqCWCNJdRZ7dW5G6dyK+Dwfy7pj2BvhGar0a+w9vVxFZFiuczWp7+2NDca3AYGyLLVi5JqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716268328; c=relaxed/simple;
	bh=Q2qSgSFB8UjUWqO4soRX61IynMlBYuFv6ez7nS2cXUw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=irSiuzehwD6KuPO7x8/4Crs5q2a1fPyQhinXQOtQTtjbFIJ5NBxYsiuYLRNco7GMWUrkKUXUahvj/mtgQD4o+JuSqJ/+rxM8i+NtkiXKi4+EdKwla+x+btqux9+3HdPQ3W/1+S+CegrOnE/duiX4Jl4NPnUMe3IpK0vUAyUokuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzZjeT0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBF2C2BD11;
	Tue, 21 May 2024 05:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716268328;
	bh=Q2qSgSFB8UjUWqO4soRX61IynMlBYuFv6ez7nS2cXUw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=IzZjeT0qfaxJDdzUz5sSmQwN5xPZ91I5zjgDLcvYICifOQ+Aju783jPmAR0k4SZ1x
	 5dQuYG3nwCpVVEFF6QpNlKEszDGjnG7Dm62e7R5ymJJE5UU5TCtOP7ZwWlH07LgOfc
	 4WwBZR3G2jg3m0qM8EnN5umrigbN8ysDEKAh7IdRvqyQ1Ljpp27VxabUuyHc5+UGYw
	 KSVRRRQJTKdingDYhc3SekvVHDdSux7uB/cvlrc758Uq6cj+GMhJXytok6gNCLqQGS
	 UApivuFPPdX8dAjOPBONp6wko7LLCArfcKvMODpMETPIbfidi8eDPSf2CWC8RLWFxE
	 Z04AokbZ32/fQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] wifi: ath11k: move power type check to ASSOC stage
 when connecting to 6 GHz AP
References: <20240424064019.4847-1-quic_bqiang@quicinc.com>
	<87wmo0k71i.fsf@kernel.org>
	<3dc28f34-45cc-4e14-b9ea-1f7b78a6a591@quicinc.com>
	<87h6esebu8.fsf@kernel.org>
	<b6b23a29-78ef-4e4f-8042-e13833fcb1ec@quicinc.com>
Date: Tue, 21 May 2024 08:12:05 +0300
In-Reply-To: <b6b23a29-78ef-4e4f-8042-e13833fcb1ec@quicinc.com> (Baochen
	Qiang's message of "Tue, 21 May 2024 09:52:06 +0800")
Message-ID: <878r03eoka.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 5/20/2024 11:34 PM, Kalle Valo wrote:
>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>> On 5/11/2024 5:54 PM, Kalle Valo wrote:
>>>
>>>> Oh, this fell through the cracks. Commit bc8a0fac8677 was introduced in
>>>> v6.9-rc1 so I should have sent this to v6.9 but it's too late now. I'll
>>>> need to queue this for v6.10 via wireless tree.
>>>>
>>>> Adding the regression also to regzbot:
>>>>
>>>> #regzbot introduced: bc8a0fac8677
>>>> #regzbot title: ath11k: connection to 6 GHz AP fails
>>>>
>>> Hi Kalle, with an upcoming patch this regression is expected to be fixed:
>>>
>>> https://lore.kernel.org/all/20240506214536.310434f55f76.I6aca291ee06265e3f63e0f9024ba19a850b53a33@changeid/#t
>>>
>>> So here the ath11k fix would not be needed any more once above patch got merged.
>> 
>> What happens if we apply both patch 'wifi: ath11k: move power type check
>> to ASSOC stage when connecting to 6 GHz AP' and patchset 'wifi:
>> mac80211: build TPE handling'? In other words, do they conflict from
>> functionality point of view?
>
> No functional conflict, 6 GHz AP connection would also succeed with
> both of them applied.

Ok, thanks. In that case I would like take patch 'wifi: ath11k: move
power type check to ASSOC stage when connecting to 6 GHz AP' to
ath-current branch from which it will go to v6.10. Is that ok for
everyone?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

