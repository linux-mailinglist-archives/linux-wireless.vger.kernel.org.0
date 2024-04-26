Return-Path: <linux-wireless+bounces-6927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F35D8B3672
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 13:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836E01C211A6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 11:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC2013A3EE;
	Fri, 26 Apr 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqHng6fb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AA139CFC
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714130473; cv=none; b=WXjYJZpWWr0dc1pDYiz2Y5m+s15DgJEid3NY4GzQBVjPhXmwY9K2GGf/YcBt64Lfq0wG3DSnOf6Q74bJoILxd0kgiFf4lSSef8CcwI49iY2cp1UEbA//MOQ87/AFieVhWeW3hymxJjObPaTm23fZ2KB14saQ2J4tpCLYkOPQXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714130473; c=relaxed/simple;
	bh=mhBi+vrcS4Fy8zp+GC5pGosCtmCgqqvpS4W1W39uIEI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TDT131G7l0/EmODoARfq0EIgZZkv3PprIVQmq9DA2n9Whupm5BBRLcdx2PfjeZp9rSh+l7ETCR3oX+7pH6anOc/h19NloRSagM1+64vt1d/9dDnaALphaB+gXMFWrmi6KHZXxCneAcdlgnXWJz/y17pPj276qy5uu2PF7raTdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqHng6fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9E0C113CD;
	Fri, 26 Apr 2024 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714130472;
	bh=mhBi+vrcS4Fy8zp+GC5pGosCtmCgqqvpS4W1W39uIEI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qqHng6fbOZrw5Rdam/rL7VnqAgC265jAiGJOHd17zfXQmjaMdV3NTp8baRkyYYv1X
	 HLHk+AdxpDs5B0WkqIP2XwjOXnnhiVP9qv8viXnAguqjkhTsYFRHwiRwHAwc4+hML4
	 ltnTQrRmV8V5KelVooorRmIOQmyQcsbiOSsW8WMBtrFD7q9ZowqfL4GT1ZSpUUzCcQ
	 0qoD9Kera0Ih/gNAu0ukcnuRnXC1rnDryN6ngC+gn/k2njK2SvlcdOUrThrCrQpXPz
	 cVXnVbdj4qcOxeexFPUUNkE61q+xb0XQjKmUhDIcxzADkmuQlwLjia1yxjycEBu2Kz
	 QJNtCn7L/9u5w==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] wifi: ath12k: report station mode transmit rate
References: <20240419032122.7009-1-quic_lingbok@quicinc.com>
	<20240419032122.7009-2-quic_lingbok@quicinc.com>
	<87bk5xs7qj.fsf@kernel.org>
	<050ae0d4-c879-40c2-b2ac-1766aaa2c789@quicinc.com>
Date: Fri, 26 Apr 2024 14:21:10 +0300
In-Reply-To: <050ae0d4-c879-40c2-b2ac-1766aaa2c789@quicinc.com> (Lingbo Kong's
	message of "Fri, 26 Apr 2024 14:41:33 +0800")
Message-ID: <87v844qsih.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> On 2024/4/26 0:54, Kalle Valo wrote:
>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>> 
>>> +static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct
>>> hal_tx_status *ts)
>>> +{
>>> +	struct ath12k_base *ab = ar->ab;
>>> +	struct ath12k_peer *peer;
>>> +	struct ath12k_sta *arsta;
>>> +	struct ieee80211_sta *sta;
>>> +	u16 rate;
>>> +	u8 rate_idx = 0;
>>> +	int ret;
>>> +
>>> +	spin_lock_bh(&ab->base_lock);
>>
>> Did you analyse how this function, and especially taking the
>> base_lock,
>> affects performance?
>
> The base_lock is used here because of the need to look for peers based
> on the ts->peer_id when calling ath12k_peer_find_by_id() function,
> which i think might affect performance.
>
> Do i need to run a throughput test?

Ok, so to answer my question: no, you didn't do any performance
analysis. Throughput test might not be enough, for example the driver
can be used on slower systems and running the test on a fast CPU might
not reveal any problem. A proper analysis would be much better.

>>> +enum nl80211_he_ru_alloc
>>> ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
>>> +{
>>> +	enum nl80211_he_ru_alloc ret;
>>> +
>>> +	switch (ru_tones) {
>>> +	case 26:
>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
>>> +		break;
>>> +	case 52:
>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
>>> +		break;
>>> +	case 106:
>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
>>> +		break;
>>> +	case 242:
>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
>>> +		break;
>>> +	case 484:
>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
>>> +		break;
>>> +	case 996:
>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
>>> +		break;
>>> +	case (996 * 2):
>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
>>> +		break;
>>> +	default:
>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
>>> +		break;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>> How does this function compare to
>> ath12k_he_ru_tones_to_nl80211_he_ru_alloc()?
>> 
>
> ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc() is different from
> ath12k_he_ru_tones_to_nl80211_he_ru_alloc().
>
> the logic of ath12k_he_ru_tones_to_nl80211_he_ru_alloc() is

Sure, I can read C. But _why_ do we have two very similar but still
different functions. That looks fishy to me.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

