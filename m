Return-Path: <linux-wireless+bounces-10998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6DB948A60
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 09:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01EA1B219A6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 07:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739D63C092;
	Tue,  6 Aug 2024 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCojz3rL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB215D1
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930427; cv=none; b=PxN2TH0cfij1giTxBfMDbuTRvT65H4AKcctPf93/nkgDS+ZaO/Ch2BdReozqa/aRs5gxLf4apMH15g3juttos5sXt4XKDyHbU6Ie/cU7IJ7Qr4chR8KGPvPdePW6A9KDR3V1/RD97pHtG8NvLzPUUV0ZGvYt6CxjVyD0DLQf9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930427; c=relaxed/simple;
	bh=aNHLgtdPKU3e2xxAzCTmFuhZ+7O8MM0gYcitQPGZ1hw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=V7Kc06jSifjlRNXt11087tGnqttQgU4w4Rv4ylxe/sy1dizAjbP4FRozkPPHyvYddSr5Fj/SAvII0/ooM4dHzsgInkOVuLGD8Uv/GrtDCiPLjl1DWwUOVwJIjhf81nTiNE65QCqCnWOYdM/2NQRWEhko9P9ZKoyIIsvgdol+UWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCojz3rL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6DFC32786;
	Tue,  6 Aug 2024 07:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722930427;
	bh=aNHLgtdPKU3e2xxAzCTmFuhZ+7O8MM0gYcitQPGZ1hw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FCojz3rLwRJvyvqm4dhyIaYHk0rFHiSVYj2Gvt6MFqjOh2kXXz6JbBNnd2Bj+gAwb
	 PykoF8Pgzu9NccAtgZEQENtZtRD4qsp6b5e+ZYgMoe2845X8o9Z5vGtsQJdMX8dhU9
	 QrR2/tAsQQ8SwVrBVXLmjNZAoRxP6oR6xY1IKfk9lwasn4jqiqqF7eevOLa33C32a4
	 QhdDMb7tv4XsSFBFP3QFr4D/38c2UAcJkfLEhzo7+XEylRdqGPisjWNqAjnOaeVpux
	 87LNo+V3m29/9Ys/kEsZKugDvaFIcXEWm0HI3g7sOBdtTqn7gCEclgiI1BmvHbQQOL
	 /NiiHeSm/YPxw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: ath11k: Add rx histogram stats
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230427100730.1328970-1-quic_mkenna@quicinc.com>
References: <20230427100730.1328970-1-quic_mkenna@quicinc.com>
To: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
 Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
 Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172293042371.3540390.11798501362964094495.kvalo@kernel.org>
Date: Tue,  6 Aug 2024 07:47:05 +0000 (UTC)

Maharaja Kennadyrajan <quic_mkenna@quicinc.com> wrote:

> Add peer specific debugfs support to store and
> display peer rx stats info like HE, VHT, HT,
> legacy and NSS.
> Also, add a debugfs knob to reset rx stats
> specific to the peer.
> 
> This helps  to debug the throughput related
> issues in the UL traffic(STA to AP) by getting
> the segregated rx_stats info like HE, VHT, HT etc,.
> 
> There is no addition of new debugfs_file here to get
> these segregated stats. The exising rx_stats is enhanced
> to get these stats.
> 
> Usage:
> 
> To print rx stats:
> echo 1 > /sys/kernel/debug/ieee80211/phyX/ath11k/ext_rx_stats
> cat /sys/kernel/debug/ieee80211/phyX/netdev\:wlanX/stations/
>         <peer_mac>/rx_stats
> 
> To reset rx stats:
> echo 1 > /sys/kernel/debug/ieee80211/phyX/netdev\:wlanX/stations/
>         <peer_mac>/reset_rx_stats
> 
> Output:
> 
> RX peer stats:
> Num of MSDUs: 116
> Num of MSDUs with TCP L4: 0
> Num of MSDUs with UDP L4: 0
> Num of MSDUs part of AMPDU: 0
> Num of MSDUs not part of AMPDU: 116
> Num of MSDUs using STBC: 0
> Num of MSDUs beamformed: 0
> Num of MPDUs with FCS ok: 116
> Num of MPDUs with FCS error: 0
> BCC 5 LDPC 111
> preamble: 11A 5 11B 0 11N 0 11AC 111 11AX 0
> reception type: SU 116 MU_MIMO 0 MU_OFDMA 0 MU_OFDMA_MIMO 0
> TID(0-15) Legacy TID(16):0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5
> RX Duration:6459
> 
> RX success packet stats:
> 
> HE packet stats:
> MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0
> MCS 6: 0        MCS 7: 0        MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0
> 
> VHT packet stats:
> MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 111
> MCS 5: 0        MCS 6: 0        MCS 7: 0        MCS 8: 0        MCS 9: 0
> 
> HT packet stats:
> MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0        MCS 6: 0        MCS 7: 0
> MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0       MCS 12: 0       MCS 13: 0       MCS 14: 0       MCS 15: 0
> MCS 16: 0       MCS 17: 0       MCS 18: 0       MCS 19: 0       MCS 20: 0       MCS 21: 0       MCS 22: 0       MCS 23: 0
> MCS 24: 0       MCS 25: 0       MCS 26: 0       MCS 27: 0       MCS 28: 0       MCS 29: 0       MCS 30: 0       MCS 31: 0
> 
> Legacy rate packet stats:
> 1Mbps: 0        2Mbps: 0        5.5Mbps: 0      6Mbps: 5
> 9Mbps: 0        11Mbps: 0       12Mbps: 0       18Mbps: 0
> 18Mbps: 0       24Mbps: 0       36Mbps: 0       48Mbps: 0
> 
> NSS packet stats:
> 1x1: 5 2x2: 0 3x3: 111 4x4: 0 5x5: 0 6x6: 0 7x7: 0 8x8: 0
> 
> GI: 0.8us 5 0.4us 111 1.6us 0 3.2us 0
> BW: 20Mhz 5 40Mhz 0 80Mhz 111 160Mhz 0
> 
> Rate Table (packets):
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0             111               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
> 
> RX success byte stats:
> 
> HE byte stats:
> MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0
> MCS 6: 0        MCS 7: 0        MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0
> 
> VHT byte stats:
> MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 12742
> MCS 5: 0        MCS 6: 0        MCS 7: 0        MCS 8: 0        MCS 9: 0
> 
> HT byte stats:
> MCS 0: 0        MCS 1: 0        MCS 2: 0        MCS 3: 0        MCS 4: 0        MCS 5: 0        MCS 6: 0        MCS 7: 0
> MCS 8: 0        MCS 9: 0        MCS 10: 0       MCS 11: 0       MCS 12: 0       MCS 13: 0       MCS 14: 0       MCS 15: 0
> MCS 16: 0       MCS 17: 0       MCS 18: 0       MCS 19: 0       MCS 20: 0       MCS 21: 0       MCS 22: 0       MCS 23: 0
> MCS 24: 0       MCS 25: 0       MCS 26: 0       MCS 27: 0       MCS 28: 0       MCS 29: 0       MCS 30: 0       MCS 31: 0
> 
> Legacy rate byte stats:
> 1Mbps: 0        2Mbps: 0        5.5Mbps: 0      6Mbps: 346
> 9Mbps: 0        11Mbps: 0       12Mbps: 0       18Mbps: 0
> 18Mbps: 0       24Mbps: 0       36Mbps: 0       48Mbps: 0
> 
> NSS byte stats:
> 1x1: 346 2x2: 0 3x3: 12742 4x4: 0 5x5: 0 6x6: 0 7x7: 0 8x8: 0
> 
> GI: 0.8us 346 0.4us 12742 1.6us 0 3.2us 0
> BW: 20Mhz 346 40Mhz 0 80Mhz 12742 160Mhz 0
> 
> Rate Table (bytes):
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0           12742               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
>          0               0               0               0               0               0               0               0
> 
> DCM: 0
> RU: 26: 117 52: 0 106: 0 242: 0 484: 0 996: 0
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
> Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>

Dropping this, please rebase if still needed.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230427100730.1328970-1-quic_mkenna@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


