Return-Path: <linux-wireless+bounces-37644-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z9DCNjAIKmpThgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37644-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 02:58:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C166D922
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 02:58:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=GebO+4O7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37644-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37644-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9FF430DAF98
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 00:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B401519B4;
	Thu, 11 Jun 2026 00:58:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727AE35893
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 00:58:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781139502; cv=none; b=un5BERxqA61Rs17F4COodDM0iccTQfWK0DRQNJ21BoD1CUBfF3LCW4LMYWjHAgGS5ldRfszqql0bAZiaSNN9twTvwL6QD8B1OL+JZBfHVcF/ofC9dbIB7+c6gTubkoxpXxAypMumx2SLZjq1KUn1fdYst8tlLJJmqgFVfckQf0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781139502; c=relaxed/simple;
	bh=0zaxIiB2SsBHCQV2pACYWwjSYi8Qlqwgyj7G/Zrp9Ck=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tz5AV/L2td4YF3cPbvG1jsRePMIPVFMSMSzXdqFytv4e3LYw0I8jowUOc2pFH5wNsZQNAQelglKb6gWdURW7viowkDdcQJpjSajrXLUYdiABaXFsAP9CDGrnY4dJPc04qGMpgNYGEJ0zgqpRBvSAfPdnD8RBgJ9qtOGBkM1jVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GebO+4O7; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B0wFD411496963, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781139495; bh=0zaxIiB2SsBHCQV2pACYWwjSYi8Qlqwgyj7G/Zrp9Ck=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GebO+4O7wdHMf+tYDkMAg/RtraXrQdaURatp35GlBGogS2jalD54/qp2ugRqJ5V3c
	 5BBpyXKGcCKu2e1uY6uzNxN5Us0YmIE8U0VCkr+lFEmU/G58wTGI9rmGK1kjXNjL6e
	 VUohv8V1Qiqbl4rZXDsAy0YTq17/cCz4Sl14SO1x8Y7XLnYcRzkckfa7an5Kq845bh
	 NXDDaFThMHHYjzSNMuTiqlrIcjrd28MQROB51bqu5HG+EFNn9VZtpbuCR6km5SWmMf
	 ONk9ApGDbEcjOzOM1S0RZtumbnTAQABCRO4s8LsW8nB0HJreqX5Cghht9byads6Hnj
	 SFXqN2tjB1X0w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B0wFD411496963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jun 2026 08:58:15 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 08:58:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 08:58:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 11 Jun 2026 08:58:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/2] wifi: rtw88: 8822c: Don't process RF path C
 in query_phy_status_page{0,1}
Thread-Topic: [PATCH rtw-next 1/2] wifi: rtw88: 8822c: Don't process RF path C
 in query_phy_status_page{0,1}
Thread-Index: AQHc+NlIBbceEAuLBkKiaLeBIwZl5bY4iNmg
Date: Thu, 11 Jun 2026 00:58:15 +0000
Message-ID: <2916142fe261429c9351e9513c49474a@realtek.com>
References: <ee30b95f-bc68-4711-9b15-cf5fd23c3c48@gmail.com>
In-Reply-To: <ee30b95f-bc68-4711-9b15-cf5fd23c3c48@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rtl8821cerfe2@gmail.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37644-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 385C166D922

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSZXBs
YWNlIDw9IHdpdGggPCBpbiB0aGUgbG9vcHMgaW4gcXVlcnlfcGh5X3N0YXR1c19wYWdlezAsMX0o
KS4gVGhleQ0KPiB3ZXJlIHByb2Nlc3NpbmcgZGF0YSByZWxhdGVkIHRvIFJGIHBhdGggQywgd2hp
Y2ggdGhpcyBjaGlwIGRvZXNuJ3QgaGF2ZS4NCj4gVGhlIG9ubHkgYmFkIGVmZmVjdCBzZWVtcyB0
byBiZSB0aGF0IHRoZSBwaHlfaW5mbyBmaWxlIGluIGRlYnVnZnMgd2FzDQo+IHByaW50aW5nIHVu
ZXhwZWN0ZWQgdmFsdWVzIGZvciBSRiBwYXRoIEMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0
ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmct
S2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

