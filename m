Return-Path: <linux-wireless+bounces-34805-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AvlJiiz32lCXwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34805-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:47:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8CD406143
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16E5C30B764F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5102A3DC4C1;
	Wed, 15 Apr 2026 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="I/K6qWP/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C73D3D1C
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267738; cv=none; b=SI/Oc2pd1YYokVjc4LVvFuB/Xn7B9+EdCia89AVGQTtnrVWPftx8QBYoyTSOWTd04ajbGYCq73ie0uurf6+wF2a3LViOmNp/YOMBAc1sxkatUHdxj37CHDVsgTMB3YGu3JUyvhJVT4ug4IRmffV2cX1TSGAkPxsgJ7EdgsdXk2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267738; c=relaxed/simple;
	bh=8lgbw1IAkZXSUg0Tw95Joz3uDO++LhjIaHZj407TJ5k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nVeFhGZeXZ5lTdo3mVax2UhGmdtBDNYdlcreA4K0ZTjMU83OU2VlCLtrWUv+3RkzpH7gbt0eVivS4op4nMXqK2TrWgdWwMMuKXV/No1YuHHWYX2cn+elHdXd+NZKUvwUUqA74qfJDHNNK25l8XymZnq+PKuAk3bfST5JZDtrN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=I/K6qWP/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UYqdouJV//K94E6Ox7PhFl2mIGqgBUjekCQLdPPwVPM=;
	t=1776267737; x=1777477337; b=I/K6qWP/mV15A7uCA2BxmGYkIuq9kZzN631gw6KtpjpuVfN
	SILC+GmKO/6r7BjxywnZcxZRp0SB12QyIhdzPTlHwXd3qEY+P8fK8qOavTMjWouJ1KEy25NNTnY64
	pWo3AzTUcj4oEcQArLRIiZ4rhQ2vmyLfxua54O9HHPwCjGMeXS3+5DcNk1gOAvY021qpNoMFmB7Uk
	I+V7hjxAObyG7EJpmfqy2hEcL4xo9Y/TuIqjV3TvN6O71Qat3edXbiZrUCZH85LYmozyx3ihRhjDk
	3jEx7a5n8SuUra7pWr8TLPdt2GvYGasYwJ/9xBjl/kJQe73bONtE+eIv8dSvmyOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wD2NZ-00000006UWV-42MO;
	Wed, 15 Apr 2026 17:42:14 +0200
Message-ID: <73562d420ffab279827127825bbdbc064ed34bfd.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: radiotap: add definitions for the
 new UHR TLVs
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org
Date: Wed, 15 Apr 2026 17:42:13 +0200
In-Reply-To: <d0144694-13b9-4d6c-9a6b-59d41a9562bf@freebox.fr> (sfid-20260415_171026_955369_4ECEEA2E)
References: 
	<20260412152605.73e682d0c8c3.I5a0c858467c852b7a2a00f580bd073af29c37705@changeid>
	 <e3af2190-3941-4ec8-9c59-91eafc6eb156@freebox.fr>
	 <60e2d9cdb781ad0bed35ef664f7d63dfc49fb9eb.camel@sipsolutions.net>
	 <d0144694-13b9-4d6c-9a6b-59d41a9562bf@freebox.fr>
	 (sfid-20260415_171026_955369_4ECEEA2E)
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34805-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 0A8CD406143
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-15 at 17:10 +0200, Pablo MARTIN-GOMEZ wrote:
> On 15/04/2026 16:54, Johannes Berg wrote:
> > On Wed, 2026-04-15 at 15:27 +0200, Pablo MARTIN-GOMEZ wrote:
> > >=20
> > > > +	IEEE80211_RADIOTAP_UHR_ELR =3D 37,
> > > > +	IEEE80211_RADIOTAP_UHR =3D 38,
> > > Why are the values 37 and 38 but below in the doc 35 and 38?
> >=20
> > The doc doesn't even exist yet as you say? Other things are being
> > assigned to 35/36.
> I wasn't clear, I didn't mean the doc like the actual documentation but
> the code comments that are used to document the defined value, e.g.
> `ieee80211_radiotap_uhr_elr - content of UHR-ELR TLV (type 35)`, it
> should be `type 37`, no?

Ah! That would be due to last minute renumbering here, indeed it should.

> Just the little brain of mine that likes when things follow expected
> patterns :) But more seriously, given that I didn't have access to the
> specs, the only thing I could use that could point out an issue was
> comparing to the patterns of existing fields and matching `known` fields
> with `data` fields.
>=20

Sure, fair. I don't really remember, I do remember mostly copying from
EHT (it is necessarily similar since UHR doesn't really even define its
own MCS set etc.), and then filling in the remainder in reserved (or no
longer used) bits...

johannes

