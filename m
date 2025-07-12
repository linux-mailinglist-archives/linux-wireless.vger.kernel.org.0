Return-Path: <linux-wireless+bounces-25317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028CAB02C0A
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 18:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D09188F084
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3EB288C8C;
	Sat, 12 Jul 2025 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8dtt/mN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3D70823;
	Sat, 12 Jul 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752339573; cv=none; b=b46/Gvumb5TcNNAArtDGLMsFb90D582Nnz8zB53yqIi1Oc4Mtf/G2ZEkD5Yi3I9FdeOdIRQdGHMzVFPtAoas07QR4i0yO1zVSlC18YCHl6ixCQZjDnHvbOX4R1n0NDDKM/LiKlJ0ZUu0srbsbHxSnaGA0fDaIcxEtlkHaVW9Oi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752339573; c=relaxed/simple;
	bh=O6/br0HScFLjxFbUFDku985RqpRVfW8PbxO4etqtAeo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FURC1FXPdHOGsH0fxEOXY0NPwnRD71bsbmLHWBUV4+QrX0P9e2533uleZUSQo8T4dj/w3H8COuRBbrofoJi21lfZ9jhu9acphjdb5xMKFaIKKwffz1B59zz+rn7FQ/b2jGMUG1QC62ii4P0V38jNMNcFOem2NlZOR0dpq12CSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8dtt/mN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764FEC4CEEF;
	Sat, 12 Jul 2025 16:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752339571;
	bh=O6/br0HScFLjxFbUFDku985RqpRVfW8PbxO4etqtAeo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=B8dtt/mNnQuXk73OIgDAEefgL+cjk4d2PkFYjC4FBG6AIMDS7ggf2ReZKwhJ2BJ03
	 LwZPDHqE2TPIMQyORbUjDB5rC2w95bs/mv0C8zvMBYd4wsUI+jt5DzEjubxKgyyVnP
	 4dCVS0dB7rb1fhp6N4vRcYHCYYZKIHGlhmC8IWOaeqqzeTCQpE1ga7jCwiTKqoUs8L
	 0dD6Es8xCiPN8iFmNMtxDPc8JM8OJyknplW2FTPZKClJueYgqY9cIH3QC4zmwnN/XZ
	 CXjg3FED78ntmr3mTDjoAKtIFEDDiGLYUIhiATo59f51hRhldezOK5RxmGnfds7HiK
	 1UrwIKV1/K3Wg==
Message-ID: <23e629cb-0698-4a9c-aa18-9a7e71aa8b73@kernel.org>
Date: Sat, 12 Jul 2025 18:59:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 wireless-next 7/7] dt-bindings: net: wireless: rt2800:
 add
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:MIPS" <linux-mips@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>
References: <20250710200820.262295-1-rosenp@gmail.com>
 <20250710200820.262295-8-rosenp@gmail.com>
 <d8b0abb2-1a12-42bf-aafd-4cd1e21babd6@kernel.org>
 <CAKxU2N-c2tHBYWBM+FJGqdSaqzw9u0O8e0G7AVqk6b0QdRnPTw@mail.gmail.com>
 <20250711-invisible-dainty-jackrabbit-acbf8f@krzk-bin>
 <20250712104006.GA13512@wp.pl>
 <e435a765-fb91-408f-81dd-01a73fc43b6b@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <e435a765-fb91-408f-81dd-01a73fc43b6b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/07/2025 18:53, Krzysztof Kozlowski wrote:
> On 12/07/2025 12:40, Stanislaw Gruszka wrote:
>> Hi Krzysztof,
>>
>> On Fri, Jul 11, 2025 at 09:48:49AM +0200, Krzysztof Kozlowski wrote:
>>> On Thu, Jul 10, 2025 at 03:40:30PM -0700, Rosen Penev wrote:
>>>> On Thu, Jul 10, 2025 at 2:40 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>
>>>>> On 10/07/2025 22:08, Rosen Penev wrote:
>>>>>> Add device-tree bindings for the RT2800 SOC wifi device found in older
>>>>>> Ralink/Mediatek devices.
>>>>>>
>>>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>>>>> ---
>>>>>>  .../bindings/net/wireless/ralink,rt2800.yaml  | 47 +++++++++++++++++++
>>>>>>  1 file changed, 47 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..8c13b25bd8b4
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
>>>>>
>>>>> Filename should match compatible. You were already changing something
>>>>> here...
>>>> hrm? that makes no sense. Various drivers have multiple compatible lines.
>>>
>>> Luckily we do not speak about drivers here. Anyway, follow standard
>>> review practices, you don't get special rules.
>>
>> Could you please elaborate what you mean ?
> 
> Rosen replied in abrasive way, so I am not going to dig this.
> 
>>
>> I greped through Documentation/devicetree/bindings/*/*.yaml and plenty
> 
> I assume you refer to last 2 years bindings, not something older, right?
> It is really poor argument to find old files and use them as example
> "they did like that".
> 
>> of "compatible:" items do not match the filename. So hard to tell
> 
> I did not ask for compatible to match filename.
> 
>> what rule you are referencing, as it seems it's not really applied.
> Check reviews on the lists. It is pretty standard review. Everyone gets
> it for this case here - single device, single compatible.

BTW, it is not hiding on the lists:

https://lore.kernel.org/linux-devicetree/?q=f%3Aherring+filename
https://lore.kernel.org/linux-devicetree/?q=f%3Akozlowski+filename

Best regards,
Krzysztof

