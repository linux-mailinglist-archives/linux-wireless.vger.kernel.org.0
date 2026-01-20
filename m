Return-Path: <linux-wireless+bounces-30989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66359D3BDFB
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 04:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E856349C2E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 03:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566583314D1;
	Tue, 20 Jan 2026 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jdjF+ClA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B143314C1;
	Tue, 20 Jan 2026 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768880353; cv=none; b=M74Q3XcSLEaB0lpLsC7PXBh43STLNHeDz42r2yIn1FuLYmuYC/lHN2O/fCSWRiNcl8qIl8SsRaj1Gulw5g4TBtilN3tVj7+SJB45CqtaVLi4jSoBxfXU59MhV0Dq7Z6YX5qo3mj2kCSBqzxbVsZ3/KQgCPEJTOGejNbtYUDL7yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768880353; c=relaxed/simple;
	bh=fUs5qs/OdtDbWbiTghrWvVv9O+SqF5UEiLNAZUtqjr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jRjBKFO2m9c8waAGtmVeFBgN0dJneXPtPcPNGk5vcROf3QGu4SRxKHfbBLFu5hZdPRfpvLnD74WYBW5ICg3KknWfp3aqsAW8/cjLfC5T8hSIj4L6ZDM/s0OkClI0ACFdENDJXIArKWgGA24NMR35kM8xpMTe9T9kQgHP/tulcwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jdjF+ClA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60K3d4We9132860, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768880344; bh=WWlRka46jla/1zA7NZfPd0mt9jvylFC+4gj4FEMccX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jdjF+ClAnNXHjoVflG+0mp1CE+qpT5rI0Pjo8L8Bnh2GiW67RAVwVwC+7etRLCbw1
	 3GavkmYF601wN94gTmIvuCUM8b/rEeo1emXauSIo6in9nApdhOWkFtllWexFyXX2zj
	 sescQH+Bn6ulPi7nzMkTD/YR7u9Cy/I8cPilr77iTgThDDqMu3yqBaCCYCzWRTLmNb
	 B9CyKuxUbeY0enhbXd4LD4f/VN7aHMZmgAq+7qFsb0DqvxBKEfbruq9YHMFMiRbW8o
	 RzWGbJklsSbmMHENCk9totD3a5Wr23f8UJAV2URT3GxwYSWbjGb8Rhtavh3MU6uXbz
	 iDT6UPxl+jiVw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60K3d4We9132860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 11:39:04 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 20 Jan 2026 11:39:04 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 20 Jan 2026 11:39:01 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5%9]) with mapi id
 15.02.1748.010; Tue, 20 Jan 2026 11:39:01 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Zilin Guan <zilin@seu.edu.cn>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>
Subject: RE: [PATCH v2] wifi: rtw89: debug: Fix memory leak in
 __print_txpwr_map()
Thread-Topic: [PATCH v2] wifi: rtw89: debug: Fix memory leak in
 __print_txpwr_map()
Thread-Index: AQHchulIg6QvmnQrbEyKhcpS3/LPa7VaatCg//97qACAAIflkA==
Date: Tue, 20 Jan 2026 03:39:01 +0000
Message-ID: <e0ddcb2d043c4006bc34a039f7469e04@realtek.com>
References: <20260116130834.1413924-1-zilin@seu.edu.cn>
 <e8e7b26c37084c418e2d6778c77ca100@realtek.com>
 <1127a2bb3b86437e82cf4b46c1a73f44@realtek.com>
In-Reply-To: <1127a2bb3b86437e82cf4b46c1a73f44@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Zong-Zhe Yang <kevin_yang@realtek.com> wrote:
> > Zilin Guan <zilin@seu.edu.cn> wrote:
> > >
> > > In __print_txpwr_map(), memory is allocated to bufp via vzalloc().
> > > If max_valid_addr is 0, the function returns -EOPNOTSUPP immediately
> > > without freeing bufp, leading to a memory leak.
> > >
> > > Since the validation of max_valid_addr does not depend on the allocat=
ed
> > > memory, fix this by moving the vzalloc() call after the check.
> > >
> > > Compile tested only. Issue found using a prototype static analysis to=
ol
> > > and code review.
> > >
> > > Fixes: 036042e15770 ("wifi: rtw89: debug: txpwr table supports Wi-Fi =
7 chips")
> > > Suggested-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > > ---
> > > Changes in v2:
> > > - Move memory allocation after validation check to avoid leak.
> > >
> > >  drivers/net/wireless/realtek/rtw89/debug.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/realtek/rtw89/debug.c
> > > b/drivers/net/wireless/realtek/rtw89/debug.c
> > > index 1264c2f82600..987eef8170f2 100644
> > > --- a/drivers/net/wireless/realtek/rtw89/debug.c
> > > +++ b/drivers/net/wireless/realtek/rtw89/debug.c
> > > @@ -825,10 +825,6 @@ static ssize_t __print_txpwr_map(struct rtw89_de=
v *rtwdev,
> char
> > > *buf, size_t buf
> > >         s8 *bufp, tmp;
> > >         int ret;
> > >
> > > -       bufp =3D vzalloc(map->addr_to - map->addr_from + 4);
> > > -       if (!bufp)
> > > -               return -ENOMEM;
> > > -
> > >         if (path_num =3D=3D 1)
> > >                 max_valid_addr =3D map->addr_to_1ss;
> > >         else
> > > @@ -837,6 +833,10 @@ static ssize_t __print_txpwr_map(struct rtw89_de=
v *rtwdev,
> char
> > > *buf, size_t buf
> > >         if (max_valid_addr =3D=3D 0)
> > >                 return -EOPNOTSUPP;
> > >
> > > +       bufp =3D vzalloc(map->addr_to - map->addr_from + 4);
> > > +       if (!bufp)
> > > +               return -ENOMEM;
> > > +
> > >         for (addr =3D map->addr_from; addr <=3D max_valid_addr; addr =
+=3D 4) {
> > >                 ret =3D rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, a=
ddr, &val);
> > >                 if (ret)
> > > --
> > > 2.34.1
> >
> > Looks good to me.
>=20
> I suppose I can add
> Reviewed-by: Zong-Zhe Yang <kevin_yang@realtek.com>
>=20
> Okay?

Okay, thanks.

