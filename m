Return-Path: <linux-wireless+bounces-7626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD58C4BC9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 06:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73838285BBF
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 04:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7871111CA1;
	Tue, 14 May 2024 04:51:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECED6156E4;
	Tue, 14 May 2024 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715662270; cv=none; b=ivEWgb5P3SNh03No3iZRGkWGu5JURGJnH9t5jQmJlYx/YON8koXsuzVdaRxV0q+qpwNPm4R7RiUVfUCGZI/vuwJaj60Qr0TiSvnDP5a9sfeg2koVlP6a+051kb8ukcS1rXFQXBP228e2qBrxDsvIswQOe9pNfVTYCVa4QPU4bRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715662270; c=relaxed/simple;
	bh=tDPqBP4j+7ZARKmInSjhtsEAIUssFCy8qEGySeTizao=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=bf/Qm7mvAWlzs6FKwDA5LSyX2gg4YqUHuiXhut+JxY3phmuXSaVM6BB5SrhqOYnEbOsnUh+vQcHtYrgUY6R/aEhYRlswT8k5a8YG2xZfjhHyP1AmaPfRM4vw8dvDy4X2V6xnKzrPRf6ckiqDBGB76VqqR+vHcXY3e4ewEBFcR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: keescook@chromium.org
Cc: chunkeey@gmail.com,chunkeey@googlemail.com,davem@davemloft.net,edumazet@google.com,helmut.schaa@googlemail.com,johannes@sipsolutions.net,kernel@quicinc.com,kuba@kernel.org,kvalo@kernel.org,linux-kernel@vger.kernel.org,linux-wireless@vger.kernel.org,netdev@vger.kernel.org,pabeni@redhat.com,pkshih@realtek.com,quic_jjohnson@quicinc.com,stf_xl@wp.pl,toke@toke.dk
Subject: Re: [PATCH v2 2/2] mac80211: Use flexible array in struct
 ieee80211_tim_ie
In-Reply-To: <202308301529.AC90A9EF98@keescook>
Organization: Gentoo
Date: Tue, 14 May 2024 05:51:02 +0100
Message-ID: <87jzjxgfnt.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I think I've just hit this, unless it's been fixed since and it's just
similar.

```
[  291.051876] ================================================================================
[  291.051892] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.6.30/work/linux-6.6/include/linux/ieee80211.h:4455:28
[  291.051901] index 1 is out of range for type 'u8 [1]'
[  291.051908] CPU: 2 PID: 627 Comm: kworker/2:3 Not tainted 6.6.30-gentoo-dist-hardened #1
[  291.051917] Hardware name: ASUSTeK COMPUTER INC. UX305FA/UX305FA, BIOS UX305FA.216 04/17/2019
[  291.051922] Workqueue: events cfg80211_wiphy_work [cfg80211]
[  291.052082] Call Trace:
[  291.052088]  <TASK>
[  291.052096] dump_stack_lvl (lib/dump_stack.c:107) 
[  291.052114] __ubsan_handle_out_of_bounds (lib/ubsan.c:218 (discriminator 1) lib/ubsan.c:348 (discriminator 1)) 
[  291.052130] ieee80211_rx_mgmt_beacon (include/linux/ieee80211.h:4455 net/mac80211/mlme.c:6047) mac80211
[  291.052354] ? check_preempt_wakeup (kernel/sched/fair.c:977 kernel/sched/fair.c:8226) 
[  291.052368] ? check_preempt_curr (kernel/sched/core.c:2232) 
[  291.052375] ? ttwu_do_activate (kernel/sched/core.c:3766 (discriminator 2) kernel/sched/core.c:3794 (discriminator 2)) 
[  291.052383] ? __mutex_lock.constprop.0 (kernel/locking/mutex.c:489 kernel/locking/mutex.c:607 kernel/locking/mutex.c:747) 
[  291.052393] ieee80211_sta_rx_queued_mgmt (net/mac80211/mlme.c:6288) mac80211
[  291.052599] ? finish_task_switch.isra.0 (arch/x86/include/asm/paravirt.h:700 kernel/sched/sched.h:1386 kernel/sched/core.c:5138 kernel/sched/core.c:5256) 
[  291.052613] ieee80211_iface_work (net/mac80211/iface.c:1602 net/mac80211/iface.c:1658) mac80211
[  291.052792] ? __pm_runtime_suspend (drivers/base/power/runtime.c:1128) 
[  291.052807] cfg80211_wiphy_work (include/net/cfg80211.h:5789 net/wireless/core.c:442) cfg80211
[  291.052889] process_one_work (kernel/workqueue.c:2632) 
[  291.052894] worker_thread (kernel/workqueue.c:2694 (discriminator 2) kernel/workqueue.c:2781 (discriminator 2)) 
[  291.052897] ? __pfx_worker_thread (kernel/workqueue.c:2727) 
[  291.052900] kthread (kernel/kthread.c:388) 
[  291.052905] ? __pfx_kthread (kernel/kthread.c:341) 
[  291.052909] ret_from_fork (arch/x86/kernel/process.c:153) 
[  291.052913] ? __pfx_kthread (kernel/kthread.c:341) 
[  291.052917] ret_from_fork_asm (arch/x86/entry/entry_64.S:314) 
[  291.052922]  </TASK>
[  291.052923]
================================================================================
```

I can reproduce it fairly easily when changing wifi adapters and
toggling connecting to an AP.

(It was a fun mini-adventure to get the trace usable and I should send
some patches to decode_stacktrace.sh, I think...)

thanks,
sam

