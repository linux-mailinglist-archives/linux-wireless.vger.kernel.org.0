Return-Path: <linux-wireless+bounces-15518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7A49D3266
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 04:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8EBB228C2
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 03:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4455336D;
	Wed, 20 Nov 2024 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="R0HQyf5V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF6147C79
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072314; cv=none; b=NGW2wHYzjPRSXpWRTO1EK2CZHTyN+vxQFbDlD/V2pevlp4LTq/E4jjY9iNMwcmNH3+cZxtI+imKd9bcQWQXTffU++i22BR8ve9FJ0olLegOxFwaUvj/Ed1wkw9bNEYe0EoqBGwCFXdaEdL7uywostMatTPIDfqeWOv2QSbQNuxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072314; c=relaxed/simple;
	bh=IggduWnkOdParuZfkvr+HhdTNndF1ctftvjbzwCPihU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iztHfETMxsri1s6vH5dEIkNp5I7H3lvl3gyDRNl/88xk6tD/XK/ysJdv1o4vReQN14C9C3GaLsl5RmJqLwgtqGeOABmmhXO2oXn8wBd4JCOll8wef4Q9SPzkaAGfoTdqKSGbGFN7THqMmOn44wRUHZJSRNmoSDjOg67sQP4WB4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=R0HQyf5V; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK3BfYU23437508, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732072301; bh=IggduWnkOdParuZfkvr+HhdTNndF1ctftvjbzwCPihU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=R0HQyf5VjHTL5adj8hs6kVyhLv1+koFPLJDPoN3VeM/HO/3YyDjNUuaEB/ozNHnwQ
	 hcEuQFUOkleFTlvWl0wygRCZbgsShBGSTviPeX7jl7bBNhgq+ezbf8yeJ3I81N2frc
	 WnuyPlCM1dARtRNsmKt3kNnnaRPbPUwpMt03lc2eIMmm/oiGNLb+y9wRpssPCBfGJP
	 sFnv19cTs5i8EtOp/3es5jjVjNcFToQRN2StWUza52OC39q0mUTK94IMgjdgc62bce
	 FUEe/cqjds6T8KuUWvvyv6E40IilBeLKUofGt8/pTVbmj+flfsbqR7PR0Znb/KUK1L
	 ROlFIYXfDob9w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK3BfYU23437508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 11:11:41 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:11:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Nov 2024 11:11:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 20 Nov 2024 11:11:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Zong-Zhe Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH v2 1/6] wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
Thread-Topic: [PATCH v2 1/6] wifi: rtw89: 8922a: configure AP_LINK_PS if FW
 supports
Thread-Index: AQHbOW7zpSXp73vNCUiGSBdsDq1AS7K8+bOLgAKFgQA=
Date: Wed, 20 Nov 2024 03:11:40 +0000
Message-ID: <9ac0fb9682e74b3f89b92be245f61998@realtek.com>
References: <20241118040255.40854-1-pkshih@realtek.com>
	<20241118040255.40854-2-pkshih@realtek.com> <87mshwvhz2.fsf@kernel.org>
In-Reply-To: <87mshwvhz2.fsf@kernel.org>
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


Kalle Valo <kvalo@kernel.org> wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > After FW v0.35.46.0, for AP mode, RTL8922A FW supports a new FW feature=
,
> > called NOTIFY_AP_INFO, to notify driver information related to AP mode.
> > And, one function of it is to monitor PS states of remote stations. Onc=
e
> > one of them changes, FW will send a C2H event to tell driver. With this
> > FW feature, we can declare AP_LINK_PS.
> >
> > For now, driver still needs to determine if a frame is ps-poll or U-APS=
D
> > trigger. So, add the corresponding RX handling in driver, which activat=
es
> > only when at least one AP is running.
> >
> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>=20
> [...]
>=20
> > +static inline void rtw89_assoc_link_clr(struct rtw89_sta_link *rtwsta_=
link)
> > +{
> > +     struct rtw89_sta *rtwsta =3D rtwsta_link->rtwsta;
> > +     struct rtw89_dev *rtwdev =3D rtwsta->rtwdev;
> > +
> > +     rcu_assign_pointer(rtwdev->assoc_link_on_macid[rtwsta_link->mac_i=
d],
> > +                        NULL);
> > +     synchronize_rcu();
> > +}
>=20
> In ath12k patches I got feedback that synchronize_rcu() should not be
> used unless we explicitly need it, for example if if we free something
> or similar. Just wanted to mention this, up to you if you want to keep
> it or not.

The 'rtwdev->assoc_link_on_macid[rtwsta_link->mac_id]' is to store pointer =
of
rtwsta that is drv_priv [] of ieee80211_sta. After returning from this
function (disassoc), ieee80211_sta is going to be freed by kfree, no other
synchronize_rcu(), so I think this is necessary here.=20

Thanks for your reminder.=20



