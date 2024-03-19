Return-Path: <linux-wireless+bounces-4918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B735C88029B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 17:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E945A1C222C5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B09101EB;
	Tue, 19 Mar 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcFwo+8y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A4101D4
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866655; cv=none; b=XD35oLVocTc0nK+OiPbbm0i2z9uLk6dx7qC6p1kVuhuoCfA6AltczlhHU5ICphG/HuwUU2z8jWnFj1rxFMnZ6ldCqRI+rKrQSADw3G0K2D3LFnJqiD8Iy8a2UA7yvBTTGAbQ9mQv4pHCxY/R0v1gxqJKb6UJepuM22om8zmIM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866655; c=relaxed/simple;
	bh=BhQ1Cx52fdlhWCQ7Y100sxJZR3YCJfSLoeqDBDgxTu8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IY7KrhPFlKdOIhwKYL8XLMfIYsQynO40RLDR5aAQn66psXuVVheRub5dpmKmg+dIK65rCJPyiquQfs1vfbRKaZBxh/5L1Ow5+wlwvmnSlJ8pf+8cdeZH2r4a00VQNLyZCQNujkbrXv2TThnCcIbdVuIaYZNEi0E9w1yljhO0rn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcFwo+8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CA5C433F1;
	Tue, 19 Mar 2024 16:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710866654;
	bh=BhQ1Cx52fdlhWCQ7Y100sxJZR3YCJfSLoeqDBDgxTu8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ZcFwo+8yzt83BDjt2w3N5cCgflUR6SodzRnTahJMG9bZxc+FDVacu3Xt+sMtgvukW
	 ml16TFCOjQwNpR2PTnGGSaVQKFChRhbMo2vCBGQLADSzgpcIqafsc1EDz3579moeUH
	 m4LBBQ2RRnu3y8NKoXv0+YoKQQm8oUhRd7ppQUVHHxEiY2ebmKqh/1+h3JGsYdj6wo
	 ipw5jRSWuNxcENaxydIX+Dck3GJtqBBm/aEAI6kuBehmfN3HJGaNff7VUyOwbCLOeL
	 FJqtOwLKwyGiaoNW+lVJzpWvvZ/yhyrufXqp7zAQV6S3TCYG9d+gemnfu3U2//qUEq
	 I8RvwAwh0hySQ==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/3] wifi: ath12k: Optimize the lock contention of used
 list in Rx data path
References: <20240226162310.629162-1-quic_periyasa@quicinc.com>
	<20240226162310.629162-3-quic_periyasa@quicinc.com>
	<87msr4gbps.fsf@kernel.org>
	<33d25f11-d54d-6161-383d-d3823d5f6d19@quicinc.com>
	<874jd3cszc.fsf@kernel.org>
	<1e9c36d9-0a2a-e458-a727-9630746b24e7@quicinc.com>
Date: Tue, 19 Mar 2024 18:44:11 +0200
In-Reply-To: <1e9c36d9-0a2a-e458-a727-9630746b24e7@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 19 Mar 2024 15:07:50 +0530")
Message-ID: <87il1ib290.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> On 3/18/2024 11:39 PM, Kalle Valo wrote:
>
>> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>>
>>> On 3/11/2024 6:35 PM, Kalle Valo wrote:
>>>> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>>>>
>>>>> When a packet arrives in Rx rings, the RX descriptor moves from the u=
sed
>>>>> list to the free list. Then, the rxdma ring gets replenished, where t=
he Rx
>>>>> descriptor again moves from the free list to the used list. At the en=
d, the
>>>>> descriptor came to the used list with unnecessary list movement. The
>>>>> descriptor used list is maintained in the Rxdma ring structure, which
>>>>> creates lock contention for the list operations (add, delete) in the =
Rx
>>>>> data path. Optimize the Rx data path by removing the used list from t=
he
>>>>> common Rxdma ring and maintain as a local variable in the Rx ring han=
dler
>>>>> itself, which avoid lock contention. Now, to find the used list descr=
iptor
>>>>> during descriptor cleanup, we need to check the in_use flag for each =
Rx
>>>>> descriptor.
>>>>>
>>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>>>
>>>>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>>> Before looking at this in detail: When optimising something it would be
>>>> good to have before and after numbers showing the improvement. Otherwi=
se
>>>> it's just wishful thinking.
>>> I don't have numbers. Like you said, Its just a wishful think.
>> So do you still want us to take this?
>>
>> In the future please do provide numbers to show that the optimisation
>> really helps as intended. Otherwise we might even go backwards.
>
> This is a simple UDP UL throughput test case results on x86+NUC device
> with QCN9274 card
>
> Before:
> Average:=C2=A0=C2=A0=C2=A0=C2=A0 CPU=C2=A0=C2=A0=C2=A0 %usr=C2=A0=C2=A0 %=
nice=C2=A0=C2=A0=C2=A0 %sys %iowait=C2=A0=C2=A0=C2=A0 %irq=C2=A0=C2=A0 %soft
> %steal=C2=A0 %guest=C2=A0 %gnice=C2=A0=C2=A0 %idle
> Average:=C2=A0=C2=A0=C2=A0=C2=A0 all=C2=A0=C2=A0=C2=A0 0.24=C2=A0=C2=A0=
=C2=A0 0.00=C2=A0=C2=A0 12.54=C2=A0=C2=A0=C2=A0 0.08=C2=A0=C2=A0=C2=A0 0.00=
 23.33=C2=A0=C2=A0=C2=A0
> 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0 63.81
>
> After:
> Average:=C2=A0=C2=A0=C2=A0=C2=A0 CPU=C2=A0=C2=A0=C2=A0 %usr=C2=A0=C2=A0 %=
nice=C2=A0=C2=A0=C2=A0 %sys %iowait=C2=A0=C2=A0=C2=A0 %irq=C2=A0=C2=A0 %soft
> %steal=C2=A0 %guest=C2=A0 %gnice=C2=A0=C2=A0 %idle
> Average:=C2=A0=C2=A0=C2=A0=C2=A0 all=C2=A0=C2=A0=C2=A0 0.34=C2=A0=C2=A0=
=C2=A0 0.00=C2=A0=C2=A0=C2=A0 4.60=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=
 0.00 19.59=C2=A0=C2=A0=C2=A0
> 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0 75.47
>
> is it fine to capture in the commit log ?

Thanks, exactly something like that helps to show that the optimisation
is helping. Please also include your analysis of the results in the
commit message.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

