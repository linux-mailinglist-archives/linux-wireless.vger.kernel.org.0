Return-Path: <linux-wireless+bounces-8960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD6D9063BF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 08:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82048B20DC4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 06:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C52C135A53;
	Thu, 13 Jun 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK3amY4N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2737C
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258864; cv=none; b=g7ZWdhHWYnG2r0/Q/Q7L2oMlxTOa2fQOnlRZTfd7VBQ4mqBCqYJOh4q7impNeSmyevjYCi5G/pOTSHC0KmzokJPz6PFW0kkb7qjEXcW+Q386YBBNCQQUg2b+RI/1SOWIU9ZIylB5ey6Y6hBU4R1+Ld76VJ86VCaImu4itM1XgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258864; c=relaxed/simple;
	bh=+51VKcepJeVtW2R1jSxsa3QyWsN1hvVdN0GLvhuNV1M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MifRfw/0BFMtvKpuAemhQNhboQ0N+ANUbDAU3MxJts2mqxb53XNtc9WSBdrK8RbbctVsRBqzosuOxKRQdTh7F7MnGJUPe5wXEPwItelqEinx63CsTchZfOE459aOmLppbo9M4y553YM3nG0k0xuitp0vmxi3l4AtRuWp18SoYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK3amY4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEACC2BBFC;
	Thu, 13 Jun 2024 06:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718258863;
	bh=+51VKcepJeVtW2R1jSxsa3QyWsN1hvVdN0GLvhuNV1M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JK3amY4NzvWTv8ktX0c68xCY3k7DKm+k6QaGZaaZ8PVNJRg3v9D/M6rUGi6zRJKFU
	 gFCdIhbOJECCEGNTf2f+mJ/d8+x+iHmI9aW9yEJx5cHYCxBNW6b4Nh8KyGEGYrs461
	 mIsXc5Y5THrm2CoufsA5KdWx1Pf+gDWPb+tyY3jr99GJ0ywsXiklarbCE0GvhBsw1I
	 c1EuGVUDGw+G8IPyRSOruN/ax+OBGFutQqXYqVTLe/5Cw7+lIiryA+N2tYomOyVRNm
	 6cX6HecapH4YKw3zHhaCwZDWWokVg42mHjE6XlBrIBiydsxGrsjDZVUkh2dnT4HENk
	 ketgP3hJS0CdQ==
From: Kalle Valo <kvalo@kernel.org>
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: Fix WARN_ON during firmware crash in
 split-phy
References: <20240529034405.2863150-1-quic_aarasahu@quicinc.com>
	<87v82goha4.fsf@kernel.org>
	<5b3c9394-bac8-4f94-9af8-686a76a3726b@quicinc.com>
Date: Thu, 13 Jun 2024 09:07:40 +0300
In-Reply-To: <5b3c9394-bac8-4f94-9af8-686a76a3726b@quicinc.com> (Aaradhana
	Sahu's message of "Thu, 13 Jun 2024 10:31:01 +0530")
Message-ID: <87a5jpnzo3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaradhana Sahu <quic_aarasahu@quicinc.com> writes:

> On 6/10/2024 10:40 PM, Kalle Valo wrote:
>> Aaradhana Sahu <quic_aarasahu@quicinc.com> writes:
>> 
>>> Whenever firmware is crashed in split-phy below WARN_ON triggered:
>>>
>>> ? __warn+0x7b/0x1a0
>>> ? drv_stop+0x1eb/0x210 [mac80211]
>>> ? report_bug+0x10b/0x200
>>> ? handle_bug+0x3f/0x70
>>> ? exc_invalid_op+0x13/0x60
>>> ? asm_exc_invalid_op+0x16/0x20
>>> ? drv_stop+0x1eb/0x210 [mac80211]
>>> ieee80211_do_stop+0x5ba/0x850 [mac80211]
>>> ieee80211_stop+0x51/0x180 [mac80211]
>>> __dev_close_many+0xb3/0x130
>>> dev_close_many+0xa3/0x180
>>> ? lock_release+0xde/0x420
>>> dev_close.part.147+0x5f/0xa0
>>> cfg80211_shutdown_all_interfaces+0x44/0xe0 [cfg80211]
>>> ieee80211_restart_work+0xf9/0x130 [mac80211]
>>> process_scheduled_works+0x377/0x6f0
>> 
>> This is just the stack trace, not the full warning. If you send me the
>> full warning I can add it to the commit message. Also it would be always
>> good to identify what warning it is exactly as line numbers can change
>> etc.
>> 
>
> Sure, the full warning is given below:
>
> [ 364.713223] WARNING: CPU: 3 PID: 82 at net/mac80211/driver-ops.c:41
> drv_stop+0xac/0xbc
> [  364.716875] Modules linked in: ath12k qmi_helpers
> [ 364.724598] CPU: 3 PID: 82 Comm: kworker/3:2 Tainted: G D W
> 6.9.0-next-20240520-00113-gd981a3784e15 #39
> [  364.729378] Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C9 (DT)
> [  364.739965] Workqueue: events_freezable ieee80211_restart_work
> [  364.747082] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  364.752897] pc : drv_stop+0xac/0xbc
> [  364.759752] lr : ieee80211_stop_device+0x54/0x64
> [  364.763226] sp : ffff8000848dbb20
> [  364.768085] x29: ffff8000848dbb20 x28: 0000000000000790 x27: ffff000014d78900
> [  364.771301] x26: ffff000014d791f8 x25: ffff000007f0d9b0 x24: 0000000000000018
> [  364.778419] x23: 0000000000000001 x22: 0000000000000000 x21: ffff000014d78e10
> [  364.785537] x20: ffff800081dc0000 x19: ffff000014d78900 x18: ffffffffffffffff
> [  364.792655] x17: ffff7fffbca84000 x16: ffff800083fe0000 x15: ffff800081dc0b48
> [  364.799774] x14: 0000000000000076 x13: 0000000000000076 x12: 0000000000000001
> [  364.806892] x11: 0000000000000000 x10: 0000000000000a60 x9 : ffff8000848db980
> [  364.814009] x8 : ffff000000dddfc0 x7 : 0000000000000400 x6 : ffff800083b012d8
> [  364.821128] x5 : ffff800083b012d8 x4 : 0000000000000000 x3 : ffff000014d78398
> [  364.828246] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000014d78900
> [  364.835364] Call trace:
> [  364.842478]  drv_stop+0xac/0xbc
> [  364.844734]  ieee80211_stop_device+0x54/0x64
> [  364.847860]  ieee80211_do_stop+0x5a0/0x790
> [  364.852375]  ieee80211_stop+0x4c/0x178
> [  364.856280]  __dev_close_many+0xb0/0x150
> [  364.860014]  dev_close_many+0x88/0x130
> [  364.864092]  dev_close.part.171+0x44/0x74
> [  364.867653]  dev_close+0x1c/0x28
> [  364.871732]  cfg80211_shutdown_all_interfaces+0x44/0xfc
> [  364.875031]  ieee80211_restart_work+0xfc/0x14c
> [  364.879979]  process_scheduled_works+0x18c/0x2dc
> [  364.884494]  worker_thread+0x13c/0x314
> [  364.889266]  kthread+0x118/0x124
> [  364.892825]  ret_from_fork+0x10/0x20
> [  364.896211] ---[ end trace 0000000000000000 ]---

Thanks, so I assume it's this check from drv_stop():

	if (WARN_ON(!local->started))
		return;

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

