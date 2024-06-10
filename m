Return-Path: <linux-wireless+bounces-8764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA1902772
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 19:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963921C2134D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18D1E4B0;
	Mon, 10 Jun 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V52NgtLy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D8139580
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718039281; cv=none; b=Tvjvlu5RfHJ4auQLreSRfekCzFYuxQBxb5QLZqlwINiQ56gL0vUk/ye+ggGfGONTxnl4vJK5hMFDyKKcHgt5q2hpQc3oKL1k+W8QyQE065CVLERvJz+PKhevSble8wNcQylrJLZZCxzNVlYHTazn43Hoog3sK/DWNFI2MKr6srI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718039281; c=relaxed/simple;
	bh=NpVa99PNMxyd2qle9TyoOVLTKSLJ+nVkeuskWbVwSlA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ASXWdIbrpwgEOY5RjKNfvpo2Di8oH3eUKOQS03NEe0114bmhE8l/ateUiHKSbcADj3EADWENvsrZAbOMh7YNgXrc4snmc9AqM2P+hAijejgQ87jZyUaBdf0exL4DVq9HI/uMDTzR3jCSoNvd+QnLeno+dRE/0+UGgXp0y27VqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V52NgtLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F72C2BBFC;
	Mon, 10 Jun 2024 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718039280;
	bh=NpVa99PNMxyd2qle9TyoOVLTKSLJ+nVkeuskWbVwSlA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=V52NgtLyxHzH1un4QwAzSah1lWV5B9pmgy7NkyuOxgQ1o6uOnfbUr/Yv6nRJ19C8L
	 J9+FUU33AKjoLmcjy1gTcpUm3Qu+YtsNcCcXdddP7tjkhaQyPY9A5MMdL67OndN5l1
	 iKApYwe2dIyzELy3zo6TdCf8+buKsObjVwsMe0XvKf5ULDoAEprCfLR8zA4kt6vVks
	 Fd1WoYYBeFkWISbXtUlgfo0WZEIqsjuXUXYCuiiCmGBDGhTWfDJDAT2CQSaahxPSYL
	 JczHrg9KHJSeo+RWhdg0sIB58KloUXHdkS/M5a+FTMdQjRBfhEXztrSXrPZs9XhMrm
	 5L14IDvvriWcw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath11k: fix wrong handling of CCMP256 and GCMP
 ciphers
References: <20240605014826.22498-1-quic_bqiang@quicinc.com>
Date: Mon, 10 Jun 2024 20:07:57 +0300
In-Reply-To: <20240605014826.22498-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Wed, 5 Jun 2024 09:48:26 +0800")
Message-ID: <87zfrsohea.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

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
>>From user point of view, we have observed very low throughput due to this issue:
> action frames are all dropped so ADDBA response from DUT never reaches AP. AP
> can not use aggregation thus throughput is low.
>
> Fix this by setting IEEE80211_KEY_FLAG_GENERATE_IV_MGMT flag and by reserving proper
> MIC length for those ciphers.
>
> Tested-on: WCN6855 hw2.0 PCI
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Reported-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
> Tested-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
> Closes:
> https://lore.kernel.org/all/CADS+iDX5=JtJr0apAtAQ02WWBxgOFEv8G063vuGYwDTC8AVZaw@mail.gmail.com
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

[...]

> @@ -5927,7 +5929,10 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
>  		     ieee80211_is_deauth(hdr->frame_control) ||
>  		     ieee80211_is_disassoc(hdr->frame_control)) &&
>  		     ieee80211_has_protected(hdr->frame_control)) {
> -			skb_put(skb, IEEE80211_CCMP_MIC_LEN);
> +			WARN_ON(!(skb_cb->flags & ATH11K_SKB_CIPHER_SET));

Using WARN_ON() in the data path is not advisable as it's not rate
limited and quite spammy, in the worst case it can lead to kernel
crashing (I have experienced this even myself). ath11k_warn() is safer
in this regard so I changed it to this:

			if (!(skb_cb->flags & ATH11K_SKB_CIPHER_SET))
				ath11k_warn(ab, "WMI management tx frame without ATH11K_SKB_CIPHER_SET");

Please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=aeadb08d7b4acced84a45812f1285c8cd3ed853a

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

