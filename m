Return-Path: <linux-wireless+bounces-7595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87308C42F8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15301C21336
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 14:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DFA15383C;
	Mon, 13 May 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUx2QbRK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9CC153819;
	Mon, 13 May 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609693; cv=none; b=XKqiap8q9M8HU1g296VEqFm7MUXDCYRnc0xz4cb3MmgPz01l2TIt0DUZuLQCKh5IQdNqG3YKgLv0elK1+FUZ90hLOHxU64uDz+S2hNymlsYGGW2SidybwqfTiDEGvseDx9sC1F2ckKg0UGBTn8jAkH4eUgzmKEMsmSNTiJTFFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609693; c=relaxed/simple;
	bh=UPuauCYh36dyevJphL1EJxVRpRWQSPlcqWsuOaWqJYg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=oULmEUDnlUJYRiXC8jkObsr5lqGX4J7na8IXBiMA8b4Wypnmy2gr84/zjUUd3yFkrLtZHL7LROTqp/0AkdCcRRrj+N5PSj2SzZ+ZnF3wLtGegNlkYqWtzxwqTOxbG+4JagNXQSBz1vWIuk9ofbyhyH/OcpSzYzvIU8TanCTrc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUx2QbRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E431CC4AF10;
	Mon, 13 May 2024 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715609693;
	bh=UPuauCYh36dyevJphL1EJxVRpRWQSPlcqWsuOaWqJYg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=kUx2QbRK0U2xWMPGy+9v/76znz5fhfdeGGXl8g4bm5sRXIPEVuPo1yvjLwIcedQdc
	 qM9lJHG4GrWsNYcRX648GkGYJcxHZ5pHZrocQWl35aTA5TZXfLah5xHJ217FqqCYgT
	 aEZNs2qSKFif6KmNkRx8KcN2yvHkPcuDIuBgmJzs9bNve2BoSiGyOekQP/BM6tBGzT
	 TFL6/Jumm80F2Nwza/pWfbzcU+5i8oLXE9y1XFLeTKDjrIqhkSi8d6W1t/9Uga427y
	 nNhKbegS6z/nZB2N1PeyqQJyuqiGMvvLRZc+QJMJUEVT6JTy5WxRkFw2jWvFeDWM78
	 xbq5p+bwx4iHA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: fix misspelling of "dma" in
 num_rxmda_per_pdev
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-1-44d2843a2857@quicinc.com>
References: 
 <20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-1-44d2843a2857@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171560969001.1690511.12764694198482040352.kvalo@kernel.org>
Date: Mon, 13 May 2024 14:14:51 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The ath12k_hw_params member num_rxmda_per_pdev contains a misspelling
> of "dma" so fix it.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

ff5fa958d2fd wifi: ath12k: fix misspelling of "dma" in num_rxmda_per_pdev
3b9344740843 wifi: ath12k: initialize 'ret' in ath12k_dp_rxdma_ring_sel_config_wcn7850()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240504-ath12k_dp_rxdma_ring_sel_config_wcn7850-ret-v1-1-44d2843a2857@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


