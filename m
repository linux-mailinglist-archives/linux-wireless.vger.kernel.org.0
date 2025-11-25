Return-Path: <linux-wireless+bounces-29327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D57A6C841FA
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 10:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 812003425AB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A5425A359;
	Tue, 25 Nov 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q3+Iepdo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D453527472;
	Tue, 25 Nov 2025 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061394; cv=none; b=ftU+VVuAq8cT1JXFTSZOY8fIDXpqdY+UYpheg+nsOz2+H8uxWNONphAMGYRWWL7OiXoMx8V2bvyT8983AAC28yvZ84VueEcJly6F6jK1GnNRnu2ZGKPa4SOJHxW8BSZmON4aKBpkO3ZQIb5C2JBjqWgyAsYq3rUFP1daq3GwzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061394; c=relaxed/simple;
	bh=dBz9i6fgQgTr/GQzJdYEQ3Hy6Nohx/gguYp6Q9fAOK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dmNIoFcAuE8NqOgd4JBUtfOfFQAsiI1BnlhOVlIJCKXrUpyGvxBU80Z2O4VWiW6dHbdu01ZIq+aEwLw0QHJr4USDkRz41IAgWttz3tB/RXGAXwl4ZtgfqSL1ZRgZWDHpCmXBa9Vp6QOdMGOnfFmJqGNhNZHnFrUONpYQupZlWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q3+Iepdo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AP933iV42697737, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764061383; bh=cqmgGVgIg2KtZDPSAyW6YIUEtJ6IOU0ztLgpxhPAy+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Q3+Iepdoee6VUD8uUDCH5lLq6YOZt3b68bAovQqdGzL2Z+6xy+b1j+5qR/61nlNhP
	 5ro4cDtvthiXQWV72g3VKLREXAGNk/5/79RuzdjfVCJAjIILR/hDn9FyEIrPSwvXL1
	 wReuqMy0u6rCJlPmt8eGfWEbIeKCE2BXlTW0ZO3ndKK0OsrZNTJk9280P0CgP/pPK2
	 XdPblLye+c1pLnB3bHzhASyPl1P/0Jngg26FabJxE4u1sHMCvuntAH/PmjwvNH3sfv
	 7EwqlIAHU88jMQG/RrtCPf4P6y79JHOYSeG/JuafhTYkSWb2mmT0dhycGKnvlh7OH+
	 yJJDDSbt/K2lQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AP933iV42697737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 17:03:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 25 Nov 2025 17:03:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 25 Nov 2025 17:03:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 25 Nov 2025 17:03:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Les Boys <lesboyspp43@outlook.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2] realtek/rtlwifi: ensure unicast is
 reinitialized to false in each iteration
Thread-Topic: [PATCH rtw-next v2] realtek/rtlwifi: ensure unicast is
 reinitialized to false in each iteration
Thread-Index: AQHcXeYNuIE80rjdbk2Za3HWoPPukbUCis0AgACM2BA=
Date: Tue, 25 Nov 2025 09:03:00 +0000
Message-ID: <731806e542f245b3b3ae6d2429c499e5@realtek.com>
References: <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <d664a966f7754e879948039189aba8e8@realtek.com>
 <SA2PR10MB44605A853386FE1BB7174498A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <SA2PR10MB4460861A8224AA99EE5ACF6BA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
In-Reply-To: <SA2PR10MB4460861A8224AA99EE5ACF6BA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
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
> Previously, the unicast variable was only initialized once during the
> function execution. Therefore, if unicast was set to true in the (n-1)th
> iteration, it would affect the nth iteration. This patch resolves the iss=
ue
> by reinitializing unicast to false at the start of each iteration.
>=20
> CHANGE:
> 1. Fix indention
> 2. Use a better way recommanded by maintainer to solve original problem
> 3. Fix subject
> 4. Remove useless if and TODO comment
>=20
> (added CC this time)
>=20
> Signed-off-by: LBLaiSiNanHai <lesboyspp43@outlook.com>

This should be your real name which is identical to From field=20
(I have mentioned this in v1).


---

Move your CHANGE here with three '-' as delimiter=20

> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wir=
eless/realtek/rtlwifi/pci.c
> index fe7140328..a07de6b57 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -752,16 +752,13 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_=
hw *hw)
>                         memcpy(IEEE80211_SKB_RXCB(skb), &rx_status,
>                                sizeof(rx_status));
>=20
> -      unicast =3D false;

This is your change in v1, please use upstream as base.=20

Also, you missed to remove initializer of `unicast` in original code.=20

More, check status of your patch in patchwork [1].

[1] https://patchwork.kernel.org/project/linux-wireless/patch/SA2PR10MB4460=
861A8224AA99EE5ACF6BA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com/

> -
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

