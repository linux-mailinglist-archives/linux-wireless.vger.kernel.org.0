Return-Path: <linux-wireless+bounces-8008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C756B8CD28D
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45FA5B209AF
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040113B5B0;
	Thu, 23 May 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Tppuyf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0648174C
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468486; cv=none; b=EhV6V0MWOO70kiO+bdAfB7xNzbhfoLwVikBF6IC1kWGTqmso8wF/5+R7UvVduJtPZWT86becJsv7XI2mC+Ni1k/E+YT16Si+pEneMDPBGAj4pXmthsh6tlgWVDrB7mqa4ewWPip+90dL987+kXjFutNnPj/QOrlQDDVXXw/4u2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468486; c=relaxed/simple;
	bh=mw3AjiCutiW5+eW1CEA3+1A3NI+qqQKSV7bBWw+3fjY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=pvbEKzZ8ArM4bjhJ1qR1OMETGgUe83ihtkSdeqyP+CSFNln7wHaQAZ0Nxubdews/Ck6gnZR3JhAQ58yomXm/NmnuWtT/J3Maq85dE1KrUoyJ9vqVOhGFnqOpVrX9Hzfk49+gMDP/6w9b3e+oNhwlTgsvGGQ5zVm2CVgKh58ijpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1Tppuyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F49C2BD10;
	Thu, 23 May 2024 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716468486;
	bh=mw3AjiCutiW5+eW1CEA3+1A3NI+qqQKSV7bBWw+3fjY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=b1TppuyfHaDkLG+zR2kEdUMzGxX7W6VLxyicvyEaietYeTmVXKCxmrNFYPYnScRN5
	 vjJ/lyjEo7xU+Dx1v+LP4LXgW1PK+TYHtNRuamyM0VMNm7YMGzwV8GPRl5752HLoUl
	 FwQAxtZ0n43T3rYwhNR8eRax+YnrPBkM0vZ/R+tvpAlxTVltVNiOM6RDuvp6i5+L7X
	 UngRfLRK2P1NCbOH8hLT/6/4o+B+ALR2bZGRvWYXwYFlmtMcCdGqH9QExE6O1/OqKy
	 UQ0DNSZW9jNKCLb+s8dc23EDaNCD8K1Z61AGhdTVKblztCBw1XBS3CbnzR4nsQBKE9
	 LbNBOgSvbJ9jg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: move power type check to ASSOC stage
 when
 connecting to 6 GHz AP
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240424064019.4847-1-quic_bqiang@quicinc.com>
References: <20240424064019.4847-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171646848396.213015.14022235573584346331.kvalo@kernel.org>
Date: Thu, 23 May 2024 12:48:05 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> With commit bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
> ath11k fails to connect to 6 GHz AP.
> 
> This is because currently ath11k checks AP's power type in
> ath11k_mac_op_assign_vif_chanctx() which would be called in AUTH stage.
> However with above commit power type is not available until ASSOC stage.
> As a result power type check fails and therefore connection fails.
> 
> Fix this by moving power type check to ASSOC stage, also move regulatory
> rules update there because it depends on power type.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Fixes: bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-current branch of ath.git, thanks.

6e16782d6b4a wifi: ath11k: move power type check to ASSOC stage when connecting to 6 GHz AP

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240424064019.4847-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


