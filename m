Return-Path: <linux-wireless+bounces-15021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B99BFA9B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 01:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64EC7B21865
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 00:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88829802;
	Thu,  7 Nov 2024 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WwXLfNQz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4E7F9
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938659; cv=none; b=p/aMLpfG3unHTcSoVUzqRzowvc9yMr97jV2CpDSRyq5p5TBT2+YX6J7ThjxV+90L++nurkSeWYhfw0Zr6W4vcdSOJ4Qu6jRgb2WvyGf0R8S1+4qgOF+vzTRwvU2+tLzo6JMFnMTTHXIRl1kmYyxCOhXAvdcDKwLdUQiCHa4+Pw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938659; c=relaxed/simple;
	bh=XR5CPjtvZ9s0cmstv99RTNQqKlRec8iCXpqWNaomN6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bMqzPulHvMXRWHN994fhHs9MtRemcs5a6r7m8qNDiuhUDEgVJZc8RK2y2+MiiqGD4nqcu+9lnOwvGgLXFzHS0QpHsU4Bw2EkfKAF2kBV7HVZ4udgUWJD1dZg7q7C8tVglcIwCFuTZ28hL/Ee3aDyfkeH5sbAVbKfo04zHkISvPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WwXLfNQz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A70HFt943562195, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730938635; bh=XR5CPjtvZ9s0cmstv99RTNQqKlRec8iCXpqWNaomN6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WwXLfNQzADNnz/gabRMtRxEsaLOyLtzGS0tiBYv/JJzu0yPfzLSX+JiCDI1K4kobl
	 Lg48ZWBtHZDuHNP6RwLBxZE3ou6Z5cwFcF2Sn1XkLGD+7kSsRDvv+rhVtmcI3A4d85
	 JncRFqyydwfQjSjSmjvkWKpVn/uNb8RmYzM/p/UtZZiPupUjoBlGA8pgc4nRvNTjnh
	 SFgU8KSwi7ARX2NveuR49VL5s6UXDxlAaFPx0S8uTd6n7183lex7jugeYkrVGXZTFL
	 nbWUjaHotvNXo5PyVrBYmWGejNy+9STwrGbVJUyEyTr93/DkfAxBiN0M0UxSXxwbni
	 RVqHx7Pe8VEEA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A70HFt943562195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 08:17:15 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 08:17:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Nov 2024 08:17:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 7 Nov 2024 08:17:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ladislav Michl <oss-lists@triops.cz>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "pbrobinson@gmail.com" <pbrobinson@gmail.com>
Subject: RE: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
Thread-Topic: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to
 purge TX skb
Thread-Index: AQHa9DSxPPAHrjHHCkiWzpTbPs2zeLKoc5iAgAGerMD//90HgIABfEmA
Date: Thu, 7 Nov 2024 00:17:14 +0000
Message-ID: <5e49875a73214c89bb6220ddb54a1c15@realtek.com>
References: <20240822014255.10211-1-pkshih@realtek.com>
 <20240822014255.10211-2-pkshih@realtek.com> <Zyn5WcUGoibH7-s8@lenoch>
 <d78848f7768a4bdabf92e053525d232d@realtek.com> <Zys33cLsOuMGaRek@lenoch>
In-Reply-To: <Zys33cLsOuMGaRek@lenoch>
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

Ladislav Michl <oss-lists@triops.cz> wrote:
> On Wed, Nov 06, 2024 at 03:43:24AM +0000, Ping-Ke Shih wrote:
> > Ladislav Michl <oss-lists@triops.cz> wrote:
> > > On Thu, Aug 22, 2024 at 09:42:55AM +0800, Ping-Ke Shih wrote:
> > > > When removing kernel modules by:
> > > >    rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core
> > > >
> > > > Driver uses skb_queue_purge() to purge TX skb, but not report tx st=
atus
> > > > causing "Have pending ack frames!" warning. Use ieee80211_purge_tx_=
queue()
> > > > to correct this.
> > > >
> > > > Since ieee80211_purge_tx_queue() doesn't take locks, to prevent rac=
ing
> > > > between TX work and purge TX queue, flush and destroy TX work in ad=
vance.
> > >
> > > A the very same problem exists in 6.1 kernel series, where this patch
> > > becomes oneliner:
> >
> > linux-6.1.y branch doesn't have patch that exports ieee80211_purge_tx_q=
ueue().
>=20
> Sure, but that one applies with a little fuzz.
>=20
> > > ---
> > >  drivers/net/wireless/realtek/rtw88/main.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/=
wireless/realtek/rtw88/main.c
> > > index 81f3112923f1..d7d4b0f05da9 100644
> > > --- a/drivers/net/wireless/realtek/rtw88/main.c
> > > +++ b/drivers/net/wireless/realtek/rtw88/main.c
> > > @@ -2145,7 +2145,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
> > >
> > >         destroy_workqueue(rtwdev->tx_wq);
> > >         spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
> > > -       skb_queue_purge(&rtwdev->tx_report.queue);
> > > +       ieee80211_purge_tx_queue(rtwdev->hw, &rtwdev->tx_report.queue=
);
> > >         skb_queue_purge(&rtwdev->coex.queue);
> > >         spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
> > >
> >
> > Seemingly, we need below also?
>=20
> Perhaps I was lucky enough I never hit it here, but for a sake of complet=
eness
> it should be there as well.
>=20
> > diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wire=
less/realtek/rtw88/tx.c
> > index 6ed470dd6f22..224678b9c38b 100644
> > --- a/drivers/net/wireless/realtek/rtw88/tx.c
> > +++ b/drivers/net/wireless/realtek/rtw88/tx.c
> > @@ -188,7 +188,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t=
)
> >         rtw_warn(rtwdev, "failed to get tx report from firmware\n");
> >
> >         spin_lock_irqsave(&tx_report->q_lock, flags);
> > -       skb_queue_purge(&tx_report->queue);
> > +       ieee80211_purge_tx_queue(&tx_report->queue);
> >         spin_unlock_irqrestore(&tx_report->q_lock, flags);
> >  }
> >
> > Have you seen "Have pending ack frames!" in your side?
>=20
> Yes.
>=20
> > If so, use above changes to verify again on the latest kernel, and send=
 a patch?
>=20
> Do you mean to send a patch against linux-6.1.y stable tree? I can see yo=
ur
> patch in wireless-next only, so I do not think sending it to stable now w=
ould
> work. But in general, having this fix in the stable trees is a good idea.

I meant to send a patch to wireless-next. After it gets merged, send anothe=
r
backport patchset related to the warning to 6.1 and 6.6.=20



