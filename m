Return-Path: <linux-wireless+bounces-28691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E6C42734
	for <lists+linux-wireless@lfdr.de>; Sat, 08 Nov 2025 05:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0763B3AD305
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Nov 2025 04:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1029125291B;
	Sat,  8 Nov 2025 04:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyll2Mgi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5498800;
	Sat,  8 Nov 2025 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762577309; cv=none; b=sMOfjVTwaHH5ylgukszH0XrSkTwZvk2Cyju4GtYrSboabfT8bi0qbdFCNtHMnN+Xg+wlayGBaVP5xdMco7emuj8VGCLDVb9oBLbC9g1Idaj59HS3nAI+wbJxjnaKuhgNgZGla4mVg2nq4KffwKUAVU0nmWcWAEknMtvvE6cEOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762577309; c=relaxed/simple;
	bh=B8kniEjRPA7YAHYOfjzp5guHiB6McGPOk77JxmK6OrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9zkKzD3zHrQlkE7Rn1m0uh4xKlC2uPNVJpWZ+qb79t4oD9P1JC+szwdtEv4NjZqiKjwl1714Y86r10BwV9NHNje8wJs4c/XiHE/V6G/QjX6/WDcya5/v0MOdNzPRPQD8xWXJlZWAT4FzeYE+eXTwnDhxTe3ZNKj6QmxFgfyVoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyll2Mgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B449C19422;
	Sat,  8 Nov 2025 04:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762577308;
	bh=B8kniEjRPA7YAHYOfjzp5guHiB6McGPOk77JxmK6OrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyll2MgihpQQ/RaZ7028oLjYWK3j4ThamXQiLwmqE1qnPbAi4U8vz6nWL04t9pgTx
	 9oDDb34pM6D6ZPyGiuUy8JXBp7ctWjcs4dFAZolTdacFv+q3zlMyKBGjTq1rzb1ZbL
	 ImBNWquUqqA697kHZ3DUdn1tpxKEL+sIP/OfxOWVwcBZYXP0mYJXuJxbApVu03SXiu
	 UeR3ntbRBvbH5uXzuYiq+BNivhX7zSPyBJ88gTZOIhmGt48wQM1wzyFPNT8fj7/Y4z
	 gTy9MPi/wAB4m29qUk1A/AOnpOSBtddswEJOVq1FKZl8yw350cIHYSSMBLt+EBpYG+
	 wqhQYDJqUt/pQ==
Date: Fri, 7 Nov 2025 21:48:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tim Hostetler <thostet@google.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next v2] ptp: Return -EINVAL on ptp_clock_register if
 required ops are NULL
Message-ID: <20251108044822.GA3262936@ax162>
References: <20251104225915.2040080-1-thostet@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104225915.2040080-1-thostet@google.com>

On Tue, Nov 04, 2025 at 02:59:15PM -0800, Tim Hostetler wrote:
> ptp_clock should never be registered unless it stubs one of gettimex64()
> or gettime64() and settime64(). WARN_ON_ONCE and error out if either set
> of function pointers is null.
> 
> For consistency, n_alarm validation is also folded into the
> WARN_ON_ONCE.
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> ---
> Changes in v2:
>   * Switch to net-next tree (Jakub Kicinski, Vadim Fedorenko)
>   * Fold in n_alarm check into WARN_ON_ONCE (Jakub Kicinski)
> ---
>  drivers/ptp/ptp_clock.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index ef020599b771..b0e167c0b3eb 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -322,7 +322,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	char debugfsname[16];
>  	size_t size;
>  
> -	if (info->n_alarm > PTP_MAX_ALARMS)
> +	if (WARN_ON_ONCE(info->n_alarm > PTP_MAX_ALARMS ||
> +			 (!info->gettimex64 && !info->gettime64) ||
> +			 !info->settime64))
>  		return ERR_PTR(-EINVAL);
>  
>  	/* Initialize a clock structure. */
> -- 
> 2.51.2.1026.g39e6a42477-goog
> 

I am seeing this warning trigger on my machines that use the iwlwifi
driver, presumably because .settime64 is not assigned a value in
iwl_mvm_ptp_init().

  [  +0.000003] WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x103/0x780 [ptp], CPU#0: NetworkManager/483
  [  +0.000010] Modules linked in: ...
  [  +0.000036] CPU: 0 UID: 0 PID: 483 Comm: NetworkManager Not tainted 6.18.0-rc4-debug-next-20251107-07207-g9c0826a5d9aa #1 PREEMPT(full)  84ece3456f9361105a10b63b41a3c832c71ec446
  [  +0.000003] Hardware name: AZW MINI S/MINI S, BIOS ADLNV106 05/12/2024
  [  +0.000002] RIP: 0010:ptp_clock_register+0x103/0x780 [ptp]
  [  +0.000003] Code: c7 60 22 f2 c0 41 89 c5 e8 8a 5d 2f d0 45 85 ed 74 4e 49 63 ed 48 89 df e8 da 94 6a cf eb 14 48 83 7f 78 00 0f 85 66 ff ff ff <0f> 0b 48 c7 c5 ea ff ff ff 48 8b 84 24 80 00 00 00 65 48 2b 05 3c
  [  +0.000001] RSP: 0018:ffffcc5b04adb290 EFLAGS: 00010246
  [  +0.000002] RAX: 0000000000000000 RBX: ffff8934d76b2068 RCX: ffff8934d76b4900
  [  +0.000001] RDX: 0000000000200000 RSI: ffff8934c1ebb0c8 RDI: ffff8934d76b4810
  [  +0.000001] RBP: ffff8934d76b4810 R08: ffffffff8ff70160 R09: 0000000000000001
  [  +0.000001] R10: ffff8934d62fd1c0 R11: 0000000000000000 R12: 000000000ea00000
  [  +0.000001] R13: 0000000000000002 R14: ffff8934c1ebb0c8 R15: ffff8934d7708a10
  [  +0.000001] FS:  00007fac016312c0(0000) GS:ffff89389cd6b000(0000) knlGS:0000000000000000
  [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [  +0.000001] CR2: 00007f7f93e50f30 CR3: 0000000119666002 CR4: 0000000000f72ef0
  [  +0.000001] PKRU: 55555554
  [  +0.000001] Call Trace:
  [  +0.000002]  <TASK>
  [  +0.000002]  ? iwl_trans_send_cmd+0x3e/0xb0 [iwlwifi 72c0d1371c0a5e8807f47a9d18b5f8082f51cdd9]
  [  +0.000022]  ? iwl_mvm_send_cmd+0x16/0x40 [iwlmvm b29beaee96a9c574b7e4367316ad1fb89a4d5bfc]
  [  +0.000019]  ? iwl_mvm_config_scan+0x145/0x1b0 [iwlmvm b29beaee96a9c574b7e4367316ad1fb89a4d5bfc]
  [  +0.000017]  iwl_mvm_ptp_init+0xe1/0x150 [iwlmvm b29beaee96a9c574b7e4367316ad1fb89a4d5bfc]
  [  +0.000014]  iwl_mvm_up+0x8e9/0xa10 [iwlmvm b29beaee96a9c574b7e4367316ad1fb89a4d5bfc]
  [  +0.000012]  ? kmalloc_reserve+0x64/0x100
  [  +0.000003]  ? kmalloc_reserve+0x64/0x100
  [  +0.000001]  __iwl_mvm_mac_start+0x78/0x2b0 [iwlmvm b29beaee96a9c574b7e4367316ad1fb89a4d5bfc]
  [  +0.000012]  iwl_mvm_mac_start+0x47/0xf0 [iwlmvm b29beaee96a9c574b7e4367316ad1fb89a4d5bfc]
  [  +0.000010]  drv_start+0x48/0x110 [mac80211 5dddabcc52998b16707609bbcccb5a7bd69e6ccc]

Seems like iwl_mld_ptp_init() would also be affected by this? I did not
see how many other drivers are potentially impacted by this.

Cheers,
Nathan

