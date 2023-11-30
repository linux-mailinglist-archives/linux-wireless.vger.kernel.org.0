Return-Path: <linux-wireless+bounces-242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF157FF857
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 18:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F32281690
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540F256459;
	Thu, 30 Nov 2023 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U65o5Om9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754847A5A
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 17:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8230C433C7;
	Thu, 30 Nov 2023 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701365596;
	bh=t8uwdWXJ/C0JLH2QtDk8ksHVHtSvg4O875BSx0Lnepo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=U65o5Om96swNnsEc4VWBBVrKn+jJlHiJwetMhFbmNLXe21f81nW1mxyUmiOr8kuer
	 p2ZCdwAm1lUz5pBg11I5fkT5M6OdqRR100/Sn0pFOP4hmYQSaMKbuIsIOgdKJ6tpHI
	 mzDvskPaC8jO2bGjRVDlaKMv/isO2xNBT3WnEySjiMIDIE0huKngOIm95A1cck8JHT
	 vMz2Rihy+j1tyFTITKW4m6AqeBrHqu+GEt/6FAG/CePxwKVqPmt2uTkBa1xbQOAV5y
	 923yJJZQG5PSn1Tlx9uQ1lKNyhAR3bGUxAnH7nd19fGkrcNmDjHihju59hb+nQE40L
	 aLx32waVWA8jA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix the issue that the multicast/broadcast
 indicator is not read correctly for WCN7850
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231118134538.19545-1-quic_lingbok@quicinc.com>
References: <20231118134538.19545-1-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <lingbok@qti.qualcomm.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170136559355.1566939.2533583060106709722.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 17:33:15 +0000 (UTC)

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> We observe some packets are discarded in ieee80211_rx_handlers_result
> function for WCN7850. This is because the way to get multicast/broadcast
> indicator with RX_MSDU_END_INFO5_DA_IS_MCBC & info5 is incorrect. It should
> use RX_MSDU_END_INFO13_MCAST_BCAST & info13 to get multicast/broadcast
> indicator.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

ALWAYS run ath12k-check:

drivers/net/wireless/ath/ath12k/hal.c:892:16: warning: cast to restricted __le16
drivers/net/wireless/ath/ath12k/hal.c:892:16: warning: cast from restricted __le32

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231118134538.19545-1-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


