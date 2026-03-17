Return-Path: <linux-wireless+bounces-33322-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJxlJBPCuGkfjAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33322-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 03:53:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0082A2F46
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 03:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E30C3013DF6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 02:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C33282F3F;
	Tue, 17 Mar 2026 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AYiyeGvY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F760199949;
	Tue, 17 Mar 2026 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715985; cv=none; b=Sy6Wrw7C5L/08mBufiUPKj8cMJbCT7X7cVU3GtT71b7qMFLWizMvLipuM3RmlNQqfRo5tWJ9jzzsoYwCUefxLxD7sWRzZrR2i84Va2s7sSQI91WENcLuMSqS2wtbTY7xLfA8rjQVpgXfZ7iKAmYfeVNe2yVUNn9tDhm8eZKEzSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715985; c=relaxed/simple;
	bh=pvimW8ZYCHV3f4TRFHz3JjybSEfqOOXY89e9arJlkWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fer/kSn6S0O+0U0aQRTjRtlVyTor4ROM/Ph0KmfPBUZUun917GvYqKfmkFPqsbF1qpBjIxTMy8/c0f+jtScAQofT5DtD7eivhd6oI0tI2gCRfgf22WqWVekaii0QDkOAXy0NDA0SeLmuvexmPIvXLhLu3JpOc0Qql0bX/S7tFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AYiyeGvY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62H2qrQuB3100834, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773715973; bh=pvimW8ZYCHV3f4TRFHz3JjybSEfqOOXY89e9arJlkWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AYiyeGvYsRdZEiVIyox85jzmofQdDWdzz6G8nhdvuVhU3FFm6N//fTax6SHs0ANmU
	 WYvLSx/aDCcPzVwVRa9P5TnRsrBzJAg7w6B2WjcQXXhHvXzDCVejlbA29DVHVEQBDr
	 onvzrSu0Wl258vNqJDF2bjjp0UGuy1iFNqzoGeAqEwpOPsxdF/4n6GO1AJFMielNOR
	 nIusbY+BhVRZZvSdXRaDI6f4UiVjjj9ptxfslJ04yw72f1WSX3vYAhCALRugV4giC8
	 P2msyYX/HgV2GwmagV/yquPynodUzNdaCJRp+oSoKMVkBWVh5HZEK829Bp+1QlOJXM
	 1/1D4crRl5M0Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62H2qrQuB3100834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 10:52:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 17 Mar 2026 10:52:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 17 Mar 2026 10:52:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?R2VvcmcgTcO8bGxlcg==?= <georgmueller@gmx.net>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v3 1/4] wifi: rtl8xxxu: move
 dynamic_tx_rpt_timing_counter from ra_info to priv
Thread-Topic: [RFC PATCH v3 1/4] wifi: rtl8xxxu: move
 dynamic_tx_rpt_timing_counter from ra_info to priv
Thread-Index: AQHcsvKN7nlD0qqX6kuVFEnvPxtmwLWwsvLg//+wK4CAAajX8A==
Date: Tue, 17 Mar 2026 02:52:52 +0000
Message-ID: <44e9c61d5f5d48f7880a7d9c8f1433eb@realtek.com>
References: <20260313135321.3196688-1-georgmueller@gmx.net>
 <20260313135321.3196688-2-georgmueller@gmx.net>
 <fbd2420985544f858374468d25e848f5@realtek.com>
 <3724d77a-8aa4-40ec-9a4a-644cb1439837@gmx.net>
In-Reply-To: <3724d77a-8aa4-40ec-9a4a-644cb1439837@gmx.net>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33322-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Queue-Id: 3F0082A2F46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

R2VvcmcgTcO8bGxlciA8Z2VvcmdtdWVsbGVyQGdteC5uZXQ+IHdyb3RlOg0KPiBBbSAxNi4wMy4y
NiB1bSAwNzoxNyBzY2hyaWViIFBpbmctS2UgU2hpaDoNCj4gPg0KPiA+IEdlb3JnIE3DvGxsZXIg
PGdlb3JnbXVlbGxlckBnbXgubmV0PiB3cm90ZToNCj4gPj4gZHluYW1pY190eF9ycHRfdGltaW5n
X2NvdW50ZXIgaXMgbm90IHBlciBtYWNfaWQsIGJ1dCB1c2VkIGFjcm9zcyBhbGwNCj4gPj4gbWFj
X2lkcy4NCj4gPg0KPiA+IEkgZG9uJ3Qga25vdyB0aGUgcHVycG9zZSBvZiBkeW5hbWljX3R4X3Jw
dF90aW1pbmdfY291bnRlci4gQ291bGQgeW91DQo+ID4gc2hhcmUgeW91ciBzdHVkeT8NCj4gPg0K
PiBJdCBpcyB1c2VkIGdsb2JhbGx5IChub3QgcGVyIG1hYykgbGlrZSB0aGlzIGluIHRoZSB2ZW5k
b3IgZHJpdmVyIGFzIHdlbGwgWzFdWzJdLg0KPiBCaXR0ZXJibHVlIFNtaXRoIGdhdmUgdGhlIGhp
bnQgdGhhdCB0aGlzIHNob3VsZCBub3QgYmUgcGVyIG1hY2lkIFszXSwgc28gaXQgc2hvdWxkDQo+
IG1vdmUNCj4gb3V0IG9mIHN0cnVjdCByYV9pbmZvLg0KPiANCj4gWzFdDQo+IGh0dHBzOi8vZ2l0
aHViLmNvbS9sd2Zpbmdlci9ydGw4MTg4ZXUvYmxvYi9tYXN0ZXIvaGFsL0hhbDgxODhFUmF0ZUFk
YXB0aXZlLmMNCj4gI0wyNDgNCj4gWzJdDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9sd2Zpbmdlci9y
dGw4MTg4ZXUvYmxvYi92NS4yLjIuNC9oYWw4MTg4ZXJhdGVhZGFwdGl2ZS5jI0wNCj4gMjg1DQo+
IFszXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy85MzhhZTYwOC1h
ODY1LTQwNTYtMDZkZS1jMjMwZDc0ZTE4NDdADQo+IGdtYWlsLmNvbS8NCj4gDQoNClRoYW5rcyBm
b3IgdGhlIGluZm8uIEkgY2FuJ3QgZmluZCB0aGUgbG9nIGludGVybmFsbHksIHNvIGxldCdzIGtl
ZXAgaXQgDQphcyBnaXRodWIgZG9lcy4NCg0KUGluZy1LZQ0KDQo=

