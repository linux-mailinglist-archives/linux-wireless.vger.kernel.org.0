Return-Path: <linux-wireless+bounces-13113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9339E9842EA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 12:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5053F282417
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADC3156871;
	Tue, 24 Sep 2024 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMzyiYxP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6715624C
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172225; cv=none; b=cT9KjiQqk9Ww49HG+rxiUTPcOT02mDRvRHUsXPUC5wX/hXgdKQCY7KQUkBjEXVY67SSO9ERiw251/uDii+YaqZp6YSwCfj22qRO5bAJZe/aHlFLelQ1PkIzSxBo37wkCmv3rdMUqhmWdG4hqULTbTlEz/qIhUproNtHhjiNrWUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172225; c=relaxed/simple;
	bh=ShGbu8Qt1hiH26jaSyQZaGCXLqy48t6HW8OjvCJTT7o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=s1+lnCmXSxbfK6gsiqvE8hP9Pba9GETu8Dewh8IBQNbR2dMCFqnBpexz6sHXn7wvy3M23AH7yysvR9CQxjYjf455WU8Mf4LYVhp2zgem69ldJmYQ+gu/Swj0Op0r+3oZ4T1fXrLIuD3elj7EYAmx0jkdI3tZvTpq2AZocBwzFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMzyiYxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC614C4CEC4;
	Tue, 24 Sep 2024 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727172224;
	bh=ShGbu8Qt1hiH26jaSyQZaGCXLqy48t6HW8OjvCJTT7o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KMzyiYxPKj5nflUq3KlEl9JUV3HUAL+zMLNWfxuqLyqWzZyVT4beqrvWeApy80on+
	 9af49WN2urTaa/JluZj9gdWm7Ny/6xiCFzbZSHuAjoAOysWD7y3sRImjW1vn+U+E/p
	 iVmTuuxkWhuJwv5vJPOFuYhEsMqcsXJKXGeiQ0kf+eZd3d4Zp7+vx1ya3JTty+0zUv
	 biEJDKRj2wHpkXFRHFiLTm87ScomcByNAhGGtAy5SqKSZE16/z6mF61Au14djm6jla
	 7jA1njC9Fr5n8sncBNL/6jACqyAcqSd8j3DTcCpGo9oHIZUhRiafFZZ2u/F0bsKxnc
	 CVhUon4dNZ6yQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH RFC v2 1/4] wifi: ath12k: switch to using wiphy_lock()
 and remove ar->conf_mutex
References: <20240918181042.91891-1-kvalo@kernel.org>
	<20240918181042.91891-2-kvalo@kernel.org>
	<33963bc8-7cc9-434a-8910-cbcfc6fa965e@quicinc.com>
	<87setpa0pm.fsf@kernel.org>
Date: Tue, 24 Sep 2024 13:03:41 +0300
In-Reply-To: <87setpa0pm.fsf@kernel.org> (Kalle Valo's message of "Tue, 24 Sep
	2024 11:57:09 +0300")
Message-ID: <87frpp9xmq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>
>> On 9/19/2024 2:10 AM, Kalle Valo wrote:
>>> @@ -4310,7 +4301,7 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
>>>  
>>>  	spin_unlock_bh(&ar->data_lock);
>>>  
>>> -	mutex_lock(&ar->conf_mutex);
>>> +	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
>>
>> note in patch 4/4 ath12k_sta::update_wk is converted to use
>> wiphy_work. While a wiphy work item is running wiphy lock is held
>> already. So here try to acquire wiphy lock once again will lead to a
>> deadlock.
>
> Ouch again, thanks for catching this! This time I actually tested
> changing bitrates and it shouldn't deadlock in v3. But I did notice
> sleeping while atomic warnings (even without this patchset) and decided
> to fix those in the same patchset as well.
>
> Oh, and WCN6855 firmware was also crashing whenever I tried to change
> the bitrates. But let's handle that separately.

Bah, I of course mean WCN7850. Too many chipsets...

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

