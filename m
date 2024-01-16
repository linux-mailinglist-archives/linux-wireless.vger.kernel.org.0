Return-Path: <linux-wireless+bounces-1978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A692482EF21
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 13:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6006B285CAF
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479A51BC26;
	Tue, 16 Jan 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE/VGly+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4ED1BC23
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 12:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E566DC433F1;
	Tue, 16 Jan 2024 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705408702;
	bh=S6/7lJVC6JILhB6Z5JfqKG7z1YHe5+sb8EPCR03iwBs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aE/VGly+K3q+TUPcQbNjHu8JrOeStWaF4fmKAnKbgeqDpTmd423cR7Vrjp/awL9cn
	 opI8mPB7NZ792DQSu1vdkx9lobIhLLDQKP3HEYnj76kO4zTbMmv0KfKJGCh/JocS4E
	 mO/cm7SFhLDAv+r94GfMyOXY/lsJ0TJ7o3Qu8qyPl+hxipzAON2xr9S8GdxoWsGqUL
	 qVHRfE2pJyETPDAro5zInLDfOyhJ8n2Qek//HsOZyhiqetgBZI55gh395snFept1bc
	 vTETg3R+K9lFv7teut9KiFUrk6fN+RupQm+spZ1Yw3Gu+trd7T8bUK5GMWPhkc4m7f
	 Xdl7xNFt3eZxw==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Introduce the container for
 mac80211 hw
References: <20240112024214.3481840-1-quic_periyasa@quicinc.com>
	<20240112024214.3481840-3-quic_periyasa@quicinc.com>
	<87bk9m7f5g.fsf@kernel.org>
	<839b56fa-9ce8-47f3-768d-b4f32a2041f1@quicinc.com>
Date: Tue, 16 Jan 2024 14:38:20 +0200
In-Reply-To: <839b56fa-9ce8-47f3-768d-b4f32a2041f1@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 16 Jan 2024 10:44:46 +0530")
Message-ID: <8734ux78sj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

>>>   static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
>>>   					 struct ieee80211_vif *vif)
>>>   {
>>> -	struct ath12k *ar = hw->priv;
>>> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>>> +	struct ath12k *ar;
>>> +
>>> +	mutex_lock(&ah->conf_mutex);
>>> +
>>> +	ar = ath12k_ah_to_ar(ah);
>>>     	mutex_lock(&ar->conf_mutex);
>>>   	ath12k_scan_abort(ar);
>>>   	mutex_unlock(&ar->conf_mutex);
>>>   +	mutex_unlock(&ah->conf_mutex);
>>> +
>>>   	cancel_delayed_work_sync(&ar->scan.timeout);
>>>   }
>>
>> Do we really need two mutexes? I don't see any analysis about that. And
>> even if we do, I feel that it should be added in a separate patch.
>
> Yes, ah->conf_mutex protect the concurrent mac80211 operation. But
> there is other places like radio/link specific synchronous operation
> (ie MGMT tx wait for the vdev deletion) is needed. To fulfill this
> need, we also need radio/link specific (ar) mutex instead of all link
> (ah) mutex for efficient lock/unlock.

Are there any numbers to show the inefficiency? Anyway, I consider
adding new mutexes as an optimisation which could be done in a separate
patch with proper analysis.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

