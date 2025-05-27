Return-Path: <linux-wireless+bounces-23435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A9AC49BB
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 09:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CC5189904C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 07:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7CE248F42;
	Tue, 27 May 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dBp0x28I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB81A0BD6;
	Tue, 27 May 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332703; cv=none; b=AU93OrM2HEhpc6ie8CerI+2GrsXovuO9GomDk9Yu6dcTw4zPKFACOtPGFtrUF9YyXmM6a11gB9v0HK6g9cc8N+aS8JAd885vVR0XJvP4GQAOVf2NiyzJxufjZdRKDLjnmiIAycSLcWstsnvKaJX4HTevJeNTkJQGcRNdmwXKh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332703; c=relaxed/simple;
	bh=9SFvgeOwKrobD4cRTqiopVNcOl4N2zjHLcRSyk72nmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JVmsEhB4SHupxzqFo2yUwrxDTHDtA5a/WcFuVc9ll2jz6MNOi3Dd72zubiobx66zDjmH0O1DKMGHDCP/JTdZr0StCV9QOGPBnM7rAvHCmBLVtu83jO9U0qElHlR3qVpDGrGAjM9ix2TiW1OvHrSb3HGTovikjlr+iUAT4avwKQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dBp0x28I; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54R7wE9611481514, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748332694; bh=F3p54VaksFXXr0qjBndcI+PrSvsXrHVobFyMgUaaFIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dBp0x28I/UrGGDId/+nVBYwqKGd2VJW/WO5B04+lm8WP/6yhhKOuR0Uy5r5kzqdhH
	 MhcWP+rdJ3oedmETjL5vmlsT/IyWC7V/0KARlHuWTGnW7RoEY+eYjE+y+8+O8E+9Ds
	 eV0jyub97ppKhhFLYQtvpUzs6dkw+Puv0Q3zWQo+RUo+pfqX5fxAlnWGRkZ/Dob6bB
	 JU6+idzrIBqCn5xYkOOMF3IubFCZHRpEXaWVrqJRnTQVeWskJgUwELtbHmrBTvnnwJ
	 tUtpnFqAmynPHSelzNbZiymslkqz5+84RpaNyRpBKIqZPBbQAnl2b28l1iwoJuDHee
	 HdCsn1HbhyEOw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54R7wE9611481514
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 15:58:14 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 May 2025 15:58:14 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 May 2025 15:58:13 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::dd06:104c:e04d:a488]) by
 RTEXMBS03.realtek.com.tw ([fe80::dd06:104c:e04d:a488%2]) with mapi id
 15.01.2507.035; Tue, 27 May 2025 15:58:13 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] wifi: rtw89: mcc: prevent shift wrapping in rtw89_core_mlsr_switch()
Thread-Topic: [PATCH next] wifi: rtw89: mcc: prevent shift wrapping in
 rtw89_core_mlsr_switch()
Thread-Index: AQHbzswfjeN9r26I10eoAov9FdTI97PmBnfw//+Mn4CAAIgNsA==
Date: Tue, 27 May 2025 07:58:13 +0000
Message-ID: <c70e23c6e9134f7e8b8791b5ece6baa3@realtek.com>
References: <aDVUEHfa9q2zBD6i@stanley.mountain>
 <582b5bc4c4434934838ae28d77b7f73a@realtek.com>
 <aDVtu6dpKfWOyBn6@stanley.mountain>
In-Reply-To: <aDVtu6dpKfWOyBn6@stanley.mountain>
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

Dan Carpenter <dan.carpenter@linaro.org> wrote:
>=20
> On Tue, May 27, 2025 at 07:38:17AM +0000, Zong-Zhe Yang wrote:
> > Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >
> > > The "link_id" value comes from the user via debugfs.  If it's larger
> > > than BITS_PER_LONG then that would result in shift wrapping and
> > > potentially an out of bounds access later.  Fortunately, only root ca=
n write to debugfs files
> so the security impact is minimal.
> > >
> >
> > Thank you for catching this problem.
> >
> > >
> > > [...]
> > >
> > > @@ -5239,6 +5239,9 @@ int rtw89_core_mlsr_switch(struct rtw89_dev
> > > *rtwdev, struct rtw89_vif *rtwvif,
> > >         if (unlikely(!ieee80211_vif_is_mld(vif)))
> > >                 return -EOPNOTSUPP;
> > >
> > > +       if (unlikely(link_id >=3D BITS_PER_LONG))
> > > +               return -EINVAL;
> > > +
> >
> > Since I think this problem only comes from dbgfs path, would you like t=
o just add a check in
> debug.c ?
> >
> > For example,
> > (based on 0 <=3D valid link id < IEEE80211_MLD_MAX_NUM_LINKS <
> > BITS_PER_LONG)
> >
> > rtw89_debug_priv_mlo_mode_set(...)
> > {
> >         ...
> >         switch (mlo_mode) {
> >         case RTW89_MLO_MODE_MLSR:
> >                if (argv >=3D IEEE80211_MLD_MAX_NUM_LINKS)
> >                        return -EINVAL;
> >                 ...
> >
>=20
> I'd prefer to add the check in one place instead of all the callers.

Understandable.

> We could check IEEE80211_MLD_MAX_NUM_LINKS instead of bits per long if th=
at's more
> readable?

Sound good to me.


