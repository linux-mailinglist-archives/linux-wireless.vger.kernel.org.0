Return-Path: <linux-wireless+bounces-15971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159E9E6EAE
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 13:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A67E188343D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2161200109;
	Fri,  6 Dec 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2CHW3jJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115C1F6681;
	Fri,  6 Dec 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489717; cv=none; b=qpBtw/CLPClp0kfZmWBVcFZDBIQOzOLAxsGWZHEQwMVAgLDi8vRPHZI86j1VgJbVYZKGk4r1h3pSq36axou5ZJERfSE3gMMzHVicavcxiQOvcxGQ1B+KRO7gDE52tZALyVeY1MDqGZwzK1O7SSsM0C0IKNStcgtGkF2eY9dVxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489717; c=relaxed/simple;
	bh=ut+n6OkeEePipWNKkILbIw1fd3nezu+R13ATMigoLes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJYgtcdXOpv82c190+qk0d060Da8ZKkJCz1BXIaKxt/XgIp7O+mg7J7WGTeFL7xLht27UAGb0+6sqkyH+AJ7bN+rkdgMYJ/VbKWJAaGTc64k9IraCdK/5iCytBmOYH8Jd5qAnhi7Y7kVNJ4TZfcs4DO4Q0S3mxcS2G18RjvqKn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2CHW3jJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915C6C4CED1;
	Fri,  6 Dec 2024 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733489717;
	bh=ut+n6OkeEePipWNKkILbIw1fd3nezu+R13ATMigoLes=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W2CHW3jJc24Sw0orGRez001VEhUVd30dX9BD9pO5031wGocVLxDblhdG4rJV3pewp
	 wkV9jDnJ54AZKZJBqIn9J/zXCiPcnSxtIkad6velCia5lDH9ayz7UR7FaoPdJ6gubQ
	 cpoOdGaf1t+Eyd+ppx4ySRBJBZNip5LbSBGRrpMoA5IHkduDdx0gah/weQPrBrK4Ph
	 qNGe861N9yb5uEMeFsAL7QiJSRXtfydImiy1JXa5dKZmD2Ac6nByXmoUItRvWrFdQA
	 00CfBV2bb/oYsu+ZjffbI91NLFN9jtMQXSB8eM14QwcaDcL1gLVwf6WWSKIFyVPjl6
	 s26MAdx7mXzUQ==
Message-ID: <cda109c9-a1e2-42cb-b830-6764c6eef519@kernel.org>
Date: Fri, 6 Dec 2024 13:55:11 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/22] wifi: ath12k: add Ath12k AHB driver support for
 IPQ5332
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <ou5kgedz5aga4dtda6k23uhybcjy7mfwie74p6q3qyn5bdajz7@ftejp7lqrise>
 <0b2f8734-f502-42d7-bdc5-b0d382d2aa70@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <0b2f8734-f502-42d7-bdc5-b0d382d2aa70@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/12/2024 12:07, Raj Kumar Bhagat wrote:
> On 10/16/2024 12:27 PM, Krzysztof Kozlowski wrote:
>> On Tue, Oct 15, 2024 at 11:56:15PM +0530, Raj Kumar Bhagat wrote:
>>> Currently, Ath12k driver only supports WiFi devices that are based on
>>> PCI bus. New Ath12k device IPQ5332 is based on AHB bus. Hence, add
>>> Ath12k AHB support for IPQ5332.
>>>
>>> IPQ5332 is IEEE802.11be 2 GHz 2x2 Wifi device. To bring-up IPQ5332
>>> device:
>>> - Add hardware parameters for IPQ5332.
>>> - CE and CMEM register address space in IPQ5332 is separate from WCSS
>>>   register space. Hence, add logic to remap CE and CMEM register
>>>   address.
>>> - Add support for fixed QMI firmware memory for IPQ5332.
>>> - Support userPD handling for WCSS secure PIL driver to enable ath12k
>>>   AHB support.
>>>
>>> Depends-On: [PATCH V7 0/5] remove unnecessary q6 clocks
>>> Depends-On: [PATCH V2 0/4] Add new driver for WCSS secure PIL loading
>>> Link: https://lore.kernel.org/all/20240820055618.267554-1-quic_gokulsri@quicinc.com/
>>> Link: https://lore.kernel.org/all/20240829134021.1452711-1-quic_gokulsri@quicinc.com/
>>
>> These are series targetting other subsystems. I do not understand why
>> you created such dependency. It does not look needed and for sure is not
>> good: nothing here can be tested, nothing can be applied.
> 
> To validate this series, the dependencies mentioned above were necessary, which
> is why they were included.

What does it mean "validate"? You are supposed to describe how upstream
can consume this.

> 
> Currently, the "[PATCH V7 0/5] remove unnecessary q6 clocks" has been merged,
> so this dependency will not be required in the next version.
> 
> The "[PATCH V2 0/4] Add new driver for WCSS secure PIL loading" series is still
> under review and is required for validation.
> 
> However, this series can still be applied and compiled without these dependencies.
> Please let us know if we should remove the dependency in the next version.

So write proper cover letter not bringing up fake dependencies.
Otherwise answer is: this cannot be tested, thus it will not be reviewed.

Best regards,
Krzysztof

