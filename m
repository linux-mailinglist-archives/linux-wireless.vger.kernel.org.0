Return-Path: <linux-wireless+bounces-27839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FD7BC0123
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 05:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B9D14E5A9F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4911F4C8B;
	Tue,  7 Oct 2025 03:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YsdsMLFK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CE1F3D58;
	Tue,  7 Oct 2025 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759806806; cv=none; b=AIQomgQAiO0tnPoiPuePCs8eUUg+9a1lgvbIV7bXC1XZ8IWiB03XFmEJqW+x/hx7767bJuzkw55TR5v1FzLrHyb9STtt+Bb0nae2Wl1X/YK36cWZahSgvhyPyNFSBskfLYji4Tqf4uZ44Hmeb+Kkxi3yNbTdjKZIJ97pqHty16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759806806; c=relaxed/simple;
	bh=g7SBsgpEXa0bEbTMglrTg0VgIQmHDA8rbXlLwuk8S5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tDM3YblKmj1VS5dPL3oAGvEcib+wkUkwhrT7UOBBQJcDWG+iw7EdpC6jAHEGm1Y18b3oRc2cnRTHiUhvOcXLvR38iXV0+0ZcmTu/WVA+Gy3C5ca3xw9M2ZYrCDCCj3iP3WonT/7BlRhu74yIcrLmMHk9WTyLiivuUkTE5u5jXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YsdsMLFK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5973D8q243438052, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759806788; bh=lSh85/Q7itr2LXpqH53KzmVW4jEDAZPaB6WVCNkaCDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YsdsMLFKAxw3eNgEnKJwrVDMr+ghI6F8KD8fX2/O80+/N64voCB+pIUtv/88QBtca
	 42g2jb9RCcjl040ZqLQJqcioaXOY1SgRUCbpbcTVoUV0NqFdVxLDzBGEOhiUEvEz/z
	 M/ZeFkm9ErH2rqJNOQ16fQiN9ZOMcAX6HEoxaW8kdvwRYFYofojInwLy4xRQmp7R2I
	 b0CFflDh23Bu7GLxiLk44Ov/k5gFYb0F7zeHmHNfFewY0QZ7FH9uxngUzgj0sePxZ5
	 5ShUQmDVxtDcUu6v4ZCVNBsbuT/Gezgde+7lLb4vNC2LGOGYXOExV96Q0WOgJZfQ8H
	 ZknEu/albQ9Xg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5973D8q243438052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 11:13:08 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 7 Oct 2025 11:13:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 7 Oct 2025 11:13:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 7 Oct 2025 11:13:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v2 5/7] wifi: rtw89: implement C2H TX report handler
Thread-Topic: [PATCH rtw-next v2 5/7] wifi: rtw89: implement C2H TX report
 handler
Thread-Index: AQHcM9ij/5zY6bpRKkiRJfxW79+fNLS2B9uQ
Date: Tue, 7 Oct 2025 03:13:08 +0000
Message-ID: <91083b4683fd457ab6363b135bfee6a3@realtek.com>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-6-pchelkin@ispras.ru>
In-Reply-To: <20251002200857.657747-6-pchelkin@ispras.ru>
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
> rtw89 has several ways of handling TX status report events.  The first on=
e
> is based on RPP feature which is used by PCIe HCI.  The other one depends
> on firmware sending a corresponding C2H message, quite similar to what
> rtw88 has.
>=20
> Toggle a bit in the TX descriptor and place skb in a queue to wait for a
> message from the firmware.  rtw89 has an extra feature providing TX
> reports for multiple retry transmission attempts.  When there is a failed
> TX status reported by the firmware, the report is ignored until the limit
> is reached or success status appears.  Do all this according to the vendo=
r
> driver for RTL8851BU.
>=20
> It seems the only way to implement TX status reporting for rtw89 USB.
> This will allow handling TX wait skbs and the ones flagged with
> IEEE80211_TX_CTL_REQ_TX_STATUS correctly.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

[...]

> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wirel=
ess/realtek/rtw89/mac.c
> index fd11b8fb3c89..10c2a39e544b 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5457,6 +5457,20 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtw=
dev, struct sk_buff *c2h, u32
>         rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
>  }
>=20
> +static void
> +rtw89_mac_c2h_tx_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 =
len)
> +{
> +       const struct rtw89_c2h_mac_tx_rpt *rpt =3D
> +               (const struct rtw89_c2h_mac_tx_rpt *)c2h->data;
> +       u8 sw_define =3D le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_S=
W_DEFINE);
> +       u8 tx_status =3D le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_T=
X_STATE);
> +       u8 data_txcnt =3D le32_get_bits(rpt->w5, RTW89_C2H_MAC_TX_RPT_W5_=
DATA_TX_CNT);

Since we'd like reverse X'mas tree order, I'd like separate declarations an=
d
assignments. Like

u8 sw_define, tx_status, data_txcnt;

sw_define =3D le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_SW_DEFINE);
tx_status =3D le32_get_bits(rpt->w2, RTW89_C2H_MAC_TX_RPT_W2_TX_STATE);
data_txcnt =3D le32_get_bits(rpt->w5, RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT);

Otherwise, looks good to me.

> +
> +       rtw89_debug(rtwdev, RTW89_DBG_TXRX,
> +                   "C2H TX RPT: sn %d, tx_status %d, data_txcnt %d\n",
> +                   sw_define, tx_status, data_txcnt);
> +}
> +

[...]


