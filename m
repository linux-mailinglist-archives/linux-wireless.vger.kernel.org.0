Return-Path: <linux-wireless+bounces-4219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE186BE62
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 02:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C8D1F21B83
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 01:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B114D36135;
	Thu, 29 Feb 2024 01:37:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49684339A0
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170648; cv=none; b=ECWh0mMAYSxWYaim2/mpxlbYRih4Xb9sNasId8RIy1P5QUNAXHBdBgYhmENVJsSztOGKYsQmaQELugDH0KpuLVwrsGnGetNlp9Cnshd8q3iO30qfgTi7KVk6OpsJ041sBzW2Z69I0vmK5cE7RVVS1ZhS/vB34c0CDSX/9AdDSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170648; c=relaxed/simple;
	bh=skPpaEuLRIZ6eirQIPaCaL+NCBFs2dA2ubPpPVKK8cg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DAIvVznd+yjETNXNHy56SXCJtgpTC71fQQ1Fh/l/BhuU/Rlw+gW/o407pl0MFtlvbL6b4kke/bbQu2cQyN5qZFrzWGPE3iTKt7fFiATJNyStJ4n0h2SwJHsXtooFlg+FfDQxjENYevLJhVVoGI4yj6m+mj3DedII0PuCQnx0jIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T1b9llD988269, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T1b9llD988269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 09:37:09 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 29 Feb 2024 09:37:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 09:37:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 29 Feb 2024 09:37:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sascha Hauer <sha@pengutronix.de>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Sean
 Mollet" <sean@malmoset.com>
Subject: RE: [PATCH 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
Thread-Topic: [PATCH 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
Thread-Index: AQHaaXcR3HkprUxyPEepnjoj4RB95rEdn6yAgAA7GoCAARQJgIABmkjQ
Date: Thu, 29 Feb 2024 01:37:08 +0000
Message-ID: <d03453973370468aaf5213d61e8e3089@realtek.com>
References: <731ea688-04ef-4f02-9d01-3e9026981057@gmail.com>
 <Zd3b81m3_Hh47lww@pengutronix.de>
 <aacc9bf5-90e3-4e7a-af44-33d11fe89c18@gmail.com>
 <Zd71FWoTDn5plI5R@pengutronix.de>
In-Reply-To: <Zd71FWoTDn5plI5R@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Sascha Hauer <sha@pengutronix.de>
> Sent: Wednesday, February 28, 2024 4:56 PM
> To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Cc: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>; Se=
an Mollet <sean@malmoset.com>
> Subject: Re: [PATCH 1/4] wifi: rtw88: 8821cu: Fix firmware upload fail
>=20
> On Tue, Feb 27, 2024 at 06:27:51PM +0200, Bitterblue Smith wrote:
> > Adding Sean Mollet because I forgot earlier.
> >
> > On 27/02/2024 14:56, Sascha Hauer wrote:
> > > On Tue, Feb 27, 2024 at 02:18:20PM +0200, Bitterblue Smith wrote:
> > >> +  if (addr < 0xFE00) {
> > >> +          if (addr <=3D 0xff)
> > >> +                  current_reg_sec =3D REG_ON_SEC;
> > >> +          else if (0x1000 <=3D addr && addr <=3D 0x10ff)
> > >> +                  current_reg_sec =3D REG_ON_SEC;
> > >> +          else
> > >> +                  current_reg_sec =3D REG_OFF_SEC;
> > >> +  } else {
> > >> +          current_reg_sec =3D REG_LOCAL_SEC;
> > >> +  }
> > >> +
> > >> +  if (current_reg_sec !=3D REG_ON_SEC)
> > >> +          return;
> > >
> > > Is there something we want to do with current_reg_sec =3D=3D REG_LOCA=
L_SEC
> > > or current_reg_sec =3D=3D REG_OFF_SEC later? If not the above could b=
e
> > > rewritten as:
> > >
> > >     if (addr > 0xff && addr < 0x1000)
> > >             return;
> > >     if (addr > 0x10ff)
> > >             return;
> > >
> > >     ...
> >
> > Dunno, I just copied the code from the other drivers:
> >
> >
> https://github.com/morrownr/8821cu-20210916/blob/5b39398e2de146edeb767164=
20f3288f508bea61/os_dep/linux
> /usb_ops_linux.c#L171
>=20
> Ok, nothing is done with current_reg_sec here as well, so I suggest
> rewriting the check like I suggested.

I also prefer rewriting the code, but we can add comments to describe there
are three sections:=20
  1. on (0x00~0xFF;0x1000~0x10FF): this section is always powered on
  2. off (< 0xFE00; but not on section): this section could be powered off
  3. local (>=3D 0xFE00): usb specific registers section=20

Since only on-section needs special deal, maybe positively listing register
ranges would be clear, like

	bool reg_on_sec =3D false;

	if ((addr >=3D 0x00 && addr <=3D 0xFF) ||
	    (addr >=3D 0x1000 && addr <=3D 0x10FF))
		reg_on_sec =3D true;

	if (!reg_on_sec)
		return;

Ping-Ke


