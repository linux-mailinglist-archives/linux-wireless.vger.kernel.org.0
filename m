Return-Path: <linux-wireless+bounces-3622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0658561E7
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 12:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A7CB33083
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D5129A8A;
	Thu, 15 Feb 2024 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYAGv80k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA41292F1
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996242; cv=none; b=vFXRFNFZnYvcXcinyyh3e0GAvhACB9j6/XSLUgE7qpz5HNjA6snk20mHto32qrPhGxVs993VAHK0iBqyuEYpk2puYFotdtudX5A23nDXTLEKaVkW+gv41XE2mcHIz3oMrQg3tjg7D0+RgSApkfshpHoR9aeRAU4BNi8eolZa7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996242; c=relaxed/simple;
	bh=eXCxHWY5sXnYQAHIrXcmuCtKtdH6fUG7bClWRU+dlzQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=JGMVIA8LCqM6y8vOLACd5ls6VtZzG7Li6Rnzwo00yVxyX0CZKMqyJuezIClmQ9Wx4KVA783qyWM81+yd4wyc+633BEhUAum/40F5RZ4guh6nW7fvCh2iQILZT4ch1WEIYNBEsb392PuAe0Yn6xN3QpivtkYUeM9kxnF2K6Qu2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYAGv80k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690ADC433F1;
	Thu, 15 Feb 2024 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707996242;
	bh=eXCxHWY5sXnYQAHIrXcmuCtKtdH6fUG7bClWRU+dlzQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=NYAGv80kZo+caeCIkiRoPRvW1BoCX0nRXZyDppJxxur22e30Fst74xj0wtbs+Mop1
	 Jrh4+sIdqHLQFUvWZF8aN4qyUzccCyIlF1FOjm1KKxEjXgfWkJ/xJQ4yVCG0BiSUb5
	 Q1WbbtYxN3QrepURYobnqLk2VhUjXieauJCvdoE+Vtdg2fKa85LOgd7QAk6qnA6xk9
	 AO4Gp/+rrlsCpVDQMO0rmm1Yt5DGNku2yPvvB76dTdql4aCsEbIMJ9R4VsqrTCbWYP
	 F5svmIymeWeOpE4suVekkmkJml0zTDmFq7BM7/MVV0W9hTjSk3kogge1uvHoDVM5F0
	 pTV5Bid8D6cyw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: ath11k: move pci.ops registration ahead
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240109021336.4143-2-quic_bqiang@quicinc.com>
References: <20240109021336.4143-2-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170799623969.3860606.1320756266938068421.kvalo@kernel.org>
Date: Thu, 15 Feb 2024 11:24:01 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> In ath11k_pci_probe() there is a switch statement that, based
> upon the PCI device ID, assigns pci_ops. After the switch,
> ath11k_pcic_register_pci_ops() is called to register the pci_ops.
> 
> Unfortunately, this registration is too late if any of the cases
> in the switch need to perform operations that require the pci_ops
> to already be registered. In particular, an upcoming patch for
> QCA2066 needs to call ath11k_pcic_read32().
> 
> To address this issue, call ath11k_pcic_register_pci_ops() from
> each case instead of doing so after the switch. That way the ops
> will be registered if any subsequent operations within the case
> processing require the ops to be present.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

515bcdf587f9 wifi: ath11k: move pci.ops registration ahead
5dc9d1a55e95 wifi: ath11k: add support for QCA2066

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240109021336.4143-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


