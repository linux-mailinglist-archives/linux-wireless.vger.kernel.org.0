Return-Path: <linux-wireless+bounces-3963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3186165C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 16:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FF61C24A08
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 15:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC284A52;
	Fri, 23 Feb 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHolXJUf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A1084A4A
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703549; cv=none; b=gDAZpXTq3Dw4G6F/m69nCWn+c0VjBBnp/jqdt9ks1oTHuWn1w4DkCgIxgOMFjzgb36Jd5FcT8x6Luz6kL8o2vFZ3grBlHs9kLNOrbFyAEXw8ATN0VtqEI4E14HXPjS3EZBWsMBgQ+G/JTib3qC6iyKzY7uzzRd0YnlfWqxV88Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703549; c=relaxed/simple;
	bh=FmdvAEI4lkHI7aqgmEpRIL+TMUp4vr6etufiYyBm5k4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Ry9QZK6wQv74XyCrtZCtMATr6DIO0WnXO5DSQf7r4KNzPXCWQsAHA+DSycP36cMV2Vdobfsk0DKgp6zoc7WlVB9JYW2Gx5XfseZSdy0Hd38YkNvvQiq4/HQCCBDyDRcgmLj2YaVSpMLEQ5K0bV5YQzaMWMEafN2XdmIOiFWhgMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHolXJUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B540C43390;
	Fri, 23 Feb 2024 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708703548;
	bh=FmdvAEI4lkHI7aqgmEpRIL+TMUp4vr6etufiYyBm5k4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=GHolXJUfZDvh0DEYzWBve3v49ummEY1OKRHt2DHCJl2wD/M/VmTKepWlBp6bCXmSY
	 ssc/1vWwgUnvirVvvS9QsVOJxGgFBzP6LfutylfpEcKYH1XHDCwTbt6JGS8aBv8izd
	 0wxFNEmLB/OXXmVx6OWYijOKHFuxEPhj4/B/B1SEqRpVxMnybmxnJ9dSdu2db+9zQ6
	 iFEqdR0drT1sor+NfGd9SXEgeUxIGOvBSfDNxl6IiB5047dr2U7REWVF/Enk4bPqyK
	 V9mXkmpXj14ceVoM9niaIpoKtqHGt3+gsm/fAQQSqJ5I2UTIn2LNdma7WFMRZgtC9N
	 KdGHYfFtRymdw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: ath11k: rearrange IRQ enable/disable in reset
 path
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240221024725.10057-2-quic_bqiang@quicinc.com>
References: <20240221024725.10057-2-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170870354531.2702005.2457317926886672852.kvalo@kernel.org>
Date: Fri, 23 Feb 2024 15:52:27 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> For non WoW suspend/resume, ath11k host powers down whole hardware
> when suspend and powers up it when resume, the code path it goes
> through is very like the ath11k reset logic.
> 
> In order to reuse that logic, rearrange IRQ handling in the reset
> path.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

5 patches applied to ath-next branch of ath.git, thanks.

d455e805de70 wifi: ath11k: rearrange IRQ enable/disable in reset path
fbb2a14afe00 wifi: ath11k: remove MHI LOOPBACK channels
5f3288a34878 wifi: ath11k: do not dump SRNG statistics during resume
361c90ed3647 wifi: ath11k: fix warning on DMA ring capabilities event
50556081e09b wifi: ath11k: thermal: don't try to register multiple times

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240221024725.10057-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


