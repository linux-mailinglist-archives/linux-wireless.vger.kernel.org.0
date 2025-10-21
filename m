Return-Path: <linux-wireless+bounces-28123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8CABF4AB7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 07:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7D1D4E3978
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 05:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148C725A355;
	Tue, 21 Oct 2025 05:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JaKXyPMY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D91C84C0;
	Tue, 21 Oct 2025 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761026085; cv=none; b=k2YxlefFocYmeDSItAUJlprBcmZ79PX3N06nekr350pZWdj+lUL8KY02cBQ1WxSMUMa8MgABfthYajSdozIc9bl6WxTt7XIB66TbfdZtHQyA7fZQwcVRaYJVlzY+VgtsP39VadnbjFh1NUcuJ/mbW8X9ca5i6VwVFHVrZkiN5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761026085; c=relaxed/simple;
	bh=k/PzmNmfi4aweybsn7bH32j4ovc1Z9YhXxj51D9pzLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=th0QDAWH2ix3tIW8Dy+qWjO5x+Gl+CBhAinuAZFM1i6S2eKgCpT3w/xbRHOmbasAJUamt1msTqtBVzazx4wY2kJfqm+NQAGpTVb9qKTFNtOIMClmbk3ODE1k2AIlDKgE1BACSIYxLgpSJJOFpayt/r82AaBVwYusgm1ZxmzwXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JaKXyPMY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59L5sbNsB2503619, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761026077; bh=k/PzmNmfi4aweybsn7bH32j4ovc1Z9YhXxj51D9pzLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JaKXyPMYGGLTzyjopGhiLJM+UEHElzrxDi0yjI3GG9xLYIKln1cVHa/yWAD7KxaaX
	 pSpYw0HsT2fjv4/FAWQMlcoPY69T3cvWa+0kbsLI1LlS73VnJiTe/9Vj7UGvEbFrm9
	 UpoafVX2th/s+XNxqGyblQ/C+1OR1dIbif3EiuMeC7EOR6A7vEUYbs07+DctFsf5C9
	 e3EVfGrD8+dc6SJbZw6TLsrYVHCjY/cwNay6G8RpYOzYNCI3sLxbVOO39Lln6pxXIv
	 ZVVjHcyzDSg0GWHxnsyzabMRqMdgxBlhub0XVqrfNkKOvolifYOrvgr9OdPNtEEKhy
	 ZmCX8pmA9q6zA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59L5sbNsB2503619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 13:54:37 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 13:54:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 13:54:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 21 Oct 2025 13:54:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yu-Chun Lin <eleanor15x@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
        "visitorckw@gmail.com"
	<visitorckw@gmail.com>,
        =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?=
	<stanley_chang@realtek.com>,
        =?big5?B?Q1lfSHVhbmdbtsDgsq7LXQ==?=
	<cy.huang@realtek.com>
Subject: RE: [PATCH rtw-next v2] wifi: rtw89: Replace hardcoded strings with helper functions
Thread-Topic: [PATCH rtw-next v2] wifi: rtw89: Replace hardcoded strings with
 helper functions
Thread-Index: AQHcMZ3/mdEYn0w0EUij6sEji8MiZbTMOcUw
Date: Tue, 21 Oct 2025 05:54:37 +0000
Message-ID: <21c8692ca9364e498852622e833cc708@realtek.com>
References: <20250930000545.2192692-1-eleanor15x@gmail.com>
In-Reply-To: <20250930000545.2192692-1-eleanor15x@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

WXUtQ2h1biBMaW4gPGVsZWFub3IxNXhAZ21haWwuY29tPiB3cm90ZToNCg0KPiBSZXBsYWNlIGhh
cmRjb2RlZCBzdHJpbmdzIHdpdGggJ3N0cl9vbl9vZmYoKScsICdzdHJfZW5hYmxlX2Rpc2FibGUo
KScsDQo+IGFuZCAnc3RyX3JlYWRfd3JpdGUoKScuDQo+DQo+IFRoZSBjaGFuZ2UgaW1wcm92ZXMg
cmVhZGFiaWxpdHkuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFl1LUNodW4gTGluIDxlbGVhbm9yMTV4
QGdtYWlsLmNvbT4NCj4gQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29t
Pg0KDQoxIHBhdGNoKGVzKSBhcHBsaWVkIHRvIHJ0dy1uZXh0IGJyYW5jaCBvZiBydHcuZ2l0LCB0
aGFua3MuDQoNCjhiNzk1ZmU0MjkyNyB3aWZpOiBydHc4OTogUmVwbGFjZSBoYXJkY29kZWQgc3Ry
aW5ncyB3aXRoIGhlbHBlciBmdW5jdGlvbnMNCg0KLS0tDQpodHRwczovL2dpdGh1Yi5jb20vcGtz
aGloL3J0dy5naXQNCg==

