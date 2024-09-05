Return-Path: <linux-wireless+bounces-12552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3CE96E1FB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02491C252FD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23817C9B9;
	Thu,  5 Sep 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGjxyBNW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFCD1803D;
	Thu,  5 Sep 2024 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560922; cv=none; b=jZDFKACzBp8feSe/tSzU+FipVPOGFFtRSUO36FbuKxYP2lJ2dyQbcYS1H3I1WvEmUdECLcGeS9BoIGcesCamqs6X9jOaFeNIE7bkIG+0gu8vmK2u2q+vZLPMzcbXyPIgygyc9IZm8QZACUHUk6gwEQOeehi15TyLG3u0pme3ONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560922; c=relaxed/simple;
	bh=f7E3AztuRKMZ28p4LyFuIOxzMggsHH+GtAi8Hcdna/o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lD1PtZklZfqteyo4ZqOAKwxWWIfNngv+LK6qMYWoFRX6E0nOOu3/m0bsmtmmoK9+l7EaK/4uZ+SLypLiXcVUCd90NnY+BnW3VlCN9BBg39Ae+fZ8Ro/hqzM5x6m6KvD3DKsveLtwNrG7TmVO2EM25g5X1IgnBv9pZPQhPRVKmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGjxyBNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6951FC4CEC3;
	Thu,  5 Sep 2024 18:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725560920;
	bh=f7E3AztuRKMZ28p4LyFuIOxzMggsHH+GtAi8Hcdna/o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RGjxyBNWFIjT0UV3k85KNMQ/C8AmP1eZPymbVkmmAeHO+w9izHOhUHUbt6IdZjUsX
	 Em7OWJPKgEi0qYauywdcZE5zP1W+HBk0KVfG+kxWfzIu6fQ69oKZryVf0cMduv8MD5
	 /vaAjz7ThafuSkdFPJ+J/c3RCXax/c9OdNPz1N9cDnMmwRYgy1Ni9y1zp85eJxNVGK
	 ocORw5/Vj2GSKuXf3ChkJ4YzMCnezms/KgokuHTEV854SPtDaIwoxqPP28g9iEOwe5
	 h95lzF9t/6XyA65YcxpSX5vVsnyMEHxigBsFVDOzcDkCVQ+226l9MzpcRkXUqtoF2T
	 lYHR2RzLUVGiw==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Jeff Johnson
 <jjohnson@kernel.org>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  ath11k@lists.infradead.org,  linux-kernel@vger.kernel.org,  Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the
 inputs of the ath11k on WCN6855
References: <20240814082301.8091-1-brgl@bgdev.pl> <87a5hcyite.fsf@kernel.org>
	<CAMRc=Mcr7E0dxG09_gYPxg57gYAS4j2+-3x9GCS3wOcM46O=NQ@mail.gmail.com>
	<87y146ayrm.fsf@kernel.org>
	<CAMRc=Mfes+=59WP8dcMsiUApqjsFrY9iVFEdKU6FbTKAFP1k_A@mail.gmail.com>
Date: Thu, 05 Sep 2024 21:28:35 +0300
In-Reply-To: <CAMRc=Mfes+=59WP8dcMsiUApqjsFrY9iVFEdKU6FbTKAFP1k_A@mail.gmail.com>
	(Bartosz Golaszewski's message of "Thu, 5 Sep 2024 20:19:34 +0200")
Message-ID: <878qw6hs4s.fsf@kernel.org>
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

> On Thu, Sep 5, 2024 at 5:47=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrot=
e:
>>
>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>>
>> >> > +  - if:
>> >> > +      properties:
>> >> > +        compatible:
>> >> > +          contains:
>> >> > +            const: pci17cb,1103
>> >> > +    then:
>> >> > +      required:
>> >> > +        - vddrfacmn-supply
>> >> > +        - vddaon-supply
>> >> > +        - vddwlcx-supply
>> >> > +        - vddwlmx-supply
>> >> > +        - vddrfa0p8-supply
>> >> > +        - vddrfa1p2-supply
>> >> > +        - vddrfa1p8-supply
>> >> > +        - vddpcie0p9-supply
>> >> > +        - vddpcie1p8-supply
>> >>
>> >> Like we discussed before, shouldn't these supplies be optional as not
>> >> all modules need them?
>> >>
>> >
>> > The answer is still the same: the ATH11K inside a WCN6855 does - in
>> > fact - always need them. The fact that the X13s doesn't define them is
>> > bad representation of HW and I'm fixing it in a subsequent DTS patch.
>>
>> But, like we discussed earlier, M.2 boards don't need these so I think
>> this should be optional.
>>
>
> If they are truly dynamic, plug-and-play M.2 boards then they
> shouldn't need any description in device-tree. If they are M.2 sockets
> that use custom, vendor-specific pins (like what is the case on
> sc8280xp-crd and X13s) then the HW they carry needs to be described
> correctly. We've discussed that before.

Sigh. Please reread the previous discussion. In some cases we need to
set qcom,ath11k-calibration-variant even for M.2 boards.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

