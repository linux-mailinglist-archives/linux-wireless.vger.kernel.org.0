Return-Path: <linux-wireless+bounces-23029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1443FAB8E0E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A1C1BC16E2
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5A717BA3;
	Thu, 15 May 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="bF3djluT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800E1361
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331233; cv=none; b=EOQKzAGTYp67qLm7younQ6NFoqWuQ4fq/KlUmoqN8sd7Xyn6ymP0nc093LuRff1/k0sOJ7rlAICwWtx02ER0aQKxQn1/MNSSAI4x5YWt91ECNqZLJEanfxstAIToBlh5kBsSBp67RWYo1Jysj2Mv54SlB+JKEglqU83QW1CwHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331233; c=relaxed/simple;
	bh=ppT4f5KlGBgk8DfxgDzQeyhtpeGKY6Z5RerzWqnZTKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsGpNIqD4luAaVWhXwDsOwUOccCD6OU69Gkb46bAffT8oY9ewYlGKZMNIHgNLQCZDMcUmXYjJFF4TKU5jX1j1L5WYfykEeVTWvY8o05MVHqxbp8quwm+bEVkjOIJ/qf3U7tD0wWf8B7xyoQU/8LBkc0lJ5M9/VoTg8E7foGMh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=bF3djluT; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BF29F2A73D3
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 17:38:17 +0000 (UTC)
Received: from engine.ppe-hosted.com (unknown [10.7.65.218])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C82BF600C7;
	Thu, 15 May 2025 17:38:11 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 994DF1000A1;
	Thu, 15 May 2025 17:38:09 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 3AD6E13C2B0;
	Thu, 15 May 2025 10:38:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3AD6E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1747330689;
	bh=ppT4f5KlGBgk8DfxgDzQeyhtpeGKY6Z5RerzWqnZTKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bF3djluTY+krrMqRKtZ4sKAj2xyLfQ0GRG/AnpLHHgaNudvXcjK8o1aTd4rHVW1kR
	 b9wvH+3MWdj2xm7boiAhHq9Q+fAS05nzZjczPbJQJuXpkhxLz4v43jIyVz0MxtHR4Y
	 Xf0rd6aay3y7Bq8wXUAndL02HefpTZ7Fftc4nvrQ=
Message-ID: <921a952f-84ab-38dc-836a-1de0aa565f24@candelatech.com>
Date: Thu, 15 May 2025 10:38:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
 <52d96a61f56cd37b297e12b7ffb2936a479607ea.camel@sipsolutions.net>
 <f6d6ed3c-54de-4dcb-bea3-8a420f001c9a@quicinc.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <f6d6ed3c-54de-4dcb-bea3-8a420f001c9a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1747330690-lJKFqVolB_GR
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1747330690;lJKFqVolB_GR;<greearb@candelatech.com>;535bfda298b524f45ffb92fb019ae3e8
X-PPE-TRUSTED: V=1;DIR=OUT;

On 5/15/25 10:35, Sarika Sharma wrote:
> On 5/15/2025 5:00 PM, Johannes Berg wrote:
>> On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>>>
>>> +void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
>>> +                         struct station_info *sinfo)
>>> +{
>>> +    /* Resetting the MLO statistics for accumulated fields, to
>>> +     * avoid duplication.
>>> +     */
>>> +    sinfo->tx_packets = 0;
>>> +    sinfo->rx_packets = 0;
>>> +    sinfo->tx_bytes = 0;
>>> +    sinfo->rx_bytes = 0;
>>> +    sinfo->tx_retries = 0;
>>> +    sinfo->tx_failed = 0;
>>> +    sinfo->rx_dropped_misc = 0;
>>> +    sinfo->beacon_loss_count = 0;
>>> +    sinfo->expected_throughput = 0;
>>> +    sinfo->rx_mpdu_count = 0;
>>> +    sinfo->fcs_err_count = 0;
>>> +    sinfo->rx_beacon = 0;
>>> +    sinfo->rx_duration = 0;
>>> +    sinfo->tx_duration = 0;
>>> +
>>> +    /* Accumulating the removed link statistics. */
>>> +    sinfo->tx_packets += sta->rem_link_stats.tx_packets;
>>> +    sinfo->rx_packets += sta->rem_link_stats.rx_packets;
>>> +    sinfo->tx_bytes += sta->rem_link_stats.tx_bytes;
>>> +    sinfo->rx_bytes += sta->rem_link_stats.rx_bytes;
>>> +    sinfo->tx_retries += sta->rem_link_stats.tx_retries;
>>> +    sinfo->tx_failed += sta->rem_link_stats.tx_failed;
>>> +    sinfo->rx_dropped_misc += sta->rem_link_stats.rx_dropped_misc;
>>
>> Setting something to 0 just to += it seems silly?
>>
>> However I think it also needs a bit more explanation - it's sinfo, so
>> it's zeroed at allocation, where would non-zero numbers come from?
> 
> Currently, the station information for MLO is populated with some values from sta->deflink, as the sta_set_sinfo() call is common for both non-MLO and MLO.
> 
> When updating the station_info structure in cfg80211_sta_set_mld_sinfo(), the accumulated fields (such as packets, bytes, etc.) will already contain values set 
> by mac80211 (from the deflink fields).
> 
> Therefore, directly adding to these fields would be incorrect, so they should be reset to zero.
> 
> May be this, resetting can be done directly in cfg80211 during cfg80211_sta_set_mld_sinfo(), will correct this.

If nothing else, you could just do assignment instead of setting to zero and then
incrementing?

I did not actually review the over-all logic, so perhaps there are bigger
issues I'm not aware of.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



