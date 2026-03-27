Return-Path: <linux-wireless+bounces-34089-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHvrAkGZxmnrMQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34089-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 15:50:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD1F346524
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 15:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05EFB300A5B1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6A3F9F36;
	Fri, 27 Mar 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kV/hovMS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982F3F99F2
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774623013; cv=none; b=XBX5EXx8YXja0VVU8flhv5ix8Md3qaci3nEY3pDIXqKrHEoLqRXTV7/LW6+jUi/2BMuccIYFyujS82zAIZ8t/1v+/1nvHHZ/e+4wB5IZX3pQMpo6by8Dv4ZMy9/V0bA/HRYkGBn3LDKRSYI979ZmSIhr0gFyIgCOfBX8GCPyjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774623013; c=relaxed/simple;
	bh=xAhOeYYXubtgDlF/P+peMIoOJQXENx3wxOMpRauBpoo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owEjWRH5Taa5iGT1j7ox6gW/HKeupvaG8CCtKwehzRo4ef0E8ELAySmamuBcn/EOLiYKHT6BC2SRis5OLATEwQvH8M/lyDkUuuzB5v11bxHQePjvt2+7ATtd0IL2tloKzYHfLNwwiy2gtT7XEX07/gMKm/9H5S8f8D4in2g/DMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kV/hovMS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xAhOeYYXubtgDlF/P+peMIoOJQXENx3wxOMpRauBpoo=;
	t=1774623011; x=1775832611; b=kV/hovMSWsrYtpQXVMHEYoebGM8U9pAk8vR6Xew38uFUSjC
	JXw+R3ji7ZhbAy82XmahMb7XdrDvEjg67ffESur9bYGtzLrhRn+Mgx1iJst6VVJzXC9Ty6uutjJa+
	nn1LVVtDagN2RSW2SECQpDZjhnZR9UDJ0ojUXYw6YIyLWz1ifoQfPMknthGAfB91kvIczMYUC5LH8
	ROxrBCvOrQ/AVxRr9hLdllIkc837Q7ukMwd6quVsIBXECW9iuUKDQluiLk2KJaBeoieKApElh+w8n
	93lPKlNlxIjsIRhJhv5v5HhV8kFBj47hb1sIVsrRX4SQ1UsXYe3FtWJnJgWsvCgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w68Vk-0000000EKtU-3S2d;
	Fri, 27 Mar 2026 15:50:09 +0100
Message-ID: <8aa10ce1ed9da7409ade68d376a61f5e14c70219.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 08/19] wifi: mac80211: clean up STA NSS handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MG <pmartin-gomez@freebox.fr>, linux-wireless@vger.kernel.org
Date: Fri, 27 Mar 2026 15:50:08 +0100
In-Reply-To: <79228bab-aa6c-4fda-97c9-768b158dfa3a@freebox.fr> (sfid-20260327_132444_673524_537A049C)
References: <20260327093659.711584-21-johannes@sipsolutions.net>
	 <20260327103659.5296c2f3a949.I97fb93ccc1b366110ab23de58fcd73676cdd85d6@changeid>
	 <79228bab-aa6c-4fda-97c9-768b158dfa3a@freebox.fr>
	 (sfid-20260327_132444_673524_537A049C)
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34089-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AD1F346524
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-27 at 13:24 +0100, Pablo MG wrote:
> Hello,
>=20
> If we are doing some cleanup, let's go full on it.
>=20

No? You're sounding a lot like an LLM that really likes to comment on
code that's only moved...

I literally wrote:

>> Move ieee80211_sta_init_nss() from VHT code to station code,

so it wouldn't be a good idea to be changing it at the same time.

johannes

