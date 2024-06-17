Return-Path: <linux-wireless+bounces-9053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D6C90A924
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 11:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54ABE286E5B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 09:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD5E19069D;
	Mon, 17 Jun 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1c5oIuT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE1190694;
	Mon, 17 Jun 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615379; cv=none; b=CZG0vAjbL7gnHE80XagZxhWcrLtd0g/iqTA0OoH+y784cAg3vVPm1Twe6/ZECD0HGjaDQhd7NjH6WrTnt/PL6yoy1Cmr+aKMuIOOkQImFKSFCQLLwdCXE+pao8TSglTrHALngQZn1sT9z6gO1kWwtpNTNpVr2ETur5/IhZp1HR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615379; c=relaxed/simple;
	bh=CFsb4JRR8B7+LNbbg/vD4+mfvHSBhr5GHHr0I+YW3Zc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IKzzaJm+catIrS1coFwXGlS2UYpOepUaksgD1AgweXfOUpPtPjcyHEZyaacDMv+3sFzl4L0uk9pp0KQ4stnk7svodTsM+q/Ke8xMeRPbLxkEHBKQqBoVXmCmG/irNwjCrh2Qk+I/4PZi2c6PvciHYvbDL4p0+SkKzgy66pxRFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1c5oIuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C68C3277B;
	Mon, 17 Jun 2024 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615379;
	bh=CFsb4JRR8B7+LNbbg/vD4+mfvHSBhr5GHHr0I+YW3Zc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=G1c5oIuTePKfG2RzKc8tjI5+qJyx22PFYRthWIJb40HJGySFJR02dRUwTKxt8qCdV
	 QvMWlvTPpO/998/8121SGDWwPusP7s+ExTE/Mk20ukPkEnUI+aoPe4tZHRTQGmerON
	 WqyW5MrPNbTFAdSkUk+XoRj/xih/OjLlaE/Ve5bbghMw2lUdh6S9P2XvmRJ5QTNAoE
	 CjoOzYnL4feeyss7uNmDJom8g7ut1HyCz6Dx7KdAH23aRkzj6r+9nvearD04vM9mjd
	 nOVkiXu/A70y1Bsye0WO/tO+wrzx3cUmIHjPmDTTrL4ZL9hgwCUSg85SwE+tcqewxk
	 5+y7QOzLvi2gg==
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
	<87ikyenx5c.fsf@kernel.org>
	<CAMRc=MdPQu-r4aaeag9apYP1-FoQ2-_GAk_qnHqDz-jWibRDFQ@mail.gmail.com>
	<CAMRc=Mfsqnfy-Q++QyZNmsYoV72hUoNFEDCW6KZ0H_MEHEe5Rw@mail.gmail.com>
Date: Mon, 17 Jun 2024 12:09:33 +0300
In-Reply-To: <CAMRc=Mfsqnfy-Q++QyZNmsYoV72hUoNFEDCW6KZ0H_MEHEe5Rw@mail.gmail.com>
	(Bartosz Golaszewski's message of "Fri, 14 Jun 2024 09:18:14 +0200")
Message-ID: <878qz4kkaa.fsf@kernel.org>
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

> On Wed, Jun 12, 2024 at 2:52=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>>
>> On Wed, Jun 12, 2024 at 2:49=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wr=
ote:
>> >
>> > Bartosz Golaszewski <brgl@bgdev.pl> writes:
>> >
>> > >> >> Sure, I don't need DT but that's not my point. My point is why r=
equire
>> > >> >> these supplies for _all_ devices having PCI id 17cb:1101 (ie. QC=
A6390)
>> > >> >> then clearly there are such devices which don't need it? To me t=
hat's
>> > >> >> bad design and, if I'm understanding correctly, prevents use of
>> > >> >> qcom,ath11k-calibration-variant property. To me having the suppl=
ies
>> > >> >> optional in DT is more approriate.
>> > >> >>
>> > >> >
>> > >> > We require them because *they are physically there*.
>> > >>
>> > >> I understand that for all known DT QCA6390 hardware, the supplies s=
hould
>> > >> be provided thus they should be required. If in the future we have
>> > >> different design or we represent some pluggable PCI card, then:
>> > >> 1. Probably that PCI card does not need power sequencing, thus no DT
>> > >> description,
>> > >> 2. If still needs power sequencing, you can always amend bindings a=
nd
>> > >> un-require the supplies.
>> > >>
>> > >>
>> > >> Best regards,
>> > >> Krzysztof
>> > >>
>> > >
>> > > Kalle, does the above answer your questions? Are these bindings good=
 to go?
>> >
>> > To me most important is that we are on the same page that in some cases
>> > (eg. with M.2 boards) the supplies can be optional and we can update t=
he
>> > bindings doc once such need arises (but we don't make any changes right
>> > now). Based on point 2 from Krzysztof I think we all agree, right?
>> >
>> > Just making sure: if we later change the supplies optional does that
>> > create any problems with backwards compatibility? It's important that
>> > updates go smoothly.
>>
>> No, you can always relax the requirements alright. It's only when you
>> make them more strict that you'll run into backward compatibility
>> issues.
>>
>> Bart
>
> Kalle,
>
> Is that ok with you? Can we get that queued to avoid the new
> check_dtbs warnings in next when the DTS changes land?

Yes, this patchset is already on our pending branch and should be
applied soon. I was on a long weekend hence the delay.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

