Return-Path: <linux-wireless+bounces-22883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7262AB49BE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 04:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7868C16FA30
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6841E51D;
	Tue, 13 May 2025 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="s2jQS9ld"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366724C6C
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104679; cv=none; b=SEiGJq82KCQjjoTh+2/opKGEP1lEgjiEXj3+I3uiaifP6+Ax4yN0HGyPQdITEnrXh9g8zBloKOsxLJxPxdBvmTn0Qptx5j4d93uAcnhm9Dx+wMg5WKO7eaDsrXsMaBpU5UYNO3RgRXGXv2uwKco9LaPqqXgscTbIgubptpDLYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104679; c=relaxed/simple;
	bh=QS2WhQirkrCdqUJ9EL3JmhsCNemLcN1PDwMH3vUXtOs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fsbP4MkEfH84zDEFXlt+ZQCuW5uVj0YnE8xQ29d8Gb4jLkfuS5y8aREqs2xpdBNc0+o1fAvTcHOPkNRtjVMruvd6cqbC/uwdsIDkhM9KVdZI9+b6vma70BNggWNitOvOJrmFNj05YjBCFEH5jsjMTQrXqsio18D4T9NLrTCVS+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=s2jQS9ld; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D2pB1i93554887, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747104671; bh=QS2WhQirkrCdqUJ9EL3JmhsCNemLcN1PDwMH3vUXtOs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=s2jQS9ldyHLnaF2yFLoPUj1e2WJGHarQ0Z3YoSc2sjsXyk5dD2IgejUMVb+AxyS9O
	 G0+dYcmLJGZu2sdh+6BCYXtq8AgtqoE0K124z0rzPDSM4dS3yNcyT4m8s2jqSPKb7H
	 K/tRqY0b6RPNy7F/YVDHLj6XXQBwtyjvHKo3m+/6AEMenuiGg27obXLOD10MhI56IO
	 57iD3ipBXAObMolcnG4E87zft+54gbc+zcS5/CDlgzi2U7w3uLd07oBzfS3zQ2IGwQ
	 V6PFQnMQRyrN6VbqMGrRnrJSerr74sf4jKlCyqHaAzF77TdItfAn9uCwHhqb7gglI4
	 eO16W7EKy+v+g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D2pB1i93554887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 10:51:11 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 10:51:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 10:51:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 10:51:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 02/13] wifi: rtw89: Get dle_mem via rtw89_hci_dle_mem()
Thread-Topic: [PATCH rtw-next v1 02/13] wifi: rtw89: Get dle_mem via
 rtw89_hci_dle_mem()
Thread-Index: AQHbvTYOjUg1tNmko0OMin8tnDz9BrPP6Tfg
Date: Tue, 13 May 2025 02:51:10 +0000
Message-ID: <313e7c27384445bcade5ebe5c2f381de@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <594d5987-5e6d-405c-b482-d101b43cb65c@gmail.com>
In-Reply-To: <594d5987-5e6d-405c-b482-d101b43cb65c@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBEb24n
dCBhY2Nlc3MgZGxlX21lbSBpbiBnZXRfZGxlX21lbV9jZmcoKSBkaXJlY3RseS4gVVNCIDIsIFVT
QiAzLCBhbmQNCj4gU0RJTyB3aWxsIG5lZWQgZGlmZmVyZW50IHNldHMgb2YgdmFsdWVzLg0KPiAN
Cj4gUmVuYW1lIGRsZV9tZW0gaW4gc3RydWN0IHJ0dzg5X2NoaXBfaW5mbyB0byBkbGVfbWVtX3Bj
aWUgYW5kIGdldCBpdA0KPiB2aWEgcnR3ODlfaGNpX2RsZV9tZW0oKSBhbmQgcnR3ODlfcGNpX29w
c19kbGVfbWVtKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4
ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPg0KDQoNCg0K

