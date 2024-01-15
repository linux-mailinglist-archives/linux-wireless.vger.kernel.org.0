Return-Path: <linux-wireless+bounces-1939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B9082DCE2
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 17:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E3A2827AD
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85591798C;
	Mon, 15 Jan 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1ROy/tS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20C17981
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 16:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A8EC433F1;
	Mon, 15 Jan 2024 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705334756;
	bh=Cr2vcSI2SOfdEjNv+aRzgSma/lm3Z+oZzZokPDQfWSc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=W1ROy/tSwtnAS7w42HTToTcmqU3CNtY4c3G+NqU60SoEN9BxlD7gahVqMvYn8/hRR
	 rZTs5EgulY5YuDjT7kQ0pLcS9znYsOY882BQT+51ox9uj7fEjKa2VHC5MMZ7Y4mBg8
	 sOBkGyNL4fYn1oSFm9d6mVqkOypnX8CowrwKYjbnD9ey7wYd5+KIXXroPgH3Bfyh53
	 5yvbDlKhc9ufDnuYMp25UqJnwtvxS/UnQLDmzSZ2NJVsm3pElKM1Yk56lG05YDcFv0
	 osgLlM64pkCbpvJSH8gNCWHjFsmyc/VEckuNAOl9jsvvFU0KZGTEGGz5QEvkKPmu3r
	 nxgkmX+CziX2g==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: ath12k: Introduce the container for mac80211 hw
References: <20240109051252.3325106-1-quic_periyasa@quicinc.com>
	<20240109051252.3325106-3-quic_periyasa@quicinc.com>
	<87mst67ge4.fsf@kernel.org>
Date: Mon, 15 Jan 2024 18:05:53 +0200
In-Reply-To: <87mst67ge4.fsf@kernel.org> (Kalle Valo's message of "Mon, 15 Jan
	2024 17:41:55 +0200")
Message-ID: <87il3u7fa6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>
>> To support multi link operation, we need to combine all the link/pdev
>> under a single wiphy. This avoids the overhead of synchronization
>> across multiple hardware instances in both the cfg80211 and mac80211
>> layers. Currently, each link/pdev is registered as separate wiphy,
>> tightly coupled with link/pdev/radio (ar) structure. To enable single
>> wiphy registration within the chip, we decouple the wiphy data entity from
>> the link/pdev/radio (ar) structure and move it under the chip (ab)
>> structure with a new data container (ath12k_hw) structure. This approach
>> improves scalability for future multi link operation support.
>>
>> 		mac80211 hw private data structure diagram
>> 		------------------------------------------
>>
>> 	Now						After
>>
>>  +---------------------+                          +---------------------+
>>  |mac80211 hw priv data|                          |mac80211 hw priv data|
>>  |                     |                          |                     |
>>  |                     |                          |                     |
>>  |                     |                          |                     |
>>  |                     |                          |   ath12k_hw (ah)    |
>>  |                     |                          |                     |
>>  |                     |  +------------------->   |                     |
>>  |    ath12k (ar)      |                          |   +-------------+   |
>>  |                     |                          |   |             |   |
>>  |                     |                          |   | ath12k (ar) |   |
>>  |                     |                          |   |             |   |
>>  |                     |                          |   |             |   |
>>  |                     |                          |   +-------------+   |
>>  |                     |                          |                     |
>>  |                     |                          |                     |
>>  +---------------------+                          +---------------------+
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>
> [...]
>
>> @@ -3790,6 +3831,10 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
>>  	     new_state == IEEE80211_STA_NOTEXIST))
>>  		cancel_work_sync(&arsta->update_wk);
>>  
>> +	mutex_lock(&ah->conf_mutex);
>> +
>> +	ar = ath12k_ah_to_ar(ah);
>> +
>>  	mutex_lock(&ar->conf_mutex);
>
> Do we really need two mutexes? I don't see any analysis about that. And
> even if we do, I feel that it should be added in a separate patch.

Sorry, wrong version. I'll comment on v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

