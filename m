Return-Path: <linux-wireless+bounces-28482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B97EC29EEF
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 04:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303113B2B9D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 03:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B784D19C546;
	Mon,  3 Nov 2025 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NUgAL3Si"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDD8248C
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139805; cv=none; b=Y/BxmsayhKMtYYVsbuRjAQ+f+2bybn+XuUKY+j8lzfx8aMA/c3h0ptqjd/OpRinoTkilOxYSYOlnlAuddPlwsIrOH8FfUQEykKGu4s5lI7HToj06KGmBhXrBBDCMT0KX6YhLeDDnayRBGgUdCPvEk6WV4u4lFDCvL1Kr3+moKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139805; c=relaxed/simple;
	bh=JstMsQXAAg4ul6yWzCLAjVE0sbSoLHSQ+KmRlMwzSpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MX1RvRorwcH3RqCSv7KDSnJg7+W2ujmX3aJIR7+imVAmOV58ntZOSxwOcMT6Dh4aln1PxH6fXPLObURj5qrbr7YXT+4tGX7bzwknZsReSeAlBs6Fi7grvyWTsGqzyCBAL7H8vCtzuouvsCPqBW5SIn5iT6LIbA2PsaNOnui5GXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NUgAL3Si; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A33DUjW4716032, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762139610; bh=SW5R1loP+I2ZlWIFNRmYmhcnPuboC0FMTUowpW6RMA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NUgAL3Si4W9JlmSIs8Z5oGyyZG01wCRAjY6CGGhZ/Rbq+E9dlYqbR5B8l5FwksdSo
	 dVfBl2GC6sl/oHdIAsISWDPYX3VRjOwPOMjtKNaT5y4vsWr9O11VFM5zCjXWP2lu3T
	 bChI76rvS7Id3b6p8ZZdmvz/yQNwl1hcVUoWVLcc4ZY6BNsUkbzGXAnbJS9PdRW6BY
	 XVTvHQ+YAaMZ86dLgF6f2x2so4cYeUSgPw1khk1szTTacPpRTFq1HbQqvYzR+Ibxdh
	 98/LdHttKf+DddYNZ6MzdlfpNFe/KgsEb79PfrJjcHQjlVMdj0EQtVt98hG7ySloRw
	 kE7eCR+FFJOuQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A33DUjW4716032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 11:13:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 11:13:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 3 Nov 2025 11:13:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
        "Sean.Wang@mediatek.com"
	<Sean.Wang@mediatek.com>,
        "Leon.Yen@mediatek.com" <Leon.Yen@mediatek.com>,
        "Michael.Lo@mediatek.com" <Michael.Lo@mediatek.com>,
        "allan.wang@mediatek.com" <allan.wang@mediatek.com>,
        "Eric-SY.Chang@mediatek.com" <Eric-SY.Chang@mediatek.com>,
        "km.lin@mediatek.com" <km.lin@mediatek.com>,
        "Quan.Zhou@mediatek.com"
	<Quan.Zhou@mediatek.com>,
        "Ryder.Lee@mediatek.com" <Ryder.Lee@mediatek.com>,
        "Shayne.Chen@mediatek.com" <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH 3/6] wifi: mt76: mt7925: refactor regulatory notifier flow
Thread-Topic: [PATCH 3/6] wifi: mt76: mt7925: refactor regulatory notifier
 flow
Thread-Index: AQHcSkWcCZ8S8dG8GUS3a3GHc4YG6bTgSrEg
Date: Mon, 3 Nov 2025 03:13:30 +0000
Message-ID: <baa20bd04f0647ab901b71b5860b2ce7@realtek.com>
References: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
 <20251031090352.1400079-4-mingyen.hsieh@mediatek.com>
In-Reply-To: <20251031090352.1400079-4-mingyen.hsieh@mediatek.com>
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

> --- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> @@ -6,6 +6,7 @@
>  #include <linux/pci.h>
>=20
>  #include "mt7925.h"
> +#include "regd.h"
>  #include "mac.h"
>  #include "mcu.h"
>  #include "regd.h"

regd.h is included already.


