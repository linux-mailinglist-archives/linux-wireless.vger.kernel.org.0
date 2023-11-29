Return-Path: <linux-wireless+bounces-215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C47FD5A7
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 12:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4E728326C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 11:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A61C68A;
	Wed, 29 Nov 2023 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkEuqTlp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959CA156CD
	for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 11:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC5FC433C9;
	Wed, 29 Nov 2023 11:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701257344;
	bh=TKTcP6093uefYpxtij2HyGfmUbAKixrSV0niW+6OUUQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=bkEuqTlpb4DohnHlVwfICDYRKpKzy2y2L2zbNdlTwJAt2AsBgR/UBHDQCcvFXgoTO
	 IAFvUgitmVRu5oEVjiWWoFJGT9iruq/+t2ux5om+Csw7qzZlQeZqUYI8xcSHj23Z61
	 UOxWHxCuCsT49vadF8EIHN3Z7j6rry+EY9KYZFyZA8Y38utLVLwxc95m0g9Upyx8jx
	 WWmGC6mZZ/sitSHZBZ/+g8a23g3UXn0zxZkRIHrnpxiycidxqTyKSTBOi79vIej77r
	 6yIl9HBIg44/605edeqp7ZVXnn8KDKs+aU+wMpTDk7pSqeJHJXkXcPiUpcqI88bY/E
	 qA/FLZ8avGzLg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] wifi: ath9k: Fix potential array-index-out-of-bounds
 read
 in ath9k_htc_txstatus()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231113065756.1491991-1-linuxlovemin@yonsei.ac.kr>
References: <20231113065756.1491991-1-linuxlovemin@yonsei.ac.kr>
To: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Cc: linux-wireless@vger.kernel.org, toke@toke.dk, dokyungs@yonsei.ac.kr,
 jisoo.jang@yonsei.ac.kr, Minsuk Kang <linuxlovemin@yonsei.ac.kr>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170125734120.1070846.4640976279183534285.kvalo@kernel.org>
Date: Wed, 29 Nov 2023 11:29:02 +0000 (UTC)

Minsuk Kang <linuxlovemin@yonsei.ac.kr> wrote:

> Fix an array-index-out-of-bounds read in ath9k_htc_txstatus(). The bug
> occurs when txs->cnt, data from a URB provided by a USB device, is
> bigger than the size of the array txs->txstatus, which is
> HTC_MAX_TX_STATUS. WARN_ON() already checks it, but there is no bug
> handling code after the check. Make the function return if that is the
> case.
> 
> Found by a modified version of syzkaller.
> 
> UBSAN: array-index-out-of-bounds in htc_drv_txrx.c
> index 13 is out of range for type '__wmi_event_txstatus [12]'
> Call Trace:
>  ath9k_htc_txstatus
>  ath9k_wmi_event_tasklet
>  tasklet_action_common
>  __do_softirq
>  irq_exit_rxu
>  sysvec_apic_timer_interrupt
> 
> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2adc886244df wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231113065756.1491991-1-linuxlovemin@yonsei.ac.kr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


