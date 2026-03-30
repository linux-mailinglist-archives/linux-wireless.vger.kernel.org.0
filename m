Return-Path: <linux-wireless+bounces-34153-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6aM8JV/7yWmd3wUAu9opvQ
	(envelope-from <linux-wireless+bounces-34153-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:26:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B1F355457
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81ECB3001FAC
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486301E5724;
	Mon, 30 Mar 2026 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="tEopj3L3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98F228DC4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774844760; cv=none; b=qTRhmBd19aoyZT6Wmhri5FPMZwWIPFtAGiTZ1pj6MtzwNd4qsLRz+VrCbWV/o9dzLXMj50J2DB882xGLtICXrcvr4wtOQ2QUN51VaG07hyr9rP5oakJdltPmKEKAoWytO0Ba5OPYgY4Vt5NcjFNziZPfl723STytsnaG+QUiGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774844760; c=relaxed/simple;
	bh=qLuFi/Xsd7liuO7aQmpQZH5v8TkbCZKdIka44pgn3C4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lXJMzajEk/Vxgoafu87SZEYqhTWShdjolRBGLpQ4CPpltfvuW/tetjYwRV7moir85Z4/rZ+/ZCp3ao8kCWEkS2n2CwBz0yGBw+KHPNyWzcw/GfR06IBsC+Zpo6joHldQ74VnWQUWtDEYfO/ie9PhrupuLaZqSk/4/a59oq3dfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=tEopj3L3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U4PsaU6328034, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774844754; bh=qLuFi/Xsd7liuO7aQmpQZH5v8TkbCZKdIka44pgn3C4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tEopj3L3hT3cuzSNIMzg5Nel77h4I6O/MHAzKHBzf/9iF/lIN8XZQA/JFpUp4+cHi
	 u3q7qYrEMs/k8KFeGfhwH1n/mB7eED97S+DmzSoHzC1jNwHv9qeJGk9yUPDj/es7ka
	 /znrl1jbDxQ9oUR24rk6ywursGPPANaM5BPNn9fazegFjc/eFQgJXXUMHIS24dETLV
	 jJnOYG6UKki3k4jq+JF8oK4nASmQ6AUE99qTRP9qqmf9RdR7N2eKmJu0dOUuCNu0Dz
	 jUGqgzFAp4VZGuK/rdSb3TFizkgbHPHDCOx/Begd6NSr/FwBechqIo7KTG3V8y6QSq
	 FLQyQWBPM6d8g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U4PsaU6328034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 12:25:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 12:25:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 12:25:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 10/12] wifi: rtw89: Add rtw8922a_dle_mem_usb{2,3}
Thread-Topic: [PATCH rtw-next 10/12] wifi: rtw89: Add
 rtw8922a_dle_mem_usb{2,3}
Thread-Index: AQHcvUM1D3B6FE/RCUehtQRDHclSubXGf79w
Date: Mon, 30 Mar 2026 04:25:55 +0000
Message-ID: <f7e0bc5c572a49a0a1f307bbc2f60832@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <44678760-ded9-4542-8626-37cd71d30c51@gmail.com>
In-Reply-To: <44678760-ded9-4542-8626-37cd71d30c51@gmail.com>
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
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34153-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: 82B1F355457
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
cnR3ODkyMmFfZGxlX21lbV91c2IyIGFuZCBydHc4OTIyYV9kbGVfbWVtX3VzYjMgYW5kIHRoZWly
IHZhcmlvdXMNCj4gcXVvdGFzIGFuZCBzaXplcyBpbiBzdHJ1Y3QgcnR3ODlfbWFjX3NpemVfc2V0
Lg0KPiANCj4gImRsZSIgY291bGQgYmUgIkRhdGEgTGluayBFbmdpbmUiIG9yICJEb3VibGUgTGlu
ayBFbmdpbmUiLiBUaGVzZSBhcmUNCj4gc29tZSBwYXJhbWV0ZXJzIG5lZWRlZCBmb3IgUlRMODky
MkFVLg0KPiANCj4gQWxzbyByZW5hbWUgd2RlX3NpemU0X3YxIHRvIHdkZV9zaXplM192MSBiZWNh
dXNlIHRoZSBuYW1lIHNlZW1lZA0KPiBpbmNvcnJlY3QuDQoNCk5vdCBzdXJlIGlmIHZlbmRvciBk
cml2ZXIgZGlkIHNvbWUgY2hhbmdlcyBmb3IgdGhpcywgYnV0IEkgY2hlY2tlZCB0aGUNCmxhdGVz
dCB2ZXJzaW9uIHdoaWNoIGl0IGxvb2tzIGxpa2UgYXMgeW91ciBjaGFuZ2VzLg0KDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4N
Cg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo=

