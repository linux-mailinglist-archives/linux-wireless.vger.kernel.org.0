Return-Path: <linux-wireless+bounces-15214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DAC9C5E91
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 18:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA46280FC6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B94204953;
	Tue, 12 Nov 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II3dfFNf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149CB20DD7D
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431499; cv=none; b=mw/MsB1+jzxgXyiQnEsxfXTrUX+PrhJ917ajQke1uPvB+r/D1KUnFLqkPRq9dIMkO4LqXLp+je0lfeBRzhoJngYvDxa2H6dgdvoE2a7ZtKRKuZXpcwlkdBiyARyrNpt+5S9wElLNB4q0OPrOVwnJekHDgXdDuz/vv+f+5BXYFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431499; c=relaxed/simple;
	bh=ga3dKBc62Z4mi0etr/9wyQGY2vEKZ6lsaiEZ72u5JI8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bkwUq7wMZraZNfdIqyu36WBG4dolRB0AC/rwUWJp7EE7roqvN6zP+ar9TrAgTUubTq8d2BKWRyi9Ux4Aah8TPBYLL/7oty4vrUXrKIKb0KoBEZO/J+GHjlb6u6RUdNqdQcMEND7C9ecVu4nK7BkkQoeUInt4+ZaysCAuF/EdZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II3dfFNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C925EC4CED0;
	Tue, 12 Nov 2024 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731431498;
	bh=ga3dKBc62Z4mi0etr/9wyQGY2vEKZ6lsaiEZ72u5JI8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=II3dfFNf55ntWQTMR78MPvosfiLX76ErO3YcT8n/b9MwWm5/ROWyPt7eujU9/AdhO
	 wAQZVaWZ+sqYwOVsP7FjAUH1dttPnVlTfb4eie7DAxE3Aj/J25NT5332cHtaxlj5v1
	 5Bmi5/hvMJ6LcEd/Rufs3vP6Idx8q6PZm0q/w/9qJSu48XWim7TpLSVC7RUFeUrBfy
	 HKnUJMfmgYwJBwjJk9KTkR/HQFtwH+rd46Ii5dTP1DnskMBJzBm+pM5+oV0zf+ZItL
	 kshymC0+lvkpMs4rZSFFLf9CROamY2MANkdPp6FhtgoS2Jp9H/+Lmlaq7+SIJFcO3Z
	 BiZ5Isczg6jrQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/8] wifi: ath12k: support change_sta_links() mac80211 op
References: <20241106142617.660901-1-kvalo@kernel.org>
	<20241106142617.660901-3-kvalo@kernel.org>
	<e028f65c-9faa-46e0-ae34-35815a121ba9@quicinc.com>
	<8734jw4ciw.fsf@kernel.org>
Date: Tue, 12 Nov 2024 19:11:36 +0200
In-Reply-To: <8734jw4ciw.fsf@kernel.org> (Kalle Valo's message of "Tue, 12 Nov
	2024 18:55:51 +0200")
Message-ID: <87ttcc2x87.fsf@kernel.org>
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
>> On 11/6/2024 10:26 PM, Kalle Valo wrote:
>>> From: Sriram R <quic_srirrama@quicinc.com>
>>> 
>>> Add ath12k_mac_op_change_sta_links() for adding and removing
>>> link station.
>>> 
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>> 
>>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>>> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>> ---
>>>  drivers/net/wireless/ath/ath12k/mac.c | 97 ++++++++++++++++++++++++++-
>>>  1 file changed, 96 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>>> index 0ff886e4b3ed..c0cc4e51a4d1 100644
>>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>>> @@ -5572,6 +5572,101 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
>>>  	rcu_read_unlock();
>>>  }
>>>  
>>> +static struct ath12k_link_sta *
>>> +ath12k_mac_alloc_assign_link_sta(struct ath12k_hw *ah,
>>> +				 struct ath12k_sta *ahsta,
>>> +				 struct ath12k_vif *ahvif, u8 link_id)
>>> +{
>>> +	struct ath12k_link_sta *arsta;
>>> +	int ret;
>>> +
>>> +	lockdep_assert_wiphy(ah->hw->wiphy);
>>> +
>>> +	if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
>>> +		return NULL;
>>> +
>>> +	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
>>> +	if (arsta)
>>> +		return NULL;
>>> +
>>> +	arsta = kzalloc(sizeof(*arsta), GFP_KERNEL);
>>
>> kmalloc() is preferred as ath12k_mac_assign_link_sta() will do 'zero'?
>
> That's true. Jeff, are you able to change this in the pending branch?

Actually ignore that, I'll submit v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

