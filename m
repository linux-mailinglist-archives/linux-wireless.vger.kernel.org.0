Return-Path: <linux-wireless+bounces-3013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB01D846F4A
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB17F1C246A4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A42651A2;
	Fri,  2 Feb 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKiFdLxI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B88608FD
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874117; cv=none; b=MnAwx7Pggca60mnvvydLoUykTvPZjAGLJ2KYNyfSwqVuvHFbQvcejKLjGiHaY827GDIYus7u703GGihOqIto7eTVVwwn9F7hyCm2gMd+e0tRBTjecGXEGlbrgsBNnN+HZSv2G2qdf5pmpnju14t566DKVHZMGYUgDnw0cor3BX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874117; c=relaxed/simple;
	bh=z4gO3mQEqJNFiFdLOMUsqG+yj2/Gcf/2cOR4uqD60BM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=i+2lINcDRFPq8qZzOdylJPBUi/sivzsQ7xhEEkd0oOMBrh21dO7QXB5Q0nyHTsTWJ7T3EqOOgod7nF2J4anNd7EdsHWFA/JRkflymQi4K4tYJ7YAYENRWFKU6Liz4aiHJMLuqI/IKFFWC41ULLouNGBGyaHkYXxf9Q+GFYeeeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKiFdLxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D29FC433F1;
	Fri,  2 Feb 2024 11:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874117;
	bh=z4gO3mQEqJNFiFdLOMUsqG+yj2/Gcf/2cOR4uqD60BM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=KKiFdLxIqUk+F0Va0NnSfqzLthXkiQgrakd22NAqiKhx2ilEJ3Doef9hMk+UzLE3P
	 mavVexPZpQ+deNy40zkcoSBFxcSUKO/QQU/HZKSpNVhwnaSfMcNCWBZUQFWsQ7eNQY
	 qyByZt42B+FotnIep1uWMUB0w8BKMDtHOAwpmWmla+Uxtwy1cfunRE3CFClBeo1ovv
	 /5k39+XCpxZ4XfQByc2KBrFfHmFRhasFOaihel4bahx4KaJ5vefAYcxZPJPmPXXlca
	 IRud+uKWsczxjXlmBx4ywaw3ytuMfbnMqcwF+ZsuWTTncoGNOVFrnGJ5QdBpisXesA
	 2lSFIfjLzK0cg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: change to move WMI_VDEV_PARAM_SET_HEMU_MODE
 before WMI_PEER_ASSOC_CMDID
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240131021832.17298-1-quic_bqiang@quicinc.com>
References: <20240131021832.17298-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170687411452.3200018.9505739166220430603.kvalo@kernel.org>
Date: Fri,  2 Feb 2024 11:41:56 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently when connecting to an AP with 11AX-HE phy mode, host sends
> WMI_VDEV_PARAM_SET_HEMU_MODE parameter to firmware after
> WMI_PEER_ASSOC_CMDID command. This results in TXBF not working, because
> firmware calculates TXBF values while handling WMI_PEER_ASSOC_CMDID,
> however at that time WMI_VDEV_PARAM_SET_HEMU_MODE has not been sent yet.
> See below log:
> 
> AP sends "VHT/HE/EHT NDP Announcement" to station, and station sends
> "Action no Ack" of category code HE to AP, the "Nc Index" and
> "Codebook Information" are wrong:
> 
> Issued action:
> IEEE 802.11 Action No Ack, Flags: ........
> IEEE 802.11 wireless LAN
>     Fixed parameters
>         Category code: HE (30)
>         HE Action: HE Compressed Beamforming And CQI (0)
>             Total length: 152
>             HE MIMO Control: 0x0004008018
>                 .... .... .... .... .... .... .... .... .... .000 = Nc Index: 1 Column (0)
>                 .... .... .... .... .... .... .... ..0. .... .... = Codebook Information: 0
> 
> Change to send WMI_VDEV_PARAM_SET_HEMU_MODE before WMI_PEER_ASSOC_CMDID,
> then firmware will calculate the TXBF values with valid parameters
> instead of empty values. TXBF works well and throughput performance is
> improved from 80 Mbps to 130 Mbps with this patch.
> 
> Good action after this patch:
> IEEE 802.11 Action No Ack, Flags: ........
> IEEE 802.11 wireless LAN
>     Fixed parameters
>         Category code: HE (30)
>         HE Action: HE Compressed Beamforming And CQI (0)
>             Total length: 409
>             HE MIMO Control: 0x0004008219
>                 .... .... .... .... .... .... .... .... .... .001 = Nc Index: 2 Columns (1)
>                 .... .... .... .... .... .... .... ..1. .... .... = Codebook Information: 1
> 
> This change applies to all chipsets.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Fixes: 38dfe775d0ab ("wifi: ath11k: push MU-MIMO params from hostapd to hardware")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

413e20e82ee7 wifi: ath11k: change to move WMI_VDEV_PARAM_SET_HEMU_MODE before WMI_PEER_ASSOC_CMDID

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240131021832.17298-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


