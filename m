Return-Path: <linux-wireless+bounces-38639-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tfk0Ec0ES2rtKwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38639-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 03:28:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B670BEAC
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 03:28:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=oCo+iUlU;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38639-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38639-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 895933009CE1
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 01:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535D358375;
	Mon,  6 Jul 2026 01:28:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7A351C28;
	Mon,  6 Jul 2026 01:28:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783301320; cv=none; b=qlm/Y2IHg7aqj8bgeOR7n6AJMazZ9vEB7HZGwGAfEPzCWwooXpneLfr2eZrqnwIoyK0xMWqSCvWodMXxbuHHyjwGW/I3P+d6QYFytqmL/VECr5TklFTFG52Wx1zJBw7j9T4uE850XMaUTALvHfpmht9U+sNSkQ7DEXlbhKv84vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783301320; c=relaxed/simple;
	bh=v3PNJ/RQd351yGcxp0r+YMw4QM0LA4U5u3IHub7pbzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0Yg0UbqcK4QQb1sqO6CO+HYJavwm3HBaRJDwjNrFABF4fkS7B7dn9B3NzKQ3XBqTQo0eKq1hAjrzpC4CPgDAwGLQkkGit7NomnshHPdkyvLzsoEd+AcfU3b9KAjIcENMyriywGiQO04+E/VAsqdvqEZWwH1xREU0A3vJA4UToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=oCo+iUlU; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6661SDu34072315, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783301294; bh=v3PNJ/RQd351yGcxp0r+YMw4QM0LA4U5u3IHub7pbzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=oCo+iUlURhle24JuZEf2xWb1P3owwI0ebF3lOEos5b02mHQjvR+imExR1mjlxTIDz
	 AcKBpj8Mc3HDUu7qw6GOFZeNiteNTipVZqwPTvdfyARaWUakHxNfONpEaZYNY+wvea
	 7cUxDTdoTcgUaYMJsNr5r6sKo0dr3eE0IrkOKK6TG2OKXodrqcQLIC+i7obTJSGldF
	 wRR0C9zEPduWEtB+BmSwxajun88VsbaHRUOPdjLKE5Rh+L+4ysomEPXZEDwNDzFIk4
	 sA+WYT7dhfBVqiu7BtPqcSt4h6Z7HzdtnObkQKd8bxKijHj3KoaGwWWb1mCm1FiDC9
	 o0Ix0dhs3Lj3A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6661SDu34072315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 Jul 2026 09:28:13 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Jul 2026 09:28:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Jul 2026 09:28:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 6 Jul 2026 09:28:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "d.morgun@ispras.ru" <d.morgun@ispras.ru>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v3] wifi: rtw89: check return values in
 rtw89_ops_start_ap()
Thread-Topic: [PATCH rtw-next v3] wifi: rtw89: check return values in
 rtw89_ops_start_ap()
Thread-Index: AQHdB6yGBat2UlXDIU6MC6TToLZCtrZWPqYggAU0LACABErpkA==
Date: Mon, 6 Jul 2026 01:28:14 +0000
Message-ID: <a2bab03c876345bbaebf5f05f99040f2@realtek.com>
References: <20260629094452.8709-1-d.morgun@ispras.ru>
 <d58f1e279a0944529669a1e49d96cac6@realtek.com>
 <6754361d578f7418fe85e1aec8a6b618@ispras.ru>
In-Reply-To: <6754361d578f7418fe85e1aec8a6b618@ispras.ru>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38639-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:d.morgun@ispras.ru,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ispras.ru:email];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F7B670BEAC

ZC5tb3JndW5AaXNwcmFzLnJ1IDxkLm1vcmd1bkBpc3ByYXMucnU+IHdyb3RlOg0KPiBIaSBQaW5n
LUtlLA0KPiANCj4gU29ycnkgZm9yIHRoZSBjb25mdXNpb24uIFRoZSB2MyBzdWZmaXggd2FzIGFk
ZGVkIGJ5IG1pc3Rha2UgZHVyaW5nIGxvY2FsDQo+IGl0ZXJhdGlvbnMgb2YgdGhlIHBhdGNoLg0K
PiANCj4gVGhlcmUgaXMgbm8gcHVibGljIHYxL3YyIGluIHRoZSBtYWlsaW5nIGxpc3QgaGlzdG9y
eS4gVGhpcyBpcyB0aGUgZmlyc3QNCj4gdmVyc2lvbiBzdWJtaXR0ZWQgdXBzdHJlYW0uDQo+IA0K
PiBJIHdpbGwgcmVzZW5kIGFzIHYxIGlmIG5lZWRlZC4NCg0KTm8gbmVlZCB0byByZXNlbmQuIEkg
aGF2ZSBtZXJnZWQgdGhpcyBwYXRjaC4gDQoNClRoYW5rcw0KUGluZy1LZQ0KDQo=

