Return-Path: <linux-wireless+bounces-35822-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOq3F49Z+GlStQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35822-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 10:32:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5684BA416
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 10:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4709A3010B93
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 08:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16FE331A76;
	Mon,  4 May 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LDyW/NZU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA87A331A61;
	Mon,  4 May 2026 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883293; cv=none; b=tG5obAHb7kG/n9IjxYL4IL+F3pNMcB0lrgtnUTbK2buS/xf4m0U+lcjZqLrRM29dZtokrhJNJ88mErWMH6Ul5laKqk8K9aQHhbWuPlPPsOQzJTHGRnhOuzw6AVIBBDFkYumM0dPsAC/P98PYPSh58PjZH7fK6SHH2fpP6Durw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883293; c=relaxed/simple;
	bh=vpVfXkwpSYaRIefcy0a61BzjkpwY7MPWY+jgKHbMKMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FBi1U7oWqe8xmVuQ7eGXODLD3WHGbIdkoGBRILe+1KooPIddzAU9rfo3YIDxvmOJAZQGCIMKvPpY6zWgm4A2LQfNI1a8ihwvdDq1k3e9Xr7J7cKpvHzhJRNpfDqMsK02ibSWWP6Q+eQKNg/uC4P7cVvVtN9uouP6z71VJYdV/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LDyW/NZU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BN4uSPdgnhHaUi6vQoU5jOpHW/0+tIz+jFTceVnzRvY=;
	t=1777883291; x=1779092891; b=LDyW/NZUpuU5JKgYIuP4ky975STQ7+LmwAd6M1t1QRtANtb
	g2vwZEARtCqnowsyLqpqbHgGHaKMPMTVAs0iM0IhwVy7kEr6NZOC6V4KSXzjGG9bX+wk8THO4ggcL
	J5Iy3XyQeK3wsAzN+TDsnAvVz6gI10eHGKHURLVpJeff9sOaT6jkS4us1iR1GgaaH2s03cQ2R/47D
	YcviQrniQ1ZQYEmvWXpU5qGFpDFIHXSNzIuPW3Z/9qwoR4KxDuSjeG2GNQJq2hJOCzcjvHQd25NVW
	lzq/Eyc7IpDG9beHNr4JEWINQFyKzHROG5UTOiENm8OFfFMrM4TzPu8XDz5p/p8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wJoen-0000000EpQB-2exg;
	Mon, 04 May 2026 10:28:01 +0200
Message-ID: <316680e2dc0103774bf0cfb77f60341a85ef5b81.camel@sipsolutions.net>
Subject: Re: nl80211: SET_WIPHY_NETNS does not check caller's CAP_NET_ADMIN 
 over the target netns
From: Johannes Berg <johannes@sipsolutions.net>
To: Xie Maoyi <maoyi.xie@ntu.edu.sg>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Date: Mon, 04 May 2026 10:28:00 +0200
In-Reply-To: <TYZPR01MB6758FE8FDBB58A6CAA4DC6BBDC302@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
References: 
	<TYZPR01MB6758FE8FDBB58A6CAA4DC6BBDC302@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
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
X-Rspamd-Queue-Id: AD5684BA416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35822-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

Hi,

On Sun, 2026-05-03 at 06:55 +0000, Xie Maoyi wrote:
> Hi Johannes,
>=20
> I think I have found two related namespace handling gaps in nl80211 on v7=
.0 mainline. I would appreciate your view on whether they are bugs and whet=
her they are worth fixing. The second one is much narrower than the first.
>=20
> Bug A: NL80211_CMD_SET_WIPHY_NETNS does not check the target netns.

I guess that's more a question of convention than anything else?

But I guess we should follow the netdev convention:

> By comparison, net/core/rtnetlink.c::rtnl_get_net_ns_capable() spells out=
 the convention:
>=20
>     /* For now, the caller is required to have CAP_NET_ADMIN in
>      * the user namespace owning the target net ns. */
>     if (!sk_ns_capable(sk, net->user_ns, CAP_NET_ADMIN))
>         return ERR_PTR(-EACCES);

which (also?) requires access in the target netns.

> Bug B: nl80211_prepare_wdev_dump() continuation does not re-check netns.
>=20
> The first dumpit invocation validates the wdev against the caller via __c=
fg80211_wdev_from_attrs(..., sock_net(cb->skb->sk), ...). Subsequent invoca=
tions look up the wiphy by global index via wiphy_idx_to_wiphy(). They do n=
ot re-check sock_net(cb->skb->sk) against the wiphy's current netns.
>=20
> Other dump paths in the same file do this check on every iteration. See n=
l80211_dump_wiphy() at line 3437 and the parallel scheduled scan dump at li=
ne 4420.
>=20
> If a wiphy moves between dumpit invocations of NL80211_CMD_GET_SCAN via N=
L80211_CMD_SET_WIPHY_NETNS, the dump silently keeps copying BSS list conten=
ts from the wiphy's new netns into the caller's netns. On its own this race=
 needs a separate caller to migrate the wiphy mid-dump. With bug A, the att=
acker can arrange the race themselves.

This seems ... inconsequential? After all, moving a wireless device
between namespaces doesn't really change the physical layout of the
machine. Perhaps that'd give someone access to the SSID of some hidden
network but that's not really a secret anyway since it's over the air.

Maybe we should fix it for clarity and convention, but I don't see it's
really an issue?

johannes

