Return-Path: <linux-wireless+bounces-6004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5818E89D854
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 13:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7D71F21A27
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 11:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8B786651;
	Tue,  9 Apr 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d46EgBGB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46B42053;
	Tue,  9 Apr 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663034; cv=none; b=MbiNnLYYSMF1KTcUlop/hulVv/DG84zJphKCLOcLkR3bQsqE0x7jjNVlJA4DWyx9OX6w07KXzamtBSEhBFQoRwEi2iyLL7dTqm4ctxnRkM68trH9Qp6Ri4MIVx7eRafrBS1jRd6/bJ6X8oR6Zf+titRTgEi+/6VOUj+uRc9x774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663034; c=relaxed/simple;
	bh=nbeeO/HdiPZM8HHVLpt1fCwCNBVTR0HOgVLESsZWhOI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MYvmVbl0o0W672vnkOrw+BfPjRyRGGdHo5rHW7mnMBJytKUVKvUIqwsLc0k9noQVKz+Wulo8cksNvVssKYpPsrM+hWGI5/A9Y4BiPwovlo+C4O1CO29fQn9rlFKevbkXiJ5dEhuAforHNT1GkBXBa9+95U0rx+mP+8OsoAgbVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d46EgBGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D44DC433F1;
	Tue,  9 Apr 2024 11:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712663033;
	bh=nbeeO/HdiPZM8HHVLpt1fCwCNBVTR0HOgVLESsZWhOI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=d46EgBGBB+dImlGf5ySrLOyH8Ij3UrZQPzy4rRGGekUc48s6LOWgQaPOdY3zEgMrb
	 DO+ftabH7b6ZH6g39eV2l9yV0LxEDg9HCUZxy3wN+9z9gffSuupiELVlZgLW9Akbya
	 M3RLvjkJZ8ObgnMZwfjMMpd0zsNZUO92xmeIOKNA1e36B/vBLCWYDPtJObdYvr6VaS
	 Q3jTycG3C8+o8NDe3wVxTpZglXPlZNeb9zp2ceyNA9qlJ3Ci43tHFQeuZWi93DQc8q
	 pew28ArfhUw0IXj+aeUC7J4vyQ8YCqrXjhpTQex3N6zSlEl40rMQdQD50sxIuRR8rU
	 tK+FeYLqyrmUw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 2/3] net: qrtr: support suspend/hibernation
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240305021320.3367-3-quic_bqiang@quicinc.com>
References: <20240305021320.3367-3-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <manivannan.sadhasivam@linaro.org>,
 <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <mhi@lists.linux.dev>, <quic_bqiang@quicinc.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171266302937.3197288.10067259080549350573.kvalo@kernel.org>
Date: Tue,  9 Apr 2024 11:43:51 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> MHI devices may not be destroyed during suspend/hibernation, so need
> to unprepare/prepare MHI channels throughout the transition, this is
> done by adding suspend/resume callbacks.
> 
> The suspend callback is called in the late suspend stage, this means
> MHI channels are still alive at suspend stage, and that makes it
> possible for an MHI controller driver to communicate with others over
> those channels at suspend stage. While the resume callback is called
> in the early resume stage, for a similar reason.
> 
> Also note that we won't do unprepare/prepare when MHI device is in
> suspend state because it's pointless if MHI is only meant to go through
> a suspend/resume transition, instead of a complete power cycle.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

e0cd1185900e net: qrtr: support suspend/hibernation
166a490f59ac wifi: ath11k: support hibernation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240305021320.3367-3-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


