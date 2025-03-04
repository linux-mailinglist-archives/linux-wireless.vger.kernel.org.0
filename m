Return-Path: <linux-wireless+bounces-19744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD2A4D799
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 10:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5751886F5D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E961FA167;
	Tue,  4 Mar 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="knFgDYD6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525B1EB5FE
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079253; cv=none; b=JuDUa4M9Utz0FDXHWr5CI3L8XqXsdK96+uF7NB2Dlo+IOf1GZC3HYJWAQUEnZSw5dJkzCxxeIqG4NXODIz5tK+yuAEzi6yejLIDZAlUY8SG8gxalM++14OrtVtcvyf807Cb+DvW5H+Rinvtt3cE8Affc0SB8wfVQYzq7fHMcvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079253; c=relaxed/simple;
	bh=YMbKoyT5ntVioX3ZPp76o2D1yPMXqlzCJLcvOjHafjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z1LtRumoerYx0hGNflNCFv6mMh/wVGr/boMKBIgxTPiReSZA04NORarUI+Th4yVUReWxCMIooIfqYYYzjJPxFgPVucjDHOP0rnNWwi/Sfo3cy1VKqW147ftEh1vaPbOyxLAZJtxS4i4UwqwcgtQL+3mK6DFITi7wGTqlnp6EFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=knFgDYD6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52496YXT03426696, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741079195; bh=YMbKoyT5ntVioX3ZPp76o2D1yPMXqlzCJLcvOjHafjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=knFgDYD6hohgNXdC99Tret2eJjTkwiJnPxjgOiX2vdiOR5d8LmTTsNPSTzEvMtvif
	 JE0+vgFx2rktX8sbfbFsnQPlvVm01tONJUWSqT+5GIjpWz012ttvclNR9RvNCIe8cb
	 N4NtW/r2NQZpYWZKFhDLEXlZr7VOvigHj2yyRvE/JmtscAl0uWAw3LjpMa51KHEtvz
	 egwa2jTKEfcXbJqdIhSBisEpxIu4wCdV5hOn1xd0zkEFi6texMbI82Bvp46XCDMZMD
	 px/1+hy3C1zfkGxVD/QfyF4qgMJnhFkuafKY/VOjvQnCOWqEs+V1IW3KHg6D13ZgFG
	 Qb74HBIItUyNw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52496YXT03426696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:06:35 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Mar 2025 17:06:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 4 Mar 2025 17:06:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Tue, 4 Mar 2025 17:06:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
        "Sean.Wang@mediatek.com"
	<Sean.Wang@mediatek.com>,
        "Leon.Yen@mediatek.com" <Leon.Yen@mediatek.com>,
        "Michael.Lo@mediatek.com" <Michael.Lo@mediatek.com>,
        "allan.wang@mediatek.com" <allan.wang@mediatek.com>,
        "Eric-SY.Chang@mediatek.com" <Eric-SY.Chang@mediatek.com>,
        "km.lin@mediatek.com" <km.lin@mediatek.com>,
        "Quan.Zhou@mediatek.com"
	<Quan.Zhou@mediatek.com>,
        "Ryder.Lee@mediatek.com" <Ryder.Lee@mediatek.com>,
        "Shayne.Chen@mediatek.com" <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v2 1/6] wifi: mt76: mt7925: load the appropriate CLC data based on hardware type
Thread-Topic: [PATCH v2 1/6] wifi: mt76: mt7925: load the appropriate CLC data
 based on hardware type
Thread-Index: AQHbjM7UNOPbi6v4JUCOaZmi+hVXCbNip7ew
Date: Tue, 4 Mar 2025 09:06:34 +0000
Message-ID: <4d4e50e6b76e46d5b949701316889ee6@realtek.com>
References: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
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

Mingyen Hsieh <mingyen.hsieh@mediatek.com> wrote:

[...]

> +       struct evt {
> +               u8 rsv[4];
> +
> +               __le16 tag;
> +               __le16 len;
> +
> +               __le32 ver;
> +               __le32 addr;
> +               __le32 valid;
> +               __le32 size;
> +               __le32 magic_num;
> +               __le32 type;
> +               __le32 rsv1[4];
> +               u8 data[32];
> +       } __packed * res;

nit: no need space between * and res, i.e. "__packed *res".

> +       struct sk_buff *skb;
> +       int ret;
> +
> +       ret =3D mt76_mcu_send_and_get_msg(&dev->mt76, MCU_WM_UNI_CMD_QUER=
Y(EFUSE_CTRL),
> +                                       &req, sizeof(req), true, &skb);
> +       if (ret)
> +               return ret;
> +
> +       res =3D (struct evt *)skb->data;
> +       *val =3D res->data[offset % MT7925_EEPROM_BLOCK_SIZE];
> +
> +       dev_kfree_skb(skb);
> +
> +       return 0;
> +}
> +
>  static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
>  {
>         const struct mt76_connac2_fw_trailer *hdr;
> @@ -809,12 +857,19 @@ static int mt7925_load_clc(struct mt792x_dev *dev, =
const char *fw_name)
>         struct mt792x_phy *phy =3D &dev->phy;
>         const struct firmware *fw;
>         int ret, i, len, offset =3D 0;
> -       u8 *clc_base =3D NULL;
> +       u8 *clc_base =3D NULL, hw_encap =3D 0;

not sure if mt76 declare local variables in reverse X'mas tree order?



