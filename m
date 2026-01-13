Return-Path: <linux-wireless+bounces-30721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB1DD1660C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 03:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E83302515A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 02:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54147157480;
	Tue, 13 Jan 2026 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Rkn0/S1/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A363CB
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273053; cv=none; b=jVp3jCM+LJKpQ9eO8WCRr4GBgbZ82OR2aGFcBAn2u0fTFtK94Ww7WJNGaqWw6GbbxaHVfGdhTg+mZIaq4bz6bilTtULtSbHLFSXvNP25Nz5bhn7ZWVdHMYNe5vFk/+pnBFFroDMy89tw7crLQCh2jClvCGC9TCtC3iFRUbH+5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273053; c=relaxed/simple;
	bh=9RDTgj8urylr9bD4Bd6aMPDLYu6OGR55szl/YEuhDl8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=g+rEQmmW3GHnmY66uWUJQCotWzx3tVpV9oe5b/HqBcN94TBvjfufPgJSguCCcWuNK0r0bT27D5Rn/4bSicPOQhN06BDN7iEnk8qjsgL8rcNhp8EUT41oCtIsFaWQYa1ZQPXiVlYbVwL9JnzR01nRJX4xtlJwVuKIyBIWBIj6VgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Rkn0/S1/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60D2vRxL52186832, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768273047; bh=Xloj9/aKgB+tr6Wl0nT33CPPfU7cN+FvEz7OAQiQH4o=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Rkn0/S1/35Pl6D1m/2U2E18K6CiqbXg+vYZGJrnMx1ew7h7dLLhyMOSW7S96keMlL
	 hmx0LOc22llMxr+QABjbkTe7eA6BiiBsrPTVWQy68KIcUI3sSWaqt/G4xfFhgT9Yn1
	 CdHFKuad7b3/y8ljeR6NwnmSF4o6jbUG4iUiJmapv26VdmPNpyTVaonHJqln/uLT2G
	 2f276030JCMFfKxaX/eixEI2ip5i9jqxLEuzNISKNQyb5CZgnWAuR7DLizoAsz7az7
	 CZIFQVbXHnfs/p6x1RIU0BYe1bkqvsxLVo8VbTBxGrY+4Azwk2TfArheIfmoyxOmBz
	 kBKNrSDtjBWpw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60D2vRxL52186832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 10:57:27 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 13 Jan 2026 10:57:27 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 13 Jan 2026 10:57:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>, <linux-wireless@vger.kernel.org>,
        <pkshih@realtek.com>, <rtl8821cerfe2@gmail.com>
CC: <usbwifi2024@gmail.com>, <xirxes@gmail.com>, <zenmchen@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: Add support for D-Link VR Air Bridge (DWA-F18)
In-Reply-To: <20260112004759.6028-1-zenmchen@gmail.com>
References: <20260112004759.6028-1-zenmchen@gmail.com>
Message-ID: <85aa5446-e0b2-43b0-981f-bb9e63e0daef@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 13 Jan 2026 10:57:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zenm Chen <zenmchen@gmail.com> wrote:

> Add the ID 2001:3323 to the table to support an additional RTL8832AU
> adapter: D-Link VR Air Bridge (DWA-F18).
> 
> Compile tested only.
> 
> Link: https://github.com/morrownr/rtw89/pull/44
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

292c0bc8acb6 wifi: rtw89: Add support for D-Link VR Air Bridge (DWA-F18)

---
https://github.com/pkshih/rtw.git


