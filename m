Return-Path: <linux-wireless+bounces-15781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3244C9DB720
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 13:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB881281A76
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF7419004B;
	Thu, 28 Nov 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGha05sh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E22CCC0
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732795736; cv=none; b=al+T+cRXAt/YbRSTjUJzq54A6+g5Iw8xAytcNwMgP6u9kff5ljnonRqOU+M7piDLjPYOGXb9wVYtLRfs6K8G6taK7v9sE2UuzxGjrqGQDi7uzaE3HknGwgqfW5Xf63Cex8dqyI9FcbetmDBO5oLF+FvIHidMmqkXsTZDxX/trow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732795736; c=relaxed/simple;
	bh=M7XUhFj2CBG6AIiPB6HZ7jrcFq/PWCF9szTudLUMOfU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pJDk4AMhb7xzh+/SSwOJP/sWvHe8ozdetwBWEkZ21Dx+gy49OIH+O9YFPptojA1qIsO8gNhW0U9F6bQXh32+fRPEGhDJNU2lbK6aK2UPYmXeBk7ZpqMU4qRSqg61BD+kQoNb6RlKxMv3QIzpI4ztXV3xhZNRiGwNN4V1PAaQB/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGha05sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F235C4CECE;
	Thu, 28 Nov 2024 12:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732795735;
	bh=M7XUhFj2CBG6AIiPB6HZ7jrcFq/PWCF9szTudLUMOfU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=QGha05shSD5jCag2NbDx724fWeOoFzQuuRyWiJgJx4wl27x401l9esfEsfAhdrEac
	 s7ndBJhbaqGcmBv8zwsKsVprKvqSMoOsfyYnmgrqWivg15efRHSZpxWqmum+1L1oAf
	 mjpzgy5pKqHLK9wcCP8v253shAagrttzWqldKGZ9cyhqgv5AK9mL3n7ZGUkWIyI3Zg
	 /QEMIL39nUCyLosRYKFQJ4UNWzvfbxj3U/Ls2HGZE2qYIMRHOidE5lPHMcbodzmXsc
	 fEdh+h00YxbPIFWLnlWy88spFs9A4IGz00SDTdSy8V4Nqn6d8hHcL7zxeTxhYgRiDv
	 auaCPNqBkubMA==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 01/10] wifi: ath12k: convert struct
 ath12k::wmi_mgmt_tx_work to struct wiphy_work
References: <20241126171139.2350704-1-kvalo@kernel.org>
	<20241126171139.2350704-2-kvalo@kernel.org>
	<83b2325e-4d98-49a1-ae32-a69d7962e4a3@quicinc.com>
Date: Thu, 28 Nov 2024 14:08:53 +0200
In-Reply-To: <83b2325e-4d98-49a1-ae32-a69d7962e4a3@quicinc.com> (Baochen
	Qiang's message of "Wed, 27 Nov 2024 10:34:00 +0800")
Message-ID: <87y113v9uy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 11/27/2024 1:11 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -6726,6 +6726,8 @@ static void ath12k_mgmt_over_wmi_tx_drop(struct ath12k *ar, struct sk_buff *skb)
>>  {
>>  	int num_mgmt;
>>  
>> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>
> why would we need wiphy lock protect here? I don;t see anything in this function need it.
>
>> +
>>  	ieee80211_free_txskb(ath12k_ar_to_hw(ar), skb);
>>  
>>  	num_mgmt = atomic_dec_if_positive(&ar->num_pending_mgmt_tx);
>> @@ -6787,6 +6789,8 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
>>  	int buf_id;
>>  	int ret;
>>  
>> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>
> and here the same question as above. I know this function is only called from
> ath12k_mgmt_over_wmi_tx_work() which is under wiphy lock protection. But the function
> itself doesn't need to assert it if the function does not need its protection.
>
>> +
>>  	ATH12K_SKB_CB(skb)->ar = ar;
>>  	spin_lock_bh(&ar->txmgmt_idr_lock);
>>  	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
>> @@ -6841,7 +6845,7 @@ static void ath12k_mgmt_over_wmi_tx_purge(struct ath12k *ar)
>>  		ath12k_mgmt_over_wmi_tx_drop(ar, skb);
>>  }
>>  
>> -static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
>> +static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work *work)
>>  {
>>  	struct ath12k *ar = container_of(work, struct ath12k, wmi_mgmt_tx_work);
>>  	struct ath12k_skb_cb *skb_cb;
>> @@ -6850,6 +6854,8 @@ static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
>>  	struct sk_buff *skb;
>>  	int ret;
>>  
>> +	lockdep_assert_wiphy(wiphy);
>
> we are definitely under wiphy lock protection since this is a wiphy_work item, hence no
> need to assert it explicitly. see also
>
> ieee80211_sta_monitor_work()
> ieee80211_beacon_connection_loss_work()
> ieee80211_csa_connection_drop_work()
> ieee80211_teardown_ttlm_work()

I have deliberately added all these lockdep_assert_wiphy() calls to
document which functions are called with wiphy_lock() held, otherwise
doing any locking analysis is much harder. My plan is that once MLO
support has landed to ath-next my plan is to document ath12k locking
design properly in the code. I think at that point we can also discuss
how we should use lockdep_assert_wiphy() in ath12k and should we drop
the extra calls.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

