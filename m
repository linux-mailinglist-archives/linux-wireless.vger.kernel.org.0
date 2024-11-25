Return-Path: <linux-wireless+bounces-15693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38909D8AD6
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 17:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D771698C6
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1251B4126;
	Mon, 25 Nov 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/JONB8i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A81AD418
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553992; cv=none; b=lcNIHoUzIXop7LytKmHYUGiCU76ngdipD9Ut+kzUXRMPd9LNckYG8CXdLDIxYxS24ksj3hw4ZUlTEWPstne+2nPmEP43mi6V8LdAKT5LB+pvk/K8ln8OnjeskbWmnNTHcUPPWm8tNq8kgIhmccCGUdhdT69i992NbcQ04Obd/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553992; c=relaxed/simple;
	bh=XNq8q55584h79E89kcVLCw2LeiYgjOWnn4wWoaKuqr4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gvrOS2UXqBURxfldpbwZqWy2A4QleBOsVfR+yBUZMj7wSSuBFQVSR2icgoH/JeFz2HKH8JgQeZC2q/8sNimjgx0qVNXzSQlXd5Ki9NDM6TD473CgpA9aq/olyxFbMcDY+6WI9XpNNto1bzcVtRFxl0441sBtDpNjwelJLmGYyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/JONB8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBC1C4CECE;
	Mon, 25 Nov 2024 16:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732553992;
	bh=XNq8q55584h79E89kcVLCw2LeiYgjOWnn4wWoaKuqr4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=U/JONB8i42F/pz+SKflSuA3y4hmEab2TuB5OHhIBv1zggW4moc3oaD9Ks7zS2dPu/
	 Dk35IUABDsAWrfli2ZKZvkDWbpDn0PNvRf+W15G/t3fe4SBRk5mb3LMP4+bVeMPuUs
	 U96gE2Z4PSvHmi8oKGUl61HNQ7n4e7ppNeTj3ZRoMb8GFu9Egc1LaGHGI5FE4oRvi1
	 hHLe9Z8XFLnFTmPOG1+r4qxDlbIChlisUBHydixBL/KVmFoLmyYyf5XC8nrxq9YfZv
	 frYyPFQrrUxsUJFSH98IeZjzpGpN5MtSQ+foOZZu8vqN346IWvALDgWc2PlZtWZQmw
	 EuAvPqjcoEGVQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 8/8] wifi: ath12k: Use mac80211 sta's link_sta instead
 of deflink
References: <20241121155806.1862733-1-kvalo@kernel.org>
	<20241121155806.1862733-9-kvalo@kernel.org>
	<84214119-96d9-4873-a655-bd2f6f649bb6@quicinc.com>
Date: Mon, 25 Nov 2024 18:59:49 +0200
In-Reply-To: <84214119-96d9-4873-a655-bd2f6f649bb6@quicinc.com> (Jeff
	Johnson's message of "Thu, 21 Nov 2024 16:27:42 -0800")
Message-ID: <87bjy3w8oq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 11/21/2024 7:58 AM, Kalle Valo wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>> 
>> Currently mac80211's struct ieee80211_sta deflink is used to fetch any sta
>> related configurations in driver. With MLO multiple link sta's (struct
>> ieee80211_link_sta) are affiliated to an ML sta and corresponding link configs
>> are present in sta->link[]. Fetch link sta of corresponding link from ML sta
>> and use the same for configurations.
>> 
>> Add ath12k_get_link_sta() helper to fetch ieee80211_link_sta from arsta. But as
>
> nit: Add ath12k_mac_get_link_sta() ...

Fixed in the pending branch, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

