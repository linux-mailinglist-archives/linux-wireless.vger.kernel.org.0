Return-Path: <linux-wireless+bounces-21145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ABFA7ABF8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 21:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B720B17D800
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC6256C71;
	Thu,  3 Apr 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1IblNrT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525B256C70;
	Thu,  3 Apr 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707136; cv=none; b=aNbF1HBVybC9dIp1y7kSf6bS0en4kHB8PinHJU3W4TZMGx4sDJOygFKMXd1XgNM8MWINCCqjgysuS9IIlBXssEMDipMewkOnXxE/HpS2KYlIutJJ/3K0Xk+Bj95BPWiQhZQhPFbdOB32+PycbFbwqZO2q/J2Wl36kmgld0QQKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707136; c=relaxed/simple;
	bh=NilAVgNUnea1icERfhytbZ+XwefVTD71Tzk6Trb40CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HyDy5VtwAlr0he6krRZA1fJccQwCQQCYM3/tv3m7wGn19kxS885shwCJrD/E/eF27x0Fsc0oWnZTbnokQ6Jk9KDumpUjV9oplpb6Aq5iKpSiRF0JVwahrQWUZ1sJXDjSkPxU+VcTPLCmfH57qCED1rsWL2tQ0yrRoNYHeO26KDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1IblNrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCA2C4CEE9;
	Thu,  3 Apr 2025 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707136;
	bh=NilAVgNUnea1icERfhytbZ+XwefVTD71Tzk6Trb40CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1IblNrT4DOwnSNXP0Z7yT9N06H4n0boqrtKJ4+RE/z7UqMOTf0UEc3hOouhkA5vJ
	 CZ7T5l9YgxjqH2xBsKw4afHJiWpd7EYk2PrNyFS8i6UGIJXpgj4KSYCbveSVIyMv33
	 3dw4FSMrrA4nVYi5KdO28WUodvgL8ZFpcF/bvG1lO1ui2gK7ZSZdUH3zMCXjOnaZuQ
	 QOXkbPLnwdFF4XjZDhkiYBvULI//9U0pEQuztzp4OL4Wyni7ZEEV5EPS0vvlgQrkwU
	 lSMDYFnym4ISyhj090r2camSdulwbknLXx7FIVRYVkWPeq8LedYQY8InacJfV+7Ckt
	 /YwryynoK1SVQ==
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
Subject: [PATCH AUTOSEL 6.13 38/49] wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table
Date: Thu,  3 Apr 2025 15:03:57 -0400
Message-Id: <20250403190408.2676344-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index e832ad53e2393..a4f4d12f904e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -22,6 +22,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
 	{ USB_DEVICE(0x045e, 0x02fe) },	/* XBox One Wireless Adapter */
+	{ USB_DEVICE(0x2357, 0x0137) },	/* TP-Link TL-WDN6200 */
 	{ },
 };
 
-- 
2.39.5


