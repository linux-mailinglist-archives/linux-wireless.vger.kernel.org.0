Return-Path: <linux-wireless+bounces-20509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0773A67CBE
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 20:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96093ACEB3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 19:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C79213E91;
	Tue, 18 Mar 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/wtmQ61"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478720E700;
	Tue, 18 Mar 2025 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324810; cv=none; b=LhyxC5AtJ3Obb8uknt86EcyIjRPAgdY+FHtPL4qgv27LPohGqi7s4mroBgWKrdKMT1UhhTiocdqW72dFOr/t5M0hqd9rItj9ejACfTpQLp0vfwLQzxJFG5/5H1ozrXyz4212NSHjFuieazZ5P5A4D05j3bji94luW54fhIAU8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324810; c=relaxed/simple;
	bh=Xo5w1fx9yvRmBVej5qr8t/m8llPrRxNN35gLhLhf/8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbfPeH1whBSS71bLQL+ycaS3zGfmdOiBukRmogi33qykNP9fGgKt2kna2MA4IJ7LxRlK0Z8goCzPgr31ztg+BqwuJJCE3PeDKL8Vag3AjgenDPGZPPJSipeH/cQV+Q1vmdPXQTeqr4ACQ+Ax4KAbHzRmyQb2/u10j0P3Mlii9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/wtmQ61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91A8C4CEDD;
	Tue, 18 Mar 2025 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742324809;
	bh=Xo5w1fx9yvRmBVej5qr8t/m8llPrRxNN35gLhLhf/8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m/wtmQ6123dkhN20PPZUKcDaUe48XA3jubeidCAbi0E238GS9iK/uc0x5s9j8UEW9
	 e7EXau+ZS8E6Ey5qFh9NiY40AaJ6CQ47P7Q7Qgxt+uI7hji5iRHVI88zhn8qXQWuea
	 8C+TlzvFsMoP9V/QjZCFWv2sb5gucvY8n69AuDisXeWc1TotQbHdVgmyz1o+OxSGK7
	 KpY2PMBsdBQ73fpTu+VbQji/rqAp7McOLWjdW+o9n203i/sSzkqN1SR4ULHQvIJT4A
	 VWAV7gcwGGK1WJwX5j6vl2fH0sj896NgakfnN2bbWSaKc1wdZrc47ZUg2Kr1t0td7+
	 mfiq4z+vQQOfw==
Message-ID: <551018bc-26e2-47f4-8fcc-9478834b9199@kernel.org>
Date: Tue, 18 Mar 2025 20:06:42 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v11 08/13] wifi: ath12k: add AHB driver support
 for IPQ5332
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Balamurugan S <quic_bselvara@quicinc.com>,
 P Praneesh <quic_ppranees@quicinc.com>,
 Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
 <20250317204639.1864742-9-quic_rajkbhag@quicinc.com>
 <683b16dd-a3e9-4cc3-836a-95f3747d3c0a@oss.qualcomm.com>
 <0da16aae-2fa3-49a4-bdd3-f08a7655365f@kernel.org>
 <f35a6080-8dbd-45ca-8fb4-d6b01a5bb007@oss.qualcomm.com>
 <332db13c-81db-42ad-afcf-3a4262344bf2@kernel.org>
 <31b4ca9c-892a-4ba5-b006-95deed6deceb@kernel.org>
 <8e5b0ae1-ea1b-4dfa-84dc-c53edd2afc42@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <8e5b0ae1-ea1b-4dfa-84dc-c53edd2afc42@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2025 19:53, Jeff Johnson wrote:
> On 3/18/2025 11:19 AM, Krzysztof Kozlowski wrote:
>> On 18/03/2025 19:16, Krzysztof Kozlowski wrote:
>>> On 18/03/2025 18:55, Jeff Johnson wrote:
>>>> On 3/18/2025 8:50 AM, Krzysztof Kozlowski wrote:
>>>>> On 18/03/2025 16:44, Jeff Johnson wrote:
>>>>>> On 3/17/2025 1:46 PM, Raj Kumar Bhagat wrote:
>>>>>>> +	hw_rev = (enum ath12k_hw_rev)of_device_get_match_data(&pdev->dev);
>>>>>>
>>>>>> kernel test robot warns:
>>>>>> cast to smaller integer type 'enum ath12k_hw_rev' from 'const void *'
>>>>>>
>>>>>> looks like others have fixed this by first casting to (uintptr_t)
>>>>>> a few examples:
>>>>>>
>>>>> Cast via (kernel_ulong_t)
>>>>>
>>>>> But another point is that this patch at stage v11 should not have
>>>>> compiler warnings and it's not our tools who should point it out. Except
>>>>> W=1, all standard static analyzers (sparse, smatch and coccinelle) are
>>>>> expected to be run.
>>>>
>>>> I ran what I thought was a reasonable cross-section of builds and did not see
>>>> this issue. Seems this issue is only flagged with config: um-allmodconfig ??
>>>>
>>>> Guess I need to add that configuration to my builds...
>>>
>>> This should be visible on every build on 32 bit archs.
> 
> Yes, I'm seeing it now on my i386 builds
> 
>> Patchset does not apply neither on next nor on on mainline, so cannot
>> verify... Probably another problem to solve here - some sort of dependency?
> 
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
> 
> The series should apply cleanly on ath.git ath-next branch


Yeah, but next is fed with for-next branch, not ath-next.... and
for-next is 10 days behind ath-next. I assume for-next is what you send
to the next merge window and ath-next is rather next-next-merge window,
just like DRM people are doing?

Best regards,
Krzysztof

