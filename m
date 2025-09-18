Return-Path: <linux-wireless+bounces-27449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8B1B82D6D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 06:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035F44A076B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 04:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD3244662;
	Thu, 18 Sep 2025 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fPw3eB8w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BD7241664;
	Thu, 18 Sep 2025 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758168037; cv=none; b=oAxaVuKFp0QTUXC8CnjZlYZYi2uxxomD4jz0BP03xF4Vr4Ts3If/WM5VlkspdeMUjTqVHG7NSFjYvKFdKBF4w2NIAJ2clobxR/okj3lBezcCwTe4T8wqnFhQxRIBdCVEIDwLxGmvZ6b3lnaRfKEdU1+pXfN57c2afB94RmdDhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758168037; c=relaxed/simple;
	bh=afjM9h6h+iyrSkWCeooIuUGSF4sz2XGs7yO7jWty1uw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N4o5ejX7DYyDGN4uUTQw3bgzMAtU9lzSN2TX3Fn6RdMz4H6Lhu7sgdA8eWJIQ6eLOTGF7xC/cT76rXmw4zOwPcGw90xXLPnXNhhl9sHNV6D7tBRvCJc9zzNvGxPb5lyrgS1aZ6S/v2NGs/yRdVuHFmT1qAmC1dW/WMT1bETs4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fPw3eB8w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58I409oY41366026, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758168009; bh=bSYjaCMBA5N0RZxLFxXWqR8CkeiHrM8cDyTs9gHcRyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fPw3eB8wn2WwuM/EruD0ofNNWCuzfp1f5//wtr0ReZYLVs7NhAVRcjdYltzcQIwix
	 IFPj+KZuIpGSgya59q2ofnTjpLNyr4lI779PVSViT9kvC/ItcJairikEN3LTc5bb2A
	 wYCfs4AX8jm4WW1BOl7aKfvaePdcoVHc3H7FNzQBpOyNlKcWcH7dWCSIdjxZ3g/u0M
	 J0yk7si9DAI3Y2EzAdcqcZHrwni8QGC7xllmgeCoDmDJtTi7EB6cHcFkeKKzGML1/P
	 cSqF8OjvgX5l/RyCmm5TYMbS9gJR3MN7TWdX/zoFXh2bc6S8oiMbSSOzucVJyX4nbe
	 JRVLH6kzIdyXQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58I409oY41366026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 12:00:09 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 18 Sep 2025 12:00:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Sep 2025 12:00:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 18 Sep 2025 12:00:09 +0800
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
Subject: RE: [PATCH rtw v4 1/4] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Thread-Topic: [PATCH rtw v4 1/4] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Thread-Index: AQHcJ7j9ihvmCigyUEi4g4qppzNcU7SYSUhg
Date: Thu, 18 Sep 2025 04:00:09 +0000
Message-ID: <391e7cc762a549b7826e72090b61ebb2@realtek.com>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-2-pchelkin@ispras.ru>
In-Reply-To: <20250917095302.2908617-2-pchelkin@ispras.ru>
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

[...]

> @@ -6181,6 +6187,27 @@ rtw89_assoc_link_rcu_dereference(struct rtw89_dev =
*rtwdev, u8 macid)
>         list_first_entry_or_null(&p->dlink_pool, typeof(*p->links_inst), =
dlink_schd); \
>  })
>=20
> +static inline void rtw89_tx_wait_release(struct rtw89_tx_wait_info *wait=
)
> +{
> +       dev_kfree_skb_any(wait->skb);
> +       kfree_rcu(wait, rcu_head);
> +}
> +
> +static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev)
> +{
> +       struct rtw89_tx_wait_info *wait, *tmp;
> +
> +       lockdep_assert_wiphy(rtwdev->hw->wiphy);
> +
> +       list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
> +               if (!wait_for_completion_timeout(&wait->completion,
> +                                                RTW89_TX_WAIT_DEFAULT_TI=
MEOUT))
> +                       continue;


Why should we wait 10ms? Just try_wait_for_completion()?

Since TX completion might be missing (rtw89_core_stop(), for example),=20
shouldn't we unconditionally free all in wait list for that case?


> +               list_del(&wait->list);
> +               rtw89_tx_wait_release(wait);
> +       }
> +}
> +
>  static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
>                                      struct rtw89_core_tx_request *tx_req=
)
>  {



