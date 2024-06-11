Return-Path: <linux-wireless+bounces-8810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFCA9043DC
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 20:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A9E1F25E9C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 18:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3775158AA7;
	Tue, 11 Jun 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W99yVoRv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C5557CA7
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131375; cv=none; b=hTPHLFSPUh+CIRF7oJRVSNmcBIFhRsZS8Pf5JbhShY5Ss2Z2rO4mgZbsDttMCwfRgVz7UmYKhBiXTGrgGAU7jol14NAjd89m3dgVdV7wZ2h3QHMEtsCVEu0IEZseMjqu7zTS4TC3fb5c2apHx5Mfm4CQM/yQ/G0V8NRHhOHHpWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131375; c=relaxed/simple;
	bh=NOoJ/5u2iqT0kvtELbXBuBpqiPxXcNZfz62k2C29M7M=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=o+nnNvJyh6zQh1Vna3rhW12Y0P1a6Kb9QyFRhAV9Yj9QkoaEiw64v1o4Xp5H7JHiD+UFZaAoDgzKQJTNydYe2yjIfDpaamPu6+9UgwBbrIGo/7IwwWay/AIXEp5sm4LrQauAg0RBAotOM0XM+OUPhqNWPg0vz4TGITN2n4gizb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W99yVoRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2ECFC2BD10;
	Tue, 11 Jun 2024 18:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718131374;
	bh=NOoJ/5u2iqT0kvtELbXBuBpqiPxXcNZfz62k2C29M7M=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=W99yVoRvIOhW0SSvSzCt4kFrQZpgg+/xDPE2+wrsh2uW3Isu5MYqs/R0iV/gv6HzI
	 0n+59UFnpXcQDCq8fNxexp24CqsIuASBk00Df2ckUUnavEmtBhD/gXR3Voyx5VGq1H
	 agxF40OYdq9HeQKAKBkJOhHhJuLTj7ksODDdpTvTlfNFEgBkQxEfcaJAAZBPnpR4sw
	 nnPCPHfHw85ksPhqtuAJk434mZrivCrkXV/cGjUBYy5Mh9odyJAv7c+4Kj5c8sDZy9
	 dFc0/tohOiBtPqb2xwwf6WXGk6BZHo3zDtYX939KRTXkjrEHkHZci257dYOWqDbeeY
	 DGzqhvTwtLzgA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: avoid unnecessary MSDU drop in the Rx error
 process
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240604062641.2956288-1-quic_periyasa@quicinc.com>
References: <20240604062641.2956288-1-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171813137163.3564613.14473521688819768834.kvalo@kernel.org>
Date: Tue, 11 Jun 2024 18:42:53 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, in the Rx error processing handler, once an MSDU drop is
> detected, the subsequent MSDUs get unintentionally dropped due to the
> previous drop flag being retained across all MSDU processing, leading
> to the discarding of valid MSDUs. To resolve this issue, the drop flag
> should be reset to false before processing each descriptor.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9e32058ae62f wifi: ath12k: avoid unnecessary MSDU drop in the Rx error process

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240604062641.2956288-1-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


