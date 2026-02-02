Return-Path: <linux-wireless+bounces-31453-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLaACJOHgGnO9wIAu9opvQ
	(envelope-from <linux-wireless+bounces-31453-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 12:16:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3D1CB89F
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 12:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13CA1301052A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9539523D7FC;
	Mon,  2 Feb 2026 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OIW1QA5K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF31B4F1F
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030800; cv=none; b=B+eC5DEXNDnUzc7EFgl9KPBZKrk/koTV55/Nz3GdNQVwRt7ML06LU8U3HJi5OHW4iA8BqJIzhYTGYfbSLpb7gijiDWELhxHLbwMXpLqY0AbaB6U4M/iqR6V9pwDrG1kZq8bo5TrKbaLCweLxFt6OQq/UKcZFILwwvopD+uuzSZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030800; c=relaxed/simple;
	bh=13JRXbCBOouOG3nPyRziW/7H6iUFOSglWlAsmUUzjDM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GHe7piRA7bhW9su+SY9iuTDBBxWwk60PuBLK1mHgkmuhe6iDnBgQs5aOoH+4sx+aszL0M3f1TMy3Rks1hHE3O6w2hxGhulWWDrNSdjaQBxPm33lJ6vTgJMa+VwRu1cSZu/wwqpwyekfekaUfkCa0fGu5lPuxZ2Ga0z4HiQ7eCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OIW1QA5K; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=13JRXbCBOouOG3nPyRziW/7H6iUFOSglWlAsmUUzjDM=;
	t=1770030799; x=1771240399; b=OIW1QA5KB8sAeILkmzCt5OMttSWRjGp1FH0foulK3oGUVrt
	kr7sRrgT+n/cwKiAHM4ZzuoPFOewfz1nPjcJWZWY8Otntq3qf656D4fC0bDkcJpRYNA2LK0B2YUlQ
	IrF6MuJO+kvYFsoIeTXKmXRpOxz32y8IrhB7MiZd+2BvSwwyYB9qVGs0LTKhsLlXMp7207FufuNlY
	vq4CJmMsQIqfG37cZAq3UCO/ESaMlfNB/GuQaCCe/lC5HYxLtHnCKv9yKSxHDMU0TxlYz54ZqfzzQ
	pMZo4hQfJwjJFMdl9vT58q6a8/RAVkHNJlQgGx3akTIEvSEGqX0GCaEOd8SWewsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vmrro-0000000BVhf-2gF9;
	Mon, 02 Feb 2026 12:13:16 +0100
Message-ID: <e9d9ad7a197cee9cb8c825a3292a70e934acbfea.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 0/3] wifi: initial UHR support
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, 
	linux-wireless@vger.kernel.org
Date: Mon, 02 Feb 2026 12:13:16 +0100
In-Reply-To: <87aaabdd-1c21-4b18-9650-a3b4c2618538@freebox.fr> (sfid-20260202_112757_645065_404FFA12)
References: <20260130154259.265130-5-johannes@sipsolutions.net>
	 <87aaabdd-1c21-4b18-9650-a3b4c2618538@freebox.fr>
	 (sfid-20260202_112757_645065_404FFA12)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31453-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6E3D1CB89F
X-Rspamd-Action: no action

On Mon, 2026-02-02 at 11:27 +0100, Pablo MARTIN-GOMEZ wrote:
> On 30/01/2026 16:21, Johannes Berg wrote:
> > Should probably just not be trying to do this while I have a fever...
> >=20
> > Maybe this one's going to be the last respin despite that.
> >=20
> > FWIW, I'm also working on further NPCA support, both rudimentary AP
> > (just configuration of the NPCA chandef) and non-AP side. But I'm
> > not going to post _that_ until I get through my fever ;-)
> >=20
> > johannes
> >=20
> Look good to me, but I don't feel I have the sufficient knowledge to=20
> either the standard or mac80211 to warrant a Reviewed-by or an Ack-by.

Thanks :)

johannes

