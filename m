Return-Path: <linux-wireless+bounces-21151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E8A7AD3C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 22:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B3E189D474
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006B2BD596;
	Thu,  3 Apr 2025 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNtf7aUW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC182BD590;
	Thu,  3 Apr 2025 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707396; cv=none; b=iJzg01DfQUeM4FABlZYbaOUmL4Y2zaAxME8C/s+jeA8CvfWoc3m9XXtP5tFOn1k9SK+otOxJTbEFwJw4BrEIv3vhq90ae/C0TGnu/3ZBXBEnFjfplhZRXZqsD4Qq2euWla7IiaJqbv+X/bCTZ7YhZU936okVj3Qc5q27h3ILdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707396; c=relaxed/simple;
	bh=k3JtT1044L+E/0ZKJrYQfqsGEng/GOGW9/OU9mKWewI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C2I88PXgXLQ9iEVVrqVsPX3S1CjZubRitS0uA8RmbmCXyE6BkNVhUQxYG7QrKrgs+5F47UHKhJwAiG5W/qBfPFP0nfEGpYsUAez5UKrN4zbRVYW8Mdauo1hjj92STYbzKZvg4wAvv6MVglYkZTFGV7FCqnxWLXlD1AQxRs95urU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNtf7aUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB07C4CEE3;
	Thu,  3 Apr 2025 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707395;
	bh=k3JtT1044L+E/0ZKJrYQfqsGEng/GOGW9/OU9mKWewI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNtf7aUWq8T/N8thtUa1ulR4nwkpFRQ/q8AJBMPtinMp/+jxhofEQ6DXlrL9yASxH
	 Sjm4yN8wP6tAKvtD4vEgG3QyuzeoDJuLG4IetxIeOR0M91iPmnY1+zeUbK7XXSc4Of
	 vk2YC9QLBGDKolP9uTXWHsEZ3YXj1XnCLU1WUrwZgEdSCJRivwUqEgJR+bm938G193
	 gsg9chavbyQZ2qxig6zuvcegoE0Yig0H0xUdzeghomI3Ej1Ri8ql2rpiebh21QWxV3
	 t003KI06k47fA9gjYo1ZHENFRNVsUFUecZkjqTI9sSLIyPjOaLmoLnZqm28wlvY4yo
	 ZzuxEb2iATXkg==
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
Subject: [PATCH AUTOSEL 5.15 13/16] wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table
Date: Thu,  3 Apr 2025 15:09:21 -0400
Message-Id: <20250403190924.2678291-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190924.2678291-1-sashal@kernel.org>
References: <20250403190924.2678291-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 2575369e44e20..9369515f36a3a 100644
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


