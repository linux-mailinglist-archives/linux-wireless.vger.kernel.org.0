Return-Path: <linux-wireless+bounces-33835-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBYuOteqw2nAtAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33835-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:28:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DA532239D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 10:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87F44305EA59
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47147351C28;
	Wed, 25 Mar 2026 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="YOrMot5R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964B2D877D;
	Wed, 25 Mar 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430624; cv=none; b=tzyTemUdSl7W6BQbVOXKNv2CnQ+o+ZtlO+rX78aSDgt1buinhxRj8lFZcU3mg6gY9cBu7TSnu27bh0Jr6eA/jyv5ln3/is9da/b72XWVjtKf6yVTz8JirN+JUx5Zuw8Xr1F/T7FcErT2qZQKvTWkfRjOBMax/gm8lzVQF+2CjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430624; c=relaxed/simple;
	bh=qr6JRabDJJK1h/crA9vo1OfH4td6qAvjFmMpKGxuqg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5bEjJnuDwSUg7iK7lkop8xgim/Sa2V/62rsAn5Eb9ZFoMAH5Tt2DZV8O89NzBwRYzt5IuOnHxWWWUZaIHpkbGNwXsqbcjxcSDhaXFDupx23UJPlz3BJjBiQwllqvHA8GGDH4vW2+O0doJDrK1d9x3waw6DL597BQzM7hu+NZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=YOrMot5R; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eEO1uFB+ct6oY6BEGcxeJRyxc+jpLvp5NYqxbVyu6DY=; b=YOrMot5Rq8riRSLxn/3+DnQipm
	afV6VpLSLm/2e83u1fAfkSR9vHgxKhIuXY364JjmaMBfBKV2nxr4hv/E8jIDFZG4N9jwVFl6EiVBf
	Az+4AHgXINNY2f7UZihktXbKNG1Ow79YQMqJYrf0oVq26T5c9oO03PA/gsONQLcMazBuNPKQeH/QA
	6qH6k0xSaZbD6kEooeOzWfV9bu8eBf+PtEsaDOY3NhM4NghpIoSC5VmDXpyYU+En5Ei+vaZ/lzTPZ
	rrCLoPkZ6p70XxuC4nETOV4LCE3aRAqebUpXVWOdirIPTCc2zlHoaA4a/RccD9vtJH2LuoYxSBlou
	dKKol9eQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w5KSH-008yQ3-Kn; Wed, 25 Mar 2026 09:23:12 +0000
Date: Wed, 25 Mar 2026 02:23:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Michal Kubecek <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>, 
	Kory Maincent <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Ido Schimmel <idosch@nvidia.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Johannes Berg <johannes@sipsolutions.net>, 
	James Guan <guan_yufei@163.com>, Kees Cook <kees@kernel.org>, Paul Moses <p@1g4.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	security@kernel.org, notify@kernel.org
Subject: Re: [PATCH] wifi: virt_wifi: remove SET_NETDEV_DEV to avoid
 use-after-free
Message-ID: <acOpZ76jptETE7Bd@gmail.com>
References: <20260324224607.374327-1-alex.popov@linux.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324224607.374327-1-alex.popov@linux.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33835-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,bootlin.com,suse.cz,nvidia.com,pengutronix.de,gmail.com,linuxfoundation.org,sipsolutions.net,163.com,1g4.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.com:email]
X-Rspamd-Queue-Id: 17DA532239D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 01:46:02AM +0300, Alexander Popov wrote:
> Currently we execute `SET_NETDEV_DEV(dev, &priv->lowerdev->dev)` for
> the virt_wifi net devices. However, unregistering a virt_wifi device in
> netdev_run_todo() can happen together with the device referenced by
> SET_NETDEV_DEV().
> 
> It can result in use-after-free during the ethtool operations performed
> on a virt_wifi device that is currently being unregistered. Such a net
> device can have the `dev.parent` field pointing to the freed memory,
> but ethnl_ops_begin() calls `pm_runtime_get_sync(dev->dev.parent)`.
> 
> Let's remove SET_NETDEV_DEV for virt_wifi to avoid bugs like this:
> 
>  ==================================================================
>  BUG: KASAN: slab-use-after-free in __pm_runtime_resume+0xe2/0xf0
>  Read of size 2 at addr ffff88810cfc46f8 by task pm/606
> 
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x4d/0x70
>   print_report+0x170/0x4f3
>   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>   kasan_report+0xda/0x110
>   ? __pm_runtime_resume+0xe2/0xf0
>   ? __pm_runtime_resume+0xe2/0xf0
>   __pm_runtime_resume+0xe2/0xf0
>   ethnl_ops_begin+0x49/0x270
>   ethnl_set_features+0x23c/0xab0
>   ? __pfx_ethnl_set_features+0x10/0x10
>   ? kvm_sched_clock_read+0x11/0x20
>   ? local_clock_noinstr+0xf/0xf0
>   ? local_clock+0x10/0x30
>   ? kasan_save_track+0x25/0x60
>   ? __kasan_kmalloc+0x7f/0x90
>   ? genl_family_rcv_msg_attrs_parse.isra.0+0x150/0x2c0
>   genl_family_rcv_msg_doit+0x1e7/0x2c0
>   ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
>   ? __pfx_cred_has_capability.isra.0+0x10/0x10
>   ? stack_trace_save+0x8e/0xc0
>   genl_rcv_msg+0x411/0x660
>   ? __pfx_genl_rcv_msg+0x10/0x10
>   ? __pfx_ethnl_set_features+0x10/0x10
>   netlink_rcv_skb+0x121/0x380
>   ? __pfx_genl_rcv_msg+0x10/0x10
>   ? __pfx_netlink_rcv_skb+0x10/0x10
>   ? __pfx_down_read+0x10/0x10
>   genl_rcv+0x23/0x30
>   netlink_unicast+0x60f/0x830
>   ? __pfx_netlink_unicast+0x10/0x10
>   ? __pfx___alloc_skb+0x10/0x10
>   netlink_sendmsg+0x6ea/0xbc0
>   ? __pfx_netlink_sendmsg+0x10/0x10
>   ? __futex_queue+0x10b/0x1f0
>   ____sys_sendmsg+0x7a2/0x950
>   ? copy_msghdr_from_user+0x26b/0x430
>   ? __pfx_____sys_sendmsg+0x10/0x10
>   ? __pfx_copy_msghdr_from_user+0x10/0x10
>   ___sys_sendmsg+0xf8/0x180
>   ? __pfx____sys_sendmsg+0x10/0x10
>   ? __pfx_futex_wait+0x10/0x10
>   ? fdget+0x2e4/0x4a0
>   __sys_sendmsg+0x11f/0x1c0
>   ? __pfx___sys_sendmsg+0x10/0x10
>   do_syscall_64+0xe2/0x570
>   ? exc_page_fault+0x66/0xb0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   </TASK>
> 
> This fix may be combined with another one in the ethtool subsystem:
> https://lore.kernel.org/all/20260322075917.254874-1-alex.popov@linux.com/T/#u
> 
> Fixes: d43c65b05b848e0b ("ethtool: runtime-resume netdev parent in ethnl_ops_begin")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

