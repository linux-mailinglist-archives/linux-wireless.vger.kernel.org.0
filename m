Return-Path: <linux-wireless+bounces-26854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF46B3B31A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 08:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D31D462105
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 06:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459A9223311;
	Fri, 29 Aug 2025 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZKRDowjd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA67404E
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448042; cv=none; b=seyIBs7YUZTlCNAZQZXD/E0zrZPv+dqxvw6Kl77ZY9X8rCo9k8Hm847fgRs13X7UUGrvMSKmmW1xWwk9cG32ob+PJFLJfhoygA6IfcVgCuWoQNUEVwpoRptwIWRY4OW/CDTEkihsGKiexmFj1lweSH5/QVoUb+M61oAzrfk1r4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448042; c=relaxed/simple;
	bh=hstyvumzzCjG4S+yphhApmnJhxe0KVfcsJT8jNHQ1kw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdmOljrAxncLfp9n4DbnKF7r/U0WlUwcbOFZdVc9VPWtptSi63+0L5hz9QofYRgZeNliCkuxa3w9/uP65v/7sBSI1FaCDqwqnRsoEGcqZp34+G5RUzthHGVhiLmfZmm4y8eRaCnxGXeNcrCFMpNcPtGGDlCrwk0S2Fm6+ilHmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZKRDowjd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57T6DupE63103326, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756448036; bh=hstyvumzzCjG4S+yphhApmnJhxe0KVfcsJT8jNHQ1kw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZKRDowjdKP5WLRpPlKG3C2m4i3flv5UoD0aKYp9Wtl5+8QPNkU42pHvM/sVGPPwn3
	 YkGF5H4e6L/n6e6v9DXOx8qON/4Rp+BhGXJs9JRb8vTG/i0VFRrizgVew6RckXzZn8
	 i4n7nsr8g4tijTztytzdWgI06InYGsLJ8CoNYwyQeRy1EJ4ul6g0eAP0XCHXHbokJI
	 TlhKtvHh2OLMTrv9FcJUOCvW/hs8Fsh1JbVM+jDcx2ZWbQLY9yajCN8O3ngrVuo9Z9
	 3guiHTNxA3pyKrLVZYdOFmzzesbe1BirXEuRmyiCv85UM/r3tqxPvYX1b+str547Ft
	 fRDEhS5knek9w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57T6DupE63103326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 14:13:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 14:13:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 29 Aug 2025 14:13:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 02/11] wifi: rtw89: usb: Move bulk out map to new struct rtw89_usb_info
Thread-Topic: [PATCH rtw-next v3 02/11] wifi: rtw89: usb: Move bulk out map to
 new struct rtw89_usb_info
Thread-Index: AQHcF3KTF4AHkUd3QUCZ8laIJzf057R5KQNw
Date: Fri, 29 Aug 2025 06:13:50 +0000
Message-ID: <25b90dfaed7a4a9d931b02c06b7681f2@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
 <9e4a9bca-1ec0-441b-9743-0759b6bda26e@gmail.com>
In-Reply-To: <9e4a9bca-1ec0-441b-9743-0759b6bda26e@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
ODUyQVUsIFJUTDg4NTJDVSwgYW5kIFJUTDg5MjJBVSB3aWxsIG5lZWQgYSBkaWZmZXJlbnQgVFgg
Y2hhbm5lbA0KPiB0byBidWxrIG91dCBlbmRwb2ludCBtYXBwaW5nLCBzbyBjcmVhdGUgYSBuZXcg
c3RydWN0IHJ0dzg5X3VzYl9pbmZvDQo+IGFuZCBtb3ZlIHRoZSBtYXBwaW5nIHRoZXJlLiBJbml0
aWFsaXNlIGl0IGluIGVhY2ggY2hpcCdzIGRyaXZlci4NCj4gDQo+IFN0cnVjdCBydHc4OV91c2Jf
aW5mbyB3aWxsIGFsc28gaG9sZCBzb21lIHJlZ2lzdGVycyB3aGljaCBhcmUgbG9jYXRlZA0KPiBh
dCBkaWZmZXJlbnQgb2Zmc2V0cyBpbiBSVEw4ODUyQ1UgY29tcGFyZWQgdG8gdGhlIG90aGVyIHdp
ZmkgNiBjaGlwcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4
MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVh
bHRlay5jb20+DQoNCg0K

