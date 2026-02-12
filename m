Return-Path: <linux-wireless+bounces-31790-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id flK9OhIcjmmG/gAAu9opvQ
	(envelope-from <linux-wireless+bounces-31790-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 19:29:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 441FE13040A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 19:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF5D304C08C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC57267AF2;
	Thu, 12 Feb 2026 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gLTzeIKw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36931242D78
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920976; cv=none; b=pDKoqRcDVnXjKdZWZjFMKWsgzK6nRwG6MUGg9lvp9rhgaQbk/2MGEbqUGrFxseHXXRbP7CJttVzVhgs8ia3lycIAV5rxOxXIOzHF4mQQ0PFivKdxkBaB9rb2Y40KJpzPpteqfU7v87nPT/V0ydOjULVh/mVsVxN9a/2JWUW3eZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920976; c=relaxed/simple;
	bh=Dx2mtJ96lcO8Kk0cam68h5su84uGUvdZpDSVC6n0Ca4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=arn5zjx8qiJxiFX+cyBwjSK+lUhZOjtyg6EtAHfqSEeilQrvmwOz4aVUnkUiUTIcyqAevIaj5nW3Vl6YAHU8RqAt0wlAIJ9F7H20rGWDrFLkeC+e8/yxHWVlZxkgT65H034w4pCn3856Mh/eAvT4r6KnN10Q9zjshberX98LfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gLTzeIKw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Dx2mtJ96lcO8Kk0cam68h5su84uGUvdZpDSVC6n0Ca4=;
	t=1770920975; x=1772130575; b=gLTzeIKwsg0CtfsIRv0W8jX3CAvE3NXr9eceMDMfeTD5FAB
	jBiidQVUy5H3gjdgUgIHRY45qK60QaU8wyMpGU+6MO7BDR2SNXcO+dUii0JnDtwu1lG3A2exk+sB/
	SyhEaDQk8FKSduM8N9lpbO7pZS5tZ8hXs6DJW+zYONIjEJSAJvsDpKab444HQOzmL9+hNSVrx//UK
	T6sH3VE2CyFB5JICKmlWUkyDfn35ZfBpdHP7uOVM/3+GD8u/o6di9aGMpKJ+v+q+BipZXlqaQ6Y8S
	BsZk+PJ/b1aDjMn/t482PZocV4mxHEItmH3p6xR7L8Ui+UIsTvfpTKRffdYLqAAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vqbRT-00000006UcP-19cl;
	Thu, 12 Feb 2026 19:29:31 +0100
Message-ID: <bb793bdd1875840315ff92dbff3675117bf06842.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 00/02] wifi: ieee80211/mac80211: Add
 UHR (802.11bn) Capability and Operation parsing helpers
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Thu, 12 Feb 2026 19:29:30 +0100
In-Reply-To: <6e9ff54e-dc83-46ad-8415-5c950d6c4444@oss.qualcomm.com>
References: <20260212172401.234059-1-karthikeyan.kathirvel@oss.qualcomm.com>
	 <c9353b48d4efdcdfcd46553e83a8131869c08b49.camel@sipsolutions.net>
	 <6e9ff54e-dc83-46ad-8415-5c950d6c4444@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31790-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 441FE13040A
X-Rspamd-Action: no action

On Thu, 2026-02-12 at 23:13 +0530, Karthikeyan Kathirvel wrote:
>=20
> On 2/12/2026 11:06 PM, Johannes Berg wrote:
> > On Thu, 2026-02-12 at 22:53 +0530, Karthikeyan Kathirvel wrote:
> > > This series covers support for UHR capability and operation (11bn)
> > > parsing helpers for DPS/DBE/P-EDCA, and adds mac80211 hwsim changes.
> > >=20
> > > The code changes are based on the IEEE 802.11bn Draft P802.11bn/D1.3.
> > > There may be changes in the code to adopt upcoming 11bn spec changes.
> >=20
> > Indeed. I hear Qualcomm prefers 8 bits for the NPCA primary channel
> > rather than the 4 bits for the NPCA primary channel (offset) ;-)
> >=20
> Okay, I might missed any other thread if this is discussed, let me check

No no, that was a discussion with the spec folks!

johannes

