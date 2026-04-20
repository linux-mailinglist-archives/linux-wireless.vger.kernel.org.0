Return-Path: <linux-wireless+bounces-35018-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG12JKLm5WlkpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35018-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 10:41:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 303FE4284C3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 10:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D299300D1C5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6476C38911F;
	Mon, 20 Apr 2026 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CWgjlEma"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC83890F6
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674459; cv=none; b=ckIFf8kHrzIMvXNqZhexXZxIc16m7oGqIWD/5Pn5e9FqjkyW4t2O79rIonxCMQRb6L0uKRUEzvCOb9kRfNo9BZlOwibCf4iV12NDRSBvqnVD9u9Ga3D9omXC8DkUTeNO950u5KD3YajEgJDMSBxalEVgj8npH0SlLmWXsCjN7Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674459; c=relaxed/simple;
	bh=DgvgaOGTr8UmTjzrXapbNwc6LkFbtB2z/UzwDd/Qpbw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1eTtLRZGA6prSeZ07g6O34xnZqm1kuJfVs8B/xTHYWGqIw2tGjlbKxGwd649uDpBm3WbNgyl1Y77R+RYRvW9vDhKgvLx3gbMwW8mH+beyTYqr8u1h3QhrSZzn2cy+PYHsLDg1Q+6jDcelRdVSbLKWi18daUPNP8NjFmfE5EfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CWgjlEma; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K8esST3837758, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776674454; bh=DgvgaOGTr8UmTjzrXapbNwc6LkFbtB2z/UzwDd/Qpbw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CWgjlEmazAhFX5FEy2iiOB+srz7PP/M4zZm5K8SCHr+vTtVutvvArsf/WVKmC7WEm
	 jaBuxrq0n5cgPRBvZA3Ywcyi4JEBdXWbDeXm2HP9i7TX1Y1MCK3RusocxSyRpyw2a4
	 qStfS81VjBZPHnc0ey9kkJl1iagbq9c4Eys5pzFUyBFmV+FIR8Sz/2sR9xIsVGOr4U
	 u+v1XqNO8kymQkl5Q2mqitIIh7q8flTZ4o2G6UPD2ofy5JWunD0qbUIhoYDb2zsem8
	 SIxx1IXqf22QOLp7M/ZK54YAWkg2Na/kmWpz7ELfas9jh+yeHL6w0xU8wEuvRmFhkz
	 bo1SN/HnPBs2Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K8esST3837758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 16:40:54 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 16:40:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 16:40:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 20 Apr 2026 16:40:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 07/11] wifi: rtw89: Let hfc_param_ini have
 separate settings for USB 2/3
Thread-Topic: [PATCH rtw-next v2 07/11] wifi: rtw89: Let hfc_param_ini have
 separate settings for USB 2/3
Thread-Index: AQHc0ALJKi3iy2PPqkeAi5gWGMSS3bXnookw
Date: Mon, 20 Apr 2026 08:40:51 +0000
Message-ID: <e36c4468a7ce4803a5f99cc0096a5b65@realtek.com>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
 <588bf309-4b92-454f-bfd6-5e81248abee3@gmail.com>
In-Reply-To: <588bf309-4b92-454f-bfd6-5e81248abee3@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-35018-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 303FE4284C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
OTEyQVUgbmVlZHMgZGlmZmVyZW50IHNldHRpbmdzIGZvciBVU0IgMiBhbmQgVVNCIDMuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNv
bT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo+IC0t
LQ0KPiB2MjoNCj4gIC0gQ2hhbmdlIHJ0dzg5MjJkLmMgYXMgd2VsbC4gSXQgZGlkbid0IGV4aXN0
IHdoZW4gdjEgb2YgdGhpcyBwYXRjaCB3YXMNCj4gICAgc2VudC4NCg0KVGhhbmtzIGZvciBhd2Fy
ZW5lc3Mgb2YgdGhpcyA6KQ0KDQoNCg0K

