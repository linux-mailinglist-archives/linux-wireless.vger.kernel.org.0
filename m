Return-Path: <linux-wireless+bounces-34154-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKY0Hsn7yWmd3wUAu9opvQ
	(envelope-from <linux-wireless+bounces-34154-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:27:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2186355472
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4D973004C3C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F7826FA60;
	Mon, 30 Mar 2026 04:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UvXEOlys"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1671E5724
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 04:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774844869; cv=none; b=jIQTBHeysuMHExxW55rw50Q3JA29AukfHtMf6+nsXA0MmgTNxxFKECXIO89hdpd9cUJwtxZRAtfBIQSbCx+oBupuQ6WT3Ny8BodYEuD3NH9d5keIs2Af4oO9isqOEHcRx9o/0UGLk5/ifACMkaai2naevpO7EUTyB2zV3mwengU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774844869; c=relaxed/simple;
	bh=sZylmzMLzJxGwwmn8ymS0FkPCnFB8fRV6r5mxc8W/8I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UQ5dkxyakw7eFC5xgztaH1ekeZPzuSuwRl5hyvaihQJ1fosYiAyUCDI9T+2n1BJvsVeDvPfnC8C/qhZYtJn/SOmkD/D8MdsS0JTUXJkMkKgzvVDitGP/D4PmLNFfmv8s7hVe3FeIaRufbdXk4TuLznC4h0/XOIeiMfkwABP9AEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UvXEOlys; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U4Rh9X2331110, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774844863; bh=sZylmzMLzJxGwwmn8ymS0FkPCnFB8fRV6r5mxc8W/8I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=UvXEOlysgNfwSszH8f2H6HhPqhD3GAoA57jac3mUE62laJA202u4+w40lQibO6xFR
	 xC14g3RQM99Q0BThzdXdB0GVw00b1AvfnT9LWzsqPxmkeC++oHKjRkSTMHB53wWq91
	 en6SuKlE/JpNuNqUFmrVxYMHQ+HMIxyjEDm5drjxBumAWFiLFsxjV/pw2ALVDZ5l+c
	 S8cPdFQGRWchF2k+eAQSLOt3yQYNkoBTS+/2STqkYcfxUsomD0d/cggDVk/m/OpOi+
	 NgYjt/Byvn2aPJHlhdLw9vg0KRxWcCVIOnMsQpjWAB3982PO9e6zqeDeR1NPpANKVG
	 Tac+vdmJ8AikA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U4Rh9X2331110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 12:27:43 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 12:27:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 12:27:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 12:27:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 11/12] wifi: rtw89: Add rtw8922au.c
Thread-Topic: [PATCH rtw-next 11/12] wifi: rtw89: Add rtw8922au.c
Thread-Index: AQHcvUNJkGyhGqYK+0yI7avQ2jzPIbXGgH2g
Date: Mon, 30 Mar 2026 04:27:44 +0000
Message-ID: <4adb61ed69d3441ebde505cff98d9c9a@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <c171e4ff-2a84-4c71-9c1c-a485863c1855@gmail.com>
In-Reply-To: <c171e4ff-2a84-4c71-9c1c-a485863c1855@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-34154-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E2186355472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IGlzIHRoZSBlbnRyeSBwb2ludCBvZiB0aGUgbmV3IHJ0dzg5Xzg5MjJhdSBtb2R1bGUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNv
bT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

