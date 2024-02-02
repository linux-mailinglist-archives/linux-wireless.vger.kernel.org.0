Return-Path: <linux-wireless+bounces-3030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018D0847065
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E471C21061
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D74315AB;
	Fri,  2 Feb 2024 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odsefLlC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A20715A5
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877211; cv=none; b=tA1aeW/4aHihjMU9UIJmsbeqbii4dPntYpJA+noe0Vym79NcUUwpTYa0bSQOTj3Eh/HWzkTJlqUMJ2Iin2xXoYOEdp83fwdaTsGvDpPbYGD2yuSIadKxudxRsfYMfFX2yG47OJ6ZNLrzvJ2u0pinhS8yqkSz+QNGupdLFDgeYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877211; c=relaxed/simple;
	bh=HVpMJX4yaTYtWCWha9jRm5UBMt4O9QaOzbebi8cEGho=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=olVqleGKnAEU98UGw/I/HYHOsrbTWlslI6I8aeachsXFqFx8+eBIOgWAXId+Rkl2kVWIf+qTewyzDUGy9I4WJjqwnxhzuRypGe6Z9u7ImkzxJ8TFgxN5S2O0RTFqbWdmAJlqHishJrR9a9iOGM3d0VxlGDD1yC/DQ/RvmMgGz4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odsefLlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F39C433C7;
	Fri,  2 Feb 2024 12:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877210;
	bh=HVpMJX4yaTYtWCWha9jRm5UBMt4O9QaOzbebi8cEGho=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=odsefLlCKl/Wt5Vc0vljRZBFkBmcm3TO8deQOLPEqcdW6etjyjxwKJg12OFops0QD
	 fkDPYBX8ZRCeYwyX8x1YRMghg3Jh84YnuYH3Z1H/FIGV7eihQCNGUy5SMT1bIJNTI/
	 /6ONzg8w11Lqz+/AP2sxjIOnAHNS13BGxKjbiRtvuZCL8lI6V61iuUCJz0YeSXX6KR
	 Ug+tu6QMXnL7b61LHcWpmrXjHfKDQ97Vo2Ru3eiLyAuyW4AxNWKoldP9CvJnBjneEQ
	 iwYsglhyatMCvknAMCCD14oWhv+VHpjAmM3ry/4FbjWvG4bqYO9u3MRLWmiKxtPvZZ
	 tKsFEmAWTLkYg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 01/13] wifi: ath12k: indicate NON MBSSID vdev by
 default
 during vdev start
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240129065724.2310207-2-quic_rajkbhag@quicinc.com>
References: <20240129065724.2310207-2-quic_rajkbhag@quicinc.com>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Sriram R <quic_srirrama@quicinc.com>,
 Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170687720763.3214428.5130695458131576261.kvalo@kernel.org>
Date: Fri,  2 Feb 2024 12:33:29 +0000 (UTC)

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> wrote:

> When any VDEV is started, MBSSID flags are passed to firmware to
> indicate if its a MBSSID/EMA AP vdev. If the interface is not an AP
> or if the AP doesn't support MBSSID, the vdev needs to be brought up
> as a non MBSSID vdev. Set these flags as a non MBSSID AP by default
> which can be updated as and when MBSSID support is added in ath12k.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

13 patches applied to ath-next branch of ath.git, thanks.

6925eba532e1 wifi: ath12k: indicate NON MBSSID vdev by default during vdev start
9f06911998ca wifi: ath12k: fetch correct pdev id from WMI_SERVICE_READY_EXT_EVENTID
287033810990 wifi: ath12k: add support for peer meta data version
902700d55d4a wifi: ath12k: fix fetching MCBC flag for QCN9274
94e8235c679d wifi: ath12k: Add logic to write QRTR node id to scratch
664a1c96b297 wifi: ath12k: fix firmware assert during insmod in memory segment mode
f7019c2fcdf6 wifi: ath12k: split hal_ops to support RX TLVs word mask compaction
3cf1a9f7a1b2 wifi: ath12k: remove hal_desc_sz from hw params
419927ec8438 wifi: ath12k: subscribe required word mask from rx tlv
57c8b5c332e5 wifi: ath12k: add MAC id support in WBM error path
afeee629e72e wifi: ath12k: fix PCI read and write
af9bc78d14fb wifi: ath12k: Read board id to support split-PHY QCN9274
2d3a7384b9c8 wifi: ath12k: disable QMI PHY capability learn in split-phy QCN9274

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240129065724.2310207-2-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


