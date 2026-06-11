Return-Path: <linux-wireless+bounces-37663-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u9fCKSB7KmqGqgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37663-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 11:08:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD206703BD
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 11:08:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=dH6jb6Ec;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37663-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37663-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A6643007978
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107B285CB9;
	Thu, 11 Jun 2026 09:08:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055533D6EA;
	Thu, 11 Jun 2026 09:08:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168926; cv=none; b=fNO8xmKIgeFxGhiLnSXfW2+YsLtW/++XEmwT1p8I9411dxsH9a8NNAIXnZJQPH87XiHfQWb67gUy0iIRjjlzMgJFjv2/C1lx9+M72HJFqHjbwhuJTbHyoWpJfY3Le2ra8gRBqBUWbRL6vsYih0To2ypB1/UVGfxoNaUkJjEc+/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168926; c=relaxed/simple;
	bh=r4EOnctjpPmPGtatMLc5tV39VGj7npeYLqZZDaFa6sA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hOZsIWyoJ7AveXIF+fvL2Ck1/zH3ClaWAqmN/vF/mEVEamIlfXjzpi2OVI295lYIAksrR+x4CmomJ79Lz3c8BgpptIVeECF2r/PvNwSKp4IU/akvB+B9OKQGPa/CCxhpbNKr/blzHDLQW+UlSGSMmpMZxdzfRuHVfZHD0x0Ni5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dH6jb6Ec; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B98eimE1823749, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781168920; bh=r4EOnctjpPmPGtatMLc5tV39VGj7npeYLqZZDaFa6sA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dH6jb6EcyvmfDOSbd1QjxJACJkP/DP/cqoeIOq1Ui5h1gj4zZACYnix37/4qbZAkU
	 C0xZdRE2lITsIjdIbAZ5Zw36tfxwVa4IkDShtHSuXwcZPm6YprR3DpM56r6+uKMJIi
	 HwU5hCz6kMDAQguVy9qx2ccFqIoV3bqCEi4xYSKmL5ZRbp8chEJqeL72rErwvN9iAN
	 ktgKoLKqz5GFp/wMLrN8EyfhanS9CBEuRMXOk9mK/NoGP7gCy/XnAudGD15gx4lUr/
	 BBML9One/8mIkujqzClRRxvCQEDbsv/wEMBHh3lHDMKYz+GU7Fta0hhKFGb+M9Tp7V
	 VxMrnncTLDdFg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B98eimE1823749
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jun 2026 17:08:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 17:08:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 11 Jun 2026 17:08:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Wentao Guan <guanwentao@uniontech.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?big5?B?RGF2aWQgWWFuZyi3qKjlsGEp?= <dian_syuan0116@realtek.com>,
	"zhanjun@uniontech.com" <zhanjun@uniontech.com>, "niecheng1@uniontech.com"
	<niecheng1@uniontech.com>
Subject: RE: [PATCH] wifi: rtw89: fw: correct
 rtw89_fw_h2c_default_cmac_tbl_be()
Thread-Topic: [PATCH] wifi: rtw89: fw: correct
 rtw89_fw_h2c_default_cmac_tbl_be()
Thread-Index: AQHc+XtFIorFAI00TU+w0k4KkSb5drY5D8rAgAAAl1A=
Date: Thu, 11 Jun 2026 09:08:39 +0000
Message-ID: <1017648a65ec4b139b76e2eb7583da26@realtek.com>
References: <20260611082021.46650-1-guanwentao@uniontech.com>
 <60dbac65771f46ae85efb922dd9f319e@realtek.com>
In-Reply-To: <60dbac65771f46ae85efb922dd9f319e@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37663-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:guanwentao@uniontech.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dian_syuan0116@realtek.com,m:zhanjun@uniontech.com,m:niecheng1@uniontech.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uniontech.com:email,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BD206703BD

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiBTZW50OiBUaHVyc2Rh
eSwgSnVuZSAxMSwgMjAyNiA1OjA2IFBNDQo+IFRvOiBXZW50YW8gR3VhbiA8Z3VhbndlbnRhb0B1
bmlvbnRlY2guY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBEYXZpZCBZYW5nKLeoqOWwYSkNCj4gPGRpYW5fc3l1
YW4wMTE2QHJlYWx0ZWsuY29tPjsgemhhbmp1bkB1bmlvbnRlY2guY29tOyBuaWVjaGVuZzFAdW5p
b250ZWNoLmNvbQ0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSB3aWZpOiBydHc4OTogZnc6IGNvcnJl
Y3QgcnR3ODlfZndfaDJjX2RlZmF1bHRfY21hY190YmxfYmUoKQ0KPiANCj4gV2VudGFvIEd1YW4g
PGd1YW53ZW50YW9AdW5pb250ZWNoLmNvbT4gd3JvdGU6DQo+ID4gQkVfQ0NUTF9JTkZPX1cyX1BS
RUxPQURfRU5BQkxFIGlzIGZvciBoMmMtPncyLCBub3QgaDJjLT53MS4NCj4gPiBUaGVzZSB3aWxs
IGNhdXNlIGgyYy0+dzEgd3Jvbmcgb3ZlcmxhcCBieSB3MiBhbmQgdzIgbm90IGluaXRpYWxpemVk
Lg0KPiANCj4gVGhhbmtzIGZvciB0aGUgY2F0Y2guDQo+IA0KPiA+DQo+ID4gRml4ZXM6IGM3MzYw
N2IzYThlZiAoIndpZmk6IHJ0dzg5OiBmdzogYWRkIENNQUMgSDJDIGNvbW1hbmQgdG8gaW5pdGlh
bGl6ZSBkZWZhdWx0IHZhbHVlIGZvciBSVEw4OTIyRCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogV2Vu
dGFvIEd1YW4gPGd1YW53ZW50YW9AdW5pb250ZWNoLmNvbT4NCj4gDQo+IEFja2VkLWJ5OiBQaW5n
LUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gDQoNClRvIGxldCBzdWJqZWN0IGNsZWFy
LCBJJ2xsIGNoYW5nZSBpdCB0bw0KIiB3aWZpOiBydHc4OTogZnc6IGNvcnJlY3QgcHJlbG9hZCBm
aWVsZCBvZiB3MiBpbiBydHc4OV9md19oMmNfZGVmYXVsdF9jbWFjX3RibF9iZSgpICINCg0K

