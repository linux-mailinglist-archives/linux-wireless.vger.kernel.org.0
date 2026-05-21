Return-Path: <linux-wireless+bounces-36737-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOoHBvxWDmoZ+AUAu9opvQ
	(envelope-from <linux-wireless+bounces-36737-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 02:51:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B08B959D692
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 02:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22E82301B3CA
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 00:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343562727E2;
	Thu, 21 May 2026 00:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WmsiEghw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB327FD76
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324666; cv=none; b=KQtRh4hSxazT7QbcnxZQk3rxk22wR6m/GRR1RT7Yw4jBT4BzfTZfm0Be7YiKNOga3D2KXmTCHWtXV6cfkyXnufN7jbC23pzKvxe8HFMc2wLxzKVFsg5c+9mNZ4anxQWrqTRcH01W/IupAOqgTwv76tOE9cdFLCQCEPMZUsiENTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324666; c=relaxed/simple;
	bh=ULMn7UhQ9lz5xIggsDXs7IWXZq2FHKb4TXvFkXpJlCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KNEy9Qma2cp8sbUl0/7cvwNNast3YcQxdSTYQ+HkRurR7b4PXUVJfyBrqOnkdpvv40h2oIvFs2JIU/upYmJ87Tm5W8kMIihp2b6Y5ZY4bt6ao4PRhA0amuaeody2Tw8UCdKqZH/2YG3n0WXgJZyBwB8ylibbRST49yiSBGdf9h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WmsiEghw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64L0oRWM1754080, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779324627; bh=ULMn7UhQ9lz5xIggsDXs7IWXZq2FHKb4TXvFkXpJlCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WmsiEghwZiI7yG9P+sq3JAsU0AncnINcF2nKBpr5tow7JTGIWZXtTfkaolH44FmWc
	 AFy08oLK8GkAOuTyF8KisU77rL4VVhnq1yH76lO7BNH/d936nbF1FlEM1R1SVl6Q8u
	 GWcGZyDakm+vC5Yuq8jkmIS7O9PaFsLCyDjkTArhFrkep7WU4EkoA4+x3HBYmwSmzO
	 dZ9+mxEZMQwS+ll/yeHD9FbG/YLe+0xtF9mZXJ2zPwHjrqyWaDXMbrP6gX/L7QgMqK
	 w9i/XMz/m0IpSxJkld8EpASXys06N2s8ibko+9zPNHH1fo+4lQoYXAT3IyODL4Gj2d
	 cXBMlGKKqSpCA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64L0oRWM1754080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 08:50:27 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 May 2026 08:50:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 May 2026 08:50:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 21 May 2026 08:50:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: LB F <goainwo@gmail.com>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>,
        Fiona Klute <fiona.klute@gmx.de>,
        "andrej.skvortzov@gmail.com" <andrej.skvortzov@gmail.com>,
        "anarsoul@gmail.com" <anarsoul@gmail.com>,
        Zhen XIN
	<zhen.xin@nokia-sbell.com>
Subject: RE: [PATCH rtw-next v2] wifi: rtw88: Add more validation for the RX
 descriptor
Thread-Topic: [PATCH rtw-next v2] wifi: rtw88: Add more validation for the RX
 descriptor
Thread-Index: AQHc6GL8ZnnnGocfaEehrIhqseGVmLYXprxw
Date: Thu, 21 May 2026 00:50:27 +0000
Message-ID: <ce31120c297642c7a49eb468d43dd277@realtek.com>
References: <5bfecba3-8a90-4e0f-9558-af5cd8a14975@gmail.com>
In-Reply-To: <5bfecba3-8a90-4e0f-9558-af5cd8a14975@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36737-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,googlemail.com,gmx.de,nokia-sbell.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:mid,realtek.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B08B959D692
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IFNv
bWUgUlRMODgyMUNFIGNhcmRzIGNhbiByZXR1cm4gZnJhbWVzIHdpdGggY29ycnVwdGVkIFJYIGRl
c2NyaXB0b3IsDQo+IGNhdXNpbmcgd2FybmluZ3MgYW5kIGNyYXNoZXMgaWYgdGhleSBhcmUgcGFz
c2VkIHRvIHRoZSB1cHBlciBsYXllcnMuDQo+IA0KPiBUaGUgUEhZIHN0YXR1cyBzaXplIGZpZWxk
IGlzIDQgYml0cyB3aWRlLCBidXQgaW4gcnR3ODggaXRzIHZhbHVlIHNob3VsZA0KPiBvbmx5IGJl
IDAgb3IgNC4gQ2hlY2tpbmcgdGhpcyBjYXRjaGVzIG1vc3Qgb2YgdGhlIGNvcnJ1cHQgZnJhbWVz
Lg0KPiANCj4gSWYgYSBQSFkgc3RhdHVzIGlzIHByZXNlbnQsIHRoZSBQSFkgc3RhdHVzIHNpemUg
c2hvdWxkIG5vdCBiZSAwLg0KPiANCj4gVGhlIGZyYW1lIHNpemUgc2hvdWxkIG5vdCBiZSBsZXNz
IHRoYW4gb3IgZXF1YWwgdG8gNCBhbmQgc2hvdWxkIG5vdA0KPiBleGNlZWQgMTE0NTQuDQo+IA0K
PiBUaGUgcmF0ZSBzaG91bGQgbm90IGV4Y2VlZCA0U1MgTUNTOS4NCj4gDQo+IERpc2NhcmQgdGhl
IGZyYW1lIGlmIGFueSBvZiB0aGVzZSBjaGVja3MgZmFpbC4NCj4gDQo+IENsb3NlczogaHR0cHM6
Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMjEyODYNCj4gU2lnbmVkLW9m
Zi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2Vk
LWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

