Return-Path: <linux-wireless+bounces-27641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B142AB9D52E
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 05:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D617AD750
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 03:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026962DEA80;
	Thu, 25 Sep 2025 03:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dxZjIb72"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A6233134;
	Thu, 25 Sep 2025 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758771577; cv=none; b=Ngh/ljjI+UIMblyIGCeQyu6Sx7ZkerDgff3UE71oD7gdtY71ykRk90J6M9ercLSJNiW8Vf8NOZxkQTNvqzhjK97eXjzj9T33Ip8y5PDvMomc1LUaRAOANCpes/P5gmHzkaIjrj5FmkRrJkEHtnqSt/vm5sNUH1ppq26pWag690A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758771577; c=relaxed/simple;
	bh=XPuiJTetrA6TzrhKGeU6oChWLgdR6/7myg5dufXg3MY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rN/NbHh5tyOhHBg8bU9DjUfErKwtrAQxaMu5UbQdq0X7WuyEypvrz/22JjZ4soCA9r4MirFJlY3iamPwF7kXN5C7qrQDhVnslhaDa4y7Sq2k6MCgCnXOpxQAsvXsKityV+aSf2MxwmL3L+7Xv8R8XK9J001/jq/hcD1AhCH+5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dxZjIb72; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58P3dEgeD589309, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758771554; bh=UBK/F3gJ4sbQkkaxgyTqVjw8gDtHVjsoI3s75BRHtoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dxZjIb72q2Yt/ZUzQ2OLkwbjmMQdOEQfZd7Om1WS7xyAbndzVsTIbc8mE3i2ctVbp
	 GPt2JAk9LAIgw734JvvhMvhITwlvVbp+4/ROs1rw0xRYIlUn+nb3hSjcrpACdAg47V
	 K6Pd1JvUW1dJCbVEmZF8MfRfSp2hu+0nwGr+U2OHxuTdQzIdQsCICrgaN4UNCcEV3r
	 4ugIRSPFwPBV4GiBkh+iCBUNbVAOKZ59UAw12klcd/BrCkJ98nlE66ukAuCFg/k5/c
	 zxQcwlchdC1HynxnQUbVf3gQlbRx1oujQafiYSABdxQpVnJPn5iJC+TtKqJ5HszMND
	 ne4kO2rJ+XeWQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58P3dEgeD589309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 11:39:14 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 25 Sep 2025 11:39:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 25 Sep 2025 11:39:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 25 Sep 2025 11:39:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next 5/6] wifi: rtw89: process TX wait skbs for USB via C2H handler
Thread-Topic: [PATCH rtw-next 5/6] wifi: rtw89: process TX wait skbs for USB
 via C2H handler
Thread-Index: AQHcKjJdzKHdGQymJEGBjGH1ND0qlLSjQH4w
Date: Thu, 25 Sep 2025 03:39:14 +0000
Message-ID: <c2c40bed311c4f05948cf2541c64ea30@realtek.com>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-6-pchelkin@ispras.ru>
In-Reply-To: <20250920132614.277719-6-pchelkin@ispras.ru>
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

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> TX wait skbs need to be completed when they are done.  PCIe part does thi=
s
> inside rtw89_pci_tx_status() during RPP processing.  Other HCIs use a
> mechanism based on C2H firmware messages.
>=20
> Store a sequence number in a TX wait object so that it'll be possible to
> identify completed items inside C2H handler.  No need to add the
> corresponding skb to the &txcb->tx_ack_queue on USB part.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

[...]

> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wirel=
ess/realtek/rtw89/mac.c
> index 831e53aedccc..79409eb4d028 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5477,6 +5477,7 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, stru=
ct sk_buff *c2h, u32 len)
>  {
>         u8 sw_define =3D RTW89_GET_MAC_C2H_TX_RPT_SW_DEFINE(c2h->data);
>         u8 tx_status =3D RTW89_GET_MAC_C2H_TX_RPT_TX_STATE(c2h->data);
> +       struct rtw89_tx_wait_info *wait;
>         struct sk_buff *cur, *tmp;
>         unsigned long flags;
>         u8 *n;
> @@ -5485,6 +5486,16 @@ rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, str=
uct sk_buff *c2h, u32 len)
>                     "C2H TX RPT: sn %d, tx_status %d\n",
>                     sw_define, tx_status);
>=20
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(wait, &rtwdev->tx_waits, list) {
> +               if (wait->sn =3D=3D sw_define) {
> +                       wait->tx_done =3D tx_status =3D=3D RTW89_TX_DONE;
> +                       complete_all(&wait->completion);
> +                       break;
> +               }
> +       }
> +       rcu_read_unlock();
> +

Since we can get 'wait' from RTW89_TX_SKB_CB(), can we just use
rtwdev->tx_rpt_queue?

Also, call rtw89_core_tx_wait_complete() to complete wait?

>         spin_lock_irqsave(&rtwdev->tx_rpt_queue.lock, flags);
>         skb_queue_walk_safe(&rtwdev->tx_rpt_queue, cur, tmp) {
>                 n =3D (u8 *)RTW89_TX_SKB_CB(cur)->hci_priv;



