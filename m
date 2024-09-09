Return-Path: <linux-wireless+bounces-12689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DCC97213B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75FA282394
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117EC16F0F0;
	Mon,  9 Sep 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKm1U9H0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1520B04
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903633; cv=none; b=gtt6W0RhHfAR4DPG2w17nXALtO5ozlKYcHMjQj7cH+tNOep/FLhDJvON+4W7hzeTqpvfyKHDrDJbuGKLMZIChjecssNi2q0LRqRbJrB0rzJr9eTHxyOztw3kKAWZZZiodeJa/r4NMAvv3L5CI8SZbmVN0dP5weHSuJS367fel+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903633; c=relaxed/simple;
	bh=AtmZVGQ1z32CRVXcR1nEktBUb28OAe2Lo7zj4Sh7yw0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Bbcfd80d8u5+wDoPq2SVvCdTgPi8avzI7px+mdOsom9DUn2ictm0RRMKPQ/efRqKpD5A4+ojNbu28Lv9xumY5BSZzSCmsh52IuOI05n7xAKe6HufDjLA2QdcWHGRo2IZn4Oc8zrtxOlgyI3Pzk7R/v+R8FRDcJ20q8duXsmmZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKm1U9H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7F7C4CEC5;
	Mon,  9 Sep 2024 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725903632;
	bh=AtmZVGQ1z32CRVXcR1nEktBUb28OAe2Lo7zj4Sh7yw0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=HKm1U9H0EHhag0g5R13J65bO/jr33meW90Ak1eN73Dzsxh5eYMGFN8+dixJQH9I0r
	 Qf5U4qmWbuAxYKY/CL7nVBsXC72hvT4WcKutBw9jMsh28mE1rfBoMXKeWmijSPFEN0
	 PHWqJCsNou61Sdn/mRzN7FE7sBcWfDUzb5RNOqKtdgyh7vmwOIxhstws5b08vu6KW9
	 KGv6wiSQ3Cxx3Y/LlprFalQGvqn1SCfebYyfsRfKW9Mw3nDDan+nALJgk6rc/Vh7I+
	 ipoUyJJFmbNF9Jjzc2dUFOdLYl1o9AW42oEcG6OpewyKda4kVXkAlGMHW4z8x/ohFi
	 BtF0oZicOV8/Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ath-next-20240909
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <13914e4d-92d4-4ccd-a7d5-86c5a17426e8@quicinc.com>
References: <13914e4d-92d4-4ccd-a7d5-86c5a17426e8@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
 <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
 <quic_jjohnson@quicinc.com>, <quic_kvalo@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172590362906.2257202.15489777283532077082.kvalo@kernel.org>
Date: Mon,  9 Sep 2024 17:40:30 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The following changes since commit ae98f5c9fd8ba84cd408b41faa77e65bf1b4cdfa:
> 
>   Merge tag 'ath-next-20240812' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2024-08-13 12:58:32 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20240909
> 
> for you to fetch changes up to 02f454f9aa6255d99611d6a4e37edd08812878df:
> 
>   wifi: ath12k: Avoid -Wflex-array-member-not-at-end warnings (2024-09-05 19:20:21 +0300)
> 
> ----------------------------------------------------------------
> ath.git patches for v6.12
> 
> This is once again a fairly light pull request since ath12k is still
> working on MLO-related changes, and the other drivers are mostly in
> maintenance mode.
> 
> ath12k
> 
> * Fix a frame-larger-than warning seen with debug builds
> * Fix flex-array-member-not-at-end warnings
> 
> ath11k
> 
> * Fix flex-array-member-not-at-end warnings
> 
> ath9k
> 
> * Fix a syzbot-reported issue on USB-based devices
> 
> ----------------------------------------------------------------
> Gustavo A. R. Silva (2):
>       wifi: ath11k: Avoid -Wflex-array-member-not-at-end warnings
>       wifi: ath12k: Avoid -Wflex-array-member-not-at-end warnings
> 
> Miaoqing Pan (1):
>       wifi: ath12k: fix the stack frame size warning in ath12k_mac_op_hw_scan
> 
> Toke Høiland-Jørgensen (1):
>       wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit
> 
>  drivers/net/wireless/ath/ath11k/core.h   |  8 ++++-
>  drivers/net/wireless/ath/ath11k/dp.h     | 23 --------------
>  drivers/net/wireless/ath/ath12k/core.h   |  8 ++++-
>  drivers/net/wireless/ath/ath12k/dp.h     | 12 -------
>  drivers/net/wireless/ath/ath12k/mac.c    | 54 ++++++++++++++++++--------------
>  drivers/net/wireless/ath/ath9k/hif_usb.c |  6 ++--
>  6 files changed, 46 insertions(+), 65 deletions(-)

Pulled, thanks.

fe57beb026ef Merge tag 'ath-next-20240909' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/13914e4d-92d4-4ccd-a7d5-86c5a17426e8@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


