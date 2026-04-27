Return-Path: <linux-wireless+bounces-35327-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R35qI/zG7mmUxgAAu9opvQ
	(envelope-from <linux-wireless+bounces-35327-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 04:16:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FD46C0F1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 04:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CC0A3009CF8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 02:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D62282F03;
	Mon, 27 Apr 2026 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IY9i8h63"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ECC2AD00
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777256185; cv=none; b=Osje5HqlSH6dDhECf7Hg5BEmk44Vd2hM0gL6OEuKFfl47JFLYdyM2Srl6DZmiYdqO9b/EOqj89qzYDU2LiEm4frnArjtnNbqsom+r50H9HvVrolmCdeRPPOepmeyTjttPnR6L5IeDuMLPk4jQP12WX25juvFBWCSVabkWXxjv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777256185; c=relaxed/simple;
	bh=/BMAX3r8w8LmEaUIlf7cbzFq+UBgAVFXPMynSEHKLmk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FlsLDwI1kkSk5nOUp72fIN81NwOIFYW1W6d4PtO2CkKq++8WevgtWH1/gedLDY/Nzg45Ps0vHqAsorbPqB47RkzSFGvnDO92mm6n8DpAxP3ONl51ffRleirKcuqNGDNLspErRe2CzTvZH63BjcgbLXEmw/cP9qq9Ea3kgm799pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IY9i8h63; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63R2GJEJ03215987, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777256179; bh=/BMAX3r8w8LmEaUIlf7cbzFq+UBgAVFXPMynSEHKLmk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IY9i8h63TovqY0puBeSNpPmhmssWeCaE5ujcdQx6E/uJV3n++YUbm6wpAQbmqcOW0
	 lLzomRDLkY2LWvn6bIQ2Q9CsNzBBKC5ieeCAwk4UCzAkoZpjrRrUPSu9PFevg2z4cu
	 6R5SePh4wJLLWYef+ZNONeNkRxIaMKg5f/C6Vj+CTm0e2HryLpmtu/B3S5nsSjQ5QZ
	 m+GVxv0URic2bfsAnQAE+PzfaAlWlQQh/1xtPnAGKlA444/DhF4I0i+QXbBLcmSAFv
	 UGKGShzzUYdiWKWhdGHpC/BwrWPWEbzUA9U9qJxHJvVOfZikWCJluj3lGjSgxuWufo
	 4HCn20kQWtO3w==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63R2GJEJ03215987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 10:16:19 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 27 Apr 2026 10:16:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 27 Apr 2026 10:16:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 27 Apr 2026 10:16:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtlwifi: rtl8821ae: Fix C2H bit location
 in RX descriptor
Thread-Topic: [PATCH rtw-next] wifi: rtlwifi: rtl8821ae: Fix C2H bit location
 in RX descriptor
Thread-Index: AQHc1OpXwGeiOHGX2UiTYJzp2rKUcLXyLXXw
Date: Mon, 27 Apr 2026 02:16:19 +0000
Message-ID: <d1c3fad594524619b661bb793792026b@realtek.com>
References: <04da7398-cedb-425a-a810-5772ab10139d@gmail.com>
In-Reply-To: <04da7398-cedb-425a-a810-5772ab10139d@gmail.com>
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
X-Rspamd-Queue-Id: DC1FD46C0F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35327-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBCaXQg
Mjggb2YgZG91YmxlIHdvcmQgMiBpbiB0aGUgUlggZGVzY3JpcHRvciBpbmRpY2F0ZXMgaWYgdGhl
IHBhY2tldCBpcw0KPiBhIG5vcm1hbCA4MDIuMTEgZnJhbWUsIG9yIGEgbWVzc2FnZSBmcm9tIHRo
ZSB3aWZpIGZpcm13YXJlIHRvIHRoZQ0KPiBkcml2ZXIgKENhcmQgMiBIb3N0KS4NCj4gDQo+IENv
bW1pdCBmNTY3OGJmZTFjZGMgKCJydGx3aWZpOiBydGw4ODIxYWU6IFJlcGxhY2UgbG9jYWwgYml0
IG1hbmlwdWxhdGlvbg0KPiBtYWNyb3MiKSBtaXN0YWtlbmx5IG1hZGUgdGhlIGRyaXZlciBsb29r
IGZvciB0aGlzIGJpdCBpbiBkb3VibGUgd29yZCAxLA0KPiBjYXVzaW5nIHBhY2tldCBsb3NzIGFu
ZCBCbHVldG9vdGggY29leGlzdGVuY2UgcHJvYmxlbXMuDQoNClRoZSBtaXN0YWtlIGluIHRoZSBj
b21taXQgaXMNCg0KI2RlZmluZSBHRVRfUlhfU1RBVFVTX0RFU0NfUlBUX1NFTChfX3BkZXNjKSAg
ICAgICAgICAgICAgICAgICAgXA0KLSAgICAgICBMRV9CSVRTX1RPXzRCWVRFKF9fcGRlc2MrOCwg
MjgsIDEpDQorICAgICAgIGxlMzJfZ2V0X2JpdHMoKigoX19sZTMyICopKF9fcGRlc2MgKyA0KSks
IEJJVCgyOCkpDQoNCj4gDQo+IEZpeGVzOiBmNTY3OGJmZTFjZGMgKCJydGx3aWZpOiBydGw4ODIx
YWU6IFJlcGxhY2UgbG9jYWwgYml0IG1hbmlwdWxhdGlvbiBtYWNyb3MiKQ0KPiBDYzogPHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0
bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+DQoNCg0K

