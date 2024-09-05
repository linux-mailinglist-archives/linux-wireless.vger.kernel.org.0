Return-Path: <linux-wireless+bounces-12539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAA496E03A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971F41F26194
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF01A0AFA;
	Thu,  5 Sep 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4EqXz8J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A651A0AF7
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555149; cv=none; b=s5R5/7HW3UJP7O/3315uqND5rzV58NJ7/Bm3uMn2fIJrRAgdAo30W1E+c+u51ep6iR/qUJWUWgUzbcD+GJe1ajH9cuhRX9ftaL7ZjofW2hsXJZJyNYM7dXR6jtflwOVz2a4KJT004GxwJUAcpAJlb7a7DOtCO6LpsI00yioyJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555149; c=relaxed/simple;
	bh=f5RnDW+SslH2BteySC4zr7oSDiqA/6lUXefA0ljak7U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GnCkahDT96sqW+2H6EQODa9ICySKm9E3VJnZw60voKbuI+CI51S258ZxXMEHxK1yFWsDYV/qC6R3g+Dme6lstgrmykUa/yMCGTZs2wm0DC8HUOIGD4P5WAMzM9P2g63cL2kEcqmR2xaT2+5kHjDRpnQyGqd1L/tlA/PendUD+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4EqXz8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C811C4CEC3;
	Thu,  5 Sep 2024 16:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725555149;
	bh=f5RnDW+SslH2BteySC4zr7oSDiqA/6lUXefA0ljak7U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Q4EqXz8JYwhmWW3wGAXf0yqaruDlzladCVzw3VNU4NoyQFqATZhd49P7Ajh6wKS7U
	 WiAUQAyj13vxMpBZtiWEiHgrAery6+2hwBJs4LoaPtkAVDFXmFvR9rV0qukd3VUL3x
	 1VhG2EhohM47nrxJVwwiRB5hYLRqqgN5XHUmzhk6CQGt7Eh6081zCB3lGr6QuHVcFr
	 TvMZr3gxlvxNMO5has9KG4jBk+zoNeMK8RbK8sqlMKE6ZyNtElNtOgeBLI5FMpolM4
	 9Rf9tsdanGGtz1j96dd2nK5rr27rkpyDnXtTKY5beUmIiETzelLXMuZYHK75rPCPsA
	 vetfFbnqaMRsQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH RFC 1/4] wifi: ath12k: switch to using wiphy_lock() and
 remove ar->conf_mutex
References: <20240821153728.2121600-1-kvalo@kernel.org>
	<20240821153728.2121600-2-kvalo@kernel.org>
	<a1a4202f-5c10-401a-9b02-47dacb9be048@quicinc.com>
Date: Thu, 05 Sep 2024 19:52:26 +0300
In-Reply-To: <a1a4202f-5c10-401a-9b02-47dacb9be048@quicinc.com> (Baochen
	Qiang's message of "Thu, 22 Aug 2024 13:46:37 +0800")
Message-ID: <87le06hwl1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 8/21/2024 11:37 PM, Kalle Valo wrote:
>> @@ -845,7 +845,9 @@ int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
>>  	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
>>  	int ret;
>>  
>> -	mutex_lock(&ar->conf_mutex);
>> +	lockdep_assert_wiphy(hw->wiphy);
>> +
>> +	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
>
> we don't need this lock because it is already held by mac80211.
>
>>  	ret =  ath12k_wow_cleanup(ar);
>>  	if (ret) {
>> @@ -913,7 +915,7 @@ int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
>>  	ath12k_wow_cleanup(ar);
>>  
>>  exit:
>> -	mutex_unlock(&ar->conf_mutex);
>> +	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
>
> same here.

Ouch, that's bad. Will fix in v2, thanks!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

