Return-Path: <linux-wireless+bounces-11478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D1952C3B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 12:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6EF284DCB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748DC7DA6D;
	Thu, 15 Aug 2024 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un1AGHtT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F057DA6C;
	Thu, 15 Aug 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714729; cv=none; b=Ht5Lc1aRl6h6BqMbBbGpJVK3q+VEzqoOviyFY68jbmkrABWkdsAT/aWx3o4o2VParc2KZD6GP88khgt+DJNXuDX1QSor3/ZxGEY5it97jURZuMrQE+FOX+8mdYgi5KBFebL6H63WV67Qr2UmUW33s4MMINGEersvktJF/pV8DK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714729; c=relaxed/simple;
	bh=sHvQeaXALSod3ueM8ffo2GB1iY9rKy6DqW6c+tre7Eg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=u3n5jfxhlnYoofGWF5F59j6aOihIInWM+ge2ARqycqXivH7+9LHNCzPFLTZo5UKBihY/dv+WT5hL9xE3WQRB3Pq14rVCLspKAvFrcYhYB+/QR2P749vAeyiwH5Dt8lzoBl0OcKnmg9mDr78OKdhRK5mbtUpE2GR7R/F49JruH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un1AGHtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF34C32786;
	Thu, 15 Aug 2024 09:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723714728;
	bh=sHvQeaXALSod3ueM8ffo2GB1iY9rKy6DqW6c+tre7Eg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=un1AGHtTQkIq8l2baWkpOvK8FoMjlipyROLzC48SvoWBv+3U/pSjfXUoUXLVspXz+
	 STZiaI/a6Tmy7tdCNHdOEfyrDj0aVkP/Sw/QvvmJ6mtOMiQcrdUIGFC0iwsGTU/V4Y
	 9J5nxrc+9mOni7qLmZwWbOvnlgiJbIxurtIcb2upt5emhELjSVFdG3kJ/pw6Ssbe2s
	 DRKVy7RoeXJjZK1NanCK5B+xkwSfi3I0hVR+h2zlTuP4m67u4Oa0aGj4+3bcvy/NBj
	 xFGqEPrCi5A7r4J/U3Q6RSxtAXJuUwF4P9iKf5E3p7E69IQ31AEhj7zPmjx7J4miQH
	 Kb8SqKyVfFYYg==
From: Kalle Valo <kvalo@kernel.org>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,  Krzysztof
 Kozlowski <krzk@kernel.org>,  Jacobe Zang <jacobe.zang@wesion.com>,
  <robh@kernel.org>,  <krzk+dt@kernel.org>,  <heiko@sntech.de>,
  <davem@davemloft.net>,  <edumazet@google.com>,  <kuba@kernel.org>,
  <pabeni@redhat.com>,  <conor+dt@kernel.org>,  <efectn@protonmail.com>,
  <dsimic@manjaro.org>,  <jagan@edgeble.ai>,  <devicetree@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,
  <linux-rockchip@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <arend@broadcom.com>,  <linux-wireless@vger.kernel.org>,
  <netdev@vger.kernel.org>,  <megi@xff.cz>,  <duoming@zju.edu.cn>,
  <bhelgaas@google.com>,  <minipli@grsecurity.net>,
  <brcm80211@lists.linux.dev>,  <brcm80211-dev-list.pdl@broadcom.com>,
  <nick@khadas.com>
Subject: Re: [PATCH v10 1/5] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
	<20240813082007.2625841-2-jacobe.zang@wesion.com>
	<1914cb2b1a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<e7401e25-7802-4dc3-9535-226f32b52be1@kernel.org>
	<062d8d4e-6d61-4f11-a9c0-1bbe1bfe0542@broadcom.com>
	<1e442710-a233-4ab2-a551-f28ba6394b5b@linaro.org>
	<180f7459-39fa-4e96-83d6-504e7802dc94@broadcom.com>
	<df52a968-96be-4f05-8d6f-32a2abde1d91@linaro.org>
	<f504a3e7-cb18-41ce-a76d-267d464b6b05@linaro.org>
	<19151c92b40.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date: Thu, 15 Aug 2024 12:38:40 +0300
In-Reply-To: <19151c92b40.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	(Arend Van Spriel's message of "Wed, 14 Aug 2024 18:47:04 +0200")
Message-ID: <87bk1uyvkv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On August 14, 2024 4:08:52 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>
>> On 14/08/2024 13:15, Krzysztof Kozlowski wrote:
>>> On 14/08/2024 12:59, Arend van Spriel wrote:
>>>> On 8/14/2024 12:39 PM, Krzysztof Kozlowski wrote:
>>>>> On 14/08/2024 12:08, Arend van Spriel wrote:
>>>>>> On 8/14/2024 10:53 AM, Krzysztof Kozlowski wrote:
>>>>>>> On 13/08/2024 19:04, Arend Van Spriel wrote:
>>>>>>>> On August 13, 2024 10:20:24 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>>>>>>>
>>>>>>>>> It's the device id used by AP6275P which is the Wi-Fi module
>>>>>>>>> used by Rockchip's RK3588 evaluation board and also used in
>>>>>>>>> some other RK3588 boards.
>>>>>>>>
>>>>>>>> Hi Kalle,
>>>>>>>>
>>>>>>>> There probably will be a v11, but wanted to know how this series will be
>>>>>>>> handled as it involves device tree bindings, arm arch device tree spec, and
>>>>>>>> brcmfmac driver code. Can it all go through wireless-next?
>>>>>>>
>>>>>>> No, DTS must not go via wireless-next. Please split it from the series
>>>>>>> and provide lore link in changelog for bindings.
>>>>>>
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>> Is it really important how the patches travel upstream to Linus. This
>>>>>> binding is specific to Broadcom wifi devices so there are no
>>>>>> dependencies(?). To clarify what you are asking I assume two separate
>>>>>> series:
>>>>>>
>>>>>> 1) DT binding + Khadas Edge2 DTS  -> devicetree@vger.kernel.org
>>>>>> reference to:
>>>>>> https://patch.msgid.link/20240813082007.2625841-1-jacobe.zang@wesion.com
>>>>>>
>>>>>> 2) brcmfmac driver changes  -> linux-wireless@vger.kernel.org
>>>>>
>>>>> No. I said only DTS is separate. This was always the rule, since forever.
>>>>>
>>>>> Documentation/devicetree/bindings/submitting-patches.rst
>>>>
>>>> I am going slightly mad (by Queen). That documents says:
>>>>
>>>> 1) The Documentation/ and include/dt-bindings/ portion of the patch
>>>> should
>>>> be a separate patch.
>>>>
>>>> and
>>>>
>>>> 4) Submit the entire series to the devicetree mailinglist at
>>>>
>>>> devicetree@vger.kernel.org
>>>>
>>>> Above I mentioned "series", not "patch". So 1) is a series of 3 patches
>>>> (2 changes to the DT binding file and 1 patch for the Khadas Edge2 DTS.
>>>> Is that correct?
>>>
>>> My bookmark to elixir.bootling does not work, so could not paste
>>> specific line. Now it works, so:
>>>
>>> https://elixir.bootlin.com/linux/v6.11-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L79
>>>
>>> The rule was/is:
>>> 1. Binding for typical devices always go via subsystem tree, with the
>>> driver changes.
>>> There can be exceptions from above, e.g. some subsystems do not pick up
>>> bindings, so Rob does. But how patches are organized is not an exception
>>> - it is completely normal workflow.
>>>
>>> 2. DTS *always* goes via SoC maintainer. DTS cannot go via any other
>>> driver subsystem tree. There is no exception here. There cannot be an
>>> exception, because it would mean the hardware depends on driver, which
>>> is obviously false.
>>
>> In case my message was not clear: we talk here about organizing
>> patchsets, not individual patches. If you ask about patches, then DTS,
>> bindings and driver are all separate patches. This set already is split
>> like that, so this was fine and I did not comment on it. Only through
>> whom the DTS patch goes - separate tree.
>
> I used the "series" which is my term for "patchset". Sorry for
> confusion. So "[PATCH 3/5] arm64: dts: rockchip: Add AP6275P wireless
> support to Khadas Edge 2" should be submitted to rockchip soc related
> tree and the rest can go through the wireless-next tree. Got it.

Yes, this is how we have done before as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

