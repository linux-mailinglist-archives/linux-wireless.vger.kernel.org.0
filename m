Return-Path: <linux-wireless+bounces-8811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3AD9043E2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 20:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81AD0B2307D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9613E79B96;
	Tue, 11 Jun 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4Iwu+bF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B879949
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131421; cv=none; b=P/xw6+PZaILzCxZtfSdcJkDKlfaSLhiPKfvbv3AL+mLy0BcVGkqf8u9z2SWVpueNrvHyk0Odgqf+Pw0CMoPEL2HxfiCoKJzvAd3U/QJ6959sSmw8VcfQIcX720n68I7MhP8dY675FgucsDfL89ejX2fRUJ2n8weFsp72GQS48EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131421; c=relaxed/simple;
	bh=RK5lFeShPdN2/t41StVtrCf7E+vf0TXH4AeWM81OjIQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=DyAvYxCXkWFmGXYKCz0yIzq+WKNfNuZj8ATU91woZO9CzktSiwuaifUCwilnEGPqy56dMz19nq54vOuISwKBXicYgkZPJ289C7RkV7SJdQN+4VPsbpvLJRU7Cn1VrOGZ0I2TLRvXnCyI62N6npUi//04DnahPDwlnie6IstLKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4Iwu+bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F091C4AF49;
	Tue, 11 Jun 2024 18:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718131421;
	bh=RK5lFeShPdN2/t41StVtrCf7E+vf0TXH4AeWM81OjIQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=a4Iwu+bFQFRgi132I29iD7u5eRfPfCk7UcR7slPAZImjNQaFGhVuME/2WvatElvvY
	 aLomAoSru4gVcCOBO3Zx1nwNYsdtnJPaqZ1Oyy1XIw/OicqDXyQMSnegclNBYk6ygp
	 D3fE4bDr7NozfWluL1lB5xLCO1nKeBWS+3U21+jzH2MWMOGg5EqDwwBig655n6evjj
	 NyJ9YiHrXaU3FqSOOBDoanXsd5udksPMrt9IdUagvRUd2Xk+zpkro1hRJZnJXJNnpu
	 BGbdn7VY9rQzzIzMn5DUymB+kcVg2kfCBa0+v4SCoxZ0bCGiEPQUZImqJVqpHk3koJ
	 5ulZtOVXlerOQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: fix wrong handling of CCMP256 and GCMP
 ciphers
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240605014826.22498-1-quic_bqiang@quicinc.com>
References: <20240605014826.22498-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171813141843.3564613.12568256142700301980.kvalo@kernel.org>
Date: Tue, 11 Jun 2024 18:43:40 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently for CCMP256, GCMP128 and GCMP256 ciphers, in ath11k_install_key()
> IEEE80211_KEY_FLAG_GENERATE_IV_MGMT is not set. And in ath11k_mac_mgmt_tx_wmi()
> a length of IEEE80211_CCMP_MIC_LEN is reserved for all ciphers.
> 
> This results in unexpected management frame drop in case either of above 3 ciphers
> is used. The reason is, without IEEE80211_KEY_FLAG_GENERATE_IV_MGMT set, mac80211
> will not generate CCMP/GCMP headers in frame for ath11k. Also MIC length reserved
> is wrong. Such frame is dropped later by hardware:
> 
> ath11k_pci 0000:5a:00.0: mac tx mgmt frame, buf id 0
> ath11k_pci 0000:5a:00.0: mgmt tx compl ev pdev_id 1, desc_id 0, status 1
> 
> From user point of view, we have observed very low throughput due to this issue:
> action frames are all dropped so ADDBA response from DUT never reaches AP. AP
> can not use aggregation thus throughput is low.
> 
> Fix this by setting IEEE80211_KEY_FLAG_GENERATE_IV_MGMT flag and by reserving proper
> MIC length for those ciphers.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Reported-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
> Tested-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
> Closes: https://lore.kernel.org/all/CADS+iDX5=JtJr0apAtAQ02WWBxgOFEv8G063vuGYwDTC8AVZaw@mail.gmail.com
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d2b0ca38d362 wifi: ath11k: fix wrong handling of CCMP256 and GCMP ciphers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240605014826.22498-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


