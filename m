Return-Path: <linux-wireless+bounces-15161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F809C36C5
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 03:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7321C20A6E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 02:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628AE13A25B;
	Mon, 11 Nov 2024 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cCaZaNCF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D22595
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731293945; cv=none; b=N7oNS5Vhs7ThOpLbw9ZYVDCur8j2andVkQE9AvBVi5RBLsrj/5C4NNehdmxq1dqe0Mg6jeO/ZbB9d5t4z0LA5sqftGxSnrdCChvJaYVt3IzDbVR7BctEA7AGTVsxfVgf3TrB4Ov7hQ14LoFTiKLk2mqnqYy46m6Li20R64vCxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731293945; c=relaxed/simple;
	bh=nfwihCgwkOkNv8iR2wdzMfdrsRKmxmbSPRY68JIqDfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eBRm/c+zce1CU5305bKtcQDU/BPvg4TFQQNZMAxr+C4Wqn/Pi4PkU6WllXK6FRscYzw6VYxg9+tS0liMBVZ+VdkVcCEHpLco5NygaqywESwMnFZjdx1YUe9G/PcBdqtM3zRViOEXoAtmPJrDTphFbXwjjkaqaPe1B+7ywL1GFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cCaZaNCF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AB2wfWO31488870, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731293921; bh=nfwihCgwkOkNv8iR2wdzMfdrsRKmxmbSPRY68JIqDfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cCaZaNCFBCm2577zuarJyPV5QV7YSMIGAnIHwQ1Y6GpBIjECoSvLKEShtm4ug9Ltp
	 bO4wq8XVHYlQtVEcPbLo28T69Ujd72yybnNiCceaVgw2DsWtQxMX/wNBG/OslyYCyZ
	 vvKRLGDsUxKw5d/3ho57KJdYpG0VDz7o2F/fbNX2bv2BsIpTK6Yb0LarjutFXw4N8q
	 jWK677HPLiBzm3fTWqUEM0/MLZQvfcC8Qixaum9/QOtcwlFgYkKoShDu48RCA9uO3s
	 9kCOb3OupSrONQ54Bh9qZqRHsZU+Ff1FPjH6jo0FmtfPwh3g1nPT3mJnJ51UETn1cS
	 i74h1VyHhVJXA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AB2wfWO31488870
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 10:58:41 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 10:58:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Nov 2024 10:58:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 11 Nov 2024 10:58:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kalle
 Valo" <kvalo@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: RE: [PATCH net 5/5] wifi: rtlwifi: usb: fix workqueue leak when probe fails
Thread-Topic: [PATCH net 5/5] wifi: rtlwifi: usb: fix workqueue leak when
 probe fails
Thread-Index: AQHbMRmyetrUO5Ddvk2+060ZgCtCdrKsp0/ggAAPVYCABJTWgA==
Date: Mon, 11 Nov 2024 02:58:41 +0000
Message-ID: <f4733b73aae54b2f91231c1093ad93b1@realtek.com>
References: <20241107133322.855112-1-cascardo@igalia.com>
 <20241107133322.855112-6-cascardo@igalia.com>
 <d66c4ae9004c43058c89fcc3d97f4b41@realtek.com>
 <Zy3yv1TrPGXeP6x3@quatroqueijos.cascardo.eti.br>
In-Reply-To: <Zy3yv1TrPGXeP6x3@quatroqueijos.cascardo.eti.br>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> On Fri, Nov 08, 2024 at 02:23:48AM +0000, Ping-Ke Shih wrote:
> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > > rtl_init_core creates a workqueue that is then assigned to rtl_wq.
> > > rtl_deinit_core does not destroy it. It is left to rtl_usb_deinit, wh=
ich
> > > must be called in the probe error path.
> > >
> > > Fixes: 2ca20f79e0d8 ("rtlwifi: Add usb driver")
> > > Fixes: 851639fdaeac ("rtlwifi: Modify some USB de-initialize code.")
> > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > > ---
> > >  drivers/net/wireless/realtek/rtlwifi/usb.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net=
/wireless/realtek/rtlwifi/usb.c
> > > index 8ec687fab572..0368ecea2e81 100644
> > > --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
> > > +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
> > > @@ -1039,6 +1039,7 @@ int rtl_usb_probe(struct usb_interface *intf,
> > >         wait_for_completion(&rtlpriv->firmware_loading_complete);
> > >         rtlpriv->cfg->ops->deinit_sw_vars(hw);
> > >  error_out:
> > > +       rtl_usb_deinit(hw);
> > >         rtl_deinit_core(hw);
> > >  error_out2:
> > >         _rtl_usb_io_handler_release(hw);
> >
> > I think deinit should be in reverse order of init step by step:
>=20
> Well, I kept the order that they appear in the remove path. Also, I check=
ed
> that they are not exactly independent and rtl_usb_deinit does not need to
> be called when rtl_init_core fails. I have just checked and it wouldn't
> cause any harm either if rtl_usb_deinit is called in case rtl_init_core
> fails. So either way should be fine.

Well. Original implementation of the workqueue is not symmetric. Without
real hardware verification, we can't move the code of destroy queue from
rtl_usb_deinit() to rtl_deinit_core().=20



