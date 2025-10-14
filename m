Return-Path: <linux-wireless+bounces-27964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824CCBD7364
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 05:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D320E188C77E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 03:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9D117A30A;
	Tue, 14 Oct 2025 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="emx4ox/m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF4246797
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 03:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760414178; cv=none; b=irz2jSir3Z7CFV4Bz7iebpSZSTQTYAXEXk7e34FppjPPrpnN3nsWORHjd3aqkcZhm/pLBFL1M5ibFsNQFgn2XnlmKqpsbqYU7otQtrzHZV61/xCUPSg5/yGigzc3HRrMecAFhBotd+WePtm9fGNl0K6eTcFEsbC2Cj01D/IV/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760414178; c=relaxed/simple;
	bh=YPIAjHepLHsL62Art2VPpOf0CGAqilRYb2967/KQC1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WHBou99uT/9W0DBwMUqGAidWPx3HXIEJX6yU3KYg2rMwt9c+QHvsw5+ODf036joE5mkwu7/6zyd7J5iL605uTahU3WPuJ7951V54unx2wT5jbgr6RZwIjtlDfNF5YyqSyt4MLa33b+fsThmYbXTUU9729dElEn7Weqm+iJggAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=emx4ox/m; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59E3uAT412664096, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1760414170; bh=YPIAjHepLHsL62Art2VPpOf0CGAqilRYb2967/KQC1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=emx4ox/m2+5XnmyTgHbdZ8fL3lJaYjALs0JFIf/j9PdopYM3MeqYC8lnEM0dOF8Dk
	 qkKvqufTrrCVmBZzyh3XD83q99500nor880V7o5nUFDTDacvoaf0jlGDyD57qWgYl+
	 38CGLEKztDNn4UGgh+ZPAIRLWyC8YkUNACXQESnS9gHZT96guuOIbr0VKUZiYL84kH
	 59ENB0JdaGbB+dgyNaM0A2u+Sv4DxDVm8gN3N4Q4I5UaFKfSAAK4nAfrCE2fp9Wsza
	 egpA7TlQ3L84OaALIIZGC7W5i6PBkbPAb8N/iowRdfFHCo9a54AUhUVhyjZjXBOUHv
	 6x6bkygOWmTBg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59E3uAT412664096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 11:56:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 14 Oct 2025 11:56:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 14 Oct 2025 11:56:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next 2/3] wifi: rtl8xxxu: Dump the efuse right after reading it
Thread-Topic: [PATCH rtw-next 2/3] wifi: rtl8xxxu: Dump the efuse right after
 reading it
Thread-Index: AQHcORNdox6YRVcdDk6ZfOC7O4WFNrTBCq2A
Date: Tue, 14 Oct 2025 03:56:10 +0000
Message-ID: <dd207e59f26842b984302e1162a9b4ad@realtek.com>
References: <cdbe1a18-f6f1-4575-bad9-e85db8101247@gmail.com>
 <1f544dc4-17f6-4401-995d-5cb4567b82fa@gmail.com>
In-Reply-To: <1f544dc4-17f6-4401-995d-5cb4567b82fa@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTb21l
b25lIHJlcG9ydGVkIGEgcHJvYmxlbSB3aXRoIHRoZWlyIFRQLUxpbmsgV043MjJOIChSVEw4MTg4
RVVTKToNCj4gDQo+IHVzYiAxLTE6IFRoaXMgUmVhbHRlayBVU0IgV2lGaSBkb25nbGUgKDB4MjM1
NzoweDAxMGMpIGlzIHVudGVzdGVkIQ0KPiB1c2IgMS0xOiBQbGVhc2UgcmVwb3J0IHJlc3VsdHMg
dG8gSmVzLlNvcmVuc2VuQGdtYWlsLmNvbQ0KPiB1c2IgMS0xOiBGYXRhbCAtIGZhaWxlZCB0byBw
YXJzZSBFRnVzZQ0KPiBydGw4eHh4dTogcHJvYmUgb2YgMS0xOjEuMCBmYWlsZWQgd2l0aCBlcnJv
ciAtMjINCj4gDQo+IFRoaXMgZXJyb3IgY2FuIGhhcHBlbiB3aGVuIHRoZSBmaXJzdCB0d28gYnl0
ZXMgb2YgdGhlIGVmdXNlIGRvbid0IGhhdmUNCj4gdGhlIGV4cGVjdGVkIG1hZ2ljIHZhbHVlIG9m
IDB4ODEyOS4gSW4gYSBzaXR1YXRpb24gbGlrZSB0aGlzIGl0IGNvdWxkDQo+IGJlIHVzZWZ1bCB0
byBzZWUgdGhlIGNvbnRlbnRzIG9mIHRoZSBlZnVzZS4NCj4gDQo+IER1bXAgdGhlIGVmdXNlIHJp
Z2h0IGFmdGVyIHJlYWRpbmcgaXQsIGJlZm9yZSB0cnlpbmcgdG8gcGFyc2UgaXQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo=

