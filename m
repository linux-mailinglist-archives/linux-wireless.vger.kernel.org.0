Return-Path: <linux-wireless+bounces-8058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E05E38CEE3E
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 10:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F451F2150F
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E3C1A2C04;
	Sat, 25 May 2024 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiU7u947"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166CDDC4
	for <linux-wireless@vger.kernel.org>; Sat, 25 May 2024 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716627432; cv=none; b=FW7jibZCtvGrMwwcRKWonAM7n1JnH73j/3/9pRS7ymnHZpJeOoQM2HKP+fjdKRC7w6+HtTb+GJelnXggaN6p18NnwFZNmrkJLqbJRjNcy9sdBjGsgQiMxFKbGMj1MCvQ8hlFFREjPgqz9E64A4AYovsIrQZM12Ai7b0TZ/D5HXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716627432; c=relaxed/simple;
	bh=Gcf1PjpBNuOzGLzYpXk2kfrm5iEDnDTK2iAiTuh3WLY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=EHDV4mwPDeuUYqcjpFuB059BY3KTVpInfANY8NOZnmhlQ2NziQ4udsqS0PIadoMMBoJMsGS0VCjyHkSJGG0T8GAeSDIB+/zixMrS8WFQQ86QzihFr31Q7xq8H3o39CdYTkdc80+gRgwOrKBm1qcg7jSFwEfp6u805Rk4F/fU1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiU7u947; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CE2C3277B;
	Sat, 25 May 2024 08:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716627432;
	bh=Gcf1PjpBNuOzGLzYpXk2kfrm5iEDnDTK2iAiTuh3WLY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jiU7u94714TOa0PNEufE937WeRvVjltb8xRYkGs5xyqRrDBi6btp3el2yK1zYXDPM
	 C0Vvl3mRK8uJPzmlL7S+oDJgP6bW+IXLPtSrw9FhocCIgmbXvrX3Z8MLxKyuzJaoK1
	 58w7seCUU0NdMxd9BIbkHILs5e4JQBRFOTwutMcau3OAKE8I3K6dvx5ck87pZ47n+2
	 aE+uUpO8izPjd448Phc1ppUvp9u/m6zl+8EAfgg2LzyjYM54trb3kLFCAlsPVuLW4h
	 IWxF38bBluy7NFcBsBh9iGDOdl2kwG44UOut5amQvM6A2Oneg73EesUbCCnvQa70uv
	 G6O0b4VnEQqzQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] wifi: ath12k: change DMA direction while mapping
 reinjected packets
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240520070045.631029-2-quic_ppranees@quicinc.com>
References: <20240520070045.631029-2-quic_ppranees@quicinc.com>
To: P Praneesh <quic_ppranees@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 P Praneesh <quic_ppranees@quicinc.com>,
 Baochen Qiang <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171662742964.564311.15908765736182779932.kvalo@kernel.org>
Date: Sat, 25 May 2024 08:57:11 +0000 (UTC)

P Praneesh <quic_ppranees@quicinc.com> wrote:

> For fragmented packets, ath12k reassembles each fragment as a normal
> packet and then reinjects it into HW ring. In this case, the DMA
> direction should be DMA_TO_DEVICE, not DMA_FROM_DEVICE. Otherwise,
> an invalid payload may be reinjected into the HW and
> subsequently delivered to the host.
> 
> Given that arbitrary memory can be allocated to the skb buffer,
> knowledge about the data contained in the reinjected buffer is lacking.
> Consequently, there’s a risk of private information being leaked.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Co-developed-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

33322e3ef074 wifi: ath12k: change DMA direction while mapping reinjected packets
073f9f249eec wifi: ath12k: fix invalid memory access while processing fragmented packets
a57ab7cced45 wifi: ath12k: fix firmware crash during reo reinject

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240520070045.631029-2-quic_ppranees@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


