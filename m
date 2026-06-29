Return-Path: <linux-wireless+bounces-38232-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YVeSLgvSQWoxuwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38232-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:01:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE36D5758
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:01:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=aOXr044e;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38232-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38232-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1528D300291B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 02:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C374340D597;
	Mon, 29 Jun 2026 02:01:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7AC40D568;
	Mon, 29 Jun 2026 02:01:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782698502; cv=none; b=XcTO9sa3SuXWbrRqTLxEoBeQzolpzNgqfEzBJLlJTXLjvflYNHuTu2oSTIRbrFHI+DPtZk82aRBBzQ/lusG3pPUAokT5mdxoM9rwKzvs+86kucVYU/1hPOgALlZvrQw9dxYUUPGB3CtvFjXEP4Gb7kVihyf445L11oztXcZ07o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782698502; c=relaxed/simple;
	bh=AkkTQtyLRV097Sms5de69DLZID2tlhNlWXMdF+M4o9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J0dWQFZ2heuTV1pOq2+HjKBjOay1w8fJxHdhjBi8suJiVUJN3rrZKmpkhjo4K6URurC1qIXEgI2CUiYRul0OK31el8vu2iJprQkpS0YQtHZ4XrtMS50uskyn90I3biReH5YEv585bmWDkffrkrIKsKwN8YTZlrXqhslTeI41WR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aOXr044e; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65T21be563310360, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782698497; bh=9b13Tp4GggjSaqurMEtCAd0qWj54OWNCOoCrY+wmap0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aOXr044eUjNuYbILSIxfOukoC/DF7i08KVIYvCfubmPnpH6E3i2PwMrwNeCVo0l1O
	 ivTJNUZmOuSPQzWbna+0/tHL1sUBg1s3A/G5uUmRFmmKfAJvq+ZDCGpgTw71ngoOeo
	 rNhLdqL/ZzF2AP553I+ZhH0lNHCf8ZzJ/p5pb7ZKQsVZ44x0z4txod6JYbzoe5D4WL
	 HN+SoI8K6JMzDryCfTjG7Yd2LgxNoWcCzrwl1uT+FukiJ7kvLzR4oCQ3PKbGvjGNSm
	 qDGBN1+C5Ai+1UgKfJkG7txu9hxUJbUUC3CVcDwXtr4Eh7v8gfr7qyuQB1/12e0dHn
	 xnmnbMkTXrxAg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65T21be563310360
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 10:01:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 10:01:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 10:01:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 29 Jun 2026 10:01:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: William Hansen-Baird <william.hansen.baird@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 2/3] wifi: rtlwifi: convert pci if-statement
 to ID table
Thread-Topic: [PATCH rtw-next v3 2/3] wifi: rtlwifi: convert pci if-statement
 to ID table
Thread-Index: AQHdBVIkcZkQT/mQz0GSNcfIj7+lj7ZUy39w
Date: Mon, 29 Jun 2026 02:01:36 +0000
Message-ID: <a7d55ea808d54d98ab5be41d53f41a65@realtek.com>
References: <20260626095648.1124924-1-william.hansen.baird@gmail.com>
 <20260626095648.1124924-3-william.hansen.baird@gmail.com>
In-Reply-To: <20260626095648.1124924-3-william.hansen.baird@gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38232-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:william.hansen.baird@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3BE36D5758

William Hansen-Baird <william.hansen.baird@gmail.com> wrote:
> Refactor the ASUSTek quirk logic from an if-statement to a standard
> rtl_aspm_quirks pci_device_id table. This allows future devices with
> the same quirk to be added more easily while avoiding a large if-chain.
>=20
> Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c
> b/drivers/net/wireless/realtek/rtlwifi/pci.c
> index 38eca8d91581..44121203671c 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -31,6 +31,12 @@ static const u8 ac_to_hwq[] =3D {
>         BK_QUEUE
>  };
>=20
> +static const struct pci_device_id rtl_aspm_quirks[] =3D {
> +       /* ASUSTek F441U/X555UQ */
> +       { PCI_DEVICE_SUB(PCI_VENDOR_ID_REALTEK, 0xb723, 0x11ad, 0x1723) }=
,
> +       { }

nit: we can just '{}' (without a space).

> +};
> +
>  static u8 _rtl_mac_to_hwqueue(struct ieee80211_hw *hw, struct sk_buff *s=
kb)
>  {
>         struct rtl_hal *rtlhal =3D rtl_hal(rtl_priv(hw));


