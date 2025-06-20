Return-Path: <linux-wireless+bounces-24278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA96AE1312
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 07:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB997189732B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 05:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2E01FBEB9;
	Fri, 20 Jun 2025 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCaJ0yLW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C41DED53;
	Fri, 20 Jun 2025 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397979; cv=none; b=hC4UNWCjtgE3sAIH7i28eM29g4URTW/fpjZ/QrfASjmSE4ADdXiw6SxO/OEEvBKdU/ZJj88aPLcZA+CfgWzLuYm615y7khPLYEOC5ZF9zm+cGMYACicMBugA6lWv8KGABiog6LsvHdTIJAPP7+kgnMszzwtqJd+7yP+h1neCsJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397979; c=relaxed/simple;
	bh=J53Bxt+CpHgBflG0yd+XaefqPIypj2Q4G2sGpszNHQg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GbZH0NuuOparkmmxa2ZEFyClJhcwc4OYjdC9ZH7aEPU2SST3sNESfbmsXNZCW168FUa2p5Er/x+9T6mbU+wJTw8DeyYg3umqSCXw0CwKpo+XjZInUCMXczCHU3Iui2gBuNBHpErGA8ojpMHHHzlN/EQMYz5ElPpK1wGbBllTFLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCaJ0yLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933BFC4CEE3;
	Fri, 20 Jun 2025 05:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750397979;
	bh=J53Bxt+CpHgBflG0yd+XaefqPIypj2Q4G2sGpszNHQg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bCaJ0yLWt7EcaCwIvWzuiMzqxwE6uuf29DBGhEbmtkvVhl9PlJpwLy4SD4MvdUQ08
	 9OBMBelK9Hf/a987JxrCAO5awdgLlf+L3t1C6zsJiFLRxjndrUDiRf14W7z4pit7a3
	 XLOn1wN5n6Li0KINLdEQOk34SXeiXgYqEfMMdX1yt+ITehVHjM1OcvA/W/aaKF0mr6
	 o8VltkgcsWE69FuzavQUChmEyBpzsZHw+2Rk7neuNp/EWU/lcKruUJ7hIjSjIKund9
	 RzL1wUjGQOA1Vl3U7Repq7l55D6jUhvpfAD3n08RaCGwOl4g+Xxq/LCb57PEkZ+tmU
	 qmNdiNvtBQP7Q==
Message-ID: <ddc48fa7-3fca-46a3-9224-11c0c3fce4a4@kernel.org>
Date: Fri, 20 Jun 2025 07:39:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 0/5] wifi: ath9k: add ahb OF support
From: Krzysztof Kozlowski <krzk@kernel.org>
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
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <ef0db40a-14d1-4670-82ca-f724a0eeee0d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/06/2025 07:32, Krzysztof Kozlowski wrote:
> On 20/06/2025 02:33, Jeff Johnson wrote:
>> On 6/8/2025 8:08 PM, Rosen Penev wrote:
>>> First two commits are small cleanups to make the changes of the third
>>> simpler. The fourth actually adds dts definitions to use ahb.
>>>
>>> v2: Add documentation, use kernel_ulong_t, and of_device_get_match_data
>>> v3: Use qcom prefix and wifi suffix as in other ath drivers.
>>> v4: fix up dts example in Documentation
>>> v5: move back to using qca prefix. It makes no sense to diverge between
>>> all the other drivers for MIPS based qualcomm devices. qcom as a prefix
>>> is used for Quallcomm's ARM(64) stuff.
>>>
>>> Rosen Penev (5):
>>>   wifi: ath9k: ahb: reorder declarations
>>>   wifi: ath9k: ahb: reorder includes
>>>   wifi: ath9k: ahb: replace id_table with of
>>>   dt-bindings: net: wireless: ath9k: add OF bindings
>>>   mips: dts: qca: add wmac support
>>>
>>>  .../bindings/net/wireless/qca,ath9k.yaml      | 23 ++++++-
>>>  arch/mips/boot/dts/qca/ar9132.dtsi            |  9 +++
>>>  .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  4 ++
>>>  arch/mips/boot/dts/qca/ar9331.dtsi            |  9 +++
>>>  arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 ++
>>>  .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  4 ++
>>>  arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 ++
>>>  .../qca/ar9331_openembed_som9331_board.dts    |  4 ++
>>>  arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  4 ++
>>>  drivers/net/wireless/ath/ath9k/ahb.c          | 60 +++++++------------
>>>  10 files changed, 84 insertions(+), 41 deletions(-)
>>>
>>
>> DT team, should I take this series through my tree?
>> Toke, Ack?
> No, of course not. The same as you asked some time ago: DTS never, NEVER
> goes via driver subsystem tree.
> 

Heh, you do not have any subsystem maintainers acks or reviews on DTS,
so this should not be considered. It's like me taking wireless patches
without your acks.

Best regards,
Krzysztof

