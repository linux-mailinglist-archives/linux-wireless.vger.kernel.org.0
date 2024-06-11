Return-Path: <linux-wireless+bounces-8808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C439043D3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 20:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA3BB2540A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DFF4F606;
	Tue, 11 Jun 2024 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWC855Mm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F294D8BB
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131218; cv=none; b=Agjh9bmVs8svoGewU3WmjnM/bmKLqqL6q0INE6HriyyjogDkEZnPAsYKQPRPOiVmvz9Ra0n2BrGOrg0dCkVABPofBdGDN2EsBR1yyE/lEwq4A99j5RM7QZ/HhL7LueAlr96UWeGhSuATMD1Yyyca52CwLiTSDrI037/Wg22KHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131218; c=relaxed/simple;
	bh=xjTNil0Z8c2KFdRC6UT5suVh0Knn5BS56cRAY4d+jRA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=uyo1sc7zh09isBkcHSMNIlthR6+CvEbhtBn4X0BEghxBE6IQAE4fuBeZUEt28zKZvSMK8BoTJD4lJay1AblKf3QiAsAU/gC/HjduvYuod2cm3OEfP081lawvwRBxot7EenF/7CcsYYr/r72cuZejIEe99dTVTiA4CbxK2bFpGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWC855Mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC012C2BD10;
	Tue, 11 Jun 2024 18:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718131217;
	bh=xjTNil0Z8c2KFdRC6UT5suVh0Knn5BS56cRAY4d+jRA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=kWC855MmxrZtEDuowAvxiHCaXOT1uTVXJpuTsZw1Q6HhENnxjr9RDVwbPiOjRMPqI
	 2vI+whnth/Zj97IDVAJQ8EzMKtWhnds1B1uZHhWtIVb9kinD+3e/y9D+nw1EaOp+DR
	 9La6PbqTp1yLeYiOXuOvC0Q0nOL8kVnCI2QaffKCYTBw9luwdMAldb+iGfyIchhMXc
	 dgirZkpfpGLZ+nn71+kbHaQXFP8Am9/lxnhSw6Ugm0nH9eW15Z6ejkcobJOvNFBuwK
	 N2f1LpiLPlfgxzPE8fQ+WJOIzPKfOKT3ltHS7GDVOSMJbW5HI2YSgbm2Tl6RRgojA2
	 nsMLaOkmTkUJQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix RCU documentation in
 ath11k_mac_op_ipv6_changed()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240531022411.6543-1-quic_bqiang@quicinc.com>
References: <20240531022411.6543-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171813121489.3564613.14982279115447611746.kvalo@kernel.org>
Date: Tue, 11 Jun 2024 18:40:16 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Current documentation on RCU in ath11k_mac_op_ipv6_changed() says:
> 
>         /* Note: read_lock_bh() calls rcu_read_lock() */
>         read_lock_bh(&idev->lock);
> 
> This is wrong because without enabling CONFIG_PREEMPT_RT
> rcu_read_lock() is not called by read_lock_bh(). The reason
> why current code works even in a CONFIG_PREEMPT_RT=n kernel
> is because atomic_notifier_call_chain() already does that for
> us, see:
> 
>         int atomic_notifier_call_chain()
>         {
>                 ...
>                 rcu_read_lock();
>                 ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
>                 rcu_read_unlock();
>                 ...
>         }
> 
> and backtrace:
> 
>         ath11k_mac_op_ipv6_changed
>         ieee80211_ifa6_changed
>         notifier_call_chain
>         atomic_notifier_call_chain
> 
> So update the comment to make it correct.
> 
> This is found during code review, compile tested only.
> 
> Fixes: feafe59c8975 ("wifi: ath11k: use RCU when accessing struct inet6_dev::ac_list")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

53d7c99719e2 wifi: ath11k: fix RCU documentation in ath11k_mac_op_ipv6_changed()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240531022411.6543-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


