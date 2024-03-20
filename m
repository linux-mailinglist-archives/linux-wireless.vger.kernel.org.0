Return-Path: <linux-wireless+bounces-4981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664EC8812B8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 14:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971B51C235F9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F313D54C;
	Wed, 20 Mar 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF8Ve8tQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D079929CFD
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942851; cv=none; b=QM57O12wrW7BVJpCHBDBWFzkzKM4WbqY2nTBipUYaCbadDAJ2B7RgxErOK6/XdLtYUgacTS/oMBN7Kca598Q5f6R7C5HthEKqh8m5TaP0gKyzygR3gf22oVfyyr8m1CDgxEjLZNq30z1Vgpyog8ubHT9fkPVUWWFkVb3U3T3Kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942851; c=relaxed/simple;
	bh=E4HAccDgIzvq1QD9IsgxBSUka7YbR2QB3za8XjJ+a0Q=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=dJocek1LC1T6cgeB5x4GrCvIqU3wt2TBGajDcspq6sGyCctLTNi/+4HxOyYzc+U+o9rImp3Lne7kXipc8oMcIRdZ/OcDHmKdXjYpSJh1gSyyTkI+hYLYgHjHxyZeGG3PiKwf/JBQjqazDS4mIxXx4QP5+KtsujN2cBJvYxXxBuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF8Ve8tQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D835C433F1;
	Wed, 20 Mar 2024 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710942851;
	bh=E4HAccDgIzvq1QD9IsgxBSUka7YbR2QB3za8XjJ+a0Q=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=XF8Ve8tQGWxcGo42PbO6D1Z2/vqOPRZua8ZK5nKLHpgPnQ8gVoxnnSmA1D+yQdF9M
	 9oYwY+K41K6ax8zEsnEtEGujnDE+Ho2SHpSCyLTGAdvAwvoaKQU9/i95exEjx4oYUp
	 E5xZpf0MjFs1lzzPTqMdbhenbRxnC0yILLoBSYHY2ThcGFO81KBSd1L3quNKcHkhni
	 SqJWtnboy6ahTHZAmH2aCdGTZfrv+1SrFAGNRmKUUMtrcFRFzlRknD+QQq7LinFaoW
	 JeN0R+gGn4MBepIPN6La5Lc1CcA6jm177tM0li+ABpAm6855eR+QbPbdN8fQJHseL/
	 A0JjLSXTpDofA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: do not process consecutive RDDM event
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240111071406.14053-1-quic_bqiang@quicinc.com>
References: <20240111071406.14053-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171094284861.3225057.1212406705882400621.kvalo@kernel.org>
Date: Wed, 20 Mar 2024 13:54:10 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently we do reset for each RDDM event from MHI, however there are
> cases, see below log, that we get two or more consecutive events, and
> it is pointless to do reset for the subsequent ones. What's more, it
> makes reset process more likely to fail.
> 
> [ 1502.115876] ath11k_pci 0000:04:00.0: boot notify status reason MHI_CB_EE_RDDM
> [ 1502.115884] ath11k_pci 0000:04:00.0: firmware crashed: MHI_CB_EE_RDDM
> [ 1502.224041] ath11k_pci 0000:04:00.0: boot notify status reason MHI_CB_EE_RDDM
> [ 1502.224050] ath11k_pci 0000:04:00.0: firmware crashed: MHI_CB_EE_RDDM
> 
> Add a check to avoid reset again and again. This is done by tracking previous
> MHI status: if we receive a new RDDM event while the previous one is
> also the same, we treat it as duplicate and ignore it, because normally
> we should receive a MHI_CB_EE_MISSION_MODE event between them.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

There was a simple conflict in copyright year which I fixed:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=8d2bcb72053d955aebb8c398ebf2ad73afca5731

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240111071406.14053-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


