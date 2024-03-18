Return-Path: <linux-wireless+bounces-4862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548987EF77
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 19:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3701F21F30
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 18:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC4D55C3F;
	Mon, 18 Mar 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnhcRFeZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A755C0E
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785353; cv=none; b=T//Kc6bN8knW4Lqi7x7+uPZm8lgEVXbAWDsHweKYboG7fWf1cSuiLa1+3zWSudiNMfMgDRPiE5AQJoFbY17/GuJG5XaH6ROGF/ap1IAUoyxPHoZ5kyErsk/2VzhLjjlkZFFXj38W1mhUuU69K5pcLq10EoMnXek6pA6RkQ07SFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785353; c=relaxed/simple;
	bh=wIWY0HA295G/NniJe/M6mx6znfKdYejU/U7bItnmyzM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tJP+aWq4lybOWoAejfPOxckbg0oQCT1SatojMcLqrYdhMCzlLIonwTeLvpwq+kxNXfzeiI74EHSWZIsQMXD+FfQIj2r9D9Ie7fK6HOiHdcvo1/ThLrLyttXNMUKOwXdP8v/zTc0ybC2zgU+1XzJVVMOppir11Qg1F1zEAVcm1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnhcRFeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B099C433F1;
	Mon, 18 Mar 2024 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710785353;
	bh=wIWY0HA295G/NniJe/M6mx6znfKdYejU/U7bItnmyzM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WnhcRFeZsxvIVnPe9XGGfP0m+q1vpn2LReoEfvCXZDxOF6ad8REFmAxDW8PA9BkEl
	 o4KwSrZ3fFk67B3ZCsewSz2OGSEO/1zwAhJ1MvIK547qnWrtVqVrwFhVj1RyrZ83qz
	 PpkMZeFifAIK3F3HEO7P4eJGTUexrb8/gObdwwH0whwQrXaguS++eT1/2uqwQN2YsJ
	 9vPWhJJvI6V8TXJLf+8Uvr310J+hzk1P8fH9uvtOWrm/4sKpwa/iUreifDpx+2PCr8
	 KTE0V+KdgqqolvOtWVlUcVkAvfkwkVQW7TXsRi7k/Kw85XIUnDbnvR1QzSibPPdqGo
	 E7HDXQAdsChYw==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/3] wifi: ath12k: Optimize the lock contention of used
 list in Rx data path
References: <20240226162310.629162-1-quic_periyasa@quicinc.com>
	<20240226162310.629162-3-quic_periyasa@quicinc.com>
	<87msr4gbps.fsf@kernel.org>
	<33d25f11-d54d-6161-383d-d3823d5f6d19@quicinc.com>
Date: Mon, 18 Mar 2024 20:09:11 +0200
In-Reply-To: <33d25f11-d54d-6161-383d-d3823d5f6d19@quicinc.com> (Karthikeyan
	Periyasamy's message of "Mon, 11 Mar 2024 19:25:10 +0530")
Message-ID: <874jd3cszc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> On 3/11/2024 6:35 PM, Kalle Valo wrote:
>> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>>
>>> When a packet arrives in Rx rings, the RX descriptor moves from the used
>>> list to the free list. Then, the rxdma ring gets replenished, where the Rx
>>> descriptor again moves from the free list to the used list. At the end, the
>>> descriptor came to the used list with unnecessary list movement. The
>>> descriptor used list is maintained in the Rxdma ring structure, which
>>> creates lock contention for the list operations (add, delete) in the Rx
>>> data path. Optimize the Rx data path by removing the used list from the
>>> common Rxdma ring and maintain as a local variable in the Rx ring handler
>>> itself, which avoid lock contention. Now, to find the used list descriptor
>>> during descriptor cleanup, we need to check the in_use flag for each Rx
>>> descriptor.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> Before looking at this in detail: When optimising something it would be
>> good to have before and after numbers showing the improvement. Otherwise
>> it's just wishful thinking.
>
> I don't have numbers. Like you said, Its just a wishful think.

So do you still want us to take this?

In the future please do provide numbers to show that the optimisation
really helps as intended. Otherwise we might even go backwards.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

