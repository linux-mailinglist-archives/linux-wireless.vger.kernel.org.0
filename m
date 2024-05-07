Return-Path: <linux-wireless+bounces-7291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435CA8BE6FA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 17:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D970B292D6
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D976616132B;
	Tue,  7 May 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPULlZ5s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E29161308;
	Tue,  7 May 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094334; cv=none; b=FpwfjqNlI9tkyQRVQOpC5VhBN+WVAwf3SmSUiVnU2yB1rVjEFT0KBNlE7xZwzu7tR++3abUsPZXOUD3e4+mn0NX6S2zc+JRw+HiDQiXeSG21kFr7/FTKQIoCy0Akrsv1KPL86nKi2astFOMauMAtULgmOqzWRKi694ONExwZrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094334; c=relaxed/simple;
	bh=VVeb/LlZcPst//x0wDQgatV0HpkM8V7tQznlTpAm+QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyQO1IJwfjlyNMhaNjPc0sj7DBDbjDJY/qlk8nUlr9ofdMLf1GamKPmSOtHRVeBUMV7Uw6M5U7Gqp2rWs1vGRnh77n2eIn9bl3GaqHFL9qroRDbon/bjzHDFQWyX6eQJp84HsFgntr/MMKVYeY8O2yWiNIjahxfYqazKBBEBhYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPULlZ5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC53C2BBFC;
	Tue,  7 May 2024 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094334;
	bh=VVeb/LlZcPst//x0wDQgatV0HpkM8V7tQznlTpAm+QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPULlZ5sCvp/thR6YELavA6A7tsYjvPFaihKBvsUJWSfk0t+iFaF+Abmaqz597+tk
	 gg1bRHkd1WU2Zp6QOdAIwrooUYsWET6XA6d8khuZXsriaBrU4GyUtr3EnIN2lY/cPS
	 pGOl7fAnP2ExrPyqoif8h+C9e3naaD8j/AlIgkvsaO623Nqy+0KWFN+trs8hAgUMbm
	 5++IXFV3JlAhQceJJGqKgEMT7GjfA4olT7XtHWcZEPM970k+m2WLOSleJKVDOuVYqZ
	 VaguSfHqu5t1eQM3J6q9NZxIC/YBD9ZLCSpaQh22HYR1uq26XxKp+nuceNAg9//eeL
	 LWpznNru1d0LQ==
Date: Tue, 7 May 2024 10:05:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: ath10k <ath10k@lists.infradead.org>, DT <devicetree@vger.kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pierre-Hugues Husson <phhusson@freebox.fr>,
	Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Alexey Minnekhanov <alexeymin@postmarketos.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	wireless <linux-wireless@vger.kernel.org>,
	Jami Kettunen <jamipkettunen@gmail.com>,
	MSM <linux-arm-msm@vger.kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Message-ID: <171509432258.482945.17084228193857427143.robh@kernel.org>
References: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
 <54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr>


On Mon, 29 Apr 2024 16:04:51 +0200, Marc Gonzalez wrote:
> The ath10k driver waits for an "MSA_READY" indicator
> to complete initialization. If the indicator is not
> received, then the device remains unusable.
> 
> cf. ath10k_qmi_driver_event_work()
> 
> Several msm8998-based devices are affected by this issue.
> Oddly, it seems safe to NOT wait for the indicator, and
> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
> 
> Jeff Johnson wrote:
> 
>   The feedback I received was "it might be ok to change all ath10k qmi
>   to skip waiting for msa_ready", and it was pointed out that ath11k
>   (and ath12k) do not wait for it.
> 
>   However with so many deployed devices, "might be ok" isn't a strong
>   argument for changing the default behavior.
> 
> Kalle Valo first suggested setting a bit in firmware-5.bin to trigger
> work-around in the driver. However, firmware-5.bin is parsed too late.
> So we are stuck with a DT property.
> 
> Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


