Return-Path: <linux-wireless+bounces-16477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE0B9F4E25
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 15:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A5E164A30
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1A1F472A;
	Tue, 17 Dec 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p62oys+W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29491F4713
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446763; cv=none; b=Wjck5RdDYVjdzijqwPeUbr+9pjGLTX8HpgkwpxYAhcVVns4j8xyczU6bcLyOWgAWtX9pgSlumfNCIfzWS6tJ3pqU4LczZWqNcT1i3n746aXYT748S39FX5D+J5W46mE2OzgxC8e0nuOWqREAENWXQ6eh5JfsA9pEGnfabPGisZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446763; c=relaxed/simple;
	bh=pOoZRHsdKE7v2ECFsEVSpOwoH9Mz2gzKsGXQgVL/M/4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MEZJoDq3Zw0GvlNJpQKdfky6CYG33fHt35a9EhX8L4BP9Yh4Zi8hQ9CwPNoB/g6rzRUnt9CAbPFC09NTo5EF9icoqjvTOSCMzh5s5S8q93eu8Bf7fX4Q6tD5jgiliz4M7fT2cCCImrMlcV7rgW9Db6QglfZZZ3NoWNoTTn2uY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p62oys+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90348C4CED4;
	Tue, 17 Dec 2024 14:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734446763;
	bh=pOoZRHsdKE7v2ECFsEVSpOwoH9Mz2gzKsGXQgVL/M/4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=p62oys+WEA21wxHLd1fk3m6T8Xhp5dfIPRF1njFgqLUL8kGyZMzaMw8Km823iOx2r
	 fBRZNjwfL4zPvATmF1LQAr23O/HM9+DuRpJRZKmSfnNqfXSXNU58toASWN0y/suL+s
	 iTOCZrKyFFRS7IJSdfpDVodPm5QQ8iqG2cH+ULcgkF+Rmoanb9KMhO0uoTh8rEtWvl
	 MnuiEQBQXzSy0uXL3hs9aFVMQ8Ar97zHPQQp0cvp/4UPx6cKw68fexD3JFkCkQaI/N
	 Y/hOXF+mf0752uYNIxRVorgYpy+gk/6IIIWMEOcbc+XTqPX8AI5/MYeQ3h/pt/sEiT
	 1+a+3g2Fn2k7A==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] wifi: ath11k: move update channel list from
 update reg worker to reg notifier
References: <20241213093909.629-1-quic_kangyang@quicinc.com>
	<20241213093909.629-2-quic_kangyang@quicinc.com>
Date: Tue, 17 Dec 2024 16:46:00 +0200
In-Reply-To: <20241213093909.629-2-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Fri, 13 Dec 2024 17:39:08 +0800")
Message-ID: <87frmmmkpj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> From: Wen Gong <quic_wgong@quicinc.com>
>
> Currently when ath11k gets new channel list, it will mainly do two things
> in ath11k_regd_update():
> 1. update channel list to cfg80211 by reg_work.
> 2. update cfg80211's channel list to firmware by
> ath11k_reg_update_chan_list().
>
> Flow:
> ath11k_regd_update
> ->regulatory_set_wiphy_regd
>         -> schedule_work(&reg_work)
>                 ->reg_work->reg_process_self_managed_hint
>                         ->handle_band_custom(update to cfg80211)
> -> ath11k_reg_update_chan_list(update to firmware)
>
> But ath11k_reg_update_chan_list() is immediately called after reg_work
> is queued. They are running in different threads. At this time,
> ath11k_reg_update_chan_list() may use a wrong channel list because
> handle_band_custom() may not be finished.
> This may result in out-of-bounds write errors:
> BUG: KASAN: slab-out-of-bounds in ath11k_reg_update_chan_list
> Call Trace:
>     ath11k_reg_update_chan_list+0xbfe/0xfe0 [ath11k]
>     kfree+0x109/0x3a0
>     ath11k_regd_update+0x1cf/0x350 [ath11k]
>     ath11k_regd_update_work+0x14/0x20 [ath11k]
>     process_one_work+0xe35/0x14c0
>
> So should make sure ath11k_reg_update_chan_list() is called after
> handle_band_custom() is finished.
>
> reg_process_self_managed_hint() will call reg_call_notifier() after
> handle_band_custom(). This function will call ath11k_reg_notifier(), so
> move ath11k_reg_update_chan_list() to ath11k_reg_notifier(). Then
> ath11k can update correct channel list to firmware.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>
> Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

I think the commit message should be completely rewritten, the idea here
is not to list functions and their call orders.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

