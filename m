Return-Path: <linux-wireless+bounces-35902-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNhoBH7o+WmsFAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35902-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 14:54:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C4A4CDFE7
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 14:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B24BB3020289
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 12:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B912426D35;
	Tue,  5 May 2026 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="x59l8Fe3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCAB382380
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984772; cv=none; b=C8S1CAums9UfHUvuz0pga+TQXmZK0ocqUtaqSleybv8T0r4t8I/lpCI4c0GoI9nRYY2xReNklVAziMZzaCw4RaE7yEvCP9hJAT0GfxnGXxYUlTByOQDiVhoa1WKoTF4TD6e4thydUqcJ0Uwci4HTAEKynJdkvu0bvsQpOgasAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984772; c=relaxed/simple;
	bh=EAom2s4zuvb5XPaYVAOirh9VYAQPLusGHolmgQY7FM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lUakMikHSsiKFHDcIa47DsmeAOptM6MAWb7staqlXmZ/TjBMcRH96xLcisLc//PoV+t/P6D3kVU+TT1UiFVup+uTyRXKfNa1HBWjDUkopkPV7ABMhxZyUdqzrmNr63FO07M5ju0uDDZOj5o4f4PPwtncjn8ajcDYqg5YLxEwipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=x59l8Fe3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EAom2s4zuvb5XPaYVAOirh9VYAQPLusGHolmgQY7FM0=;
	t=1777984770; x=1779194370; b=x59l8Fe3GlsD+g9HaZNSmOqP0a4sHsBWrgsx52eWJJkEwrb
	vk1FDvzSr2iapE1shlyw9FVcLqxhRJQaOMEdVkKRFm5HMv6Z1FATybSgVre8unUe63udzR1vF3FTo
	tzuGTXu+3wUsQkRE0twaCkdNyfSKTiFDppjYrmNHRlf12bdk3FQ/SckDb/AxfIEqWyKA0vUnECMit
	FhgVucCXjDb/EMwzC3OEuZqIMOFn2uiPr1N49ZaLgM89IEt2TB491mG5sb9msCrN0W7MyASqp5XUu
	tzvUJ2QU2CRvROl9+3zLlFTYVzZ0m7j6DLyutHD4A0uqLqYjh3Y5u02GbKO5leUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKF3f-0000000GBLM-0xsg;
	Tue, 05 May 2026 14:39:27 +0200
Message-ID: <ffd01c8f9621bdb561e8d39a7c33296fa9bcb2db.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 2/4] wifi: cfg80211/nl80211: rename to
 probe_peer(), extend probe status, and update in-tree users
From: Johannes Berg <johannes@sipsolutions.net>
To: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Date: Tue, 05 May 2026 14:39:26 +0200
In-Reply-To: <20260417133124.3412752-3-pritiwa@qti.qualcomm.com>
References: <20260417133124.3412752-1-pritiwa@qti.qualcomm.com>
	 <20260417133124.3412752-3-pritiwa@qti.qualcomm.com>
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
X-Rspamd-Queue-Id: 32C4A4CDFE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35902-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

Your subject lines are way too long, you really don't need to spell out
everything, and if there's a list of things, probably better to break
into multiple patches.

> Update in-tree users (wil6210, mwifiex) and mac80211 so the tree continue=
s
> to build after this change.

That's also pretty obvious.

> mac80211 switches cfg80211_ops to .probe_peer and passes link_id =3D -1
> at the probe status callsite to preserve existing behavior.
>=20
> This change is otherwise behavior-neutral, per-link STA reporting will
> follow in a subsequent patch.

I think you really should split this differently - perhaps first an
internal API change, that just does all the renaming, then the actual
logic change including the nl80211 API, and finally the mac80211
implementation?

johannes

