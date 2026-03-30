Return-Path: <linux-wireless+bounces-34155-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gjGdK278yWnJ3wUAu9opvQ
	(envelope-from <linux-wireless+bounces-34155-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:30:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DA9355483
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B144F300DE0E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9547261A;
	Mon, 30 Mar 2026 04:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dFnKAklN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A128DC4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 04:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774845034; cv=none; b=oOHTMx/IhwpHPiHG686ysxGu2RudICGUglOCqcet7s0tBw9uc6+qG1g0AT5PIg+EwmHg4YnlUrvhvU07C7Hg+2awGo04TB/La/3I63qSJC7XyaLqWESHxmEfdJkV4N04Ir9Qah29RGTyQf/eV3gPs3EgOV9TIdWsPNt6hfX4km0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774845034; c=relaxed/simple;
	bh=ZocL3RYvPZ9h1x63Y1rudeqQfWH+nYVBvS7rXhYftZc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bssuzxzzTsbtYZng3zaxgUyf6jTJHLB0j1iIxh7YDigea+RdDeJkvbfmKJ/4WC5gWI6T0OuvBksLq5Yo/qHZbjm3xb233/d6WlJ9zpwcxYfbjtDHYuJNmmaDcU9pqII9ppKMVePWWV+99leBRo6Dkd1R68Raq5Nq20iSmJtmbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dFnKAklN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U4UTk94332661, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774845029; bh=ZocL3RYvPZ9h1x63Y1rudeqQfWH+nYVBvS7rXhYftZc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dFnKAklNgSoRDMyX98Mtl1uBOKvdCV+PxOCSeXU+kkalBlnh57YpTQohK3e7vNeDC
	 sRxVCDvbHmfk9/XyNuEjzkbSpW3Vsy1gbHB0bvrIR/3uk84011oFT/LO9l992zmD0q
	 5Lpln5qmWaf+p+JnpMCQKk2O/J9xvPCC2toF0sQMdTEC30KtkLq2Wwzf5WVkbBY7NB
	 H4zn/hotziF74x3BbfR/cRcRK+cCTrUWxwZO6O+TDwJg/Q6XEtEuB/ZOXWdexSvw+X
	 zi7M6IinMRw9W8vNNFS5WPhPRz4f0t3mKaV0EoonUBR2usRVrXK0/Umc8QK19YpanN
	 Dir1dVtwVXFxg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U4UTk94332661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 12:30:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 12:30:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 12:30:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 12/12] wifi: rtw89: Enable the new rtw89_8922au
 module
Thread-Topic: [PATCH rtw-next 12/12] wifi: rtw89: Enable the new rtw89_8922au
 module
Thread-Index: AQHcvUNhxarQpdDaFkqvlDgjxfTWhbXGgJ9Q
Date: Mon, 30 Mar 2026 04:30:29 +0000
Message-ID: <3a47d4ced7f745ba838c430a8a864462@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <99125850-8dee-4a98-ab68-5d171449a2e0@gmail.com>
In-Reply-To: <99125850-8dee-4a98-ab68-5d171449a2e0@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34155-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: E6DA9355483
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUZXN0
ZWQgd2l0aG91dCBNTE8sIG1vc3RseSBpbiBzdGF0aW9uIG1vZGUgYW5kIGEgbGl0dGxlIGluIEFQ
IG1vZGUuDQoNCkNvdWxkIHlvdSBzaGFyZSB0aGUgcmVzdWx0IGFib3V0IHRocm91Z2hwdXQgb3Ig
ZGF0YSByYXRlPw0KDQpTaW5jZSB5b3Ugbm90ZWQgd2FybmluZ3MgcmVsYXRlZCB0byBSRiBjYWxp
YnJhdGlvbiwgSSdtIHZlcnkgaW50ZXJlc3RlZA0KaW4gdGhlIG51bWJlci4gDQoNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0K
DQpPdGhlcndpc2UsIA0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5j
b20+DQoNCg0K

