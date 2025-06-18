Return-Path: <linux-wireless+bounces-24231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C15ADE073
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 03:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D85917BD49
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 01:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E599155A25;
	Wed, 18 Jun 2025 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="b19ge4sP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86687F9C1;
	Wed, 18 Jun 2025 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750209021; cv=none; b=R/UY6dZdYgafj6wyBReTBVwGIlVWmWfn4Z77mqmox3U2OWy6m/GUBkrSUZQgodS9rHbWlOIp4YT2SOuDYSrKXBIGOpgEcOjlLG69238G0m4G8I0AotLkEJt9u24DFVs9c5Qe6n1n8MSpr7Y1iZ9VGG5WBbvfTBO4RLv9pKq5Ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750209021; c=relaxed/simple;
	bh=Cw6o99Gvmhp27ZbWfCsnlR86rcOb5E5FSDweUoGXFVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b7yKmSdHRcTN7eFKaeL/ehQyECQZbGLIcR0L1v+bCerrOVNOsjnUQKmJUOpVFRMJyphmqV0BkY0qjC2gEVI0BhEl9GB1DKVROnQAdNlpZVNX8own2o/braSyuyaJLgRHrhPLRt2YH3Q4cO9cjotIZ/rIcrdVQ/fqkQWjuBff65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=b19ge4sP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55I193Db83306740, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750208943; bh=E7L6ZWQ6/sv4GzqkUcB6G0LwFcOvfR17Z2ea74AgKI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=b19ge4sPFRR64nMca62UFYQvvQNT+ICX7Kq02I29OuO7zIED+1ygQM7ClB8A+kg56
	 OJvSkDYVNx2HlinXN6/JjDAqDlD0j492QIpFXpUTNDrphVcjUypJ/bMYfj2Eg59VS/
	 70mYd6XtcXsXQHBmz1VfdyvcPxy2G2csjfdf6hCiq3LADQB2I87Dsa4FZK4H2JBrCH
	 w+QbyD2Ed5MHrcEhuzLOxG20Xqz9CwAgl9bBR/Yb5gbj+Igla7488I1Sgt+oxYIZPf
	 49a2Umczd0SAwHuV5wZCNZywAARfi1C4BdqvQMxEOl0CYJByzbTKrgkLRrDSGUIPBu
	 vTg3z4S4SgJEQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55I193Db83306740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 09:09:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Jun 2025 09:09:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 18 Jun 2025 09:09:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 18 Jun 2025 09:09:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Daniil Dulov <d.dulov@aladdin.ru>
CC: Hin-Tak Leung <hintak.leung@gmail.com>,
        Larry Finger
	<Larry.Finger@lwfinger.net>,
        "John W. Linville" <linville@tuxdriver.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH v2] rtl818x: Kill URBs before clearing tx status queue
Thread-Topic: [PATCH v2] rtl818x: Kill URBs before clearing tx status queue
Thread-Index: AQHb34/NAqhk6rzVnkCG6FF6zvRynrQIF6uQ
Date: Wed, 18 Jun 2025 01:09:09 +0000
Message-ID: <493ace2f47b24c739ae4ab3bea2efa93@realtek.com>
References: <20250617135634.21760-1-d.dulov@aladdin.ru>
In-Reply-To: <20250617135634.21760-1-d.dulov@aladdin.ru>
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

Daniil Dulov <d.dulov@aladdin.ru> wrote:
> In rtl8187_stop() move the call of usb_kill_anchored_urbs() before cleari=
ng
> b_tx_status.queue. This change prevents callbacks from using already free=
d
> skb due to anchor was not killed before freeing such skb.
>=20
>  BUG: kernel NULL pointer dereference, address: 0000000000000080
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.15.0 #8 PREEMPT(volun=
tary)
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/=
2015
>  RIP: 0010:ieee80211_tx_status_irqsafe+0x21/0xc0 [mac80211]
>  Call Trace:
>   <IRQ>
>   rtl8187_tx_cb+0x116/0x150 [rtl8187]
>   __usb_hcd_giveback_urb+0x9d/0x120
>   usb_giveback_urb_bh+0xbb/0x140
>   process_one_work+0x19b/0x3c0
>   bh_worker+0x1a7/0x210
>   tasklet_action+0x10/0x30
>   handle_softirqs+0xf0/0x340
>   __irq_exit_rcu+0xcd/0xf0
>   common_interrupt+0x85/0xa0
>   </IRQ>
>=20
> Tested on RTL8187BvE device.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: c1db52b9d27e ("rtl8187: Use usb anchor facilities to manage urbs")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

The subject prefix should be "wifi: rtl818x: ...".=20
I can fix it. Don't need to resend because of this.=20



