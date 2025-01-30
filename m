Return-Path: <linux-wireless+bounces-18211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 064DEA229AB
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 09:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A28F3A24FC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602971B0F04;
	Thu, 30 Jan 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POacsNCt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336911B040C;
	Thu, 30 Jan 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226289; cv=none; b=kmnQma4PsH6yAvGSdI/mDuqW+k7WmgBrtgCn8bZrll8bm/kLBO2MAkZS4PlIVGm5aIqS9pE8UpRLIJ1o9OOatx9ZrMHTkXOprOXC8vqNeaBQqmJXV0C6ezlag6ga3SfqqEyIOIjLbvFCco5Hjol1Hj0RnbcTW6pKEALyKptjNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226289; c=relaxed/simple;
	bh=a8pARe+EC3ECTuBLU5pJVHvAEBheRpHsCl5XeHxWQLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnfRzl5qrrlnhW3JitLJhzEDw3mV3SreB8f0WPDQ6FgCEs87Slrhua1v2h93Y0gX444wT7meEvJKhM3mN7ixaEYSnodvNvn4NtrzqhSk68oskQ71AjfFl0yfMwVSk4WmBuhW2A1fy8KoA0CZoQhkfggsXVMVEhd7PJe2MFCR/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POacsNCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B54BC4CED3;
	Thu, 30 Jan 2025 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738226288;
	bh=a8pARe+EC3ECTuBLU5pJVHvAEBheRpHsCl5XeHxWQLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POacsNCtX6lRKzk9JBfKHFucT9mBexH91JfLW87+bUMnmJp0k7y96kgbTGQ8e2S0i
	 /7SQjK4y4i2NREvCVI9rYtSRWFDAXP5Z+9vzsQlxaXs0ZkNGklbOItDQMNeP7RMliF
	 bzKXSeC9Rhuo5aeB0EZdYgfm1f1ovBViGuV7Vydx/orrmU+u5o01ziRaShkMkMQywr
	 Y6acdaqKTbpnugvrGVD2GNWZZeH5ACYWAfExVAFOWL7y9hJVFhLn+xI1DJjSoPh+UJ
	 YD+aBmHHYGySy82uqR6Torvweo8lUi3I6m3QEvoEsDBEogUhPDzlwlVy1Xcw36vIkm
	 lyXS5ZCo3ZblA==
Date: Thu, 30 Jan 2025 09:38:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Subject: Re: [RFC PATCH 3/5] wifi: ath12k: add ath12k_hw_regs for IPQ5424
Message-ID: <20250130-groovy-competent-mastiff-19cc9e@krzk-bin>
References: <20250130051838.1924079-1-quic_rajkbhag@quicinc.com>
 <20250130051838.1924079-4-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130051838.1924079-4-quic_rajkbhag@quicinc.com>

On Thu, Jan 30, 2025 at 10:48:36AM +0530, Raj Kumar Bhagat wrote:
> From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
> 
> Add register addresses (ath12k_hw_regs) for new ath12k AHB based
> WiFi device IPQ5424.
> 
> Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.5-01053-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/hal.h |  3 +
>  drivers/net/wireless/ath/ath12k/hw.c  | 87 ++++++++++++++++++++++++++-
>  2 files changed, 89 insertions(+), 1 deletion(-)
> 

That's not a separate patch. Regs do not make any sense on their own,
so this commit makes no sense on its own.

Best regards,
Krzysztof


