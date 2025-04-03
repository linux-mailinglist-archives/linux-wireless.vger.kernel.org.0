Return-Path: <linux-wireless+bounces-21150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF85A7ACE5
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 21:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 053D67A79F9
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8747A29616D;
	Thu,  3 Apr 2025 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNtZH96S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92725A2B6;
	Thu,  3 Apr 2025 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707357; cv=none; b=FRrTgNSN4zoq20jLm7iV5y0ufrAMiCFBRQKydrRZLR9+IRu9YvhqAi0doSaygPJb9Qem/Pq7QL+1+QClVD0qllumHARVD4t5Imz8xCdNHbThlZzW/YSx5ZkckTGTMlpiJpFMR5mx+IesuKgs9BkEWwE9J97LZ2jt5k63i4j8uQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707357; c=relaxed/simple;
	bh=GNHJfVzVNAlpwYr3o5Fo+VsNpqk3jsX89c60zyBrKwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2V46EsSjj+5gyKEFnwf9j/n6Q71LgtyrKCrhp9jyiSOnvdR8pZJNlcBWw/z8bpSPM1nBjL+sdKt4xJ0/dVK9HuyciFOR7zQ+bG7NIxkWz8lz3GLUYhf72M5gAFmGqW1g0lXStGrlPXtLeWkdj9lgidcLBdxwPrG/4BzzbOnY+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNtZH96S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9381C4CEE3;
	Thu,  3 Apr 2025 19:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707357;
	bh=GNHJfVzVNAlpwYr3o5Fo+VsNpqk3jsX89c60zyBrKwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNtZH96SC7vejZoof6rb13cd2BmHITWz5AZ5zVhIMpl1nrI339vnsX3xu8Weky0fZ
	 YeZ80LunGjsW//mHlS+ItEoJf+aHO+I0iy056fTJQMb/Brv0Pv2bxwTozusVHt9rW2
	 O4Pl5T0CtmPe45VJ+FBK8ZJBEjP8gX0+w58nj1eSykCFqBhSzGHIeixdoHTr2f6Gac
	 8uDWHNiY8ghFY8Ql4uWQ7GXRz3c+bTWcSj50qYajSndhBod84xc2L85VXtvXfm2nEF
	 Kw70X1zdMGg4EHMMv2e3xBr7c95qFD/3ALyINWEaD2+ugEOB38zcbMidyemh91AMyd
	 zR1AlSzHzUUzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Icenowy Zheng <uwu@icenowy.me>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 14/18] wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table
Date: Thu,  3 Apr 2025 15:08:40 -0400
Message-Id: <20250403190845.2678025-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190845.2678025-1-sashal@kernel.org>
References: <20250403190845.2678025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
Content-Transfer-Encoding: 8bit

From: Icenowy Zheng <uwu@icenowy.me>

[ Upstream commit 06cccc2ebbe6c8a20f714f3a0ff3ff489d3004bb ]

The TP-Link TL-WDN6200 "Driverless" version cards use a MT7612U chipset.

Add the USB ID to mt76x2u driver.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Link: https://patch.msgid.link/20250317102235.1421726-1-uwu@icenowy.me
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 55068f3252ef3..d804309992196 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -21,6 +21,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
 	{ USB_DEVICE(0x045e, 0x02fe) },	/* XBox One Wireless Adapter */
+	{ USB_DEVICE(0x2357, 0x0137) },	/* TP-Link TL-WDN6200 */
 	{ },
 };
 
-- 
2.39.5


