Return-Path: <linux-wireless+bounces-27460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA0FB830A6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6CE328891
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 05:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E216A2749DC;
	Thu, 18 Sep 2025 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hTnmOgdw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B8534BA25;
	Thu, 18 Sep 2025 05:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174480; cv=none; b=fih6XkmeccJxD1zR4bsDrL6Sjel8pRXRwceKdbcrKfhRrC6fsAOlfxU9wlKbGyTJc7DDbHnHRkuLhMs5xKhX971+9UGW+leshIZ1H9s/WjHVjEXYXDynIiK0DzMjqqUdcUSTg1oekBlNqT3LvjNNx96CPJPTrTG6m8W3xaKspds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174480; c=relaxed/simple;
	bh=xFolDp6332lIWG99mEFJizjdgDigvfEDxo/ur2b0P4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j840L6B3c6VKfExrQLcT9vfXSm6l27KebFZ3L8djh7TvSFRPw71Ts1d/C3dwppDWEI1MXY+V/NcsTfnlIIfwKGHvtNoQutLC2RmGRDgmoRMk4A0m8J/eOuspsBt+ZslypFN3rzJBvihydm7Y9BbR3N4wFn2RCHPPeiGGxBSfIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hTnmOgdw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58I5lbj771492350, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758174458; bh=VcK/+TIWcIi6qrGqFh/AmAAydzMYa/+PBfAEj6GfuUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hTnmOgdwzXUbW0fs7g2kp/xNrVynWOZRMabN0F2H8Ve6wJrWF3stzSeAC0ni9Ef/5
	 VbL91eTeZ5xHkIXRb1DY9TORDo1kTQvVm5N+Qi0GMqpcOBUpYKIiNgDPYUhGb1zPz+
	 QtzHnUP2+AXYCi4p5+NrycZarX7K5QNgs2zuRG3V8ghdgXr3r1D7eRTriiz8fTumcu
	 101XbG7BAOdAs5cU9cVrSGtnS76VRAj7qj57rRiYn1EzWoJHKQuETe9fMEKAP3O3IE
	 NpZNt9THMe5Z0SkHFjPICeK4utB9DP1IVNRgfOva6KR0mO/lHr4z+mQP0JeoUfj3Yq
	 TgBPjtnNAs0pQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58I5lbj771492350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:47:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 18 Sep 2025 13:47:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 18 Sep 2025 13:47:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>
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
Subject: RE: [PATCH rtw v4 2/4] wifi: rtw89: fix tx_wait initialization race
Thread-Topic: [PATCH rtw v4 2/4] wifi: rtw89: fix tx_wait initialization race
Thread-Index: AQHcJ7j8gFkFIGygsECCjdEXp53dJbSYbw2Q
Date: Thu, 18 Sep 2025 05:47:37 +0000
Message-ID: <08b25263c6874a089e4a271cb95a9cb7@realtek.com>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-3-pchelkin@ispras.ru>
In-Reply-To: <20250917095302.2908617-3-pchelkin@ispras.ru>
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
> Now that nullfunc skbs are recycled in a separate work item in the driver=
,
> the following race during initialization and processing of those skbs
> might lead to noticeable bugs:
>=20
>       Waiting thread                          Completing thread
>=20
> rtw89_core_send_nullfunc()
>   rtw89_core_tx_write_link()
>     ...
>     rtw89_pci_txwd_submit()
>       skb_data->wait =3D NULL
>       /* add skb to the queue */
>       skb_queue_tail(&txwd->queue, skb)
>                                             rtw89_pci_napi_poll()
>                                             ...
>                                               rtw89_pci_release_txwd_skb(=
)
>                                                 /* get skb from the queue=
 */
>                                                 skb_unlink(skb, &txwd->qu=
eue)
>                                                 rtw89_pci_tx_status()
>                                                   rtw89_core_tx_wait_comp=
lete()
>                                                   /* use incorrect skb_da=
ta->wait */
>   rtw89_core_tx_kick_off_and_wait()
>   /* assign skb_data->wait but too late */

How will we receive tx completion before TX kick off?=20
(see the original code below)

[...]

> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wire=
less/realtek/rtw89/core.c
> index 438930b65631..1efe4bb09262 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1094,22 +1094,13 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_=
dev *rtwdev, struct sk_buff *sk
>                                     int qsel, unsigned int timeout)
>  {
>         struct rtw89_tx_skb_data *skb_data =3D RTW89_TX_SKB_CB(skb);
> -       struct rtw89_tx_wait_info *wait;
> +       struct rtw89_tx_wait_info *wait =3D wiphy_dereference(rtwdev->hw-=
>wiphy,
> +                                                           skb_data->wai=
t);

Can't we just pass 'wait' by function argument?

>         unsigned long time_left;
>         int ret =3D 0;
>=20
>         lockdep_assert_wiphy(rtwdev->hw->wiphy);
>=20
> -       wait =3D kzalloc(sizeof(*wait), GFP_KERNEL);
> -       if (!wait) {
> -               rtw89_core_tx_kick_off(rtwdev, qsel);
> -               return 0;
> -       }
> -
> -       init_completion(&wait->completion);
> -       wait->skb =3D skb;
> -       rcu_assign_pointer(skb_data->wait, wait);
> -

Here, original code prepares completion before TX kick off. How it could
be a problem? Do I miss something?

>         rtw89_core_tx_kick_off(rtwdev, qsel);
>         time_left =3D wait_for_completion_timeout(&wait->completion,
>                                                 msecs_to_jiffies(timeout)=
);



