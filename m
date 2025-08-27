Return-Path: <linux-wireless+bounces-26678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A375B37A1B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 08:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B6D1B6335A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 06:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950D4239567;
	Wed, 27 Aug 2025 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="B2SbTLa0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E58186A;
	Wed, 27 Aug 2025 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756274526; cv=none; b=aLalJtt3gJADXoLw130XmVZtVGRhAsQWYfII3NnYH/ssUxTwk94R/OZKAvkLcx9+R9/jpBXtc0xzMGGB6QUIwYn6yld+dPEO0nH/5CvmU+3X3Ub6UO8dv6BSH7No+E2VDstpBpEGcVvjD5ghY87vXFFhkyF9hQiM4nWg6ZUXhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756274526; c=relaxed/simple;
	bh=HWhGJoV5ssE+aP397OMZszIWNaRw6yr66VO6s5alFkk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eq4q0VNoR0ubncYEArcRWgIH/A1LqGr9hcQJcdAit2YHPirJ/BYJM2uk6VRaD1cj7cZngLS8kq5hpcLiNITlt/5strFhm+GG6ncprBEIo/3bqXAv+xApnlqT8zfoj6DdSLF+Z24D1v/QIn1egaKigr1pA7V4If0oWvy33Dvb9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=B2SbTLa0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57R621QL02980532, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756274521; bh=KIVb+4HvtrNUOcoVZ95hxBCBWqZBd1t9atXxBqEI37M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=B2SbTLa0CWPfWEK1P6kyyZRnwZiy+IqEO5KzcH0DFlh/+J7/quRxiRxdccZJgdPsR
	 TN9vjiZirYrrJmMelWuocwE4FHPPISWzCOR4NblVLBlVOjnT3uzVLTCEc20oofbtMm
	 JfxBGcpnVzV75kfv6VF/PSJ/xGqWZ13MG9uJF+fiq/or8eLwkTNJVwOjDipAYEucTt
	 WiCRMqUoZhIemYG9pAwwkThFc1WpycSx65Pfzh4BkTcf+fdQ4ueqRon8sw3ZUqYiXS
	 unkVSR5r3DF4qpVJtt/3kKYTRA4jmCrSTenaJGR6VWr1ThByRGxb59xLz6+DXQgReW
	 MGiIxdM0JzKRw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57R621QL02980532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 14:02:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 27 Aug 2025 14:02:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Wed, 27 Aug 2025 14:02:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
        "open list:REALTEK WIRELESS DRIVER
 (rtw89)" <linux-wireless@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8852bt: Remove redundant off_reverse variables
Thread-Topic: [PATCH] wifi: rtw89: 8852bt: Remove redundant off_reverse
 variables
Thread-Index: AQHcFwgL5yWiVoTtL0GaLbiP5ja9NrR196fQgAAKITA=
Date: Wed, 27 Aug 2025 06:02:01 +0000
Message-ID: <f9fed9cb54004e93b7d330107c93c7b5@realtek.com>
References: <20250827040643.208541-1-liaoyuanhong@vivo.com>
 <07dd869670914c659c98eae0315c704a@realtek.com>
In-Reply-To: <07dd869670914c659c98eae0315c704a@realtek.com>
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

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Liao Yuanhong <liaoyuanhong@vivo.com> wrote:
> > The variable off_reverse and its related code are completely redundant =
in
> > the function. Remove them to clean the code.
> >
> > Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> > ---
> >  drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> > b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> > index d0e299803225..f23754a5c7b9 100644
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> > @@ -1799,22 +1799,14 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev=
, enum rtw89_rf_path path, bool
> o
> >  {
> >         struct rtw89_dpk_info *dpk =3D &rtwdev->dpk;
> >         u8 val, kidx =3D dpk->cur_idx[path];
> > -       bool off_reverse;
> >
> > -       val =3D dpk->is_dpk_enable && !off && dpk->bp[path][kidx].path_=
ok;

Please use this style. Otherwise, compiler warns

../drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c:1803:34: warning: dub=
ious: x & !y


> > -
> > -       if (off)
> > -               off_reverse =3D false;
> > -       else
> > -               off_reverse =3D true;
> > -
> > -       val =3D dpk->is_dpk_enable & off_reverse & dpk->bp[path][kidx].=
path_ok;
> > +       val =3D dpk->is_dpk_enable & !off & dpk->bp[path][kidx].path_ok=
;
>=20
> The previous patch has merged. Please re-spin this patch on top of rtw-ne=
xt [1].
> The subject should be "[PATCH rtw-next]", so NIPA can do correct tree sel=
ection.
>=20
> [1] https://github.com/pkshih/rtw.git rtw-next
>=20
> >
> >         rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx=
 << 2),
> >                                BIT(24), val);
> >
> >         rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n"=
, path,
> > -                   kidx, str_enable_disable(dpk->is_dpk_enable & off_r=
everse));
> > +                   kidx, str_enable_disable(dpk->is_dpk_enable & !off)=
);
> >  }
> >
> >  static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx=
 phy,
> > --
> > 2.34.1
>=20


