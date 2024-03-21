Return-Path: <linux-wireless+bounces-5068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D160881A91
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 02:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A1D2830A9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B0AA23;
	Thu, 21 Mar 2024 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="ZkTI75nQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD945684
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710983447; cv=none; b=g/UIXpzuN5k1UaBlSSSeKlmxUPorYp+DtkOX0HyczdKN2F/SreCmfEBF2tdUsaM8Tp/oNeBBBQDe6y+G+J2TYyQyb2WRTqCfC1VTYj3G3F2Jbnk8C4kgXy4kkLYRtvZX+CW1m5zcE6WG2ZuZDCwgoU/j8uv6omSSOlfNuqOTqWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710983447; c=relaxed/simple;
	bh=6MQMLlAuGm3bV6vFTJe3Quhxm6atT+GcyiQ3jRZwV5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9rqEEUqBqmelSEiIEQBxttDUSQqY2B2X3Fqi0eZMw+LGAdXOoCdQMz2g9AuDEKtPpRLKcGC0+03amGo9veFptF6Z0lmewJD1GR2h0gcSD7De5zYDLUsib9CcYq+k5h9/RN91QNoQLAb4vg2Yb98mZUe19N8YcAgGAd0YsKRpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=ZkTI75nQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710983426; x=1711588226; i=s.l-h@gmx.de;
	bh=S3aebGzcnWECYCgqJKp1PnTOj2g+yCBkGfd83wHVF34=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=ZkTI75nQPaBFeIP6oF2lMz1qJaotBB2ecf6LoTx0YYJrA8vWi41cAjT0la9g31vx
	 N903Zin7jUC3m6b3JM9DdIsrUKyWNLQnpJ0XevC9K2VEQXwqiCdb8Oz0pSUGlO3fT
	 P+0MIR96HrAwPEDOC3Ez8DjEZDC7eyKQU6ZiyPbbYYK1vwt+UN9f8DJVCnwMXZ0QY
	 4lh0XBvsi+hhGvFbRZpO+MR0T5KbbOU3CBXKt1mUIK9Q03QkX3F8C9ZaQ7ES3vdMs
	 i1dNlgKLeE8K+niRa55O89QhAoFElht/adfqK8sS5wslBVvHtrqNWxM8NycvhEZ7n
	 +xOMyNaD+t+T0eXdFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.82.155]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1rljNH0Guz-003b3w; Thu, 21
 Mar 2024 02:10:26 +0100
Date: Thu, 21 Mar 2024 02:10:23 +0100
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger
 <Larry.Finger@lwfinger.net>, Christian Hewitt <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 00/12] wifi: rtlwifi: Add new rtl8192du driver
Message-ID: <20240321021023.60e6af07@mir>
In-Reply-To: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QcnDpeCe+JTC/XgVMF7zPMdsA1O/87WGEaCfelffcTodabyHcZk
 D3kwhozJG8TQiE32K0K+2zEmWtwY0Fixsl6w0cpWJqIZWu0/hz/gRq+VeTPVOuWiZhhmjbl
 WAukzzMbo7YWi6UQcumcUh3M9TiU1+XFEcGoijhDFo7NleMoMnx3D30m6xH9sWXrW7zRwbP
 5aRHEtnu/htsg/jauokew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sIcMQZQRG94=;oD5vwGA4TeGInDwQHl+gzOL4SCY
 sJNJYbXdw32d06sv1zXrprkbSj3elfrXhuqRwj58hReCfSVv+Si/hXE/+WBWstohLAmJSVUFF
 WAoRHguqSmiYWCFd0HUyw7XKjGqQqZy+19hcd4ZAHsuJXe7zGypNZ7WeZcxjAqTPsvz6zmWuf
 QyqVihDvc9SHs4HkOPxj6xMVPe5ZhKhhAtcD+6V6tENYyP8mXn4MumZ+bM6PDR3RqhuoMVtdY
 IWd5pfXsZgXBH+pqTnplQmiXlhk/5T4nBvBbxinaEkTTP7dcX74t2m39OaxaGdWY5JgyrnlP5
 xotPFWJZ3va9y7XOL0G5isf0CYQrBCxULbQpTjSOzwz3dbPGlFaddeGNvMi33/ULgWhZjdECT
 7+bkvRpAQs5jY+SDDVvV9jXtr1l/M5JaXPKUuEIhWbemz4PDTpoUO/EPROr3aYuekI78NytEh
 rrUjEZy2ruuWabL4IbdjBQN3Ng7h2PBgsqNUlASS0/lyIgNEePlIsd9LvJL5aV+Yza8ibE6co
 PjbAWQYSNKtiNtHGpf+X56Bkz+pzqbC9oiw+5lQSwjdmy7ydDYyi0odfhWGoon9AM43Ciwxb7
 8HsEZ+NF3T74d4itrfZdxcos1xN20LdZqGxZsnl3AM8icOedJseK1SXOKK1rVVmD1aiJ2iU0p
 HRYb8vDIbVJtcy/qbDoKYmpx/aa/gL2v8PBKUdD2FK/uSa9Wp6NjWW26Szi9DjdKT0w1t3CCU
 TuuyeDn/EhcIQNcmZfpPyi7VC04VfP8D+172x/B0vE/2NMz46tPyF+F3tJL4kJw4XNkQ2wp3F
 o7m5JF6zPJC61vvwOsSu0d22OcfDxP30+KC4LEHuzSTlg=

Hi

On 2024-03-20, Bitterblue Smith wrote:
> These patches add a driver for the RTL8192DU chip.

Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>

> Patch 1 fixes a bug in rtl8192de. Patch 2 depends on it.
>
> Patch 2 moves a good portion of the code from rtl8192de to a new module
> rtl8192d-common.
>
> Patch 3 makes some adjustments to rtl8192d-common.
>
> The remaining patches add the new rtl8192du driver.
>
> Power saving is disabled by default because it's not working yet.
>
> Dual MAC chips are not tested.
>
> Until Ping-Ke Shih will add the firmware to the linux-firmware
> repository, the driver can be tested with the firmware from Larry
> Finger's repository:
> https://github.com/lwfinger/rtl8192du/blob/master/rtl8192dufw.bin

I've successfully tested v3 of this patch series on my DeLock 88540.

No issues observed in 'normal' daily operations previously with v1
either, it works nicely and makes this USB WLAN card usable.

Best regards and many thanks
	Stefan Lippers-Hollmann

