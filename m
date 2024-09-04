Return-Path: <linux-wireless+bounces-12497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB7896C463
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 18:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0EE284093
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080B71DA31D;
	Wed,  4 Sep 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNyJNrnW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE884A21
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468470; cv=none; b=jxU9SxyEMOao/xBDzpG5QnRFyfiEkTMR2BkkbHAi0D1FnAZ9obGQNeTRszQUeqE1jr0T3BfIGeFJByGAyX+W7iaiUAHz9FAktdIS383Jubbev86mYtpsF8y5MZ93Ycc1rdT8PWCxUyKCut8MK+sz1EPSymQ170PT8nGhSqYFMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468470; c=relaxed/simple;
	bh=X66EKTKKlLp0zzrFK7FAl5dyY0nwJPplilZx9JvjO8o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=m7QPhvQ4SWR37nnCMb3lG3XfYgAnGKjExze+cIHEaIYzkNRXm/+vJH7LcXktu8mhea5g4hC7IcOjgYOCr/BRQkv2DkzDDCYPL89YuaiwxMnvF3EmQfvKDkDJtMpQ2JD7cC//08KSa/yb1iT7HbDHynA18X8hcaJpyOE+Mor3exw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNyJNrnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9081EC4CEC2;
	Wed,  4 Sep 2024 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725468470;
	bh=X66EKTKKlLp0zzrFK7FAl5dyY0nwJPplilZx9JvjO8o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=vNyJNrnWeiY8x1WdnAlyKaLRFT9inNHSRu+kcoUeJahW6ZJ5d9xwnL8+zp31VIS9T
	 UVjOVaCZJnTb1ImfT9EFO21qMvPkUq1GDqEjw35IB2cdqLIhii2CaOQ4bb8w5017NH
	 YVL+YKFmeGvlzTCy9VzkbvtYKkvihUFBndPc4TIC1yo74lHWPns1oVrVCP3k+eBBwZ
	 sbL2nUZUDd+e6G9F+q2g4G9orkH/VVBZutesOVQL5KUBeWhhBTYl9f1AihYMhu/Nc7
	 6hHz81mrPeb/QEyuQPXPXVJVuzwFKJ4E9jWniFvNtSLHkjME91v+QaJlRQ1o+riwas
	 U67cAlLu+i26w==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: avoid deadlock during regulatory update
 in ath12k_regd_update()
References: <20240830023901.204746-1-quic_bqiang@quicinc.com>
	<f613591f-bca5-4481-99e8-d294703f67dc@quicinc.com>
Date: Wed, 04 Sep 2024 19:47:47 +0300
In-Reply-To: <f613591f-bca5-4481-99e8-d294703f67dc@quicinc.com> (Jeff
	Johnson's message of "Wed, 4 Sep 2024 09:33:05 -0700")
Message-ID: <87frqfcqmk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/29/2024 7:39 PM, Baochen Qiang wrote:
>
>> From: Wen Gong <quic_wgong@quicinc.com>
>> 
>> Running this test in a loop it is easy to reproduce an rtnl deadlock:
>> 
>> iw reg set FI
>> ifconfig wlan0 down
>> 
>> What happens is that thread A (workqueue) tries to update the regulatory:
>> 
>>     try to acquire the rtnl_lock of ar->regd_update_work
>> 
>>     rtnl_lock
>>     ath12k_regd_update [ath12k]
>>     ath12k_regd_update_work [ath12k]
>>     process_one_work
>>     worker_thread
>>     kthread
>>     ret_from_fork
>> 
>> And thread B (ifconfig) tries to stop the interface:
>> 
>>     try to cancel_work_sync(&ar->regd_update_work) in ath12k_mac_op_stop().
>>     ifconfig  3109 [003]  2414.232506: probe:
>> 
>>     ath12k_mac_op_stop [ath12k]
>>     drv_stop [mac80211]
>>     ieee80211_do_stop [mac80211]
>>     ieee80211_stop [mac80211]
>> 
>> The sequence of deadlock is:
>> 
>> 1. Thread B calls rtnl_lock().
>> 
>> 2. Thread A starts to run and calls rtnl_lock() from within
>>    ath12k_regd_update_work(), then enters wait state because the lock is owned by
>
> checkpatch complains that the commit description exceeds 75 columns
>
> at a minimum you should avoid exceeding 80 columns
>
> Kalle, do you want to reformat when you pull into pending?

Yes, I can reformat it in the pending branch. But I'm busy right now so
it might take a while.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

