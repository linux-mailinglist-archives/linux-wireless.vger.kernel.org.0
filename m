Return-Path: <linux-wireless+bounces-709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A20F80F4A9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 18:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35250281582
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 17:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1B57D89C;
	Tue, 12 Dec 2023 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYBVRVY1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292A6FDC
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 17:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F48C433C7;
	Tue, 12 Dec 2023 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702402455;
	bh=yk6/skGYK6YvSbUR9DTx4a8xAsateDiOD9tx7ERd4nQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=WYBVRVY1g61Otta5VIkRm5KAu0U3eGsGlKSBeIr10JSJ5wg5V9N0MN8LBKhkPf3Yb
	 IIDGkuEMDxZRsgXqDEdmm/ackG5+kMhcaqZr1GSRwOxc6Wi8jM8VQ7v3ixHUaA0y5d
	 8ausYg5HlF0K5jfaZbHlgQL/DLN0zfSWzjhhM1UMupi30gf0Tz1f9OR5oGD2hGBKLf
	 ziPeKe2MHIaC23jQt37dQkiqpQMEKjqWwlYObtk09lijv37bCIxR9egbYhjh82rPdU
	 WuLysKGGzS1p8SJgbk6vPJCKOla3aWNU7HlpaHWcnxmJkDrVexVwIoBKHedHcn7ymi
	 BsEKTly41MY0A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: fix the issue that the
 multicast/broadcast
 indicator is not read correctly for WCN7850
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231206141759.5430-1-quic_lingbok@quicinc.com>
References: <20231206141759.5430-1-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_lingbok@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170240245237.422537.1028242008359125098.kvalo@kernel.org>
Date: Tue, 12 Dec 2023 17:34:14 +0000 (UTC)

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
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

7133b072dfbf wifi: ath12k: fix the issue that the multicast/broadcast indicator is not read correctly for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231206141759.5430-1-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


