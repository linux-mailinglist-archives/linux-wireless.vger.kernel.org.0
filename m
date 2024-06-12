Return-Path: <linux-wireless+bounces-8878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B39052C6
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747E61F26A83
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F4170856;
	Wed, 12 Jun 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJkZjo5x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964BA16F8F6;
	Wed, 12 Jun 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196159; cv=none; b=BLgf92qD/M7LfbnxKGHJORlzc92pvbd3h1qEGHu0b+kXZB7akOP4gbyE6fPcN4KP8w9dCZ0z/eCEFzf0lnKAs+WfiE6PUp6WHsQOLgxOC1DkDmAXfKtQbR6eIZY+XPAFy8QYja0BZ9aHLxUZv1D1K5CBQsidUjNU75OVNYBP6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196159; c=relaxed/simple;
	bh=z+KLxZwv3KVjMH+GO5G/9Jy6q5pczKwfg5UxIKL9ucM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lV/PyxFgKOCJjqJCDHVqAfpqTBMRDQ2KAuLMO7JuwX5fvpNIuRu3Cz/D6oFKJ1nGT2POtyT5f+2IAWAgJv4pj0+6HafvqhBzv/Izl+N3r6pNDPFmoPjzE1kqVpn1XUHLzz91Tj9YWbzAFfwfRl0KOtvxXIe0psFIki3hkiZ0Lxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJkZjo5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D9FC3277B;
	Wed, 12 Jun 2024 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718196159;
	bh=z+KLxZwv3KVjMH+GO5G/9Jy6q5pczKwfg5UxIKL9ucM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kJkZjo5xs0lK86YklafnNU927mRi4jWdl0SCGkcphfa1Z9n6VxvAqQaJxC1gGKSJL
	 RoYSkIqL4CUGFKVz5HYkntqCEGAENNgD7w4d4FJS/6uVur/sAgna6t3xIvSZskMA/p
	 /VwEt3XVxLyFLVDui40jlEas+ijlXkVJ16ZphJ2DNl6vJKAS9MyqzY1eeFgKafp8xn
	 ZUNWCt5FywUYQkmoATvI1+GZTDKK4AhAsDmmcI8y2Hy7FDnjzSDJE7IgrTAKhAeXnq
	 cE9u+gLYEpoAJQ7sz1AaBmUwdaD55b90h9Ce+/V39ScOZUkvnLCOKAN/sB93TfGn59
	 YF6m2J0Q8nbGw==
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
	<87sexqoxm9.fsf@kernel.org>
	<CAMRc=McYAbhL5M1geYtf8LbgJG5x_+ZUFKXRuo7Vff_8ssNoUA@mail.gmail.com>
Date: Wed, 12 Jun 2024 15:42:33 +0300
In-Reply-To: <CAMRc=McYAbhL5M1geYtf8LbgJG5x_+ZUFKXRuo7Vff_8ssNoUA@mail.gmail.com>
	(Bartosz Golaszewski's message of "Thu, 6 Jun 2024 20:08:11 +0200")
Message-ID: <87msnqnxhi.fsf@kernel.org>
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

> On Thu, Jun 6, 2024 at 6:16=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrot=
e:
>
>>
>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>>
>> > On Thu, Jun 6, 2024 at 4:02=E2=80=AFPM Kalle Valo <kvalo@kernel.org> w=
rote:
>> >
>> >> Sure, I'm not worried about functionality. I'm worried that if I
>> >> there's, for example, an ARM based setup which uses DT and wants to u=
se
>> >> a similar QCA6390 board that I have, and set
>> >> qcom,ath11k-calibration-variant in DT. In other words, I'm worried if
>> >> you are looking at this only for Snapdragon family of boards?
>> >>
>> >
>> > No, what I'm looking at is the entire QCA6390 package. That means WLAN
>> > *and* Bluetooth *and* the PMU that manages power.
>>
>> I think we are just looking at this from different point of views. You
>> are looking at a datasheet (most likely for a Snapdragon based system)
>> and I'm looking what actual devices there are out in the field.
>>
>> > If you're using the QCA6390 on a device-tree system then you should
>> > probably model at least the WLAN node and the PMU and the problem with
>> > supplies is fixed.
>>
>> But why? If there are boards out there who don't need any of this why
>> would they still need to model all this in DT?
>>
>
> Because this is what is there? The goal of the device tree is to
> describe the hardware. The fact we didn't describe it before doesn't
> make it correct.
>
>> Based on the discussions I have heard only Snapdragon systems who
>> require all this configuration you describe. Of course there can be
>> other systems but I have not heard about those.
>>
>
> DT is not configuration, it is description of actual hardware. It
> doesn't matter if Snapdragon systems are the only ones that actually
> *require* this description to make WLAN/BT functional upstream. The
> chipset would be the same on any PCIe board, it's just that the host
> systems wouldn't need to take care with its power sequence. But for a
> dynamic board like this, you don't need DT.
>
>> > But if you don't have the supplies, that's alright for downstream.
>>
>> What do you mean downstream in this context?
>>
>
> I mean: if you wanted to upstream the DT sources, then they should
> include the supplies AND the PMU node. But if you just want to make
> the WLAN run on some vendor kernel then you don't need to think about
> it, it will work.
>
>> >> Again, I don't see this as a blocker. I just want to understand how t=
his
>> >> should work for all types of devices there are out there.
>> >>
>> >> > But if you have a QCA6390 then you have its PMU too and the bindings
>> >> > model the real-world hardware.
>> >> >
>> >> > IOW: your laptop should be alright but the supplies are really there
>> >> > which warrants adding them to the bindings.
>> >>
>> >> Sorry, not following here. Can you clarify your comment "the supplies
>> >> are really there"? You mean inside the PCI board? But that's not visi=
ble
>> >> to the kernel in anyway, the PCI board just works after I plug it in.
>> >> It's like a regular PCI device. So I don't understand why that should=
 be
>> >> visible in DT, but I can very well be missing something.
>> >>
>> >
>> > I think you're thinking about some kind of detachable PCIe board with
>> > this chipset on it.
>>
>> Exactly, a lot of WLAN boards are like this.
>>
>> > I refer to the QCA6390 chipset itself which is also more than just
>> > PCI. The Bluetooth interface doesn't use PCI at all. On the boards I'm
>> > working on, the chipset is just soldered to the main board.
>>
>> And I guess you are looking at Snapdragon boards only?
>>
>
> But what is your point?

My point (again) is that to me it look likes that you are looking this
only for Snapdragon type of devices and ignoring the rest. I am looking
at this to support _all_ type of devices and I want to make sure that we
don't have any artificial restrictions to use ath11k or ath12k devices
in upstream Linux.

I could not find a public example of a QCA6390 M.2 board like I have, but
here's one for QCA2066:

https://compex.com.sg/shop/wifi-module/wlt206h-wifi6-ble5-1-11ax-qca2062-qc=
a2065/

QCA2066 is a mobile chipset supported by ath11k, similarly like QCA6390.
It's just newer and different features, and with a different PCI id. In
the past using these kind of M.2 boards for Wi-Fi has been quite common
but don't know how commit it is nowadays.

>> > If your detachable board "just works" then it must be wired in a way
>> > that enables WLAN the moment it's plugged in but this doesn't happen
>> > over PCI. The chipset has a power input and GPIOs to enable each
>> > module.
>>
>> I don't know how the boards are implemented but it could be so. But from
>> host system point of view it's just a regular PCI device.
>>
>
> And you don't need DT anyway for this type of devices.

I wish we wouldn't need to use DT for such M.2 boards, but we do need to
use qcom,ath11k-calibration-variant in some cases when the device (or
the firmware) doesn't provide unique enough identifier to choose the
correct board file automatically. I already mentioned the property in my
earlier emails.

I hope this clears up what I'm trying to say.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

