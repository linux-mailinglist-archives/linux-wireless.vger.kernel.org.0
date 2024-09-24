Return-Path: <linux-wireless+bounces-13103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E802698413B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 10:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654DEB22663
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D414F124;
	Tue, 24 Sep 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhNqczD+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6014F9F7
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168233; cv=none; b=Ni/rT0Fp9/vfNpw0wzB906gkGzWFcgQBkZ+zezkRMYBHfbAmdJ4VMpIXQjoJaQye0MHwc2+0TGSxXt9Wrykhbwl9o/jrblGv0YpCjvDV8IaHuW3YHz7ynoqD+l6hDu0uxw99eKcmzLYkRW4DRzYp2nKZyWvx2B+AYdEg6mUBhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168233; c=relaxed/simple;
	bh=p85naDZaBA/vtn1u3T0+3QYlfIyugrxWm9rBRDCctRg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=c5xZ7Wcg+mFKbTJ0wBbpkfE4lQHrZroIEInKYCP3wfwk5UVyPkn9gssC2Vby9GCvky/IpiHAliO1mcBSMWNdXrb1DKGkhWQKRpNFdRkM8/RJgAsnr9TxB0PHvXb10/obzIiKzTAx9Dmt8YzWEsyTVRVPB2gt6HfnyqCmr49Mg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhNqczD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2FDC4CEC4;
	Tue, 24 Sep 2024 08:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727168232;
	bh=p85naDZaBA/vtn1u3T0+3QYlfIyugrxWm9rBRDCctRg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VhNqczD+3jXflp9zeens/XQOVn2HnvZso1NOy82kNoomERWLjdaQ+ndvyUIDdPtEb
	 rin7BVbRfiOz4tHpdRsbs0diO8duRqk0d4gGf4YC0r3LhnuzhcWVPPMJW4MpZEMja3
	 NrutGj38GxuuloccU0dqRNIJu9P8AbYBl4Lu7aIHm2GZacFwixfBifGR9IbaSYiYq9
	 j5CCBznG+c4SkVF+klBAz6SKc+3uSMR0BdHQCk1SrC/fn5V5S/Tj3tTD8ibk5wjq1i
	 9W7bDYCMiZR83nxs9/xk5saIy/rXVm5XSmiv1o1KTus6L1dss001IAlXdxbleilQZU
	 ddK9LsC/fywYg==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH RFC v2 1/4] wifi: ath12k: switch to using wiphy_lock()
 and remove ar->conf_mutex
References: <20240918181042.91891-1-kvalo@kernel.org>
	<20240918181042.91891-2-kvalo@kernel.org>
	<33963bc8-7cc9-434a-8910-cbcfc6fa965e@quicinc.com>
Date: Tue, 24 Sep 2024 11:57:09 +0300
In-Reply-To: <33963bc8-7cc9-434a-8910-cbcfc6fa965e@quicinc.com> (Baochen
	Qiang's message of "Thu, 19 Sep 2024 10:43:56 +0800")
Message-ID: <87setpa0pm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 9/19/2024 2:10 AM, Kalle Valo wrote:
>> @@ -4310,7 +4301,7 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
>>  
>>  	spin_unlock_bh(&ar->data_lock);
>>  
>> -	mutex_lock(&ar->conf_mutex);
>> +	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
>
> note in patch 4/4 ath12k_sta::update_wk is converted to use
> wiphy_work. While a wiphy work item is running wiphy lock is held
> already. So here try to acquire wiphy lock once again will lead to a
> deadlock.

Ouch again, thanks for catching this! This time I actually tested
changing bitrates and it shouldn't deadlock in v3. But I did notice
sleeping while atomic warnings (even without this patchset) and decided
to fix those in the same patchset as well.

Oh, and WCN6855 firmware was also crashing whenever I tried to change
the bitrates. But let's handle that separately.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

