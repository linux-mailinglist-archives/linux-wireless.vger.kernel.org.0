Return-Path: <linux-wireless+bounces-8620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496048FE84E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 16:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBA1283437
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0B19645C;
	Thu,  6 Jun 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGSpgk2S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E44195FC6;
	Thu,  6 Jun 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682523; cv=none; b=pPhRGc3+eF02CE1hMBmAU0Izw00W2BddFeB3x6we6zmSJbTt5hF2ofO0GTAl4p9+7FE5wwKV9UUDLKM0AvEwesYEjWX+AWXurmBHrapTiKD3Fk4/G42MCXQBDdw3rMIYdK9yZ+mPrmgCls+m2lLE9RgiFfo16GFzT0fLsAQjjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682523; c=relaxed/simple;
	bh=ivsf4NbZZPAamDEi3OCHaSjrBCmG4UqHfSgu3HZ5PWY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uMgY8E7GdivOGj22MEvTL/nH38wYVkxLH1M+xh/FsAKW1V/jSq/f0XvfP230ZcoXNCmW+fsyIE23lA7VjvhC+CZLd90BgXe/ym0Vkf5OvCCMuowfkRC9A8D9Edd5TK6rwB6Wvhy7smsr39HPqOVXeG41O84BZ2+LSAaI2Kb9Bh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGSpgk2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55343C2BD10;
	Thu,  6 Jun 2024 14:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717682522;
	bh=ivsf4NbZZPAamDEi3OCHaSjrBCmG4UqHfSgu3HZ5PWY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=uGSpgk2S9Q99QsCDrnFKgKraNdbOOhYSONYIIH2BHVK2ycaCv0j+dmU4CbWH9oBsl
	 /J8x10c81VUUGgH+F+o5iFK8iJ1N3/hdDgSJpOL1eMQ64ggEw7IYNBeyUIg1QS0kuY
	 Lym15z8f+QhlPxGLzLuxIEHUmDvZAvWyIa8AQ9O+MCJ4+iA9TEZTreiq6kGUHPKhy2
	 l5LxMFSLbsqNE1sagCmLT/7GMCy/HoZtA3CTZiOAwK5tf6EVyW4/g5jr+XaV5B9ReZ
	 7Bsrq9LThBfrwDEkz9kIRyRY1w8DCgbIRo9Vfe2lwE9W2LSIGgnws/KaPOes7FDA1J
	 YXpduBI7BQwFA==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Jeff Johnson
 <jjohnson@kernel.org>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  ath11k@lists.infradead.org,  linux-kernel@vger.kernel.org,
  ath12k@lists.infradead.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
References: <20240605122106.23818-1-brgl@bgdev.pl>
	<20240605122106.23818-2-brgl@bgdev.pl> <87h6e6qjuh.fsf@kernel.org>
	<CAMRc=MdiKxtnN+g92RUTXdOydaPV5M2u5iUdKyE2SNvDkdXAjg@mail.gmail.com>
Date: Thu, 06 Jun 2024 17:01:57 +0300
In-Reply-To: <CAMRc=MdiKxtnN+g92RUTXdOydaPV5M2u5iUdKyE2SNvDkdXAjg@mail.gmail.com>
	(Bartosz Golaszewski's message of "Thu, 6 Jun 2024 15:35:47 +0200")
Message-ID: <871q5aqiei.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> On Thu, Jun 6, 2024 at 3:30=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrot=
e:
>
>>
>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>>
>> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> >
>> > Add a PCI compatible for the ATH11K module on QCA6390 and describe the
>> > power inputs from the PMU that it consumes.
>> >
>> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> [...]
>>
>> > +allOf:
>> > +  - if:
>> > +      properties:
>> > +        compatible:
>> > +          contains:
>> > +            const: pci17cb,1101
>> > +    then:
>> > +      required:
>> > +        - vddrfacmn-supply
>> > +        - vddaon-supply
>> > +        - vddwlcx-supply
>> > +        - vddwlmx-supply
>> > +        - vddrfa0p8-supply
>> > +        - vddrfa1p2-supply
>> > +        - vddrfa1p7-supply
>> > +        - vddpcie0p9-supply
>> > +        - vddpcie1p8-supply
>>
>> Not sure if we discussed this before, but based on this I understand
>> that there can't be an DT entry for device pci17cb,1101 without all the
>> supply properties? But there are QCA6390 devices with PCI id 17cb:1101
>> which do not need these supplies and already work. For example, my Dell
>> XPS 13 x86 laptop is one. Or anyone who manually installs QCA6390 board
>> to their PCI slot and some of them might want to use DT, for example
>> setting qcom,ath11k-calibration-variant.
>>
>> This is not a blocker for me, just making sure that we are not breaking
>> any existing setups.
>>
>
> If they are already powered up without the need for the PCI pwrctl
> driver to do it, then they will work alright. Bindings don't affect
> functionality.

Sure, I'm not worried about functionality. I'm worried that if I
there's, for example, an ARM based setup which uses DT and wants to use
a similar QCA6390 board that I have, and set
qcom,ath11k-calibration-variant in DT. In other words, I'm worried if
you are looking at this only for Snapdragon family of boards?

Again, I don't see this as a blocker. I just want to understand how this
should work for all types of devices there are out there.

> But if you have a QCA6390 then you have its PMU too and the bindings
> model the real-world hardware.
>
> IOW: your laptop should be alright but the supplies are really there
> which warrants adding them to the bindings.

Sorry, not following here. Can you clarify your comment "the supplies
are really there"? You mean inside the PCI board? But that's not visible
to the kernel in anyway, the PCI board just works after I plug it in.
It's like a regular PCI device. So I don't understand why that should be
visible in DT, but I can very well be missing something.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

