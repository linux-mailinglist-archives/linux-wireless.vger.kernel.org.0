Return-Path: <linux-wireless+bounces-12534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD796DECE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 17:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB0028460F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C91A01DB;
	Thu,  5 Sep 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOXtCC74"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773D1A01D0;
	Thu,  5 Sep 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551234; cv=none; b=BaaGUbHLHpcTRicGWw958VF87tk4yxArG2H59KY2FbRkaujjXS1FLCIrIFYIzcWivox7OkzFjhPwodka8plhrpyADr0BGN/MoF2wRoxDsu0UpCIwzhd/ElyjrO5YqRYGuXM2Lf+F24m4YPIkgH2V1QpGIDGjnvJZu9sggxDydzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551234; c=relaxed/simple;
	bh=EAnWPkg+5+GfGadRDWc4j55kZwjPEaiqdZ04TSPhyos=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jZoyPH1e5WG1/4fCojL2T+j0bcxNEMIrL/+isbC8LHownDWg0Kr9sCUwpWrZfnGRTdG0tjIdOEKu2TWHKyqKC1g1wnl8XsnFYSm0t0pTwgPTHSmv8k6/1CMjtgb0Xg3sAMpjqPMfOld/x0xnW/xuTLWG8h/D5fXvUvZbkA3fmlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOXtCC74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165F8C4CEC3;
	Thu,  5 Sep 2024 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725551234;
	bh=EAnWPkg+5+GfGadRDWc4j55kZwjPEaiqdZ04TSPhyos=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HOXtCC74HGrL730QZmOaBJtnFJEObt0esD22qKWieMiWmCIZv1EIusQv3CuAdLftm
	 FfM5xsYk7cxqk0TR3X0VVe0JOv63+s3k65JqPegMz0YeBbYesr64f7gNLSH3V+lXVM
	 ZlXLV3FXD4A/kB2ZP4YhthlwH7MFA3YHqZlbQrMySYOopoaHxFlIRHy32c9Tc9sGoQ
	 xyuoV0j//LEbTfOtYSFItG247fuA9/Ay2Kvo+fEERs/w/GHRPk/qb68QVM9EjyrPT0
	 L+sXiWp1PRjS4U7RvUoB43gxKTwDaKzVkJUAir0YbTs9RMQtsFT7T1ulEPtzK1skHL
	 0Vc1C7ncqcXhQ==
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
Date: Thu, 05 Sep 2024 18:47:09 +0300
In-Reply-To: <CAMRc=Mcr7E0dxG09_gYPxg57gYAS4j2+-3x9GCS3wOcM46O=NQ@mail.gmail.com>
	(Bartosz Golaszewski's message of "Fri, 16 Aug 2024 11:10:00 +0200")
Message-ID: <87y146ayrm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

>> > +  - if:
>> > +      properties:
>> > +        compatible:
>> > +          contains:
>> > +            const: pci17cb,1103
>> > +    then:
>> > +      required:
>> > +        - vddrfacmn-supply
>> > +        - vddaon-supply
>> > +        - vddwlcx-supply
>> > +        - vddwlmx-supply
>> > +        - vddrfa0p8-supply
>> > +        - vddrfa1p2-supply
>> > +        - vddrfa1p8-supply
>> > +        - vddpcie0p9-supply
>> > +        - vddpcie1p8-supply
>>
>> Like we discussed before, shouldn't these supplies be optional as not
>> all modules need them?
>>
>
> The answer is still the same: the ATH11K inside a WCN6855 does - in
> fact - always need them. The fact that the X13s doesn't define them is
> bad representation of HW and I'm fixing it in a subsequent DTS patch.

But, like we discussed earlier, M.2 boards don't need these so I think
this should be optional.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

