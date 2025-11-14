Return-Path: <linux-wireless+bounces-28955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42337C5B770
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 986124EE00D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFE62EBBA8;
	Fri, 14 Nov 2025 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ptRFIwQp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02152EA755
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100172; cv=none; b=GaRxW045s0qnbr/Gy0kQcBVqdE42qvM+/MO5AbdBjoGBS5I6NSQ5dODI0QE3XnPUtUPBzOfusiZrTYjv+y1+gsd1hzxl3nTi4b3zwWiKwzyngjEg88xPW2sO873UX2yN18+TCDIQIZeJNEXa3oHsRxRlYTcAfFXdAiajZdwNUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100172; c=relaxed/simple;
	bh=2LAjPUIoDffWNhu/moJqEXXEtE8Z4fGktVM835DX7fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZY8PGeGXytajlwPCS0CLWHVimN53niaqN+yTIriGGVHF7afC9Q4VN2HT0xyhhMEUhbzXIgGBGUZS5OsU7iHTVJzS2ALLEU0GZVJlUr9DUQy7jCAFYOd0BnpkXWDorGkKt1ae3WskNvNl3xBvDwunSn0/A2b4dcFJSkdrtCa3NYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ptRFIwQp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE62lxwE1038288, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100167; bh=2u9Xw+95DZjJ/hEjQEdsCV5khGuqHmGBlicsK+oBmsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ptRFIwQpjAZAzNqy7J3TAWQkpmTJMfb9hH0pGIQyo+Gm9ybYxBDlJEmOGHXaO9FKR
	 nVOi6bMuZ/G3hTKv+2dnlZWj9tNxdPxO4VClTHdtvBg0c3KWdxeSN27tlItbbTRBcv
	 bd8yudILol1jv1aci2LWe+X1khouMeVYR6OEpCQ8SHdNLin12opEZr244BrdqSWOUD
	 +Cz5t4WnHSS8G8t4QAAifEphjhvex2kgCVtO4MroXbp1+xMu480mN4uqBp7hvz4Y0Z
	 SmsrVUVqyr6Xjbm4yV+kw4j8vUIUfOZjdTFwy6Zt2sj9/ySQtnkabj54QfR3KpPflh
	 KV2x5FOShFd6g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE62lxwE1038288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:02:47 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:47 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:02:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 08/14] wifi: rtw89: phy: ignore DCFO if not defined in chip_info
Date: Fri, 14 Nov 2025 14:01:22 +0800
Message-ID: <20251114060128.35363-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114060128.35363-1-pkshih@realtek.com>
References: <20251114060128.35363-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For WiFi 7 chips, DCFO (digital carrier frequency offset) feature isn't
supported, so the corresponding registers aren't defined in chip_info.
Check and ignore this feature accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 28e2b15240a7..08eb3fa6b347 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4608,7 +4608,7 @@ static void rtw89_dcfo_comp(struct rtw89_dev *rtwdev, s32 curr_cfo)
 	s32 dcfo_comp_val;
 	int sign;
 
-	if (rtwdev->chip->chip_id == RTL8922A)
+	if (!dcfo_comp)
 		return;
 
 	if (!is_linked) {
-- 
2.25.1


