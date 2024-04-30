Return-Path: <linux-wireless+bounces-7048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E008B7740
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 15:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789551C20922
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 13:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0644A171640;
	Tue, 30 Apr 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV4jsJ5L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630842AA5
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484142; cv=none; b=luTIFN5J3CdCBfDVR/dXpLoqACF7dMOOMrR4r0XNTgMBwmSn8h6vQ/pm0SOjXZS8wXExyL2ORSH/dcMu+8UdjpIaN9j6oal+E1p+fXkKu2ykrc007RGJ2uTZFIr9ipmPKH6IkF9cCQGJI5Q+lV0cUFj5GLe7QUZ4+BYIuZbvtmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484142; c=relaxed/simple;
	bh=BS4Ex7IDF8ZvIW9lV3JywjDVj9PSW7RLDN20me3TgKw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=eqcE8mksYCetSM6nCWv96HZXI5GpQ0UF1rnDo+Rin8JwlC6nVsN17cuUkWSwPVsnEVVO+2xwASx/HJ4hK1cv9up0os7LI/TmXcyXiQE2BDtrzLa4qugciPy8xpWV2XkVhnZxRdqHSYwgGHNr0i4S3UpZtffwRUGj/z0VybK/Eys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV4jsJ5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E7FC4AF18;
	Tue, 30 Apr 2024 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714484142;
	bh=BS4Ex7IDF8ZvIW9lV3JywjDVj9PSW7RLDN20me3TgKw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=BV4jsJ5LPmBqPzC0gnQHzmHg0GRz1qo4abBCZ40VXLW9WuWMK1s64EG/lpXzsWc+8
	 2C0gVt7lMECrN8aM833fiAtyBAlSjeK93putnuQDzB1X4YOGlPqW5xzF6sC7xJ9a/Q
	 If3pf5iZhCiif2fFSm/QISn0Lt78/5qB2r2IgOm0RR03yQVe+pbWrDrEh3qHzGYi8t
	 dOb8xro1hlEUREsGqzx+4rBN0m7roJC+OMpUjLQIT20zsbbjEFZhn9ee7YG8aqrSh4
	 eipef7bTxQ63oio702XMvDp1Dfnw1yAyGZ5E13u8wROWACbjqlV2DyeWHtPIIsm2ez
	 4L3CGBDLRoFrw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: fix flush failure in recovery scenarios
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240426015434.94840-1-quic_bqiang@quicinc.com>
References: <20240426015434.94840-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171448413940.313333.15685357327905271227.kvalo@kernel.org>
Date: Tue, 30 Apr 2024 13:35:41 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Commit eaf9f17b861b ("wifi: ath12k: relocate ath12k_dp_pdev_pre_alloc()
> call") moves ath12k_dp_pdev_pre_alloc() from ath12k_core_start() to
> ath12k_mac_allocate(), resulting in ath12k_mac_flush() failure in
> recovery scenarios:
> 
> [ 6849.684104] ath12k_pci 0000:04:00.0: pdev 0 successfully recovered
> [ 6854.907320] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
> [ 6860.027353] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
> [ 6865.143385] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
> 
> This is because, with ath12k_dp_pdev_pre_alloc() moved to ath12k_mac_allocate(),
> dp->num_tx_pending is not reset due to ATH12K_FLAG_REGISTERED set in
> recovery scenarios.
> 
> So a possible fix would be to reset that counter at some proper point,
> just like the old design. But considering that the counter tracks number
> of packets pending to be freed or returned to mac80211, forcefully reset
> it might make it hard to expose some real issues. For example if somehow
> ath12k fails to free/return some TX packets, we don't know that because
> no warnings any more.
> 
> That is to say we should not reset that counter during recovery (which is
> already done due to above commit), instead should decrease it each time
> a packet is freed/returned. Currently almost each related function has
> this logic implemented, except ath12k_dp_cc_cleanup(). So add the same
> there to fix this issue.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

24de1b7b231c wifi: ath12k: fix flush failure in recovery scenarios

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240426015434.94840-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


