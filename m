Return-Path: <linux-wireless+bounces-29111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD491C6C213
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 01:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 198D835EB73
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 00:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D514F9D6;
	Wed, 19 Nov 2025 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="w4UMyA8m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64E1EEA31
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512150; cv=none; b=FYtiG5X04RrzS/wnZk5oasnPGPZA3ZS2EDNWyB2ca64CmX6+AzyLsOClR2z2Il9gqZCw7DivjcIC9wsCGBuNjupdk0iPQxS3OjWCSrvekVocPAmzdpmCeq9H1qyudnfGVlgLltvCKiB+7WzoPXDE+JflWJX7bZDo5fp4oJVhsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512150; c=relaxed/simple;
	bh=1PAp0ig6/SGOdhFkn2ZEHEVFtgh4ACQyuma1UJQPbK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YXrjy+YhDtUFmzpKosujK/gF28aFS5fvUmsy7SH78k5DslrF93YhyGR31Qu2s0VmCW3OxO1eBlvh5ZD8olTzR0r68kjfd7tZ+5/74jzniOw8pQjPohpavXensumRyNFGaBmH7Yy0jbQkJYZio9IUO9hytuRp3qX4OTjhqDVYWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=w4UMyA8m; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AJ0SwAbA2493546, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763512138; bh=1PAp0ig6/SGOdhFkn2ZEHEVFtgh4ACQyuma1UJQPbK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=w4UMyA8mOrm2J96CGYOgX0LaDsL45nCY7NQRNXUhia7YFliVP/PLxq+0LMEPCeOh+
	 wRpPGfNUO22xWGSyOkskuxSaptCnV9GUSuM2qMX/fmN+DtF5yMLdCiKFA13xCiW9kb
	 4Bh5Hc3j+NVFw4YlxDyEbOzH3DgEfhGpsNu9WXHoHaHElVVzw5Jn55rdkeKc8hGDoI
	 b2gEr0w1AJSUEvc7VBJNjxkHCGkzFa4EscWXw3c1rDK9/V1bY6u3F+6nkXDk1KXHgV
	 LEvt/cPv4rV/a48ecWyt+oLS6odpSsbM8ZXG0Td0/Ev/ddoaILHfnxSEplQJhaaFES
	 BZ0K8DqdqtzRg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AJ0SwAbA2493546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 08:28:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 19 Nov 2025 08:28:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 19 Nov 2025 08:28:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 19 Nov 2025 08:28:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next 4/5] wifi: rtl8xxxu: Fix RX channel width
 reported by RTL8192FU
Thread-Topic: [PATCH rtw-next 4/5] wifi: rtl8xxxu: Fix RX channel width
 reported by RTL8192FU
Thread-Index: AQHcVzfjMbkwLSTgKEOo+HgLaiSJBLT3v/NAgAAA6yCAAG2dAIAA+esA
Date: Wed, 19 Nov 2025 00:28:58 +0000
Message-ID: <3612db8e17734f6392571461114b3750@realtek.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
 <afd60ba6-4af8-4944-a915-4e2b814bbed3@gmail.com>
 <988bfe53bd5b42bbb411745f34114db1@realtek.com>
 <cc6f78a75c2746478191e6fe1537412d@realtek.com>
 <6a84df25-b3b5-450c-964a-cceff9544833@gmail.com>
In-Reply-To: <6a84df25-b3b5-450c-964a-cceff9544833@gmail.com>
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

DQpCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IE9u
IDE4LzExLzIwMjUgMDU6MDIsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBIaSBCaXR0ZXJibHVl
LA0KPiA+DQo+ID4+PiArDQo+ID4+PiArICAgICAgIGlmIChyeG1jcyA+IERFU0NfUkFURV8xMU0g
JiYgcnhtY3MgPCBERVNDX1JBVEVfTUNTMCkNCj4gPj4NCj4gPj4gTml0OiB3b3VsZCBpdCBiZSBj
bGVhciB0aGF0ICcgaWYgKHJ4bWNzID49IERFU0NfUkFURV82TSAmJiByeG1jcyA8PSBERVNDX1JB
VEVfNTRNKScgPw0KPiA+Pg0KPiA+DQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgdGhvdWdo
dCBhYm91dCB0aGlzIG5pdC4NCj4gPg0KPiANCj4gWWVzLCB0aGF0J3MgYmV0dGVyLiBOb3cgSSBy
ZW1lbWJlciB0aGlzIGNhbWUgdXAgYmVmb3JlLg0KDQpJJ2xsIHdhaXQgZm9yIHlvdXIgdjIgdGhl
bi4NCg0K

