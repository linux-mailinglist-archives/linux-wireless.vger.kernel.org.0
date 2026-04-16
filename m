Return-Path: <linux-wireless+bounces-34894-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CY1KBbs4GnWnQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34894-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 16:03:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 379C140F527
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 16:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 855E3301704C
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC743D3331;
	Thu, 16 Apr 2026 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SeDKBEse"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379A3242BE
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347901; cv=none; b=PRbZUW3MMopcXCIQSf6jfYSZ1Yjl6WDw1AWCsZwJovOEhQuVPKCvmQUBvktiuzWE2gY6vdguYas3Wfo4+nvUMwghbc0/hhmYV7Vu20bCSLKdXNYraulBDrr510CUPiQ3Rd2z4XcPQaSM0mr7iqDeRRXO+YvfUltLDEicdNSteYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347901; c=relaxed/simple;
	bh=0WiFtOKpuH99v0rvFTLmKXdVBM+624SezYkHfxYddO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZUIDYWu4E5wvtg9uzYB1af1Z7R1R6ovYUJ9rOS0vi6KAaQNHH2NGvvxMR/F1wvrSGwO8WXnTZ/sxqzF70fJ/D33KmZfbBdqtGXimfYDbe1u7oekEV1uz5kTxEvDPrOJTzt13tB7LdjJe3izCg6Z5TH4UY6OoBntBjH7RTFS3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SeDKBEse; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=N2MrwBV/rH6Exc5owJwvCEcQKwqyvao5xljUA+tnxmY=;
	t=1776347897; x=1777557497; b=SeDKBEseJ8cOagmTtcvKK7pnvhQTRkI5YTdouja0O2PALE/
	8oB6Y7n6vcrP9SgJ7uNzBf71aO19KPyHdCZFMa9ngB6TVTKZPuT6rukly3rdRFhhQ6dr7RIcT6INd
	LnAFBwDDmtPn2lojYn0UwXxfD5hmo7ziMAVzwNkbImxr5hmGrbLzNShgT2ekVJm4jCCbzyrObgiec
	vxnFW3ISqQ4pZ2YE0Jg+gMo+TVYoG4b5BmiuDDa5aGdlUDlJ1zhHr0as5ZmTxl5Te4vKnenIJ6dSP
	HTCtf7Hhj7gV8F+2bSfQ2Ec6YvJgd49LqVNUrCGfXt5hX6x9nh4ZBQR2SjMHwmWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wDNEU-00000007TXm-3TDB;
	Thu, 16 Apr 2026 15:58:14 +0200
Message-ID: <49f35f3dfe84c564585bd3bc014a6931a7789624.camel@sipsolutions.net>
Subject: Re: Wi-Fi speeds degrade from 600Mps to 30Mps while using WPA2
 security, but not on open network, shortly after ISP firmware upgrade.
From: Johannes Berg <johannes@sipsolutions.net>
To: Benson Bear <benson.bear@gmail.com>, Pablo MARTIN-GOMEZ
 <pablomg@eskapa.be>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 16 Apr 2026 15:58:14 +0200
In-Reply-To: <CACM6vn7Dau9cX4tUCVQZmEpRmd7JiNtALUfR_fFARMbR_VZ_7A@mail.gmail.com>
References: 
	<CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
	 <b1a7678d-8e87-444e-b38a-bb7aedcd4f30@eskapa.be>
	 <CACM6vn6UXfSXw2WpYvzF+ODPGHw-LtsBMgtvc6n7s9iF9eaS6Q@mail.gmail.com>
	 <beee4be9-2bfc-4c38-ad1b-13ecc7d90aa3@eskapa.be>
	 <CACM6vn7Dau9cX4tUCVQZmEpRmd7JiNtALUfR_fFARMbR_VZ_7A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34894-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,eskapa.be];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 379C140F527
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-16 at 08:34 -0400, Benson Bear wrote:
>=20
> Thanks again.  Sadly it looks like linux (the wpa_supplicant) is
> in the wrong here, just reasoning about it.   I assume the AP
> always offers the option.   It doesn't get a rejection before it
> even makes an offer.   So that means when it offered it when
> PMF was not disabled in the client, the client must have
> accepted the offer.   Because we know in the other case,
> when PMF *is* disabled, that it works fine, which must mean
> the AP received correctly a rejection of the offer.  So had
> the client sent a rejection in the first case, like it did in the
> second, there is no reason the AP would not have accepted
> that rejection.  So the client must have sent an acceptance.

Doesn't mean they both negotiated the use correctly, or even encrypted
the frames correctly. Could even be that they both agreed on PMF, but
then the AP sent unencrypted AddBA request (or response, depending on
the direction) and the client dropped it, or any other weird things.

> Not iron clad, because maybe the AP is just plain crazy.

My bet would be on that but we'd have to see a sniffer capture. But in=20
general, we definitely know that PMF works with Linux/wpa_s and WiFi7
requires it, etc.

johannes

