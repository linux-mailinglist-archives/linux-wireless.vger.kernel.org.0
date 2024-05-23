Return-Path: <linux-wireless+bounces-8030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A2C8CD8AE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46CE280DCB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D08C175A5;
	Thu, 23 May 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7yp5lZ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06512E48
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482919; cv=none; b=KzJc5CuP9fTiiQ2fdLtBTkkWXrr8JR16azfcn238cq+l+e0mcCWnvJW9/5WMR5iDRtEjwWo1R/VjK4H6xYlTkaNGHwIQHloyYQEJiYmLHnep+ilHtF8ZIAv+95LOlQi73vw3MmhES5GawGw7cexlBl5ISAn2IfV9nRjjjkHA9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482919; c=relaxed/simple;
	bh=9gx+ourYVhlhZCxSr2aEDzAYZlVvSbuxXz0Wj09tqhU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=V9inALMIT1STpDYY2wQinSnZuGlDoW58M+ixWvICEJ93P4POelwNC/WFpDxXpP1cMGScOxiLlaP86G22Ed3tRD/Lidt69Ug41CaWQojlv/8gDhkWA8cBFGJHKo0nExuby4C7RpySAaIJWkkOGshcLMtJfPmQmhOU5o1ubeZFGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7yp5lZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D37C2BD10;
	Thu, 23 May 2024 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716482918;
	bh=9gx+ourYVhlhZCxSr2aEDzAYZlVvSbuxXz0Wj09tqhU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=O7yp5lZ55fsW8KUCIS0u2s1pKeWrmDcW/sTlyyMAvcFVeH24beuybbofggqUnSTkd
	 nl08aLzbcLCElkZi4MzYjjUGA2ySOy+jv95k3Rtl0NkU42wb03y56jDjRrPhNQbpYj
	 TIPjWay4Zj/IhTA5G9COPW8O1r0u61d8BHKiNG9O5l0VMS7RINHzWlb4Q2VIPYrYHI
	 GDk1Wftwhk5pinTJmpLLsc+M8ZlZiTSNjnkqfaPV4SqbT2Mlnh/eNVispJm3v7w57a
	 sYAMVTzSC6VH56YCwCeKcWq338FyD/d90nWI5jmqsMeK7sJ9FBG6RNb7ftjR1wBySZ
	 ctWlQisd7pkvw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] wifi: ath12k: add support for WoW
References: <20240523033143.21677-1-quic_bqiang@quicinc.com>
Date: Thu, 23 May 2024 19:48:35 +0300
In-Reply-To: <20240523033143.21677-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Thu, 23 May 2024 11:31:36 +0800")
Message-ID: <875xv4bhjw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Add support for WoW (Wakeup on Wireless) funtionalities, this including
> magic-pattern, net-detect, disconnect and patterns, HW data filter, ARP
> and NS offload, GTK rekey offload.
>
> Also enable keepalive before suspend to avoid unexpected kick out by AP.
>
> v2:
>  - [2/7] wifi: ath12k: add basic WoW functionalities
> 	1. In ath12k_wow_convert_8023_to_80211(), change to use 'size_t'
> 	   instead of 'int' to make GCC happy
>  - [5/7] wifi: ath12k: support ARP and NS offload
> 	1. In ath12k_mac_arvif_get_arp_ns_offload(), change to use
> 	   GFP_ATOMIC to fix kernel crash due to sleep in invalid context
>  - rebased on ToT
> 	
> Baochen Qiang (7):
>   wifi: ath12k: implement WoW enable and wakeup commands
>   wifi: ath12k: add basic WoW functionalities
>   wifi: ath12k: add WoW net-detect functionality
>   wifi: ath12k: implement hardware data filter
>   wifi: ath12k: support ARP and NS offload
>   wifi: ath12k: support GTK rekey offload
>   wifi: ath12k: handle keepalive during WoWLAN suspend and resume

I see new kmemleak warnings with ath-pending-202405231313, I'm assuming
it's from this patchset but didn't check. I see a lot of warnings like
below but I can provide more information tomorrow if needed.

unreferenced object 0xffff88814fa4d800 (size 1024):
  comm "wpa_supplicant", pid 11989, jiffies 4296591308
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00  ................
    fe 80 00 00 00 00 00 00 02 03 7f ff fe 37 16 02  .............7..
  backtrace (crc 3f321b49):
    [<ffffffff8dbdd8d5>] kmemleak_alloc+0x45/0x80
    [<ffffffff8b573984>] kmalloc_trace+0x284/0x2d0
    [<ffffffffc0e634e2>] ath12k_mac_arvif_get_arp_ns_offload+0x72/0xd0 [ath12k]
    [<ffffffffc0e6b437>] ath12k_mac_op_ipv6_changed+0xc7/0x1470 [ath12k]
    [<ffffffffc077e797>] ieee80211_ifa6_changed+0x1c7/0x3a0 [mac80211]
    [<ffffffff8afeb177>] notifier_call_chain+0x97/0x310
    [<ffffffff8afeb72d>] atomic_notifier_call_chain+0x5d/0x140
    [<ffffffff8d918796>] inet6addr_notifier_call_chain+0x16/0x20
    [<ffffffff8d7f193a>] addrconf_ifdown.isra.0+0xa8a/0x1700
    [<ffffffff8d800895>] addrconf_notify+0x105/0xdd0
    [<ffffffff8afeb177>] notifier_call_chain+0x97/0x310
    [<ffffffff8afeb571>] raw_notifier_call_chain+0x11/0x20
    [<ffffffff8d277e1b>] call_netdevice_notifiers_info+0x8b/0xf0
    [<ffffffff8d28ec33>] __dev_notify_flags+0x163/0x240
    [<ffffffff8d290771>] dev_change_flags+0xf1/0x150
    [<ffffffff8d647406>] devinet_ioctl+0x1116/0x19b0

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

