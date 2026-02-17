Return-Path: <linux-wireless+bounces-31957-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIzUHs6QlGk9FgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31957-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 17:01:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B489114DCEB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 17:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C4D7300440D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC92DC764;
	Tue, 17 Feb 2026 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IynfXP/6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A842D592C;
	Tue, 17 Feb 2026 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344061; cv=none; b=fcVVwXnFPTxsqbo7JGNmJdZoTdH/18YV16fgbLV01vb9OmhRIkQSNHTRltGk0vy0c8EQtKRtXpm9H72GiluQQYgB9OURhTydTVE7hW5Xsg34xfRbYCfqeFWB6KT1yrrjWlwf5yrdJfY5yDqgGTX6vCyOi9DjgEH3uF3NiyD+jC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344061; c=relaxed/simple;
	bh=HwQH+6oTuwSOmFmmMdmdwytaxxG6IMrbl6CUTbuluOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCS/563pSfYj+JKFhjRoPHKuztyyk4hiSIEPWuTrkUwazQnlTNenoDrorKt5p7iGuYdTlkhs930QLy5vTxQ5my/D4NaiI8oF4Mh2XaLI+ZeaTc6e89KrDbAXVEZkBn/WaNJUL/w56lHqr6dEaWaIQ8tnhiVwddHdtix8ViBT29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IynfXP/6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HwQH+6oTuwSOmFmmMdmdwytaxxG6IMrbl6CUTbuluOE=;
	t=1771344060; x=1772553660; b=IynfXP/6LFTYG+22bw3+OZNMM5neLxjXqlj+pcvp6CMEtVa
	QkHzECoHbgAgR8OtSWCe1icT9YXpA2hugYJ02rTe8Q8Fo2qa9YqsVXLC93e78G43qDT0rzvxXlFFe
	iTzmPRuOwZjGXrnMlnbas7WeZMiXWnciiHetEF8Diz2rOWp4bCBrgZwcVnKoSp+I1CBzYvH8WLnOO
	RxefYjqaV5dVnSkN4ovBwxSfMYZMNWwnT3UgHMX8b6NfRIzB4OAKR2/JLQi61Sw1C77E3ZAs9bq26
	xvEEOp89QpdAAERTkDPHBpJtNCwymsijLtieFR+vhH20VC3VhKR+gAbefmxkwPHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vsNVR-0000000BTRf-34uj;
	Tue, 17 Feb 2026 17:00:57 +0100
Message-ID: <6ed3a0ee5e15c73f304050d303e74441cdf61659.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: mac80211: Fix ADDBA update when HW
 supports reordering
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Pablo
 MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Date: Tue, 17 Feb 2026 17:00:56 +0100
In-Reply-To: <aZR9eQlhy55iD6IN@pilgrim>
References: 
	<5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt>
	 <f1243e86eea72999581d33c6f97ff9015ce71542.camel@sipsolutions.net>
	 <aZRnlPA_uY9uWuKr@pilgrim>
	 <d142f76473a03c76c780390f0352ffbb03566e48.camel@sipsolutions.net>
	 <aZR9eQlhy55iD6IN@pilgrim>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[sipsolutions.net:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-31957-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B489114DCEB
X-Rspamd-Action: no action

On Tue, 2026-02-17 at 15:38 +0100, Remi Pommarel wrote:
> On Tue, Feb 17, 2026 at 02:59:34PM +0100, Johannes Berg wrote:
> > On Tue, 2026-02-17 at 14:05 +0100, Remi Pommarel wrote:
> > > On Tue, Feb 17, 2026 at 12:30:08PM +0100, Johannes Berg wrote:
> > > > On Tue, 2026-02-17 at 11:36 +0100, Remi Pommarel wrote:
> > > > > Commit f89e07d4cf26 ("mac80211: agg-rx: refuse ADDBA Request with=
 timeout
> > > > > update") added a check to fail when ADDBA update would change the
> > > > > timeout param.
> > > > >=20
> > > > > This param is kept in tid_ampdu_rx context which is only allocate=
d on HW
> > > > > that do not set SUPPORTS_REORDERING_BUFFER. Because the timeout c=
heck
> > > > > was done regardless of this param, ADDBA update always failed on =
those
> > > > > HW.
> > > >=20
> > > > Seems like a legit problem, but
> > > >=20
> > > > > Fix this by only checking tid_ampdu_rx->timeout only when
> > > > > SUPPORTS_REORDERING_BUFFER is not set.
> > > >=20
> > > > that doesn't seem right? Especially the way you implemented it, it =
won't
> > > > even respond at all when it's an update and SUPPORTS_REORDERING_BUF=
FER
> > > > is set.
> > >=20
> > > I could be wrong but I think the patch format here make it difficult =
to
> > > read. If it's an update and SUPPORTS_REORDERING_BUFFER is set, the
> > > following "if" in the code (not fully visible in the diff here) will =
end
> > > calling drv_ampdu_action().
> >=20
> > Yes, but it will be IEEE80211_AMPDU_RX_START which isn't really intende=
d
> > by the state machine/API between mac80211/driver. So that doesn't seem
> > right.
> >=20
>=20
> That does make sense. However, if I understand correctly, it means that
> even if we end up storing the timeout for drivers that support
> reordering, a new IEEE80211_AMPDU_RX_UPDATE should still be introduced,
> right?

I guess in order to do a no-op update that doesn't change the timeout,
we could? But not sure it's all worth it?

Pablo seems to have looked up that it _is_ supported - which I didn't
expect because it's not part of the API contract, so the drivers
implemented something that can't actually ever get hit? Seems odd. And
I'm pretty sure e.g. iwlwifi wouldn't support it.

But I basically also think it's not worth it in practice; why try to
support something that's never going to happen?

johannes

