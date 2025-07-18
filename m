Return-Path: <linux-wireless+bounces-25638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEC8B09B77
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B217BA2B7
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 06:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2465919F40A;
	Fri, 18 Jul 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="v/MuHvRh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04919E97C
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820535; cv=none; b=ikBNEuAx4IYwcAVoNUrSRQcXRvle8hBN8F818BnGjthr6GemY7EYKIL5QGcUSk0myascN1gwWbxxj+lYP5N7gW8v1497vTnf/ns9tx3l56LxaRGc3WlG6g5qSXXjvxdIHMxyP51TM6shgliIjApNwx8vnl6bDJjB8jjaQp+JxxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820535; c=relaxed/simple;
	bh=9pQGG5tmxr8ATFmyyPt0Gkft5YsUVtJu3dR0Ru4umrg=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=YLNPP5J581vuSW8W56lYiGZwZZmXEVUxGcB0lW/98wzce5OejNFXLEaXalbC4TQ8QcYWj2fMH+BfYn0vK2a5pm3xdII7hgKmg3rcMZs/cnIRfQYXRZoRO8CUm0UDQUww2eW4ymGi0fFZt1q0fdfTqT1IrDOQLu/36vL1verwm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=v/MuHvRh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56I6ZRoO41147776, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752820527; bh=9pQGG5tmxr8ATFmyyPt0Gkft5YsUVtJu3dR0Ru4umrg=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Message-ID:Date;
	b=v/MuHvRhvH2tWcgcIrz4FalEbAuerrEiE8fTD0s4MVc8Yrj4BCXSKj8U1b0Xuaxcq
	 vO9mbSalc41rr8mMb3D5LcKUeXvxWRmOW962czthadwjP1xQZgHu5x3Rh6JM/3OgZu
	 BDMP0bmLNTdeYaL5CSgZLYYNLC7lQdQFElFwCeh4trvtAeSriU4Wpvjb8pUzOGRdIb
	 naAKgvkQXA0Ou+LfD7SYLHWXVBFnC3CBP0A5CNnRVgYCa5jmguyAX7YCvUK2bOAxbh
	 znZa6achmwpHJq8IQAodUOZZk2yL3eeJhV79MC4lGAy5pu2p/9Hu/rvROaLOqM5ygS
	 wJlKe2zj4XpGA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56I6ZRoO41147776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 14:35:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 14:35:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 18 Jul
 2025 14:35:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v2 1/2] wifi: rtw89: Lower the timeout in rtw89_fw_read_c2h_reg() for USB
In-Reply-To: <09313da6-c865-4e91-b758-4cb38a878796@gmail.com>
References: <09313da6-c865-4e91-b758-4cb38a878796@gmail.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Message-ID: <6a03b8fb-fab7-4990-8bc5-8f6beb626b45@RTEXMBS04.realtek.com.tw>
Date: Fri, 18 Jul 2025 14:35:26 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOgoKPiBUaGlz
IHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYygpIHdpdGggYSBkZWxheSBvZiAxIMK1cyBhbmQgYSB0
aW1lb3V0IG9mCj4gMTAwMDAwMCDCtXMgY2FuIHRha2UgfjI1MCBzZWNvbmRzIGluIHRoZSB3b3Jz
dCBjYXNlIGJlY2F1c2Ugc2VuZGluZyBhCj4gVVNCIGNvbnRyb2wgbWVzc2FnZSB0YWtlcyB+MjUw
IMK1cy4KPiAKPiBMb3dlciB0aGUgdGltZW91dCB0byA0MDAwIGZvciBVU0IgaW4gb3JkZXIgdG8g
cmVkdWNlIHRoZSBtYXhpbXVtIHBvbGxpbmcKPiB0aW1lIHRvIH4xIHNlY29uZC4KPiAKPiBUaGlz
IHByb2JsZW0gd2FzIG9ic2VydmVkIHdpdGggUlRMODg1MUJVIHdoaWxlIHN1c3BlbmRpbmcgdG8g
UkFNIHdpdGgKPiBXT1dMQU4gZW5hYmxlZC4gVGhlIGNvbXB1dGVyIHNhdCBmb3IgNCBtaW51dGVz
IHdpdGggYSBibGFjayBzY3JlZW4KPiBiZWZvcmUgc3VzcGVuZGluZy4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4KCjIgcGF0Y2go
ZXMpIGFwcGxpZWQgdG8gcnR3LW5leHQgYnJhbmNoIG9mIHJ0dy5naXQsIHRoYW5rcy4KCjY3MWJl
NDZhZmQxZiB3aWZpOiBydHc4OTogTG93ZXIgdGhlIHRpbWVvdXQgaW4gcnR3ODlfZndfcmVhZF9j
MmhfcmVnKCkgZm9yIFVTQgoxMjMyMmEwMjYwMzAgd2lmaTogcnR3ODk6IExvd2VyIHRoZSB0aW1l
b3V0IGluIHJ0dzg5X2Z3ZGxfY2hlY2tfcGF0aF9yZWFkeV9heCgpIGZvciBVU0IKCi0tLQpodHRw
czovL2dpdGh1Yi5jb20vcGtzaGloL3J0dy5naXQKCg==

