Return-Path: <linux-wireless+bounces-14949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4B69BDDBF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 04:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933291F245F7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 03:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C019047C;
	Wed,  6 Nov 2024 03:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OJ/Y6nZM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF78190468
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 03:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864630; cv=none; b=tkeNwqqI0jj1Wev9wwkHQF/vsvso30JkSph402CFH5C6nw4p3KAQNBoHHkl5lKHY6rqGYEdJalWWSH5G4TfYPM+XSNfEWoC4ZdL1t5Rk+PufEJagSrPaqnV7WTW41AQFH2TX811zEhiuRST7bF73hTUV4Izuln5YBRrpNcBP5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864630; c=relaxed/simple;
	bh=9xUw+s2fVltDhlhLWOwV06zzQxmbco7DifL4B55Bswk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kNcNnmJrOjKYbWXTlp4qYWAJZQ3LOEVe66st63gaTfa45jer5T5UNu6SoXXaPHpqAAEHMusW1G2OuXJFrYwtWaDOELlKKXVwKfn95ZYY4OzugL6j/eZIo2To+EgCf7IwNI9URqOQCzLFwV8qIBP61J75QdWE5Qi1mCM8UHOHzKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OJ/Y6nZM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A63hNbuD2138138, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730864604; bh=9xUw+s2fVltDhlhLWOwV06zzQxmbco7DifL4B55Bswk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=OJ/Y6nZMpSTqInfUgTE78L+JYpOF0qZUcTRevW0TM6itwr7xibrWoxYsQWv12nHxS
	 GVM+Ax7HnT8NaUnGV2RPNW7v6SPqZXJ9ZLXnpL2I8ev+OBSVaaDeGYY0W56RLW4mNO
	 7rFcK+sg1w4T+C8zk2793fxXxfJ19CGnG8s3BlJntf48OZqWuX0tmwNackSIU16BAj
	 5I4bLecq/9jJ6jRsdfvDzbcTGTYDkHZ1WNFpIv8Dqi0qLqgwoK90eUgcYQaYONlZBJ
	 T4WAK9yYTAn5/Q334P5djqStmGDO9tODiMpEB9sk8f6okKFypT4rw/z+s/8wjWYDjD
	 /ojoqGYA0QJKA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A63hNbuD2138138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 11:43:24 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 11:43:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Nov 2024 11:43:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 6 Nov 2024 11:43:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ladislav Michl <oss-lists@triops.cz>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "pbrobinson@gmail.com" <pbrobinson@gmail.com>
Subject: RE: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
Thread-Topic: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to
 purge TX skb
Thread-Index: AQHa9DSxPPAHrjHHCkiWzpTbPs2zeLKoc5iAgAGerMA=
Date: Wed, 6 Nov 2024 03:43:24 +0000
Message-ID: <d78848f7768a4bdabf92e053525d232d@realtek.com>
References: <20240822014255.10211-1-pkshih@realtek.com>
 <20240822014255.10211-2-pkshih@realtek.com> <Zyn5WcUGoibH7-s8@lenoch>
In-Reply-To: <Zyn5WcUGoibH7-s8@lenoch>
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
> On Thu, Aug 22, 2024 at 09:42:55AM +0800, Ping-Ke Shih wrote:
> > When removing kernel modules by:
> >    rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core
> >
> > Driver uses skb_queue_purge() to purge TX skb, but not report tx status
> > causing "Have pending ack frames!" warning. Use ieee80211_purge_tx_queu=
e()
> > to correct this.
> >
> > Since ieee80211_purge_tx_queue() doesn't take locks, to prevent racing
> > between TX work and purge TX queue, flush and destroy TX work in advanc=
e.
>=20
> A the very same problem exists in 6.1 kernel series, where this patch
> becomes oneliner:

linux-6.1.y branch doesn't have patch that exports ieee80211_purge_tx_queue=
().

> ---
>  drivers/net/wireless/realtek/rtw88/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wire=
less/realtek/rtw88/main.c
> index 81f3112923f1..d7d4b0f05da9 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -2145,7 +2145,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
>=20
>         destroy_workqueue(rtwdev->tx_wq);
>         spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
> -       skb_queue_purge(&rtwdev->tx_report.queue);
> +       ieee80211_purge_tx_queue(rtwdev->hw, &rtwdev->tx_report.queue);
>         skb_queue_purge(&rtwdev->coex.queue);
>         spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
>=20

Seemingly, we need below also?=20

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless=
/realtek/rtw88/tx.c
index 6ed470dd6f22..224678b9c38b 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -188,7 +188,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
        rtw_warn(rtwdev, "failed to get tx report from firmware\n");

        spin_lock_irqsave(&tx_report->q_lock, flags);
-       skb_queue_purge(&tx_report->queue);
+       ieee80211_purge_tx_queue(&tx_report->queue);
        spin_unlock_irqrestore(&tx_report->q_lock, flags);
 }

Have you seen "Have pending ack frames!" in your side?
If so, use above changes to verify again on the latest kernel, and send a p=
atch?



