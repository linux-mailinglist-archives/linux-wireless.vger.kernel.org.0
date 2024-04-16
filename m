Return-Path: <linux-wireless+bounces-6401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4CE8A6FBC
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 17:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3FE1F2237F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE4130A6F;
	Tue, 16 Apr 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLbRiTBm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48C12C7FB
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281134; cv=none; b=lh0tkhgajLscbirC/wzV653ZWhavYVzlRpgASTveiZ9MPSJzL06jKK6Ct8EoVOiPdBCeRKKG6LWFfONPc/yHwvvOH2TZ1NJIL3yXRd7v6d7JWQ/Gx9DH9cAcYXkX7s4SyLSekL88jzn/YiWTJkrT+nFhOlBsservdvogavrdMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281134; c=relaxed/simple;
	bh=K/MSx+kBrzVHwkn5x+iwOZu5fOasPv/F/bgNFCFPMFc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=lHvJgb5yJzGsvYMJd4PcXC0uvEsfiCQuNzgLL4yN+90+rT+fTeNHNW+5B8IUuzWLm8FrSfczMCJBg2q4B3IfAHE6Qme005RZpajan7zWGY6utH2Fb8PXtbtgfy3Vr1zBF2+1HX4RHm0URE3slxVJUQ37oNpyDwZs45q2PBKiGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLbRiTBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AAEC113CE;
	Tue, 16 Apr 2024 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713281134;
	bh=K/MSx+kBrzVHwkn5x+iwOZu5fOasPv/F/bgNFCFPMFc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=cLbRiTBm6XzsFNgW7z9JMXlns1VpD+qOu2wXeAvaV7900t62bBlGDMzVIcghQLmDF
	 3i3wKYxh9r5YYp5TJC/24hYTAPLly7jHigz+CXglb9fOzdw1lSi1TIq4oul/sVMbKx
	 aCsI/R3Iyi1rcnrDMDNve7Z8+1iDVUxDRaH17ZcXeukoAJaBGiMxWe8eWWSYiu1zOn
	 NsmnBIT1/m1hOVmKIv3YhXTP4zhpudCdLREWvU237RcKJY8b1YuzehuzvWn5TjLltr
	 49BguSTzIVZTKF3wpKz/jH3lI9mJoOSAgx6cadUK+p2jTG6twIvG1TOBvdP+46dbqM
	 H3zQbKwi1RWpw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: use RCU when accessing struct
 inet6_dev::ac_list
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240411165516.4070649-2-kvalo@kernel.org>
References: <20240411165516.4070649-2-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171328113106.329964.14896487316067436390.kvalo@kernel.org>
Date: Tue, 16 Apr 2024 15:25:32 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Commit c3718936ec47 ("ipv6: anycast: complete RCU handling of struct
> ifacaddr6") converted struct inet6_dev::ac_list to use RCU but missed that
> ath11k also accesses this list. Now sparse warns:
> 
> drivers/net/wireless/ath/ath11k/mac.c:9145:21: warning: incorrect type in assignment (different address spaces)
> drivers/net/wireless/ath/ath11k/mac.c:9145:21:    expected struct ifacaddr6 *ifaca6
> drivers/net/wireless/ath/ath11k/mac.c:9145:21:    got struct ifacaddr6 [noderef] __rcu *ac_list
> drivers/net/wireless/ath/ath11k/mac.c:9145:53: warning: incorrect type in assignment (different address spaces)
> drivers/net/wireless/ath/ath11k/mac.c:9145:53:    expected struct ifacaddr6 *ifaca6
> drivers/net/wireless/ath/ath11k/mac.c:9145:53:    got struct ifacaddr6 [noderef] __rcu *aca_next
> 
> Fix it by using rtnl_dereference(). Also add a note that read_lock_bh() calls
> rcu_read_lock() which I was not aware of.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> 
> Fixes: c3718936ec47 ("ipv6: anycast: complete RCU handling of struct ifacaddr6")
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to wireless.git, thanks.

feafe59c8975 wifi: ath11k: use RCU when accessing struct inet6_dev::ac_list

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240411165516.4070649-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


