Return-Path: <linux-wireless+bounces-14802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 045239B8A38
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 05:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9565BB21C04
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 04:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B9146A72;
	Fri,  1 Nov 2024 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="b06df2ql"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C727211C;
	Fri,  1 Nov 2024 04:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730434978; cv=none; b=F1yibXX0Kq8qoAsDIc0t788Aaiszag3dimCtLc34k0jvQLVrjYSPuGbfxLpzPwfmT2ZFpG2XNFJXmcfnLUTFjSptGSbg1eZM4vmZAqOIHn5JspdGxRB+GduxEMhpxgEwoI5zkcYQfGBg3CG7Amy9Bay7BrEBLMzqOQKns2Z8NFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730434978; c=relaxed/simple;
	bh=+R9vhprP6Pe387Q5ueLIl38bbj6vgw38MdtuxGVbax4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L7+/qgp1c2WvUxJKFabj8Y4cK2vfoK/CVaG/BMY5I1wEPtqIvpcbkomJG2pYokfaWIvTmuTwoNjAYwx4nzgElvs0t4YPQVDiTis9tfjicFP2hsqjEahiDyvPHnY3AqaySKr1LxA5OtLvWCNf0dV+fG9GhnZy6LluLyO1i+B2SMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=b06df2ql; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A14MJOf82509540, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730434939; bh=+R9vhprP6Pe387Q5ueLIl38bbj6vgw38MdtuxGVbax4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=b06df2ql6dP0by1U8c3jHx/U9S6Qp0Ryu8CAR0u9OJBw8ulYZYN2Dze7myCFEzbFE
	 IgnlmpGIKXj5rySbkgqYPKHE07agwDwb4EicBkYLcrjlmC7OVC18qHhpryfUQImsi2
	 n4QLwS7ErFzwovEexr8JQr0/pZDfP74J1pHqXciEeiict0xX20J12IjyDaiyL4WY55
	 BW2YUnyqu+JUGsma9xMQYyPt1wCPJ1azEbvOX90WH9MKw9fNqqI5gx7+MGo41FR3tq
	 u48Gh+x2dN/hc7PCMNuQfF0GtZzSyRFdrl3jypqIdZQsH4wMdvoRmvPAmg/DQ4nd85
	 512wP5cnF4uOg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A14MJOf82509540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Nov 2024 12:22:19 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 12:22:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Nov 2024 12:22:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 1 Nov 2024 12:22:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
	<syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
Subject: RE: [PATCH V3] wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures
Thread-Topic: [PATCH V3] wifi: rtlwifi: Drastically reduce the attempts to
 read efuse in case of failures
Thread-Index: AQHbK62jzL4hMAZxOk2XHUy0QNETw7Kh0tAg
Date: Fri, 1 Nov 2024 04:22:19 +0000
Message-ID: <8363b94ee45c49c0996b12010c18b9f0@realtek.com>
References: <20241031155731.1253259-1-gpiccoli@igalia.com>
In-Reply-To: <20241031155731.1253259-1-gpiccoli@igalia.com>
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

Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
> diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c
> b/drivers/net/wireless/realtek/rtlwifi/efuse.c
> index 82cf5fb5175f..0ff553f650f9 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
> @@ -162,9 +162,19 @@ void efuse_write_1byte(struct ieee80211_hw *hw, u16 =
address, u8 value)
>  void read_efuse_byte(struct ieee80211_hw *hw, u16 _offset, u8 *pbuf)
>  {
>         struct rtl_priv *rtlpriv =3D rtl_priv(hw);
> +       u16 retry, max_attempts;
>         u32 value32;
>         u8 readbyte;
> -       u16 retry;
> +
> +       /*
> +        * In case of USB devices, transfer speeds are limited, hence
> +        * efuse I/O reads could be (way) slower. So, decrease (a lot)
> +        * the read attempts in case of failures.
> +        */
> +       if (rtlpriv->rtlhal.interface =3D=3D INTF_PCI)
> +               max_attempts =3D 10000;
> +       else
> +               max_attempts =3D 10;

As your comment, setting max_atttempts to 10 under condition of INTF_USB wo=
uld
be more reasonable, like

    u16 max_attempts =3D 10000;

    if (rtlpriv->rtlhal.interface =3D=3D INTF_USB)
        max_attempts =3D 10;




