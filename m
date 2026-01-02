Return-Path: <linux-wireless+bounces-30292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A77BCEE876
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 13:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D39303DD23
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEA630FC09;
	Fri,  2 Jan 2026 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4vzuANR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BE30F55A;
	Fri,  2 Jan 2026 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356639; cv=none; b=A2IZ694Txy51fz5cSIIcFLysTwPEirCSxM6giZMSMlobSQJF8Wrd9NlNggNIuuQmiXqvtMPAAAIVkKnhlvi2Ma7+Pa9tmPBK7Bx3yp/JbeFuKwyusX7lvvem4e2TjarjQWFut/mDqWE5ufJI5qILPUVk3PnCQLB5VPWdqvITuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356639; c=relaxed/simple;
	bh=UFKKF1haRLgSTi4RG+IyCkOVonss33GrfgWTfx8VFj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz/ZE/rpQQnr2zZNyHK8lY3Dsr5EgYHttAHxPESinGs/MgGvKA4eXc6ytZC1e/4Fo/Ul3SpfA3Us+QLK5T4KPS7qfHH0+nyMju1NgULKK2R0kTbwib9e7FzYnMZ9RbeYVF6k57XX6q3gISK2qU6TZHkMRK2WryPlzhADOEWV2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4vzuANR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1EDC116B1;
	Fri,  2 Jan 2026 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767356638;
	bh=UFKKF1haRLgSTi4RG+IyCkOVonss33GrfgWTfx8VFj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4vzuANRs/MKY/qs8qq0MJvtp8uzAfIK0t0Nq/f97q9oZtXOL267hkPvzCQDFRrF/
	 bOefuMnqSyBXiPUT55snSNbPneHYuOoy6h+was+izicXzxDY2RyakDOjAnCIvZdPum
	 iRqGw4CdAY9s4jBAGG7gzqCYUEVJ32IQRMkGJYDw577TipItqMKWIAF8s6asVKyTTf
	 Ci8ORTHWb7KbQfEwsYtB/tDqXLQlMc3ptzpAg/84UQiMrvGEncOuOvO9/7FdlVAfur
	 MFi8mYG4AlrCWUKNv5UMDiGEIvZnK1Dw3mg+uVcMfpl9zslr5NIShF7/4D8OwZqZZm
	 06S+Fz2WgoARA==
Date: Fri, 2 Jan 2026 13:23:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/14] regulator: dt-bindings: qcom,qca6390-pmu: describe
 PMUs on WCN39xx
Message-ID: <20260102-exotic-spectacular-ladybug-0dc1c5@quoll>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-1-1ff4d6028ad5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251231-wcn3990-pwrctl-v1-1-1ff4d6028ad5@oss.qualcomm.com>

On Wed, Dec 31, 2025 at 01:35:51AM +0200, Dmitry Baryshkov wrote:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,wcn3950-pmu
> +              - qcom,wcn3988-pmu
> +              - qcom,wcn3990-pmu
> +              - qcom,wcn3991-pmu
> +              - qcom,wcn3998-pmu
> +    then:
> +      properties:
> +        wlan-enable-gpios: false
> +        bt-enable-gpios: false
> +      required:
> +        - vddio-supply
> +        - vddxo-supply
> +        - vddrfa1p3-supply
> +        - vddch0-supply
> +        - vddch1-supply

You need new binding file. 3/5 above are not shared with any other
device.

> +
>    - if:
>        properties:
>          compatible:
> 
> -- 
> 2.47.3
> 

