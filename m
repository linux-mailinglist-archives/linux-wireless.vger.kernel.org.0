Return-Path: <linux-wireless+bounces-16293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B089EE094
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 08:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50ED91613DF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 07:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE3A188591;
	Thu, 12 Dec 2024 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMPU8K/l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF3259483
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989798; cv=none; b=jsZSW2a/+QLKyOB3j1YEHuNKeHSZDbwzLcJqyz/yjpZEBVBufdWQU/Znt1R3EJcnrqwBXtJ/SaosentaVGUn4q/lGrE9fS9WfxLqDy9uDprhKpansGm0jjbB2t+l74B+TVFgB+RVMV2HftmQs6IiG/Aou7MpwLVqCri8RKRJ8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989798; c=relaxed/simple;
	bh=oK4GaQ1I1rVikWsU34y8VDLGduzZeeugS+Q8BX5oGIc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KGcR/FTfQQQnZ9q3VuGgXeBmKPGgr4i2uUMZn8Cagx/RxHw4C5yOWXbpfsx9/Og+Ick8wzUDVFTsHA9bz6Y2mBt0WCDSe7Wzm+hAzj2ozJGvFgDEGKHUbRmrIHiNJLWcspaU1+gDOmVUNh5BH+ez3OmT/vELBpr0WLN93e6/4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMPU8K/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19335C4CED1;
	Thu, 12 Dec 2024 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733989798;
	bh=oK4GaQ1I1rVikWsU34y8VDLGduzZeeugS+Q8BX5oGIc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KMPU8K/lrCCJImylDX3qwLHipCqV0bklFnA20+U2BJHUif20tKo90guHebZjZWVoG
	 o0FoCmaddvzPbeGF2vpWv+Vp/oEnsYWlZVRKFCbahoCISedJav9SPCPwPGqFMUQBnY
	 aybpurCS+RR8tiDYGSSBG7q1TO0Jo7VWVHpqDAfJXvXTnE+ARflnoNqZTFVX9C6X1k
	 9jkDSTY+2ZgBojl4UPvk3p25pGq36Tvq+bBnmU16R1MsOz3uvdZceZuDKhasbTtsGZ
	 NGHM1ek+5dv1z9fqc1C6AJAlEkrSLc/TDtXVAwXyX10diDh/X5wi5L1L10/FZ4UJqO
	 K9nJs84/IUZLg==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 3/4] wifi: ath12k: Refactor ath12k_get_num_hw() helper
 function argument
References: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
	<20241212004906.3087425-4-quic_periyasa@quicinc.com>
Date: Thu, 12 Dec 2024 09:49:55 +0200
In-Reply-To: <20241212004906.3087425-4-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Thu, 12 Dec 2024 06:19:05 +0530")
Message-ID: <87zfl1pcgs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, the ath12k_get_num_hw() helper function takes the device handle
> as an argument. Here, the number of hardware is retrieved from the group
> handle. Demanding the device handle from the caller is unnecessary since
> in some cases the group handle is already available. Therefore, change this
> helper function argument from the device handle to the group handle. This
> also fixes the below Smatch static checker warning.
>
> Smatch warning:
> ath12k_mac_destroy() error: we previously assumed 'ab' could be null
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/ath12k/3e705de0-67d1-4437-97ff-4828d83ae2af@stanley.mountain/
> Closes: https://scan7.scan.coverity.com/#/project-view/52682/11354?selectedIssue=1602340
> Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

I don't get how this is any better but of course I might be missing
something. To me this looks like shuffling code around to shut up a
smatch warning.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

