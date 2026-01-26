Return-Path: <linux-wireless+bounces-31172-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPRILqo/d2mMdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31172-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:19:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B70C86AF7
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6B213003638
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BF132E15B;
	Mon, 26 Jan 2026 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pF2+2uj3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727953064AF
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422461; cv=none; b=m+rfzbznE9hJ9Mbklt0WsnAeX0ao3Q3qBRC11PnC4kk9hP5VUNF3ps2B1EPsynKacBG3tfS8kshAdTWiSF0FBa28E4firATGHHF+/jKJIT1Uj+k9KzfIMKDfxxmWWHDKo33X8xT7uxdORMzmKYsQVYB5NgThm9z1O4zoM24pTaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422461; c=relaxed/simple;
	bh=K6PXFo2zYvV6F7OHo42NVK/K90TXzL7QYHmP1akvJpI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T4fPYczzKtPFxA2iPK8xhzZIW+H0ZxNJpi0leiatgZrRt2dZicT1UqQ8ZQKUqxe3UN3AERtrb+/1U1S+DRzRbmJ5dMZDqIwDiCS42dqL00oJ06+5i1SFh2NbMkmdeXWAaFffobQA4WtERCLXnqhO0fxu3IuXN6T8N9/TOPZSdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pF2+2uj3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60QAE48f8676239, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769422444; bh=FUR07LtK9QB/4+nbhxg0iZVC/Egw8FV2telW0FscXXY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pF2+2uj30fFkDy+Z5lA48Ll4cvwxkndgafALSfT/OtBJ0kLGLo+pArXT1dfJ1MnVs
	 ZxvHGgZg3PUSerhzYG3TOCtAv9Lo1AC0KxTNHC41jvvjbmamlKgPZC4XQbpez4Dm54
	 V1orlvQ6pGVr7b/pSa0tIrzFcFWJpBtGNRaj9NQBM+eKG6h79wLlhNxV0NlnH5O6cC
	 eQACE8mrWpR0hqOfVyDFb8f7ZtXlyPkZuurf5m+crEp+8+SH1v+jWhWNym5KbWpHDO
	 5ges8PANxsw6BMJi0oo34qN9TqLrByzbIEyA5A7a9XTWNIZKN8FF/U6XMZdfShIk/8
	 /a6l+b+fG/spQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60QAE48f8676239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 18:14:04 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 26 Jan 2026 18:14:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 26 Jan 2026 18:14:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 26 Jan 2026 18:14:04 +0800
From: Mh_chen <mh_chen@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Lucid Duck <lucid_duck@justthetip.ca>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Bitterblue
 Smith <rtl8821cerfe2@gmail.com>,
        Isaiah <isaiah@realtek.com>
Subject: RE: [PATCH] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Topic: [PATCH] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Index: AQHcjkpOprwyThrh+0qoaRiP29pAsrVjy/ZQgABwPoA=
Date: Mon, 26 Jan 2026 10:14:04 +0000
Message-ID: <c628d6935fdf4e0c97f7d7938d996e89@realtek.com>
References: <20260125221943.36001-1-lucid_duck@justthetip.ca>
 <290226f1d7144477a668f045cbd8eb56@realtek.com>
In-Reply-To: <290226f1d7144477a668f045cbd8eb56@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31172-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[realtek.com,justthetip.ca,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mh_chen@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0B70C86AF7
X-Rspamd-Action: no action

+Isaiah for Wi-Fi USB driver,

-----Original Message-----
From: Ping-Ke Shih <pkshih@realtek.com>=20
Sent: Monday, January 26, 2026 11:40 AM
To: Lucid Duck <lucid_duck@justthetip.ca>; linux-wireless@vger.kernel.org; =
Bitterblue Smith <rtl8821cerfe2@gmail.com>; Mh_chen <mh_chen@realtek.com>
Subject: RE: [PATCH] wifi: rtw89: usb: fix TX flow control by tracking in-f=
light URBs

+ developers of WiFi USB adapters

Lucid Duck <lucid_duck@justthetip.ca> wrote:
> rtw89_usb_ops_check_and_reclaim_tx_resource() currently returns a=20
> hardcoded placeholder value of 42, violating mac80211's TX flow=20
> control contract. This causes uncontrolled URB accumulation under=20
> sustained TX load since mac80211 believes resources are always available.

Then URB becomes exhausted?=20

>=20
> Fix this by implementing proper TX backpressure:
>=20
> - Add per-channel atomic counters (tx_inflight[]) to track URBs between
>   submission and completion
> - Increment counter before usb_submit_urb() with rollback on failure
> - Decrement counter in completion callback
> - Return available slots (max - inflight) to mac80211, or 0 at=20
> capacity
> - Exclude firmware command channel (CH12) from flow control
>=20
> Tested on D-Link DWA-X1850 (RTL8832AU) with:
> - Sustained high-throughput traffic
> - Module load/unload stress tests
> - Hot-unplug during active transmission
> - 30-minute soak test verifying counters balance at idle
>=20
> Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>

[...]

> diff --git a/drivers/net/wireless/realtek/rtw89/usb.h=20
> b/drivers/net/wireless/realtek/rtw89/usb.h
> index 203ec8e99..f72a8b1b2 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.h
> +++ b/drivers/net/wireless/realtek/rtw89/usb.h
> @@ -20,6 +20,9 @@
>  #define RTW89_MAX_ENDPOINT_NUM         9
>  #define RTW89_MAX_BULKOUT_NUM          7
>=20
> +/* TX flow control: max in-flight URBs per channel */
> +#define RTW89_USB_MAX_TX_URBS_PER_CH   32

Curiously. How did you decide this value? Have you tested USB2 and USB3 dev=
ices?
How about their throughput before/after this patch?

> +
>  struct rtw89_usb_info {
>         u32 usb_host_request_2;
>         u32 usb_wlan0_1;
> @@ -63,6 +66,9 @@ struct rtw89_usb {
>         struct usb_anchor tx_submitted;
>=20
>         struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
> +
> +       /* TX flow control: track in-flight URBs per channel */

I feel we don't need repeatedly adding this comment. If you like it, just k=
eep one.

> +       atomic_t tx_inflight[RTW89_TXCH_NUM];
>  };
>=20
>  static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev=20
> *rtwdev)
> --
> 2.52.0
>=20


