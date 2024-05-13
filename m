Return-Path: <linux-wireless+bounces-7596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DCB8C42FC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 16:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77542820C2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 14:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40663153803;
	Mon, 13 May 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNmtCVJw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266350279;
	Mon, 13 May 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609765; cv=none; b=oZMjnp1LcdFhMjhc01/T/vG3UXoOLHEdVk6bEKO+07sB9W6aZpub21QILLg84j+jQqdWhG/6AKXt0c9gujDCjcIXxRFSzXiQr2+FnMT/6ZbbZa0/GcYV5aWLvN8I9nOBcMwR/ww4Es3ilTYlC2U64Z4nXeUd9dWMOaUr3wS4z00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609765; c=relaxed/simple;
	bh=ztDLgSBwpXs1XqFtFOt86T1h2DMz/XQmvsHWKSx1FeM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=qH3IfW0t/e68Mfr+US5q7Zjow8q0Qi9wcQzEn5V7cEPxjschRGGLuplNHY4IJE2dMVX++RbFNSWle5UkqcUop2q3iz+bRMnfc5N88nyTkIOK29jycLNBiuVkSdYRL3aPF9hVMi9hFpVOGUzATxfC6SEcaz7LBrE3Ahvsli2Z+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNmtCVJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2D4C32781;
	Mon, 13 May 2024 14:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715609764;
	bh=ztDLgSBwpXs1XqFtFOt86T1h2DMz/XQmvsHWKSx1FeM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DNmtCVJwPDEsfWvcPiiLOyHBC4Rmy3N3hPBcJgLbFVdGL8tHpmNpfu4Vbqle0QPY4
	 PsFmfqWo0euv1DYfjyazS7BPjAgu2LTVgezqGPm9PxM7e0esVeZqPW7t+v6T93jjh+
	 oLp/uW4uSLL1EqSJvj66pxuE+tM1rIPn1thedJosCmoambJFEWpeKmB0BwLKxxxN1o
	 BFiIuyhP0Mmr5KCKhLM7KXupG3G7/QIeb6U1p0wxqNaetUNsFDNkd9ZSNwR+7tDXwX
	 g40rXpANPwJFhlLLJbNdWUtZt88PHFvjJDLpgwPj3gv6RlI/Gf62diIjizSch2FHXZ
	 nPSCPQ1o9+U1Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr>
References: <54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT
 <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171560975908.1690511.498631481702370762.kvalo@kernel.org>
Date: Mon, 13 May 2024 14:16:00 +0000 (UTC)

Marc Gonzalez <mgonzalez@freebox.fr> wrote:

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
> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

71b6e321e302 dt-bindings: net: wireless: ath10k: add qcom,no-msa-ready-indicator prop
6d67d18014a8 wifi: ath10k: do not always wait for MSA_READY indicator

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


