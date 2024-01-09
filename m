Return-Path: <linux-wireless+bounces-1634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E841D82892E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 16:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8357A1F24DB5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB239FE8;
	Tue,  9 Jan 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOW4ieNd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91D839FE7
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jan 2024 15:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B100C433F1;
	Tue,  9 Jan 2024 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704814909;
	bh=PrPT1PF1nLNq7MhFisgwCZbFl/aRMX6i5ALN/Gf296k=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pOW4ieNdmUZyZvCWsn6W3U2etakpyFD/MyTR1IJWpwJwYB78Dr6s/utb4bh0fH8hX
	 Q8TS39SQ5u/ca51wf9LQqK/61/a+Zv5bLJ77JYvUmlLsfBX3FUhloAdmctdsjSD2yI
	 6jEozcV2J789zxGYsUszOW2hD9g/7t82Kvytd/vWp5oMiOnM51Z0oyqDzyzXVtRyM7
	 WH5O0AuW2AQ1qTWGockk7eNDjQaHuOH5UfJbAlz+nBzwfTLAP066n0lIuw2Rqu6nu1
	 wxiY8NtlzafCl+mtao6lcQb6azj0FYUrPYfwlecl2odySLP0A7CpAcjRPCkCxdfIGu
	 tfG2wM1eStGLQ==
From: Kalle Valo <kvalo@kernel.org>
To: Zhenghao Gu <imguzh@gmail.com>
Cc: ath11k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath11k: fix IOMMU errors on buffer rings
References: <20231212031914.47339-1-imguzh@gmail.com>
Date: Tue, 09 Jan 2024 17:41:46 +0200
In-Reply-To: <20231212031914.47339-1-imguzh@gmail.com> (Zhenghao Gu's message
	of "Mon, 11 Dec 2023 21:19:14 -0600")
Message-ID: <8734v6ecp1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zhenghao Gu <imguzh@gmail.com> writes:

> virt_to_phys doesn't work on systems with IOMMU enabled,
> which have non-identity physical-to-IOVA mappings.

Can you give an example of such system? Just curious where you are
seeing this.

> It leads to IO_PAGE_FAULTs like this:
> [IO_PAGE_FAULT domain=0x0023 address=0x1cce00000 flags=0x0020]
> and no link can be established.

What do you mean with link in this context? Are you talking about 802.11
association?

> This patch changes that to dma_map_single(), which works correctly.

Good catch. And virt_to_phys() documentation even says this:

 *	This function does not give bus mappings for DMA transfers. In
 *	almost all conceivable cases a device driver should not be using
 *	this function

> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Signed-off-by: Zhenghao Gu <imguzh@gmail.com>

Jeff, are you ok with this?

I did some cosmetics changes in the pending branch (removed unnecessary
parenthesis, reverse xmas tree etc), please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=fefa43d63e1928fce6e8c2bb626900e9ce98ca69

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

