Return-Path: <linux-wireless+bounces-15752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBB69DA4DA
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 10:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B0628149D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC61189905;
	Wed, 27 Nov 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="X7VAQKf0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E0192D66
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700165; cv=none; b=kn9cyJJSpd8fdsZGhflG3bRFnClbwhTU0KiISbdnoIQ17ED1ak2pT1XZNe/zIoRT8S+mPpiYOt9cFVPksPgNzxOoxJo9WgWwaiRPDq/ikR2FTJoy6PTj79KulI3Vu958CKjw12hgamsG87g40dgrwnxVuMre80LoxZ5C9Q0sQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700165; c=relaxed/simple;
	bh=JENMomMYhBi38d+XuNsmypWSmnK5f9rrhoSRpuRZ6Js=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTlPjAjS0aGYYUfWsBMx5Kp13or6PVmqYfCd0Xq99Yf54zlBfNK4TUUDgBwEDdfFF1Y3DsOnS8/WMcf9GyOgh1v359H+T+ALgdiABLtIcQkaqQ/hctHx2JTcdaBbSDlSn6v3yPPZHc/Y3/inyFiRzGM2itpxESXAxAOwYxVCUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=X7VAQKf0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AR9Za5A22497001, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732700136; bh=JENMomMYhBi38d+XuNsmypWSmnK5f9rrhoSRpuRZ6Js=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=X7VAQKf0UBkVhtlIgn/6tx4HdnOyDcYXt+4WxCz/FR0r5ITH+XSjturt2XMhd67kd
	 L/sgBxRt2iK89qWmS3sGTA+Ly6QvH3nzSMEDJeEsf2UeJYUL9aHaTHtBzOAP9iY3iF
	 OWS1DLIslEJL4gkRSd/255wCzWBUBQpdewCSo3IVlrHSQE13jVnYAUFq/n7dh3e4do
	 vRGNTtHdhC+SnZkMKetTrkPI1BBgXFL7/+VV/noO6XB2/6ueXuou+VHmzmp0Sxi4lj
	 dHO0UIqHbuf9noP3kiPXbQjkR6SJ7Ayf+mg7B0VE5cMt1/+q3Bx6NjPPyrmKXlyEei
	 XR4IT8SJa8GTw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AR9Za5A22497001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 17:35:36 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 17:35:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Nov 2024 17:35:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 27 Nov 2024 17:35:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kalle
 Valo" <kvalo@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: RE: [PATCH 2/4] wifi: rltwifi: destroy workqueue at rtl_deinit_core
Thread-Topic: [PATCH 2/4] wifi: rltwifi: destroy workqueue at rtl_deinit_core
Thread-Index: AQHbPQPtuhSVOKRI70Kht440h06pSrLKoYkg//+5VwCAAIocMA==
Date: Wed, 27 Nov 2024 09:35:36 +0000
Message-ID: <5ca4e7fb3ec643a287aad8fc08646886@realtek.com>
References: <20241122172718.465539-1-cascardo@igalia.com>
 <20241122172718.465539-3-cascardo@igalia.com>
 <3b967b62f2954e799a856140aa4b0796@realtek.com>
 <Z0bkNuVvv1eJMFyo@quatroqueijos.cascardo.eti.br>
In-Reply-To: <Z0bkNuVvv1eJMFyo@quatroqueijos.cascardo.eti.br>
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
> On Wed, Nov 27, 2024 at 05:35:23AM +0000, Ping-Ke Shih wrote:
> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > > index fd28c7a722d8..062d5a0a4c11 100644
> > > --- a/drivers/net/wireless/realtek/rtlwifi/base.c
> > > +++ b/drivers/net/wireless/realtek/rtlwifi/base.c
> > > @@ -575,9 +575,14 @@ static void rtl_free_entries_from_ack_queue(stru=
ct ieee80211_hw *hw,
> > >
> > >  void rtl_deinit_core(struct ieee80211_hw *hw)
> > >  {
> > > +       struct rtl_priv *rtlpriv =3D rtl_priv(hw);
> >
> > A blank line between declarations and statements.
> >
>=20
> Same here.

Prefer you send v2 to prevent I mess up the code.=20




