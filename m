Return-Path: <linux-wireless+bounces-425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909B380582C
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 16:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A96E281B4B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B28567E81;
	Tue,  5 Dec 2023 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayT6Ffhp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D758101
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 15:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708B4C433C8;
	Tue,  5 Dec 2023 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701788760;
	bh=6XNlK8LiAolYKHBxWx4NVArki/Uu6MojnCM41SR+luI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ayT6Ffhpsc7mLa0pDG9oXhR7w6GsqIM5JnJhmeFABlRsvjvkRGRe/LVdF1lcVYYd/
	 qW9b8F4uHVvMlqmGNl7DusWF7fmW2XeTW61mMSePnHf6HvN61npRXFJh7gPAvj/8MF
	 i4JNSRkvGY5YvdWTzdKnpXE5QpjjhacaTbER+vUCB9fceYR1uiYd9zqqZru9aYFHru
	 Fl8lzKY8ewUnwexb9+Z5spdEi1IOXgQu/rDdc7iB+cK7U0k3RU7SPZ4txn4iUSh6ru
	 S7h4O53MlrzLPjgAuqEsFFx8MTLT9mGRJ/B6khv/V3aMr+OpFju3F13MH28P97IQ5i
	 ccke1p0W2pLcQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/7] wifi: ath12k: get msi_data again after request_irq
 is
 called
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231121021304.12966-2-quic_kangyang@quicinc.com>
References: <20231121021304.12966-2-quic_kangyang@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170178875768.2413512.746840226279919618.kvalo@kernel.org>
Date: Tue,  5 Dec 2023 15:05:59 +0000 (UTC)

Kang Yang <quic_kangyang@quicinc.com> wrote:

> The reservation mode of interrupts in kernel assigns a dummy vector
> when the interrupt is allocated and assigns a real vector when the
> request_irq is called. The reservation mode helps to ease vector
> pressure when devices with a large amount of queues/interrupts are
> initialized, but only a minimal subset of those queues/interrupts
> is actually used.
> 
> So on reservation mode, the msi_data may change after request_irq is
> called, then it will lead to spurious interrupt. But when VT-d in
> BIOS is enabled and ath12k can get 32 MSI vectors, ath12k always get
> the same msi_data before and after request_irq.
> 
> So in case of one MSI vector, ath12k need read msi_data again after
> request_irq is called, and then the correct msi_data is programmed
> into WCN7850 hardware components.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

7 patches applied to ath-next branch of ath.git, thanks.

1b66601d1416 wifi: ath12k: get msi_data again after request_irq is called
604308a34487 wifi: ath12k: add CE and ext IRQ flag to indicate irq_handler
1f1f7d548a00 wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP IRQ
6711b2a80b9a wifi: ath12k: refactor multiple MSI vector implementation
8398654398c2 wifi: ath12k: add support one MSI vector
08d52ba29678 wifi: ath12k: do not restore ASPM in case of single MSI vector
a3012f206d07 wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231121021304.12966-2-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


