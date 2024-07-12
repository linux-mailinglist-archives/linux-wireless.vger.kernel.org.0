Return-Path: <linux-wireless+bounces-10204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8118492F76A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 10:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384A61F21613
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB213E03A;
	Fri, 12 Jul 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="HYJF8aCl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E685C56
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774665; cv=none; b=hP38Kq9eq9R+PgsG6Rb2ML/bhitA8F/vn/OzxGs0IF2o/cmolfbnc5cNtYrIbRwD23nG2wggT6xqT8d3Pio0nFGpaDRMBszkzur5k7oXUDrRcRq7NX+IzTipRbgeHnO6uN/aM3xohTf5b4C/k3LUOfQcIo2a05NMMOOMwCGCQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774665; c=relaxed/simple;
	bh=MeJe//Em7DgPJmlc6Kvw+nqubwtouh8oC6mMmD0kJtY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qYTgXl57bSE1FMpBh2bvy1+raW9RL3f77sIZ4C8LTD2Mnygw4/jM8XXyyh7aChQk/opYkJS7kDXzwoF09jYfV5JmbT7pwwfmyoKh42i6wsnygxxI4WLnEJH6Q6H/vVHolgJN1m5xV54nnAyz++yx5uUlR7GkzciCxiyZrj7l3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=HYJF8aCl; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720774639; x=1721379439; i=spasswolf@web.de;
	bh=q818iMHzVBVmVT4CCTpT313nYF1LwDuhQ5Wo0/o9I78=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HYJF8aClPG9Gs4DK7tVi/DfrW95Nyj1KYJIsN8ORTIZKTwGxLYix1I931TO/E4hN
	 JVqTCh3gqQBJG87hmKlN4j+kzvlpnk8PgY3saVP48bmzwA3/C6QYVvZ1AzzSzlG6S
	 ArSt6onXC27X2IAxan6UGekhpIoaDhGzxFazge90BqVWErn9nWXf33VwC2faJ+I7c
	 sEyAtF8B4IHM6YK/p4rs/g6nw1QjuljDkMTEc9Bhb2liiiG8V5y1SJNNP8UY+fPY/
	 wuU4X9SyCzQ89Q9TCjNscznjfkiDlf06OZ3iNHfGacGvfvcrPMjTknWy3Qp/yQoTV
	 CyEYaIPR912Y1m5KxA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav2X-1rvs4i00AV-00apCg; Fri, 12
 Jul 2024 10:57:19 +0200
Message-ID: <bed2ef069bf991032f95f556b23fc5c8f725d535.camel@web.de>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
From: Bert Karwatzki <spasswolf@web.de>
To: Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	mingyen.hsieh@mediatek.com, nbd@nbd.name, sean.wang@mediatek.com
Date: Fri, 12 Jul 2024 10:57:17 +0200
In-Reply-To: <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
References: <20240711175156.4465-1-spasswolf@web.de>
	 <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sIKhldBgcjtPKQWFe/buZTda0sdouDZcp2V6JqwlSh2q62Cho/j
 nlvjuMSklrXtpSk/fLVcwwI9KF1ynsLTvKWUQFlMd7Rto36C5jDKvyehU8kDyn6qcpEJAa8
 tveUAXeqfU3im8TZpo694cEKX3eNq/6EQgCGkKEEjXCCqIRkyeRW7F7nvPTGJGj5TNfSSLO
 XXuFYRxCEBrEYtq80c4Fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jMP8WPPszMA=;rdREfHQyvwNxa8u0hXghW38V7ot
 eZ9nVu3nHgi5maCFhOMdIF0XryFuMG4PPG9VwU4DnKkJl6m2j8bOFMRdSrgf2iX+b0RYr0nUI
 otQjns3KiVM0+tH6JkyKFAawEPY9Zzf4oznh1u3fa9pIW28OJ0jO0cWdJnG+lvKZXTjoaau6N
 qEUoR+4FQCuENBF1p5/FXZjvwsAb5IWwsVAkyR9RL+u4xWDd0XN4gSSUyeK++U2EObVvelcj+
 Uh1ABbJj7AmdHm70pv+9VSL7Ftc4uWA55xSDHRZ0e3rm9RHkYzTYINvvDYpBqCPOe7YOfDAe5
 0EqFh2DQvf4t5bEKN9UA+5xNoa2N3tWw9GI5+S0HMsbK/z5VharQqpRoyHPe3Rb5Dwcq62pcE
 woN76ppHr8d3JQ2UmnOsEv/r4XV8EREgjzLjt3FxEp2bRgcEelFvL0pODHiAgp0yZ6XQ0aM7N
 JHC5zYIkvCRqWdAaoKXIE23JuXJjQ0gdqeIu4WldD54L5ztQYIeJW1aVZKrb9Mn7+fDNN8P2a
 jP+KG6ZJJ8KpsvMeQ1IPKE3Vhw2WvTdmdzmIxtN5MX+2ge4ooUTRQosD0gYrH39d6qRokibW4
 CZDE++9kF3dS5V51QWR4UYAH4KQUeR5iR9jVTselV5CVAwtuzmG5y3SgDuIoDtw+MP0dLx4kS
 n6P/z2wXneYlZMXN4be3VT0FVvr8mr7HzQ/Pg+QYXePgUWa/XcUyTRzSxwc/MW/bA98bUCUqj
 pvDVqDgvsMDLld0Dg/7lBqlRhCJwOXv4VNMmoRj6SCh+kRovzD1ul6ls+KVnclOwR8Ra7ayJo
 +BfNt4N9j1QaR9ph/EKyrM1A==

Am Donnerstag, dem 11.07.2024 um 18:40 -0500 schrieb Sean Wang:
> Hi Bert,
>
> Thanks for the detailed debug log. I've quickly made a change to fix
> the issue. Right now, I can't access the test environment, but I'll
> test it and send it out as soon as possible. Here's the patch.
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 2e6268cb06c0..1bab93d049df 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -303,6 +303,7 @@ mt7921_add_interface(struct ieee80211_hw *hw,
> struct ieee80211_vif *vif)
>
>         mvif->bss_conf.mt76.omac_idx =3D mvif->bss_conf.mt76.idx;
>         mvif->phy =3D phy;
> +       mvif->bss_conf.vif =3D mvif;
>         mvif->bss_conf.mt76.band_idx =3D 0;
>         mvif->bss_conf.mt76.wmm_idx =3D mvif->bss_conf.mt76.idx %
> MT76_CONNAC_MAX_WMM_SETS;
>

I tested your patch with linux-next-20240711 where it works fine and with =
linux-
next-20240712 where the mediatek related error are solved, too, but gdm ha=
ngs on
startup (with no related log messages, which I'm sure is a different probl=
em).

Bert Karwatzki

