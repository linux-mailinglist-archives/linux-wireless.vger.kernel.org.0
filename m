Return-Path: <linux-wireless+bounces-24290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9B1AE1F69
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 17:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E733B7D87
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91762E8E1D;
	Fri, 20 Jun 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvNFgUXl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BDB2D29CF;
	Fri, 20 Jun 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434328; cv=none; b=QRogJs42MKdVwhlZiVBfTz3zZs66NS0Hg4E46IwRczOcmGmR/z9nQ9anKLL9MkFfI6a0RYBY+wm7+w0oskS9NKEC8ACrtUROvW5uyaFV2jSMdUOm5sZjFl4ETT2/xJLbkDjeDlZjq9hHnM5UzyrvX6KVJagnLgX2B3LNDfCWGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434328; c=relaxed/simple;
	bh=Zd84NnTL2fRFyvN5Ij331Z+OZS7ttEjUlHQ/6RFI/04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKINPUeL6zBO/VDhoW9pGpAso1R9Ay+oqY+S2KM42bghvZOtGYVUYAeDIr/i6xMQT2mCuEVLGoBhH2w0/Fm8UUtN9ulEKSpsFCzncVZ+Pt5g/lwVKMpUiaMjZMkXmFZuBtgRyRtsIB2hNC7eHNFvMlZvwx0ZvbZK/TB149Fejjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvNFgUXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDBDC4CEE3;
	Fri, 20 Jun 2025 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750434328;
	bh=Zd84NnTL2fRFyvN5Ij331Z+OZS7ttEjUlHQ/6RFI/04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AvNFgUXlACUxkFVn3xM0WDk9PfcqX0bEtt58WjDUroFsIckjvXLM5rbsVSMxYfQwd
	 DrwW5lGOQ36ScXDNd/s+Nzk5qIoWxH2j2p9rJiuk6frrcJxGhL3V2mRF7gAp2o2J++
	 LEsUQveLs0d60HhUbPNnYO2UzzTIGdsd8u+LlVV5fC8DNTmD8XnYXocT75x23eJGSt
	 nlQOL+H9zoRz8f0eyuvRmM2u2ulQRt3a4jowazEvB6vtAtuWnNNzrFgui9omfagcZN
	 JDnUvXb2Rpe8IxpZ5iUleDbzUpRdtQkL7Rob+3jzYql6LfkHzl2teaq1K2JwyJwbG5
	 DU2DM+nE/l0Sw==
Message-ID: <1788be57-2c26-4bfc-97bf-7d9a0abe3861@kernel.org>
Date: Fri, 20 Jun 2025 17:45:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 0/5] wifi: ath9k: add ahb OF support
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 nbd@nbd.name, Johannes Berg <johannes@sipsolutions.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:MIPS" <linux-mips@vger.kernel.org>
References: <20250609030851.17739-1-rosenp@gmail.com>
 <37561ac8-ac0f-4744-9495-c7589544d4bb@oss.qualcomm.com>
 <ef0db40a-14d1-4670-82ca-f724a0eeee0d@kernel.org>
 <ddc48fa7-3fca-46a3-9224-11c0c3fce4a4@kernel.org>
 <4a3ad8a6-90a9-45c5-bbdf-7b91d3c18e51@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <4a3ad8a6-90a9-45c5-bbdf-7b91d3c18e51@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/06/2025 17:27, Jeff Johnson wrote:
> On 6/19/2025 10:39 PM, Krzysztof Kozlowski wrote:
>> On 20/06/2025 07:32, Krzysztof Kozlowski wrote:
>>> On 20/06/2025 02:33, Jeff Johnson wrote:
>>>> On 6/8/2025 8:08 PM, Rosen Penev wrote:
>>>>> First two commits are small cleanups to make the changes of the third
>>>>> simpler. The fourth actually adds dts definitions to use ahb.
>>>>>
>>>>> v2: Add documentation, use kernel_ulong_t, and of_device_get_match_data
>>>>> v3: Use qcom prefix and wifi suffix as in other ath drivers.
>>>>> v4: fix up dts example in Documentation
>>>>> v5: move back to using qca prefix. It makes no sense to diverge between
>>>>> all the other drivers for MIPS based qualcomm devices. qcom as a prefix
>>>>> is used for Quallcomm's ARM(64) stuff.
>>>>>
>>>>> Rosen Penev (5):
>>>>>   wifi: ath9k: ahb: reorder declarations
>>>>>   wifi: ath9k: ahb: reorder includes
>>>>>   wifi: ath9k: ahb: replace id_table with of
>>>>>   dt-bindings: net: wireless: ath9k: add OF bindings
>>>>>   mips: dts: qca: add wmac support
>>>>>
>>>>>  .../bindings/net/wireless/qca,ath9k.yaml      | 23 ++++++-
>>>>>  arch/mips/boot/dts/qca/ar9132.dtsi            |  9 +++
>>>>>  .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  4 ++
>>>>>  arch/mips/boot/dts/qca/ar9331.dtsi            |  9 +++
>>>>>  arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 ++
>>>>>  .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  4 ++
>>>>>  arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 ++
>>>>>  .../qca/ar9331_openembed_som9331_board.dts    |  4 ++
>>>>>  arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  4 ++
>>>>>  drivers/net/wireless/ath/ath9k/ahb.c          | 60 +++++++------------
>>>>>  10 files changed, 84 insertions(+), 41 deletions(-)
>>>>>
>>>>
>>>> DT team, should I take this series through my tree?
>>>> Toke, Ack?
>>> No, of course not. The same as you asked some time ago: DTS never, NEVER
>>> goes via driver subsystem tree.
>>>
>>
>> Heh, you do not have any subsystem maintainers acks or reviews on DTS,
>> so this should not be considered. It's like me taking wireless patches
>> without your acks.
> 
> That is why I was looking for clarification.
> All the DT stuff had your R-B and hence why I asked Toke for his Ack.
> Will DT team take the entire series (I'm ok with that)?
> Or just the DTS and I should take the rest?

It's not the DT team, we are not taking any DTS patches ever but
platform or SoC maintainers are taking DTS for their platform. So please
take only your subsystem - wireless drivers and wireless DT bindings -
leaving DTS for platform/SoC maintainers.

Best regards,
Krzysztof

