Return-Path: <linux-wireless+bounces-33480-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB/9Br7cu2kmpQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33480-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 12:23:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C53B2CA3FD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 12:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 281153025D24
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122A3C8709;
	Thu, 19 Mar 2026 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Kqu7zCwV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B6366DD6;
	Thu, 19 Mar 2026 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919387; cv=none; b=S7WQQcmhTlQSybAJHRRK/rHyFAKmaHNZDWa3n9QtrEuWJMMrlREpLHXcNplyGR0ujoTl4US1/uYS9KC23rGqpNuCxQXCnb7YmruZBqsknDMjV9aGEL7HY+h8jhlqC6Z37GHPgdCSs53QFDA0QWdIXhtLJYFfiYbe2bT2wM15JmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919387; c=relaxed/simple;
	bh=GieeL4JhntlKNACmxsTYTav1MpGtykBADLmttEp2Hno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIWGsaoRUEFi1OEyyKPzYW1ri9il2ycTHzL9gnsWcwofz03BckcZxgt7eU3Zt1NdY4T0W6YjXykfOgh5zs2HC5Ex+TITJMkY5nQ1gmS1c+sKjq+zNaO+Oglfq86yt7AvOon/FM3cW5AQwIuQmb3gs6QmflD8+2N0iBwLXMUnCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Kqu7zCwV; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GQvd2yklJJIdCH/QJ+XUCMsMQRENNhVBNQBm6KsPwYU=; b=Kqu7zCwVhpo3Nzjhnm7TBvBDWq
	dfpR4D8p+17PikIkw0V5kXmEhTo5ZDE0Mr8r5UCikYjiqFtqKT8QyPI7nvy0ejpCI7kSbTwWfb2Qz
	Ihrx+Wi91Ze6pgEi1GdB4xiCPZ7dYIUlcDauUpnc+L9M+z9CZgSogY/yQ8vCmOKIt4/anB0s9ERj5
	v+qEH3tdScsrFqBf2nc4VCR4XZHXUK+vtTD8tce19D3EIBS/9pP/H90FO1SiCbDL5MLWmtr9tHND+
	je9v8sGy/YawL9ojgzHeZ07TeDTt/DWEpHY4j6W5gHVtORSZR5IwSGt+ZKKMRZnUo1GEmHrrwlpyd
	7AUcViUA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1w3BSw-000J5D-2Y;
	Thu, 19 Mar 2026 12:23:02 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1w3BSw-0003zm-0g;
	Thu, 19 Mar 2026 12:23:02 +0100
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] wifi: brcmfmac: silence warning for non-existent,
 optional firmware
Date: Thu, 19 Mar 2026 12:23:01 +0100
Message-ID: <2405698.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <48BB2A8D-D969-4686-9B30-11331FB14C56@gmail.com>
References:
 <20260317111202.1074675-1-alexander.stein@ew.tq-group.com>
 <48BB2A8D-D969-4686-9B30-11331FB14C56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5059167.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27945/Thu Mar 19 07:24:38 2026)
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-33480-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ew.tq-group.com:dkim,sh-git:email]
X-Rspamd-Queue-Id: 6C53B2CA3FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--nextPart5059167.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Christian Hewitt <christianshewitt@gmail.com>
Date: Thu, 19 Mar 2026 12:23:01 +0100
Message-ID: <2405698.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <48BB2A8D-D969-4686-9B30-11331FB14C56@gmail.com>
MIME-Version: 1.0

Hi,

Am Mittwoch, 18. M=C3=A4rz 2026, 08:42:55 CET schrieb Christian Hewitt:
> > On 17 Mar 2026, at 3:12=E2=80=AFpm, Alexander Stein <alexander.stein@ew=
=2Etq-group.com> wrote:
> >=20
> > The driver tries to load optional firmware files, specific to
> > the actual board compatible. These might not exist resulting in a warni=
ng
> > like this:
> > brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfmac4373-sdio.t=
q,imx93-tqma9352-mba93xxla-mini.bin failed with error -2
> >=20
> > Silence this by using firmware_request_nowait_nowarn() for all firmware
> > loads which use brcmf_fw_request_done_alt_path() as callback. This one
> > handles optional firmware files.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20
> On behalf of all distro maintainers receiving end-user issue reports
> that wrongly finger-point to =E2=80=9Cmissing firmware=E2=80=9D as the ca=
use of all
> brcmfmac wifi problems:
>=20
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>

Thanks.

> Before and After below:
>=20
> VIM1S:~ # dmesg | grep brcmfmac
> [   12.687679] brcmfmac: F1 signature read @0x18000000=3D0x15294345
> [   12.727469] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43456=
=2Dsdio for chip BCM4345/9
> [   12.727947] brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfm=
ac43456-sdio.khadas,vim1s.bin failed with error -2
> [   12.813544] brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfm=
ac43456-sdio.clm_blob failed with error -2
> [   13.157373] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available =
(err=3D-2), device may have limited channels available
> [   13.157423] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob availa=
ble (err=3D-2)
> [   13.159391] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/9 wl0: =
Jun 16 2017 12:38:26 version 7.45.96.2 (66c4e21@sh-git) (r) FWID 01-1813af84
>=20
> VIM1S:~ # dmesg | grep brcmfmac
> [   12.218764] brcmfmac: F1 signature read @0x18000000=3D0x15294345
> [   12.283612] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43456=
=2Dsdio for chip BCM4345/9
> [   12.382176] brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfm=
ac43456-sdio.clm_blob failed with error -2
> [   12.678015] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available =
(err=3D-2), device may have limited channels available
> [   12.678066] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob availa=
ble (err=3D-2)
> [   12.680092] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/9 wl0: =
Jun 16 2017 12:38:26 version 7.45.96.2 (66c4e21@sh-git) (r) FWID 01-1813af84
>=20
> Is there any chance the same change can be done for the clm_blob and
> txcap_blob error messages? (for the same reason). Other than for RPi
> boards I=E2=80=99ve never seen these files available and used with any la=
rge
> scale Linux distro and there are none in the upstream linux-firmware
> repo; thus these files are only being packaged by specialist distros
> or images targeting a specific or limited set of hardware devices. For
> everyone else running a mainstream distro image these errors are just
> log-noise, and while they are harmless and technically correct, end-
> users constantly misinterpret them.

Well, my platform doesn't generate errors/warnings for clm_blob and
txcap_blob, so I don't know which code path triffers them, nor car I test
them.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/
--nextPart5059167.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEByESxqszIvkmWRwbaS+g2M0Z/iUFAmm73JUACgkQaS+g2M0Z
/iXtnwgAvlMqRGgxgk+/Za0i2+OgonH4eSoNeomDzyC8MUKwMXtqBwYq/ri9IDPq
6dgeZtXjtzJAdOzfZxNYmifZEkGNOyyTOGcKCeDHCGdt8mNtoKS5gUFNvbdRP34D
gjIwNSKSw4lkCP6MK1Q/93s+tH8ugyrUvfk2PKRi/KIjcq/UKmwGgRol56nRywy8
4zWJuA9cd/SahPR8lyu6u+6HSxQL6z5ZCkSDUcI1DFGE/Ydxsby3TF6hwx/hPKWS
uDDCeiL0fdzddPgOymdhiaQQ49rUyev6tMNSnsuI32D/YyD9Bisjqk0nspWK16P4
QSv8RSJzSp0IjGdrXmssQAzZKPTYsg==
=eB2H
-----END PGP SIGNATURE-----

--nextPart5059167.GXAFRqVoOG--




