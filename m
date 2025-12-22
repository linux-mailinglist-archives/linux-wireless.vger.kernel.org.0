Return-Path: <linux-wireless+bounces-30051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFB3CD60CF
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 13:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58A553050CCC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC6F2D24A9;
	Mon, 22 Dec 2025 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3sFdgPZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DDA261B80;
	Mon, 22 Dec 2025 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407315; cv=none; b=uSld4mSqq9Z5RMyKdxH3+uJpYYEBpoJiJi6KSv1Xew1EmWzKeNgq86uvSHfYiyezk2Bn+f+Gnyqdw8WU6L2NGrf3KnZigZoNdNaA6+kPJZWwDBe4geeRJsov+sJDhokegnGekl2ia4UT2kkEE9YdrCjTUiqbVFEBFcA1K3OPr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407315; c=relaxed/simple;
	bh=G5Zg4EHeNRLacKj+LTFhvKWt/cUI8R7NhKAOfZw/9c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8PsGpFPacaYGbtysvH/zsZrfMbpoNgdD/qc9ihg/O3s2Whmegk5dwIbpy5fDEjB2FbdzXCoDBShMcDJ8U+eq3p90poTj5uHCkAXeOtWLygm15K/8pEw9obI1vh1PqPXcBRVk0O0c73ppZFS9RfvrGyF79PJlXLxj+gpFrs1jgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3sFdgPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ED2C113D0;
	Mon, 22 Dec 2025 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766407314;
	bh=G5Zg4EHeNRLacKj+LTFhvKWt/cUI8R7NhKAOfZw/9c4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M3sFdgPZXQTBDSkFVxFGUcF+kiGNSnacJtoydMWKvbVZ6+zTIZk+HEiCdCkAOErbg
	 ui0DjVc8m2ZSfxuuRcIgi5Jhs5UyFwKFG5qCGTlVfs0oViNl+YrTLCDLr3lq3wZFKO
	 91oeaduN5OxJdxu36f7HEz6OpPgdc7Tj38W8yxFaZ2YLRSqpujFZ8ERsGqxK0TJfAg
	 DZFoF3qu5ATNBSfeYx2oj1W0V3Hos551TFtKqgb9icdxG26p3gBVKp2kzvwnL2jBrp
	 fx2L2C26w0Vg8aPOsCmCFk0ZyVxF+RfFCqWLRATG0XPdnvLlrs8+kRXugwYk00bbtQ
	 mDMG7dzYmx/iA==
Message-ID: <2ff993a7-0fda-4337-9acc-92aaa75be750@kernel.org>
Date: Mon, 22 Dec 2025 13:41:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] dt-bindings: wireless: ieee80211: Add
 disable-rfkill property
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bryan O'Donoghue <bod.linux@nxsw.ie>, jerome.debretagne@gmail.com,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 ath12k@lists.infradead.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Dale Whinham <daleyo@gmail.com>
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
 <M7kfFb5fz-WB43U_xCUwgxpmBJ4TNdp4jE6yFu6HmemIcDx5tXO6H4xnW_pEQz6DMkKm-3POdB9hIdB092zhGQ==@protonmail.internalid>
 <20251220-surface-sp11-for-next-v5-2-16065bef8ef3@gmail.com>
 <e0e9e690-c56e-4b56-90f9-2af46a7feaf3@nxsw.ie>
 <c29de60c-c7c6-45d7-8d90-616df23df01c@kernel.org>
 <v4hxei4t7n6ebvw6heoccei2t3mskq7uo7zejv6dyvvq5fr5sv@xzpsiic5x7a4>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <v4hxei4t7n6ebvw6heoccei2t3mskq7uo7zejv6dyvvq5fr5sv@xzpsiic5x7a4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mani,

On 22-Dec-25 12:45, Manivannan Sadhasivam wrote:
> On Mon, Dec 22, 2025 at 11:23:18AM +0100, Hans de Goede wrote:
>> +Cc Mani
>>
>> Hi,
>>
>> On 20-Dec-25 07:04, Bryan O'Donoghue wrote:
>>> On 20/12/2025 00:21, Jérôme de Bretagne via B4 Relay wrote:
>>>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>>>
>>>> For some devices, Wi-Fi is entirely hard blocked by default making
>>>> the Wi-Fi radio unusable, except if rfkill is disabled as expected
>>>> on those models.
>>>>
>>>> Commit c6a7c0b09d5f ("wifi: ath12k: Add Support for enabling or
>>>> disabling specific features based on ACPI bitflag") added a way to
>>>> support features set via ACPI, including the DISABLE_RFKILL bit.
>>>>
>>>> Add a disable-rfkill property to expose the DISABLE_RFKILL bit
>>>> equivalent for devices described by a Devicetree instead of ACPI.
>>>>
>>>> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/net/wireless/ieee80211.yaml | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
>>>> index d89f7a3f88a71d45d6f4ab2ae909eae09cbcaf9a..c10a4675640be947cd0b5eaec2c7ff367fd93945 100644
>>>> --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
>>>> @@ -29,6 +29,12 @@ properties:
>>>>         different 5 GHz subbands. Using them incorrectly could not work or
>>>>         decrease performance noticeably
>>>>
>>>> +  disable-rfkill:
>>>> +    type: boolean
>>>> +    description:
>>>> +      Disable rfkill for some devices on which Wi-Fi would be entirely hard
>>>> +      blocked by default otherwise
>>>> +
>>>>   additionalProperties: true
>>>>
>>>>   examples:
>>>>
>>>> -- 
>>>> 2.47.3
>>>>
>>>>
>>>>
>>>
>>> Is this really a hardware description though ?
>>
>> I would say yes it is. The wifi chip has an rfkill input pin and
>> things will be broken when that pin is hardwired to a fixed value
>> rather then being actually connected to a GPIO from say
>> the embedded controller.
>>
> 
> IIUC, even if the M.2 slot has the W_DISABLE1# signal routed from the host,
> the device won't make use of it as there is no physical connection. So you want
> the WLAN driver to change the state through SW?
> 
>> So I think that we would need here is not a disable-rfkill property
>> but some way to indicate in the DT-node that the rfkill input pin
>> is not connected and thus should be ignored.
>>
>> This (the rfkill input pin being not-connected) IMHO very much
>> is hw-description.
>>
> 
> Though we can argue this way, I would prefer to handle it in the driver. For
> example, with my M.2 series, we will end up describing the M.2 slot:
> 
> 	connector {
> 		compatible = "pcie-m2-e-connector";
> 		w-disable1-gpios = <&tlmm 117 GPIO_ACTIVE_LOW>;
> 		...
> 		ports {
> 			...
> 			endpoint@0 {
> 				reg = <0>;
> 				remote-endpoint = <&pcie4_port0_ep>;
> 			};
> 		};
> 	};
> 
> Then if we use a DT property to convey the RFKILL pin state of the device, we
> would need to describe the endpoint device in DT and hardcode the state:
> 
> 	&pcie4_port0 {
> 		...
> 		port {
> 			pcie4_port0_ep: endpoint {
> 				remote-endpoint = <&m2_e_pcie_ep>;
> 				disable-rfkill;
> 			};
> 		};
> 	};
> 
> So this will essentially make the M.2 device non-swappable unless you change the
> DT since you've how hardcoded the device property in the binding. This is
> something I try to avoid to make the M.2 slot really swappable.
> 
> For this reason, I would prefer to handle the RFKILL state in the WLAN driver
> using the device specific compatible. This will be problematic only if multiple
> cards of the same Device ID have different RFKILL state and the devices are not
> distinguishable even with sub IDs.

I think we're miscommunicating here. I'm not talking about the card having
a broken rfkill implementation, I'm talking about the M.2 slot on the mainboard
having e.g. W_DISABLE1# hardwired in such a way that cards would interpret it as
having to always disable their wifi radio which is very similar to what is
happening on the surface device. Except that on the Surface there is no M.2 slot,
the wifi is just soldered onto the mainboard I believe.

Based on experience I'm pretty sure we will encounter M.2 slots which such
a hardwired W_DISABLE1# signal sooner rather then later.

So my proposal is to come up with a generic way to solve the broken M.2 slot
case and then apply that to the Surface case.

Regards,

Hans



