Return-Path: <linux-wireless+bounces-35206-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJSEBhWE6GkNLQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35206-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 10:17:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7272D443578
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22BD7302B521
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4853BF677;
	Wed, 22 Apr 2026 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="phGMDeiM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006E03BED79;
	Wed, 22 Apr 2026 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845842; cv=none; b=LcHuR5jQBynVXjdHVAnFIffS+FcMtKBA+n+aadrD+ATfX6Bg02pf1C71AYvPIZYP/w5Fyf1tE/YMwGMDVxl4ns3mYmbwY+WT+7SB55Oe+w1fd8a6t9v5S44MgXoT40cgwkW5sQM4J0CcfTfOlKOdJkjOZMNNngqs+U29P6PNlic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845842; c=relaxed/simple;
	bh=HGC/JRyoNvyNUV4QXYG4juHOZmN/yT2mah0PuAvfojo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mi9z0sO+dD2AfoQsM8+Y9oLDD2ZVXtJeU6KvxeEM9a+ZWJjWuKp+l4xWHVy/P7+ez+bIvsuqkjzBq0OU25RXLhsZfKKGHKid7vYVMaL+vbrUxcH+L3KaurSoZUaRmRFd6HI1gbGxWBbjhIEQs72r7U2fzZq89P26z5voGrmt6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=phGMDeiM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HGC/JRyoNvyNUV4QXYG4juHOZmN/yT2mah0PuAvfojo=;
	t=1776845841; x=1778055441; b=phGMDeiMzOFk1t4uzQHYuwFMgNPlMTPW0Sy/GuapqZTpU3x
	pTihX8O7tX3gO6fgtCAPLEo0vvrU0U9V2lHe6eCjaN7RLtvquaFuOXhTG+ojxe2t/+kTyihQJH8LJ
	QztSMPerOzXCcdkjDCjXrDkXVS2SXV+et1pFBqU5ysayXc598NGY9XN2KSMGWURrRrLfDCrXeAqtK
	+DQUo5sOBkatie7caxPdueXcJehEGnzPpAFKPwdzYRHqEQckTJZoNeJyyJX2EIBI91eklGJlUP6Hi
	Vgglf+8z9gvYikAK1fYQj+VR/G96Y4F3TJJGpsnqhRqKi1LCym54etCEtHJVp28Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1wFSln-000000069nm-43Aq;
	Wed, 22 Apr 2026 10:17:16 +0200
Message-ID: <3720de2882e8238855e85b312f66a39366068433.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: check ieee80211_rx_data_set_link return
 in pubsta MLO path
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, Michael Bommarito
	 <michael.bommarito@gmail.com>, linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ramasamy Kaliappan
	 <ramasamy.kaliappan@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 10:17:14 +0200
In-Reply-To: <434407f50d6b7ee85ad14dd6db757f7d9f695a96.camel@sipsolutions.net> (sfid-20260422_082757_656444_8F0EBA32)
References: <20260422000651.4184602-1-michael.bommarito@gmail.com>
		 (sfid-20260422_020705_790305_99EA1A92) <434407f50d6b7ee85ad14dd6db757f7d9f695a96.camel@sipsolutions.net>
	 (sfid-20260422_082757_656444_8F0EBA32)
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35206-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_TO(0.00)[sipsolutions.net,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 7272D443578
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-22 at 08:27 +0200, Johannes Berg wrote:
> On Tue, 2026-04-21 at 20:06 -0400, Michael Bommarito wrote:
>=20
> > Benjamin Berg's 2026-02 RFC v2 "wifi: mac80211: refactor RX
> > link_id and station handling"
> > (20260223133818.9f5550ab445f.I...@changeid) touches the same
> > code and may supersede or subsume this patch; happy to fold /
> > rebase / drop.
>=20
> Yeah, Benjamin, what's up with that :)

Hmm, good question. I was hoping for a userspace hostap implementation
to start using the new NO_STA flag as that part is otherwise untested.
Qualcomm was going to work on that, but I have not yet heard about it
again.

That said, it should be fine to merge patches 1-4 at least. So I am
happy to submit them separately.

Benjamin

>=20
> OTOH we perhaps wants this patch in wireless, and then yours in
> wireless-next.
>=20
> johannes

