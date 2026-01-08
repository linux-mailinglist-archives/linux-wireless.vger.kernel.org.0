Return-Path: <linux-wireless+bounces-30559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C51BD033B2
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 15:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 542BE303EB59
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF76F304BA3;
	Thu,  8 Jan 2026 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZY41mdGX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F5472DAE
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874790; cv=none; b=AhtLVYaumSQGXExpDCTIy4u1T4VZxc9n6bWMVb9HJr2kp8PZWdlHKcNQ/XDCnybRk+yXg8xsXgawCa0aO8FFVtWeXWAgWSp4r2exTZ3/flHBhnYHfmGvCO0HcAPPrlZ9VUwH4/VHAIs17A4HF+AKmMUgGJz4BjwU8KsL5gdkCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874790; c=relaxed/simple;
	bh=CR7GvJdY4Kb4dV4IZVP5W2vKAlZoexS3s4SmtK5KBFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePXAP97nnIqOvzkKChkueP38JkDksozmTgwG9SUV0LzhHBs/h3Eh0ah7NcXItvBd4/Pr6TZ6yw8KkU+yQ4+9AQVZOsG86fEba1CwCn/T/ZYTLviqsosXyw8jyAuSzhz3Zvbm+SS5GMVcIeIxKfIastNGLGOhkkoJhS2GKzkMRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZY41mdGX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nV/8cRkJZ5IZu2TQ3ZwaiTQ1xEXCUC6DpjzzN6f4JCw=;
	t=1767874788; x=1769084388; b=ZY41mdGXks5zmxS1CpT6XvsPObSBPwwTL2OZm/263aRxMGo
	0tTlYee6MAtxrY428Fx7DrA9WDWjAAkIyeq3TST1dxJ/tD5F9Ef5IXPawlKFPZ/nEHFOD812vnJe8
	ePcOG+gLAbhDtVwzBqHxCLwQJtHTFOf+d9gS/YmgrXZHavV1sd2zT8EpYnmrxPUu9HP4KFVx9/ozO
	j9H9XNEdQD4yLw9xQbN6ZNh8ojxNw4BJJGNw144kA4CzylWVUWDiLlt6wA6Ioe8E5h8m8+wmo+m33
	83+PXOsOnfwT2x2f8CR5y7l1vUBvh5n6gcjy62/dQuc3u/HhD0WzNoYDVtGAqwFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdozP-00000006UYt-1eFC;
	Thu, 08 Jan 2026 13:19:43 +0100
Message-ID: <67b8cc599e923433eec6c8baff72583c47a53cfd.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/2] wifi: mac80211: set band information
 for NULL packets only for non-MLO stations
From: Johannes Berg <johannes@sipsolutions.net>
To: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 08 Jan 2026 13:19:42 +0100
In-Reply-To: <20251127140555.472327-2-suraj.kizhakkethil@oss.qualcomm.com>
References: <20251127140555.472327-1-suraj.kizhakkethil@oss.qualcomm.com>
	 <20251127140555.472327-2-suraj.kizhakkethil@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-11-27 at 19:35 +0530, Suraj P Kizhakkethil wrote:
> Currently, when sending a NULL packet to probe a station, the band
> information is derived from the chanctx_conf in the mac80211 vif's
> bss_conf. However, for MLO, chanctx_conf is not assigned to the vif's
> bss_conf; instead it is assigned on a per-link basis. As a result,
> for MLO, sending a NULL packet to probe will trigger a warning.
>=20
> WARNING: net/mac80211/cfg.c:4593 at ieee80211_probe_client+0x1a8/0x1e0 [m=
ac80211], CPU#2: hostapd/241
> Call trace:
>  ieee80211_probe_client+0x1a8/0x1e0 [mac80211] (P)
>  nl80211_probe_client+0xac/0x170 [cfg80211]
>  genl_family_rcv_msg_doit+0xc8/0x134
>  genl_rcv_msg+0x200/0x280
>  netlink_rcv_skb+0x38/0xfc
>  genl_rcv+0x34/0x48
>  netlink_unicast+0x228/0x334
>  netlink_sendmsg+0x158/0x364
>  ____sys_sendmsg+0x1f4/0x21c
>  ___sys_sendmsg+0x98/0xc0
>  __sys_sendmsg+0x74/0xd0
>  __arm64_sys_sendmsg+0x20/0x28
>  invoke_syscall.constprop.0+0x4c/0xd0
>  do_el0_svc+0x3c/0xd0
>  el0_svc+0x28/0xb8
>  el0t_64_sync_handler+0x98/0xdc
>  el0t_64_sync+0x154/0x158
> ---[ end trace 0000000000000000 ]---
>=20
> For NULL packets sent to probe stations, set the band information only
> for non-MLD case, since MLD transmissions does not rely on band. For
> MLD connections, set the link ID as unspecified to allow the driver
> to select the appropriate link. The case specific to non-MLO stations
> connected to an MLD AP will be addressed in a follow up patch.

Technically "AP MLD" ;)

But I was more wondering about the use of "MLD connections", which seems
odd to me (vs. "MLO connections")? Connections between MLDs? MLD is an
entity, MLO is the mode of operation?

> +	if (ieee80211_vif_is_mld(&sdata->vif))
> +		info->control.flags |=3D IEEE80211_TX_CTRL_MLO_LINK_UNSPEC;

I don't see why it should be set conditionally, it should be ignored
anyway by non-MLO drivers? Or maybe if you'd want it zero for t hose
then do that explicitly?

I'm really commenting here because it gets messy in the next patch, see
also there.

johannes

