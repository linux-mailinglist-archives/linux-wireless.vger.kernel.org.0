Return-Path: <linux-wireless+bounces-27551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD25B8EAA7
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 03:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6D7189A1B5
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 01:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E861713C695;
	Mon, 22 Sep 2025 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZDPXxArJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E61805E;
	Mon, 22 Sep 2025 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504043; cv=none; b=S3YmXZgLALufix6CyCZbln5BAN1uUg5Eyj5mU+LRd5DK5jvIHRQP8fAkjgFxpjuY1JZnf02aFwWuFpuiqhbELrSrE8hxS+7NMGEJiN6phm2KoXTrCGDyjaN6vDriqKSs5EPaXWq1WZ9fOKqMHqzGSwdEuiKG+87M3TInRUC4Fe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504043; c=relaxed/simple;
	bh=6l9Y4C/duqK/lyGI2pC1y6n1jf0gIfzWiRWkMO0xh8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8MFHCrPIX+PScRQDKVeGkqJoXty9fc7u0TG+S6vBVjuckNLd2134Ppqw1m1x4wIx46/psDMeyVfk0rr3xjYlfkmgi8Rm7NS+Xs+L9dKf8L9BnVJXYerTx01iFiyxde3hkD2Me0qfghmMqdv2AwfiCSLSd1hQeNcdnuRBSdrgfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZDPXxArJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58M1KPQf83496570, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758504026; bh=vXg4a5VuQzcR91nfayU5hI1RVwFLygEJv+RdDtbf4O0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZDPXxArJa79DpJwbc/+5k1p85Va7KmsPPQRzaMXJY43XH6ZzW2DlQOFyBuHcGgPEh
	 ZZudFMFGvWl76dxo/ltowsDS3BxA8CcvZRsjAJptqBfwZISKk3qMBmItECKu1Xw1Sd
	 qdN44ar0FiYCRDSYC/Ra8YcaOUthET27CKF21FHNfRrP9CBMWgveijm9nqcFASgJL8
	 PJ7ZDMQ85Ocr3oPrm8M/IDb1KfVi7GO+9fZOrY29TMabSOxscO15/AhMgG07+ZSDl7
	 17MiXtZ4Kvbjm95djlxXS0t4n/DMsYx1h9EdZUTE2Iwav1cfd+L5N60EMRkjiHyYZV
	 FwHCHrGHNNhBg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58M1KPQf83496570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 09:20:26 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 09:20:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 09:20:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Mon, 22 Sep 2025 09:20:25 +0800
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
Subject: RE: [PATCH rtw-next v5 2/4] wifi: rtw89: avoid possible TX wait initialization race
Thread-Topic: [PATCH rtw-next v5 2/4] wifi: rtw89: avoid possible TX wait
 initialization race
Thread-Index: AQHcKan4kgPq+mq9eUqOfjqb4dlxI7SearVA
Date: Mon, 22 Sep 2025 01:20:25 +0000
Message-ID: <73dfdd41cf9c422c8cd18d41ab3dd1ec@realtek.com>
References: <20250919210852.823912-1-pchelkin@ispras.ru>
 <20250919210852.823912-3-pchelkin@ispras.ru>
In-Reply-To: <20250919210852.823912-3-pchelkin@ispras.ru>
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
> The value of skb_data->wait indicates whether skb is passed on to the
> core mac80211 stack or released by the driver itself.  Make sure that by
> the time skb is added to txwd queue and becomes visible to the completing
> side, it has already allocated and initialized TX wait related data (in
> case it's needed).
>=20
> This is found by code review and addresses a possible race scenario
> described below:
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
>=20
>   /* another thread (e.g. rtw89_ops_tx) performs TX kick off for the same=
 queue */
>=20
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
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: 1ae5ca615285 ("wifi: rtw89: add function to wait for completion of=
 TX skbs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


