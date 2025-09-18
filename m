Return-Path: <linux-wireless+bounces-27461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51307B830BB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE263288EF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 05:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3538F2BEC3F;
	Thu, 18 Sep 2025 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KmG/TAF9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3C19E99F;
	Thu, 18 Sep 2025 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174560; cv=none; b=qZ5OGFttv9EC91lFKh5LlfHynwkSZkWUQpRItNLiJ4TkE1Os2FeVLGQGSxgadJpEKErtaSX45hnNu4jLoBNFEY95K/B08y0BYv3Ypojp8ycCN+p2VYRz/VwZ1ZlRhE0gzjWp7BMelDtiC1rY1Pyfib8QrqhBIavEkTLgnE7ZVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174560; c=relaxed/simple;
	bh=CpnptQoyMBtm75U+XafLiLKBLd6jtLQfkxqbRfgYq60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RRJakroo57wv5Ohwdy2TCYHBrUIGQ9479LqI4WSO9bK9dQCfH7oDdIJxR+uaGfqcAg7uiqk7BDd0YquOALsr/FskdblxqonI8e6D0Sahh/O3v5vW6caRUoZQawR0loQhp8VaUmpycmzAcnu0h4MaCwfOuCCUNA2CgmN2IiGGWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KmG/TAF9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58I5mxpeF1494925, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758174540; bh=CXgxFBXF2ELk6MKI7Y+a+/rEvgte1u4Gl++7x8Rf/jU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KmG/TAF9URx0CUzyvPLk+04jXjRWeDeP58SrIQ39guL0XLfPClLmrFf3dNVmF7N55
	 hhf6OHrtmQTZSJ/2jtwF56EIp4mApu364EMIPnfd12Yd7dQHmXF1Mw5hkasu4ns/KR
	 LkT34hQA11lP4GyNZzsP8UGMjZjq4qsKJ/yAUR48E/Hmb9Jl3UxdZ7gTs3Ps45TyUo
	 QqQ2qD6Hzp6BLsgcrvnbFj20OVBwBCRLm1pNV+yt3Zvorv1piJOP4oSxP7CWKrNr7A
	 CkYUTvRjlLOa6ZwTd8+KZ0O0iDPVF51WJcB5DRe+AdfbKbDo9sm4jSXNVlTgeO2Vdh
	 FWugi+b2bcrIw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58I5mxpeF1494925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:49:00 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 18 Sep 2025 13:48:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Sep 2025 13:48:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 18 Sep 2025 13:48:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw v4 3/4] wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
Thread-Topic: [PATCH rtw v4 3/4] wifi: rtw89: fix leak in
 rtw89_core_send_nullfunc()
Thread-Index: AQHcJ7kEELe6Pe9ASkmQD+KIePxcPbSYcE9w
Date: Thu, 18 Sep 2025 05:48:58 +0000
Message-ID: <d7305c1e34ea4889869d27b43273d5c6@realtek.com>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-4-pchelkin@ispras.ru>
In-Reply-To: <20250917095302.2908617-4-pchelkin@ispras.ru>
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
> If there is no rtwsta_link found in rtw89_core_send_nullfunc(), allocated
> skb is leaked.  Free it on the error handling path.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: a8ba4acab7db ("wifi: rtw89: send nullfunc based on the given link"=
)
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


