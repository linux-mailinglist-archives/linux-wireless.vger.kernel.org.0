Return-Path: <linux-wireless+bounces-36101-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMcVJMhU/WkYawAAu9opvQ
	(envelope-from <linux-wireless+bounces-36101-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 05:13:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90634F107D
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 05:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B29533035AB7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 03:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CC92D8795;
	Fri,  8 May 2026 03:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="utv0uttH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C72BB13;
	Fri,  8 May 2026 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209983; cv=none; b=faG1kh1QlQR2OBZIR05gzKSFcxQDHcTc8Vz+Zy7EzAZYkurgRTVqDPeioFS8K3NijQA/KTwfCF35dPKXkjoMfJzZVF/JfwTRKVIWhGhvTUbEElNESwInWgIXVSZjXuDHVLrQQfH4IMhJUZn469K/rWQ9SXGa9rSlucpx0E1vrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209983; c=relaxed/simple;
	bh=X84XpTebIaY2qM7TvqvAdmFs068uppqXeXM5YIJY9wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=svx7Rva484kziXeZHEDWoQJnZdQdsFhLp4tnfCPo8O9Q9HLXSyfCYxa8i2w21L30GEqBMiwDZv5uqV/0Uin635IDc2QgCbsGJNx4/IqbrkfWcQy3B7N/Qyw0y519ltlRttKMHFw6Mk5aqI+shYnb1zT4BtGa7t6N2ruLSwSV/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=utv0uttH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6483CfqaE3280089, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778209961; bh=fbiEDyWiLvcXVHf9z6GV5p2SuJWIIMgr2FgTVR/C5Co=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=utv0uttH+7RxKG6bbB/qbratnOk71WdjR7S7o5d7gh8ukwL+fobedbaZViWEeoH1R
	 7ZU/tbzQ3IdOS6FwSr+lzDgCzDUDJNo0Zf31+hlZZF0FQ8AR6kt7kNSt42p2N5z41l
	 8fTRlD4703m7rlyQRLh45CGf5nKBkP5Q6NpsIrjx+e3qXDRlev2qrUtEnrZk97axJj
	 iumttAJDbF3uRIl4c5V0v6YtW+NU3E/UlfDiWhN0lBJcNoiGKt9S/fHbxpT2NEk3QJ
	 hbT2y7zRfi+6wvfp3aS1IMK9z37/SPWlKTztsS/4BT/hpu8HGZfVrU7Op0Smi7uUmp
	 MUfxI1K+XZCqg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6483CfqaE3280089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 11:12:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 8 May 2026 11:12:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 8 May 2026 11:12:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 8 May 2026 11:12:41 +0800
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
Subject: RE: [PATCH v2] wifi: rtw88: increase TX report timeout to fix race
 condition
Thread-Topic: [PATCH v2] wifi: rtw88: increase TX report timeout to fix race
 condition
Thread-Index: AQHc3j+4r4phwtxrUESRO2zJtiJuRbYDc+Jw
Date: Fri, 8 May 2026 03:12:41 +0000
Message-ID: <924a011d3be6497dbaaf399c366d995d@realtek.com>
References: <20260507163621.73295-1-luka.gejak@linux.dev>
In-Reply-To: <20260507163621.73295-1-luka.gejak@linux.dev>
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
X-Rspamd-Queue-Id: A90634F107D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36101-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

luka.gejak@linux.dev <luka.gejak@linux.dev> wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>=20
> The driver expects the firmware to report TX status within 500ms.
> However, a timeout can be triggered when the hardware performs
> background scans while under TX load. During these scans, the firmware
> stays off-channel for periods exceeding 500ms, delaying the delivery of
> TX reports back to the driver.
>=20
> When this occurs, the purge timer fires prematurely and drops the
> tracking skbs from the queue. This results in the host stack
> interpreting the missing status as packet loss, leading to TCP window
> collapse. In testing with iperf3, this causes throughput to drop from
> ~90 Mbps to near-zero for approximately 2 seconds until the connection
> recovers.
>=20
> Increase RTW_TX_PROBE_TIMEOUT to 2500ms for RTL8723DU. This duration is
> sufficient to accommodate off-channel dwell time during full background
> scans, ensuring the purge timer only trips during genuine firmware
> lockups and preventing unnecessary TCP retransmission cycles.
>=20
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")

I don't think this commit introduce USB support.=20

> Cc: stable@vger.kernel.org
> Tested-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
> Changes in v2:
>  -Isolated the change to RTL8723DU as requested by Ping-Ke
>=20
>  drivers/net/wireless/realtek/rtw88/tx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wirele=
ss/realtek/rtw88/tx.c
> index 3106edb84fb4..7fab83c3f6b5 100644
> --- a/drivers/net/wireless/realtek/rtw88/tx.c
> +++ b/drivers/net/wireless/realtek/rtw88/tx.c
> @@ -196,6 +196,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
>  void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, =
u8 sn)
>  {
>         struct rtw_tx_report *tx_report =3D &rtwdev->tx_report;
> +       unsigned long timeout;

Declare RTW_TX_PROBE_TIMEOUT as default value.

unsigned long timeout =3D RTW_TX_PROBE_TIMEOUT;

>         unsigned long flags;
>         u8 *drv_data;
>=20
> @@ -207,7 +208,13 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, s=
truct sk_buff *skb, u8 sn)
>         __skb_queue_tail(&tx_report->queue, skb);
>         spin_unlock_irqrestore(&tx_report->q_lock, flags);
>=20
> -       mod_timer(&tx_report->purge_timer, jiffies + RTW_TX_PROBE_TIMEOUT=
);
> +       if (rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8723D &&
> +           rtwdev->hci.type =3D=3D RTW_HCI_TYPE_USB)
> +               timeout =3D msecs_to_jiffies(2500);

Only RTL8723DU uses different setting treated as an exception by if-conditi=
on.

> +       else
> +               timeout =3D RTW_TX_PROBE_TIMEOUT;
> +
> +       mod_timer(&tx_report->purge_timer, jiffies + timeout);
>  }
>  EXPORT_SYMBOL(rtw_tx_report_enqueue);
>=20
> --
> 2.54.0


