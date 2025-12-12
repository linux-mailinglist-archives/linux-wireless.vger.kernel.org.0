Return-Path: <linux-wireless+bounces-29682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 986E0CB771A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 01:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5107D3016CDF
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 00:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4116719F40A;
	Fri, 12 Dec 2025 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FieuoSaq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0984C98;
	Fri, 12 Dec 2025 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765498887; cv=none; b=iwhTRBMzNsLNBZsMnclZ6SdtLeBaM8EF7DdVNNnEE8VFhdN5mo4XqDnaS+yFPihI+fnbpaDVUSgMEPzw8YjaYKcXheW4JjFZjH6Db8Kt9+KT3RwmVuHl/D1grK0Cin9s9EJRsr1DpU+UMDZkOFXmgoRzv6HBfxzISH/EQ0upY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765498887; c=relaxed/simple;
	bh=2gq99nBqGxcwG0Qq2DxzVRP3g99l9veTSGsxe/+TzDE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BjfG1BdlV5wuJ4+8BDbsy/iphLdskTQwiUIk2UCgUNGBVLVzvA61HpI5hrfWf4Dk44XooUzwJaRSnAlCrls5MtvFIrSK4sUr63GVF424tprEE1WVMwo8XMNwniVs+QIe4qxNmPmpnyqogK2a2gngDTViJVEYJADrQtN17nWLfSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FieuoSaq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC0LEJi83205610, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765498874; bh=2gq99nBqGxcwG0Qq2DxzVRP3g99l9veTSGsxe/+TzDE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FieuoSaqgFF7i8vIZHWM7nbk2DkNUEshOEoPuGW2GzGqgBlbOk9TZ5EZerIejgW8Q
	 3R+6NNMz6Lce3wckMEgaaePdhs50jC9Xg3pzDRutMXmpkkg2Oc1OkBYUnNf2ENuk/K
	 DSIcC/HzEXwQXDvZ5tseqoF424YPm4N+WNAFp/Er3qGRPlitObgQXvI0PqlQTSlsyS
	 rHmH/aHAFPulMTDUYnzftZHFDHNUeYOFQjAsL+auiwWYO0qO5Q9er36X4Dwtt5eos/
	 UP8AAiJzR3ijb41rpE38qu6mrKqenqcayAXKh1j4NglRN+iGIIyqZV8cQr4124sECK
	 RWIbi9d1zCxYA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC0LEJi83205610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 08:21:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 08:21:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Fri, 12 Dec 2025 08:21:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: syzbot <syzbot+392a2c3f461094707435@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] [wireless?] WARNING in __alloc_workqueue
Thread-Topic: [syzbot] [wireless?] WARNING in __alloc_workqueue
Thread-Index: AQHcaqPZKxyGNv7J40GXeV1L2G5CH7UdJAHQ
Date: Fri, 12 Dec 2025 00:21:14 +0000
Message-ID: <a18557c761d047d7bc4950c3c18d4b85@realtek.com>
References: <693aca04.050a0220.4004e.0346.GAE@google.com>
In-Reply-To: <693aca04.050a0220.4004e.0346.GAE@google.com>
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

PiBXQVJOSU5HOiBrZXJuZWwvd29ya3F1ZXVlLmM6NTcwMSBhdCBfX2FsbG9jX3dvcmtxdWV1ZSsw
eDExNGMvMHgxODEwIGtlcm5lbC93b3JrcXVldWUuYzo1NzAxLCBDUFUjMDoNCg0KVGhpcyBwcm9i
bGVtIHdhcyBhZGRyZXNzZWQgYnkgQml0dGVyYmx1ZSBTbWl0aCBbMV0uDQoNClsxXSBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvcGF0Y2gvZDU3ZWZl
NDgtYjhmZi00YmYxLTk0MmMtN2U4MDg1MzVlZGE2QGdtYWlsLmNvbS8NCg0K

