Return-Path: <linux-wireless+bounces-28128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE4BF4C86
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 09:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F753A6A7E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 07:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155031A9F88;
	Tue, 21 Oct 2025 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nsk5U2op"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A226E71B
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029996; cv=none; b=kGHdYwzNvu35KnP9RC5lw5BbMP/wpoyKBN8D9wmNB6QMXd1tKYyuhCm20EzQGyAIXgr3hcH51af7dtsXrinFi5/9o5Boi4B2hV/ITGA5eFAkAE8SQcTKvdj2jggJZX2YJl0Z5Pv7bcIJLcbTBlI1Xk2w5hLtjo8AVyY/yFtflqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029996; c=relaxed/simple;
	bh=44Z8s6tpFVf22OLsL9uvYHnw0bWR6BV+ahRTDEBLywA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t550fYN8ljAer1imWNnY1Do3fGTc61B/y9JLdTFyreqz2DczjciSZXqVXus6X1mhVZ1EsWBjgAptoQMicVQ/Xg4eFu7iRBBk6lihoQxAIgkKG8sa7PTIX85utbxXpVnsvi2T2EYLBr4T8/1tVbZ7wXZHDGTZAEv04uUkBoJJgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nsk5U2op; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59L6xlXhB2616374, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761029987; bh=44Z8s6tpFVf22OLsL9uvYHnw0bWR6BV+ahRTDEBLywA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nsk5U2opXpfIayu4L88szR0kEp2mA16E52hPa7kl8/DkE1FbqCboBCfj2hBD3HEkT
	 X6IUTCjXLUKQmd/7+YCyv4+dlXqbPM8CjrK89ww3EhADK/YHL64EnJfx9m0hW0uddB
	 u/0NKVNG2JzjVhXCTxChvmmx0J0KROZmn4mmidWnJZ3y8ewkJ9oMmZqAy3mEL79+Lh
	 r08NEs0FCNaizr8t8hjKlz88qX/+su0rvTE4MgVEWn6F1HUSFZZfV7UksF4w3FQ9pv
	 UQ2rSM5PyhtYvY851VtNSnZNXWdi/AmuNG7cBPYGQC8C7zwQcvUa8n5DSfrJ19SPcB
	 sDmMuMzSbxfIQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59L6xlXhB2616374
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 14:59:47 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 14:59:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 14:59:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 21 Oct 2025 14:59:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next 1/3] wifi: rtl8xxxu: Report the signal strength only if it's known
Thread-Topic: [PATCH rtw-next 1/3] wifi: rtl8xxxu: Report the signal strength
 only if it's known
Thread-Index: AQHcORM6buwg2Ly2qE2je2TUlB8BgLTMOlbw
Date: Tue, 21 Oct 2025 06:59:47 +0000
Message-ID: <3131e7d494234dfea369bd65903e1b1b@realtek.com>
References: <cdbe1a18-f6f1-4575-bad9-e85db8101247@gmail.com>
In-Reply-To: <cdbe1a18-f6f1-4575-bad9-e85db8101247@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KDQo+IFRo
ZXNlIGNoaXBzIGRvbid0IHJlcG9ydCB0aGUgc2lnbmFsIHN0cmVuZ3RoIGZvciBtYW55IChhbnk/
KSBkYXRhDQo+IGZyYW1lcy4gV2hlbiB0aGUgc2lnbmFsIHN0cmVuZ3RoIGlzIG5vdCBrbm93biwg
c2V0IFJYX0ZMQUdfTk9fU0lHTkFMX1ZBTA0KPiBpbiBvcmRlciB0byBhdm9pZCByZXBvcnRpbmcg
YSBzaWduYWwgc3RyZW5ndGggb2YgMC4NCj4NCj4gVGVzdGVkIHdpdGggUlRMODE5MkZVIGFuZCBS
VEw4MTkyQ1UuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFj
ZXJmZTJAZ21haWwuY29tPg0KPiBSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVh
bHRlay5jb20+DQoNCjMgcGF0Y2goZXMpIGFwcGxpZWQgdG8gcnR3LW5leHQgYnJhbmNoIG9mIHJ0
dy5naXQsIHRoYW5rcy4NCg0KN2FlYjhjMTE4ZWY5IHdpZmk6IHJ0bDh4eHh1OiBSZXBvcnQgdGhl
IHNpZ25hbCBzdHJlbmd0aCBvbmx5IGlmIGl0J3Mga25vd24NCmZiNTE4M2FhNjVmNiB3aWZpOiBy
dGw4eHh4dTogRHVtcCB0aGUgZWZ1c2UgcmlnaHQgYWZ0ZXIgcmVhZGluZyBpdA0KOWI1NjcwMzll
NTQwIHdpZmk6IHJ0bDh4eHh1OiBVc2UgY29ycmVjdCBwb3dlciBvZmYgc2VxdWVuY2UgZm9yIFJU
TDgxOTJDVQ0KDQotLS0NCmh0dHBzOi8vZ2l0aHViLmNvbS9wa3NoaWgvcnR3LmdpdA0K

