Return-Path: <linux-wireless+bounces-35239-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOX+Eyuf6WkAfQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35239-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 06:25:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B544CEDB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 06:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 687D63009810
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 04:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F031F99A;
	Thu, 23 Apr 2026 04:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="SqG03su8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E9244687
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917752; cv=none; b=XIJV623DrGGHnioMrxRbIFPPO+m+/rzj0wB0aXkkcWSZUF/V77AW91lT32ve9+qoQD4ZwqFIITk+y92+UQwlPGJHdUBTgs7G8Wzv88qU5nu/Iq/eqnw20J2Y7oYTWaqbZ9EaftzBMpB3n39+zijH9+MmLxQXo8k43RHCujfBOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917752; c=relaxed/simple;
	bh=Qz70XQWqkjFL1n7DMKpRt8RNanc3bCYxPXKEjrvC0wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLZs/g5Rc+IZF/cqR71ROWZMwOzTS1Rj+Bmv4+6mwzgIL7+BNlUlsAblUrsSK+xv6wNCWEXBMQNMIIDVW3U79CYgzxGT+x6ex/LeeVR0Zw3Hyibh14udb17mHCeA2wJN9LnTyYGJNZ1Okm89Yvh+m3CNI1VgZZNe7j2j3Z1296A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=SqG03su8; arc=none smtp.client-ip=202.108.3.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1776917750;
	bh=kXgg4bK6ZCKpzRg3Eg2FXeTLIzhmAY6ilX5qNb/Q9O0=;
	h=From:Subject:Date:Message-ID;
	b=SqG03su8vTDM2a6vC9R7i1Dxmmu495uFHpfqHuk1WURgycUOPXgzO+mKq2BPtRkNU
	 rMq/0B7Q3zmXGI3MmOsuihcs7EjolLxbWs92dKn7ENmErV4ivfTj+Gk+XLbtbvgg1U
	 ZAwuUvIa0us5op4pDVa+N4DSqmX4VGvHfs0g3LEA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 69E99CCB000034DA; Thu, 23 Apr 2026 12:15:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 553076291788
X-SMAIL-UIID: 3D56BE0CC2034011917CE9A522D806FC-20260423-121509-1
From: Hillf Danton <hdanton@sina.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: rsi: fix kthread lifetime race between self-exit and external-stop
Date: Thu, 23 Apr 2026 12:14:58 +0800
Message-ID: <20260423041500.2020-1-hdanton@sina.com>
In-Reply-To: <20260422173846.37640-1-aha310510@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35239-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,5de83f57cd8531f55596];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sina.com:dkim,sina.com:mid]
X-Rspamd-Queue-Id: 054B544CEDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 02:38:46 +0900 Jeongjun Park wrote:
> RSI driver use both self-exit(kthread_complete_and_exit) and external-stop
> (kthread_stop) when killing a kthread. Generally, kthread_stop() is called
> first, and in this case, no particular issues occur.
> 
> However, in rare instances where kthread_complete_and_exit() is called
> first and then kthread_stop() is called, a UAF occurs because the kthread
> object, which has already exited and been freed, is accessed again.
> 
Alternatively the race could be described with the regular diagram to better
understand the uaf.

	rsi_kill_thread()	rsi_tx_scheduler_thread()
	---			---
	atomic_inc(&handle->thread_done); // set the done flag
 	rsi_set_event(&handle->event);

				do {
					something;
				} while (atomic_read(&common->tx_thread.thread_done) == 0);
				// exit after done
				kthread_complete_and_exit(&common->tx_thread.completion, 0);

	kthread_stop(handle->task); // uaf

> Therefore, to prevent this with minimal modification, you must remove
> kthread_stop() and change the code to wait until the self-exit operation
> is completed.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69e5d03b.a00a0220.1bd0ca.0064.GAE@google.com/
> Fixes: 4c62764d0fc2 ("rsi: improve kernel thread handling to fix kernel panic")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  drivers/net/wireless/rsi/rsi_common.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/rsi/rsi_common.h b/drivers/net/wireless/rsi/rsi_common.h
> index 591602beeec6..3cdf9ded876d 100644
> --- a/drivers/net/wireless/rsi/rsi_common.h
> +++ b/drivers/net/wireless/rsi/rsi_common.h
> @@ -70,12 +70,11 @@ static inline int rsi_create_kthread(struct rsi_common *common,
>  	return 0;
>  }
>  
> -static inline int rsi_kill_thread(struct rsi_thread *handle)
> +static inline void rsi_kill_thread(struct rsi_thread *handle)
>  {
>  	atomic_inc(&handle->thread_done);
>  	rsi_set_event(&handle->event);
> -
> -	return kthread_stop(handle->task);
> +	wait_for_completion(&handle->completion);
>  }
>  
>  void rsi_mac80211_detach(struct rsi_hw *hw);
> --
> 

