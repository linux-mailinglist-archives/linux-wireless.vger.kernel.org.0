Return-Path: <linux-wireless+bounces-4422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7607687322D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 10:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F98286ADF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF1060BAE;
	Wed,  6 Mar 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOQzvOQJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16460889;
	Wed,  6 Mar 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715885; cv=none; b=ib04ZYq1Ma+89kAlFGgcxbL5YwgAQ2lS3nmMdCoaGJ/MPLnMTLSnl1Is1j52Kua48hlO+Fj1mP68tNRuSxC+bMFaG4nptLVSM6pUc2p/fdKhZseyCVVUHwsBXBis5JH4ApPHOlUM7eebYShxE7E4eb76Zg098dMCGkGwmBDPb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715885; c=relaxed/simple;
	bh=lT33D1r8s/bp6Ix6+DW7nrWJQkFQLEVIK0tbhV5W6to=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TUA4gTwtWE6kzetau+E0KswV7Zs2LQKbGPLVdJLl7LvOMItqrFRCdvoKLqlsrruHmwT/OdLDugxRA19LShVuTcIC5XwOJldRNbh6D7J72uccvGHxp7sXbmTmLdlyLRAAl21twdTlJeQiqhh4d9l7d8R3WVKpaNYUIDUZyZRGUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOQzvOQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B44C433F1;
	Wed,  6 Mar 2024 09:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709715885;
	bh=lT33D1r8s/bp6Ix6+DW7nrWJQkFQLEVIK0tbhV5W6to=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dOQzvOQJcuEDCF6tN2LV7H9G3ueiQJusbfWn68WYM5n1djQNg52Y/R/+N7keo8rWr
	 dIrTZo8a3+NEaCpaeNwpsJhC3WmWcFc/HR7XtOEKC4B7M+CoyTfjhgpZSNuOVRpexz
	 DWDMI8Dw2lXV3u/RnIm29NibdLsQ1Ym8nodHA4gLGW7DFDtGjJV2zGGftagY/d+PNN
	 h5jxqBWVgq9XUVUJ6DfjIVVeFcImFBRQ5+Xuzi2yCddr+LG84wgiAbszA8eFF9xdKP
	 xNxCE8LXSt/+DGDMXlT0MCcfLGs8ZrQx5/RiLOL5spnBj/5DHxUQzzf3qucbYcM/UE
	 GVMRl6szltttg==
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
  devicetree@vger.kernel.org,  linux-arm-msm@vger.kernel.org,  Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFC v2 0/4] wifi: ath10k: support board-specific
 firmware overrides
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
Date: Wed, 06 Mar 2024 11:04:39 +0200
In-Reply-To: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
	(Dmitry Baryshkov's message of "Wed, 06 Mar 2024 10:16:44 +0200")
Message-ID: <87plw7hgt4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> On WCN3990 platforms actual firmware, wlanmdsp.mbn, is sideloaded to the
> modem DSP via the TQFTPserv. These MBN files are signed by the device
> vendor, can only be used with the particular SoC or device.
>
> Unfortunately different firmware versions come with different features.
> For example firmware for SDM845 doesn't use single-chan-info-per-channel
> feature, while firmware for QRB2210 / QRB4210 requires that feature.
>
> Allow board DT files to override the subdir of the fw dir used to lookup
> the firmware-N.bin file decribing corresponding WiFi firmware.
> For example, adding firmware-name = "qrb4210" property will make the
> driver look for the firmware-N.bin first in ath10k/WCN3990/hw1.0/qrb4210
> directory and then fallback to the default ath10k/WCN3990/hw1.0 dir.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Fixed the comment about the default board name being NULL (Kalle)
> - Expanded commit message to provide examples for firmware paths (Kalle)
> - Added a note regarding board-2.bin to the commit message (Kalle)
> - Link to v1: https://lore.kernel.org/r/20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org

From my point of view this looks good now but let's see what others say.
Is there a specific reason why you marked this as RFC still?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

