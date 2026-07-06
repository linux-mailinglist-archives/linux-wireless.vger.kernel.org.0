Return-Path: <linux-wireless+bounces-38671-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ousPEP2PS2pIVgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38671-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:22:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0BE70FC8B
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:22:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=QVZw1nVN;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38671-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38671-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99E753122B9C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16E93A4535;
	Mon,  6 Jul 2026 10:37:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55F3AFAE0;
	Mon,  6 Jul 2026 10:37:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334268; cv=none; b=aAMnBfmCGCU6qIiOrDTaI9n0Es0GGwJZ+icS3dOnPPzJ369sFOmZxoCJHHmpTriWViA98TlIs9ytydNXA+QkcskfiTtl62fpVbyJcErJ39YeFfeNntOiko12kdn8HgVYlY+/TUdIlmSkeJisMdrQocsIHnGhTaxtil/36jXWkt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334268; c=relaxed/simple;
	bh=70DB+crKdAn5t3MarAwEHdKaAEIJV+wYO9z148L6D8k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZVCXp/ftSIV7s7YuI78Fjhr+Vnz3QDp61Dh3Fza25lteYMC7StW2+uqeoGk/+fvRgsGfq0eDgfumltEbwsUMWL6aA6g1MU2rG0R8fq1AnF99T71NLC0BEEc8YnmD0QTwtG5kcRuY7mffk8CSEhe+g0vn2J+YJQ34Usg3GCkPIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QVZw1nVN; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cTKHlkUlKyFrya+FhJXp8WuW7bCMIJ+/sIackbjAeqY=;
	t=1783334267; x=1784543867; b=QVZw1nVNE4SdXsCCeRK1VaN3HubJ19HemlDf/Dy6I/Vgx5z
	gPKMh22jneash+lq00haIxNWqDnxHueQFHplUNogD5GOhxPdOWmIHUDoOd4DaeN1WFEmn74EspxbJ
	gWrN9i8yG1I9VHeILA10WfD3yjDjtdmOR1CwM9K+IwbGtylz5lwgaTHQ2Y8o3BcOCRFO1TiNlJ/Ii
	nVOTYEmFMBDESg3AtZWbkLhqgfgfCmH7HmSbSdEYJKQC3PUTMdnusPS+Rj7lInh1cqnL+a7A8yJlL
	hmu36e9+deLxrynQglekD25/CbcsGRSTrpt4/Nb/JWb04clMMTE3ij6MYjk77WUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wgghs-0000000D61z-2zyu;
	Mon, 06 Jul 2026 12:37:44 +0200
Message-ID: <488ed9862d5196b8f5ecf23f037fa6725fbe9a52.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] wifi: cfg80211: validate rx/tx MLME callback frame
 lengths before access
From: Johannes Berg <johannes@sipsolutions.net>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 12:37:44 +0200
In-Reply-To: <20260612185042.66260-4-enderaoelyther@gmail.com>
References: <20260612185042.66260-4-enderaoelyther@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:enderaoelyther@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38671-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A0BE70FC8B

On Sat, 2026-06-13 at 02:50 +0800, Zhao Li wrote:
> cfg80211_rx_mlme_mgmt() and cfg80211_tx_mlme_mgmt() read the frame
> control field without first checking len >=3D 2, then dispatch into
> subtype handlers that assume their fixed fields are present.
>=20
> Add a frame-control length gate, then validate each subtype's minimum
> frame size in an if/else-if chain that mirrors the dispatch logic.
> Trace only after the frame is known to be well-formed.
>=20
> Side effects of this change:
>  - The WARN_ON(len < 2) is replaced by a silent early return, since
>    these cfg80211 callbacks can legitimately receive short frames from
>    drivers.

Can they? How?

johannes

