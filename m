Return-Path: <linux-wireless+bounces-34147-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGMkK+rwyWn13QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34147-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:41:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 061293550E3
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B1A300F52D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9640221F39;
	Mon, 30 Mar 2026 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kTbZUIdc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596740DFD1
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774842087; cv=none; b=aSpSrhhPSJZfkDfd8ybY35OFFLQ95Ga12/IhalaS93o94vd/tYO5E+LksduSrfdefnvTiadcDwGv0zRB/iJ/4llBXaww+CPdA/LqV5G0qMwqo5NRy++57EVr7adNAyYx7z1gFNt6AH8jGXRlyzRheyUkjXhvXQBfyXtmWh/U0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774842087; c=relaxed/simple;
	bh=phhJDOxwVUHQ5+5MDVSHkwSaOpJeI1vl0J5HMbDSk5U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fVBFaygMEGggnYBkdKj7tsCP6sVe2XLdAraLnyvjvuldDtpfImDddqkWdDDeSh1RSuIvchWNZdXuY7xGBxoriM4Lnx3p8gOGo63UPU3drmkQpm6quisNNyMnxaDLhaOtSrynQm1sDESvQ/KHmzFu0JzBzwqmnKN0Y1XDF9sqeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kTbZUIdc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U3fLrlD265097, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774842081; bh=phhJDOxwVUHQ5+5MDVSHkwSaOpJeI1vl0J5HMbDSk5U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kTbZUIdcpv2MrRwJ0YcPKM/XshEKoCVzd7luxCS/N5WQ3wqHPqK33kSFh/htTuIwm
	 WhlveBpRMTS/AxuNxz3NR+pnmZuNFjBsuZdbtkk4llRWFy3MMHk5/Mb5OFVSbsRwd5
	 SJI11wQjZHevW2k/9joxd1YB7W3GTTwdmEXicVVbY0CMX/pn4jyQ4g4WYC8iKiglDh
	 I/CAS8hMXbnkpoLV3ggconif28VdfiFWmfohDzSY73zk9u0fjgUz2Dl5MMYOTJ7iap
	 cK12RcIELMZFXmrLL1JnjeCVFCdUWVID9SS9gO9F9V+qvs40DFo0lUsCtYclKXqHcP
	 k8IK2CmyvB1Rw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U3fLrlD265097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 11:41:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 11:41:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 11:41:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 05/12] wifi: rtw89: Fix
 rtw89_usb_ops_mac_post_init() for RTL8922AU
Thread-Topic: [PATCH rtw-next 05/12] wifi: rtw89: Fix
 rtw89_usb_ops_mac_post_init() for RTL8922AU
Thread-Index: AQHcvULQFOzpHoxXkUOxUUnTlgjIVLXGc4rA
Date: Mon, 30 Mar 2026 03:41:22 +0000
Message-ID: <0ad6a9f45d16485fa411829e7ab4e626@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <560b65f9-5e60-4a42-8661-fd98eea6e9d7@gmail.com>
In-Reply-To: <560b65f9-5e60-4a42-8661-fd98eea6e9d7@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-34147-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: 061293550E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTa2lw
IG1vc3Qgb2YgdGhlIGZ1bmN0aW9uIGJlY2F1c2UgUlRMODkyMkFVIG9ubHkgbmVlZHMgdG8gY29u
ZmlndXJlIHRoZQ0KPiBSWCBhZ2dyZWdhdGlvbiBoZXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

