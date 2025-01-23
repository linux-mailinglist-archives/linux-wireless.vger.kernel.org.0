Return-Path: <linux-wireless+bounces-17845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F94A19BCC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 01:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487FE188AC8E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 00:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF9F5258;
	Thu, 23 Jan 2025 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="L94Dj0Bt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C3629
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737592344; cv=none; b=ZFP0RKcfy4hHz24y+gdCoyG/p2KRa0SrGHWRtvE7afjTOI8Tj7EjLv2yIMIYky7I913OVRa7gfHfKwLqJkdaaZD6bG/aXOKQmWb+W5O6pbUXiIlKPw7ns1eibWrByFvygg22pDCb93coP3Id6TO2Et1jXpRyr3nSWs+jbHLAFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737592344; c=relaxed/simple;
	bh=9aBZVrI5hqP27LWp6g6VpQ6dy6Q3aMOlkW42lzimsvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S/KfhB6fnvNEDJ6yvrtXDEP6ArWOjJDUDDBnEKVb2UL+XmcOZOFU5OqgoUvWfJOpy6QffJY/9SmIIP2AFTRmONbgntMi/MhpFbJVum2oihA2fILWR7kTgn171VN7eOXjBtvZCBu13I6cURxbVrrdOC+6jjMzku5XKw6o6SgD1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=L94Dj0Bt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50N0VlZW23839910, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737592307; bh=9aBZVrI5hqP27LWp6g6VpQ6dy6Q3aMOlkW42lzimsvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=L94Dj0BtqGiBSjGVTYZwvv9ADPQKe0y2uFkYTCUk4Sd3jNBsXCigDzHss5GFCL+Sw
	 JJylHyZisFq9aVIvIbKB6ZLUK6H8woYYjjUrATEQ3FFwpD3tei+nttcIITTFz9H3RB
	 f2RwsY49LR5tIn/vWKNRJ13pNL5om+K05EAcE1BQdBxuBPHO44rsW0SMIZgt+s66TK
	 0lXCFfNH0fAreEYty4LFfgbu7xn45PfMmzJXZ8Ez4aanBs1SrRgyvC9JYOQYdVPyrE
	 DEK28QkZYvSOim23W+8zbKS3GoZ3S8YVmWrOsLWWQwYymn8vAe3Ou9D0aVzZMuW1zg
	 odxtBKbcKc3pA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50N0VlZW23839910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 08:31:47 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 Jan 2025 08:31:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 23 Jan 2025 08:31:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 23 Jan 2025 08:31:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ezra Buehler <ezra@easyb.ch>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Martin Kaistra <martin.kaistra@linutronix.de>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        "Reto
 Schneider" <reto.schneider@husqvarnagroup.com>,
        Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: Enable AP mode for RTL8192CU
 (RTL8188CUS)
Thread-Index: AQHbbJ1xE9KyBjPFvEiofeS+5WzYALMjgWJg
Date: Thu, 23 Jan 2025 00:31:46 +0000
Message-ID: <1da09fe30c7f474eb15c57169e70a87a@realtek.com>
References: <20250122071512.10165-1-ezra@easyb.ch>
In-Reply-To: <20250122071512.10165-1-ezra@easyb.ch>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Ezra Buehler <ezra@easyb.ch> wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
>=20
> This allows the driver to be used in wireless access point mode on the
> AT91SAM9G25-based GARDENA smart Gateway.
>=20
> Unfortunately, the data throughput in AP mode appears to be lower than
> with the vendor driver (or in STA mode). Especially when sending, the
> data rate is significantly lower. My measurements performed with iperf3
> and an Edimax EW-7811Un (VID: 7392, PID: 7811) showed a maximum TX rate
> of about 4 Mbits/sec compared to the ~24 Mbits/sec measured with the
> rtl8192cu driver.

I assume the TX rate should be similar in AP mode and STA mode for the
same driver, but still little difference from real AP, which has more
antenna and better capability to TX/RX.=20

Base on my assumption, I think we can try
1. compare TX rate with/without RF calibration, such as IQK, to ensure
   the calibrations work well in AP mode.=20
2. try fixed TX rate by TX description to check if rate selection problem.

Ping-Ke


