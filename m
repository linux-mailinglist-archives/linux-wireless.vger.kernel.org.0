Return-Path: <linux-wireless+bounces-26705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B5B385D1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 17:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E651B64735
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB16727380A;
	Wed, 27 Aug 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YyVSKlEl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F19272E68;
	Wed, 27 Aug 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307479; cv=none; b=QeSxYPxxYcydgLgBLTQw2Ls0DLq2YuI3nHZbVv1AwXujy2mjohh/lwvpRY/iJYuSJNCUNJhSjFwT5pqhbb52OG26UtDxifT+oPpYHKRHuqldOvnbiQ8ImUoSRaiV3JdXbLyytZ+oO2SMsdBbZ/INrZIjrb7ymUUNAJiSftiNglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307479; c=relaxed/simple;
	bh=ix5mBV2tHxNkaYu8ZnrYGuOsxjJH8TMxsLOG1sca9yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z014X/jPvF3NsCR1q77kjjuelDaYl6lrdOVciUINFhgEWbo1utthx+45FmApgEzguGF4dJvAAp0u7GNTaNuuweTJMojUBT4n/n2IO9mdQLYSHRZchtGPElN68/SeSVQ4hpqQ9zxqo2Nbvz/YtLgr9yOwan0zXGsNozNhr+LlFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YyVSKlEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98D9C4CEEB;
	Wed, 27 Aug 2025 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756307479;
	bh=ix5mBV2tHxNkaYu8ZnrYGuOsxjJH8TMxsLOG1sca9yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YyVSKlElGm7IdIB0/3kRBjMNWOOSlxgzEZegHTwdem/81yipLwrEbCjwlVUnklOzn
	 3wqzpC2X6u58BfiNI73GPogJqDCX0ENvQXG3Nsn3tMU4K+aoDagrykMtgeTV8PCrmY
	 nGjF+2AxtYbjgKOKi1JjjrhGhWNHSHJJKBcrGfFg=
Date: Wed, 27 Aug 2025 17:11:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Wetzel <lifangxu22@gmail.com>
Cc: stable@vger.kernel.org, johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org, lifangxu@kylinos.cn,
	Alexander Wetzel <Alexander@wetzel-home.de>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 5.4.y] wifi: cfg80211: Add missing lock in
 cfg80211_check_and_end_cac()
Message-ID: <2025082749-strength-baffling-eb44@gregkh>
References: <20250827144502.1401-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827144502.1401-1-Alexander@wetzel-home.de>

On Wed, Aug 27, 2025 at 10:45:02PM +0800, Alexander Wetzel wrote:
> [ Upstream commit 2c5dee15239f3f3e31aa5c8808f18996c039e2c1 ]
> 
> Callers of wdev_chandef() must hold the wiphy mutex.
> 
> But the worker cfg80211_propagate_cac_done_wk() never takes the lock.
> Which triggers the warning below with the mesh_peer_connected_dfs
> test from hostapd and not (yet) released mac80211 code changes:
> 
> WARNING: CPU: 0 PID: 495 at net/wireless/chan.c:1552 wdev_chandef+0x60/0x165
> Modules linked in:
> CPU: 0 UID: 0 PID: 495 Comm: kworker/u4:2 Not tainted 6.14.0-rc5-wt-g03960e6f9d47 #33 13c287eeabfe1efea01c0bcc863723ab082e17cf
> Workqueue: cfg80211 cfg80211_propagate_cac_done_wk
> Stack:
>  00000000 00000001 ffffff00 6093267c
>  00000000 6002ec30 6d577c50 60037608
>  00000000 67e8d108 6063717b 00000000
> Call Trace:
>  [<6002ec30>] ? _printk+0x0/0x98
>  [<6003c2b3>] show_stack+0x10e/0x11a
>  [<6002ec30>] ? _printk+0x0/0x98
>  [<60037608>] dump_stack_lvl+0x71/0xb8
>  [<6063717b>] ? wdev_chandef+0x60/0x165
>  [<6003766d>] dump_stack+0x1e/0x20
>  [<6005d1b7>] __warn+0x101/0x20f
>  [<6005d3a8>] warn_slowpath_fmt+0xe3/0x15d
>  [<600b0c5c>] ? mark_lock.part.0+0x0/0x4ec
>  [<60751191>] ? __this_cpu_preempt_check+0x0/0x16
>  [<600b11a2>] ? mark_held_locks+0x5a/0x6e
>  [<6005d2c5>] ? warn_slowpath_fmt+0x0/0x15d
>  [<60052e53>] ? unblock_signals+0x3a/0xe7
>  [<60052f2d>] ? um_set_signals+0x2d/0x43
>  [<60751191>] ? __this_cpu_preempt_check+0x0/0x16
>  [<607508b2>] ? lock_is_held_type+0x207/0x21f
>  [<6063717b>] wdev_chandef+0x60/0x165
>  [<605f89b4>] regulatory_propagate_dfs_state+0x247/0x43f
>  [<60052f00>] ? um_set_signals+0x0/0x43
>  [<605e6bfd>] cfg80211_propagate_cac_done_wk+0x3a/0x4a
>  [<6007e460>] process_scheduled_works+0x3bc/0x60e
>  [<6007d0ec>] ? move_linked_works+0x4d/0x81
>  [<6007d120>] ? assign_work+0x0/0xaa
>  [<6007f81f>] worker_thread+0x220/0x2dc
>  [<600786ef>] ? set_pf_worker+0x0/0x57
>  [<60087c96>] ? to_kthread+0x0/0x43
>  [<6008ab3c>] kthread+0x2d3/0x2e2
>  [<6007f5ff>] ? worker_thread+0x0/0x2dc
>  [<6006c05b>] ? calculate_sigpending+0x0/0x56
>  [<6003b37d>] new_thread_handler+0x4a/0x64
> irq event stamp: 614611
> hardirqs last  enabled at (614621): [<00000000600bc96b>] __up_console_sem+0x82/0xaf
> hardirqs last disabled at (614630): [<00000000600bc92c>] __up_console_sem+0x43/0xaf
> softirqs last  enabled at (614268): [<00000000606c55c6>] __ieee80211_wake_queue+0x933/0x985
> softirqs last disabled at (614266): [<00000000606c52d6>] __ieee80211_wake_queue+0x643/0x985
> 
> Fixes: 26ec17a1dc5e ("cfg80211: Fix radar event during another phy CAC")
> Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
> Link: https://patch.msgid.link/20250717162547.94582-1-Alexander@wetzel-home.de
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> Conflicts:
> 	net/wireless/reg.c

This isn't needed.

> Signed-off-by: lifangxu <lifangxu@kylinos.cn>

This has to match the From: line like any other patch you send :(

Can you please fix up and resend?

thanks,

greg k-h

