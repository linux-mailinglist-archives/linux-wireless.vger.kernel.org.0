Return-Path: <linux-wireless+bounces-4421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43929873220
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 10:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AD61F2259E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF855FDB3;
	Wed,  6 Mar 2024 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqRh2GP2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FB5DF14;
	Wed,  6 Mar 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715744; cv=none; b=Eg3Q4Fa7WFHyZN1cbaXldi2+v0yEg4DmVObcPdskdY+uAoXsnuil0e1du5RTTNPbESALWfRXDipbLpEjP5pH/mH8ThoOw9s8x50iwTda0wux+sCIO9cDE49vaUzm+TaeHpxz08dooFzHk4CGDAKDTDS7gpHqwpEA6MjfzruhqpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715744; c=relaxed/simple;
	bh=pr7f95H/+sMoxZtOtUu1wtvZwxTvJ5iV+D3khX3JPOo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TBABJtOrvm9wZwtLz573k8iF6UOPzzivhZbu+EEY1StOuUaCBui3TE5B6DqPVDmfnMuDCjNQ7M+poV/6njNBuoPw6a+tgdhPLtEfUYZyoL7FP5WGGVIOnphBx0cmVkVffy4zTZYkLLV+dHRs+beU0AxRoH7fqhDWNIFSqReusS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqRh2GP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56649C43390;
	Wed,  6 Mar 2024 09:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709715743;
	bh=pr7f95H/+sMoxZtOtUu1wtvZwxTvJ5iV+D3khX3JPOo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VqRh2GP2Zlsd0Xikqogu0ime1ENHl2Scd6+UzEEnqS5uA15yPn+RZz8rK4wrYJp72
	 t3JSYr4q6nGhf3IGKJGB13HrvzUZ94qBRHHHFIrbwFPanUE6WWH5NiEoGyFLAfgv7d
	 Gm1cGJw7eCsGEfkH8jQx6PwAYoXFZSRX1sSIVRP/S/8AMjJLcdvQYZKjeGr9XVrlfQ
	 QAGFqchvVZ7vLvGvDxDaAEGPrs4MvZOJJvdTv0PuTWtKLHVnjTPgEZx3wXVvxUFmkA
	 DoKuJmJx1E8+rpYbeqY7Ct5joqoYXYRZ1Dc+LbEHNi2l2CeLcyZ6iQ493j3b7yPqZP
	 eDGIQCRk5P8og==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  ath10k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/4] wifi: ath10k: support board-specific
 firmware overrides
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
	<20240306-wcn3990-firmware-path-v2-2-f89e98e71a57@linaro.org>
Date: Wed, 06 Mar 2024 11:02:18 +0200
In-Reply-To: <20240306-wcn3990-firmware-path-v2-2-f89e98e71a57@linaro.org>
	(Dmitry Baryshkov's message of "Wed, 06 Mar 2024 10:16:46 +0200")
Message-ID: <87ttljhgx1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> Different Qualcomm platforms using WCN3990 WiFI chip use SoC-specific
> firmware versions with different features. For example firmware for
> SDM845 doesn't use single-chan-info-per-channel feature, while firmware
> for QRB2210 / QRB4210 requires that feature. Allow board DT files to
> override the subdir of the fw dir used to lookup the firmware-N.bin file
> decribing corresponding WiFi firmware.
>
> For example:
>
> - ath10k/WCN3990/hw1.0/wlanmdsp.mbn,
>   ath10k/WCN3990/hw1.0/firmware-5.bin: main firmware files, used by default
>
> - ath10k/WCN3990/hw1.0/qcm2290/wlanmdsp.mbn,
>   ath10k/WCN3990/hw1.0/qcm2290/firmware-5.bin: SoC specific firmware
>     with different signature and feature bits

Thanks, this looks good now.

> Note, while board files lookup uses the same function and thus it is
> possible to provide board-specific board-2.bin files, this is not
> required in 99% of cases as board-2.bin already contains a way to
> provide board-specific data with finer granularity than DT overrides.

After thinking more about this I agree, we want to have just one
board-2.bin file for WCN3990 as it makes easier to share board files
across all variants.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

