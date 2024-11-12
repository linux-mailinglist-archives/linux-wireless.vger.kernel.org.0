Return-Path: <linux-wireless+bounces-15212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C7E9C5DEF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 17:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67BB282A86
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2793F2141A5;
	Tue, 12 Nov 2024 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVeRfKE9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330E2141A4
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430554; cv=none; b=TGh9emgaxW7KL3fZZ4Xt8H4IuCUanGvlly0jJyOwPXy6bn1knhXQ+hw/rAeER0tlchgMbZ5ARaA6Jh2ZDStdVplGO/p4HTtevdWCXCepjfEafmvkgXBeYJLUZUBHqVXzth5F2s0QVkXp4Nl8Qh1IuREFqbHPr7xIe5zXcl2YQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430554; c=relaxed/simple;
	bh=Q98Q34J4kAW3zme2ihDg8My/MPc2+GNVAfgPsUeYKJ4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GIuL8BxzD+QnyHuVU9QBT4sadjqX4XNtrcle9OsUv/hTsBRdhctpag+oJZya07+fvOOg+mbVj5YIxaqCiRTh3SzyL3LB+y1m2F3Ju4gRnMbO9C5PvCwzKwM8RFIgxYCwLKF8KB5fHv2zLYCrslnmiYGq5FcgUYW+PWLXckldNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVeRfKE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60FEC4CECD;
	Tue, 12 Nov 2024 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731430553;
	bh=Q98Q34J4kAW3zme2ihDg8My/MPc2+GNVAfgPsUeYKJ4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GVeRfKE9zix5Sioqj8apw1vphSAgIqq0885DPOnDQ34AtyeHaRQHrvo6nMUC3T14W
	 2EuVCvH/htopgn2J8ukRuL3P5iJYw6LjvScuMGjTl8XFTFVeoK+WeJAEHa5PykKMzP
	 VrcZsZiuf+fNPQV26p4MGscdOk+IMNePyuJdr1TkbK8GqaxVrYLkR0Oada6H7MPvx5
	 LCD1XSSkHD+u8XkIXEa7Y+KdJeVR+FoUnxXnX2dOzR/5phv4XJodTgyE55JGsig6sk
	 +YfZaDJPn+9xTFYlC87Hu5wnLwnxECH6CJXHPzzM3TqhJH2NcyoZ9/+6cQpbxexsv/
	 9dKR9vwTVIg0g==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/8] wifi: ath12k: support change_sta_links() mac80211 op
References: <20241106142617.660901-1-kvalo@kernel.org>
	<20241106142617.660901-3-kvalo@kernel.org>
	<e028f65c-9faa-46e0-ae34-35815a121ba9@quicinc.com>
Date: Tue, 12 Nov 2024 18:55:51 +0200
In-Reply-To: <e028f65c-9faa-46e0-ae34-35815a121ba9@quicinc.com> (Baochen
	Qiang's message of "Thu, 7 Nov 2024 15:14:55 +0800")
Message-ID: <8734jw4ciw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 11/6/2024 10:26 PM, Kalle Valo wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>> 
>> Add ath12k_mac_op_change_sta_links() for adding and removing
>> link station.
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> 
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/mac.c | 97 ++++++++++++++++++++++++++-
>>  1 file changed, 96 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 0ff886e4b3ed..c0cc4e51a4d1 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -5572,6 +5572,101 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
>>  	rcu_read_unlock();
>>  }
>>  
>> +static struct ath12k_link_sta *
>> +ath12k_mac_alloc_assign_link_sta(struct ath12k_hw *ah,
>> +				 struct ath12k_sta *ahsta,
>> +				 struct ath12k_vif *ahvif, u8 link_id)
>> +{
>> +	struct ath12k_link_sta *arsta;
>> +	int ret;
>> +
>> +	lockdep_assert_wiphy(ah->hw->wiphy);
>> +
>> +	if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
>> +		return NULL;
>> +
>> +	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
>> +	if (arsta)
>> +		return NULL;
>> +
>> +	arsta = kzalloc(sizeof(*arsta), GFP_KERNEL);
>
> kmalloc() is preferred as ath12k_mac_assign_link_sta() will do 'zero'?

That's true. Jeff, are you able to change this in the pending branch?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

