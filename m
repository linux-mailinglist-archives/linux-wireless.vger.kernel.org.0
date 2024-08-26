Return-Path: <linux-wireless+bounces-11958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870495ECDA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23CE280E33
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AA913A88D;
	Mon, 26 Aug 2024 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MSRrRMOr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE758172A
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663760; cv=none; b=C4Q7dvwnyuLFqL8xId4NfSh9KVguZXyBW//23vTxC91KmEnpwux/6kBvoaQ9DHyOBOAoSCRy8vvW8byXgjSIVWbpAsxD8LxRNC7CYnVwZO7Rzm8U2joBfVwUASBa+oNRcMd6nBoEMgztRnDqW03F2A1Ie4aktyJayQ6kvvVy62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663760; c=relaxed/simple;
	bh=aGnEOPyTMJ53HZRp+PKrxy6tGI+Yrk+UCCHo8Tzocqk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Cg2VoUVFg6B/+DU7IRaogDZv9Ct2PdJuhJZFMJpMafSbcvRzzJ/9MSzFnWNshWuOiGZhJLGOkL3WWZzuRZwYYIM9qgsS1JqKvr1Hstt83gvulJaZ76+wYT+CzZH7pdkf4FgrcdIdOXRokqYMLEnz3exu/8hGS6p9TegkqL/97Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MSRrRMOr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47Q9FnZ023835024, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724663749; bh=aGnEOPyTMJ53HZRp+PKrxy6tGI+Yrk+UCCHo8Tzocqk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version;
	b=MSRrRMOr07cis+zdzpMIif0jvxtRVReebWuOnoxIN5CQLIHLnfa06cfnEkBY9blfE
	 KbFkOSGq6XXyihQ0tdS132vOKY8NGEaFjxTYEYXs7O5lS3ybzp7PSp+E2lMllFQXFD
	 zFZY3rx1Tih2lWMSBrlKez42qycAPDlpfWGXN0QwVGOyuG1G1XuZYd+Vf2cl+rBbHg
	 z7D70zBZGO1ShSjkGv/uCR0nuoFbCJEL609luQ6EPUDVSqZoyIwZeLJUNfXC6NwAZi
	 1rRrjAjWu8TeLVkgcTTIYkLgB/C2dZAb6L4nXoVJGnLYRT1HWVmI3uStg5iPzHX+8f
	 4d6IwWXM8XeZg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47Q9FnZ023835024
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 17:15:49 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 17:15:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Aug 2024 17:15:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 26 Aug 2024 17:15:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee
	<timlee@realtek.com>
Subject: pull request: rtw89: 8922a: add fw format-1 v0.35.41.0
Thread-Topic: pull request: rtw89: 8922a: add fw format-1 v0.35.41.0
Thread-Index: AQHa95iKKucNNGeuZkaQj3P1dSVrJw==
Date: Mon, 26 Aug 2024 09:15:49 +0000
Message-ID: <f5079de6ec52bbd97fd0deaf2df58f8b13e364b7.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF9470385B7A8646902366DC144292F6@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksDQoNCkFkZCBmaXJtd2FyZSB2MC4zNS40MS4wIG9mIHJ0dzg5IGRyaXZlciBmb3IgODkyMkEu
DQoNClRoYW5rIHlvdQ0KUGluZy1LZQ0KDQotLS0NClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5j
ZSBjb21taXQgMmNkYzExYTdiM2JmMDYwNDJmMWZiMTc5ZmExNzc1ZmRlMzgxNDkxZjoNCg0KICBN
ZXJnZSBicmFuY2ggJ210NzkyNScgaW50byAnbWFpbicgKDIwMjQtMDgtMjMgMTE6MzE6MDkgKzAw
MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHBz
Oi8vZ2l0aHViLmNvbS9wa3NoaWgvbGludXgtZmlybXdhcmUuZ2l0IHRhZ3MvcnR3LWZ3LTIwMjQt
MDgtMjYNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDgwZmEzM2I5NGE5MWExZTQ1
NjcxZThmY2Q4ZTgwYjllZmVkNDc4MzQ6DQoNCiAgcnR3ODk6IDg5MjJhOiBhZGQgZncgZm9ybWF0
LTEgdjAuMzUuNDEuMCAoMjAyNC0wOC0yNiAxNzowODowMCArMDgwMCkNCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQ2hp
bi1ZZW4gTGVlICgxKToNCiAgICAgIHJ0dzg5OiA4OTIyYTogYWRkIGZ3IGZvcm1hdC0xIHYwLjM1
LjQxLjANCg0KIFdIRU5DRSAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBydHc4OS9ydHc4OTIy
YV9mdy0xLmJpbiB8IEJpbiAwIC0+IDE1ODM0MzQgYnl0ZXMNCiAyIGZpbGVzIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHJ0dzg5L3J0dzg5MjJhX2Z3LTEuYmlu
DQoNCg==

