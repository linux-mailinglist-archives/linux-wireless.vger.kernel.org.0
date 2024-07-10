Return-Path: <linux-wireless+bounces-10152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F3792D689
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 18:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6136B287215
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC08196D8F;
	Wed, 10 Jul 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi9/eEpa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C90196D8E
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628925; cv=none; b=Ceq4uURXD4x5XfCKdXQ7QnQAKeDufy1KV1AtAoIsalyG7LUA7y0WDulfrDCiimHHERZD3yxXNVF/qymp55uMyZ9WA/3V+KD4zoh4Zio0faYQvC5xHgXxZcyjY01Iqw/rp3+dRwP1oBjWHceNqNSqcddQ5/UfiJ1idNZpgmnvWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628925; c=relaxed/simple;
	bh=EgdzbU+3yPs9BQQAdZ0RzeqYD2FW6i/xT6qw+amuVHo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=owKU15SSrtaxTiFpst4Zl4yXwLQmTi633SpN/TaGHV4CHXsrfNEt4zJ9AeXZS6s/k2IckLOft/JCz9Y1NOF8yhIKKEh2CoPC+I/CTSdd/mKRa5FoNL1i2qTchqteZBbaS+lSQA253m0iaSJfauSfY9ONDrk62alhTumvBLsjEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi9/eEpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2294FC32786;
	Wed, 10 Jul 2024 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720628925;
	bh=EgdzbU+3yPs9BQQAdZ0RzeqYD2FW6i/xT6qw+amuVHo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=oi9/eEpaRAr5Vfg+21ANwLl8HQbTTFLz2DGjObapagXWPGGZWdXCWDc6KBqVOOLUK
	 poGhOkpOY4Yjvjt8oS+hZPEGWyDuYl7MdlsX5EYqSl/VGSylOs4wGVYPGK5pzLKXMp
	 wV3Wim0rNsssrtKBJVLSKmNKt073dbr6Lcx553BO8OkHG2ybPhlpbzOWLRuwD/65WV
	 AliNsL6HAKgkU/bonY4ofnhmoVOr9j1y3V59b4V+CXGXD8CH7h40ctukG4PWLfRVY9
	 M8HxIT+Z+ztSADWLRHBSb2+bxSk4QQSIHrIQhRFwjV/MqdI2nds0pS0obB8N4Ozjhu
	 MXCdY0R/AQHLw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: fix array out-of-bound access in SoC
 stats
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240704070811.4186543-2-quic_periyasa@quicinc.com>
References: <20240704070811.4186543-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172062892254.1204645.1517943007872278005.kvalo@kernel.org>
Date: Wed, 10 Jul 2024 16:28:43 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, the ath12k_soc_dp_stats::hal_reo_error array is defined with a
> maximum size of DP_REO_DST_RING_MAX. However, the ath12k_dp_rx_process()
> function access ath12k_soc_dp_stats::hal_reo_error using the REO
> destination SRNG ring ID, which is incorrect. SRNG ring ID differ from
> normal ring ID, and this usage leads to out-of-bounds array access. To
> fix this issue, modify ath12k_dp_rx_process() to use the normal ring ID
> directly instead of the SRNG ring ID to avoid out-of-bounds array access.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

e106b7ad13c1 wifi: ath12k: fix array out-of-bound access in SoC stats
69f253e46af9 wifi: ath11k: fix array out-of-bound access in SoC stats

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240704070811.4186543-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


