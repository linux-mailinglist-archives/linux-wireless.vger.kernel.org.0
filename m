Return-Path: <linux-wireless+bounces-38676-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +z6fJpKuS2rNYQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38676-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:33:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C271150C
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:33:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=C61h+jvF;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38676-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38676-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4DA304D249
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680440D576;
	Mon,  6 Jul 2026 11:42:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DF37BE72;
	Mon,  6 Jul 2026 11:42:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338133; cv=none; b=ahBY0EpvN6jc3VLZQz/8S/EmMOL7x8xnyXE90La+6ui9PioU2P0Dj2PptQzAIJ7rEbH8xyvIC75Dk4CXhNq0tG5Qm4Xzp1EkrK1MRQsBfM6ASEYEAGUMATkXw4WYH+WUyDEXY1atwg9mgwOjaNCsSJc9KgVfWSX1NpeqRIrGXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338133; c=relaxed/simple;
	bh=ASsx8UfH0FIFGAP7FDWXSjd3lC1BEJYoUZ4zwFNSkZY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C89bcuVu6NnNCCe3AkQxgt4AdGwOFdFR6uaCqNra1NgKcXIjCBNG+agUO1UaRl+eg+O4tQbwJHzO/tdgHU5E4zewy5+oLLFuq9eJwSCxcLxLXQ7BeBWfrFNV3wQ/6se03h1djCF95X2jh19Xz+7GYoak4aQAjVURG2WHc8C3TqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C61h+jvF; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ASsx8UfH0FIFGAP7FDWXSjd3lC1BEJYoUZ4zwFNSkZY=;
	t=1783338131; x=1784547731; b=C61h+jvFrN/usxNtNBgh/NG9FFwFRPwYTBDwdKROPmyzJ5a
	/6ptj0x6Ae5tWUTr09d3B0dj/Q8LcxbI4i2wWhuwMNsj3af/hwygY05x2ZPrl5Rl0OkjeXjbTLTSG
	PmLwVnksMfpBS7GMorRMhzQBqmDb9VOknnXSKFkksOtjJKHy/xBp13gNgCxLnIggqpz0zp1EYrh2N
	5NpSwmM2qZ6EO1rIHG1K9Idb62+zZze9NuW4G5ZXkKjSsMrqCVPwNwYFp4qjxQAyjPnjPcNGPXl/i
	Nztem25HTwDdR286Pu8C5VpktxelgtS+qvqHFwwm4oQqPHdENhh2hOwLsDTqbEaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wghiB-0000000DMAe-0yF1;
	Mon, 06 Jul 2026 13:42:07 +0200
Message-ID: <4fc7e89b3203e9bc8843c848268519d34585a038.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: serialize socket owner release with
 netdev teardown
From: Johannes Berg <johannes@sipsolutions.net>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Date: Mon, 06 Jul 2026 13:42:06 +0200
In-Reply-To: <20260619162500.3876325-1-zzzccc427@gmail.com> (sfid-20260619_182509_015809_D905BC2E)
References: <20260619162500.3876325-1-zzzccc427@gmail.com>
	 (sfid-20260619_182509_015809_D905BC2E)
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zzzccc427@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38676-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E97C271150C

On Sat, 2026-06-20 at 00:25 +0800, Cen Zhang wrote:
> NETDEV_GOING_DOWN tears the interface down and cancels disconnect_wk, and
> NETDEV_UNREGISTER removes the wireless device from the cfg80211 list. The=
re
> is no ordering between those paths today,

What's that supposed to mean? Of course there's ordering between those
two things?

> so the netlink notifier can pass
> the conn_owner_nlportid check before teardown clears it, then queue
> disconnect_wk after the NETDEV_GOING_DOWN cancel has already returned.

Yeah I guess that seems like it could happen.

> Take RTNL while the notifier walks cfg80211 devices and schedules owner
> cleanup work. Netdevice notifier delivery already runs under RTNL, so the
> schedule and cancel are ordered: either the work is queued before
> NETDEV_GOING_DOWN and the existing cancel drains it, or teardown runs fir=
st
> and the notifier no longer queues work for that connection owner.

That seems a bit over the top vs. just moving the cancel - why is this
the only correct fix?

johannes

