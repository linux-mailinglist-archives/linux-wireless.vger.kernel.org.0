Return-Path: <linux-wireless+bounces-21148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECCA7AC87
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 21:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5433A9728
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547A5279323;
	Thu,  3 Apr 2025 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJf3rDuY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248BE2580DF;
	Thu,  3 Apr 2025 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707249; cv=none; b=O5SS1DHPBlDL6clb+4mC1xHZ8H9HCtntNJFuwZ1c7kPmVwsBftzY17yxG/QiLPv9dSWHusIVnEZwJr5Dsd0XlLSath0oI5KLJpUxGzedfIpR0nRUdBxKD1VLzIuBE1wHQ7UX6nwbSW/ZxqGBpB+65n8ypf6VWUze5qEgfBwM60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707249; c=relaxed/simple;
	bh=NilAVgNUnea1icERfhytbZ+XwefVTD71Tzk6Trb40CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBFd8p/CCq7h6d5fh6Zbebnj6aOXZgTs4VlcWTgqz4F0/nBwcrCI12BUrQ8dYQk14Z3EFbhBOqtkcvOcjSnRQQnRBDLsT+bEUmhJQGComYlllC8e2Jb+SC+RaImF7tvAO0rUQsNvzFtuOiwbjod3dGNri0EdXCLd2qyyTG31Ed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJf3rDuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2043C4CEE3;
	Thu,  3 Apr 2025 19:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707249;
	bh=NilAVgNUnea1icERfhytbZ+XwefVTD71Tzk6Trb40CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJf3rDuYqCyiDXpoOjVXYmrQ9d6LYVzacrnrmdGHKO+3tuT88WOZycf02JlUjJGHr
	 odYmf/swzfTy90TU2o3R/bMHVTgP+Nn3Wq4Mcjls/xbhTDAq2ROcOaS58jhExT5imt
	 XTqQE3LF2mA886W2yd1feqPlps24UTkgNsh5b6xjHZBXSx+ZHwAJ8sHivQYYnstb97
	 8n9TOohx/msxVV723FPqurjSMP2KVcrbT5AbkLCTI8gB62sVnfH7aTKkK/dtJG3YhM
	 cknumMlaG3gztLYq70UruqZi0AnW7SEKsyK+ljF8s/b3+JUN+Pib2xaZ9LJO87adUA
	 sx4uZMxpDJkeA==
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
Subject: [PATCH AUTOSEL 6.12 38/47] wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table
Date: Thu,  3 Apr 2025 15:05:46 -0400
Message-Id: <20250403190555.2677001-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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


