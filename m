Return-Path: <linux-wireless+bounces-35646-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALxzNNPd8mlgvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35646-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:42:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4039B49D56A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A970300A8FA
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180D634F259;
	Thu, 30 Apr 2026 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WWoQAaf0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16A2848BA
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777524159; cv=none; b=DQ6thzlM9NFAb7Vv1EpT96QKuS4WoulEJLjglsbJDPNyzH9yUvQuz/Ng/87V4J0jeYsw6xptRSq69M8FqEaEyfbjKMqN+ZEqaDIwykhQRJRbZhqr7WjGV/IywY4dnPaq0Jp8g+oC6ZlOJ5215YdgW5HMHRElXZMXsEjCjnghXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777524159; c=relaxed/simple;
	bh=8/n6e1uhVC1bq6XWw9TnxtNDhUZp003SIysCYAG8SR0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hK6KteYIuJ8kd5wE21A4SZUpQ2UAAfyqDMTZnwov4cSXI8UgSM7MLasb027H/8QjQ5Ai/kTP+gQgfPJAJoDvPzGU34rw6E+s8NbjDg0LB/hm9mVklA3oEcGpGkhnh16KeK0fEtSRhZZrnCcOU2zmRzakAVbOuCgEvFvPzD+nPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WWoQAaf0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63U4gXjyD1693676, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777524153; bh=8/n6e1uhVC1bq6XWw9TnxtNDhUZp003SIysCYAG8SR0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WWoQAaf0R14uKBmob8JCHIFLS9dg3+iJQd50yf46zJ6VMxo/k7tnEVPK9OGn9SCBQ
	 /PxnyxM+DeArdGUxUyKl4yA3moEXEKO2HPg+NHa4BScH0bfI9Sm9uVy87B5aaGuCcb
	 vWsfX/cY4jCvGO/lneUTlWSyGg3Q5olU7uEmPSsQfmfAgzV2FV5bkmqFhvCeH2meBd
	 mOW211+1nNxhL65Kolq21IMs565YQyUS5Q4TBBhQDMq/XE91NASRojz2cvS5eLcVGM
	 HTWBTzjuadfBOcF6urgq3IklMczKvamQWwhcqSjq3GwI3zr4bGTDDKHIkfkhhe5XQX
	 SRnWFT49Zzxvw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63U4gXjyD1693676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 12:42:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 30 Apr 2026 12:42:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Thu, 30 Apr 2026 12:42:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sivanantham Chinnaiyan <sivananth321@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RTL8922AE: Severe latency spikes (>200ms) during wifi scan
 triggers
Thread-Topic: RTL8922AE: Severe latency spikes (>200ms) during wifi scan
 triggers
Thread-Index: AQHc1x3sWMqKBjvnZUCLXhILgI7SDbX3CDTA
Date: Thu, 30 Apr 2026 04:42:33 +0000
Message-ID: <3b9fedf23b39409f8b5979ed36ea02ed@realtek.com>
References: <CAEAGRPaA+Cw3wykVXpFHfs=qwQCv-=VuBpxisg6VjOPGaGfXDw@mail.gmail.com>
In-Reply-To: <CAEAGRPaA+Cw3wykVXpFHfs=qwQCv-=VuBpxisg6VjOPGaGfXDw@mail.gmail.com>
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
X-Rspamd-Queue-Id: 4039B49D56A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35646-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

U2l2YW5hbnRoYW0gQ2hpbm5haXlhbiA8c2l2YW5hbnRoMzIxQGdtYWlsLmNvbT4gd3JvdGU6DQo+
IFNldmVyZSBsYXRlbmN5IHNwaWtlcyAoMjAwbXMrKSBvY2N1ciB3aGVuZXZlciBhIFdpLUZpIHNj
YW4gaXMNCj4gdHJpZ2dlcmVkIChlLmcuLCBjbGlja2luZyBXaS1GaSBtZW51IGluIEdVSSkuIFRo
aXMgaGFwcGVucw0KPiBjb25zaXN0ZW50bHkgb24gYm90aCAyLjQgR0h6IGFuZCA1IEdIeiBuZXR3
b3JrcywgdGhvdWdoIGl0IGlzIG11Y2gNCj4gbW9yZSBldmlkZW50IGluIDIuNEdIeiBjaGFubmVs
LiBJIGtub3cgdGhhdCBsYXRlbmN5IHNwaWtlcyBkdXJpbmcNCj4gc2NhbnMgYXJlIG5vcm1hbC4g
QnV0IEkgYW0gbm90IHN1cmUgaWYgMTUwK21zIGlzIGNvbnNpZGVyZWQgbm9ybWFsLg0KDQpJdCBz
ZWVtcyBsaWtlIHRoZSBwaW5nIGxhdGVuY3kgd2l0aG91dCBzY2FubmluZyBpcyBhYm91dCA1MG1z
IGluIHlvdXINCmVudmlyb25tZW50LCBhbmQgY3VycmVudGx5IG9mZi1jaGFubmVsIHRpbWUgb2Yg
UlRMODkyMkFFIGlzIDEwMG1zLCBzbw0Kcm91Z2hseSBpdCdkIGJlIDE1MG1zIHdpdGggc2Nhbm5p
bmcuDQoNCldoYXQgaXMgdGhlIHByb2JsZW0geW91IGFyZSBlbmNvdW50ZXJpbmcgYmVjYXVzZSBv
ZiBsb25nIGxhdGVuY3k/DQoNClBpbmctS2UNCg0K

