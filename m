Return-Path: <linux-wireless+bounces-28962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DAAC5BC43
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 08:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC91F4EA39C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E532E613C;
	Fri, 14 Nov 2025 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VEhTFa1i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023419F137;
	Fri, 14 Nov 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104814; cv=none; b=VPhRG535sTRSEvi+kDoLbxuNmEhyIXETEwIO5H7Q4IFnHru0jqOZUB0UJ0N6QjlMjyGwfnigtyXHHALPOAxqoA8jq1vVrDVtRJkNz55s18S3MyqcO3/7avivRvbA3GZOB06V0vClkNuEjdsT6tMcuEZ7IkVKMUFwkfLzGASKoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104814; c=relaxed/simple;
	bh=OIouVvGnPoikz62A2ILQprmyGzviNxM0jXuAXbxyx1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gA488p53eq9ZqLBUlpU0UwsCJPwL8dRQcR3Ypvz4rCGJbFVAkHyl4sW9uyD5epyv0psEmkY3oREEY+Mui3YG+oeeTRtq6uQ20Z2ejc7Ymqnlf1ffzmR4EBYdmuumXE4OXvhpL2ceRzIuL3b6iacGIDDQEzKaMXtVYbsk+UcDyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VEhTFa1i; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE7K4Ep81163008, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763104804; bh=/3sydLldUzCbvHsSn1MeMUP2xyjhYWiBOJo8fmkAowo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VEhTFa1iB7ogYMVIAQPa+JWQiQSZpeE/OUXp+sPXalD11fM7wC6z6mGUXFeK5Yhc5
	 OMKF4TNyNQCVbxXk/nYCBGzplJqGSspZ3FtmeBZC2O44AVZ2stjQNWTVYOcWNi//tu
	 UxPdyPiTD0YcUQvLiSUog3dHOo0VcnMEWIFS6G5cvLVjx6bIz6upKraP7tk3emrxV7
	 YoTOP4xPjQRVNt3RdIDdBCYFyTHmkxX98F8UOMPu3PTWzPsAI6tBWAoLxBBcfJ+Hng
	 tOsM0SYCB/Gaet2fkYG1VVmm/qTcL22cLLDV3K4/KkwOiGJA9qQmhxHQ8lnvsvQ03W
	 z4uZ2gYHvRcWg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE7K4Ep81163008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 15:20:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 15:20:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Fri, 14 Nov 2025 15:20:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtl818x_pci: Fix potential memory leaks in
 rtl8180_init_rx_ring()
Thread-Topic: [PATCH] rtl818x_pci: Fix potential memory leaks in
 rtl8180_init_rx_ring()
Thread-Index: AQHcVMGwn0PA1gtDskSX6KZ3v+WMB7TxwiBw
Date: Fri, 14 Nov 2025 07:20:05 +0000
Message-ID: <dc6974f6c9f04ac68d0b10a427b0abd0@realtek.com>
References: <20251113165851.39054-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20251113165851.39054-1-nihaal@cse.iitm.ac.in>
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

Abdun Nihaal <nihaal@cse.iitm.ac.in> wrote:
> In rtl8180_init_rx_ring(), memory is allocated for skb packets and DMA
> allocations in a loop. When an allocation fails, the previously
> successful allocations are not freed on exit.
>=20
> Fixes: f653211197f3 ("Add rtl8180 wireless driver")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only.
>=20

I'm surprised that people work on this old driver, and how did you find
this flaw?


It seems like rtl8180_free_rx_ring() does all things you are adding, so
just goto err_free_rings?

@@ -1130,7 +1131,7 @@ static int rtl8180_start(struct ieee80211_hw *dev)

        ret =3D rtl8180_init_rx_ring(dev);
        if (ret)
-               return ret;
+               goto err_free_rings;

        for (i =3D 0; i < (dev->queues + 1); i++)
                if ((ret =3D rtl8180_init_tx_ring(dev, i, 16)))



