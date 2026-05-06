Return-Path: <linux-wireless+bounces-35996-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIsiGAr/+mkRVQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35996-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 10:42:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB4D4D7FD3
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 10:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE56730136B5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB23393DE0;
	Wed,  6 May 2026 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="het2pFil"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479643B6345;
	Wed,  6 May 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056936; cv=none; b=Gl64gMFlJrIJmp/ADg/CcYiGm6xCqBoZEfoRhwhwH6IS595uHAAjrUBm02sYaSFyTmd9EKfLOsRWzG0EtOdBeU9Qb0HgDJOH8/VJOLRetPccfopO8FTxwl3ktEHlMf/fkHWtJfXOUt5iKps4+xKOGz4lJqBpD4YI+l9SIY1kfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056936; c=relaxed/simple;
	bh=p14Gt5yDtPDuRKL3GzExux/cNIwoCYE2oVR8kJxOeVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fznduHHgVJay5dlYFR7P8LoCW9n4NpJeIQFKvYf1FJKj3RacJLqD2VDYFP00exindi+8VFNoXAwV/nrnGycH/LWjUEZHogBxg9BdY5wi02UwbCE2b6OQ93zq294Ns/FVETf1HDEwdh/8byanxUbrbkKtk5PqOGvzq2FXayiH14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=het2pFil; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6468fqaK71881035, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778056912; bh=NXb3RgBZh/uYJOqrFmgoVF262Zk0ZPD18cHf7cHc9T0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=het2pFillO/MXQaY9RHfVjNkyXXr2ZLr6FgEno++Q/vu/eHzCQdmvcDSZIPdi2D81
	 R88TxhplN5ZGrkbm8vI38IPf6Y9rOsTaOxJwzTimReHPxoGuGJCSrIkCu12YlVbN06
	 zX2H9dC0i3JR/5Pe58dVIdIT5hYeLiPJC0COKdpQZdnyQkooYtyTNUwKYdqXafIUDV
	 rKbJTrw+ZJ7cf0mw1WIMhUWWwCiBhZyIiU2tKRGJXqatow8W+95a1uWZp0edWEkR3N
	 VbXs1gTbaZRzeis7DS10bvOUUzT7w9wU7W+iiPUywFv7E8RxZyHZtyeUOrfMe83qr2
	 Y4jdPS3o08/GA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6468fqaK71881035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 16:41:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 16:41:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 16:41:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 6 May 2026 16:41:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "luka.gejak@linux.dev" <luka.gejak@linux.dev>,
        Kalle Valo
	<kvalo@kernel.org>
CC: Stanislaw Gruszka <sgruszka@redhat.com>,
        Yan-Hsuan Chuang
	<yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: usb: fix memory leaks on USB write failures
Thread-Topic: [PATCH] wifi: rtw88: usb: fix memory leaks on USB write failures
Thread-Index: AQHc2YZ0bkKcaIYsNEi9rm3oTGPEw7YAsTUw
Date: Wed, 6 May 2026 08:41:52 +0000
Message-ID: <375601ac2dc64576afdcae4e144d51d9@realtek.com>
References: <20260501162012.250013-1-luka.gejak@linux.dev>
In-Reply-To: <20260501162012.250013-1-luka.gejak@linux.dev>
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
X-Rspamd-Queue-Id: BFB4D4D7FD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35996-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

luka.gejak@linux.dev <luka.gejak@linux.dev> wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>=20
> When rtw_usb_write_port() fails to submit a USB Request Block (URB)
> (e.g., due to device disconnect or ENOMEM), the completion callback is
> never executed.
>=20
> Currently, the driver ignores the return value of rtw_usb_write_port()
> in rtw_usb_write_data() and rtw_usb_tx_agg_skb(). Because these
> functions rely on the completion callback to free the socket buffers
> (skbs) and the transaction control block (txcb), a submission failure
> results in:
> 1. A memory leak of the allocated skb in rtw_usb_write_data().
> 2. A memory leak of the txcb structure and all aggregated skbs in
>    rtw_usb_tx_agg_skb().
>=20
> Fix this by checking the return value of rtw_usb_write_port(). If it
> fails, explicitly free the skb in rtw_usb_write_data(), and properly
> purge the tx_ack_queue and free the txcb in rtw_usb_tx_agg_skb().
>=20
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")

This commit doesn't introduce USB support.

> Cc: stable@vger.kernel.org
> Tested-by: Luka Gejak <luka.gejak@linux.dev>

How did you test this patch? Have you really encountered leak problem and
fixed it by this patch? Or make this patch by analysis, and test it
without regression?

> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>  drivers/net/wireless/realtek/rtw88/usb.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wirel=
ess/realtek/rtw88/usb.c
> index 718940ebba31..d430645a3ef3 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -456,7 +456,13 @@ static bool rtw_usb_tx_agg_skb(struct rtw_usb *rtwus=
b, struct sk_buff_head *list
>         tx_desc =3D (struct rtw_tx_desc *)skb_head->data;
>         qsel =3D le32_get_bits(tx_desc->w1, RTW_TX_DESC_W1_QSEL);
>=20
> -       rtw_usb_write_port(rtwdev, qsel, skb_head, rtw_usb_write_port_tx_=
complete, txcb);
> +       if (rtw_usb_write_port(rtwdev, qsel, skb_head,
> +                              rtw_usb_write_port_tx_complete, txcb)) {

Can we use 'ret =3D rtw_usb_write_port(...);' style, and check by next line=
?
Like the other one modified by this patch.

> +               /* URB submission failed, completion won't run, free the =
queue */

I think this comment is not necessary.=20

> +               skb_queue_purge(&txcb->tx_ack_queue);

Should use ieee80211_purge_tx_queue() since this is TX?=20

> +               kfree(txcb);
> +               return false;
> +       }
>=20
>         return true;
>  }
> @@ -518,8 +524,10 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev=
,
>=20
>         ret =3D rtw_usb_write_port(rtwdev, qsel, skb,
>                                  rtw_usb_write_port_complete, skb);
> -       if (unlikely(ret))
> +       if (unlikely(ret)) {
>                 rtw_err(rtwdev, "failed to do USB write, ret=3D%d\n", ret=
);
> +               dev_kfree_skb_any(skb);
> +       }
>=20
>         return ret;
>  }
> --
> 2.54.0


