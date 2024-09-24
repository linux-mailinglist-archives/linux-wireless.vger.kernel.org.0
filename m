Return-Path: <linux-wireless+bounces-13104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F199841B1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1691C22B18
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512682110E;
	Tue, 24 Sep 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgf1IvBl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D137154426
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169077; cv=none; b=vEx6Z9TLSW81zPaDh0sNBrwHvhgO23yhaM9R6r10APLi40kGOv5VsgtyvgFtpygqROGwZM18uRutcP7NQstKx8TRZTYZZntZSbRXY0Kg0HlzzkndVowUQKHf7qMjqcjUQxfDWIpav9tLO8Z7Kp/qtzGUCxnQwdyQOncaqXyK3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169077; c=relaxed/simple;
	bh=E+OVsVTME16mVT99zvFxAxUSip6UlzcwqZUbZKjr/Dw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=d7mcKFpg5GOZ7Ve2h04NWNyP8WgGfQfwoZ707JS/oyIWcdIwAsuMbixjVlo7hUvvWEXXjpLfuGLEMl6IoDJPyOZEQC2aHfS2wgDfaqnXo9RZUtQqC5+dguo0w1bIbXj+GdnCZouoPjyFZhocuQ6CG/JlHLSropBaYMvhB+j7B7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgf1IvBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07964C4CEC4;
	Tue, 24 Sep 2024 09:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169076;
	bh=E+OVsVTME16mVT99zvFxAxUSip6UlzcwqZUbZKjr/Dw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qgf1IvBlVj19NZirdVOdPALXM09jI9ECp+/v7AjJhp62aazjb1Mn80VORcXEqxG5E
	 ZO/W1/oJ33i+5b55hwmyoRI3mnrIJoNJOA3qLnjVcQjSVCItmkYo2o/aeUH59aV3Xt
	 kd92rzHq2rkHjb+parUOJczWm1GPjpyRgVSA/0CDEiwqXGWf7qdfuFJw9w1N+SeifV
	 SVS1hGyPp6o97WB64C31dGYDMBCoKKZL4CE21+V8PwvGcaa2Qdu6mej7ZoeuuB91aD
	 IvFFPZO0HVSLJBKGLryspua7bo+bv4H1Dwj2ShZLDNA8ETRwt1s8HEXQef5aViNrjo
	 TWXLPPtNpTghQ==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/4] wifi: ath12k: switch to using wiphy_lock()
 and remove ar->conf_mutex
References: <20240918181042.91891-1-kvalo@kernel.org>
	<20240918181042.91891-2-kvalo@kernel.org>
	<33ea3a62b4257b6ef789c30fa8f7bf7e9f1865b5.camel@sipsolutions.net>
Date: Tue, 24 Sep 2024 12:11:14 +0300
In-Reply-To: <33ea3a62b4257b6ef789c30fa8f7bf7e9f1865b5.camel@sipsolutions.net>
	(Johannes Berg's message of "Thu, 19 Sep 2024 09:06:21 +0200")
Message-ID: <87o74da025.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2024-09-18 at 21:10 +0300, Kalle Valo wrote:
>> 
>> There is now a new sparse warning, but to keep this long patch simple the
>> labels will be cleaned up in following patches:
>> 
>> drivers/net/wireless/ath/ath12k/mac.c:6635:1: warning: statement expected after label
>
> I believe this is a compiler error on some compilers (in particular
> clang), so you probably need to combine patches a little bit.

I had actually already fixed this but forgot to update the commit
message, did that now in v3.

>> +++ b/drivers/net/wireless/ath/ath12k/debugfs.c
>> @@ -15,14 +15,14 @@ static ssize_t ath12k_write_simulate_radar(struct file *file,
>>  	struct ath12k *ar = file->private_data;
>>  	int ret;
>>  
>> -	mutex_lock(&ar->conf_mutex);
>> +	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
>
> I don't think this is an issue here, but I'm not sure if you're aware
> that in general, locking the wiphy mutex in some debugfs file handlers
> can lead to deadlocks, specifically if those files are later _removed_
> while holding the wiphy lock, as is e.g. the case for station, netdev
> and link debugfs files. For this, we have wiphy_locked_debugfs_read()
> and wiphy_locked_debugfs_write() [1].
>
> [1] you are not required to understand how they are implemented ;-)

Thanks, this is good to know. I'm not that worried about that, at least
it's not showing up in my tests, so my plan is to fix that in a separate
patchset.

>> @@ -4310,7 +4301,7 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
>>  
>>  	spin_unlock_bh(&ar->data_lock);
>>  
>> -	mutex_lock(&ar->conf_mutex);
>> +	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
>
> Baochen already pointed out that you seem to not remove this later in
> patch 4, but in this patch alone you also introduce a bug (that lockdep
> should point out to you), which is that you cancel_work_sync() this in
> ath12k_mac_op_sta_state(), which clearly holds the wiphy mutex already.
>
> This causes a deadlock. It's fine after patch 4:
>
>>  	/* cancel must be done outside the mutex to avoid deadlock */
>>  	if ((old_state == IEEE80211_STA_NONE &&
>>  	     new_state == IEEE80211_STA_NOTEXIST))
>> -		cancel_work_sync(&arsta->update_wk);
>> +		wiphy_work_cancel(hw->wiphy, &arsta->update_wk);
>
> since for wiphy work it's required to ca<ll it with the mutex held./

Excellent find! I fixed it so that I moved this patch before switching
to use wiphy_lock(). There should not be a deadlock anymore, hopefully
:)

> You really should remove that comment too though, and perhaps then the
> code can be simplified by moving this to the later code also handling
> removal (none->notexist transition).

Good point. In v3 I added a new patch for this.

Thanks again for the review, I owe you so many beers[1] that it's starting
to get difficult to store them ;)

[1] https://en.wikipedia.org/wiki/Karhu_(beer)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

