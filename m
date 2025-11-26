Return-Path: <linux-wireless+bounces-29354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B99C3C88C55
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 09:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99594346C0E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9717831A808;
	Wed, 26 Nov 2025 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WRyrOnDL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4AE31986E;
	Wed, 26 Nov 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147259; cv=none; b=oeG+b9A1SITZrJxcny5MuR0r1wMjXaXMhby0eEBGX4E8zKonjhF0qQWRDtaA1o+uTvXPU5vgmOj4MnJ4bVcX1qDsRyO3ctM76NJCWZTKZvIjPHchJpNlov0d/xRMRC6aes9qL3RRusDDwI353HghWDIlxotx1PThOSbVYEUPDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147259; c=relaxed/simple;
	bh=7MkboV07J6JGavq0FjwWNOoPI/t2MtJDC5kD+CV3Czw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V6uvbanhfYOpSGt3CBlQs8AufJt8xCbfQjvLbGQmjdq45fyj77TWeCdJQE0ulHB18WtGaMCkIVzCaC1MSVuPSY3hojMR4z51CkCAspD/+8Nipdc/i7ZR7QLjCgaGQ3AnKtorJbf32wQsh/HfxTxQLUeL2jR1OYW8hmlPyrKNwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WRyrOnDL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AQ8s9ceD584747, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764147250; bh=2oYjogc9K6R8viBJmOhdxHqFw6Xxct3usjMrQ1TI6yQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WRyrOnDLKbmyRe3unx/Xgx/HnEtxmM9//RjRYnJCouv/DkvGy3MU1AUxruJmvwn1V
	 iQJtMCKdCI2CpdKbqOl9Dnmj+DTVs1bS1MGbttpsy3hYAeuh6nPVm51yigQTAVWmNe
	 KbYbu8nPLs/4DforR8dUC5sGZTIAcIa2zxwvcNbcJY4GwFDKwuxe9Ee1y1X7F/CUlb
	 Yftw0w2bK4Sf6mEWStFr9Z02t0EQXt/x58kqUCoihbraB3m0oBKWQ6TPnfEDWyInLu
	 UZV2Z1PqPk9HwMLDW2BjbNsJjFswDzWPrv3u9TziTvlX95fW+hl9mfx0hL2ELmYFS8
	 SUEuoTXUQMRMw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AQ8s9ceD584747
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 16:54:10 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 26 Nov 2025 16:54:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 26 Nov 2025 16:54:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 26 Nov 2025 16:54:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Les Boys <lesboyspp43@outlook.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next v4] realtek/rtlwifi: remove unused two if blocks
 and put unicast set inner if and else block
Thread-Topic: [PATCH rtw-next v4] realtek/rtlwifi: remove unused two if blocks
 and put unicast set inner if and else block
Thread-Index: AQHcXplRQ08tRl7ZFU2n1nKOiWbr9LUEpRQg
Date: Wed, 26 Nov 2025 08:54:07 +0000
Message-ID: <77827732646345698e1bf133bbc87494@realtek.com>
References: <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <d664a966f7754e879948039189aba8e8@realtek.com>
 <SA2PR10MB44605A853386FE1BB7174498A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <SA2PR10MB4460861A8224AA99EE5ACF6BA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <731806e542f245b3b3ae6d2429c499e5@realtek.com>
 <SA2PR10MB44606485C05B0FC57402C40FA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <ab5c8bb1f6f443c9a08882be5a1ba24d@realtek.com>
 <SA2PR10MB4460E7C842251428DB9D253EA6DEA@SA2PR10MB4460.namprd10.prod.outlook.com>
In-Reply-To: <SA2PR10MB4460E7C842251428DB9D253EA6DEA@SA2PR10MB4460.namprd10.prod.outlook.com>
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
> Removed unused if blocks and put the unicast set sentence into the
> if/else block.

Commit message is always to explain why we need this patch, but this=20
describes what this patch changes.

I think subject and commit message of v1 is more suitable than v4.

More, v5 subject should be "[PATCH rtw-next v5] wifi: rtlwifi: ..."
(please just copy & paste)

Otherwise, patch content is fine to me.

>=20
> Signed-off-by: Les Boys <lesboyspp43@outlook.com>
> ---
> CHANGE:
> 1. Move change block to correct location;
> 2. Removed initalization of unicast on the begin of function.
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

