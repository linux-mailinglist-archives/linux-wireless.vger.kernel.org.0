Return-Path: <linux-wireless+bounces-29322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 568FEC83B32
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 08:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED66934A3C8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 07:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA23284894;
	Tue, 25 Nov 2025 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vmY10O2X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF513AA2D;
	Tue, 25 Nov 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055449; cv=none; b=M4uiqpXgux1zy0T41xRbETZg7D6bG5rSe7heIIvtgS87PE3bHPxYOW+wiQ5JYgwJAdmfV/fPk3tAp3V5+B9vdgzQvmMxQTkCaLaM+EPkzVCez5HHLcorD/xdCwmeH1zJflfRoiMjLmEd1q22qjLtQ23edY+z0oU/KNBoShww6nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055449; c=relaxed/simple;
	bh=XLlXmeJ1LUJb09T/oebIRw1gWfvcq2vMr0EnQ92Qhio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W7r7mPK9woT65sxk25hreOtKucUE0pmog0ZndLS45uAyiTabXOvAZIJ74hvFbNSkS+UdR8+dVovbmi2YsBKdjQYvTzcWxAxGtjC0UcLA9ChN600tLkobH6mGaLqEEpBAQQO/15hhBUi3ouYv1+okNJLKaTpONkCOyyXEam7C8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vmY10O2X; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AP7NuHeA2571194, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764055436; bh=LzyBNlUlXf9MiuEemrJUFp08WuHt+hsz7WF3YnLP8OU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vmY10O2XwHXktTQdXzZexB1MAS2//1im+58Ht3W2wfPfDAiBzIPO4f82hWA9N/Gql
	 L/uLfa21GcRauTRMGPYEEUVRJzz272bOQUz06OmBzr+4+4ikiut4jdl4ywnT0XAIJZ
	 /8A3lUdU5CBuuvSpCDpPtWDuzuzbJK/Fa2Sw0uJf8xnOUesDwRGq9tHnQkWU6i9GsV
	 4IjdzJ2ciqTDEkpqkIS37aN3IYMd1/pd3W+VOUWmSyNva4tJMdY/xjew2C6u+tNPhB
	 PdsnrGg1mN8kY/2i+/JnNP1i0BZqygD4wFBJ+oYh7FTSOxmeRcluTUcIVKInMFAZj+
	 NxxbCtsPkgqfQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AP7NuHeA2571194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 15:23:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 25 Nov 2025 15:23:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 25 Nov 2025 15:23:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Les Boys <lesboyspp43@outlook.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] realtek/rtlwifi: ensure unicast is reinitialized to
 false in each iteration
Thread-Topic: [PATCH v1] realtek/rtlwifi: ensure unicast is reinitialized to
 false in each iteration
Thread-Index: AQHcXdjNdJ4zlsJI6k+HyP/79rWKV7UC+kYQ
Date: Tue, 25 Nov 2025 07:23:57 +0000
Message-ID: <d664a966f7754e879948039189aba8e8@realtek.com>
References: <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
In-Reply-To: <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
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

Les Boys <lesboyspp43@outlook.com> wrote:

Subject should be "[PATCH rtw-next] wifi: rtlwifi: ..."

>=20
> Previously, the unicast variable was only initialized once during the fun=
ction execution. Therefore, if
> unicast was set to true in the (n-1)th iteration, it would affect the nth=
 iteration. This patch resolves
> the issue by reinitializing unicast to false at the start of each iterati=
on.

75 characters per lines.

Does this affect your use actually?

>=20
> Signed-off-by: LBLaiSiNanHai <lesboyspp43@outlook.com>

Not sure if this is your real name? And, it should be the same as From fiel=
d.

> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wir=
eless/realtek/rtlwifi/pci.c
> index d08046926..fe7140328 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -752,6 +752,8 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw=
 *hw)
>                         memcpy(IEEE80211_SKB_RXCB(skb), &rx_status,
>                                sizeof(rx_status));
>=20
> +      unicast =3D false;
> +

Indentation is weird.

More, initializer of `unicast` can be removed, and here can be

      if (is_unicast_ether_addr(hdr->addr1)) {
               unicast =3D true;
               rtlpriv->stats.rxbytesunicast +=3D skb->len;
      } else {
               unicast =3D false;
      }

(I don't think TODO is still useful for now)

>                         if (is_broadcast_ether_addr(hdr->addr1)) {
>                                 ;/*TODO*/
>                         } else if (is_multicast_ether_addr(hdr->addr1)) {
> --
> 2.44.0

