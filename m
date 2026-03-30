Return-Path: <linux-wireless+bounces-34151-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGWaJ2/2yWl+3gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34151-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:05:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C03355228
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27A6C3037E6C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FBB393DDB;
	Mon, 30 Mar 2026 04:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hR/aZUDg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D430526E71E
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843282; cv=none; b=ZVQiUMq283UEDj2NHkpteh2YG4arPDuoxs9nyufgpH8Dpqr4UQtSTvrCHeHqYBE/gK7Bd5no1i+yEEj4G2yg2cNfJkJN4Y8KNW2FuuCkUdLOISMlG+z2dks/Rkzig2n4iB+Ttj73OOAXdtZSQ2zFPX2rv+ziGPDmTcg4QpoPnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843282; c=relaxed/simple;
	bh=VPFIob+uD4G4PlP59XG0qnDZOwR2ZLnU+z3nxu5WGi8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CcSzeqXrYbbRDZCRBfsV+QeXlheyU96XI+kFWbesh3R1im7qd7QRxhTyUBv1fnFMxy0kJSnzZn2Bz0ZiwGBLevWUfjv59IlWe91muOeWbCLYBmZ52cF+0Yt+7aULaQM7wlLokNPdv2Dt6K+cnsjEz4gDdf/akQ756UM0N6xVyus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hR/aZUDg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U41HiD4304165, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774843277; bh=VPFIob+uD4G4PlP59XG0qnDZOwR2ZLnU+z3nxu5WGi8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hR/aZUDgBVkqlg03qaDvgapeY9VpwTeQED6s1HNHpig7bxTp7LTM/AgbcyimqXNok
	 I8m5GHRxJt6wx+Cdm9nXE1N8vcUG785GzNqTj+/aYYPsTvuYNQ70jchwls90l0Fl7o
	 xOVy32PEcS6wDZH0qq3p2XQLfnrPcwm8V/neBNmgcOJS7FAfZkBSmwGVsrirOO2PvX
	 Yiawh2tfCw9eD7HwGPhU40BRdFgkJvZmM/sA47iTQDGYWs/L6Qx4N7mZ5sixNGq8Ue
	 HfLzpmkh9EZmdlLhcFufBWD7+O0ess+7d5tmTW0pB6dbkMscZJ5dPg3hx30kngMWqe
	 RRlG+X/wEbAgQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U41HiD4304165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 12:01:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 12:01:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 12:01:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 09/12] wifi: rtw89: Add
 rtw8922a_hfc_param_ini_usb{2,3}
Thread-Topic: [PATCH rtw-next 09/12] wifi: rtw89: Add
 rtw8922a_hfc_param_ini_usb{2,3}
Thread-Index: AQHcvUMh1Jc0Id1tqUmtHBggYfYPg7XGeRfw
Date: Mon, 30 Mar 2026 04:01:17 +0000
Message-ID: <ea4abcb291d24b8a89761457c8bee45d@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <6a8b746c-f702-4a76-876d-bc39991b3baa@gmail.com>
In-Reply-To: <6a8b746c-f702-4a76-876d-bc39991b3baa@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34151-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09C03355228
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTZW50
OiBGcmlkYXksIE1hcmNoIDI3LCAyMDI2IDE6MDggQU0NCj4gImhmYyIgbWVhbnMgImhjaSBmYyIg
d2hpY2ggaXMgIkhvc3QgQ29udHJvbCBJbnRlcmZhY2UgRmxvdyBDb250cm9sIi4NCj4gVGhlc2Ug
YXJlIHNvbWUgcGFyYW1ldGVycyBuZWVkZWQgZm9yIFJUTDg5MjJBVS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0KDQo=

