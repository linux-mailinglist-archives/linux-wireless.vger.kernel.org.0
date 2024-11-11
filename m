Return-Path: <linux-wireless+bounces-15160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DEA9C35D2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 02:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5A11F20C96
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221B8468;
	Mon, 11 Nov 2024 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="m4w3894D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF44749A
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731287609; cv=none; b=b/kwDgJszmkEK8YHNQFLIP6ZiFq/A8PrRIwka4REer0XaVtbrj0xu9zW42acE/XzEzoyAuJyh3us674+4HOce29suxeJN/8yi712DnPmx7AwwoZrjgw8BIEnoxrZ3rAuOxOx6ju6Yhj3qa5Iq/IhzCKiCi5szXR0U8I6y55hZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731287609; c=relaxed/simple;
	bh=GfDlA6AcLVpdY1kXxv1o5tnclt/ICsCwVQgZZq5AwOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dsZ9L0sBqjRMWmnC7EUjCLrXKmSxSFLfSqZ/ea+aSyTuTH8QoTeR3pca+MnybGat8M8riyNv7uQsCcgJUg2KI4vCSzsd9/bxnhBuy7G1FcGzgAfB/P4knvalIPY7gP4mbxM4Cbzv7n9adRNTyjJfgz/pPdPOecsWSoWfwXVwwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=m4w3894D; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AB1CkiZ61325600, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731287566; bh=GfDlA6AcLVpdY1kXxv1o5tnclt/ICsCwVQgZZq5AwOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=m4w3894DA7h8tfdigOq1NObKNX7NV9/V/ILAaHNIcSy6oqYm5zsC1SrWGrCqvAZn/
	 T/HStbYB0shPZ9sNu0atyCS2gIHY6CgYZYB/avRbWQU8z3z2mP9DHa/0IB35UtMw7j
	 MMkIUmQxkCnxtfU5kAzOicYs7LdMOpf0WmWDSeJwlLhUonV2PU0ttfGdEu2LSWJGP8
	 sLiEp9dHDHCvaqJmzxIeYBzNP8h7LjxezJaJIWXKebxh36r2tX6ZEOkeMhyb35OM3b
	 ItkcSuQs6JDO4BEpDCKkfQyiwNl7rY8J048LA3wRfmPMC5pJbGORqfMHQEJvn3nEzy
	 Xdr6rw0oPVwvw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AB1CkiZ61325600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 09:12:46 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 09:12:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Nov 2024 09:12:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 11 Nov 2024 09:12:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kalle
 Valo" <kvalo@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: RE: [PATCH net 3/5] wifi: rtlwifi: wait for firmware loading before releasing memory
Thread-Topic: [PATCH net 3/5] wifi: rtlwifi: wait for firmware loading before
 releasing memory
Thread-Index: AQHbMRmuTPaJxz8bskiJKupHobKYwLKso7MwgAAQRgCABJEpoA==
Date: Mon, 11 Nov 2024 01:12:46 +0000
Message-ID: <a3e0064ab22046fca7ad0836518c011e@realtek.com>
References: <20241107133322.855112-1-cascardo@igalia.com>
 <20241107133322.855112-4-cascardo@igalia.com>
 <fe600a9588e045658ef4415e1ceb4983@realtek.com>
 <Zy3wgtAEgZyg34R4@quatroqueijos.cascardo.eti.br>
In-Reply-To: <Zy3wgtAEgZyg34R4@quatroqueijos.cascardo.eti.br>
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

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> On Fri, Nov 08, 2024 at 02:12:24AM +0000, Ping-Ke Shih wrote:
> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > > At probe error path, the firmware loading work may have already been
> > > queued. In such a case, it will try to access memory allocated by the=
 probe
> > > function, which is about to be released. In such paths, wait for the
> > > firmware worker to finish before releasing memory.
> > >
> > > Fixes: a7f7c15e945a ("rtlwifi: rtl8192cu: Free ieee80211_hw if probin=
g fails")
> > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > > ---
> > >  drivers/net/wireless/realtek/rtlwifi/usb.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net=
/wireless/realtek/rtlwifi/usb.c
> > > index c3aa0cd9ff21..c27b116ccdff 100644
> > > --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
> > > +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
> > > @@ -1028,13 +1028,15 @@ int rtl_usb_probe(struct usb_interface *intf,
> > >         err =3D ieee80211_register_hw(hw);
> > >         if (err) {
> > >                 pr_err("Can't register mac80211 hw.\n");
> > > -               goto error_out;
> > > +               goto error_init_vars;
> > >         }
> > >         rtlpriv->mac80211.mac80211_registered =3D 1;
> > >
> > >         set_bit(RTL_STATUS_INTERFACE_START, &rtlpriv->status);
> > >         return 0;
> > >
> > > +error_init_vars:
> > > +       wait_for_completion(&rtlpriv->firmware_loading_complete);
> >
> > The firmware request is trigged by rtlpriv->cfg->ops->init_sw_vars(hw),=
 and
> > here is wait for filling rtlpriv->rtlhal.pfirmware and
> > rtlpriv->rtlhal.wowlan_firmware.
> >
> > The rtlpriv->cfg->ops->deinit_sw_vars(hw) is to free firmware. Shouldn'=
t we
> > call it here? Also shouldn't PCI need this?
> >
>=20
> About PCI, as I was testing with a USB emulator, I couldn't test it, thou=
gh
> I found a few fixes that it would need as well. I can send a patchset for
> the PCI fixes, though I won't be able to test them.

Thanks for the PCI fixes in advance.=20

>=20
> As for merging the following patch with this one, it would make sense. Bu=
t
> I found out the memory leak after coming up with this fix. And instead of
> explaining two bugs (one UAF and one memory leak) in the same commit, I
> thought it more simple to have two commits. Besides, given the Fixes line=
 I
> came up with for each one of them, they would apply to different trees.

I feel these two commits are dependent. It is hard to pick latter one witho=
ut
taking this first. But I think it is fine to keep it as was.=20



