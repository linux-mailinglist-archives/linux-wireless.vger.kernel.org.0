Return-Path: <linux-wireless+bounces-28471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B23C294D6
	for <lists+linux-wireless@lfdr.de>; Sun, 02 Nov 2025 19:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866A13AEAA8
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Nov 2025 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D484F70810;
	Sun,  2 Nov 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b="LU/JW8Wc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.bues.ch (bues.ch [116.203.120.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39A3B2A0
	for <linux-wireless@vger.kernel.org>; Sun,  2 Nov 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.120.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762107622; cv=none; b=uXzF+0Dl7XSGWhca2BAKUjU2x/bQ4Cj1QUlgCeaigtBNv+wyvwWy7HQ86dOaZ6LtcZPyzKJZ9nney+wzxQq5Bh7OXG+UQmCkrK4VUZyRbKHW5upqX4H+XeXBs/9+I9e6/dfRahdaoR7mYnFkFq1NcQSsBLcdGsx3q1xIsV5yQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762107622; c=relaxed/simple;
	bh=MpYicsu1cWamEcqCUbeSatdE5GzMhSpI/fix3zjI7Do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+UmXoIJz76ysFH5xRgsFVVgleGKL7nPy7SinMUA0ZN/HK06XiqpZ+vQNUH9iRA1KXY0C829IHG/GIBtZbB44syc6rYR1+smVL9VjIEaBJHzO4+kw6KxiZ9n/ZnlNdCyOlGl8F5cwgkDCKcS9My5E5NiP/SBSgA4Rvwd0YOEfyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b=LU/JW8Wc; arc=none smtp.client-ip=116.203.120.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Date: Sun, 2 Nov 2025 19:07:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bues.ch; s=main;
	t=1762107031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpYicsu1cWamEcqCUbeSatdE5GzMhSpI/fix3zjI7Do=;
	b=LU/JW8Wc6I6mSW/VJdhbQlJ07+RsBabnzdF94JJvT3g8Iu6ChASmPhXue0Z+jSV8cOU6fr
	BMRIF+LzdMK2fd/mxHG3wk9vkSLUFiBYB8ImVL4X1PdrH4hSZeQiPGAjuocpJ4Wa4ykJSy
	n9iTjCM75FCLIEf4Xz9hQMWX9sNZlh8Mov7HLNkSo78JXw5glAK/UAl17d22CIr/00Y3pr
	ye/xv+cIHxX9J+Q+1pQuxpdqjqBowljL1+bQdHDcx0sPFMkR8i3Z00f/kVBt7ZcINchuTk
	tAZ9NNNXGGaRp/PYAbTIR98UuoiQ3GagNJt2qVKbRBgmN+p/PN5h70clFR/ZkQ==
From: Michael =?UTF-8?B?QsO8c2No?= <mb@bues.ch>
To: "Zedequias Marin (DECO)" <dudecco@gmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Subject: Re: BCM4312 EEPROM corruption recovery help - HP Mini 110
 U98Z049.00
Message-ID: <20251102190715.317960fa@barney>
In-Reply-To: <CALaz+jkqX=JX5ODuSJTm0k_qokgYidQ5+Zu1vBuu-zmFZ6JWqQ@mail.gmail.com>
References: <CALaz+jkqX=JX5ODuSJTm0k_qokgYidQ5+Zu1vBuu-zmFZ6JWqQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//7Hj5KtT_B49Y1+2PMPTewt";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_//7Hj5KtT_B49Y1+2PMPTewt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Nov 2025 10:27:10 -0300
"Zedequias Marin (DECO)" <dudecco@gmail.com> wrote:

> I found your 2011 thread about BCM4312 issues and need help recovering
> from EEPROM corruption.
>=20
> My Device: HP Mini 110
> WiFi Card: Broadcom BCM4312 802.11b/g LP-PHY (14e4:4315)
> Subsystem: Hewlett-Packard Company U98Z049.00
>=20
> Problem: I corrupted the EEPROM while trying to configure as WiFi
> repeater. The card is detected but no wireless interface is created.
> EEPROM shows repetitive FF/3F patterns.
>=20
> Request: Could anyone provide a known good EEPROM dump for BCM4312
> (14e4:4315) specifically for HP Mini 110/U98Z049.00, or guidance on
> EEPROM recovery?
>=20
> I have EEPROM backups and can provide diagnostic info.

Hi,

the PCI ID (14e4:4315) is stored in the wireless device's serial EEPROM.
If the EEPROM is corrupted, you need to find out which PCI ID it uses now.
You can do that with lspci -nn.
Once you found out which corrupted PCI ID your device uses, you can registe=
r this
new PCI ID to the b43 driver via sysfs to recognize (see PCI/sysfs document=
ation).

Then the driver will recognize your device again and you can flash the orig=
inal
serial EEPROM to the device. See b43-tools/ssb_sprom documentation [1].

[1] https://github.com/mbuesch/b43-tools/tree/master/ssb_sprom

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_//7Hj5KtT_B49Y1+2PMPTewt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmkHndMACgkQ9TK+HZCN
iw7WNxAAqwQ/6lcqajfQmkthAZR7/cph0khJChpdhvDFvWt7R5cne6QjIiUZJJat
6OqdFGZFWOLkatjZoa7DdHaZY2Dmlr3DTVXqbaqIHojGPlKowVUPXdPYSR58jyTz
JkiFFTAAwm5PboUb1mLii7myvxbLavpTo78ICEAt1rzGwshKHtpJCfzB8/7U3oj0
zvVcVPyOjuIpoGUa7PRFdip5tROVka0oZVsMHTiYXh2G6j943kh+4PtvJefZli7e
Oo2db4p5UPt3CwqLgEqBqT8sHLe8AYdWm/7lDStDKq/ZOVy0Y2XBOfV4T7edUTWJ
829PZ9UT+olm1f0I1eVk5PaIx3DcueVT3Oo8p8MvswCj7oHOGrywb7WounPcvGUT
PYAZRwVpLw7h4glRZx69ZOvqVNUC1VdSI+XZ/grd9fcq9x+3XxTZ0ILSCHBXIn4p
OU6/1egUS/wdzfCxuZ+FxnsNSrLrmKl0nAQyr0/GxUZe4ENYIL2qQEk/QMXt8cEi
ONv516VFeTzI4F1drd1UWIfzCX9AvBHNWczAU37Q0F0qkW/2KumpoNK8wEy02418
CL4lvVaYOAHF2sXXd6G2Z24AHhOdvBNxFerRzFpjO5iBe3F6e4w6GWPIsZvkz4KR
MCZURdznzrmpJPguIsi/VLOH+jQs9cmQK+9B6dbmLTwQoUDiFKc=
=/HYr
-----END PGP SIGNATURE-----

--Sig_//7Hj5KtT_B49Y1+2PMPTewt--

