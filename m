Return-Path: <linux-wireless+bounces-32211-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JtYCfCCoGkDkgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32211-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:29:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9D21AC6CA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED09930BE1E5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCB0428479;
	Thu, 26 Feb 2026 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="p47U8aGU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D27426EC7;
	Thu, 26 Feb 2026 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123323; cv=none; b=AD2nm44OThj4dyaWKxnZ+Rm1KAJyDgNFrFSB8xROK9X7WKdBBecFQXK0OS3KYAB+qrjEOln5opSYhouooA/C9D4CLDqQYewo4jW2SWX6CVc5/jABywpT6oWAlhFsZ4WrWj8gY4PRInu1DjB5WxOa8Q84KagcCtc1C9wpojX5hEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123323; c=relaxed/simple;
	bh=IpWhmGUs07/ifKjW0BClfLzUx6ruovRKoSof7TLkZ8U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRhptIwjFlIcfjFK5xqVD5+nPMgbQp1gH3W/hnV+DjLImbyNi7WL88evfZDjjkRz7lEDL/ra7jbbobL2rzqSCvtElnIV5Wbtv92hghS/wCxOx0WCrB2DrEyU4VsveeE9SHZvfRb85jf/Bk92kXJTGPs/0+aNNderoajxkIYBUrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=p47U8aGU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IpWhmGUs07/ifKjW0BClfLzUx6ruovRKoSof7TLkZ8U=;
	t=1772123322; x=1773332922; b=p47U8aGUU8IGVIcRvC0rB6T4Zg40zNG9AkDB2iJxTbP/Ow9
	i4xlu0Su2iVYOHNXfsPFMjHoJnszBVhkYIdKV0RFDmZvs3fsPGCzynDmQBTDNPYKAz5aaqK7SkeoT
	+D7QIJtv0cP6xSV8oQn4Itd0CXH4iUo5ZcJbGys8Zlw81FUCG8XrONMr5yj4v+IzXTeE1fKXOEdFt
	fOwyasVe9cjr9CyaNPf3Rtm3bytfdNB3r9wnDAlAY+HvFl6UCW3gef8/q10qXewf2pl/lQekGHYyV
	0ocN+ZN1e9ZWlilMZYhlrgdg91QgYqHXED8olP4xcxMSDO/8r/nLKbg/r8qOVW0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vveEB-00000002UBt-1WeZ;
	Thu, 26 Feb 2026 17:28:39 +0100
Message-ID: <ab5b9eb76e4a94745c7cf1bfa886f067618a54b6.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: mac80211: Fix ADDBA update when HW
 supports reordering
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>, Pablo MARTIN-GOMEZ
	 <pmartin-gomez@freebox.fr>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 26 Feb 2026 17:28:38 +0100
In-Reply-To: <aaBo7rnVkRFz3h-U@pilgrim>
References: 
	<5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt>
	 <f1243e86eea72999581d33c6f97ff9015ce71542.camel@sipsolutions.net>
	 <aZRnlPA_uY9uWuKr@pilgrim>
	 <d142f76473a03c76c780390f0352ffbb03566e48.camel@sipsolutions.net>
	 <aZR9eQlhy55iD6IN@pilgrim>
	 <6ed3a0ee5e15c73f304050d303e74441cdf61659.camel@sipsolutions.net>
	 <aZsmk0lUpL0UBd6Q@pilgrim>
	 <0f0703e2749185f9a334b3435ffe247b42e6923b.camel@sipsolutions.net>
	 <19061b55-a211-4448-8c49-ca8daa6d9d61@freebox.fr>
	 <aaBo7rnVkRFz3h-U@pilgrim>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32211-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF9D21AC6CA
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 16:49 +0100, Remi Pommarel wrote:
> On Mon, Feb 23, 2026 at 02:25:13PM +0100, Pablo MARTIN-GOMEZ wrote:
> > Hello,
> >=20
> > On 23/02/2026 12:50, Johannes Berg wrote:
> > > On Sun, 2026-02-22 at 17:06 +0100, Remi Pommarel wrote:
> > > > > > That does make sense. However, if I understand correctly, it me=
ans that
> > > > > > even if we end up storing the timeout for drivers that support
> > > > > > reordering, a new IEEE80211_AMPDU_RX_UPDATE should still be int=
roduced,
> > > > > > right?
> > > > >=20
> > > > > I guess in order to do a no-op update that doesn't change the tim=
eout,
> > > > > we could? But not sure it's all worth it?
> > > >=20
> > > > I was going to say it would not be a no-op for a buf_size update bu=
t,
> > > > if I understand correctly, even when SUPPORTS_REORDERING_BUFFER is =
not
> > > > set the buf_size update is ignored completely and the reorder_buf i=
s
> > > > not resized yet a successful addba response is sent. Don't we need =
to
> > > > check for buf_size change as well as timeout also?
> > >=20
> > > I was going to say that I thought buf_size is not allowed to change, =
but
> > > (re)reading the spec doesn't seem to bear that out.
> > For once, the standard (802.11-2024) is really clear on this (10.25.2):
> >=20
> > A block ack agreement may be modified by the originator by sending an
> > ADDBA Request frame (see 11.5.2, except that MLME-ADDBA primitives are
> > not used by the originator). All parameters of the agreement may be
> > modified except for the TID. If the request is not successful, the
> > existing agreement is not modified. If the request is successful, the
> > behavior is as if a DELBA frame for the block ack agreement had been
> > transmitted by the originator and received by the recipient immediately
> > prior to the ADDBA Request frame.
> > >=20
> > > I guess we could just unconditionally reject any updates. I'm not sur=
e
> > > now why we ever added the update in the first place. Perhaps some
> > > implementation was doing no-op updates and failing on negative
> > > responses?
> > >=20
> > If the originator is compliant and trying to update, unconditionally
> > rejecing any update shouldn't have any side-effects. But if the
> > originator doesn't receive the ADDBA response, it is going to resend an
> > ADDBA request; for the originator, it is just a retry, but for the
> > recipient it's an update, so the originator is going to receive a non
> > success. And unless the originator sends a DELBA "by default" at some
> > point, it won't be able to create a new BA (for a given TID) with the
> > recipient.
> > [...]
>=20
> I=E2=80=99m a bit concerned that ignoring all ADDBA updates might break S=
TAs
> with finicky aggregation implementations. For example, I=E2=80=99ve obser=
ved an
> ath12k mesh point get stuck in a loop, repeatedly sending the same ADDBA
> request (with unchanged timeout or buffer size) only for us to keep
> reject it each time.

Sounds like you're both arguing for an "accept if no-op" rather than
unconditional reject, which seems fine to me. Just means storing the
values differently?

johannes

