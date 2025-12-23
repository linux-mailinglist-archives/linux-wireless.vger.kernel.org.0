Return-Path: <linux-wireless+bounces-30072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE76BCD7FB6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74B1F3001016
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C911E2858;
	Tue, 23 Dec 2025 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Mty3hw9+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB1D22D792
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461162; cv=none; b=fuRXCXzbOyFEbST2sNiVxIX+aOX6+zag4ROoVTdmKzXEjVhIiSB5y/s+L+xrmFcWuytP+AHv/kdgHRIMaeCtW7wOwspK3HsuGow9aht8HnTJYb/xuFRWhxgSVZZJCm2nrKOSWnM5Vyon/e+q6mXW6b/2t7wdtvx81pOGAsmWQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461162; c=relaxed/simple;
	bh=4PFE8KZh8bVNklHDWtvw/CaOG6Fxxegk+yXY1IOtj9A=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=QbIPt0xQ4YSCvC4Hkvg1RQ1pimPvNtYSoxjAKomzAAZ/2lUKgTklddgEVIPQzaOStESWIjeQlB25kLlwcrScepHR+5LdYKA0IIFNvWsaHwtTG2GmPwBqqXY3+9sCq1IaQ/422vRZat5D0y28KkxbC1pmW5MBLOSkGaR4o/VqTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Mty3hw9+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN3dFP61620508, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766461155; bh=cKGdYd/jkH7JSB7xaqX1i+NIhDArnogUnreibnk2Gwk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Mty3hw9+yeWdaxfV7fWFUqPp8Ih6VOYkAhy1+l14ZAYrpgWTrJw7/fPiafGwSAxGN
	 aYeGLS+zcYCJyHgbZ6BR7xogPHigCAANxdiWMXcv5H3tqZGWTc6mkreSddmz0qspWJ
	 Rv2nQ+bRGGbKhpKuUI28+fnsn8ydIxXrAt0MvXqgusTsJld38DmtAG7E8F0AYK99XF
	 mlG79ZqVAny/lbivpwNVfE2TiCTzTUfx2XoCHUUsVEcUGCRmE2BYiht4V0TIJ/swCw
	 ON4HFzImG97IlPoPoSeMMpE8KXoay4okKgpru0ZomrX2IR1Z3p/nEozVD7u7MyUXNU
	 fyKokk4iEVOjg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN3dFP61620508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 11:39:15 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:39:16 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:39:15 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:39:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Hsiu-Ming Chang <cges30901@gmail.com>, <linux-wireless@vger.kernel.org>
CC: <pkshih@realtek.com>, <cges30901@gmail.com>
Subject: Re: [PATCH RESEND] wifi: rtw88: rtw8821cu: Add ID for Mercusys MU6H
In-Reply-To: <20251205003245.5762-1-cges30901@gmail.com>
References: <20251205003245.5762-1-cges30901@gmail.com>
Message-ID: <d4c67e65-3e54-4bbb-83a4-5cdc893c90e1@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 23 Dec 2025 11:39:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hsiu-Ming Chang <cges30901@gmail.com> wrote:

> Add support for Mercusys MU6H AC650 High Gain Wireless Dual Band USB Adapter
> V1.30. It is based on RTL8811CU, usb device ID is 2c4e:0105.
> 
> Signed-off-by: Hsiu-Ming Chang <cges30901@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

77653c327e11 wifi: rtw88: rtw8821cu: Add ID for Mercusys MU6H

---
https://github.com/pkshih/rtw.git


