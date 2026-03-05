Return-Path: <linux-wireless+bounces-32575-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOVVFgsbqmkqLQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32575-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 01:08:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87784219B3C
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 01:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E14D6300A39C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 00:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C32248A5;
	Fri,  6 Mar 2026 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.gov.in header.i=gaurav.kansal@nic.gov.in header.b="I7BP6m/Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender1-o42.mgovcloud.in (sender1-o42.mgovcloud.in [169.148.143.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA29221F1F
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.148.143.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755657; cv=none; b=XbhuN7e7HY4iMWqX0VgLC1gSaLPKZSTavU2kFQt+hXuRFNDX4SURv0KOpUmKHr6+r4oeVJUCscaQC4IR4kG0D/TUtt28sAGhEJEFsRA6gAdXUszaYaTqoKyN9psidPSxx6buazHFh5QIGIRi15llIYzzxdNLdQU4swyNwp5pICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755657; c=relaxed/simple;
	bh=2GtZQG3/V4b2MFfRGcmpRuUxPXMfZ/UMxx9MN1CqJio=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PFrJLIfrhetPk/cQlF5pPMV869ns9ExvmS1QLN/iYQY6I5x/YzyQ/0O272C+dSczgRTZnm2ltidWO6eDmy07pRdpAuMWPekYNpsWVJn+yvDiWxhMSwPh/XZfgKTdp5KeixCg6GeIaW59AK8NFTJeZZbWoQZ7FnCI8yWSxh31dQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.gov.in; spf=pass smtp.mailfrom=nic.gov.in; dkim=pass (1024-bit key) header.d=nic.gov.in header.i=gaurav.kansal@nic.gov.in header.b=I7BP6m/Y; arc=none smtp.client-ip=169.148.143.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.gov.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic.gov.in
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772684423;
	s=zmail; d=nic.gov.in; i=gaurav.kansal@nic.gov.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=271up09E33xh6e9w6ywwlZ5NW0fqvwtVXEOhmFisBvU=;
	b=I7BP6m/YNpRa3D8fe4dewr8C/p3GUQ8pLfKjAJrpAlbeIKdiqV/zElPUTESVnRZn
	VGzzvC/1SLtURVEppD3qjYLYfJ6tGwa5jJ4YUz/ls0vtISFvM9ZnDUvPBkDavITzVbE
	pweKN1Mv7CTqu2SW9L94L3SyU9XzYMWPMOSkANZ0=
Received: from mail.mniccloud.in by mx.mniccloud.in
	with SMTP id 1772684421910189.91557632018907; Thu, 5 Mar 2026 09:50:21 +0530 (IST)
Date: Thu, 05 Mar 2026 09:50:21 +0530
From: Gaurav Kansal <gaurav.kansal@nic.gov.in>
To: "wens" <wens@kernel.org>
Cc: "Degrader Snehil" <degradersnehil@gmail.com>,
	"linux-wireless" <linux-wireless@vger.kernel.org>,
	"wireless-regdb" <wireless-regdb@lists.infradead.org>
Message-ID: <19cbc39a90e.1cd9982953056.6486968654066866605@nic.gov.in>
In-Reply-To: <CAGb2v6617V-jLnLrBYEZfSiv-2c8QsN2HMCmQbaXdm9NVwGGEA@mail.gmail.com>
References: <CADqxL9qYq_+8dPgXj5i_HjkpTOZwiAawsa90tNbA4Q87ZhCrSA@mail.gmail.com> <CAGb2v6617V-jLnLrBYEZfSiv-2c8QsN2HMCmQbaXdm9NVwGGEA@mail.gmail.com>
Subject: Re: wireless-regdb: Update IN regulatory domain for lower 6 GHz
 (5925-6425 MHz)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: MGov Mail
X-Mailer: MGov Mail
X-Rspamd-Queue-Id: 87784219B3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-32575-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nic.gov.in:?];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_DNSFAIL(0.00)[nic.gov.in : server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kansal@nic.gov.in,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.942];
	R_DKIM_TEMPFAIL(0.00)[nic.gov.in:s=zmail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,nic.gov.in:mid]
X-Rspamd-Action: no action

Hi ChenYu,

Didn't the information is already merged as per my last patch submission?

Regards,
Gaurav Kansal




From: Chen-Yu Tsai <wens@kernel.org>
To: "Degrader Snehil"<degradersnehil@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "wireless-regdb"<wireless-regdb@lists=
.infradead.org>
Date: Thu, 05 Mar 2026 09:08:56 +0530
Subject: Re: wireless-regdb: Update IN regulatory domain for lower 6 GHz (5=
925-6425 MHz)

 > Hi,=20
 > =20
 > On Thu, Mar 5, 2026 at 3:16=E2=80=AFAM Degrader Snehil <degradersnehil@g=
mail.com> wrote:=20
 > >=20
 > > Hi,=20
 > >=20
 > > I would like to request an update to the IN (India) regulatory domain =
in wireless-regdb to add the newly permitted lower 6 GHz band (5925=E2=80=
=936425 MHz).=20
 > =20
 > Thank you for the information. Would you like to provide a patch?=20
 > If not, I can write up a patch and tag you as the reporter.=20
 > =20
 > > The Government of India has officially opened this band for licence-ex=
empt use via Gazette Notification G.S.R. 47(E), dated January 20, 2026, pub=
lished January 21, 2026, issued by the Ministry of Communications under the=
 Indian Telegraph Act, 1885 and the Indian Wireless Telegraphy Act, 1933.=
=20
 > >=20
 > > Gazette details:=20
 > >   Title   : Use of Low Power and Very Low Power Wireless Access System=
=20
 > >             including Radio Local Area Network in Lower 6 GHz Band=20
 > >             (Exemption from Licensing Requirement) Rules, 2026=20
 > >   File No : 24-04/2025-UBB=20
 > >   Gazette : No. 47, CG-DL-E-21012026-269488=20
 > >   Signed  : Devendra Kumar Rai, Joint Secretary, Ministry of Communica=
tions=20
 > >   URL : https://www.dot.gov.in/static/uploads/2026/02/88f0ac8c74eb6f69=
07934d17d0015ab5.pdf=20
 > > The Gazette defines two device classes for 5925=E2=80=936425 MHz:=20
 > >=20
 > >   1. Low power indoor=20
 > >      - Max EIRP         : 30 dBm=20
 > >      - Max PSD          : 11 dBm/MHz=20
 > >      - Max bandwidth    : 320 MHz=20
 > >      - Restriction      : Indoor use only (Rule 5)=20
 > >=20
 > >   2. Very low power outdoor=20
 > >      - Max EIRP         : 14 dBm=20
 > >      - Max PSD          : 1 dBm/MHz=20
 > >      - Max bandwidth    : 320 MHz=20
 > >      - Restriction      : None=20
 > >=20
 > > Additional operational restrictions per Rule 5 of the Gazette:=20
 > >   - Band is prohibited on oil platforms=20
 > >   - Indoor use prohibited on land vehicles, boats and aircraft below 1=
0,000 ft=20
 > >   - Communication with and control of drones/UAS is prohibited=20
 > >   - Contention-based protocol is mandatory for all devices (Rule 4)=20
 > >=20
 > > Out-of-band emission limit: -27 dBm/MHz outside 5925=E2=80=936425 MHz =
(Rule 6)=20
 > >=20
 > > Proposed addition to the existing country IN entry in db.txt:=20
 > >=20
 > >   country IN:=20
 > >           (2402 - 2482 @ 40), (30)=20
 > >           (5150 - 5250 @ 80), (30)=20
 > >           (5250 - 5350 @ 80), (24), DFS=20
 > >           (5470 - 5725 @ 160), (24), DFS=20
 > >           (5725 - 5875 @ 80), (30)=20
 > >           (5925 - 6425 @ 320), (30), NO-OUTDOOR   # low power indoor=
=20
 > >           (5925 - 6425 @ 320), (14)               # very low power out=
door=20
 > >=20
 > > Note: Since both device classes share the same frequency range but hav=
e different EIRP limits and indoor/outdoor restrictions, I have represented=
 them as two separate lines. Please advise if a different encoding is more =
appropriate.=20
 > =20
 > Unfortunately we currently only support one rule per band. I'm inclined=
=20
 > to add the VLP one so outdoor usage is allowed.=20
 > =20
 > > I have attached the official Gazette notification PDF as supporting ev=
idence.=20
 > >=20
 > > Intel has also submitted a related update (Intel=C2=AE Wireless Wi-Fi =
Drivers 24.20.2) for this band for India. I am not certain whether that pat=
ch covers wireless-regdb (db.txt) or only their iwlwifi driver internals, s=
o I am submitting this request for wireless-regdb independently to ensure t=
he authoritative database is updated.=20
 > =20
 > AFAIK Intel manages regulatory requirements in their firmware, so it is=
=20
 > unrelated to the database we maintain.=20
 > =20
 > > Intel's Regulatory Domain Info was found in Release notes of their  In=
tel=C2=AE Wireless Wi-Fi Drivers 24.20.2 available at page 2 of https://dow=
nloadmirror.intel.com/914148/ReleaseNotes_WiFi_24.20.2.pdf.=20
 > > Please let me know if any further information is needed.=20
 > =20
 > The information you provided is very detailed. Thanks!=20
 > =20
 > =20
 > ChenYu=20
 > =20
 >=20


