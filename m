Return-Path: <linux-wireless+bounces-23065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F8AB97D2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 10:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2714E5756
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 08:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4D22D4DD;
	Fri, 16 May 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oe3a1LN6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80A282E1
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384691; cv=none; b=UxyP5XLWq+6ny/2TxXmXLzDHqWbV1m+NtoPk1XOok1VeY+U39nFKz7HTTWyPhdtQyRGLEkeSQ70U3FYgWDCXFZzUrTTGixxPN9bEedyJTkWJU/aGacVNbBSK9fsb6w8OhzuKNoD2KBPvwqRbNgdZS3dfOH8HV3Ilqn6tBpc/46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384691; c=relaxed/simple;
	bh=3+eO/Qfn6xTvJMuj8st/TlhNA5PDFTSdkuTMA5gffj4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DiYmd0xMDQZHU4JUTw9u9ciS/n8aWM5IWEzrln76mJS8EGCRE7/IRH+YfmCsLFKw1xtCsrurZIIWuotmnw/UUNz8ZVI2D0iYj/qDwkpOxvNey7gVQTJ8OK3T1IIqZIBxbqPyAQR6xX0YXZLUxY3l64Jm9wK0Nj90R5AF1xuCLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oe3a1LN6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3+eO/Qfn6xTvJMuj8st/TlhNA5PDFTSdkuTMA5gffj4=;
	t=1747384689; x=1748594289; b=oe3a1LN6eRsRZmkiXdxGxWZpNqiYhuHeHKtg7YE4vwHFkxv
	Whg0K0Eplsbfhk5BHi7rWpk7g4TZXFXm5akkmRoYijEAyDYs0SsUnidjugIAl1DWcDCM/yHmUyhxR
	Zodpy+p7EMft2PMU73lUoRfZYZtgkpGnTjZ3ufRfMuHQQzklNkynnAX3L2ZQIIcFSIqDC7L3QOYbG
	TdI9OJk2PienWJQA2IaYyKNiMLkwt9RM5cSZyg2tVJxnMxnMW1f1BUxkO8zrznS/1CKCMKHoWy+rY
	E7fS8CDAwrK90DOI9zEVPCRLJ4Jzh6+Ttc4IgJSzwOaEwDeOwDEPDXtEplRuNWtQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFqZx-0000000E7Ec-2b3M;
	Fri, 16 May 2025 10:38:05 +0200
Message-ID: <424fc6a24f3af233fc70296b9995a97c2d7f9e17.camel@sipsolutions.net>
Subject: Re: wireless-regdb: Wrong ETSI tranmit power without TPC
From: Johannes Berg <johannes@sipsolutions.net>
To: wens@kernel.org, Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Date: Fri, 16 May 2025 10:38:04 +0200
In-Reply-To: <CAGb2v676sXN_eC9s6_2a6k2ACzf3n5jBgY_id22ruoz+Zb-Jaw@mail.gmail.com>
References: <aBoK6p1+F5ve1rC6@FUE-ALEWI-WINX>
	 <CAGb2v676sXN_eC9s6_2a6k2ACzf3n5jBgY_id22ruoz+Zb-Jaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-05-16 at 16:15 +0800, Chen-Yu Tsai wrote:
> > The frequencies 5470 - 5725 have a power of 500 mW. It results in 26 dB=
m. But I
> > believe 27 dBm are allowed.

Seems like. But units are hard...

The link in the db went stale, but the current versions

https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Teleko=
mmunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/Mobil=
funkDectWlanCBFunk/WLAN_5GHz_pdf.pdf?__blob=3DpublicationFile&v=3D1

states (page 5):

--------------------
Frequenzband 5470=E2=80=935725 MHz
...
Maximale mittlere EIRP f=C3=BCr
bandinterne Aussendungen

1 W
Ausnahmen:
f=C3=BCr Anlagen in Stra=C3=9Fenfahrzeugen gilt eine maximale
mittlere EIRP von 200 mW.

...

Maximale mittlere EIRP-Dichte f=C3=BCr
bandinterne Aussendungen

50 mW/MHz in jedem 1 MHz-Band

...

Sendeleistungsregelung (TPC)

TPC muss durchschnittlich einen Abschw=C3=A4chungsfaktor von
mindestens 3 dB gegen=C3=BCber der h=C3=B6chstzul=C3=A4ssigen
Sendeleistung der Systeme erbringen; oder ohne TPC muss die
h=C3=B6chstzul=C3=A4ssige mittlere EIRP und die Obergrenze f=C3=BCr die
entsprechende mittlere EIRP-Dichte um 3 dB verringert
werden.
--------------------


So to be _really_ precise you'd end up with 1W reduced by 3dB which of
course _is_ precisely 27dBm since 1W is 10^30 or precisely 30 dBm.

(Except in "street vehicles", apparently. Rail has its own things, so I
guess that really does mean cars/trams/etc.)

But given the unit conversions are hard, we should probably just do this
in the db in dBm?

johannes

