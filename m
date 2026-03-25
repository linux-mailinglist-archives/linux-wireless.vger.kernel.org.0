Return-Path: <linux-wireless+bounces-33848-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBYtE3jpw2lvugQAu9opvQ
	(envelope-from <linux-wireless+bounces-33848-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 14:56:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA6326374
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E10C430BA7ED
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F95F3D88F8;
	Wed, 25 Mar 2026 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bzrk0jUN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BFA3D412F;
	Wed, 25 Mar 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446490; cv=none; b=YLO3mD6nSN68ZDbdikRWlHpKVkQ72ano5v202TbCzgsZy3KMRyWZoz7kdliE9ChAXhQNe1NsCdV3uH5d2K89O8obOsOuNduOJt4w9DOlEGe9vqUR1pHv3ijNF0RqatHjnnu+ZD60Nw2KfCCa88+ex20INEtDsKl253KeT+Ou3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446490; c=relaxed/simple;
	bh=wa8qIFohemTk/g54CeWAa2Thx2DA4qSfqNGZmFYAs4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT/hZ5acauj6jrYoFn4MwA0xoubf8+yx15DWDojfWRhYVp7ykJfKnO54ebXKS7Z5vD3I68Zk0Mr8xB2TRpwDYgU8kpgbUr9PMDlXNETU51mYZkRNR53hgDcNamUtxWKlXpRgi2e8EULLIkJ5N+zVukowFS86rGT5k/orlQ2DqvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bzrk0jUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6A7C4CEF7;
	Wed, 25 Mar 2026 13:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774446490;
	bh=wa8qIFohemTk/g54CeWAa2Thx2DA4qSfqNGZmFYAs4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bzrk0jUNo6rWAxMZNANyPxvz0s5wDZOwvK1rP09Uv7E33SnNLnY2wJCYhjXnSMlui
	 Xm9h21jL1CBvFLq0CuEq6BZiEhysnxxDN/Hq867xJR0gLQeUaHQBZqpoYmF72lWwYI
	 vFaSnUXsBCMHmUu1Qcqiiqqgy1Bh57aFj6yqgYLY=
Date: Wed, 25 Mar 2026 14:47:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Popov <alex.popov@linux.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Michal Kubecek <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	James Guan <guan_yufei@163.com>, Kees Cook <kees@kernel.org>,
	Paul Moses <p@1g4.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org, notify@kernel.org
Subject: Re: [PATCH] wifi: virt_wifi: remove SET_NETDEV_DEV to avoid
 use-after-free
Message-ID: <2026032550-economist-rage-ee10@gregkh>
References: <20260324224607.374327-1-alex.popov@linux.com>
 <fa3c91c3-9ceb-4fb2-9250-cc239fb0c1b6@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3c91c3-9ceb-4fb2-9250-cc239fb0c1b6@lunn.ch>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33848-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,davemloft.net,google.com,redhat.com,bootlin.com,suse.cz,nvidia.com,pengutronix.de,gmail.com,sipsolutions.net,163.com,1g4.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: EDCA6326374
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 01:34:43PM +0100, Andrew Lunn wrote:
> On Wed, Mar 25, 2026 at 01:46:02AM +0300, Alexander Popov wrote:
> > Currently we execute `SET_NETDEV_DEV(dev, &priv->lowerdev->dev)` for
> > the virt_wifi net devices. However, unregistering a virt_wifi device in
> > netdev_run_todo() can happen together with the device referenced by
> > SET_NETDEV_DEV().
> > 
> > It can result in use-after-free during the ethtool operations performed
> > on a virt_wifi device that is currently being unregistered. Such a net
> > device can have the `dev.parent` field pointing to the freed memory,
> > but ethnl_ops_begin() calls `pm_runtime_get_sync(dev->dev.parent)`.
> > 
> > Let's remove SET_NETDEV_DEV for virt_wifi to avoid bugs like this:
> 
> Did you have a look at all user of SET_NETDEV_DEV() to see if there
> are other examples of the same bug?
> 
> What i found was:
> 
> https://elixir.bootlin.com/linux/v6.19.9/source/drivers/net/ethernet/mellanox/mlx4/en_netdev.c#L3180
> 
> Does this have the same problem?

That's not pointing to the "parent" device, but rather the actual device
under operation from what I can tell.  Or am I mistaking what "pdev"
means here?  Isn't that the pci device the driver is bound to?

thanks,

greg k-h

