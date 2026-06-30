Return-Path: <linux-wireless+bounces-38308-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rR2cL3ENQ2p5OQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38308-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 02:27:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 136C66DF613
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 02:27:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=d2NwCBZA;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38308-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38308-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D94F43011127
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B418871F;
	Tue, 30 Jun 2026 00:27:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491740D56E;
	Tue, 30 Jun 2026 00:27:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782779246; cv=none; b=TbyafB4X0gDHPCWBJ6KxOAZTB0iSRX9KNPR4Nn7UGjflx0JFaNV9BEIfNbYL4ZlTMnCz13+M3Ic391/uBdN2UbJQ79n0PhG3a2wdTAjf6OtZ7T8zCztwbmT1BKZrhKOt3PsVwGDFkGVxZAHbD7mDb5wYhw0e+H1iIWitAPnLoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782779246; c=relaxed/simple;
	bh=8wAVPdwj84X4xW0CMXEYhBKS2xEvjo34oyTEbv6ljf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P38YMcHN8hk3zJFe80BX8Qxd7KPOI92rj+I+Uv0YwkEytVl/+OuNx97sfR2v0nIFKT78vxddpVAUDRKiMd44NrVanURcOJY6KfmeLkhdQ1F5Jit9BFlurEMeoaYDV9CNVYE7lVzI9LgyqlhBlv56+F9bxZ5d/SSOwuCXv1O6ohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=d2NwCBZA; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65U0R3W804004176, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782779224; bh=8wAVPdwj84X4xW0CMXEYhBKS2xEvjo34oyTEbv6ljf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=d2NwCBZAgx/QAp2aKtCe72ZMobwB7pyhx93CPJIdGDskDZDDPoBpRjH/OFKYwJgvB
	 N3aP3HgJYmAe/Fs46TXqOPDRMn8JSnDzGrwMnI1bk+KX7h6TXCdHhLWb6KUVd60zAn
	 9N0Xqo0w/0FI75q7V2kKGcFL0EM2gyTLuwA3+LsoFVO5RL3bAmbqXLUMnDobOw5Tan
	 QiTrvdSbhSN7YPDr9RiLB5dn3GTYE/1tgVFtBj7az8NNYM5Gbn8HK6Kk4R936eUJ8E
	 //ti0QetVM0OxbrONgFyJZRwoKhfOGALeCeqF2MJV7+FV2S6ev97tC5dlmSKUX+GxF
	 57kQMI/NV9AZg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65U0R3W804004176
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jun 2026 08:27:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 30 Jun 2026 08:27:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 30 Jun 2026 08:27:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Morgun <d.morgun@ispras.ru>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v3] wifi: rtw89: check return values in
 rtw89_ops_start_ap()
Thread-Topic: [PATCH rtw-next v3] wifi: rtw89: check return values in
 rtw89_ops_start_ap()
Thread-Index: AQHdB6yGBat2UlXDIU6MC6TToLZCtrZWPqYg
Date: Tue, 30 Jun 2026 00:27:04 +0000
Message-ID: <d58f1e279a0944529669a1e49d96cac6@realtek.com>
References: <20260629094452.8709-1-d.morgun@ispras.ru>
In-Reply-To: <20260629094452.8709-1-d.morgun@ispras.ru>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38308-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:d.morgun@ispras.ru,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 136C66DF613

Dmitry Morgun <d.morgun@ispras.ru> wrote:
> Subject: [PATCH rtw-next v3] wifi: rtw89: check return values in rtw89_op=
s_start_ap()

Patch is fine. But I don't remember why this is v3. Can you point out
v1 and v2?

> Several functions called in rtw89_ops_start_ap() may fail to allocate
> skb or fail to send H2C command to firmware, returning -ENOMEM or an
> error code. Their return values are ignored, so subsequent commands
> are executed with incorrect state.
>=20
> Check the return values and propagate errors.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: a52e4f2ce0f5 ("wifi: rtw89: implement ieee80211_ops::start_ap and =
stop_ap")
> Signed-off-by: Dmitry Morgun <d.morgun@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>




