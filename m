Return-Path: <linux-wireless+bounces-14644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93BE9B4E34
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E16D283288
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6DE194AD6;
	Tue, 29 Oct 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwc0OTsM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1CB194AD5
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216301; cv=none; b=LILCT/1u3y1fDxKCzBtsUHF4MUjj/UEJlb52scTSbMyaAt4vjERLNNb5fva+/tVhBv9m7pG1X8WC9MDhu4xzFMqXWvRh5f9MWfsWAxui3IW86OO0zqwsRIH6dfKwOWVdwDaMVhKKL7odRvtDusXjNFwB7O9z4UhNdJ4Tkfj9Bfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216301; c=relaxed/simple;
	bh=7koc/GFdhTZdrZ0NcZyL5CVWROPPIVBdXCdcDMNX7nQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cTero9rVN0SzGk3tH66BY7upnJ8yFpYif3T9zt80gJ6IjUp8qxxUh6YIWbqbFNRdvTC1GMjBSdbbr8qkw2GA3BjbNNg6Rzt7d7p28s8RKyBmBVFYGnKDQodbgqLXyeQJuBPxM7c+L8kI69lav4ttoSREwMAkr2xaoir6HwXDqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwc0OTsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE452C4CECD;
	Tue, 29 Oct 2024 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730216300;
	bh=7koc/GFdhTZdrZ0NcZyL5CVWROPPIVBdXCdcDMNX7nQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jwc0OTsMz+5dZu9WOLGpG7j1ctZehTtE0+zFlkQlV/IuxStxXYNY/uUSAguHFd2W+
	 TFDXWLnPOJZSJ9BRn7a0p4458IYujLrZZvR38rvDbivuUmRM+Vq2MmzdIAVWNOnBlY
	 LYjhehcVb7Xr8V213wAvMm7HlSOyhpOSrbLmk0ex0q3L5nPTgR8KATgB2rUKzNRjcR
	 RkDxQ0Sha65gQI1s8qPgR/OjZIlDG4aNInmzjoPjZWHCiO79ZDXT28gA57H8SxiE5k
	 94ax96frk7sQTydU3xpVt8SfmLYbMOVwkhcN2MCAg3joBdImIsDP8igaWbEA8HYM8R
	 hpb/bZReH3fYw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Aditya Kumar Singh
 <quic_adisi@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/8] wifi: ath12k: Refactor sta state machine
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-4-kvalo@kernel.org>
	<a4b92b80-ec57-4db3-acd7-9c6c7644d7c9@quicinc.com>
Date: Tue, 29 Oct 2024 17:38:18 +0200
In-Reply-To: <a4b92b80-ec57-4db3-acd7-9c6c7644d7c9@quicinc.com> (Jeff
	Johnson's message of "Wed, 23 Oct 2024 08:38:09 -0700")
Message-ID: <875xpahqc5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

+ aditya

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>> +static int ath12k_mac_station_unauthorize(struct ath12k *ar,
>> +					  struct ath12k_link_vif *arvif,
>> +					  struct ath12k_link_sta *arsta)
>> +{
>> +	struct ath12k_peer *peer;
>> +	int ret;
>> +
>> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>> +
>> +	spin_lock_bh(&ar->ab->base_lock);
>> +
>> +	peer = ath12k_peer_find(ar->ab, arvif->vdev_id, arsta->addr);
>> +	if (peer)
>> +		peer->is_authorized = false;
>> +
>> +	spin_unlock_bh(&ar->ab->base_lock);
>> +
>> +	/* Driver should clear the peer keys during mac80211's ref ptr
>> +	 * gets cleared in __sta_info_destroy_part2 (trans from
>> +	 * IEEE80211_STA_AUTHORIZED to IEEE80211_STA_ASSOC)
>
> I'm unable to understand this comment

Indeed, that's weird. Aditya, do you have any idea what the comment is
trying to say?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

