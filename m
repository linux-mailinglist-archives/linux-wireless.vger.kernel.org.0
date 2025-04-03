Return-Path: <linux-wireless+bounces-21152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BAAA7AD6F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 22:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E4A3BBAA3
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBC42D4B53;
	Thu,  3 Apr 2025 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdThhI7y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717EC25B671;
	Thu,  3 Apr 2025 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707430; cv=none; b=ZYOZ5II0ECUhHt3jN3qeeJNktLrCW5qscdkJhMA1q5LBxrhDq+hXMn0mKoae3Wj1wD7BkskpigbqnZsj+qU99ubs9LsSdUGaKOlyMyDO3qnAkv2ppZ94lxH/WEiMTATWH5GuUf5996WDSTeXJo7mzuCXQj1H0Y7GnNn3ACKpxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707430; c=relaxed/simple;
	bh=NANuZcB+1Aam2VftjP5x9dhJ7SvyFJhCDE5Np6+DG1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t38yX59fqU+LOHMZuM86twTfQrzCT0lEKCbJrZpZ1aYAwxqw9QOIBONV22B85ObRXKcZp7avEq3wJYNmtG3GVD23n7cwFlyVlzs0OlivLG+5ZVr6kqjEjM65zMnDIIm2urgQ4LtTSxHaTKFqT69kPPmjlnEcEYB1zj8jrgct/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdThhI7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F71DC4CEE8;
	Thu,  3 Apr 2025 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707430;
	bh=NANuZcB+1Aam2VftjP5x9dhJ7SvyFJhCDE5Np6+DG1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdThhI7ySQBkhSrHXaB/Ie7tHBlmTGMnyuEVtRULefQqzZWtCCMcHo+B+g8lRHQiV
	 TvH0vCuJyYMIHpvEqzDQ+ncbog5X99OXTptHZXJOGk8S2kK33dKZWU1s5mjaw4isN5
	 sD6kQAOxeVG4V8PZAsUc5HvAJrDxqFYB03cqYlYUVGZx6DGUfOWXXwCP+2flHVao4n
	 8hDgblPnlDiD5CCGmUbmxcJ8+P436iNJeEIdBS6yrXsJFCAZ09ZWddAf4OHNlvWocW
	 GL8bK1p+xGsX0+shMl3baEboM9oBDOhQ4LR5I9zVEReBhw6dMxZckeNT9pPYpcj+xA
	 0de59l6vID5hQ==
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
Subject: [PATCH AUTOSEL 5.10 12/15] wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table
Date: Thu,  3 Apr 2025 15:09:59 -0400
Message-Id: <20250403191002.2678588-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191002.2678588-1-sashal@kernel.org>
References: <20250403191002.2678588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index 4e003c7b62cf6..82a193aac09d7 100644
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


