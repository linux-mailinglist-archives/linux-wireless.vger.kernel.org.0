Return-Path: <linux-wireless+bounces-8879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CE59052EB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9F51F21B71
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81CD176241;
	Wed, 12 Jun 2024 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ2k0Fwt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D87172BC1;
	Wed, 12 Jun 2024 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196596; cv=none; b=BTe8Rd9hgBj5pz9y95/t5Srio9XEPDMn0qCFy4SfQ2o8yxPqqdnQx9EPXmBV05RlNvOZLoAkKr4zG/joMZH5QVq15echLmvW1qZA9Diyt+cadD9Wa2gmMhZeJ5yO7llIm2Uq3RaJ8a/z4iOWmZ4QlMnB3PJVILYwv79yvpfrivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196596; c=relaxed/simple;
	bh=eQnr5sp7TMU5N9+uMDCu57G7uX0Piw4Oz8VKM7kfQy8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=B2SVJAOLpVYJ01Ix7QsmKct3WJRGStLPZtBx1WcesbU9KaoPEDDPQ92uK+Ox59FYFPO7xMwd2Lyn1zHfPWQnY+cqzo9bFVKkyev+jGDetpPKTDMas5X8o4UO6SXFN2shFdgjrR/CnAaPlqZt7coGPaTTULBWoq1Gd6LjCzlWzFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ2k0Fwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94965C3277B;
	Wed, 12 Jun 2024 12:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718196596;
	bh=eQnr5sp7TMU5N9+uMDCu57G7uX0Piw4Oz8VKM7kfQy8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aJ2k0Fwtt4Xb1+hzlbll1Aahwhuiw50/l5W97ntyw/wMLsB1NPLwI8RyOXHcP6scE
	 LDeOq9eFDKNdz1Rqv+0AZh5iWyng3A3wsJw85AQP4Tgo15pNlzXsqoJNBGuC0wOBOd
	 ePJzAeCzlYh9g1k2Ha/zf5lnnK65hoYrkznfPeoPr3YX/99a0PZkyE55ILb9Zt0QK/
	 3gsNei2Yyg4Ip8d1LqdhbBnCGAd8eQhDnY8MrYVwYdkXLmzCp2M7q8kjAS659fi5oU
	 +WZn8rsCC7RSlyfS1BDCDW79WFkX2AcfW0Xn0B3qc2Ue3XdfGm70GuI7lr4PazJTDl
	 8pdMRG8iYjqaw==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Jeff Johnson <jjohnson@kernel.org>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  ath11k@lists.infradead.org,
  linux-kernel@vger.kernel.org,  ath12k@lists.infradead.org,  Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
References: <20240605122106.23818-1-brgl@bgdev.pl>
	<20240605122106.23818-2-brgl@bgdev.pl> <87h6e6qjuh.fsf@kernel.org>
	<CAMRc=MdiKxtnN+g92RUTXdOydaPV5M2u5iUdKyE2SNvDkdXAjg@mail.gmail.com>
	<871q5aqiei.fsf@kernel.org>
	<CAMRc=McacZMP-51hjH+d8=PVe+Wgw4a8xWcv0sRPLJKL_gP=KQ@mail.gmail.com>
	<87sexqoxm9.fsf@kernel.org>
	<CAMRc=McYAbhL5M1geYtf8LbgJG5x_+ZUFKXRuo7Vff_8ssNoUA@mail.gmail.com>
	<8db01c97-1cb2-4a86-abff-55176449e264@kernel.org>
	<CAMRc=Mer2HpuBLGiabNtSgSRduzrrtT1AtGoDXeHgYqavWXdrA@mail.gmail.com>
Date: Wed, 12 Jun 2024 15:49:51 +0300
In-Reply-To: <CAMRc=Mer2HpuBLGiabNtSgSRduzrrtT1AtGoDXeHgYqavWXdrA@mail.gmail.com>
	(Bartosz Golaszewski's message of "Tue, 11 Jun 2024 22:05:57 +0200")
Message-ID: <87ikyenx5c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

>> >> Sure, I don't need DT but that's not my point. My point is why require
>> >> these supplies for _all_ devices having PCI id 17cb:1101 (ie. QCA6390)
>> >> then clearly there are such devices which don't need it? To me that's
>> >> bad design and, if I'm understanding correctly, prevents use of
>> >> qcom,ath11k-calibration-variant property. To me having the supplies
>> >> optional in DT is more approriate.
>> >>
>> >
>> > We require them because *they are physically there*.
>>
>> I understand that for all known DT QCA6390 hardware, the supplies should
>> be provided thus they should be required. If in the future we have
>> different design or we represent some pluggable PCI card, then:
>> 1. Probably that PCI card does not need power sequencing, thus no DT
>> description,
>> 2. If still needs power sequencing, you can always amend bindings and
>> un-require the supplies.
>>
>>
>> Best regards,
>> Krzysztof
>>
>
> Kalle, does the above answer your questions? Are these bindings good to go?

To me most important is that we are on the same page that in some cases
(eg. with M.2 boards) the supplies can be optional and we can update the
bindings doc once such need arises (but we don't make any changes right
now). Based on point 2 from Krzysztof I think we all agree, right?

Just making sure: if we later change the supplies optional does that
create any problems with backwards compatibility? It's important that
updates go smoothly.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

