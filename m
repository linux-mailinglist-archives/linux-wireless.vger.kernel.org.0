Return-Path: <linux-wireless+bounces-15695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA619D8AE8
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 18:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9EF165C1A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830CC1B4157;
	Mon, 25 Nov 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfF2vjL/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1B1B3930
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554213; cv=none; b=V9vqOHI0miGMNx6yyfsLtI99G54GpUOObJUxKaQRfqI+Ym15DkTmep3v3oRRYiqkLWZfhl3lF273DwrSVJi8W3CypCHEn6nLZNXsO1gV5E6D+BmED8bFlCHIE3nTs92ghB9tru0N/l1nmQYClGZK1k7B9ZmTaudV281ppT9Dqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554213; c=relaxed/simple;
	bh=qsoPHVJ1FKxqyZ/a4Rvp+6vkLWUialj+oE6B0JEmo3w=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=UdcdSeiG8uB2g+OD8Yhm9vIg1flzFlvf+/qNJiXueWqS8lmcHhZn3TXINNAsnxKoLTzCv9+HHtgTesIkkGNtRSn9A8VrIoYq3lkB+cCJZyyZqFedZh9BfyMEMxDxBUv3Bde9Wxa9U4+fD4aLlkDk8f8OFllC0FZ66Ifh7BceirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfF2vjL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBAEC4CECE;
	Mon, 25 Nov 2024 17:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732554212;
	bh=qsoPHVJ1FKxqyZ/a4Rvp+6vkLWUialj+oE6B0JEmo3w=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=SfF2vjL/Q4TDl/AWWXaItVc1cKxnOI2swiiN/+A1UdnArlhH2k/2y0UUY7qZzP4ku
	 v/9NL/x+vJFvMp5kNP0l9cRPgI8MciBkyohc7n9o4Kcu5LFj/s6i853AUlX3vRNI7l
	 IHAG+TLsHVATIcdlL8shOTJv+ClKd1t+4I0dtahKJiMpNjA+Y+9q3Vfc2jHxYN+dtT
	 SheEtRcwLQYIV56JewCv20rvIz3n5h6/oz9tCTC9hmTTENhbt1Phi9UYtRuCaEDGX0
	 kFsAeZfp8IGULQj7LZcK3aD6C2No5oDN8+/xD5zo6G525tkXLBEpUi7NJZ/m5ucVQ4
	 4jN+GQpE6rIVQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] wifi: ath12k: Add MLO station state change handling
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241121155806.1862733-2-kvalo@kernel.org>
References: <20241121155806.1862733-2-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173255421040.2180217.10732984199396676191.kvalo@kernel.org>
Date: Mon, 25 Nov 2024 17:03:31 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> Add changes to handle multi-link station state change with proper
> link handling and add code changes for ML peer creation, peer deletion.
> 
> In ath12k_mac_assign_link_sta() initialise all arsta fields first and only then
> call rcu_assign_pointer(). This is to make sure that readers don't have access
> to arsta which is still modified.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

8 patches applied to ath-next branch of ath.git, thanks.

8e6f8bc28603 wifi: ath12k: Add MLO station state change handling
a27fa6148dac wifi: ath12k: support change_sta_links() mac80211 op
ea4192553850 wifi: ath12k: add primary link for data path operations
061097e5732d wifi: ath12k: use arsta instead of sta
a0300e6bcfd4 wifi: ath12k: add reo queue lookup table for ML peers
aaac8850a07f wifi: ath12k: modify chanctx iterators for MLO
3952657848c0 wifi: ath12k: Use mac80211 vif's link_conf instead of bss_conf
63fdb90642ee wifi: ath12k: Use mac80211 sta's link_sta instead of deflink

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241121155806.1862733-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


