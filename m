Return-Path: <linux-wireless+bounces-14814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9B99B934D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764D5B22473
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F029F136347;
	Fri,  1 Nov 2024 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alNmWNl1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44C49620
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471628; cv=none; b=WlN5+xzcBM3x7ODhm5iWTSSJeZgOYF/aYwQgKSMUld3IfMkdnEHu8GhnJ3yS0IvYfqt4bUj3UE+hV9nNmKhDIwmEN+BR2aa1NzF070jtRbjy/+enBaFCtmD+5fc/grCQ0L5FcLXn7dVTIYKimAUdkikrgAEkVZjQECrCRDLjCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471628; c=relaxed/simple;
	bh=JCP681ULLq4G4635kQjFN2HzHMMxeCdi1hW8lQkAaL0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=c21xORSjJLbofk2UMhtkPVT0SKGzM5GHeF/G9cwHI5N/GYBM7DoPcZibeCWKDJtxdmXgKb1p7C1Qsz/kb1VDCSGU3GWfsOF7yxjjmLx/l9KHfL9XLami0pdBDNqqFPMZuQ8lUf0IVfQZHd15vFCLJs+iez6ly59FbZg0SU+mO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alNmWNl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC1BC4CECD;
	Fri,  1 Nov 2024 14:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730471628;
	bh=JCP681ULLq4G4635kQjFN2HzHMMxeCdi1hW8lQkAaL0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=alNmWNl1Xtvzqsh3LTD1G8DpMAYZRLTLcPkI1NRYiFmu1mYgLGn+FzqzNAgHtaV6A
	 XU1AlmhfCx21kk+rxIa4N/xi/iPkf/BvABk1db5mQCfUjqpmolKL5ZGw0/yV3wC6/C
	 ZBEyO3CRG/m9eatf9yhjLHG8X1DpzRiP3n73EXTUHBXquBd1OqtgrekYWnzaN3Q+fy
	 aw9HvSwyL+BndDS5iBxeXlCDNofxApcAvGYmmg+EokByXYXtKsVbxpuQF8LzYGTAGh
	 vHHvC7hhtDnci42c0YCUZ5qimeCIx+wBaVOcG/W2VW8TgEjqYsM68e9VPyeWSTcYsI
	 WyyAIYdoPDMjA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 7/8] wifi: ath12k: add helper to find multi-link station
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-8-kvalo@kernel.org>
	<05f2ef12-5176-4742-adb7-04da614995fc@quicinc.com>
Date: Fri, 01 Nov 2024 16:33:45 +0200
In-Reply-To: <05f2ef12-5176-4742-adb7-04da614995fc@quicinc.com> (Jeff
	Johnson's message of "Wed, 23 Oct 2024 09:01:01 -0700")
Message-ID: <877c9n6n1y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>> --- a/drivers/net/wireless/ath/ath12k/peer.c
>> +++ b/drivers/net/wireless/ath/ath12k/peer.c
>> @@ -80,6 +80,20 @@ struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
>>  	return NULL;
>>  }
>>  
>> +static struct ath12k_peer *ath12k_peer_find_by_ml_id(struct ath12k_base *ab,
>> +						     int ml_peer_id)
>> +{
>> +	struct ath12k_peer *peer;
>> +
>> +	lockdep_assert_held(&ab->base_lock);
>> +
>> +	list_for_each_entry(peer, &ab->peers, list)
>> +		if (ml_peer_id == peer->ml_peer_id)
>> +			return peer;
>> +
>> +	return NULL;
>> +}
>> +
>>  struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
>>  					   int peer_id)
>>  {
>> @@ -87,6 +101,9 @@ struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
>>  
>>  	lockdep_assert_held(&ab->base_lock);
>>  
>> +	if (peer_id & ATH12K_ML_PEER_ID_VALID)

[...]

> does other code elsewhere need to mask this bit off to have the "true" peer_id?

Based on my investigation the peer id is stored with
ATH12K_ML_PEER_ID_VALID so it should not be masked (unless I'm missing
something). This is not pretty but I guess keeps the code simpler.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

