Return-Path: <linux-wireless+bounces-19046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A3A37BA3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 07:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E533A7A2185
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 06:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC7118F2C3;
	Mon, 17 Feb 2025 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wD9Rr34A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E318DB3A
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774649; cv=none; b=fAJSCdUrp6IPh7imGk2cpsD24JsVg26cn3qEUhOpgF2W5+BGDeFVucI8p0hrt3kHDwLD3Ojcv0FrbZLO8x/SxERUVeYTSE6mx29KxPBqjf1vY9/2M/tRHcANuHLVj8vb8C/waxDViFwuOYYO9JE7F7Au8fYEMvGY/wKGfCbzJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774649; c=relaxed/simple;
	bh=9/elhzY3yCQ8Ag603J2ZU/bstqs9/hhoPGfOihW6oWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1MNTBF2GfjCGX4pE+Z7NNwP+jA/KqEcglr6wIp5gFq/UF0mGRpmX6F7z37Hhu+i6ImJK5Rp5FLQHulLjv0ik+HznGs8dNVpn4bvIwVqy7eEO9+AlKMI9sr4I4TND9LotVI+wJBwWE/MGO3dNwxhUpG91HDdcAD0euLbd+2y+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wD9Rr34A; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H6i45n92646803, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739774644; bh=9/elhzY3yCQ8Ag603J2ZU/bstqs9/hhoPGfOihW6oWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wD9Rr34A1Sf9Rh1kar+khR8ZDLVmKne3Ncmnfg21c0+TdiZ0hS95ZGRDau10MAYeM
	 1X6gOK8la5mJNw6LW3gLdEdf6DyLFZSvlqMAO8YPVBBe5Rwyz9pBYvLWgI81PGU0r6
	 Khip8fYYaTmXwRKGGJrvP5x7gZbuJF6rBYa/XbDNBnYgPc7olFKdlkxoBKtRUOXVY4
	 NAIJnRUd7QbTJWpfSpwHJW83/hYEJMi0RMu5VcfU0K9MY9H26UBlhd0Vzyf3BkNSFc
	 e5vNDUZihjmESEQ7Hvf8Ri0e+XDcPOiKw1YXYpoRSeEXm00V+/CLG1Rsbw/I8rNJfo
	 R48HFSHiAFRWg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H6i45n92646803
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 14:44:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 14:44:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Feb
 2025 14:44:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
Date: Mon, 17 Feb 2025 14:43:06 +0800
Message-ID: <20250217064308.43559-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217064308.43559-1-pkshih@realtek.com>
References: <20250217064308.43559-1-pkshih@realtek.com>
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

The error code should be propagated to callers during downloading firmware
header and body. Remove unnecessary assignment of -1.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index abbf420463bd..d9efe14fc687 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1510,7 +1510,6 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev,
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
-		ret = -1;
 		goto fail;
 	}
 
@@ -1597,7 +1596,6 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 		ret = rtw89_h2c_tx(rtwdev, skb, true);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to send h2c\n");
-			ret = -1;
 			goto fail;
 		}
 
-- 
2.25.1


