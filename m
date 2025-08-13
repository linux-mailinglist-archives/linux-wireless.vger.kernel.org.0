Return-Path: <linux-wireless+bounces-26369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF6CB24F40
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 18:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCDB881FA3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 16:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693422820B6;
	Wed, 13 Aug 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWzP51AR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471E28000A
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100848; cv=none; b=LhRQXCN0P1Up+yBum2Zbi5KPMUG3CEpZ06GPQee2FKxakhCdUzFf9xf82YVi8iiKTCjwJ7YSZzLN5a4tc+7mL6AwOxUQX2e9/W4xzzaO9QIQvSyvM47ZURpeDK8qMvAowwbnTcvNvE+pT8o4AAu1HpMsCDp5rdE/LXSL+4IIm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100848; c=relaxed/simple;
	bh=2emd38XphUi6IZy2uLgiRRt37gOsNyuIyf1UAgYALXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXjPs+IrXEMui8uupKRaNjyIbUoRqbpjVQhSXcXkFvtqfkSdxEpaesCA2TMKyR3a9rZTlUfRuXSnIn0AucyIvQcrQjWY6Cu/aFgiyIxceNGBv43dmockStXNCoK1sgeKuuLlXIAq+MvxIUikfCps8VmnK8vzYez5ep7zbYqh1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWzP51AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E725C4CEEB;
	Wed, 13 Aug 2025 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755100847;
	bh=2emd38XphUi6IZy2uLgiRRt37gOsNyuIyf1UAgYALXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jWzP51ARqwHaIaKC56xiZJgCe2jX0VXUDmecpM2U58JHMvXopGI5axzMSw3LDgjOf
	 NeGuUDGyFteH+4Ie6YOvNWmRY1XFalQ5mqGyVhhcF2CurNc8h8IZRhSvIk/HfB1CEz
	 AXV91cLYMiqXl9dRhQIv+VmMHsAWmY61QtepZOIX1DJJ/SJpipmqtkhI4jiWAlRfQk
	 PpmGrCKLq7UhhL9/7DDbE5iIiR3wDy4JkYzZ7QV9EW/A/UZxNRXgHK4ublb7kw8WDy
	 t2K/UZ9K7M2YX4N4iaxiuyDPQo721IigTVA7My7ueKhW8gxEJTKoM53quH3D+PdzPw
	 WU4wHhYXFWSDA==
Message-ID: <f6b046b0-d230-41e6-ab18-686cc7b65f16@kernel.org>
Date: Wed, 13 Aug 2025 18:00:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 03/13] wifi: ath12k: Move Wi-Fi 7 WMI
 configuration to dedicated file
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Kiran Venkatappa <quic_kiranv@quicinc.com>, ath12k@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
 <20250812-ath12k-mod-v1-3-8c9b0eb9335d@quicinc.com>
 <00a72188-8ac7-4527-8128-352d0882754f@kernel.org>
 <b62af6d9-eea1-41d0-997d-b9585f2a9533@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <b62af6d9-eea1-41d0-997d-b9585f2a9533@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2025 17:43, Jeff Johnson wrote:
> On 8/12/2025 10:52 PM, Krzysztof Kozlowski wrote:
>> On 12/08/2025 19:09, Kiran Venkatappa wrote:
>>> +}
>>> diff --git a/drivers/net/wireless/ath/ath12k/wmi_wifi7.h b/drivers/net/wireless/ath/ath12k/wmi_wifi7.h
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..1514e3e8d4cb65d3d95d95a1c1593a7b66abcf58
>>> --- /dev/null
>>> +++ b/drivers/net/wireless/ath/ath12k/wmi_wifi7.h
>>> @@ -0,0 +1,15 @@
>>> +/* SPDX-License-Identifier: BSD-3-Clause-Clear */
>>> +/*
>>> + * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>
>> Don't rewrite the copyrights. Original file had different one. GPL FAQ
>> also EXPLICITLY asks for date in copyrights and does not allow one
>> without the date.
>>
>> (and before you bring internal qcom regulations, let me remind that they
>> do not matter. we discussed this in other thread)
> 
> Wi-Fi team wasn't party to the other thread, and this series was following the
> legal guidance we were given. I'm circling with the core kernel team and the
> legal team to make sure your concerns are resolved.

+Cc Greg,

Please follow legal guidance expressed in:
https://www.gnu.org/licenses/gpl-howto.en.html#copyright-notice

and the license you agreed by signing of the patch:
LICENSES/preferred/GPL-2.0:

"Copyright (C) <year>  <name of author> "
...
"... publish on each copy an appropriate
copyright notice and disclaimer of warranty;"

Just to remind - you as author sign off your patch, not your legal team.

Best regards,
Krzysztof

