Return-Path: <linux-wireless+bounces-7735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D628F8C72B9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 10:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9289728313A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B8C27269;
	Thu, 16 May 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7UoYMLo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7D80031
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847918; cv=none; b=AiEe5I0IqAhqfblpaL2ylll1fGwdC0NU6zECeHNCkQpb/nvrO5+lJ4TDKTK48/FfD0Vg+n+tzLNDlE8OYcsbwj6eKYv4tfQr3xgQM6Ug8Rf18LpaLZEmTt8t2l4bMR8T8O6ppLvgW2KrSm8BytxrXESy7g4ltdbl4jmKXANLo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847918; c=relaxed/simple;
	bh=6FvXY67QijEXcpeNfgnrirFNHmtBhw7HjQZnfRwkU0Q=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=gHCnRQ2ayqbbZIzvZCe5U9BiYMMLEmdkQElIOZTl2FGayJlQZ3JR5t752ooUh4HTSjqANBClsP3aCZUozp2x2HyqpDJyco1qDw05WGTw9z4BuEhnTCrPhFOjHKzax42AaWUWa+nG37uXR77h8Ij2UlTm/Eh09odCB9wT/xmDPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7UoYMLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821F7C113CC;
	Thu, 16 May 2024 08:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715847918;
	bh=6FvXY67QijEXcpeNfgnrirFNHmtBhw7HjQZnfRwkU0Q=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=F7UoYMLoQC/wmnVWcHSCuF7ry1RkiLRgZ95wPAEVWBgbb+mv2bnMqEvzTivY3rKpP
	 F4X5CnmsypB8q03QoMDR8jBpFGaRmLPkzMl8tRYhR/s49fRqD89pPQQvP243UgDHHE
	 WddvU2NcOY3AlflgL6HKFol5zPpqn/+Bh0Jp13YAf/lh8VhuGsgmBAZcTX2jC0oqoX
	 xTqfZxGtpfr9dIAG2nnOTVAI9NI6Ylcg9BhhCrhpfCN0vnT6zn56KzcjiyFoiw5NmE
	 tQoWE/HA+DiIXWiwleoXJOa4eiGLdByzgAvVA92BtC8FlGeROCo58z7ywL1nFMI4K3
	 zlQcoM2ZULitA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup
 Failure
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240510070427.206152-1-quic_nithp@quicinc.com>
References: <20240510070427.206152-1-quic_nithp@quicinc.com>
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171584791537.2781522.14910135960105060836.kvalo@kernel.org>
Date: Thu, 16 May 2024 08:25:17 +0000 (UTC)

Nithyanantham Paramasivam <quic_nithp@quicinc.com> wrote:

> We observe intermittent ping failures from the access point (AP) to
> station (STA) in any mode (AP-STA or Mesh) configured. Specifically,
> the transmission completion status is not received at tx completion
> ring id 4 (WBM2SW ring4) for the packets transmitted via TCL DATA
> ring id 3. This prevents freeing up tx descriptors and leads
> to buffer exhaustion.
> 
> Currently, during initialization of the WBM2SW ring, we are directly
> mapping the ring number to the ring mask to obtain the ring mask
> group index. This approach is causing setup failures for WBM2SW
> ring 4. Similarly, during runtime, when receiving incoming
> transmission completion status, the validation of the ring number by
> mapping the interrupted ring mask. This is resulting in
> validation failure. Thereby preventing entry into the completion
> handler ath12k_dp_tx_completion_handler().
> 
> The existing design assumed that the ring numbers would always be
> sequential and could be directly mapped with the ring mask. However,
> this assumption does not hold true for WBM2SW ring 4. Therefore,
> modify the design such that, instead of mapping the ring number,
> the ring ID is mapped with the ring mask.
> 
> According to this design:
> 
> 1. During initialization of the WBM2SW ring, mapping the ring ID
> to the ring mask will ensure obtaining the correct ring mask group
> ID.
> 
> 2. During runtime, validating the interrupted ring mask group ID
> within the transmission completion group is sufficient. This
> approach allows the ring ID to be derived from the interrupted ring
> mask and enables entry into the completion handler.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

0ce9ab2785e4 wifi: ath12k: Fix tx completion ring (WBM2SW) setup failure

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240510070427.206152-1-quic_nithp@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


