Return-Path: <linux-wireless+bounces-12650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4349713B4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 11:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A901C22A37
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B8F1B5303;
	Mon,  9 Sep 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="lvZPoacw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D661B3746;
	Mon,  9 Sep 2024 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874185; cv=none; b=sv5rde9WAdJKzEohA1+/Sc4xSZQN2RJAxMWMfaaswzC8TOqZH2D0J7iMskZm8QYpLHfM5pjzUN/rpBweBNYdp3iG3vykrxAnquEJrRmafyN5N5Two2E2sJMDw/nl4+uXRMuCdlqrQPZY7oTtaiYHdsJ+SNqHYCwjkH87k8WjW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874185; c=relaxed/simple;
	bh=muUEXAvbIq0DbFUN2mAlt0pOR9Csq+RMxXJJ+FkpbGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gFNkTHedN4fdGqQvBydY9eSaYv7mjneX26bInLs4ClF8TsIFsi/10WoUkwiQQSPBcW/o1yhyfzP35G8jgEmq4xSUFLxwhvNCT0R2cvxpNZ4C09k5eNHYFFG6lTY5ahXnUmMz21JwHvC8oBtdIcIo+t9pAE3E3sXfFnHRpG0Z/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=lvZPoacw; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1725874170; bh=muUEXAvbIq0DbFUN2mAlt0pOR9Csq+RMxXJJ+FkpbGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lvZPoacwobMjIrF/0XTNZIFuM+STgRZd+DJXgtSx/9WGndgLv4BVhFig9fI3yCSYD
	 /s2skfVAPHpUDKx34zcURIdNUChrRIieLJeDRDA4iDtawvYA41mhh+sxJymLlKV2rK
	 hPinZj3plzxiIBwdV3Iehtx60KXVu4Vyz5y999mmKIuzaIwy6/WOr8/AEHo/AbdeCB
	 vSQcb2/0y1XwHN6UPSH6qMn3jAH8Zs/P9g+WBQSj5pKpTIAGwIPHLnKmGDqjOPFvRk
	 7CnsKYNv+oUE/3ShgBrf8zJBEXE/bfqEQ89OSU6g2x/+SFBbfC1xINwydYtx1LE+NP
	 uNPpNmO+ZdF1A==
To: Jeongjun Park <aha310510@gmail.com>, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Jeongjun
 Park <aha310510@gmail.com>
Subject: Re: [PATCH] wifi: ath9k: add range check for conn_rsp_epid in
 htc_connect_service()
In-Reply-To: <20240906142452.144525-1-aha310510@gmail.com>
References: <20240906142452.144525-1-aha310510@gmail.com>
Date: Mon, 09 Sep 2024 11:29:30 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875xr5qio5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeongjun Park <aha310510@gmail.com> writes:

> I found the following bug in my fuzzer:
>
>   UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_hst.c:26:51
>   index 255 is out of range for type 'htc_endpoint [22]'
>   CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.11.0-rc6-dirty #14
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>   Workqueue: events request_firmware_work_func
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x180/0x1b0
>    __ubsan_handle_out_of_bounds+0xd4/0x130
>    htc_issue_send.constprop.0+0x20c/0x230
>    ? _raw_spin_unlock_irqrestore+0x3c/0x70
>    ath9k_wmi_cmd+0x41d/0x610
>    ? mark_held_locks+0x9f/0xe0
>    ...
>
> Since this bug has been confirmed to be caused by insufficient verification 
> of conn_rsp_epid, I think it would be appropriate to add a range check for 
> conn_rsp_epid to htc_connect_service() to prevent the bug from occurring.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  drivers/net/wireless/ath/ath9k/htc_hst.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
> index eb631fd3336d..aedba5f79bfb 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_hst.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
> @@ -293,6 +293,8 @@ int htc_connect_service(struct htc_target *target,
>  			service_connreq->service_id);
>  		return -ETIMEDOUT;
>  	}
> +	if (target->conn_rsp_epid < 0 || target->conn_rsp_epid >= ENDPOINT_MAX) 
> +		return -EINVAL;

nit: please add a blank line after the }, and get rid of the extra space
at the end of the line with the if statement.

Otherwise, the patch LGTM.

-Toke

