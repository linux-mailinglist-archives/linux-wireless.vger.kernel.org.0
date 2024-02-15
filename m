Return-Path: <linux-wireless+bounces-3621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5584D856168
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 12:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F451C227EE
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADAB12AAE2;
	Thu, 15 Feb 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1fh7ZBm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C30433B1
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996202; cv=none; b=q3Bm37G0X1GD1qzF543/SNjTKXMX6iNuYov2Xdxv69ciHusU3lCt9HGFk835SzoQwbxf12e9OQY00miEqSFQwMNKc8k7tmu0qUoUhLkujz+tfAJ55kB31oZCxv7ebINSyA6zQ5nRuwAthYIig9/B4kZDn9NS2tOBDeuaMbDDWq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996202; c=relaxed/simple;
	bh=C6N3/0wDtLwXR2sls+yfk8OM9K0bXFSbUJdhXTIGiio=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jJboIW/gWPqxw20I4CfZ/SY1zEnEH7QuT6O2j6nhfB7U5RrldJoGlOY6Np5ikRQUNXBIY6NZ4rdTJzqYNZ4ElJpgpSVq5C9rkrhRANhlnzHBSdPwOiR0NpcVdLDae4iD0clT6BGfOsONmmL8QLuIRKh9OBVbrcoXU0MxdehJ7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1fh7ZBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93E4C433C7;
	Thu, 15 Feb 2024 11:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707996201;
	bh=C6N3/0wDtLwXR2sls+yfk8OM9K0bXFSbUJdhXTIGiio=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=a1fh7ZBmGtPpE82FyDq9nxpbueQQohdFqDif/jHUAMNjH4Piwx4+4HY2r5utCj6cx
	 FZOC8RxDfExSJVeh5kVc16dpbZqeLHZ6D1qzLAM4JZ7kOlwKX14W5LTt9FChEhvyJJ
	 eVWsql3kmW0ueKjAH1OHsYMWAEo9gAIFhQkZ3j8Dp61/JfKKFN/uRGKjzpfkyQhgRY
	 shFcAiarBoPOQbMWjYHu3CVKvI1W3oVCi3VEuLnkd1tm7zO0zbKuY+yJenMuMjbWYZ
	 zTa5A33BujfML7he9yG04bPKyR1eARqTS0kPgZqYLLGGC6L9jZ6N0cSbAUqCrCDV2I
	 /lZ8CD4Jhxmjw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
References: <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
To: Carl Huang <quic_cjhuang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_cjhuang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170799619862.3860606.4011867869809767711.kvalo@kernel.org>
Date: Thu, 15 Feb 2024 11:23:20 +0000 (UTC)

Carl Huang <quic_cjhuang@quicinc.com> wrote:

> Add hardware parameter support_dual_stations to indicate whether 2 station
> interfaces are supported. For chips which support this feature, limit total
> number of AP interface and mesh point to 1. The max interfaces are 3 for such
> chips.
> 
> The chips affected are:
> 
>  QCA6390 hw2.0
>  WCN6855 hw2.0
>  WCN6855 hw2.1
> 
> Other chips are not affected.
> 
> For affected chips, remove radar_detect_widths because now
> num_different_channels is set to 2. radar_detect_widths can be set only when
> num_different_channels is 1, see mac80211 function wiphy_verify_combinations
> for details. This means that in affectected chips DFS cannot be enabled in AP
> mode.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

f019f4dff2e4 wifi: ath11k: support 2 station interfaces
24395ec11707 wifi: ath11k: provide address list if chip supports 2 stations

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230714023801.2621802-2-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


