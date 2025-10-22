Return-Path: <linux-wireless+bounces-28170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9A1BFAFF1
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 10:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C816A5648A6
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20608307482;
	Wed, 22 Oct 2025 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UB9kvIi2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A8266584;
	Wed, 22 Oct 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123317; cv=none; b=NyOC46VRx63gdRzjP7PoLdYUQHGMA0XgjS1Cu4AaAPdF99wQTN0EOEKmQ0OrYJB8DvNd+4drI8Avtea7wqrlYoKxmDLlGxtV/yvFAvP7swFxEE+FPipazWvCHZR0cPaXZgWU/hcEJTXZV+n64vzp6c7UPw4KFk9iXTrQ4YFWCPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123317; c=relaxed/simple;
	bh=ozyC0ygxJ42N93avxV/rH2GMQjZoBEuol+LMBQ94Uas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=noE8hqlasjqcH+5KdvenSjCqwxABKXFZGQWORf15dsmGdY4U5uBPdhw0dets2p/+YqWZqcaN7Lf4PteL9Y92kNwgfzQAXHbqaUHbZs+J/CyV1YB/48b0wuGy/rYslgKy3LsevGgst5QBofOd2koZe0/MOpJWMb70voxrxxB1DtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UB9kvIi2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59M8seuvF360758, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761123281; bh=bWx2M9wpDVpkM4yWZWdCxiRy4DozE9xy5F2FyAkN610=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=UB9kvIi2wewZxZYHhYW0JmLORc7wbQl+aL0WDdCvbLuiSh7woD5eMMcJM9Cuwz/py
	 RjV8r4IPTrrFEHK+dUmP38LbXO8tQDjLzmSOq1g5Adj2HyCBF6cqsGOLiWeKTYSUKJ
	 01kUgoEU9Pdc++AhSn3IcARpn+wYCapd3WYIJeYcX3veVbN5E3paIjOEFBlwVnZjnf
	 vy3KOXal8faxu6CG+oSieD0zWDBfly27lk6Rq+qTPv5RXDQFcsPkKNRDxCg9LH33N8
	 E804WTtD8fZxTzEpeGIGVcHpN46Vc0swHQo6h7lXYxiyD/6utI8EPv8G6kUNS1Lt1b
	 +JTlGAKIZCl+Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59M8seuvF360758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 16:54:41 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 22 Oct 2025 16:54:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 22 Oct 2025 16:54:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 22 Oct 2025 16:54:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v3 8/9] wifi: rtw89: provide TX reports for management frames
Thread-Topic: [PATCH rtw-next v3 8/9] wifi: rtw89: provide TX reports for
 management frames
Thread-Index: AQHcP04MOLWRdkAwuUmNSMnYYSuZ/7TN5D9w
Date: Wed, 22 Oct 2025 08:54:39 +0000
Message-ID: <92b8ee77b6b8422bb43e68110034150d@realtek.com>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
 <20251017100658.66581-9-pchelkin@ispras.ru>
In-Reply-To: <20251017100658.66581-9-pchelkin@ispras.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> In order to provide TX reports for the management queue rtw89 should
> configure the firmware.  Do this with SET_CMC_TBL_MGQ_RPT_EN() for the
> WiFi6 chips and with CCTLINFO_G7_W0_MGQ_RPT_EN flag for the WiFi7 ones.
>=20
> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


