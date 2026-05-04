Return-Path: <linux-wireless+bounces-35842-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHqeEomZ+GkAxAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35842-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:05:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E9F4BD680
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7384302811C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 13:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377F53D7D95;
	Mon,  4 May 2026 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tI9XQLOU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5034F483;
	Mon,  4 May 2026 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899756; cv=none; b=kzq2TgaDaupxmnHRpX19ahvBri6haMe36hTy2UnnPot8utFAgf/f2iex7QQxWO2/4Uxb9UuEGMH6RQ93de+ZYEe9CjXxEUTZgNpxHwA1CGp17w4ZsFQEgpUjIt+UZNpwp3VmOa26y92gO2SQ8bXvG9/1jOx3B08M300SoPtTBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899756; c=relaxed/simple;
	bh=hDVlmKICGdBFrOGtysDGeeiuj0FDhsY4cV1BhL7tHy0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VwlfVCos+rwPVabeLLKXPJFdr4sJXDc0UslBj4IOflTfrsx1/JUzmC+3+mu0yHs7gwkLp13tSl9IyNG/ta5pG6OylUN2Uwl3Nq6X0cL0xnunjU8rLQqMyXLF93/helbx05teZxy7iEoMHh4russTYTBvq3gzrSf+ylSdMmjrASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tI9XQLOU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PyiMj+S+Fn039J/0cIB0Ty7pkSjsthr/gwyte9llfeY=;
	t=1777899754; x=1779109354; b=tI9XQLOUzJPoWA+OlBVZaGUAFB0eD6TqW2FDR+PqZbNdUY2
	AzZ+0OzGsbWY1rpxSpewBBiKqoc42eDDYD/0Zpmpv8UFQLkkvksfbdq6iaNW6Odd7QxErFVFjc0tL
	4yrMsu6olEXfYo/r2aRwqSuiKuM2GrOKFxOVyXix4YBOlHXiFQ39txIImbskLc/yAonBP7KH0VRGI
	d3IrEjcfAHbjcQgWBbKYASrWbqsxIoIyKdjmAopeoNaWoQs5bURhMtsVSZaJnNsmhOej3Ce+7+5t2
	LoSJpK8v17ig/rUa0xjNHC8IL0aUq6Z8xky44W+ZJPYkRjpgHtmKrvZojgFHAlRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wJswR-0000000ExzX-3E5c;
	Mon, 04 May 2026 15:02:31 +0200
Message-ID: <c410f8ac2d91b964b279c3f106dd500da3e7afb2.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: nl80211: re-check wiphy netns in
 nl80211_prepare_wdev_dump() continuation
From: Johannes Berg <johannes@sipsolutions.net>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 15:02:30 +0200
In-Reply-To: <20260504125753.1154601-3-maoyi.xie@ntu.edu.sg> (sfid-20260504_145805_299601_518364A5)
References: <20260504125753.1154601-1-maoyi.xie@ntu.edu.sg>
	 <20260504125753.1154601-3-maoyi.xie@ntu.edu.sg>
	 (sfid-20260504_145805_299601_518364A5)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: B0E9F4BD680
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35842-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid,ntu.edu.sg:email]

On Mon, 2026-05-04 at 20:57 +0800, Maoyi Xie wrote:
> NL80211_CMD_GET_SCAN is implemented as a multi-call dumpit. The first
> invocation of nl80211_prepare_wdev_dump() validates the requested wdev
> against the caller's netns via __cfg80211_wdev_from_attrs(). Subsequent
> invocations look up the same wiphy by global index via
> wiphy_idx_to_wiphy() and do not re-check that the wiphy is still in
> the caller's netns.
>=20
> If the wiphy is moved between dumpit invocations (via
> NL80211_CMD_SET_WIPHY_NETNS), the dump silently continues to copy BSS
> list contents from the wiphy's new netns into the caller's netns
> socket buffer. The other dump paths in nl80211.c (e.g.
> nl80211_dump_wiphy() and the parallel scheduled scan dump) already
> filter by net_eq(wiphy_net(...), sock_net(skb->sk)) on every iteration.
>=20
> Add the same filter to the continuation path. If the wiphy's netns no
> longer matches the caller's, return -ENODEV and the netlink dump
> machinery terminates the walk cleanly.
>=20
> This is most usefully fixed alongside the SET_WIPHY_NETNS target-cap
> hardening in patch 1/2, which closes the path by which an
> unprivileged-userns caller could trigger this race themselves.
>=20
> Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> ---
>  net/wireless/nl80211.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index db546dd93..61b9e5eb0 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -1276,6 +1276,18 @@ static int nl80211_prepare_wdev_dump(struct netlin=
k_callback *cb,
>  			rtnl_unlock();
>  			return -ENODEV;
>  		}
> +		/*
> +		 * The first invocation validated the wdev's netns against
> +		 * the caller via __cfg80211_wdev_from_attrs(). The wiphy
> +		 * may have moved netns between dumpit invocations (via
> +		 * NL80211_CMD_SET_WIPHY_NETNS), so re-check here. Other
> +		 * dump paths in this file (nl80211_dump_wiphy() and friends)
> +		 * already do this check on every iteration.
> +		 */

The code seems fine, but the comment saying "mirror other things" seems
a bit questionable, more about the reason why to make this change than
the static state of the code. If we think it must be unified between all
the callers, then it should probably have a common check function or so.

johannes

