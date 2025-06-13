Return-Path: <linux-wireless+bounces-24084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1075FAD7FAB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 02:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C19B1895361
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 00:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51EB1C5D55;
	Fri, 13 Jun 2025 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AS24q0U6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C6EEBA;
	Fri, 13 Jun 2025 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749775302; cv=none; b=GTqUhh8ttPL34ZtXeiEE7CxY0LJY8Mey2W8C+bwXN4QG5H1nJuZikcy6xnsKA7DmRHvgumrq8AwwCN9E8BSmum7s/2cBA6PG9oim6TWwtlvdrJsjXAMtlzwWqlmYe+uvEbMzRbzj7+NzvLITX0pqRlE7EzD4tEdTC7ZC+HH9/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749775302; c=relaxed/simple;
	bh=uUA+sGiu0nPLO0aLkF4MYb50xq0jvWvi4ApLjqrcccI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LAPNrx+OYW9KVRFP4TpqeVKb6Ku89Zf/7r2r7o7SqApObeR2z7G96/5gWoYfF2Te1zIc7WH1T55VLM989avyp+zkVLqpHOu+XsG2GEVyJO6kvEboIiue4GefIyocy3tZvB0dsfkB+F4F6vaAJFLa0A3NqfSQuCCgRn88QMMuIbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AS24q0U6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55D0fWeO53284173, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749775293; bh=/JsqWsr12Jogyrw+Dr1X/RAP98kvFyjFehk3oQ1Og/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AS24q0U6MX32khCBJu7e3B+1ywdjSKEAAugRf4NSk58/9EMzzZ3MgemzqZ4eTQU4b
	 kr2kg1A/2DY+7yx1T3Kh8qfsxpsIuY+5m5dM9gBLaDtAsFS3i2iiPHe6jlBaz2CNTR
	 OPhbBA8I1RRwYtt5sCfoce6nJGsL7vOIqvcv0CO6fo5QtB/H8V5HL56qvjuY2+3y2p
	 bSpaFXWWuq9iH7qiHnqmDWL6LdvUuvANEUmH1PgxM5BpUUj1dLFmf0Wj+RVGK4KATA
	 Ia0R6cz5OmuIU7t8GcVNjtEtm/hv6ui/t1y1J6PRAg7lYybRcXWxYAhpdeT4EqwRRT
	 u71qU4xUGmB4g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55D0fWeO53284173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 08:41:33 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Jun 2025 08:41:34 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 13 Jun 2025 08:41:33 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Fri, 13 Jun 2025 08:41:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drive/realtek/rtlwifi: fix possible memory leak
Thread-Topic: [PATCH] drive/realtek/rtlwifi: fix possible memory leak
Thread-Index: AQHb23l3r973EPV6e0KOwaFFEdkNgrQAPNcQ
Date: Fri, 13 Jun 2025 00:41:33 +0000
Message-ID: <9800869271a34ca3835743207c0a4109@realtek.com>
References: <20250612090724.17777-1-fourier.thomas@gmail.com>
In-Reply-To: <20250612090724.17777-1-fourier.thomas@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

The subject should be unique and with rtw-next tag, such as

"[PATCH rtw-next] wifi: rtlwifi: fix possible skb memory leak in
_rtl_pci_init_one_rxdesc()."

Thomas Fourier <fourier.thomas@gmail.com> wrote:
> When `dma_mapping_error()` is true, if a new `skb` has been allocated,
> then it must be de-allocated.

Add a "Compile tested only". (I guess you even didn't)

>=20
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wir=
eless/realtek/rtlwifi/pci.c
> index 898f597f70a9..f754f1c3f783 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -572,8 +572,11 @@ static int _rtl_pci_init_one_rxdesc(struct ieee80211=
_hw *hw,
>                 dma_map_single(&rtlpci->pdev->dev, skb_tail_pointer(skb),
>                                rtlpci->rxbuffersize, DMA_FROM_DEVICE);
>         bufferaddress =3D *((dma_addr_t *)skb->cb);
> -       if (dma_mapping_error(&rtlpci->pdev->dev, bufferaddress))
> +       if (dma_mapping_error(&rtlpci->pdev->dev, bufferaddress)) {
> +               if (!new_skb)
> +                       kfree_skb(skb)

kernel test robot reported error here.=20

>                 return 0;
> +       }
>         rtlpci->rx_ring[rxring_idx].rx_buf[desc_idx] =3D skb;
>         if (rtlpriv->use_new_trx_flow) {
>                 /* skb->cb may be 64 bit address */
> --
> 2.43.0


