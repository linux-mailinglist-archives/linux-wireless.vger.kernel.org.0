Return-Path: <linux-wireless+bounces-11458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB8952969
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE7D1C21F83
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B773176FA2;
	Thu, 15 Aug 2024 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="l4GBbd+i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA4176FAE
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703642; cv=none; b=PmPszBfaHcx/FfeJDxZ+GH8P773LxNvGQoXEWqxAByPpjj7QMm4GjzySN7Of3ZVNCUJBqBWuOOkietT8g8GXFypTZUCat5MjFYXGAZfPXm+S4Ojy5ue1O8JhLeguCSR6pu2UMBiY9kuvOoYRyciVwbz8x/NlcZ5rSuqgLtNl+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703642; c=relaxed/simple;
	bh=e5MPBxBS45oVJBCu88wNcunzUALY+6pJkj8bpQgp0og=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oqV7o+OwV6EtUmjtjj1QAx9PNOENAS6uqMH3Plh0lEzksBTx6Z9a/hOeaenu0SeDRDxhJphvksAINlTEFRz6uacgYClFh6olHWQ5Rupe9pWmtb+gzyOxKbRqwuE0ehPZxHLYQ8edmVSYUc3gO8NfJORtqAnQJPAWcpsxpGKFDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=l4GBbd+i; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F6XuCV23701976, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723703636; bh=e5MPBxBS45oVJBCu88wNcunzUALY+6pJkj8bpQgp0og=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=l4GBbd+iYli84qRU5QcQff8qhZvwdVvyRKj9rU79pp166twEwaUEN3lEt0FyOkQ6f
	 h1WZS9huJu7IJfK572zuRnX+1Wq5wuxlCdo2gRVb0Q2Ne/We/g1URPPqYH0iM7m6Zt
	 q4SeEpkG4in5Imk47LSzt37gZMo8rEhy64x7L8pqCtbHUcJh0f1PwKPuPNKVBVIEdC
	 foTNJK0oWy9u3eQOz9tEd/8af67CPNn6e59pYr91v5M8rxNJWiISDVCA7ZciAtNp7O
	 pwN0wwtH161CkuzMBIH1P1LJKaljk7YTlz3+p8unT4y1GKJq4ey+gvbP+hDDpxSCQi
	 w9/PEPWgbPhiA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F6XuCV23701976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 14:33:56 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 14:33:56 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 14:33:56 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 14:33:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 05/20] wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be NULL
Thread-Topic: [PATCH 05/20] wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to
 be NULL
Thread-Index: AQHa7DEJqrku59fojk68ID9tSyQ5d7In4PoA
Date: Thu, 15 Aug 2024 06:33:56 +0000
Message-ID: <eb32692b42db48d2a05bd4feac9a814c@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <6d4194e2-8c8c-4d37-9b44-aada8d1d519f@gmail.com>
In-Reply-To: <6d4194e2-8c8c-4d37-9b44-aada8d1d519f@gmail.com>
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
ODIxQSBkb2Vzbid0IGhhdmUgdGhpcy4gVHJ5aW5nIHRvIHVzZSBpdCByZXN1bHRzIGluIGVycm9y
IG1lc3NhZ2VzLA0KPiBzbyBkb24ndCB0cnkgaWYgbHRlY29leF9hZGRyIGlzIE5VTEwuDQoNCklu
IHNob3J0IHRlcm0sIGl0IGlzIGZpbmUgdG8gYXZvaWQgdGhlc2UgbWVzc2FnZXMsIGJ1dCB3ZSBu
ZWVkIEJULWNvZXhpc3RlbmNlDQpmb3IgUlRMODgyMUEgaWYgd2Ugd2FudCBiZXR0ZXIgdXNlciBl
eHBlcmllbmNlIHdpdGggQlQuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21p
dGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNo
aWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

