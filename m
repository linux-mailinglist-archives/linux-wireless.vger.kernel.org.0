Return-Path: <linux-wireless+bounces-37942-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZyWgI4mcN2ocPQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37942-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 10:10:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1338A6AA628
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 10:10:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37942-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37942-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44EB3300AEC6
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E51024DCF9;
	Sun, 21 Jun 2026 08:10:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314123392D;
	Sun, 21 Jun 2026 08:10:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782029444; cv=none; b=HE8Nv9vxNmNENjdQcTZ6X40IG3dy6XK6fOVhu7tQwf6kj7dsOY+XrJs1WDRJbfaTEYefgUM/r6i+8273ZRRZmLI2P6OijmF9480DKQ6Qrwisd/2w860l9Gp0zQkf37qWdML9bppjgJnWBZgfCBSGZU3oEQtE3PvkIqyd4tgXpPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782029444; c=relaxed/simple;
	bh=MWi219Ncas9cYkI9YWVt1si3M2vFYY6RuANlgWY9qYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uxf+LtcoK81YlzOCiKIltwRhT6EmCqMZ7xmRly6vMpvqZy/p5lRmMujwRGo/QwHF4IC6hSMTL1Zs8Ny7zW1qhbyF9ppJImLPmxKzM6bshvGwEsVMQ3QJ/lyw3UDkRXjHVvPHlfpczE9l6hib1mCWtPaKXM1l6c16Ky/EwlQQt3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 8338010DC8;
	Sun, 21 Jun 2026 10:10:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6F95A6015A99; Sun, 21 Jun 2026 10:10:31 +0200 (CEST)
Date: Sun, 21 Jun 2026 10:10:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: linux-pci@vger.kernel.org, helgaas@kernel.org,
	linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Message-ID: <ajecdx3HYj5rqJBZ@wunner.de>
References: <20260621065451.21650-1-emmanuel.grumbach@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621065451.21650-1-emmanuel.grumbach@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37942-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_RECIPIENTS(0.00)[m:emmanuel.grumbach@intel.com,m:linux-pci@vger.kernel.org,m:helgaas@kernel.org,m:linux-wireless@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lukas@wunner.de,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:mid,wunner.de:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1338A6AA628

On Sun, Jun 21, 2026 at 09:54:51AM +0300, Emmanuel Grumbach wrote:
> The Intel wireless BE200 device fails to copy the TLP Attributes from a
> Request to the Completion.
> Since there is no caching involved the device anyway, disable the
> NoSnoop and Relaxed ordering on the root port.

Is there a public Specification Update which could be linked in the
commit message and/or code comment?

Thanks,

Lukas

