Return-Path: <linux-wireless+bounces-37300-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2CyWBrDaHmpHWQAAu9opvQ
	(envelope-from <linux-wireless+bounces-37300-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 15:29:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A13662E7D7
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 15:29:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=mdY+Wwjn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37300-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37300-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 690403047BEA
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7222133A711;
	Tue,  2 Jun 2026 13:26:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E923FC5A
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 13:26:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406810; cv=none; b=uFQGLbo2B5LQr29uFCH6eONM+66CaFUCOLDv2B9I0YYzMRMMdCdOZiMHYkh5tfz6nZUu8BA7YL4AOBtS2yWF5Omrre2WLZTWwXCmbawxo7pjCBWkEQlBKX0LdSa9egT6ybL8fjKtjqMD1HemTOetJKNbwCQcYkJG8/843VKcTHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406810; c=relaxed/simple;
	bh=1NzVwOCZLOeQDfq3sRmSsqsDTjhSdE6icNtDtqTrudI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sUpB5FpnhoZh5v/3MXvetsrqRGnbwOqJ+4ENNdmkGu+1GZBscWaJ9RDkd3fwmoCLuusldxNWhYrscJtPEUQFnbpClud3xAIoldmgkTJEiKsfdX/rKRpf+wgD+S8m3f3hGr8CLaQ1FN8G6LBzpdx1/R+dmw6sOBwJOyypoLSHKXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mdY+Wwjn; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1NzVwOCZLOeQDfq3sRmSsqsDTjhSdE6icNtDtqTrudI=;
	t=1780406808; x=1781616408; b=mdY+WwjndiD/NWPGa5Y+PYAs4Rva7dxQcL2f8uPFpmMBM8j
	RcRzJul4GXOzyperlElbIfC4D+jUxjihVw3ZQMJE3mVrzXM+Vh/0fDxAJRQYkTkxXuA45GtkrODdK
	Rqvftql5wS5dup0eAi1HpDLyS4BWx4N1P597qWaMaA9NL5xFsUq4oUOACycTPWJ5tKRuGhPpam+aa
	jiCpsrhwJ+GWuyTftBKx6KLaZUO3LA98XRa3HG4/yQV/eAdPiteTyMiVlCQXnawZSDto2Wykirw40
	+Z1RIQpWzzS6T23G86Q80s22m2US1TMFAr+n/ioNYgoumm8IT0oMKxBrGv9iZ/Og==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wUP8d-0000000FiT6-3FRY;
	Tue, 02 Jun 2026 15:26:35 +0200
Message-ID: <a1381c4a4c12eed998707cdf730b1b0c67f9a26e.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/1] wifi: mac80211: validate minstrel tx status rates
From: Johannes Berg <johannes@sipsolutions.net>
To: Ren Wei <n05ec@lzu.edu.cn>, linux-wireless@vger.kernel.org
Cc: nbd@openwrt.org, linville@tuxdriver.com, yuantan098@gmail.com, 
	zcliangcn@gmail.com, bird@lzu.edu.cn, xuyuqiabc@gmail.com
Date: Tue, 02 Jun 2026 15:26:34 +0200
In-Reply-To: <20260529143446.1374404-1-n05ec@lzu.edu.cn>
References: <20260529143446.1374404-1-n05ec@lzu.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37300-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-wireless@vger.kernel.org,m:nbd@openwrt.org,m:linville@tuxdriver.com,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:xuyuqiabc@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_CC(0.00)[openwrt.org,tuxdriver.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A13662E7D7

On Fri, 2026-05-29 at 22:34 +0800, Ren Wei wrote:
> From: Yuqi Xu <xuyuqiabc@gmail.com>
>=20
> minstrel_ht_tx_status() accepts both legacy tx status entries and
> rate_info-based status entries, then turns the reported HT/VHT rate
> into a minstrel group and rate index.
>=20
> The validation helpers only checked that the entry was present and had
> tries recorded. They did not verify that the reported HT stream count,
> VHT NSS, VHT bandwidth encoding, and MCS value were representable by
> minstrel_ht's rate tables. As a result, malformed tx status metadata
> could produce group or rate indices outside the tables that
> minstrel_ht_get_stats() and minstrel_ht_ri_get_stats() index.
>=20
> Teach the existing tx status validation path to enforce the exact
> constraints used by minstrel HT's tables for both status formats.
> Reject HT rates beyond the supported stream groups, and reject VHT
> rates with unsupported bandwidth encodings, invalid NSS values, or
> MCS values outside the table.
>=20
> This keeps the fix at the existing trust boundary and leaves the
> stats lookup path unchanged.

So ... I'm not really very happy with this.

First of all, I think it's kind of overblown with the CC stable etc.,
can you actually find a situation where a driver reports such a thing?

Secondly, I don't think it's the right place to be checking, we use the
data a lot for other things in status handling, and might expand that,
so it seems that instead of having specific checks for minstrel, we
should have most of the checks in general (e.g. nss=3D=3D0 is generally
invalid), and only have the things that matter for minstrel specifically
(say bandwidth) there - if those even matter, because surely we don't
expect a device that supports 80 MHz to start reporting 320 MHz, and if
that really seems important maybe we should just validate that elsewhere
as well.

But I also think that if this stuff really comes from firmware rather
than being built by the driver, it should be the driver's responsibility
to not report nonsense. I doubt we can protect against any driver
nonsense here in mac80211.

> Changes in v2:
> - shorten the subject line
> - align the From/Signed-off-by address
> - drop the Assisted-by tag

Why drop it now, when before you were saying it was?

johannes

