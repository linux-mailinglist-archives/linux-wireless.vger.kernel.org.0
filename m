Return-Path: <linux-wireless+bounces-15059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FBF9C03F8
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 12:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B35B22973
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89102003BE;
	Thu,  7 Nov 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBfEVEY5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659351FCC5D;
	Thu,  7 Nov 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978952; cv=none; b=gFW2P7PcjbJty8WWkqaHn8AKtKl80mdPwUR4rPYTBqjCXAY9H0WQ3RqB9pr4oQ35bmt3ro23nRqxmihOpI0K2gwJCCl9SBRW6BiAe2FmwjdQ48ehl/ZWXi6my+zELfgV9TzMJZRnpa85WqEkTSjTTkv4oGqdrb8N74e+BMOKubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978952; c=relaxed/simple;
	bh=hn/LWCWM3d5rbXF/Ku8OlDD6oDQ8ir5pxuttNeX7L0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqfZQJkbdSknjihypbYmbJx9CIVKBJAtKZvUAmyxzU05cWf0Fx0IXK5OIAQK7p2syhtM6oiyo4xKtEhmdyOBG+DqDJoNjhvNWgK7Zuq0tlNMnHZKr1xmIJD8flcMiF/A4FsNi9OpLYancgDF9uAKaD9kuNAm3IlVhn4YJEwIFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBfEVEY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8174BC4CECC;
	Thu,  7 Nov 2024 11:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730978951;
	bh=hn/LWCWM3d5rbXF/Ku8OlDD6oDQ8ir5pxuttNeX7L0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hBfEVEY5iGXU8zSBj+aGKyoImpil09OAqQaSS/0AbHfvA9Gg/VNkhBkYVsNfnTc56
	 f92ARaTJ4ZAet7OCjJgRbeAmUVOQCt+ZHDUE3q+8gxmzZsX9y2+fN06Ps1BsEWpCi9
	 OvAK99XdyrslGFk229NIfFKszurvlEF+lPsmdaCncOaf1rxJ5TkCsKdUuucKp3WGU5
	 uLzpUt4Pd1O0s3F4ShEjd40zQWhPQVKooiTxbdhJye9zj6qi7XtOSIwKc3VmsudQNX
	 VEutFFCX1fKBrac+se+EIlmYtSN5CwZUc3QmvRdrZ9kValAIvJsykv7IVpX7uQyzmZ
	 lb9o1+MwjEyMg==
Message-ID: <692503b8-cf39-4d6b-b70e-910fcc710d69@kernel.org>
Date: Thu, 7 Nov 2024 12:29:03 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/5] wifi: ath12k: Add wifi device node with WSI
 for QCN9274 in RDP433
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
 <49a6ec0d-8a0b-49aa-a9eb-1174cff930f6@kernel.org>
 <cmvfpctliqggra33u6ituguoxh3jxcuxiyjpbtcjbcgpu6lhoi@4zdthfkc2ed3>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <cmvfpctliqggra33u6ituguoxh3jxcuxiyjpbtcjbcgpu6lhoi@4zdthfkc2ed3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/11/2024 12:06, Dmitry Baryshkov wrote:
> On Thu, Nov 07, 2024 at 11:23:20AM +0100, Krzysztof Kozlowski wrote:
>> On 05/11/2024 19:04, Raj Kumar Bhagat wrote:
>>> The RDP433 is a Qualcomm Reference Design Platform based on the
>>> IPQ9574. It features three QCN9274 WiFi devices connected to PCIe1,
>>> PCIe2, and PCIe3. These devices are also interconnected via a WLAN
>>> Serial Interface (WSI) connection. This WSI connection is essential
>>> for exchanging control information among these devices.
>>>
>>> This patch series describes the WSI interface found in QCN9274 in
>>> device tree and uses this device tree node in the Ath12k driver to get the
>>> details of WSI connection for Multi Link Operation (MLO) among multiple
>>> QCN9274 devices.
>>>
>>> NOTES:
>>> 1. As ath12k MLO patches are not ready yet, this patchset does not apply
>>>    to the ath.git ath-next branch and that's why the patchset is marked
>>>    as RFC. These are the work-in-progress patches we have at the moment.
>>>    The full set of MLO patches is available at:
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/log/?h=ath12k-mlo-qcn9274
>>>
>>> 2. The dependency marked below applies only to the DTS patch. The
>>>    dt-bindings patches do not have this dependency.
>>>
>>> Depends-On: [PATCH V7 0/4] Add PCIe support for IPQ9574
>>> Link: https://lore.kernel.org/linux-pci/20240801054803.3015572-1-quic_srichara@quicinc.com/
>>>
>>> v3:
>>> - Created a separate binding "qcom,ath12k-wsi.yaml" to describe ath12k PCI
>>>   devices with WSI interface.
>>
>> Thanks for the changes. When you finish with testing/RFC, please send
>> proper version for review (just remember to keep numbering, next one is
>> v4 regardless whether this is RFC or not).
> 
> Isn't the 'RFC' being an invitation for review per the nature of the tag
> itself?

No, RFC means patch is not ready, might change. This was brought on the
lists multiple times and some maintainers clearly ignore RFC. Including me.

> 

Best regards,
Krzysztof


