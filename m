Return-Path: <linux-wireless+bounces-16314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32899EE933
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 15:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C968168DB8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3A32156FC;
	Thu, 12 Dec 2024 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU8G74V4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A621504F
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014505; cv=none; b=VdYiKI+fHyrUyyug6qu9dlzs9yGulrQ6qxzWBCOEXwPXMi3H2G55jEyCgTEtDU6T7aZBgLgw78Dd7xi0QpUjsG/cXUbAQbvEnOy/SUQBap8q7ANNL+6RFUOeIt6EE/AAIsHugRKQiofVfEgWQuZKokBE8uyMCvAD+HEJmwKm6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014505; c=relaxed/simple;
	bh=udnd5ep7XfiooWEs5z9E+RQRDinbRyC/oY7Nx1gVPBc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ak3ZsS49vYovZLPfAkELFGhE7aEhKHdv17q+mj9LqWStB9dmphRIfSge55hyY1/2a03Q3coKvYl4zlws1bgVLxjYL3H5tT+kmlF4Uw6uhZVwS3IKeBwNtFi1gbq6jqs4H1JaEadDH4KU35gi7MPWyTL8+98ik6lNfsqssUzOZwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU8G74V4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9F8C4CECE;
	Thu, 12 Dec 2024 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734014504;
	bh=udnd5ep7XfiooWEs5z9E+RQRDinbRyC/oY7Nx1gVPBc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=QU8G74V4v4jtg8HVIHCG1mnlLKF+1kT6vzRHe2M64MAJUbqkHfo+22dlupzCkA8NN
	 Hp4XAdyB5SJIzh+Z+0gm2r+LJ9am+Gu/a1unfXgC/Y9HQqw/Ycg6Emf1HtROtiRipt
	 xjWSRuBrpEHBs/6fyDwJR6uYgaKwLVE5ivlDMs7GNOz9RyEup3brM4Wy/R80NCiHnR
	 g121QSbikVu19hu+FwKe1Dde9UCMmSgDAXBDCFH1bTMJ4FKK1bCRTw4BMkJOGC+9uv
	 MAB/PVhaw2wMJRGFUsB5zItgXz16Sr0G9nhDAKuInNZyRa6fLfEFG1ufayUvRQ6PIK
	 cNG1aKoKjqEDA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] wifi: ath11k: fix RCU stall while reaping monitor
 destination ring
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241008053744.1070-2-quic_kangyang@quicinc.com>
References: <20241008053744.1070-2-quic_kangyang@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173401450207.833118.1446184244363325456.kvalo@kernel.org>
Date: Thu, 12 Dec 2024 14:41:43 +0000 (UTC)

Kang Yang <quic_kangyang@quicinc.com> wrote:

> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> While processing the monitor destination ring, MSDUs are reaped from the
> link descriptor based on the corresponding buf_id.
> 
> However, sometimes the driver cannot obtain a valid buffer corresponding
> to the buf_id received from the hardware. This causes an infinite loop
> in the destination processing, resulting in a kernel crash.
> 
> kernel log:
> ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
> ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed
> ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
> ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed
> 
> Fix this by skipping the problematic buf_id and reaping the next entry,
> replacing the break with the next MSDU processing.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241008053744.1070-2-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


