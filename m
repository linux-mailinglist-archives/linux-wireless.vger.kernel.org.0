Return-Path: <linux-wireless+bounces-29358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BEBC88FB6
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 10:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BA23B5B37
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEB22D060E;
	Wed, 26 Nov 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fbGSN841"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0E22B8B0;
	Wed, 26 Nov 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149705; cv=none; b=lYmfhpoiFM2ajxUqdCLxTZYYwWP9F34yhNMA95gPd1+UxAPwwfH/0RUDMe9noKINYHTvdOgBmsFON9u9jiY24VhVZG+V9BWcNpmJnqJ43EcNElzrKEXdzxIR1LFLbBAOZV3uXGBoKiH59aocjJXn38wdfpIbOpJzWCSyv4VuFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149705; c=relaxed/simple;
	bh=AgAa57R+VcGGfxPk3+9xQmmh7WrPLgfuUhjzpxl9Qeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LlT8Pi02yvUbFd7vpwzTPccGRxvB6ojdiKuLITxDi70oEStyvPKz2+F+fWNvOUpi4KFz/+xl2/SYzp2ZnOeE0gH/bJHIDUqurVemm7o+GbVUCdcxXtOfkPYuK2w9dHVV888OM6nMXWvOv9pjzUwe5ph7NLsjntpxLAXRYednb08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fbGSN841; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AQ9Yr0jA624772, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764149693; bh=rcYh11jDMsrTdOXySjQxGHt5XyippL8FDBHNUAFVZao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fbGSN841l0ywxPSMxekxXqcFlgnitnEPSefnvb7HMWL8igl2N/Ow85cd+mtNQC/SH
	 Yc2rPkBPE7jXdOpqFvnMeuZWuj2vdTqHYfw5qle/9fVzAWYt9BjHQU/2/rRiR3VbBu
	 LY4icXzXHa+fWlSo1IK0Vv+xIck/lvSFI7VO+qnvY1Rzy7Exm2VEad70mWi/+we4MB
	 BXvlXfdZKlYFdvfvw9XDxjROI6lnkA2txcRkIvxFSQ7XVQgaWRUKcmOK3cC9mHtE9f
	 YFXaiyAChjKSVeOp9A7ArDabAQUrsI8gMYKWJstg6ybGfVgwX79dsOqOEZNRreua3c
	 Em9H7c3I/lDFA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AQ9Yr0jA624772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 17:34:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 26 Nov 2025 17:34:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 26 Nov 2025 17:34:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Les Boys <lesboyspp43@outlook.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v5] realtek: rtlwifi: remove dead code and ensure
 unicast is always set explicitly in every iteration
Thread-Topic: [PATCH rtw-next v5] realtek: rtlwifi: remove dead code and
 ensure unicast is always set explicitly in every iteration
Thread-Index: AQHcXrXCaBD6LtVK20Khh4+GkreQx7UEsa/g
Date: Wed, 26 Nov 2025 09:34:54 +0000
Message-ID: <f745cdb79d564a5686d5e146d460133d@realtek.com>
References: <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <d664a966f7754e879948039189aba8e8@realtek.com>
 <SA2PR10MB44605A853386FE1BB7174498A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <SA2PR10MB4460861A8224AA99EE5ACF6BA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <731806e542f245b3b3ae6d2429c499e5@realtek.com>
 <SA2PR10MB44606485C05B0FC57402C40FA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <ab5c8bb1f6f443c9a08882be5a1ba24d@realtek.com>
 <SA2PR10MB4460E7C842251428DB9D253EA6DEA@SA2PR10MB4460.namprd10.prod.outlook.com>
 <77827732646345698e1bf133bbc87494@realtek.com>
 <SA2PR10MB4460B6485B1104727C02701BA6DEA@SA2PR10MB4460.namprd10.prod.outlook.com>
In-Reply-To: <SA2PR10MB4460B6485B1104727C02701BA6DEA@SA2PR10MB4460.namprd10.prod.outlook.com>
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

Subject should be "wifi: rtlwifi: ...". I can change it during getting merg=
ed.
No need to resend because of this.

>=20
> Removed dead code and ensured unicast is always set explicitly in every
> iteration to ensure the unicast of (n-1)th iteration will not apply to nt=
h
> iteration, the previous code checked multicast and broadcast but no any
> logic if the state is multicast or broadcast, this patch removed them and
> check it is unicast or not only, and removed the initalizer of unicast
> because all possible path will set unicast.
>=20
> Signed-off-by: Les Boys <lesboyspp43@outlook.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> CHANGE:
> 1. Optimize commit message
> 2. Change subject

Change log should point out changes of v2, v3, v4, ...=20

No need to resend because of this neither.

> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wir=
eless/realtek/rtlwifi/pci.c
> index d08046926..eda3b80df 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -652,7 +652,7 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw=
 *hw)
>         unsigned int count =3D rtlpci->rxringcount;
>         u8 own;
>         u8 tmp_one;
> -       bool unicast =3D false;
> +       bool unicast;
>         u8 hw_queue =3D 0;
>         unsigned int rx_remained_cnt =3D 0;
>         struct rtl_stats stats =3D {
> @@ -752,14 +752,13 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_=
hw *hw)
>                         memcpy(IEEE80211_SKB_RXCB(skb), &rx_status,
>                                sizeof(rx_status));
>=20
> -                       if (is_broadcast_ether_addr(hdr->addr1)) {
> -                               ;/*TODO*/
> -                       } else if (is_multicast_ether_addr(hdr->addr1)) {
> -                               ;/*TODO*/
> -                       } else {
> +                       if (is_unicast_ether_addr(hdr->addr1)) {
>                                 unicast =3D true;
>                                 rtlpriv->stats.rxbytesunicast +=3D skb->l=
en;
> +                       } else {
> +                               unicast =3D false;
>                         }
> +
>                         rtl_is_special_data(hw, skb, false, true);
>=20
>                         if (ieee80211_is_data(fc)) {
> --
> 2.44.0

