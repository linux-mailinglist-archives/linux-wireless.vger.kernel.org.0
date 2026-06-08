Return-Path: <linux-wireless+bounces-37543-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v3f9B+kvJ2qAtAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37543-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 23:11:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F37965A9F3
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 23:11:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RTFDiFny;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37543-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37543-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B79E302813F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 21:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74F3395266;
	Mon,  8 Jun 2026 21:11:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD4313E29
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 21:10:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953061; cv=pass; b=tucOEGoWYI39LDi5XroElJ1+SECburTtELf/rROeM2gTVoxvE98HM4pov1F8mCbzZKwpV63+pOGtic2Vt0sciLxn9i8X2p7EkUOWNs3bU3v1z2Q5ZUi/YFWUrmM6JKXVXhfzjET4gVIkRyPlJQP3kSWz7bi9Q3Xj9ZbzbvLCEb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953061; c=relaxed/simple;
	bh=fogdrJMfHTS0O/aUaMlx3xYV9SSrJIQT8ew4xn0HZpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZnjVlvE0dGGBe1RY2DSORdsh+1qNNlr4s43QJ0dwNe5Vqq5qR99kmoWRlXirWkgbeLacF4HA9xsugo2X2WGW03jzpc5HlVtrQhZlsc6mT7m4KtGXhUuNNR8BLuOM1as29VY3qllK6NUXYrLqB8MzG40svwSJnPgmxJ3pnQzamw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTFDiFny; arc=pass smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176fc0cc72so49846531cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 14:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780953059; cv=none;
        d=google.com; s=arc-20240605;
        b=bgTMYew5ySEOxtaFDgXdsXc5RNiqMxiZB4chNLsZb4+3V0o3DX/ofYv2IsAf7Tus42
         XE+Lph2nqvhamUx9rXTfPhfJcgth5icUqQwr/B5mVQIJ6+BepOEBX49tSBriLZDWGF+m
         9shQFDlyJ28eRxKL0gV6xPMrz4mSz7eavNI1rDpF4z2LEkQMVjW59JD9TtNheS6cifGT
         WrdK/DAX6WZxbnZKm2MO6F8rbC5yHMYw71hyZsonWa+2ht2bpi9jUXdROIHyhnAtVosi
         36PMtPk5GY5hGJuvaFt5qe3zlugfra6yCRuhIfdgQcPzU6Ze86pHdHIBwkkbur+0bd6h
         KMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BKV7Us31PplYG8nVr4YKT4dzglsvVwQG9aaoh549pW0=;
        fh=mEIP2PiabYkccRJnhnfa+m2y/r8+cnkr0lV2jPMKOI0=;
        b=RUTU4eHCSv+gIH0Uo0K+XuMEfCUGkNYv5HlydhvhQaUnurCc4M6NwyKyhXVQZRGyT3
         orWoU2HNF409BGZibHFuC/QMZbbAndSKYIMjYHKyfABtY1f+WSo+3XtJHb2d3U5uQLU+
         yeQZQJCxChDImIVxVrg8WcudnJptkqGrPLikyxdN7LoYpl2Xn03PEqfJWF1ymXyMViER
         O6vUolpSqHSsckSJtDK5711rOCecBf9LAwII23HnRi6D+S63FW9A6FT9eKb9hL5kGTLo
         xnxmQHsvzB+Q8vJ2bOgi1UrCOjM0DUiEg3aAgogngsSJmQh71Rxkbzys616HRi4qcsfG
         UYjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780953059; x=1781557859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKV7Us31PplYG8nVr4YKT4dzglsvVwQG9aaoh549pW0=;
        b=RTFDiFnyOgCLkxiRG8NIWcfh07BjFuptuBR0cNBjfVOcWJw7qhVofvYKp5kar0mxEc
         qF+9G4R2aTyi1KhL5kl1raiAGRft0Zcj5LYscQGnE1ron9STc0gCbw/5QZJJ8CNqBN62
         02hmdidifTDo03cxE7N9yg2UmwK0jmjbnSSGNivEBYe/5pkP6Y9Yi+HE8q3sYIPB8Qba
         BFaUHg3kqESjqQkYJiFpd+HMFidGp8uVZCCJPxIeuhwb4Fks6/OY9bBbEZtvwf1C9m9M
         IlSK/92G3vxGGoVFZnG7nJEA2Lo1yniAet2mUeuO7bJG9hunfVxipW0rL6wnwHIDhH7K
         AvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780953059; x=1781557859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BKV7Us31PplYG8nVr4YKT4dzglsvVwQG9aaoh549pW0=;
        b=Xa+Q8IGuvXoaSKfHyVpLvwf3JbkKoeBTpbYvlNUliGyZnjrzQk7k9eAY6PLBdKWwds
         ZqmpXgriKZz7iLby557hBWdzdg0qNOzwnG6K7AuaiXoJJwt7dP3sDLHkLabDOkMOzzZQ
         D62cp2PT9OPrrsqKlsKBllL911cxNaN+D7Rfo4JQcDn4BamNV1PCLqmiCglHxwPlwYup
         QOrnuH52/3UAWvL+GU8u3F8iffBhTGj2GjiV4h5/DvhnboNZ577V6bRoTXDk40yRcpCD
         7yBwP7fMcIAwJQGbjVyHAqlgaH+uUPzYhldjXMccjrj+uqWx4USk4bQRanAsK6QewA8f
         Evag==
X-Forwarded-Encrypted: i=1; AFNElJ8Mt0F1xZPJ7Y3H4Sg5v52h3PfypvaoGE1BvTqA2j8xg9BYCaAODmMMW4ukG/nOhwwpz+LUeahZSdCzJ5pGMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCsOhwp4rRMZw4as/3gaFXENnKPwndnr9xPipnZrOkygRNuxin
	75Tp1q8o72WXZ6/Hw2vXWZAVdCfZZJPOHO/Dvl6yukXYF/Hd1BBIoyz7w+Ji9H9yK4TdvrhJiKI
	u00ZRNYtIb4x8a8gAsQEkWsNbhsiBuw==
X-Gm-Gg: Acq92OEP7ZVtmNLgVs+Vy5jyqKvBJb2JE55JvaQjtqx87YDmm0pXizoD4+qDfwRhpru
	bobcLlajFBPNh3hGYkLCj5518uPSIh3/dV/WbTlaea20Wbn1Lrws6k130fjAt2RWg9BputaJ6TO
	o1qMQQkGINB73CuLxrAdK4MmxGxzIEwW1hym2N+MD4rNMDJmaJxFnG7zBSfoNgNjJ1abTp5DUv0
	v0+9KeN9fuYK4n6hVME/f9bACe/JF15ldyjaVk8aUauCOzOOZw66AlZdMw14gV17kqSCeqe0TLL
	c+RJPGwA6osOK1OWGHqBc515Sxg4BBvQUhbbXK/Dq1aawFEI+6zZA/mLaaE=
X-Received: by 2002:ac8:57c2:0:b0:517:5f04:f24c with SMTP id
 d75a77b69052e-51795c79c8amr255311491cf.39.1780953058621; Mon, 08 Jun 2026
 14:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa96f303-ba3d-47f0-8ffe-04c088d22913@gmail.com> <c056f6b3-e2e2-4bfd-9cd0-14225bd4d510@gmail.com>
In-Reply-To: <c056f6b3-e2e2-4bfd-9cd0-14225bd4d510@gmail.com>
From: Nick <morrownr@gmail.com>
Date: Mon, 8 Jun 2026 16:10:30 -0500
X-Gm-Features: AVVi8Cc_Zegiwe7euK8T6wuxYidr68uuaqdTM-3_d7A6iqBy3nQKZoF94wJ3eSI
Message-ID: <CAFktD2eUHaSUWmj7EXcaTisDiU2gT8nvNjXLZgGV-o1som_MtA@mail.gmail.com>
Subject: Re: [RESEND] Ongoing instability and connection loops with MT7922
 (mt7921e driver)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Angel Parra <jesusnavarrojr188@gmail.com>, 
	Linux Wireless Mailing List <linux-wireless@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37543-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:rtl8821cerfe2@gmail.com,m:jesusnavarrojr188@gmail.com,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:Sean.Wang@mediatek.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,nbd.name,kernel.org,mediatek.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[morrownr@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[morrownr@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F37965A9F3

Hello Angel,

The first thing that comes to mind after reading your report is that
the connection between the antennas and card is not good. Recommend
that you remove the back of the laptop and check the connections or
get your tech support to do it.

My wife uses a laptop with mt7921 based card (kernel 7.0) and I am on
a desktop with a mt7922 based full size PCIe card (kernel 7.0). Both
operate very fast and stable through 2 walls and ~8 meters.


On Mon, Jun 8, 2026 at 2:12=E2=80=AFPM Bitterblue Smith <rtl8821cerfe2@gmai=
l.com> wrote:
>
> On 28/05/2026 04:44, Angel Parra wrote:
> > Hello,
> > I was advised to reach out to this mailing list regarding severe wirele=
ss connection issues with my MediaTek card. I am writing to request a revie=
w of the `mt7921e` driver. While I appreciate the significant improvements =
made to the `mt7902` driver recently, the support for some newer chipsets c=
urrently feels almost unusable in real-world conditions.
> >
> > My hardware details are as follows:
> > ```text
> > 02:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express =
Wireless Network Adapter
> >         Subsystem: Foxconn International, Inc. Device e0cd
> >         Kernel driver in use: mt7921e
> > ```
> >
> > Below are the most consistent bugs and instabilities I have observed to=
 the date that constantly interrupt our workflow:
> >
> > * The adapter often fails to discover nearby access points, despite mul=
tiple mobile phones confirming their active presence.
> > * Both 2.4GHz and 5GHz WLANs frequently remain undetected, even when th=
e laptop is directly next to the router.
> > * Regardless of physical proximity to the modem, the connection process=
 regularly hangs on "Configuring interface" (in the KDE Plasma desktop appl=
et) for over 15 seconds. After this delay, the connection either succeeds o=
r fails completely.
> > * When successfully connected to 2.4GHz bands, download speeds are rema=
rkably slow and fall significantly below what my phone achieves on the same=
 connection.
> > * The detection range is severely limited; establishing a link to a 5GH=
z SSID requires being in the exact same room as the access point.
> > * Introducing a single wall between the router and the laptop triggers =
the aforementioned 15-second "Configuring interface" hang, usually resultin=
g in a failed connection.
> > * Upon failing to connect to an otherwise healthy access point, the sys=
tem enters an infinite loop. It hangs on configuration, fails, jumps to the=
 next saved SSID, fails again, and cycles endlessly through all saved profi=
les.
> > * Overall connection stability is exceptionally poor. A successful conn=
ection might persist only if the laptop remains perfectly stationary. Other=
wise, the link randomly drops after a few minutes with a "Connection deacti=
vated" state, triggering the failed connection loop.
> > * Attempting to bypass these issues by tethering to a mobile hotspot di=
rectly next to the laptop also fails. The adapter either cannot detect the =
hotspot at all or hangs during configuration, leaving the machine entirely =
offline.
> >
> > The failing connection loop in `dmesg` looks like this over a span of s=
everal minutes, clearly illustrating the continuous authentication timeouts=
 as the adapter cycles through my saved profiles:
> >
> > ```text
> > [148485.661369] PM: suspend exit
> > [148488.781860] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148488.795305] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [148488.843935] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [148488.996043] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [148489.044916] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [148491.867424] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148491.880895] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [148491.939014] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [148492.094896] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [148492.142676] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [148495.354718] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148495.368216] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [148495.418798] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [148495.577799] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [148495.625990] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [148499.324558] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148499.337991] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [148499.387641] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [148499.542987] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [148499.593575] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [148510.294935] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148510.308356] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [148510.360427] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [148510.406754] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [148510.566970] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [148520.573843] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148520.587285] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [148520.644274] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [148520.693177] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [148521.140382] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [148541.462597] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148541.476062] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [148541.522330] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [148541.973505] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [148542.022304] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [148548.610998] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148548.624376] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [148549.075668] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [148549.121771] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [148549.574886] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [148552.427178] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148552.430014] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [148552.470639] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [148552.513942] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [148552.556374] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [148565.252575] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148565.266023] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [148565.396382] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [148565.446749] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [148565.605849] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [148579.997166] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148580.010594] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [148580.072257] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [148580.112398] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [148580.152361] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [148592.848439] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148592.861867] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [148592.903480] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [148592.995422] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [148593.041528] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [148607.612953] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148607.626393] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [148607.698476] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [148607.742091] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [148607.783429] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [148620.219579] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148620.233011] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [148620.328013] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [148620.374159] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [148620.534020] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [148633.224869] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148633.238306] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [148633.303939] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [148633.356603] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [148633.514978] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [148637.634640] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148637.647620] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [148637.694360] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [148637.743291] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [148638.192244] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [148655.509368] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148655.522809] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [148655.572981] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [148656.021379] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [148656.070061] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [148677.626050] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148677.639450] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [148677.704689] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [148677.753188] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [148677.914243] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [148680.509871] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [148680.512694] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [148680.530021] wlp2s0: authenticated
> > [148680.530280] wlp2s0: associate with 84:d8:1b:9f:91:10 (try 1/3)
> > [148680.555487] wlp2s0: RX AssocResp from 84:d8:1b:9f:91:10 (capab=3D0x=
411 status=3D0 aid=3D4)
> > [148680.582777] wlp2s0: associated
> > [149142.517235] nvidia-modeset: WARNING: GPU:0: Correcting number of he=
ads for current head configuration (0x00)
> > [149361.823195] wlp2s0: Connection to AP 84:d8:1b:9f:91:10 lost
> > [149418.133906] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149418.145316] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [149418.194402] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [149418.242746] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [149418.692292] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [149437.001016] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149437.012391] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [149437.095855] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [149437.142168] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [149437.593548] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [149464.557438] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149464.568407] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [149464.730630] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [149464.777125] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [149464.932766] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [149474.631073] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149474.644554] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [149474.690700] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [149474.849313] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [149474.895328] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [149535.532981] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149535.546820] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [149535.678835] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [149535.725111] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [149535.880819] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [149879.705065] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149879.718556] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [149879.794297] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [149879.843592] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [149880.017253] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [149888.633997] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149888.647548] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [149888.805077] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [149888.856075] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [149889.015401] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [149928.562888] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149928.576448] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [149928.619097] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [149928.661687] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [149928.737998] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [149941.444820] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149941.458370] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [149941.615999] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [149941.662509] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [149941.711201] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [149956.605669] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149956.619156] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [149956.673039] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [149956.721411] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [149957.172885] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [149969.882794] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149969.896301] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> > [149969.943140] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> > [149969.990954] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> > [149970.442757] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> > [149984.624558] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [149984.638187] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [149984.697458] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [149984.737544] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [149984.778744] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [150016.560488] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [150016.573492] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [150016.614971] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [150016.673246] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [150016.721924] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [150051.575890] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [150051.589489] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [150051.636535] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [150051.685162] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [150052.134899] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > [150064.827990] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local addr=
ess=3D38:d5:7a:12:c2:3b)
> > [150064.841478] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> > [150064.966855] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> > [150065.015378] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> > [150065.174847] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> > ```
> >
> > Thank you for your time and for reading through this report. I would gr=
eatly appreciate it if this could be routed to the appropriate maintainers =
to help address these driver issues. Have a great day wherever you are.
> >
>
> Hi!
>
> These details could be helpful:
>
> - Laptop model
> - Wifi card's PCI ID (from "lspci -nn")
> - Name and version of the Linux distro
> - Full output of dmesg
>
> The mt7921e module has a parameter called "disable_aspm". Have you
> tried to set this to 1? Just a random thing you can try.
>
> I'm not sure if it's necessary with the Mediatek cards, but if you
> try this parameter, do a cold boot (set the parameter using the
> bootloader or a file in /etc/modprobe.d/, shut down the laptop, then
> turn it on again).
>
> I added the maintainers of mt76 to the Cc list.
>

