Return-Path: <linux-wireless+bounces-11465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8FC952991
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3EF1F230D6
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B582741AAC;
	Thu, 15 Aug 2024 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mT980cUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07010BA20
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723705222; cv=none; b=R0mXAqhow9wV0feSovbL9zTFa0KS6EU3nUi/gQpRcTsGYogS6RJFrmEIpj9QQMZT8+wRWtNIjPK3wxaowPtR/pjqw/WtnBNnCQmNvDng7f1JZTus+qFlZS0l9NebJOEiiLCormN8Zbl64ujj4NbFFRCAvZSlgWOMggR2LLrJEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723705222; c=relaxed/simple;
	bh=L1+I3YBQjox5AohJgi/jZdSNJGjurRshlleSZLR2Mos=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qbciw5NNTt/Sx2Srh5xAMDCOhgLvdu8KVHbBYf7pEhJPdwDhDEF9iyDDSF5/69cRqTJGqxAWcpMywsioGbxlDLmU0Z3fYCKG8iTu622If8329WFb2Xx+xr3I+uGfd54qWi3BwngFeWdmDNvnTZzA0IiUUSn2lb6ekE4YjrRDCEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mT980cUt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F70GUc83720220, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723705216; bh=L1+I3YBQjox5AohJgi/jZdSNJGjurRshlleSZLR2Mos=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mT980cUt3g84iWTLDbpItuP+Y6pIpfNRVzkmOMLjydUTuVLTtHmHEKl/qg48UnHI9
	 92AO+JwTwPaRUrU29t1Uya6kbTq1CFbx6e/U/lyiD32uaFo4GZlu7PdjyxGcWfQfXj
	 sfcPdEOlNRa5EAPfL2/o0AMnOybk3FnP0wY4i0r4t22mRVX/pbp+8VBo9/cn0ilZ+c
	 A7dgnkeROKKqvXFDg9BqrQ+vwDq8DY7mr1Vl8HHB+ZSG4/HSz0xS2o8NBQ20fn8Mva
	 hBn0uZrUTk24Xqnj2mOL1nmOu8ruCZEefLeChTQvvYfuvxsQ0+MTCD3LVyuj6gaOnE
	 dWI5+ouzJcBDg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F70GUc83720220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:00:16 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 15:00:17 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 15:00:16 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 15:00:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 10/20] wifi: rtw88: Move pwr_track_tbl to struct rtw_rfe_def
Thread-Topic: [PATCH 10/20] wifi: rtw88: Move pwr_track_tbl to struct
 rtw_rfe_def
Thread-Index: AQHa7DGjuFhznaDrWEeMzrXs/QY20rIn6Rfw
Date: Thu, 15 Aug 2024 07:00:16 +0000
Message-ID: <013ae495dd66405db520ddb4eb255113@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <571ace0f-0455-46ec-bcd5-49a87b31f3e2@gmail.com>
In-Reply-To: <571ace0f-0455-46ec-bcd5-49a87b31f3e2@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
ODEyQVUgdXNlcyBvbmUgc2V0IG9mIFRYIHBvd2VyIHRyYWNraW5nIHRhYmxlcyBmb3IgUkZFIDMs
IGFuZA0KPiBhbm90aGVyIHNldCBmb3IgZXZlcnl0aGluZyBlbHNlLg0KPiANCj4gTW92ZSBwd3Jf
dHJhY2tfdGJsIGZyb20gc3RydWN0IHJ0d19jaGlwX2luZm8gdG8gc3RydWN0IHJ0d19yZmVfZGVm
IGluDQo+IG9yZGVyIHRvIGxvYWQgdGhlIHJpZ2h0IHNldCBvZiB0YWJsZXMgZm9yIGVhY2ggUkZF
IChSRiBmcm9udCBlbmQpIHR5cGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo=

