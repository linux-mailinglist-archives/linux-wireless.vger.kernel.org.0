Return-Path: <linux-wireless+bounces-37222-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLwdJunYHGopTQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37222-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 02:57:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E956188F8
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 02:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7697D30158B8
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640201A683C;
	Mon,  1 Jun 2026 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fzN6yeWJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE56126C03;
	Mon,  1 Jun 2026 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275424; cv=none; b=St4jIOL/TWYyUDbZfrtTzpHX8IBCWV91zBDrYPz+Mvl00i8DrQWn8c4AfBb6XnGzJ25L1G9LuivOpzFRmeLUXKD4WNwajPcbM2qI0RgMcm/EQ2rv1IyP8kXB7FM9IcwQaHbYLdcEHuYYPItbuA3Lb5PQ++qqjlu3TuMLj3PVltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275424; c=relaxed/simple;
	bh=jsqf95HAfWGO0v5Nt36Mdra6dMGRtfoVa05ww5sdHik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P75FF2fk6OdSYaOREjB3+2BkQcTfjsvsc+vWlKHfUhC7EBff6tMkaS0raREK77UwWAKJ1e8MjWhjlLVhe/w5/XwziypnIq/IT2OXUvASGm1LVwLWHVRiYgQRSsxRY/vKbkNYlSwrxfnYgdE8mywDo1wZ8A2jeI1MGF9CO5ojkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fzN6yeWJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6510ubKO31691755, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780275397; bh=uOnTJLkdySPMB8TSqLClS4fREpllwh+tI32T7jRnxrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fzN6yeWJDQjoIAMrab638NdttyoEN6OiK/K/pAm8hchSEBve6JwSP5mAsiYA3j+Z4
	 zgGQh/wf2+0Fd9yLBPY/MbWcrQFENDnVIQJMgCdu5ro/iCqKPJQ0Zw8ehtB5poZtYP
	 vamBZYt6UVN+hm1AYPeaPnzjtkvXef1AvLbivMFOVPpTn63DEgNhr84fzJ/dgVBLNg
	 OOoKQIfCuoII3yeVJ1LERQBqQkjNH9EbKNGzX7QHQxZNr7ih2F4s133D/s5z4LzxGS
	 5ayIOMQC/twBLzT2n77XUNHhV7qbntWCEOB2uKWr4JMBGUPZwcP4Tftp3O0AVYoB2b
	 y4Ez/0H7jwBSw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6510ubKO31691755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 08:56:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Jun 2026 08:56:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 1 Jun 2026 08:56:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: VolcomIlluminated <Volcomilluminated@airmail.cc>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "luka.gejak@linux.dev"
	<luka.gejak@linux.dev>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: extend USB TX report timeout to RTL8822BU
Thread-Topic: [PATCH] wifi: rtw88: extend USB TX report timeout to RTL8822BU
Thread-Index: AQHc8U7w5gSrudTViUy1IAySLkqUJbYo3iPw
Date: Mon, 1 Jun 2026 00:56:38 +0000
Message-ID: <dc8a5729951b4378913d537b29141887@realtek.com>
References: <20260531223349.5952-1-Volcomilluminated@airmail.cc>
In-Reply-To: <20260531223349.5952-1-Volcomilluminated@airmail.cc>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37222-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DM_SURBL(0.00)[airmail.cc:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:mid,realtek.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E9E956188F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VolcomIlluminated <Volcomilluminated@airmail.cc> wrote:
> Luka Gejak's patch increased the TX report timeout for RTL8723DU to
> accommodate off-channel dwell time during background scans. The same
> issue affects RTL8822BU (tested on Edimax EW-7822ULC) where background
> scans cause the firmware to stay off-channel for periods exceeding the
> default 500ms timeout, causing the purge timer to fire prematurely and
> drop TX tracking skbs.
>=20
> Extend the 2500ms timeout to also cover RTL8822BU USB devices.
>=20
> Tested on RTL8822BU (Edimax EW-7822ULC) with 17,706 packets over 24+
> hours with zero drops.
>=20
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Cc: stable@vger.kernel.org
> Signed-off-by: VolcomIlluminated <Volcomilluminated@airmail.cc>
> ---
> --- /tmp/linux-6.18/drivers/net/wireless/realtek/rtw88/tx.c     2025-11-3=
0 17:42:10.000000000 -0500
> +++ /home/ptpx86mm1/kernelbuild/linux-6.18/drivers/net/wireless/realtek/r=
tw88/tx.c      2026-05-31

Just clone git repository and use 'git format-patch' to generate patch file
and send out.

> 16:00:37.125645594 -0400
> @@ -196,6 +196,7 @@
>  void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, =
u8 sn)
>  {
>         struct rtw_tx_report *tx_report =3D &rtwdev->tx_report;
> +       unsigned long timeout =3D RTW_TX_PROBE_TIMEOUT;
>         unsigned long flags;
>         u8 *drv_data;
>=20
> @@ -207,7 +208,12 @@
>         __skb_queue_tail(&tx_report->queue, skb);
>         spin_unlock_irqrestore(&tx_report->q_lock, flags);
>=20
> -       mod_timer(&tx_report->purge_timer, jiffies + RTW_TX_PROBE_TIMEOUT=
);
> +       if ((rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8723D ||
> +            rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8822B) &&

Please use https://github.com/pkshih/rtw.git rtw-next branch as your base.=
=20

> +           rtwdev->hci.type =3D=3D RTW_HCI_TYPE_USB)
> +               timeout =3D msecs_to_jiffies(2500);
> +
> +       mod_timer(&tx_report->purge_timer, jiffies + timeout);
>  }
>  EXPORT_SYMBOL(rtw_tx_report_enqueue);
>=20


