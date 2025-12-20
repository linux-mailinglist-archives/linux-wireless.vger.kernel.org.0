Return-Path: <linux-wireless+bounces-30020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A17CD2BE1
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 10:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80BD4300F591
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5022FD7D3;
	Sat, 20 Dec 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd7yPfd6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF92FD697;
	Sat, 20 Dec 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766221979; cv=none; b=PJxchRqbiaUlbz1W35lh4+sIm4gtOaJTxeyQTrvZs3zCQMIDNku+nc3C1qhfCXkMt/JjEXSOckaI6Eawm7gjw229QBvwkcZ39/ZSitlerYpMIijWuyqiD8WBhx6+zyFq+b7EdF69dK598ofGozd3iR/FeVQ5Lj18L567PI8OqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766221979; c=relaxed/simple;
	bh=P4qYNNBS+jFWt7ktTI5eDbZe8+DLAV563TzTkaM5xGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2jxjvbYIRpq8DDlDlMHwd4+TixFlB/ChsuT7MEqavMU5r2TkEhcKC4I4Co56h5ehJkp/BiBcHrdOG2q7JS8QfF8TwTDf4Up08Tp0+TEof5wnaHdpQULu8nILkQeMs6vVu5pHBp+qUBDNgfi1TtzBpPdUraU/bbarFHubJA4P8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd7yPfd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F302C4CEF5;
	Sat, 20 Dec 2025 09:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766221978;
	bh=P4qYNNBS+jFWt7ktTI5eDbZe8+DLAV563TzTkaM5xGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nd7yPfd6hOpB8pZReM+Due51lWaPtyx78AALvWinABwxP5VQGk2ylRs045NX9cOKa
	 OUa5K9hLLtsFQ8ezoom3KiD+CzVBDfkpCaVs99vtsyJv2hTPd1RyAp9pNWci0HS6KG
	 lmdCVQKDQuQT98pq5vjaL0WGGoQ9xKER0RYo5owxR+kULJ/VpM0wr90eHZprghDUTy
	 Dt9UVs6T3+/zwWBoMLw27td98RDnbxbZl9NnKxBEIy6nB7BHA0ToL54w+4TidHrDEb
	 ut8e3613kJR0GHcGZfqBxOIS/PcuCOE69jAIwXdvAp/Ov3+GauCpNSosXBqwHhaG4L
	 ViIO+X9MuK9OQ==
Date: Sat, 20 Dec 2025 10:12:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?SsOpcsO0bWU=?= de Bretagne <jerome.debretagne@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org, ath12k@lists.infradead.org, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Dale Whinham <daleyo@gmail.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: arm: qcom: Document Microsoft
 Surface Pro 11
Message-ID: <20251220-dainty-successful-quail-69cbef@quoll>
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
 <20251220-surface-sp11-for-next-v5-1-16065bef8ef3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251220-surface-sp11-for-next-v5-1-16065bef8ef3@gmail.com>

On Sat, Dec 20, 2025 at 01:21:58AM +0100, J=C3=A9r=C3=B4me de Bretagne wrot=
e:
> Add the compatibles for the Qualcomm-based Microsoft Surface Pro 11,
> using its Denali codename.
>=20
> The LCD models are using the Qualcomm Snapdragon X1 Plus (X1P64100),
> the OLED ones are using the Qualcomm Snapdragon X1 Elite (X1E80100).
>=20
> Due to the difference in how the built-in panel is being handled
> between the OLED variant and LCD one, it is required to have two
> separate DTBs, so document the compatible string for both variants.
>=20
> Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


