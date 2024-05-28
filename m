Return-Path: <linux-wireless+bounces-8215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB0B8D22BD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 19:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE401C22E73
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3789B2EAE1;
	Tue, 28 May 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/zPixi1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F652E822
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918307; cv=none; b=CYqlPePy+JWIAqZAJFMFqDA2p/+sTGZKtQVoMW1BoUUJtS21IQnBXV2dDCQjpSqZOqKFDfsa1/unNJIdIXVF6HpCGQr2oVrilHdcWjbDYstCs0S7e1n1n+zES2E042KCK7aClPW7VGX4+mvjHPl12pGIvR84zR++vY+1quM2rG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918307; c=relaxed/simple;
	bh=092slm6u3SuLv+jBx+DbZLRXByFStQ2yboHpj2kR4tg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ArKhogVxQQhHOZG99j7hauGcE30Qo56KVRZ8Wg+yao5U71KooI7K/ny17cFQuLY8V5hqCJsfEw63W0/G1DDV/WOauSzoEeZPxhhg9vWUpDqCbai6v6vGsY+zc98KvlnDSgN0gKYp2oAmMCxuZcM0VpjykMHV5kt36jUzyfJ7jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/zPixi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62EAC32782;
	Tue, 28 May 2024 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716918306;
	bh=092slm6u3SuLv+jBx+DbZLRXByFStQ2yboHpj2kR4tg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=S/zPixi1pXk6vLG7WdKE46o+AmOJT5wWIEEMce5FZcOcfXitt+pP9hALu1o69UaNY
	 /pp7c2VnvUxJO/7WVW9h4JD/Or3TnRj9aKQyO9J/j/k0yXjMkgjH+jla85vqKIeOAl
	 XbyRBSo2B0qfTbftgPiGaFk1Y27RvPD65Dn1cBvi0IRkAekDLKVOiSOycGjgkSSfD/
	 F5WSjrGhvOA9Y7mf1OGJj2JO9U0/Oc1nNNWYIcjJtvx+wdi5OXmRNuUzcUpjGrQvsK
	 vuS9huuT5HzJSkZ1DcZAZhrRzslAJbKBPhuwnPO69A7wj5Sia6XqGBD9OBrG9okLWm
	 9NYbKCjuDNvAQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix race due to setting
 ATH12K_FLAG_EXT_IRQ_ENABLED too early
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240524023642.37030-1-quic_bqiang@quicinc.com>
References: <20240524023642.37030-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171691830369.1700985.14695281653028868170.kvalo@kernel.org>
Date: Tue, 28 May 2024 17:45:05 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Commit 5082b3e3027e ("wifi: ath11k: fix race due to setting
> ATH11K_FLAG_EXT_IRQ_ENABLED too early") fixes a race in ath11k
> driver. Since ath12k shares the same logic as ath11k, currently
> the race also exists in ath12k: in ath12k_pci_ext_irq_enable(),
> ATH12K_FLAG_EXT_IRQ_ENABLED is set before NAPI is enabled.
> In cases where only one MSI vector is allocated, this results
> in a race condition: after ATH12K_FLAG_EXT_IRQ_ENABLED is set
> but before NAPI enabled, CE interrupt breaks in. Since IRQ is
> shared by CE and data path, ath12k_pci_ext_interrupt_handler()
> is also called where we call disable_irq_nosync() to disable
> IRQ. Then napi_schedule() is called but it does nothing because
> NAPI is not enabled at that time, meaning that
> ath12k_pci_ext_grp_napi_poll() will never run, so we have
> no chance to call enable_irq() to enable IRQ back. Since IRQ
> is shared, all interrupts are disabled and we would finally
> get no response from target.
> 
> So port ath11k fix here, this is done by setting
> ATH12K_FLAG_EXT_IRQ_ENABLED after all NAPI and IRQ work are
> done. With the fix, we are sure that by the time
> ATH12K_FLAG_EXT_IRQ_ENABLED is set, NAPI is enabled.
> 
> Note that the fix above also introduce some side effects:
> if ath12k_pci_ext_interrupt_handler() breaks in after NAPI
> enabled but before ATH12K_FLAG_EXT_IRQ_ENABLED set, nothing
> will be done by the handler this time, the work will be
> postponed till the next time the IRQ fires.
> 
> This is found during code review.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

0a993772e0f0 wifi: ath12k: fix race due to setting ATH12K_FLAG_EXT_IRQ_ENABLED too early

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240524023642.37030-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


