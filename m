Return-Path: <linux-wireless+bounces-16310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303CE9EE82A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 15:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB4618888EC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD778211471;
	Thu, 12 Dec 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpScoE+O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998572AF0E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012131; cv=none; b=HSIcMQUGpWIhulXpviawX6a717zaZetk968ez19Zf07YKfUsfLEkcqfFqnqWLTJi/mD6fs4TiWkgVylc820jSifrRMVhdDfTSnyUIyMCDS3RyLyqNUzKQfxyasqFydkwYfjs3huQWtcy98+HTlyewH9mD/H2NQskIZjxzWBq2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012131; c=relaxed/simple;
	bh=ovTK1jGKGDsAnJbJ0JS50A+5b+gNs6T5ryRElMlatoE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ZDBWFhdKLm8aiiAtby0CK8ayXUY20NWldIyu6X0BzASRP8PPkGWzScWbj4jM6uVx8XZx7uPQeygws92xxzVltyW3+XwTJbnqa53F8eZDUV9zwQKAS6JsN3fih4u7+StN0SEKzensrIZophlxTJbQ8XNOfJMTdY769kS0ZGqXDKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpScoE+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F93EC4CECE;
	Thu, 12 Dec 2024 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734012131;
	bh=ovTK1jGKGDsAnJbJ0JS50A+5b+gNs6T5ryRElMlatoE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=LpScoE+OxRRdwfC/TLTP0dGbvrMQsf8by0ZKQ8L+rt4FfBntF73J7WsL3mphiQMau
	 1ZLgPFcz1iQ/zuc0dg9n5Cxmcql9n7Z8+pKM6+RVGSVDZWr1r5YpgHyY3J8oEkafZ9
	 7U85gXRJKrw2Q5TEzfQC76x5fAkQxx2itjd0+B1NB8iENJ8+R3TLWLdn5dJnvzbzYg
	 OY6yw+lyUxKq2q0tw2Q4VbQO4IfCkpOMU4AcciJAAkJonL/5P6nbawq8iOaqiIKcU9
	 V00iEXIVZ9T21I07ybxvzuK+Tm4GkwGvUyUT9dcKrpvgIeMfMvU7OoS504Fvmu+rAp
	 3iPQ7dZiJclHQ==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] wifi: ath11k: move update channel list from
 update reg worker to reg notifier
References: <20241129070714.226-1-quic_kangyang@quicinc.com>
	<20241129070714.226-2-quic_kangyang@quicinc.com>
Date: Thu, 12 Dec 2024 16:02:08 +0200
In-Reply-To: <20241129070714.226-2-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Fri, 29 Nov 2024 15:07:13 +0800")
Message-ID: <8734itov8f.fsf@kernel.org>
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
> Currently ath11k call regulatory_set_wiphy_regd() in ath11k_regd_update()
> to notify the reg domain change to cfg80211 and update channel list by
> reg_work, then ath11k immediately update channel list to firmware by
> ath11k_reg_update_chan_list().
>
> callstack:
> ath11k_regd_update
> ->regulatory_set_wiphy_regd
>            -> schedule_work(&reg_work)
> -> ath11k_reg_update_chan_list
>
> They are running in two threads, it leads the channel list data out of
> sync caused by muti-threads without synchronization. At this time,
> ath11k may update wrong channel list to firmware because the reg_work
> still running or even hasn't started yet. In this case, if the
> ath11k_reg_update_chan_list accesses an improperly updated channel list
> before reg_work is completed, it may result in out of bounds write
> errors, as shown in the KASAN report:
>
> BUG: KASAN: slab-out-of-bounds in ath11k_reg_update_chan_list
> Call Trace:
>     ath11k_reg_update_chan_list+0xbfe/0xfe0 [ath11k]
>     kfree+0x109/0x3a0
>     ath11k_regd_update+0x1cf/0x350 [ath11k]
>     ath11k_regd_update_work+0x14/0x20 [ath11k]
>     process_one_work+0xe35/0x14c0
>
> The correct flow is after reg_work update the channel list according to
> new reg domain, ath11k call ath11k_reg_update_chan_list() and update the
> new channel list to firmware.
>
> reg_call_notifier()(finally it will call ath11k_reg_notifier()) will be
> called to by reg_work to notify ath11k when it finishes the channel
> list update. So at this time, call ath11k_reg_update_chan_list() in
> reg_call_notifier() with initiator type NL80211_REGDOM_SET_BY_DRIVER.
> Then ath11k_reg_update_chan_list() will use the correct channel list.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>
> Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

The commit message would need significant work to make it more
understandable, I feel that it's just explaining call flows. But clearly
describing the problem and the design how it's solved would be a lot
more helpful.

Jeff had good guidance how to write a good commit message but I don't
have a link at hand right now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

