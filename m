Return-Path: <linux-wireless+bounces-27457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7FEB83019
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CC34A3FD8
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 05:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9D629BDA3;
	Thu, 18 Sep 2025 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vLT5PifE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3203281375;
	Thu, 18 Sep 2025 05:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758173057; cv=none; b=De9fKfgTBjRr2r3NAh3b0uWoDmV0xpVA8V2XpGS8+nC0EY9MlDH0JeDH3gKkZ2hltofqtSoG7sQk6zWWN31u01f2ec1eAQh3ZHlGAYwEVKazsmy/7CdR6T1r+49/KD1QjpQze7hxpiF2g7Hy8/diB+wAjNl3fWudtDjIlT43jio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758173057; c=relaxed/simple;
	bh=FNtiDJXaDF48h0ZpLR5jyntUjXxFv/j2ACZS4RWdxX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g1V4pUujzb1YR5OZ/m/qgBe72pwS/CwzivvCfQGsHRSL+0UrXc6sORsTEgwX2FWAjPn7qLrXd9qtCm043SLv58rrMPJr4j68lp9E+ZoFx5MgcCtLJIznxE91e87V2JchJdJRhA6ICk+p4se69rRvbu1Z+g1T6VBtHK/VO23hWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vLT5PifE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58I5NtZfA1470537, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758173035; bh=yfb0T1IuR01ikSLxgbloRE+lvwhVVb9eeNr2I4REOd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vLT5PifEYz+5bMZHU0JbGeqrcey0TgFdiQCpNX52m33gbKzCJeP+yV89wva7kXfDx
	 k/F5caSsvX+3pIA7bBKqwC+2vghAJI10Rw5/6sRgFnpaR8BRdPUGLjvu6bzV0Bte72
	 VbruOZpJqCZOrxuuCh1Ju65gw7uV74VeQRrmPH3shXfqOdsJKSfxDRMa/3XIK4rN5m
	 lXXuQrEkcIlafZ+aAgnOmcAmErOijBCeRVRLQ4hDFhmBEn9T4Bk0TQ6eEaAbBqyxRW
	 GAITmdapCzkkGu9RmLm5AnvUAP2Abhu6HoCHhXRGm+sY7e0SvptVbQ+fwi38PBMg16
	 GMyHF08ZtDjcw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58I5NtZfA1470537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:23:55 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 18 Sep 2025 13:23:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Sep 2025 13:23:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 18 Sep 2025 13:23:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Fedor Pchelkin
	<pchelkin@ispras.ru>
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
Thread-Index: AQHcJ7j9ihvmCigyUEi4g4qppzNcU7SYSUhg//+OAICAAJEK0A==
Date: Thu, 18 Sep 2025 05:23:54 +0000
Message-ID: <8aa1fe0b49dd49408dc26ad48ba9a605@realtek.com>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-2-pchelkin@ispras.ru>
 <391e7cc762a549b7826e72090b61ebb2@realtek.com>
 <5d1be8c759c243f9a331c672cc301bbc@realtek.com>
In-Reply-To: <5d1be8c759c243f9a331c672cc301bbc@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Zong-Zhe Yang <kevin_yang@realtek.com> wrote:
> Ping-Ke Shih <pkshih@realtek.com> wrote:
> >
> > Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> >
> > [...]
> >
> > > @@ -6181,6 +6187,27 @@ rtw89_assoc_link_rcu_dereference(struct rtw89_=
dev *rtwdev,
> > u8 macid)
> > >         list_first_entry_or_null(&p->dlink_pool,
> > > typeof(*p->links_inst), dlink_schd); \
> > >  })
> > >
> > > +static inline void rtw89_tx_wait_release(struct rtw89_tx_wait_info
> > > +*wait) {
> > > +       dev_kfree_skb_any(wait->skb);
> > > +       kfree_rcu(wait, rcu_head);
> > > +}
> > > +
> > > +static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev=
)
> > > +{
> > > +       struct rtw89_tx_wait_info *wait, *tmp;
> > > +
> > > +       lockdep_assert_wiphy(rtwdev->hw->wiphy);
> > > +
> > > +       list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) =
{
> > > +               if (!wait_for_completion_timeout(&wait->completion,
> > > +
> > RTW89_TX_WAIT_DEFAULT_TIMEOUT))
> > > +                       continue;
> >
> >
> > Why should we wait 10ms? Just try_wait_for_completion()?
> >
> > Since TX completion might be missing (rtw89_core_stop(), for example), =
shouldn't we
> > unconditionally free all in wait list for that case?
> >
>=20
> In hci reset (when we release pending skb), the condition will become tru=
e.
> So, all left will be freed at that time. Before that, there is no logic t=
o ensure no
> more completing side, so it cannot be unconditionally freed unless we don=
't
> want to double check if those, which timed out, are done at some moment.
>=20
> (e.g. core stop will do hci reset)

Thanks for the explanation.=20

Just consider try_wait_for_completion() then.

By the way, if want a delay for timeout case, use delayed work for tx_wait_=
work
instead.

>=20
> >
> > > +               list_del(&wait->list);
> > > +               rtw89_tx_wait_release(wait);
> > > +       }
> > > +}
> > > +
> > >  static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
> > >                                      struct rtw89_core_tx_request *tx=
_req)
> > >  {
> >


