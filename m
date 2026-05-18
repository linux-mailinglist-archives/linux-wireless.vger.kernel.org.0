Return-Path: <linux-wireless+bounces-36570-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHNND5i7CmrG6wQAu9opvQ
	(envelope-from <linux-wireless+bounces-36570-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:11:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA9E56737D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA34C3017047
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 07:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDFC3DDDA7;
	Mon, 18 May 2026 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QZXPXnO+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B53DDDAC;
	Mon, 18 May 2026 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088275; cv=none; b=fbEsLzFLqSODuN/2GfBU0VzkRUXl7N6JeJi6fqQLrBE4+XTd/Hu8nnrq8fKEGtpkOkBdVNcO0l03TSSQj2bFq1IOv8ncUxAxw/T1F978rI10HN9+uNHxRQCn/YHmB4FNSqGRJmd7yS+7KaI1yJklAm2u0vdq5z+TlpN0H2VhxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088275; c=relaxed/simple;
	bh=KOpfRWiBzQlt1cuimGysHbgxAhDMS7xC7zspm5/+RAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NXWlrcM7+B92r5LdyY4d140f/pKNj/1LrP6vhBsUubW6i18wOIL6rcJ64UzHdAk47hFjkagCX2T7rOR+TGalR5l+U82+ID+2J7L8lKs6rs2g9fd6Ygqrt/yMJR/U57LJxqRxeZKZEHvP/8nI2lQUkjy9O9eXJDKRwOogctlQu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QZXPXnO+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64I7Ak9fA1591140, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779088246; bh=UusWrsxYWh10jTSKmyTVyVOFnpR6CXqXoJ6iJPg18XQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QZXPXnO+Uh1t3u0tW0v/9iA1FEAmNiAjCayJe5Kb/B3aMYW2wOMNXiINq5aeyiBZe
	 DlCASb03ooIHnh3mid9Z3rnm7V/KidaIy3FQR833mTaKt/cglobcyjeSiVhQnFNmEd
	 AGtGcfCn7WmWh18r7HaiayeQF52se99CHBjfMO/kqqd5Br6pdjRWs5JwLuwCk7hTWf
	 XXcfEftr8odmfl7NCsXEPU6+ZyRUsSnDPNEWlD61GhXoYPMEus5xOeHvwOXd0V0kqO
	 NJFJeTLiB8vB77giU1SBxEVCAkHbCStcZO8u4EzmuWnEZkic9HCwMLeMq04FZpaJpT
	 9u8x8KHKrT0JA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64I7Ak9fA1591140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 15:10:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 May 2026 15:10:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 18 May 2026 15:10:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "luka.gejak@linux.dev" <luka.gejak@linux.dev>,
        Kalle Valo
	<kvalo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3] wifi: rtw88: usb: fix memory leaks on USB write
 failures
Thread-Topic: [PATCH v3] wifi: rtw88: usb: fix memory leaks on USB write
 failures
Thread-Index: AQHc4wPL8veVv0IqfU63ijjwNALo9LYTZDzg
Date: Mon, 18 May 2026 07:10:45 +0000
Message-ID: <bb6711f7f94544e69c031925133f9bf5@realtek.com>
References: <20260513181008.13470-1-luka.gejak@linux.dev>
In-Reply-To: <20260513181008.13470-1-luka.gejak@linux.dev>
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
X-Rspamd-Queue-Id: AEA9E56737D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36570-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> @@ -456,7 +457,13 @@ static bool rtw_usb_tx_agg_skb(struct rtw_usb *rtwus=
b, struct sk_buff_head *list
>         tx_desc =3D (struct rtw_tx_desc *)skb_head->data;
>         qsel =3D le32_get_bits(tx_desc->w1, RTW_TX_DESC_W1_QSEL);
>=20
> -       rtw_usb_write_port(rtwdev, qsel, skb_head, rtw_usb_write_port_tx_=
complete, txcb);
> +       ret =3D rtw_usb_write_port(rtwdev, qsel, skb_head,
> +                                rtw_usb_write_port_tx_complete, txcb);

ERROR: code indent should use tabs where possible
#54: FILE: drivers/net/wireless/realtek/rtw88/usb.c:461:
+^I^I^I         rtw_usb_write_port_tx_complete, txcb);$

CHECK: Alignment should match open parenthesis
#54: FILE: drivers/net/wireless/realtek/rtw88/usb.c:461:
+	ret =3D rtw_usb_write_port(rtwdev, qsel, skb_head,
+			         rtw_usb_write_port_tx_complete, txcb);

Please correct them and resend v4. (You can take my acked-by in v3)

> +       if (ret) {
> +               ieee80211_purge_tx_queue(rtwdev->hw, &txcb->tx_ack_queue)=
;
> +               kfree(txcb);
> +               return false;
> +       }
>=20
>         return true;
>  }




