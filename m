Return-Path: <linux-wireless+bounces-32136-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NmIObQDnWnhMQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32136-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 02:49:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D368180BB2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 02:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 921C43013FE1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 01:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572E023C8AE;
	Tue, 24 Feb 2026 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NIn8nS5w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19388239E6C;
	Tue, 24 Feb 2026 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897774; cv=none; b=BANjbOElJMWwuj3yMyecBPoEI/1xJYQoUVB8tZOWWwNESjFZ7S/zkX/1DJl9vvlCCE3UFSgXtkqUTsZ004RUlRZ2h02KACrSb3JikpBzdzrWpRAdjzimLzZqXaUDfKSdRql1AFBQTA6s/4bn02xY5R2EERcKT0YYq/0ACoXdHfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897774; c=relaxed/simple;
	bh=FB/tKHeTjSZ1/5SZksfFlyWo5qykMKuIdlgVdUzyKYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P7Cyp4uhA+W9ZB6Tfq9KFKxH3pbWSibrEMhkgmao5LoYpoWGeZ9NI9/r4DG3/FNCU5hwN8Nh1ZaBAoAfYg2z/3UlPF/OM362FYM3Hq8o4JXmOMBN5Xaj1svoAnxJ1P73GhxRvvCDhZqeHijp8lYTtRIuz43e4uvQt65uNvVv4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NIn8nS5w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61O1nOpxD2119078, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1771897764; bh=8z97f3i3Ug7ROOsNF1clGlSUcO5q6a/Nt+xfIDdhvJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NIn8nS5w5Tn4BEY/WHqLlY3bcjsw2KULoFgFgWAClitQv9HQPntydolveF24juBCN
	 dZa0BPPaWle/Jyh7c/QmkZZXZOVgXvrzdh5Xav+8G86SS/wY+ikppLI9MV2OufAmcz
	 D3++p0xFGQ2VcadBrctkQKZ2IA0QVjhqgKnRXl2gDg+/7yTqJHt72fz+WEFKjSyoht
	 eW+x1FuaiUfOKAzVLGRU5tMDCVUD5bVNgwGeIe5qNx/5sY5aC0A1KSUxnCS1pcpwpE
	 mrBiXShV5uRxEaFTUt7edGL9kKoFS1fuKXCYhaPVW4/0OEkFuChEsb+5IMPkrDmQoN
	 C8mZEb2mcxn1A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61O1nOpxD2119078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 09:49:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Feb 2026 09:49:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 24 Feb 2026 09:49:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable
	<stable@kernel.org>
Subject: RE: [PATCH net] wifi: rtw88: properly drop usb interface reference on
 error
Thread-Topic: [PATCH net] wifi: rtw88: properly drop usb interface reference
 on error
Thread-Index: AQHcpLjbvOo/97laWkyK/7R7FXgm/rWRAqJQ//+CMICAAI+AwA==
Date: Tue, 24 Feb 2026 01:49:24 +0000
Message-ID: <a52baa6c345c4c1689094b386e3963d5@realtek.com>
References: <2026022333-periscope-unusual-f0a0@gregkh>
 <0a1b75853588468d87725e4d6aad8f22@realtek.com>
 <2026022459-robe-mutual-fc3d@gregkh>
In-Reply-To: <2026022459-robe-mutual-fc3d@gregkh>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32136-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 1D368180BB2
X-Rspamd-Action: no action

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Tue, Feb 24, 2026 at 12:46:02AM +0000, Ping-Ke Shih wrote:
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > If an error happens in the usb probe path, in rtw_usb_intf_init(), th=
e
> > > usb interface reference needs to be properly dropped, otherwise is is
> > > incorrectly increased when returning to the USB core.
> > >
> > > Cc: Ping-Ke Shih <pkshih@realtek.com>
> > > Cc: stable <stable@kernel.org>
> > > Assisted-by: gkh_clanker_2000
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/net/wireless/realtek/rtw88/usb.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/w=
ireless/realtek/rtw88/usb.c
> > > index 433b06c8d8a6..36ac20039ce2 100644
> > > --- a/drivers/net/wireless/realtek/rtw88/usb.c
> > > +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> > > @@ -1046,13 +1046,17 @@ static int rtw_usb_intf_init(struct rtw_dev *=
rtwdev,
> > >
> > >         rtwusb->udev =3D udev;
> > >         ret =3D rtw_usb_parse(rtwdev, intf);
> > > -       if (ret)
> > > +       if (ret) {
> > > +               usb_put_dev(udev);
> > >                 return ret;
> > > +       }
> > >
> > >         rtwusb->usb_data =3D kcalloc(RTW_USB_MAX_RXTX_COUNT, sizeof(u=
32),
> > >                                    GFP_KERNEL);
> > > -       if (!rtwusb->usb_data)
> > > +       if (!rtwusb->usb_data) {
> > > +               usb_put_dev(udev);
> > >                 return -ENOMEM;
> > > +       }
> > >
> > >         usb_set_intfdata(intf, rtwdev->hw);
> > >
> >
> > Since rtwusb->udev isn't used right after assignment in this function.
> > Would it be simpler that moving usb_get_dev() downward like below?
>=20
> What is even simpler, and easier, is to never call usb_get_dev() at all
> anyway as it's not needed :)
>=20
> I created that pattern a few decades ago when we thought that it was
> going to be required, but as long as the usb interface is bound to the
> driver, that pointer is going to be valid so there's no real need to
> increment the reference count, except to feel good about doing it.
>=20
> I'll gladly do that fix instead, if you want me to, I was just trying to
> follow the style of the existing code and fix up the current bug.

Because I'm not much familiar with USB devices, I can't afford to the chang=
e
that is too big to me. :)

Let's take your version, so

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

This patch can go via rtw-next tree (subtree of wireless-next), right?



