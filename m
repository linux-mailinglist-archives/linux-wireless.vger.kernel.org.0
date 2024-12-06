Return-Path: <linux-wireless+bounces-15980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C779E7498
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 16:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E56B18817F9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1440C1FCD11;
	Fri,  6 Dec 2024 15:42:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D71FC7CB
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499725; cv=none; b=G/xpSINwouoPjNTRbtU6QU7BsTPf40oH0zpWGBPQPjVqe0vcMoWpck15DxMj4/FI6Xhl9jQCQ8YszMsyWHb8zxBUUyaT+7m26E0RLkw/Xet+CBfVBm94FhD4UR7BJjBRczBlSE4EIZHWFFmbXf4M8kncBTdNDJm3AmSf2CuC+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499725; c=relaxed/simple;
	bh=qst2g2RoMHSpg6nySsNylskaVinTB4lSH/2RTi+L0D8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U9P/fPOjjNiPP7N6budiMcEt5TUklGdw2z7NznRB6qdbBM29xXio+Ul/4217kIu4IVyfrBmwG+fWJLqcHNxwXTsV354kMyuqXjlwV/FeANFE1xx6gKSEjJe/7bAtqTfTH31WR0g075pEcs8lCzThXkiJwuyaKy7J1si34EXaurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64632C4CED1;
	Fri,  6 Dec 2024 15:42:04 +0000 (UTC)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241204163216.433795-1-kvalo@kernel.org>
References: <20241204163216.433795-1-kvalo@kernel.org>
Subject: Re: [PATCH 0/7] wifi: ath12k: MLO support part 6
Message-Id: <173349972434.1649864.17683658768076689357.b4-ty@oss.qualcomm.com>
Date: Fri, 06 Dec 2024 07:42:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Wed, 04 Dec 2024 18:32:09 +0200, Kalle Valo wrote:
> In this patchset there's refactoring to support hardware grouping, meaning
> multiple hardware devices can be registered to mac80211 as a single device.
> 
> Please review.
> 
> Aditya Kumar Singh (1):
>   wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp
> 
> [...]

Applied, thanks!

[1/7] wifi: ath12k: move ATH12K_FLAG_REGISTERED handling to ath12k_mac_register()
      commit: a5686ae820fa7ab03226a3b0ff529720b7bac599
[2/7] wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp
      commit: 46d16f7e1d1413ad7ff99c1334d8874623717745
[3/7] wifi: ath12k: introduce device group abstraction
      commit: 6f245ea0ec6c29b90c8fa4fdf6e178c646125d7e
[4/7] wifi: ath12k: refactor core start based on hardware group
      commit: ee146e11b4d9183e01d8b7e4963941730ed4af6d
[5/7] wifi: ath12k: move struct ath12k_hw from per device to group
      commit: a343d97f27f514015e6d5e789672cf4ab4111720
[6/7] wifi: ath12k: send QMI host capability after device group is ready
      commit: d302ac65ac938516487f57ae20f11e9cf6327606
[7/7] wifi: ath12k: introduce mlo_capable flag for device group
      commit: da8656797ae10b524a7a0c3d5eeb6237fa3ddd70

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


