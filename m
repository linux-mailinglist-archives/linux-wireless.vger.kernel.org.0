Return-Path: <linux-wireless+bounces-17819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C7A18BA0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 07:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330693A72E0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA39D15B0F2;
	Wed, 22 Jan 2025 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SJ+IcAWl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CF191F7F
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525845; cv=none; b=jJsUWnhYfEzoqBEzn+fY99z5KM2UaynYUNLjB2ymC6qg3FZOtU+6WD9tocQsD+pzhPj551DC2S8FrLaRFIZjQ8/TBkS8aXtoAjsCZoHv6/oqi7AA1qTku4PA43lS5yKpMztaxGLe7+FWwbVVsC3vDhVbk8vu1YX0S7uih4PTLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525845; c=relaxed/simple;
	bh=6DK65/1YSopVxztO6cLCpV0N3wGgsW92Sd6RyG2jH6Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4s/Gh92/KmumL8XMhQCKtwSClIojPjPk/nU/9AZGeJ1cVUu/x2MMsSec4/40VA/FBEdnGf3wYn0dUgsd/4y2Wtnyw4MeUNPEzCsUFNfkMZr42pVDrn2MZIkHWK6U+uWeF2D8r9ryO9jxlWToB5/Sbw8blRqG7zM8yrpQTfZ0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SJ+IcAWl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50M641dB42495092, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737525841; bh=6DK65/1YSopVxztO6cLCpV0N3wGgsW92Sd6RyG2jH6Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SJ+IcAWlG/dvXpJY1e687ZeAC7OgxNZlUsXIZslbR8AFE+8zTW9vsEbooUvoOEX4b
	 b6TmaUduJ8YEB2TzKjYydLQqH1juBphW5mao7wE5aYxiihXkwIPVE0LMiBNkg7N4lI
	 ytAs+yMiVgI4VUqy9NyEYmBVq758Qb14b/DjDQhMd1ubsMd0P6j9RaxyL9a6zrfFll
	 56I1rXhULOdu6ve3QIxaNq2VM3f8U87ZKDQkxxWXNGYHUQS6A28IsViyLC1D3y8zIk
	 s5t1j4l3ju2Jy7oHyDtlIWIRxLKCdv4pCVCN4vPazMmHkBT9MFmN8LjAfYya27ADOL
	 Nz9f06etPizqg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50M641dB42495092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 14:04:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 14:04:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 Jan
 2025 14:04:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 06/10] wifi: rtw89: debugfs: use debugfs_short_fops
Date: Wed, 22 Jan 2025 14:03:06 +0800
Message-ID: <20250122060310.31976-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250122060310.31976-1-pkshih@realtek.com>
References: <20250122060310.31976-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

With this change, the object code size can reduce 768 bytes.

   text    data     bss     dec     hex filename
  77257    4262       4   81523   13e73 debug.o   (before)
  76489    4262       4   80755   13b73 debug.o   (after)

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 35bf627dbae2..0863ed6acda2 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -217,25 +217,19 @@ static ssize_t rtw89_debugfs_file_write(struct file *file,
 	return debugfs_priv->cb_write(rtwdev, debugfs_priv, buf, count);
 }
 
-static const struct file_operations file_ops_single_r = {
-	.owner = THIS_MODULE,
+static const struct debugfs_short_fops file_ops_single_r = {
 	.read = rtw89_debugfs_file_read,
-	.open = simple_open,
 	.llseek = generic_file_llseek,
 };
 
-static const struct file_operations file_ops_common_rw = {
-	.owner = THIS_MODULE,
+static const struct debugfs_short_fops file_ops_common_rw = {
 	.read = rtw89_debugfs_file_read,
 	.write = rtw89_debugfs_file_write,
-	.open = simple_open,
 	.llseek = generic_file_llseek,
 };
 
-static const struct file_operations file_ops_single_w = {
-	.owner = THIS_MODULE,
+static const struct debugfs_short_fops file_ops_single_w = {
 	.write = rtw89_debugfs_file_write,
-	.open = simple_open,
 	.llseek = generic_file_llseek,
 };
 
-- 
2.25.1


