Return-Path: <linux-wireless+bounces-240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C8E7FF7AF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 18:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36CE281B9D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DE155C16;
	Thu, 30 Nov 2023 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR8u7t7a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8073C694
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 17:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4D0C433C8;
	Thu, 30 Nov 2023 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701363857;
	bh=ipXSh/47UcjI7Ptig4SmC42fd/0Qp8rZuv+bGMrBgcA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jR8u7t7aBFWqzXOYDrYeVfpARImQWmqDnT1qpDCH/K/EMomW1Yzh2fL20gC9ZMIFs
	 muq4+WrtATJQlcPmaHJiHHddOAmHb4xNb8rSRgEQVYd7BrMNNRFrkBBdY8qOEj361H
	 2EbofQIUPLLl5xqnnmct+lQRyi8g/tJwyXVqbv+v2Qf2yGcdCj8OmNZX4X5uSnBO/i
	 v8VZE5ReMMXLve96exbJwDcsix+uuhRVcVGIZqo97/gYo6xiO5Flkkr7x7hFMG+yKI
	 i56C2F8lC8kAfjTBxX/XUGfSsPUzmFKXO2tUmsYp0TtYQrbITit2eqRkR87BH4gJWM
	 osHR84mR5wGEg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix race due to setting
 ATH11K_FLAG_EXT_IRQ_ENABLED too early
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231117003919.26218-1-quic_bqiang@quicinc.com>
References: <20231117003919.26218-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170136385394.1435047.15668793291905859073.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 17:04:16 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> We are seeing below error randomly in the case where only
> one MSI vector is configured:
> 
> kernel: ath11k_pci 0000:03:00.0: wmi command 16387 timeout
> 
> The reason is, currently, in ath11k_pcic_ext_irq_enable(),
> ATH11K_FLAG_EXT_IRQ_ENABLED is set before NAPI is enabled.
> This results in a race condition: after
> ATH11K_FLAG_EXT_IRQ_ENABLED is set but before NAPI enabled,
> CE interrupt breaks in. Since IRQ is shared by CE and data
> path, ath11k_pcic_ext_interrupt_handler() is also called
> where we call disable_irq_nosync() to disable IRQ. Then
> napi_schedule() is called but it does nothing because NAPI
> is not enabled at that time, meaning
> ath11k_pcic_ext_grp_napi_poll() will never run, so we have
> no chance to call enable_irq() to enable IRQ back. Finally
> we get above error.
> 
> Fix it by setting ATH11K_FLAG_EXT_IRQ_ENABLED after all
> NAPI and IRQ work are done. With the fix, we are sure that
> by the time ATH11K_FLAG_EXT_IRQ_ENABLED is set, NAPI is
> enabled.
> 
> Note that the fix above also introduce some side effects:
> if ath11k_pcic_ext_interrupt_handler() breaks in after NAPI
> enabled but before ATH11K_FLAG_EXT_IRQ_ENABLED set, nothing
> will be done by the handler this time, the work will be
> postponed till the next time the IRQ fires.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

5082b3e3027e wifi: ath11k: fix race due to setting ATH11K_FLAG_EXT_IRQ_ENABLED too early

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231117003919.26218-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


