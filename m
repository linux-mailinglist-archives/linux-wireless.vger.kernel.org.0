Return-Path: <linux-wireless+bounces-34564-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJKiEfd02Gn9dQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34564-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 05:56:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B151E3D1F93
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 05:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6225B300E146
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 03:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3958131E848;
	Fri, 10 Apr 2026 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ORkeRdJB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022A32C92D
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775793395; cv=none; b=jbZKsAsTqxWs1akEvoyVFj7J7FUuqIXsdxogTBiNv1gbtn3xriw4Phkpxisxk6qOUgvEi1vNB9MiFmTyyjB5HlQdUvuiJ6gY7gj5pykpUs2NEXzqZeHzTi5k6TM2RyGThYAbj4d7KpsV2gXw8CWqS4ipMPlvCALwlLTjv+kX1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775793395; c=relaxed/simple;
	bh=Q6Hz55Rnvq7vOMPwlPXAu+3VZYrW4yy1ZOPpweL593g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kf/+JdfGrAk4C616t6eJjibBF48C3vk9SKOeI4TMn4a/EcMyn/RZTlCdwXkJUFIGYAEAIEWc4snp3AYai2xHo5rMNq60Jdk8uO1Qi2S7ca9WbEdggni8XqIb3cvzJxT7gcuW/O/VZM9xrMh48miwBZzVBrnTH4xoXqp2AL/3cJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ORkeRdJB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63A3uB3a92360848, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775793371; bh=Q6Hz55Rnvq7vOMPwlPXAu+3VZYrW4yy1ZOPpweL593g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ORkeRdJB1u3p+MEhY49hrMdtq9X9pi2AYPo+tORbOXUVV/C33kRrPLo62fNs3UJpx
	 FEvy1reBzld1DMpjR39zUbYAkPMFovylyUyob4TlvU4gkNgBp6FVx+QezzLblqjVvx
	 uHbh5pzqk7EuShwwIvGUhYUJDl8rfgmH5ezfI4zy6NmrylucHDxc5JI9e5EEDB+Gbd
	 ieW+QrJ0piAwo+gyAx/EGDYpAo1scqQlAsPjuevuyVJBMhwfzM5OYtGohk9qOkqmuk
	 PWEw02p8ed4cpmgk8KfyHoVmmpnv+wV1LhAC/WcEOciqukt6R1hMDuCXmAFMhR5ooV
	 3MtzBWniA5Q2w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63A3uB3a92360848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 11:56:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 10 Apr 2026 11:56:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 10 Apr 2026 11:56:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Fri, 10 Apr 2026 11:56:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        Kalle Valo
	<kvalo@kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: RE: [PATCH] rtw88: add TX power limit support to 114 and 130 channels
Thread-Topic: [PATCH] rtw88: add TX power limit support to 114 and 130
 channels
Thread-Index: AQHcrZj6b0aZaPK17kqRjXoafOBZKbXX3tPQ
Date: Fri, 10 Apr 2026 03:56:11 +0000
Message-ID: <55c23c5551354c6f8752d620f268b37b@realtek.com>
References: <20260306-rtw88_channel130-v1-1-ff25a5bc930a@igalia.com>
In-Reply-To: <20260306-rtw88_channel130-v1-1-ff25a5bc930a@igalia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34564-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B151E3D1F93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VGhhZGV1IExpbWEgZGUgU291emEgQ2FzY2FyZG8gPGNhc2NhcmRvQGlnYWxpYS5jb20+IHdyb3Rl
Og0KPiBUaG91Z2ggMTE0IGFuZCAxMzAgYXJlIG5vdCB1c3VhbCBjaGFubmVscywgdGhleSBhcmUg
Zm91bmQgaW4gdGhlIHdpbGQgd2l0aA0KPiBzZXR1cHMgdXNpbmcgNTM1ME1IeiBhcyB0aGUgY2Vu
dGVyIGZyZXF1ZW5jeSBvZiBhIDgwTUh6IHNldHVwLg0KDQpXaGF0IGRpZCB0aGUgQVAgc2V0dXA/
IGNoYW5uZWwgMTE0IDE2ME1Iej8NCkkgd29uZGVyIHdoeSBydHc4OCBjYW4gc2VsZWN0IGEgbm90
IHVzdWFsIGNoYW5uZWwgMTE0IDgwTUh6Lg0KDQpQbGVhc2Ugc2hhcmUgeW91ciBlbnZpcm9ubWVu
dCBzZXR1cC4gDQoNCj4gDQo+IHJ0dzg4IHN1cHBvcnRzIHRoYXQsIGJ1dCBpc3N1ZXMgYSBXQVJO
SU5HIGJlY2F1c2UgaXQgY2Fubm90IGZpbmQgdGhlIFRYDQo+IHBvd2VyIGxpbWl0IGZvciB0aG9z
ZSBjaGFubmVscy4NCg0KQWN0dWFsbHksIHJ0dzg4IGhhcmR3YXJlIGNhbid0IHN1cHBvcnQgdGhh
dCwgc28gd2UgYXJlIHdvcmtpbmcgb24gcGF0Y2gNCnRvIGF2b2lkIHNlbGVjdGluZyB1bnVzdWFs
IGNoYW5uZWxzLiBDYW4gaXQgd29yayBwcm9wZXJseSB3aXRoDQp0aGUgQVAgYWZ0ZXIgdGhpcyBw
YXRjaD8NCg0KUGluZy1LZQ0KDQo=

