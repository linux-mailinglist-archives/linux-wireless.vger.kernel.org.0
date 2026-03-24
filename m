Return-Path: <linux-wireless+bounces-33745-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMZFCpDgwWlhXgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33745-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 01:53:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DA03000E0
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 01:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFE563059A4F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 00:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D61535F19B;
	Tue, 24 Mar 2026 00:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Wi7YIt9w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0ED34E766
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313192; cv=none; b=TOxIkpbWgG/c4Znh85jLYfQXT9yyNNg9gKpKOmKUPACeptlSTYQQ21WibAPm3cXZXKWauL3GxddrTM1AnXxmGu81tT5L9/+flUNkBjR7Byw8p2seP7sXC74cOenY2GZPnDJBaPkav5z68+D0XOWM/kiUpzGhnkqQDYpTvcfvmHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313192; c=relaxed/simple;
	bh=sl0pBhUmwt+ehiDtDMNv8Gvu4l11AfPv2D0SW0Y/KZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bygOxe7BHS+VkdpD3QM+/Z0m+frRasb7h4XUUn+0iZQrdKaUBrhdRNFuRoTNQxLHAbi3tDGG9E+z7gf5ifz5oiBYwn4rItxF/YJEN8Dqz/3z9avUmradq8nPsom7E207tQrbIt7IzS5xCGpU/azFMNadN4SlaWZqQV+IxWH/3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Wi7YIt9w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62O0k5J91056189, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774313165; bh=902vvz1UcwqDrnsNiC2p8NcYrDrxevo6B0ZussHOwKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Wi7YIt9ww58a9wSPjDsAk+DJJMCFGjGJGSXPXz/ShkI+0UnFWpLcn2qrqC6u7zlPo
	 JdYTTAj5zD8RvQICshApbPaHeO7CfkT2zJtS+xLcK6NUTQ0JZAcgnY7QFeHEHoOnR8
	 UlpRcWlLfE7IW6CtqgT8oaR4vNeWc+VehFjp38ZJj57ewORTsiwP+3zSxU7R7p3dz+
	 9sUI9zrBb7FlyUOrHdDELh+uQUAjBbFLzyBAI0qHGxlhu2brIR3llF90ohyls0SmnO
	 gHatTdlGBr/Cbry5g9UTQDaOfvVNuwJ9oeKPkK5XAaEdGxyFy7R9ow7UzehlkvKm+G
	 cqpOhXdyqm+Nw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62O0k5J91056189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 08:46:05 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 08:46:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 08:46:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 24 Mar 2026 08:46:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lucid Duck <lucid_duck@justthetip.ca>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v3] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Topic: [PATCH v3] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Index: AQHcux2Kpru0IpxKikWTtgITiETWOrW81s8w
Date: Tue, 24 Mar 2026 00:46:05 +0000
Message-ID: <7257ea8a28094dfe814942df78b47817@realtek.com>
References: <20260323233347.158745-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260323233347.158745-1-lucid_duck@justthetip.ca>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33745-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,justthetip.ca:email,realtek.com:dkim,realtek.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D9DA03000E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Lucid Duck <lucid_duck@justthetip.ca> wrote:

[...]

> @@ -166,16 +166,25 @@ static u32
>  rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
>                                             u8 txch)
>  {
> +       struct rtw89_usb *rtwusb =3D rtw89_usb_priv(rtwdev);
> +       int inflight;
> +
> +       /* Firmware command channel is not tracked */

This comment is fine.

>         if (txch =3D=3D RTW89_TXCH_CH12)
>                 return 1;
>=20
> -       return 42; /* TODO some kind of calculation? */
> +       inflight =3D atomic_read(&rtwusb->tx_inflight[txch]);
> +       if (inflight >=3D RTW89_USB_MAX_TX_URBS_PER_CH)
> +               return 0;
> +
> +       return RTW89_USB_MAX_TX_URBS_PER_CH - inflight;
>  }
>=20
>  static void rtw89_usb_write_port_complete(struct urb *urb)
>  {
>         struct rtw89_usb_tx_ctrl_block *txcb =3D urb->context;
>         struct rtw89_dev *rtwdev =3D txcb->rtwdev;
> +       struct rtw89_usb *rtwusb =3D rtw89_usb_priv(rtwdev);
>         struct ieee80211_tx_info *info;
>         struct rtw89_txwd_body *txdesc;
>         struct sk_buff *skb;
> @@ -234,6 +243,10 @@ static void rtw89_usb_write_port_complete(struct urb=
 *urb)
>                 break;
>         }
>=20
> +       /* Decrement in-flight counter (skip firmware command channel) */

I think this is not necessary.

> +       if (txcb->txch !=3D RTW89_TXCH_CH12)
> +               atomic_dec(&rtwusb->tx_inflight[txcb->txch]);
> +
>         kfree(txcb);
>  }
>=20
> @@ -311,9 +324,17 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_d=
ev
> *rtwdev, u8 txch)
>=20
>                 skb_queue_tail(&txcb->tx_ack_queue, skb);
>=20
> +               /* Increment BEFORE submit to avoid race with completion =
*/

This is not necessary too. Another thought is to remove this condition
(just increase/decrease the count for CH12), but skip to check the count
like this patch does in rtw89_usb_ops_check_and_reclaim_tx_resource().

> +               if (txch !=3D RTW89_TXCH_CH12)
> +                       atomic_inc(&rtwusb->tx_inflight[txch]);
> +
>                 ret =3D rtw89_usb_write_port(rtwdev, txch, skb->data, skb=
->len,
>                                            txcb);
>                 if (ret) {
> +                       /* Rollback increment on failure */

This comment is not necessary either.

> +                       if (txch !=3D RTW89_TXCH_CH12)
> +                               atomic_dec(&rtwusb->tx_inflight[txch]);
> +
>                         if (ret !=3D -ENODEV)
>                                 rtw89_err(rtwdev, "write port txch %d fai=
led:
> %d\n",
>                                           txch, ret);

[...]

Ping-Ke



