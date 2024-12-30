Return-Path: <linux-wireless+bounces-16899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A139FE2AB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 06:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E34F3A19B6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B592165F01;
	Mon, 30 Dec 2024 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udGWBdKD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07415746E;
	Mon, 30 Dec 2024 05:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735537091; cv=none; b=EAlRLY0NYM5dV+aUX/uifhWpUk1UswOXt7GxUAsHsJdV6ylCVs/Vj+t1N/t+x7IMPPDVPoB83qp8WMxBWxf5RF5wte5b24y6WWdrMUVUkkmeFlJHhUBwRpBCMx0LqNO9GeqhueNaKkvn9N7VMA1p8ky8MJ58/OF6DfNkF9vbJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735537091; c=relaxed/simple;
	bh=Lst7XNAKcOZd0nU9L0bmu0BfVZvL3jfyMPy40z56/Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoYgaqsAQpahTnn07NZGS0eXcBTa8yqXKw02E1U8VoAVFDEyRsmkGGYG9ZuTNLvrt6jMEyvpmWAcHgRoAl4wAzDJnwIRiTc0dnslgO2eh88D6hnPb07MPXvQsirl+0xabNiYjsDSaAyyPYHnnKU/eEyRm72vmdn0G5MVpvcMVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udGWBdKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0CFC4CED0;
	Mon, 30 Dec 2024 05:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735537091;
	bh=Lst7XNAKcOZd0nU9L0bmu0BfVZvL3jfyMPy40z56/Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udGWBdKDMeyCMOUIIWxljdTQtPdTgBMPyXUNeEn0H/bIu2AzEA7Elr3n9QRuwgJ6b
	 PX4Zw5Jf6w0g8wn5zeoYz88vpykNGwYsKLVOQKDOikYxpIqZM1M7E/QwPCnaPIxs0f
	 Y+Dbs2BEKLR1N8a4HpiSXFeZXGNE/R6tuEpdp9DAuTx3f3E7XbGusU9a7NeAt8wnL6
	 9Uv+bHkhTkj7kefehjl3fOu5HhNEhJCQSBhTpDmF088m4jDZT79wKsy+Z9vxaOR86E
	 LPmzPXkVFhfx0zUsHGn73KbgYLJhgwgwJEgVyjC2WSBJrQbKRgWl7ib0RWICn0pp2J
	 hOZj39HCxfrJg==
Date: Sun, 29 Dec 2024 22:38:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: John Rowley <lkml@johnrowley.me>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
	stable@vger.kernel.org, kees@kernel.org, gustavoars@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: UBSAN array-index-out-of-bounds: cfg80211_scan_6ghz
Message-ID: <20241230053806.GA129354@ax162>
References: <1815535c709ba9d9.156c6a5c9cdf6e59.b249b6b6a5ee4634@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1815535c709ba9d9.156c6a5c9cdf6e59.b249b6b6a5ee4634@localhost.localdomain>

Hi John,

On Sat, Dec 28, 2024 at 11:21:27AM +0000, John Rowley wrote:
> Hi, I'm experiencing UBSAN array-index-out-of-bounds errors while using
> my Framework 13" AMD laptop with its Mediatek MT7922 wifi adapter
> (mt7921e).
> 
> It seems to happen only once on boot, and occurs with both kernel
> versions 6.12.7 and 6.13-rc4, both compiled from vanilla upstream kernel 
> sources on Fedora 41 using the kernel.org LLVM toolchain (19.1.6).
> 
> I can try some other kernel series if necessary, and also a bisect if I
> find a working version, but that may take me a while.

This looks related to UBSAN_BOUNDS and the fact that version of clang
supports the __counted_by attribute. I do not have much time at the
moment to look at this but I have added Kees, Gustavo, and
linux-hardening for further analysis.

Cheers,
Nathan

> I wasn't sure if I should mark this as a regression, as I'm not sure
> which/if there is a working kernel version at this point.
> 
> Thanks.
> 
> ----
> 
> [   17.754417] UBSAN: array-index-out-of-bounds in /data/linux/net/wireless/scan.c:766:2
> [   17.754423] index 0 is out of range for type 'struct ieee80211_channel *[] __counted_by(n_channels)' (aka 'struct ieee80211_channel *[]')
> [   17.754427] CPU: 13 UID: 0 PID: 620 Comm: kworker/u64:10 Tainted: G                T  6.13.0-rc4 #9
> [   17.754433] Tainted: [T]=RANDSTRUCT
> [   17.754435] Hardware name: Framework Laptop 13 (AMD Ryzen 7040Series)/FRANMDCP07, BIOS 03.05 03/29/2024
> [   17.754438] Workqueue: events_unbound cfg80211_wiphy_work
> [   17.754446] Call Trace:
> [   17.754449]  <TASK>
> [   17.754452]  dump_stack_lvl+0x82/0xc0
> [   17.754459]  __ubsan_handle_out_of_bounds+0xe7/0x110
> [   17.754464]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   17.754470]  ? __kmalloc_noprof+0x1a7/0x280
> [   17.754477]  cfg80211_scan_6ghz+0x3bb/0xfd0
> [   17.754482]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   17.754486]  ? try_to_wake_up+0x368/0x4c0
> [   17.754491]  ? try_to_wake_up+0x1a9/0x4c0
> [   17.754496]  ___cfg80211_scan_done+0xa9/0x1e0
> [   17.754500]  cfg80211_wiphy_work+0xb7/0xe0
> [   17.754504]  process_scheduled_works+0x205/0x3a0
> [   17.754509]  worker_thread+0x24a/0x300
> [   17.754514]  ? __cfi_worker_thread+0x10/0x10
> [   17.754519]  kthread+0x158/0x180
> [   17.754524]  ? __cfi_kthread+0x10/0x10
> [   17.754528]  ret_from_fork+0x40/0x50
> [   17.754534]  ? __cfi_kthread+0x10/0x10
> [   17.754538]  ret_from_fork_asm+0x11/0x30
> [   17.754544]  </TASK>
> 

