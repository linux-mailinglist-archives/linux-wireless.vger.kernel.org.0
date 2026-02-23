Return-Path: <linux-wireless+bounces-32104-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x6RyIgs/nGlLCQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32104-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:50:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB2175AE6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7557302835F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D5F35C1B8;
	Mon, 23 Feb 2026 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UpmuEe4C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088D358D3D;
	Mon, 23 Feb 2026 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847432; cv=none; b=rbujw5dbNpkcwhLAueYZhNCyOU5nHIS/qsd9E9Tc9OCEAnx0xX901uWB9pynW4p71Hjk/6sPHz+nBcJ2mR8PCEH/GmiK5bHbkvSTVMKusGWEFDDDIIap/V0q9Bj81TJFOHPrOH+91he2hmIg/vwk6OaUGhBgmgJgdJ4SjO4JHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847432; c=relaxed/simple;
	bh=hGyhK0C4vNASkIvbnl9A9X0cGhUEHX938Bet6cDRYzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClIDoHBMFidAwYElcTW1EU9KHbUq5aSkqNi0KkQucJVB9sIv1Kch7E5M+kx22zCX3HxIdiau8Kj7KFqVIkoFTNwWP86zvpYVP5uFOpC3pt+vFIWxaDwLyOY0tBIc8wZPR3jI2o5+gu6eI7Sygo3Q4XBIhkEuEZOYk6nwNEpdslo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UpmuEe4C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hGyhK0C4vNASkIvbnl9A9X0cGhUEHX938Bet6cDRYzM=;
	t=1771847431; x=1773057031; b=UpmuEe4C6gJT7ITY3qt6o46rx3PZFeKgiGlhUYu/gO+AOyq
	whBNOD9ak2ZDZjOdY9VkXYn7AiQk2NUqU+brMwrTe98HEMshwnLnAZqJNYk/K54jDAgq4a6aiIdJe
	ABjn/BxFdot+JrxQN3up6Mt9jGUqlDHbQXPbFUZyffk7r8LdfmiSD4ATjpuQIe4NnTT+Y2rZYBiji
	CNBei6/E4Qk7QoteKt1xwcbU3rN/Km86jvzl1CGNJWtWhTayoLP4zN1F5yG4TqRGhCAzKRfjpjC3Y
	5i+ZcxGK5mJn2zsG4ju5g4Ftmq47bccqr/OpPNinlAcvn2DhShJV8+k2QGO7Ckpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vuUSL-0000000H1KR-1Z33;
	Mon, 23 Feb 2026 12:50:29 +0100
Message-ID: <0f0703e2749185f9a334b3435ffe247b42e6923b.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: mac80211: Fix ADDBA update when HW
 supports reordering
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Pablo
 MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Date: Mon, 23 Feb 2026 12:50:28 +0100
In-Reply-To: <aZsmk0lUpL0UBd6Q@pilgrim>
References: 
	<5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt>
	 <f1243e86eea72999581d33c6f97ff9015ce71542.camel@sipsolutions.net>
	 <aZRnlPA_uY9uWuKr@pilgrim>
	 <d142f76473a03c76c780390f0352ffbb03566e48.camel@sipsolutions.net>
	 <aZR9eQlhy55iD6IN@pilgrim>
	 <6ed3a0ee5e15c73f304050d303e74441cdf61659.camel@sipsolutions.net>
	 <aZsmk0lUpL0UBd6Q@pilgrim>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32104-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3BB2175AE6
X-Rspamd-Action: no action

On Sun, 2026-02-22 at 17:06 +0100, Remi Pommarel wrote:
> > > That does make sense. However, if I understand correctly, it means th=
at
> > > even if we end up storing the timeout for drivers that support
> > > reordering, a new IEEE80211_AMPDU_RX_UPDATE should still be introduce=
d,
> > > right?
> >=20
> > I guess in order to do a no-op update that doesn't change the timeout,
> > we could? But not sure it's all worth it?
>=20
> I was going to say it would not be a no-op for a buf_size update but,
> if I understand correctly, even when SUPPORTS_REORDERING_BUFFER is not
> set the buf_size update is ignored completely and the reorder_buf is
> not resized yet a successful addba response is sent. Don't we need to
> check for buf_size change as well as timeout also?

I was going to say that I thought buf_size is not allowed to change, but
(re)reading the spec doesn't seem to bear that out.

I guess we could just unconditionally reject any updates. I'm not sure
now why we ever added the update in the first place. Perhaps some
implementation was doing no-op updates and failing on negative
responses?

> > Pablo seems to have looked up that it _is_ supported - which I didn't
> > expect because it's not part of the API contract, so the drivers
> > implemented something that can't actually ever get hit? Seems odd. And
> > I'm pretty sure e.g. iwlwifi wouldn't support it.
> >=20
> > But I basically also think it's not worth it in practice; why try to
> > support something that's never going to happen?
>=20
> Just to confirm, you mean that updating the timeout is not worth it, but
> fixing this issue is still needed right?

Right.

johannes

