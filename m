Return-Path: <linux-wireless+bounces-5860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9143D8984B1
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 12:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D73B27E8E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F45B59B78;
	Thu,  4 Apr 2024 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9u4v2oK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA3101E6
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225251; cv=none; b=pIJ9nUFN+BIRvGe+FBIQhDmyZUN6qNkaT2Pz9xRUFnH9zUyKo4NN/ZTMsfpIwn+7DIHdxSlPsFgue7+w8ZtTu/tSXfWPr2qeUG91N5sYfxLzf5dD5pP5pvcALvh4qaHmiffButtHM6J+JJfZ5N+/6JYb2VSlhYkrAcolKQyGPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225251; c=relaxed/simple;
	bh=XEgOJFtAd5hyX1dGEovuhPvmsdKiprDvZmqlS9wDNQI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=balJKIcW8aEiaqG0FH/ZijZ9jCmoLWDwClJASe9VByYSvVbaPfiJ3Yck8KgBYFCddywgpXEcyYP6fu8nxAi3i910iY2EvYn8iNv3Dt0bq7ulibsbTzRVvoVyU9OJgzAhGM94a2n8y7lbsUNfRbe2MWwJfsR81E61ud1B+YkrYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9u4v2oK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FF2C433C7;
	Thu,  4 Apr 2024 10:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712225250;
	bh=XEgOJFtAd5hyX1dGEovuhPvmsdKiprDvZmqlS9wDNQI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=c9u4v2oKow1m8FOfV3+vm3m7neKDXSA93hj7pjGlY9T+UdS86Z4SH/OKmaN+1hHx8
	 rBF3gLqFhx4bshxkzVlJqAnpabSIhWogMGI90Idv1X3CZ+FeHko2531gK/YArNXhoJ
	 RQr6Y4CcmkHR0nyj7XS9trmAFyg3lFwb+fW7AGZu8BvwFAwJlgqoe3G78lmu601eVk
	 YYJtTA2xG24N2rHtQPQ+QjdgjlckenswgCHshFSSwZoiEoOtzUGQYldZ55WwW/kMXV
	 SCi09j0deiZkFaOpaIwbsu+q/nPeA3M49rQIsOpaT5mehZcK+Km2eE685Y5zvIvShm
	 3Q/xS0+N5ZaZw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: Add initial debugfs support in ath12k
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240320171305.655288-2-quic_rgnanase@quicinc.com>
References: <20240320171305.655288-2-quic_rgnanase@quicinc.com>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>,
 Ramya Gnanasekar <quic_rgnanase@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171222524717.1806092.5883238198294792890.kvalo@kernel.org>
Date: Thu,  4 Apr 2024 10:07:29 +0000 (UTC)

Ramya Gnanasekar <quic_rgnanase@quicinc.com> wrote:

> The initial debugfs infra bringup in ath12k driver and create the ath12k debugfs
> and soc-specific directories in /sys/kernel/debug/
> 
> For each ath12k device, directory will be created in <bus>-<devname>
> schema under ath12k root directory.
> 
> Example with one ath12k device:
> /sys/kernel/debug/ath12k/pci-0000:06:00.0
> 
> ath12k
> `-- pci-0000:06:00.0
>     |-- mac0
> 
> To enable ath12k debugfs support (CONFIG_ATH12K_DEBUGFS=y)
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

f8bde02a26b9 wifi: ath12k: initial debugfs support
f51d917b7330 wifi: ath12k: debugfs: radar simulation support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240320171305.655288-2-quic_rgnanase@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


