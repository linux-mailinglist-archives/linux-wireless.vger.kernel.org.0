Return-Path: <linux-wireless+bounces-15199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7C29C5311
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 11:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3540281F1D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 10:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F2213EE2;
	Tue, 12 Nov 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKKDas/z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6A3213ECC
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406650; cv=none; b=F+Gp02wT7StQQ/ti8bwc20W/MeGOSNmr2Le4CTwYfzL6pqUzQzY3Nwl6ioON5qVmKLlYOzGObvB+vPrOJCn158Mdk0XPuKnXdDRRcKVrEyCORglc/psswpz5QcrJAbgU2dQAEWYk9rDpeh1V9aKZtgjCdXVl59GgcA1TQVpHVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406650; c=relaxed/simple;
	bh=XWmn24pqEPofhFjs8lrl+hPSdZSxeKaJt9Se7NbgBW0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uhdHAaIqMFX9Y3iLXvj/DkIzqHVL1uD6fhTLN5rG73j4g2TYVWJBpkA6LFW/mEHofcOUpwc+k9K+BR78XBsfwom+vmaH85//pgCdN1RPS+U/ULBvBMyZBXBSEA1M3qfpe/BTJOBmxASlVvCu9T6sLzuI55025Tfzu+AIpBKqzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKKDas/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6985C4CECD;
	Tue, 12 Nov 2024 10:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731406649;
	bh=XWmn24pqEPofhFjs8lrl+hPSdZSxeKaJt9Se7NbgBW0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=cKKDas/zpQdOak9itVtHzqbH6UTuJHMPoHop8sWlodS2g9ZCWIFMQ2H34TtOyfjzk
	 wdZ4XROZG0+L4ewXHcC+dyT80+50EEJ62/0uOOLYWSrxIzshlm+1w7gHOhuf2YA6Js
	 6pUCCA+o4Ndq3nhxv3xutYG98I5j//X3lIn/WI6zQr0gRytC5TREai1awliy5Vk5av
	 k/g9HS87SeZ6Hma449Xke1KtczVBsK5i6VHdb+ITXSq2wTUEskwLjeV4h3OFTAxVeb
	 Ixekeme0Ea6mGMESDgmvLRDkfdH4r8QPy0nKyg5kyIcDYyHr/AXYWSfszIcIF5JNiP
	 zOLYYJ4c7IzpA==
From: Kalle Valo <kvalo@kernel.org>
To: Balaji Pothunoori <quic_bpothuno@quicinc.com>
Cc: ath11k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: Fix unexpected return buffer manager
 error for WCN6750/WCN6855
References: <20241030114625.2416942-1-quic_bpothuno@quicinc.com>
Date: Tue, 12 Nov 2024 12:17:27 +0200
In-Reply-To: <20241030114625.2416942-1-quic_bpothuno@quicinc.com> (Balaji
	Pothunoori's message of "Wed, 30 Oct 2024 17:16:25 +0530")
Message-ID: <87bjykwybs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Balaji Pothunoori <quic_bpothuno@quicinc.com> writes:

> The following error messages were encountered while parsing fragmented RX
> packets for WCN6750/WCN6855:
>
> ath11k 17a10040.wifi: invalid return buffer manager 4
>
> This issue arose due to a hardcoded check for HAL_RX_BUF_RBM_SW3_BM
> introduced in 'commit 71c748b5e01e ("ath11k: Fix unexpected return buffer
> manager error for QCA6390")'
>
> For WCN6750 and WCN6855, the return buffer manager ID should be
> HAL_RX_BUF_RBM_SW1_BM. The incorrect conditional check caused fragmented
> packets to be dropped, resulting in the above error log.
>
> Fix this by adding a check for HAL_RX_BUF_RBM_SW1_BM.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.2.0.c2-00258-QCAMSLSWPL-1
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
>
> Fixes: 71c748b5e01e ("ath11k: Fix unexpected return buffer manager error for QCA6390")
> Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

