Return-Path: <linux-wireless+bounces-14249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 217869A5F2F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0662B24ADB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9203E1E22F9;
	Mon, 21 Oct 2024 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adE2+KTy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFC1E1C10
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500644; cv=none; b=L5pvDKmL8L63wSd/njAqlNQEj7+ynJUrCAELFkP12KglRRLAuNoPBWJqk07lWnI8z12CFbnmCcwLdrg/GReFMZIHKP88xckvr0PIAkvCrnxxh+zqXF/wIszqT4UKMKnuRIvvhltcK/qqDV78Sr7qPW8ahe1ruin4D3i11sI4q+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500644; c=relaxed/simple;
	bh=3YaSTT+stxn3bZ4gbBZDptrOG0BxVJxtFbkNlEAnLXU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bPTPozV3ME5EBGSDFs5R37biJzgfZfuqv7nr+fHVvSbdi7rpuPK02Ksfl0mHwLHlFtAggrEDZeCMbK2Hm/p7Pc5uthTvRuqQh3HUt4T7lTxUFicyPyKZ2lkyDO6DO/xYG+fWGbSp2/wJ8dp92sTHemDIZYUOXvw8uIEMw+Ttp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adE2+KTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386A6C4CEC3;
	Mon, 21 Oct 2024 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729500644;
	bh=3YaSTT+stxn3bZ4gbBZDptrOG0BxVJxtFbkNlEAnLXU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=adE2+KTyQ01skbGHzPYI/+Zl1WXRSTGsqPX1JNY3taGXXogqYYGRxdD3iMER/Trt4
	 SLoPt4kilPn7F5AS6SWO91DbewCUvqGDKp0JjkQHITzlchn35Sz1glnp0MwELoHg7l
	 eUgX2511BB8AzjsqeJSH6bhLO6z9LeOzyyNXpKGqB/p9EVNBQOGHgkED+S37NH+0mW
	 ul2i6AXuIpGPUFqB1//q5yth0xor+4q6qq1ufQ7ByydaolRshKzCn7/g78pxYW5MZg
	 jQQoZAU7ux95U8/0V9/j++x2q/npjCiW9+vK0xTv1IfJBBFKcGMQ3VLcPG7m/dMa0n
	 xEotvTZ9p/IgQ==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 03/11] wifi: ath12k: fix struct
 hal_rx_ppdu_end_user_stats
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
	<20241016065700.1090-4-quic_kangyang@quicinc.com>
	<875xplrgj5.fsf@kernel.org>
Date: Mon, 21 Oct 2024 11:50:41 +0300
In-Reply-To: <875xplrgj5.fsf@kernel.org> (Kalle Valo's message of "Mon, 21 Oct
	2024 11:45:02 +0300")
Message-ID: <87sespq1pa.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Kang Yang <quic_kangyang@quicinc.com> writes:
>
>> Current struct hal_rx_ppdu_end_user_stats in hal_rx.h is not matched
>> with hardware descriptor definition.
>>
>> So update this structure and related code.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>
> What about QCN9274? The commit message doesn't mention anything about
> that.

I have the same question for patches 3-6. Also I would like to
understand the backwards compatibility with older WCN7850 firmwares.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

