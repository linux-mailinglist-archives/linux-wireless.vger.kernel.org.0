Return-Path: <linux-wireless+bounces-37725-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1bTPOb0BLGrSJQQAu9opvQ
	(envelope-from <linux-wireless+bounces-37725-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 14:55:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99567989E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 14:55:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dolcini.it header.s=default header.b=lxqBbeQD;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37725-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37725-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=dolcini.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30F613015888
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 12:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC0538F233;
	Fri, 12 Jun 2026 12:50:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537E33876BA;
	Fri, 12 Jun 2026 12:50:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268644; cv=none; b=U81AI5xdg0cKqs7Ceik8HTAdlxmOrxe7pimijo73vD6+bqV+TPau5UaHgfcDj5fDc6leNx26Gez4yR3Re7/kgHbenj4wekmglOWExfnOdml22JLl2oh7cJACw/224HAWOheQgHKLe9XpR/7++w02qpOopFcSvnTGHYC4oTz6wKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268644; c=relaxed/simple;
	bh=9wALB/71vlKvBLYIA0n1DLVlL9Ar1EVQJKy91gwUDRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ch37Jer7YQKE10om4H+DqKFd8a5hkHfXt7ik/yt75+7EVRuFNIj8jGRYccNmle78X/c1bBTf99O6XGQl2gbMpcTvuvPL7rBo2pj4yYwUeAB8MX/TEY3EGcgNuIkE9dg63nAfRftGOXkuzh2ELS6vcyZVAXTNUzfT+iwY9zBSERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lxqBbeQD; arc=none smtp.client-ip=217.194.8.81
Received: from francesco-nb (93-38-183-34.ip71.fastwebnet.it [93.38.183.34])
	by mail11.truemail.it (Postfix) with ESMTPA id 51F801FCE4;
	Fri, 12 Jun 2026 14:50:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1781268632;
	bh=C/mO6qvDy4Xne29Wyz+1Tk3k+4MxwpQBbkGgCDH9e0s=; h=From:To:Subject;
	b=lxqBbeQDRKs5Y/tFi8SKH22gegUmgkyJhRMuUH0gxpMHEYP5GnQiJCgz/+orWAf1J
	 0tVkI8ssI3nTVwFHuH9TScaA/b/WrYBPxAIZ4oFMZmrDcnxmGbawbNa1/vG6gucrkg
	 6ml+7H62Blgg7SGG90gdd4YBI+Gr6CHC52TvvWJwzBNEZp28NqFdI+nuy2NWg+aPa+
	 7HuQNvCFQwkLPiPuCeVWxv28mcyC4hWmGy+uh+/Le3sFoVeNhzIWDcakalNoRltraK
	 K7JHYlXrFKmX6AmQF+SSvzZu9fRHT3soqeHTOL3RroOt25sR27OuZFlyaTdmNhw/eU
	 VkGV9c/OY75rg==
Date: Fri, 12 Jun 2026 14:50:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH net-next] drivers/net/wireless/marvell/mwifiex/sdio: Use
 strscpy() to copy strings into arrays
Message-ID: <20260612125027.GA6155@francesco-nb>
References: <20260608095523.2606-3-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608095523.2606-3-david.laight.linux@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37725-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:arnd@kernel.org,m:briannorris@chromium.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dolcini.it:dkim,dolcini.it:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,toradex.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D99567989E

On Mon, Jun 08, 2026 at 10:54:47AM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


