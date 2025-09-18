Return-Path: <linux-wireless+bounces-27451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769CB82E53
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 06:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBE2720937
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 04:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71826B748;
	Thu, 18 Sep 2025 04:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TPTPr6go"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A1A927;
	Thu, 18 Sep 2025 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170477; cv=none; b=LhmP8jvm81c+wuZp1+8eUcSbHYQOReULCf3umJeRKdH4YVlLpDD9+6/QHcBhVq7e9BQYj5G4JG/SG4CxpvkNce5G0bZuWq0xxhElkK0EgFmwIe3cdCeliZL0k2w2tK/NNtexTd4D46E65aWZTJS02efL1X/qbtfVHhOzKe6vZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170477; c=relaxed/simple;
	bh=iSYFMZqhj4d3SEmsZt3/e4nFXjRUzaJHc/adW9lJy8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HpwIIx8AtdzEbtM/Q88MMD9xCotXZz0vd2VAIkl02f2Pj7Kv1JZ7Rfnvz+6z1vtidU3XNV+qKsuGgn2bAzZyOe3rwOX/7m3utbA+JupNdyud7+gAzaExZGDFZ75hiI7QVRKjVT43R7gSOoZDlupY09oRRG1rOenbuD1BGo4PxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TPTPr6go; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58I4etnsF1415576, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758170455; bh=/CVPwzFo6PS4n6NaipXzZ7iXwxD1VUr8Nz2Q1uygYD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=TPTPr6goR9wYp5zNOXbLvuxXKVk9xFrWAulHx3ZEhEHgPzKsP97iC37+4i0DHY5e1
	 CAK1/H2ZFuGojGV58w0/uaOAmLiopIhOZmvmzLl1VvUVvQHC+xHK4eD2jXWwxSWtla
	 X+PRlOAT1zcyMmQ+TTG/NJfZhntFuh3SICX9LxcQoxNgg40E3X+8ZDSQtG1uo3H5fG
	 R0L5ZjJxavQw3vl9AXblv8/D+tUsQLHnLT+Qz1SWCpOG/Nx+GiHVgSuy+PCqymM+F9
	 pFDi0Lt+nhIQ9AJzo7Z1fw6Yd8zlC7i/2lEy7m0bEZXq2j3a72zGgd+U/+1b/GumRb
	 BN/1XYo0/K9vQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58I4etnsF1415576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 12:40:55 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 18 Sep 2025 12:40:55 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d]) by
 RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d%2]) with mapi id
 15.01.2507.035; Thu, 18 Sep 2025 12:40:55 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Fedor Pchelkin <pchelkin@ispras.ru>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw v4 1/4] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Thread-Topic: [PATCH rtw v4 1/4] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Thread-Index: AQHcJ7j/vEuNy2lZBU2DsVQK/TMuArSXy+SAgACHisA=
Date: Thu, 18 Sep 2025 04:40:55 +0000
Message-ID: <5d1be8c759c243f9a331c672cc301bbc@realtek.com>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-2-pchelkin@ispras.ru>
 <391e7cc762a549b7826e72090b61ebb2@realtek.com>
In-Reply-To: <391e7cc762a549b7826e72090b61ebb2@realtek.com>
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
>=20
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
>=20
> [...]
>=20
> > @@ -6181,6 +6187,27 @@ rtw89_assoc_link_rcu_dereference(struct rtw89_de=
v *rtwdev,
> u8 macid)
> >         list_first_entry_or_null(&p->dlink_pool,
> > typeof(*p->links_inst), dlink_schd); \
> >  })
> >
> > +static inline void rtw89_tx_wait_release(struct rtw89_tx_wait_info
> > +*wait) {
> > +       dev_kfree_skb_any(wait->skb);
> > +       kfree_rcu(wait, rcu_head);
> > +}
> > +
> > +static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev)
> > +{
> > +       struct rtw89_tx_wait_info *wait, *tmp;
> > +
> > +       lockdep_assert_wiphy(rtwdev->hw->wiphy);
> > +
> > +       list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
> > +               if (!wait_for_completion_timeout(&wait->completion,
> > +
> RTW89_TX_WAIT_DEFAULT_TIMEOUT))
> > +                       continue;
>=20
>=20
> Why should we wait 10ms? Just try_wait_for_completion()?
>=20
> Since TX completion might be missing (rtw89_core_stop(), for example), sh=
ouldn't we
> unconditionally free all in wait list for that case?
>=20

In hci reset (when we release pending skb), the condition will become true.
So, all left will be freed at that time. Before that, there is no logic to =
ensure no
more completing side, so it cannot be unconditionally freed unless we don't
want to double check if those, which timed out, are done at some moment.

(e.g. core stop will do hci reset)

>=20
> > +               list_del(&wait->list);
> > +               rtw89_tx_wait_release(wait);
> > +       }
> > +}
> > +
> >  static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
> >                                      struct rtw89_core_tx_request *tx_r=
eq)
> >  {
>=20


