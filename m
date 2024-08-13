Return-Path: <linux-wireless+bounces-11347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F26E99501D3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 11:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F6C1C21E73
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9DA18953E;
	Tue, 13 Aug 2024 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3Ow85ZE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D018950A
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543145; cv=none; b=njpuK6dzEWdexVi47h+T6D1hwJwUexFmVEzjRnS1xsrXJ2JQ+tkhXcqvaTYWi4ud+W+pRfdTBnpEdIhxK+PxY18BmfHDNS39NlIJYV9vsV+7KRbmYKOL6mhwferei4xZ/fNS8JnFtVMM0hZdgUA53WJh3xfDq7InyGlxy0hab2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543145; c=relaxed/simple;
	bh=pzpoiFfq+2ivyX/04lGLavlOS/9I6phiMjzd/5Zydhc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RwSEUGlgjW1O/Uz/94b5xa4lietChihc5siEiU9N5EZzdnaYuCDJ2zVdm5C5Tm7sh5E9rwtyGgovjy55QGDHNjmJGkvGNYeeGBfAOSpHtNwSX5V4DXA5Q5FxbOSJB1nTfP0rmy4Uglmbui9xBs400AIO9ac4x38Wk32P/f/C4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3Ow85ZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5FAC4AF09;
	Tue, 13 Aug 2024 09:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723543144;
	bh=pzpoiFfq+2ivyX/04lGLavlOS/9I6phiMjzd/5Zydhc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=X3Ow85ZE7SAClwfDmI6sr+FFRdLqMvqPXPkPBYTU9TFgBAzBEuYgeD7Z2QN4jFk6l
	 GdiVYuaRfh7w5lmZR9UI8kikUrjsO1gnzEQSHW0Ji9hKwgkrIZM6YJECDvGIW3PHbu
	 sxJZuGLjlszvMhf/iLrTLA1QKuIDSHjku67Izbmr2mMXn02XKqwi7TJr/vXtZBNxqI
	 RF2lbsk5O8vABjcXZ5cw8DgGlI7AQgVK2Nk1g7iHeKD+H1Dk2eATEEpLMV5Ck5iHAy
	 as0ah4WraZaH64WW4F0XMJVcwQ1V1pm1lV9BfpXiH/XKucGRCryY7M+62r3i75PtV6
	 pCODkIjxGfnWA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ath-next-20240812
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <9ee38166-782b-409d-a2df-e2cee6e2ae21@quicinc.com>
References: <9ee38166-782b-409d-a2df-e2cee6e2ae21@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
 <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>,
 <quic_kvalo@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172354314111.731215.9038812147638682056.kvalo@kernel.org>
Date: Tue, 13 Aug 2024 09:59:02 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The following changes since commit c1cacb01f35589bd41360cdb7535afc792c08a7c:
> 
>   Merge tag 'ath-next-20240702' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2024-07-03 16:57:16 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20240812
> 
> for you to fetch changes up to 89fbe672bd0e5e5c39600fcc7a3bca0b8a212d23:
> 
>   Revert "wifi: ath9k: use devm for request_irq()" (2024-08-10 10:21:58 +0300)
> 
> ----------------------------------------------------------------
> ath.git patches for v6.12
> 
> This is a fairly light pull request since ath12k is still working on
> MLO-related changes, and the other drivers are mostly in maintenance
> mode with a few cleanups and bug fixes.
> 
> Major changes:
> 
> ath12k
> 
> * DebugFS support for transmit DE stats
> * Make ASPM support hardware-dependent
> * Align BSS Channel information command and message with firmware
> 
> ath11k
> 
> * Use work queue for beacon tx events
> 
> ath9k
> 
> * Use devm for gpio_request_one
> * Use unmanaged PCI functions in ath9k_pci_owl_loader()
> 
> ----------------------------------------------------------------
> Aditya Kumar Singh (1):
>       wifi: ath12k: restore ASPM for supported hardwares only
> 
> Baochen Qiang (1):
>       wifi: ath12k: fix invalid AMPDU factor calculation in ath12k_peer_assoc_h_he()
> 
> Dinesh Karthikeyan (1):
>       wifi: ath12k: Support Transmit DE stats
> 
> Dmitry Kandybka (1):
>       wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()
> 
> Heiner Kallweit (1):
>       wifi: ath9k: use unmanaged PCI functions in ath9k_pci_owl_loader
> 
> Kang Yang (1):
>       wifi: ath11k: use work queue to process beacon tx event
> 
> Karthikeyan Periyasamy (2):
>       wifi: ath12k: fix array out-of-bound access in SoC stats
>       wifi: ath11k: fix array out-of-bound access in SoC stats
> 
> P Praneesh (2):
>       wifi: ath12k: fix BSS chan info request WMI command
>       wifi: ath12k: match WMI BSS chan info structure with firmware definition
> 
> Rosen Penev (2):
>       wifi: ath9k: use devm for request_irq()
>       wifi: ath9k: use devm for gpio_request_one()
> 
> Thorsten Blum (1):
>       wifi: ath9k: Use swap() to improve ath9k_hw_get_nf_hist_mid()
> 
> Toke Høiland-Jørgensen (2):
>       wifi: ath9k: Remove error checks when creating debugfs entries
>       Revert "wifi: ath9k: use devm for request_irq()"
> 
>  drivers/net/wireless/ath/ath11k/core.h             |   1 +
>  drivers/net/wireless/ath/ath11k/dp_rx.c            |   2 +-
>  drivers/net/wireless/ath/ath11k/mac.c              |  12 +
>  drivers/net/wireless/ath/ath11k/wmi.c              |   4 +-
>  .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 354 +++++++++++++++++++++
>  .../net/wireless/ath/ath12k/debugfs_htt_stats.h    | 126 ++++++++
>  drivers/net/wireless/ath/ath12k/dp_rx.c            |   2 +-
>  drivers/net/wireless/ath/ath12k/hw.c               |   6 +
>  drivers/net/wireless/ath/ath12k/hw.h               |   1 +
>  drivers/net/wireless/ath/ath12k/mac.c              |   5 +-
>  drivers/net/wireless/ath/ath12k/pci.c              |   3 +-
>  drivers/net/wireless/ath/ath12k/wmi.c              |   1 +
>  drivers/net/wireless/ath/ath12k/wmi.h              |   3 +-
>  .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |   8 +-
>  drivers/net/wireless/ath/ath9k/calib.c             |   7 +-
>  drivers/net/wireless/ath/ath9k/debug.c             |   6 +-
>  drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 -
>  drivers/net/wireless/ath/ath9k/hw.c                |   6 +-
>  18 files changed, 521 insertions(+), 28 deletions(-)

Pulled, thanks.

ae98f5c9fd8b Merge tag 'ath-next-20240812' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/9ee38166-782b-409d-a2df-e2cee6e2ae21@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


