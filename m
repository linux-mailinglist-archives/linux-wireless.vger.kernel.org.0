Return-Path: <linux-wireless+bounces-12864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAEC9794B1
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 08:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529DB1F21F20
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 06:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B62171CD;
	Sun, 15 Sep 2024 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="t8rupJw+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B90C1B85D6
	for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726380302; cv=none; b=ty8XMmB9KTcb771zMc5XqPjxwBLdYXsteiOSxQswaubeZFzrWfzkoWICZouP0SNiTVjfIYPgHGBsApeZ08lRiRfgtBcPnA/aS0t86s9F49VvuiZtB0qYVg1Td8XSoPexlIN0AkKN9u0tWBuzjtsEeK8rPVUvnJpnp3D/PgCTsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726380302; c=relaxed/simple;
	bh=YiMl0W5EXLkUxP5ABOFYavI7SdjQSbcsdYIa8Z69k1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8uxE9VzACaHHGivjAaJxx52uwiu9k6KXnXcYS+FfCjjlwAGZk/QZjDcCimH2LuLCaOpJAx3RTWeA2FImusudqBe63lu37o1tJoTnN+/nhhCP/zHlixxHRlADNrXkoOAcX4NwV4jA2kjc4KiB1BQLqmdJqp+LheAvTnkZxW7Dcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=t8rupJw+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726380282; x=1726985082; i=s.l-h@gmx.de;
	bh=EZQUJxgWj+1fZbuZcHYdmnmyQgBzO6Kw1/SDCTEJGFk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t8rupJw++QbR4xmSW24WPxenUJpMT4E8UEKhnj9fCN3HKzvYbcUtNPT+9beI2LEK
	 XP4HDO23aoyk14Ui19aXu9NCGVwu1cixOYovpuZqSNILjCPmPd+PlofJuV8Mylkij
	 msK5Svb3R53zZN2jxcyYmyYuFH8CWPUkzwLodgtfrYKnDH8CGKDPhHV6xkX8Ep0l/
	 nLbljUaaUJyqRrRhwDnIuPU0NUNmRbSfseurEhuiUwbN9sFj82ZmbcMsHIPyJkK9H
	 FzwsULYEjwvCYstzgdZiHCOKMMakkzeBozjrMZcsNnrtIdOZCi9VNKm7D7UmVz5SW
	 ff5ZjOv0HblJEwHUSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.81.155]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJmF-1sBvlR1Op1-00hTUu; Sun, 15
 Sep 2024 08:04:42 +0200
Date: Sun, 15 Sep 2024 08:04:34 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Message-ID: <20240915080434.564d1c66@mir>
In-Reply-To: <4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	<20240313064917.527110c4@mir>
	<4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iDX3kvRN7G3ZmdGLq+NancrrJ6L5nEr2SCsp71Zi9X2X9K8BZSm
 6DwUg2nkeeKFzPu/+eHwclAVisCVlXTvULP9YKtg9e2YsvuFxCeaisuMi2HeWOSjc/ookPx
 KGlQG7pWbOA7tgTVru+vq1E5s1Gt1CwTw8bjzk3I1CG6aHIiDK1wJJve8JNnU/nHouBajNx
 khs7GbfqRMGwZWYB75irg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tk5SIBzLBks=;/dtjt7UfLLugB5Nr5KUGRK3wDx+
 12T6VX/4mqnkfaNzacdG1vuuofzqzT61UvGzm07Khtb0Z+v+cUtrfA16MAAliBU/JJrsbUCfS
 chK7X74hDJB8R/433T/I55h/ZDaJAqbA3SD/0fdt/ZP3rszQOmccjeNu0YYC6HIipRfJXRQoc
 WxaxtXtI2iusXdXc4WZKOH8ivDbx7xQAsZShc8kgrwWPSxks6pxWCYs1S9vFjyd4WiJfunOhQ
 YAIEXP1VOdHO1j0HO8tIKtBDK+2lmHQDMvcQa5C6cInfNtV8O0L7Q3VMS6QoaXIZo8zoRmNO3
 IYv+IkWOrVa0HviX2R4T925HIAy+Tnz7irqhCm4htHOgjM3ZovkobZzt8sYWYRv03WQBsRLrR
 3ZsVdjdn5Yln7UXppHfl2cvF/0QOg+tAFSk4XGXUpj7lPLyhgyb+dLWmB1wA16rS83WaRyqle
 IVCObmz0VdqU0bh9EZMBR6f4y3UxHMNDxkJLZB8UZyAOjQEaK5UjHNVuXNavHgO2Xa/Pmq2Uc
 BCjDabA/nf7Ib+Wi+HG+fUBh1jNDHFvnpoOGH1WCR6mh9FFKJLA/M05+l8+3nunRIiAAsLD8Y
 9czpombzYFgfSsEkgDmU4VMUnLaN9RJJQUOGsxRLwF9N/qZzWRGCHeGSMraVlPStUBxBBXwfW
 qK4+qy3nXd+HUYxdQurcfXAvSFeix4w7ykQQFpLoJQlWDZvYZaE9lxtHRbKU2D+qwwoetKIAv
 3DVco5FR3hW8siikAcOGbicOAGJ4x/ysSTC2b+gEK0I9OU3eBxtDc7W8hHcL0M097cAGdcXGe
 e06t0dQ4olg8PXv+SgMGGw9Q==

Hi

On 2024-03-13, Ping-Ke Shih wrote:
> On Wed, 2024-03-13 at 06:49 +0100, Stefan Lippers-Hollmann wrote:
> > On 2024-03-13, Bitterblue Smith wrote:
> > > Create the new module rtl8192d-common and move some code into it fro=
m
> > > rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driv=
er
> > > (USB) can share some of the code.
[...]
> > Using the firmware from https://github.com/lwfinger/rtl8192du/,
> > it would be great if someone could publish the necessary firmware
> > to linux-firmware.
> >
> > MD5:
> > abccba1e9bb456eb81dfc88502a56300  /lib/firmware/rtlwifi/rtl8192dufw.bi=
n
> >
> > SHA256:
> > 9b51f15642b7f2d41e8369d7df956f92333c09699d8a88039081a8bdc77242a1  /lib=
/firmware/rtlwifi/rtl8192dufw.bin
>
> I can do that after this patchset get merged.

As kernel v6.11 premiering with rtl8192du (which works well) isn't that
far away, I'll just drop a reminder about publishing the corresponding
rtlwifi/rtl8192dufw.bin firmware image to linux-firmware.

Regards
	Stefan Lippers-Hollmann

Post scriptum: Apologies if I missed a corresponding patch to
               linux-firmware.git.

