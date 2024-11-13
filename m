Return-Path: <linux-wireless+bounces-15247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6418A9C6D9F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 12:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100B11F27F45
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F74A2003B8;
	Wed, 13 Nov 2024 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy2UN4v3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4CC2003AE
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496562; cv=none; b=tfzqGTNWK0ehcLdpESvV2DWWZ9U4nQF33QBHU8PUEajRnTVoTw69ZRaI4bcZkhUzIph5sqR2X2zFFoZWtonD5sp+Tw5OL3fQy2qY/mdGJTTjHdjVx8PbCIvOMJaM6Mqiq5pnGb0oF4nQjc/3wgnLSTSTJMPVxutcfqpDY8pFmno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496562; c=relaxed/simple;
	bh=ib+bJZucry4VIQl+otQGDjYYRhXSZRpJohf6xBckVGQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ukKGbLmB7DZF4Qw8/7zBVm60OLR70m6TJcSAaT6iBZTMsdf/M55+ojpkEQj68yQZE/vzqbgRxGzdRM9eV0ITXn7MaqjsJ9M/ZIQZOZ74Hjxx6+BIxX8w6m5AOmDBkPp858eRowWBXYkU6ujYNkAMES82K4R8BHjBYxaMQLRR8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy2UN4v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A3DC4CED2;
	Wed, 13 Nov 2024 11:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731496561;
	bh=ib+bJZucry4VIQl+otQGDjYYRhXSZRpJohf6xBckVGQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gy2UN4v32YOlsxr60i4MDuH2FiaL3+mUmBbLroP9NsVfz+2aI3Xkloxhj472FIYFW
	 /KhcbpEPt6zqcvWEjoghwBF8FmwibWe+hcnhEfUR6R7LwzcUWSbO8jdwlX+cjnN1Ff
	 cjZ6GFc4o6GfsIqr/i2ivSAEBRkhEbELvnsjj9N63YeAci6nStiJ6NZRDuaRyut0GA
	 ZJPMj35L85mb2/Zu0FOjn8NIbY3fWCQsP8tyPGfpdybj/VTaCGOfoPzi/xWqQ4V1vc
	 M8FvBqmycqXjrlhcI48XoA4UvkVoPMRqGkfeuQA/IDBkuAwOOvTV7tYjhMUlu44CBW
	 p63r/IjsrCCIA==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 4/6] wifi: ath11k: adjust unlock sequence in
 ath11k_update_stats_event()
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
	<20241113015631.3105-5-quic_bqiang@quicinc.com>
Date: Wed, 13 Nov 2024 13:15:58 +0200
In-Reply-To: <20241113015631.3105-5-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Wed, 13 Nov 2024 09:56:29 +0800")
Message-ID: <87ttcb1j0x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Currently RCU lock and ar->data_lock are acquired in a sequence of
>
> 	rcu_read_lock()
> 	spin_lock_bh(&ar->data_lock)
>
> but released in a sequence of
>
> 	rcu_read_unlock()
> 	spin_unlock_bh(&ar->data_lock)
>
> Although there are no apparent issues with this, reorder them to
> achieve symmetry.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

