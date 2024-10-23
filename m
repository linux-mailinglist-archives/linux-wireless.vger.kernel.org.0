Return-Path: <linux-wireless+bounces-14433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB7A9AD366
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 19:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074681C21F72
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D81CFEC7;
	Wed, 23 Oct 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5/tPdYw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70715EFA0;
	Wed, 23 Oct 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706270; cv=none; b=rbNm2Cw++Rr4q0dIyMf32z1GnJZdV85TZRVunF2w3CSashiE1uqj9WRV1BCnG/vwaA77pS2FwqFKM+YdSSPPNMEOfUyMHNzDCbML55/mwbJsxz1aA6hluDjmYcSmqQOLLqx5NCg2iYoEsuWN7MOUYv/rATwMG7akbvefSDL/118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706270; c=relaxed/simple;
	bh=Ow7dsLqq7Zsk5PZkn0UMRVaiewoe1yrdqAyhv9jztmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYZiUs+O/RbR5YpalaTvV/K6jtsA1RKg3FY/h+FZ0m/JQvbWWa23VJB8r6VLFnytx6zElcNntM6+52/UMpD1WwJr8mAgPRUUVvxC+SFkiTMcI1cOoHpaYfwQ0GcadjJ3Zq5oPO9FLSs82Ok0495kg5dhN5MrDkhT7Ijtfh2aR/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5/tPdYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA50C4CEC6;
	Wed, 23 Oct 2024 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729706270;
	bh=Ow7dsLqq7Zsk5PZkn0UMRVaiewoe1yrdqAyhv9jztmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T5/tPdYwrOGLJFAlrnQpxlUUjgHlvKSE4JDpYVD447G0bBzAumXcdGCZEF1sGcm3m
	 ZIbXyDm6Do41Ly8ZSTHvnH38EFVaM7RnzEXEY902DQOR9NBrQ2Z/Oy9kvcDIqzPmvI
	 8NGaosi4FbuHIHfJPuSFo9PTkEVImPU9+VtPYvl0lw7N6PhG2A9H8mRY8grhM1g0Dg
	 Lcv9452NQJP6GgKddJunhTvU5j1iicr8AJl05tE4LzEgdkVk9Py3LnCeVOhxOo9jRw
	 DUoWNjRz5HShkSBw6ZEPxY7lpLilQxIBigWQJuSxwJPr+PH9D9UaP8Cbhz8oqvvsoo
	 w91eBn+yuj/lQ==
Message-ID: <808cfb83-a80f-431c-be69-ee3da964482a@kernel.org>
Date: Wed, 23 Oct 2024 19:57:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] dt-bindings: net: wireless: ath12k: describe WSI
 property for QCN9274
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
 <20241023060352.605019-3-quic_rajkbhag@quicinc.com>
 <b42da7f0-2034-467b-ab17-fb13ef7800c4@kernel.org>
 <9c06fdac-df4f-449c-8d58-b57c375c1751@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <9c06fdac-df4f-449c-8d58-b57c375c1751@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/10/2024 14:22, Raj Kumar Bhagat wrote:
> 
> The above three blocks represent the QCN9274 WiFi devices connected to their
> respective PCI slots. The dotted line represents the WSI connection that connects
> these three devices together. Hence, the WSI interface is part of the QCN9274 device.
> 
> To describe this WSI hardware connection in the device tree, we are adding three
> properties inside the WSI object:
> 
> 1. qcom,wsi-group-id:
>    In the above diagram, we have one WSI connection connecting all three devices.
>    Hence, “qcom,wsi-group-id” for all three devices can be 0.
> 
>    This cannot be implied by the compatible property, as explained below:
>    Let’s take the case of a platform that can have four QCN9274 WiFi devices. Below
>    is one possibility of a WSI connection:
> 
>          +-------+       +-------+          +-------+      +-------+
>          | pcie2 |       | pcie3 |          | pcie1 |      | pcie0 |
>          |       |       |       |          |       |      |       |
>    +---->|  wsi  |------>|  wsi  |--+   +-->|  wsi  |----->|  wsi  |----+
>    |     | idx 0 |       | idx 1 |  |   |   | idx 0 |      | idx 1 |    |
>    |     +-------+       +-------+  |   |   +-------+      +-------+    |
>    +--------------------------------+   +-------------------------------+
> 
>    In this case, QCN9274 devices connected in PCIe2 and PCIe3 will have the same
>    “qcom,wsi-group-id”. This group-id will be different from the “qcom,wsi-group-id”
>    of QCN9274 devices connected at PCIe1 and PCIe0.

Thanks, this explains why group-id cannot be same...

> 
> 2. qcom,wsi-index:
>    This is a unique identifier of the device within the same group. The value of
>    wsi-idx is represented in both the above cases (RDP433 and the 4 WiFi device
>    platform) in the diagram itself.

But still any device-indexing is in general not accepted (and was
mentioned during reviews multiple times).

This looks like circular list, so phandle will be enough. You only need
to mark devices being part of the same chain.

Actually graph with endpoints would be more suitable, assuming above
diagram represents connections.

Please include that diagram in binding description.

> 
> 3. qcom,wsi-num-devices:
>    Represents the number of devices connected through WSI within the same WSI group to
>    which the device belongs.
>    
>    In the case of RDP433, all devices will have this number as 3.
>    For the second example with four WiFi devices but with two WSI connections, the
>    value of “qcom,wsi-num-devices” for each device will be 2.

Not needed, just iterate over the graph children.

Best regards,
Krzysztof


