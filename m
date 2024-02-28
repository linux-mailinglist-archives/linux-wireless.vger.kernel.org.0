Return-Path: <linux-wireless+bounces-4194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CEA86B131
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 15:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6673286E6D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED2D14F998;
	Wed, 28 Feb 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVtQg5dq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15332145341;
	Wed, 28 Feb 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129008; cv=none; b=B7iJMPSRGrHTjP7kgbNFviccYpESUu0qxLaTG86Cedh7QHjzwZzkz9VXMcMC4DU4xYWWowjtRY7cjykBqgeh8Y0l5QqO46L26twG+CkB/GJT4jI5wtl5WkgRkNhnATn4f7VDCYapboKbn835cJ9M2Koqn7WZPoSb0Ls2hXdFZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129008; c=relaxed/simple;
	bh=+29q9XzaWHOI+KXDSu5A9D/Iw9UMYbaTgyR8nbq20I4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=U/v/JL1dcvRantwLTQnF+IFlEP96YEjIl+VOaZodl61C2PLDp7O+R7ffNvARjsGtElm7lnCt1N4UmVT69oB5L8lxKlIOyjzU49j9wu82efHNEsmf28Pl17xk/ZQ7BKqPlEHtKfB3+rQnxsYKzbIPoiNE9VFo04kqui3BPSAKiKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVtQg5dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CDBC433C7;
	Wed, 28 Feb 2024 14:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709129008;
	bh=+29q9XzaWHOI+KXDSu5A9D/Iw9UMYbaTgyR8nbq20I4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DVtQg5dqjYxmDNhXd1PlqiQowWozLs8nLHUUZ9Kcg/3L+meJar1UQ2Yneuhe6h25N
	 OygDcReVGMLOzpc/p5LMSubHHZHNxdyLsLggaEoQgPdemlYoXgjV84xUmI8PDgifeI
	 EhlBr89wLuQQSP3/zZ9Zmj3QN+ZAsCoVHX7+nUl5MIvCtpzSmpLmAMG/frDFWkCOdk
	 CmkQNZf6D6NLQElejh1YTYZE12uvavAnVfX+ci+UEKVm2aBD13sT79oDK26D/H+qJK
	 vxtj3vR6L81P3xwRku6/NNOtONDVbsuJeRSggwNMkwv7ppei0RrKf8E3f7XF/hdgrw
	 3D5ayFU5ru/2w==
From: Kalle Valo <kvalo@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  ath10k
 <ath10k@lists.infradead.org>,  wireless <linux-wireless@vger.kernel.org>,
  DT <devicetree@vger.kernel.org>,  Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Pierre-Hugues Husson <phhusson@freebox.fr>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
	<b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
Date: Wed, 28 Feb 2024 16:03:24 +0200
In-Reply-To: <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> (Marc
	Gonzalez's message of "Wed, 28 Feb 2024 14:24:12 +0100")
Message-ID: <871q8wk7o3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

> The driver waits for this indicator before proceeding,
> yet some WCNSS firmwares apparently do not send it.
> On those devices, it seems safe to ignore the indicator,
> and continue loading the firmware.
>
> Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> index 7758a55dd3286..145fa1a3c1c6a 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> @@ -121,6 +121,14 @@ properties:
>        Whether to skip executing an SCM call that reassigns the memory
>        region ownership.
>  
> +  qcom,no-msa-ready-indicator:
> +    type: boolean
> +    description:
> +      The driver waits for this indicator before proceeding,
> +      yet some WCNSS firmwares apparently do not send it.
> +      On those devices, it seems safe to ignore the indicator,
> +      and continue loading the firmware.

This sounds more like a firmware feature, not a hardware feature. What
about having a flag in enum ath10k_fw_features in firmware-2.bin?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

