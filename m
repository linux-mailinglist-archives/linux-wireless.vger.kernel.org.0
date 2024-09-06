Return-Path: <linux-wireless+bounces-12589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C659496EBD1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 09:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39D21C21C6E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 07:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC6714375A;
	Fri,  6 Sep 2024 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8lzerT9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783F17C9B
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607107; cv=none; b=jTH1LsC6l3LtQxfNnLpGmD3iZrDex6TA/qOPBLX0cIo85l2yROP0A0sbUFJSQ4TTlafJnX3IqrMteooH1TABM/wYgZDtlVWSTmugmSrURL20gzKdZCCfBNFY1/uEpImVl1Pzd6miagcGVTcKe0GjXRBWy9iY40Tn4mU2VmGhcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607107; c=relaxed/simple;
	bh=pE8/S+nk4iuCm6qCWQDIB3aZmhjm1EoqOeIPcFCyCjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZxZnglPARjm2KTL1WMoGsmkPvvRrk2NcMFhcVslJX3Bg+g7WHl0VFcV0bbHdXNIwVpx945Db/AyuR2qXuipsxka91ziexF8hrV7Cj6vzFoCkxZzprBY7mUEjQ5I09OzUcJorxPKnSjHsaR7e4siv+XvWXvhb0utJaMyzLqXdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8lzerT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A68C4CEC4;
	Fri,  6 Sep 2024 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725607106;
	bh=pE8/S+nk4iuCm6qCWQDIB3aZmhjm1EoqOeIPcFCyCjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h8lzerT9MERhhMTgZuB1Vn+JTP8E6X+hG8Wt9WDPedhbNeTeKCmS7FHOBdNi6BI3e
	 4/zNKl+h2c3Qq9YNBQJ1l5/3RfJSEESUAEgRISUScWcvoUD21Ovz+hXOH1gJttxkCf
	 On8CKwCSaJnKt9ctz0AtAwkBWcZQwrB4PnDLESLgQwVSzIaVbfLGbd3Wp7EfyVUvWL
	 WYkTvUNCC6CMEEIF7jkOh93gGLsSGjjXmCn8C8jnL9D/7Kos28g+79dCR5dosJVK2f
	 oG0e6lPEL/yPjShVLjioiQy552OuoWHiMP4gR3dsnc9VtiEx3RZBO9kUO3JX8FXrNN
	 iS7DSqfZKAQKw==
Message-ID: <4241565c-c09a-4364-be02-d11d80d57b2c@kernel.org>
Date: Fri, 6 Sep 2024 09:18:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: net: wireless: ath9k: add new options
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org, toke@toke.dk,
 nbd@nbd.name, yangshiji66@outlook.com
References: <20240905180928.382090-1-rosenp@gmail.com>
 <20240905180928.382090-5-rosenp@gmail.com>
 <b666cc28-af93-4b7b-a446-adf3d1ef0fe0@kernel.org>
 <CAKxU2N_nAor8SjzSH2_0ch3Sp1XScP64DK6Ni6j-2wa8nBrMUw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAKxU2N_nAor8SjzSH2_0ch3Sp1XScP64DK6Ni6j-2wa8nBrMUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/09/2024 00:35, Rosen Penev wrote:
> On Thu, Sep 5, 2024 at 2:29 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 05/09/2024 20:09, Rosen Penev wrote:
>>> These platform_data options are now available for OF.
>>
>> This explains nothing. Describe the hardware, not driver.
>>
>>>
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>
>> <form letter>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC. It might happen, that command when run on an older
>> kernel, gives you outdated entries. Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
>> people, so fix your workflow. Tools might also fail if you work on some
>> ancient tree (don't, instead use mainline) or work on fork of kernel
>> (don't, instead use mainline). Just use b4 and everything should be
>> fine, although remember about `b4 prep --auto-to-cc` if you added new
>> patches to the patchset.
>>
>> You missed at least devicetree list (maybe more), so this won't be
>> tested by automated tooling. Performing review on untested code might be
>> a waste of time.
>>
>> Please kindly resend and include all necessary To/Cc entries.
> Will do.
>> </form letter>
>>
>>> ---
>>>  .../devicetree/bindings/net/wireless/qca,ath9k.yaml  | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
>>> index 0e5412cff2bc..5c293d558a94 100644
>>> --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
>>> +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
>>> @@ -44,6 +44,16 @@ properties:
>>>
>>>    ieee80211-freq-limit: true
>>>
>>> +  qca,led-active-high:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description:
>>> +      Indicates that the LED pin is active high instead of low
>>
>> Where is DTS user of it?
> None at this time. There are only downstream users.

We do not add stuff for downstream.

> 
> This maps to the led_active_high in ath9k_platform_device , which gets
> removed in a subsequent commit.
> 
> drivers/net/wireless/mediatek/mt76/mac80211.c uses led-sources as the
> name for the same purpose. Maybe rename?

Again, you add undocumented, unused compatibles along with unused
properties. We don't care about downstream kernels. You need upstream users.

Best regards,
Krzysztof


