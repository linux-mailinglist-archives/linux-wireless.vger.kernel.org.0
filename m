Return-Path: <linux-wireless+bounces-24975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE359AFD690
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892D01C26094
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D300B2E762B;
	Tue,  8 Jul 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nKiuRx3A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FF2E6D0D
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999857; cv=none; b=qxtk77zbPx1rQH9V8PpEOzgvh0y5rs5wpwGPuFuMZu4umDfH2a7e8SseZDBbN966uE3Gi1IvJvArL8mJq4UKfn9tsO9Jm4aYm9X820eS5atoHX8LHts+ZKE3BKrL4GNu0aiVkwFOSS+xcTkKx5V1Hvk2B6uov1xthL+btdFgmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999857; c=relaxed/simple;
	bh=P4m28JgcIHcb3RfuA5FHxRC9SfiH1YZ53dw4Tti4Mv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCZConPx+nRpn0LwQXv8PckcOqVs2QpaP3BvqU0P80DioEAIsiA5O04B6ei/kfVIHnEqiGd5ebCzte6zBU5UpB6cr5gNWjwRzAdX+bmVRNrI+Wor1LWvGcIaCIJl5vwRCnWrBq/YTbOFdD0Ner/6j8ueNLF77iBF2FspMQkGr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nKiuRx3A; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-879d2e419b9so3700861a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751999855; x=1752604655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Qf6OoUd6t9+5P1mzZep4RXSNUTyvyaP3uN0U0SlC0k=;
        b=nKiuRx3AtW+N/gQUMNSbdat/IGNyn+u0YA3d+WB3hsnyJvXPdKCYD2Ji8MdqvniPpQ
         DD7WXaNkqhq5wLerj1MjU+fPm/+PnorGdNYR6v5kxqmDObsbELSgQmuehEwTmOJaQ0bQ
         MMVOeyBNBPhLdSN99VXKDEUjjkWqRM1ck9avY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751999855; x=1752604655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Qf6OoUd6t9+5P1mzZep4RXSNUTyvyaP3uN0U0SlC0k=;
        b=JswZW/cpkKH6l+mo0e8FDKQujmra3MrSRgIMIRAfjh4YOL+954xsPVCz5TJcx2YX3y
         Wk9/0g174jH4Wb13z5Dgz8D8mAvWgHEOevZld8CHbNBhuL6j1bsLxYfCY+xOqENqxvGM
         On+biQFGuB/jJIJ4hyHOKDbll+q6Z0rd2BLApBrKnLSmcteUNQxB48lXtK8ApmQCJ+gb
         7XBU7SATOzrDEjS3brzkwY9GDZQVYO1IdRcvsvv9zEM25JTIulhDJ4e8x2myGCmqY181
         A+KnnzRidJhxcQMmS6nXzoqEywAMjLgfYwNmBObAxzjUSVgog3y1+IvrkXdGljrAplKI
         UF9w==
X-Forwarded-Encrypted: i=1; AJvYcCX162LEu2TY+tSD7APGfMMoD5d7AfKS7kTqo33zfhQFDyFP9ILOiCjpUbQQ8vEiRwW6mxDqX6pHC4gkNDEmlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6LWGfc6U2MePuPkzJyRxm/tLTNNqffxfw/ZSLers8XMXMOhg
	aDUFMR0AgTF1Yh72pcjxXbCPSxutlb8jHSvf8y1HoiG4cvVfQY5nl8g2Pe02CRhTFQ==
X-Gm-Gg: ASbGnctNhYYzwfAahFX2hUc2cNeC7V8TJ+ntGMmjcHu1xe0qxiPiZZEnNnYBZuVlhW0
	IumjgoVQieDnFkljHMjRA09/Ezbw4u0+yBvk+b5toPn+gfenWDAMb7cwSPlPocQqsezU990u+b5
	q7WUjnnEQp55KBINpeb9QEi1EjCK11KFynyDNDI3a9/xjLgHQLkg33T+9l/d36JMf03+xIF+aQi
	h5vW5VkmIoA25o8PlXo9J+DXNYmvjyUWehA3SjGSPMUsTpwcb5YyL1Nz6kkBc+/8gKUEZyefxUT
	WtkXwbJAYqey7DUzAH1Do1tNQ0wC0USE1iJ4L6ZK1EXRtd0HWZiIucwqgYC26LKoNkAFQBduLhd
	vZDFTL1+WywnumS3rqOyrIM/ytcpVO9D5Bfk=
X-Google-Smtp-Source: AGHT+IECRmB2ficBX+Y4W2qALMbEbYmKFGHf8YDow88MlFUlVsgHhubDrdqKig06lIkFEiP/MGe7zg==
X-Received: by 2002:a05:6a20:7fa6:b0:222:d191:5bbd with SMTP id adf61e73a8af0-22c7f544ef9mr708165637.39.1751999854754;
        Tue, 08 Jul 2025 11:37:34 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9b88:4872:11ac:8ccb])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74cfad75020sm9321070b3a.109.2025.07.08.11.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 11:37:33 -0700 (PDT)
Date: Tue, 8 Jul 2025 11:37:32 -0700
From: Brian Norris <briannorris@chromium.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Vitor Soares <vitor.soares@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH wireless v1] wifi: mwifiex: discard erroneous disassoc
 frames on STA interface
Message-ID: <aG1lbC4LJDKzMuco@google.com>
References: <20250701142643.658990-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701142643.658990-1-ivitro@gmail.com>

Hi Vitor,

On Tue, Jul 01, 2025 at 03:26:43PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> When operating in concurrent STA/AP mode with host MLME enabled,
> the firmware incorrectly sends disassociation frames to the STA
> interface when clients disconnect from the AP interface.
> This causes kernel warnings as the STA interface processes
> disconnect events that don't apply to it:
> 
> [ 1303.240540] WARNING: CPU: 0 PID: 513 at net/wireless/mlme.c:141 cfg80211_process_disassoc+0x78/0xec [cfg80211]
> [ 1303.250861] Modules linked in: 8021q garp stp mrp llc rfcomm bnep btnxpuart nls_iso8859_1 nls_cp437 onboard_us
> [ 1303.327651] CPU: 0 UID: 0 PID: 513 Comm: kworker/u9:2 Not tainted 6.16.0-rc1+ #3 PREEMPT
> [ 1303.335937] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
> [ 1303.343588] Workqueue: MWIFIEX_RX_WORK_QUEUE mwifiex_rx_work_queue [mwifiex]
> [ 1303.350856] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 1303.357904] pc : cfg80211_process_disassoc+0x78/0xec [cfg80211]
> [ 1303.364065] lr : cfg80211_process_disassoc+0x70/0xec [cfg80211]
> [ 1303.370221] sp : ffff800083053be0
> [ 1303.373590] x29: ffff800083053be0 x28: 0000000000000000 x27: 0000000000000000
> [ 1303.380855] x26: 0000000000000000 x25: 00000000ffffffff x24: ffff000002c5b8ae
> [ 1303.388120] x23: ffff000002c5b884 x22: 0000000000000001 x21: 0000000000000008
> [ 1303.395382] x20: ffff000002c5b8ae x19: ffff0000064dd408 x18: 0000000000000006
> [ 1303.402646] x17: 3a36333a61623a30 x16: 32206d6f72662063 x15: ffff800080bfe048
> [ 1303.409910] x14: ffff000003625300 x13: 0000000000000001 x12: 0000000000000000
> [ 1303.417173] x11: 0000000000000002 x10: ffff000003958600 x9 : ffff000003625300
> [ 1303.424434] x8 : ffff00003fd9ef40 x7 : ffff0000039fc280 x6 : 0000000000000002
> [ 1303.431695] x5 : ffff0000038976d4 x4 : 0000000000000000 x3 : 0000000000003186
> [ 1303.438956] x2 : 000000004836ba20 x1 : 0000000000006986 x0 : 00000000d00479de
> [ 1303.446221] Call trace:
> [ 1303.448722]  cfg80211_process_disassoc+0x78/0xec [cfg80211] (P)
> [ 1303.454894]  cfg80211_rx_mlme_mgmt+0x64/0xf8 [cfg80211]
> [ 1303.460362]  mwifiex_process_mgmt_packet+0x1ec/0x460 [mwifiex]
> [ 1303.466380]  mwifiex_process_sta_rx_packet+0x1bc/0x2a0 [mwifiex]
> [ 1303.472573]  mwifiex_handle_rx_packet+0xb4/0x13c [mwifiex]
> [ 1303.478243]  mwifiex_rx_work_queue+0x158/0x198 [mwifiex]
> [ 1303.483734]  process_one_work+0x14c/0x28c
> [ 1303.487845]  worker_thread+0x2cc/0x3d4
> [ 1303.491680]  kthread+0x12c/0x208
> [ 1303.495014]  ret_from_fork+0x10/0x20
> 
> Add validation in the STA receive path to verify that disassoc/deauth
> frames originate from the connected AP. Frames that fail this check
> are discarded early, preventing them from reaching the MLME layer and
> triggering WARN_ON().
> 
> This filtering logic is similar with that used in the
> ieee80211_rx_mgmt_disassoc() function in mac80211, which drops
> disassoc frames that don't match the current BSSID
> (!ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr)), ensuring
> only relevant frames are processed.
> 
> Tested on:
> - 8997 with FW 16.68.1.p197
> 
> Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/util.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
> index 4c5b1de0e936..6882e90e90b2 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -459,7 +459,9 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
>  				    "auth: receive authentication from %pM\n",
>  				    ieee_hdr->addr3);
>  		} else {

How about the other leg of this 'else' (ieee80211_is_auth())? Is it
possible for these spurious frames to accidentally look like our AUTH
frames?

> -			if (!priv->wdev.connected)
> +			if (!priv->wdev.connected ||
> +			    !ether_addr_equal(ieee_hdr->addr3,

"addr3" doesn't make it totally obvious to me what this actually means,
nor that it's correct. Would ieee80211_get_SA(ieee_hdr) be equivalent?
That seems a bit more descriptive. Or else maybe a short comment (e.g.,
"ignore spurious management frames from other BSSIDs").

It seems like it's correct, because this block already filters for
specific frame types (auth, deauth, disassoc), but in isolation, it's
not the most readable.

Brian

> +					      priv->curr_bss_params.bss_descriptor.mac_address))
>  				return 0;
>  
>  			if (ieee80211_is_deauth(ieee_hdr->frame_control)) {
> -- 
> 2.34.1
> 

