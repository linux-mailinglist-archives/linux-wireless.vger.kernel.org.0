Return-Path: <linux-wireless+bounces-37726-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bLyAE6AELGrRJgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37726-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:07:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95250679A41
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:07:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dolcini.it header.s=default header.b=wC8dERj8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37726-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37726-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=dolcini.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52CE3301CF87
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154F37F8C3;
	Fri, 12 Jun 2026 13:06:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC9374E62;
	Fri, 12 Jun 2026 13:06:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269597; cv=none; b=WH6nT1/Z0Wl451pOajap85cZtQzB8mdsdH+VZyLBqGEHvqmJeafqzaSrai4Z9cbdG0Xc1V+yZeGxonjlyIM68dV0OtZJdooZCoBHVB4X9/oPWhZ1bLNWnwX7rS8tZEoJCMQexjwHl8LJyPeqRA8czNRj7sYs+C+F5PDE63lXm5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269597; c=relaxed/simple;
	bh=3/2Ue11F8wL6UEOw2Vu0tastySxi0e23NXJT9xOo4sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPNt9TCiJiB/nH8ewYlmQpnJz3Id+qh4NopKLErjlfO61lWILfF0FoxSQzvgank9S2Lm4wQh87Xo+HtkkuxP2ICcY69Jx74s+QIFsUiFcwv1gjsHdPhE8xBISRGhJg0bBFj53nS2ELAOsnbzZUzb2/gnUJAUWPFjEwe3w/fkTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wC8dERj8; arc=none smtp.client-ip=217.194.8.81
Received: from francesco-nb (93-38-183-34.ip71.fastwebnet.it [93.38.183.34])
	by mail11.truemail.it (Postfix) with ESMTPA id 5FFEB1FC78;
	Fri, 12 Jun 2026 15:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1781269593;
	bh=fL+oJnyelhrz5BnZSlgYYkxM+MCu//nUXuJUicIg6vs=; h=From:To:Subject;
	b=wC8dERj8Hqae11QuUCttVkAFFEknSQGWPWcsachCf0hdL4vpxuKzt0Qh1USUeLdxY
	 WrPAVrerZ3SfS75tlde7IyMg7fYInsItW8j+kkgejDesdS1LIxDoTfO8zpMxKx84t7
	 /O/YDfkK8mAcH8GI18wTd9mmz09NWAV9VcETk8cYKs3keX3ahiIHRwAWxVOs7ZOvWz
	 pG0KeXldn1uaBDZSXMAMoMmudjTcVPKJy1M4tKUrckJ+UfjEprCJyPQId+eGAe1T3C
	 tSQ38qX6ot5+m5CjrIVWPYK8wD3xxKxSodhiQyB5XmegiDm7KByb3xnJ9qVHm1zuJr
	 kefB2lQr0SWFQ==
Date: Fri, 12 Jun 2026 15:06:28 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Rafael Beims <rafael@beims.me>, Brian Norris <briannorris@chromium.org>,
	Jeff Chen <jeff.chen_1@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless-next v1] wifi: mwifiex: fix permanently busy
 scans after multiple roam iterations
Message-ID: <20260612130607.GA7651@francesco-nb>
References: <20260612122547.1586872-2-rafael@beims.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612122547.1586872-2-rafael@beims.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37726-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rafael@beims.me,m:briannorris@chromium.org,m:jeff.chen_1@nxp.com,m:francesco@dolcini.it,m:rafael.beims@toradex.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dolcini.it:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dolcini.it:dkim,dolcini.it:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,francesco-nb:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95250679A41

On Fri, Jun 12, 2026 at 09:25:46AM -0300, Rafael Beims wrote:
> From: Rafael Beims <rafael.beims@toradex.com>
> 
> In order for the firmware to sleep, the driver has to confirm a
> previously received sleep request. The normal sequence of evets goes
> like this:
> EVENT_SLEEP -> adapter->ps_state = PS_STATE_PRE_SLEEP -> sleep-confirm
> -> SLEEP -> EVENT_AWAKE -> AWAKE.
> Before sending the sleep-confirm command, the driver must make sure
> there are no commands either running or waiting to be completed.
> 
> mwifiex_ret_802_11_associate() unconditionally sets
> ps_state = PS_STATE_AWAKE when it processes the association command
> response, outside of the normal powersave management flow. If
> EVENT_SLEEP arrives while the association command is in flight,
> ps_state is PRE_SLEEP when the association command response is parsed,
> and the forced AWAKE overwrites it. The deferred sleep-confirm is
> never sent.

Brian / Jeff: I am not that familiar with this part of the code, it
sounds correct to me (and I discussed it with Rafael before he did send
the patch), maybe you can also have a look.

Jeff: same issue in the nxpwifi driver.

Francesco


