Return-Path: <linux-wireless+bounces-8628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4652E8FF24B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583DF1C262F3
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D401991D8;
	Thu,  6 Jun 2024 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5t7JCWJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9822197501;
	Thu,  6 Jun 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690580; cv=none; b=lm3hVEn2zRr86stBrgY7aDJGDsGABHw86RUlMHXwf7/0+0dmXTFFTdDgFeSbGWUf6gVzrC2gAqJ8ZwNH4fLewfXtH4NsVTzALuZIS2YDwaXP4BF5RSYi2AhvDXbF5rRPzT/veKO9aSVEv5kkAImfFdoa63A3+FNyb1u7dwC4wMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690580; c=relaxed/simple;
	bh=RKbbRu32NqEkkRGB9QCkrdA9I0E2J4HS53nellvn8CY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TiQlZpu03zOoGNYvP8eexSU3Xfhkrl4acHxv0EhOMwM4mc6LqPuZqkAdY0nEngbYnYyrd6fI005b19aCQu4stl9ggnjMy7jL8rRT/onhVFqJVaz85sO8Q2EtJm+ZKZornn9Vwb6AMqotRhMgKo4DCwhLlefGCT8TuiwvwxbQWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5t7JCWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D3CC2BD10;
	Thu,  6 Jun 2024 16:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717690580;
	bh=RKbbRu32NqEkkRGB9QCkrdA9I0E2J4HS53nellvn8CY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=f5t7JCWJ3/NUie/wjRKHnFdMtylLBoAicpBk5UVpokhsTN5HvKo94nckgDiFI+N0l
	 WpbcXDC9rUPdxsYtkArroDl79jYLyxLgsr9yEI75b5pp5f8w97FloGd+16dr0IMdqv
	 idErwwGzB/4tTmfftnjrcprVtG0dUCbRhw1rnzmUqcGZm6vREOfenBw4ECXhoFkqeW
	 FYUBmYpe3aXLgOy87Uxa/F6TuSnyw8NDW9kpsWPOBykVlWpU1Nrt1G+ck+lWW1ygzK
	 7URLl805hcLei5FSC9wvAWPc7CZOqtQ2tCig/5Qw2EeO/gH0DvzHn0HCoaWxTQmN3K
	 O7gQm0ww3/LXQ==
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
	<871q5aqiei.fsf@kernel.org>
	<CAMRc=McacZMP-51hjH+d8=PVe+Wgw4a8xWcv0sRPLJKL_gP=KQ@mail.gmail.com>
Date: Thu, 06 Jun 2024 19:16:14 +0300
In-Reply-To: <CAMRc=McacZMP-51hjH+d8=PVe+Wgw4a8xWcv0sRPLJKL_gP=KQ@mail.gmail.com>
	(Bartosz Golaszewski's message of "Thu, 6 Jun 2024 16:29:20 +0200")
Message-ID: <87sexqoxm9.fsf@kernel.org>
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

> On Thu, Jun 6, 2024 at 4:02=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrot=
e:
>
>>
>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>>
>> > On Thu, Jun 6, 2024 at 3:30=E2=80=AFPM Kalle Valo <kvalo@kernel.org> w=
rote:
>> >
>> >>
>> >> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>> >>
>> >> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> >> >
>> >> > Add a PCI compatible for the ATH11K module on QCA6390 and describe =
the
>> >> > power inputs from the PMU that it consumes.
>> >> >
>> >> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> >> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> >>
>> >> [...]
>> >>
>> >> > +allOf:
>> >> > +  - if:
>> >> > +      properties:
>> >> > +        compatible:
>> >> > +          contains:
>> >> > +            const: pci17cb,1101
>> >> > +    then:
>> >> > +      required:
>> >> > +        - vddrfacmn-supply
>> >> > +        - vddaon-supply
>> >> > +        - vddwlcx-supply
>> >> > +        - vddwlmx-supply
>> >> > +        - vddrfa0p8-supply
>> >> > +        - vddrfa1p2-supply
>> >> > +        - vddrfa1p7-supply
>> >> > +        - vddpcie0p9-supply
>> >> > +        - vddpcie1p8-supply
>> >>
>> >> Not sure if we discussed this before, but based on this I understand
>> >> that there can't be an DT entry for device pci17cb,1101 without all t=
he
>> >> supply properties? But there are QCA6390 devices with PCI id 17cb:1101
>> >> which do not need these supplies and already work. For example, my De=
ll
>> >> XPS 13 x86 laptop is one. Or anyone who manually installs QCA6390 boa=
rd
>> >> to their PCI slot and some of them might want to use DT, for example
>> >> setting qcom,ath11k-calibration-variant.
>> >>
>> >> This is not a blocker for me, just making sure that we are not breaki=
ng
>> >> any existing setups.
>> >>
>> >
>> > If they are already powered up without the need for the PCI pwrctl
>> > driver to do it, then they will work alright. Bindings don't affect
>> > functionality.
>>
>> Sure, I'm not worried about functionality. I'm worried that if I
>> there's, for example, an ARM based setup which uses DT and wants to use
>> a similar QCA6390 board that I have, and set
>> qcom,ath11k-calibration-variant in DT. In other words, I'm worried if
>> you are looking at this only for Snapdragon family of boards?
>>
>
> No, what I'm looking at is the entire QCA6390 package. That means WLAN
> *and* Bluetooth *and* the PMU that manages power.

I think we are just looking at this from different point of views. You
are looking at a datasheet (most likely for a Snapdragon based system)
and I'm looking what actual devices there are out in the field.

> If you're using the QCA6390 on a device-tree system then you should
> probably model at least the WLAN node and the PMU and the problem with
> supplies is fixed.

But why? If there are boards out there who don't need any of this why
would they still need to model all this in DT?

Based on the discussions I have heard only Snapdragon systems who
require all this configuration you describe. Of course there can be
other systems but I have not heard about those.

> But if you don't have the supplies, that's alright for downstream.

What do you mean downstream in this context?

>> Again, I don't see this as a blocker. I just want to understand how this
>> should work for all types of devices there are out there.
>>
>> > But if you have a QCA6390 then you have its PMU too and the bindings
>> > model the real-world hardware.
>> >
>> > IOW: your laptop should be alright but the supplies are really there
>> > which warrants adding them to the bindings.
>>
>> Sorry, not following here. Can you clarify your comment "the supplies
>> are really there"? You mean inside the PCI board? But that's not visible
>> to the kernel in anyway, the PCI board just works after I plug it in.
>> It's like a regular PCI device. So I don't understand why that should be
>> visible in DT, but I can very well be missing something.
>>
>
> I think you're thinking about some kind of detachable PCIe board with
> this chipset on it.

Exactly, a lot of WLAN boards are like this.

> I refer to the QCA6390 chipset itself which is also more than just
> PCI. The Bluetooth interface doesn't use PCI at all. On the boards I'm
> working on, the chipset is just soldered to the main board.

And I guess you are looking at Snapdragon boards only?

> If your detachable board "just works" then it must be wired in a way
> that enables WLAN the moment it's plugged in but this doesn't happen
> over PCI. The chipset has a power input and GPIOs to enable each
> module.

I don't know how the boards are implemented but it could be so. But from
host system point of view it's just a regular PCI device.

> Also: I doubt you need DT for your detachable board?

Sure, I don't need DT but that's not my point. My point is why require
these supplies for _all_ devices having PCI id 17cb:1101 (ie. QCA6390)
then clearly there are such devices which don't need it? To me that's
bad design and, if I'm understanding correctly, prevents use of
qcom,ath11k-calibration-variant property. To me having the supplies
optional in DT is more approriate.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

