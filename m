Return-Path: <linux-wireless+bounces-25437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F801B04F8A
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7BE1AA7894
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 03:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0847E2D0C8A;
	Tue, 15 Jul 2025 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LRfmmQH6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A381B4F1F
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551627; cv=none; b=dMo1Jk6BTp6a1Ts8Eo/MeKUyIxd2ZHRKIhWTAee4Lb78VFjIQjDZ2+jf3ZNNECYP4D7kU3s+m7IEKdt1ysz/cx9oh9VkpGDZXNYlNQbT+f/AIRuqHGQSSZz2zyFt4BnbyVe9QWS1OD175+OU8aXxmDGyrpurbcgmLQNyKlZm6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551627; c=relaxed/simple;
	bh=/k/B3nGoNVidT5RawLeVuns4D/CqEd0uBVUMfJW/hkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eG01s+cukq2ruQxbPxEbEy87CFudiekyNrLcaosjWk7H8GzYRpQEEFT5Io/1r1utTQcZUYAYPnaZViGK4Si7w/k+zILtgsjNsWkbjU23ySXaapDW9VkfE5xBRRyN4w4anC9XUMz/niHJQa4Oc667RiwgBXcnWYno46hyYcHLp+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LRfmmQH6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F3rePgB3971988, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752551620; bh=o3rOkTDe7zniYsn9gABUvQPOYR9xRcVMmKoDEeWlVo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=LRfmmQH6vJCrKSltkTKgTpAxTIqpRQyeEEZPw9ImVwr2O99sJHIk16FemZH2k7vEu
	 YRyPRRJeJOAedjCuFOpBXDNKRLxax3bOWpq/2mpGsrdBtEHgJTooH4t9S4pcExPPgM
	 iCO+tGZKhaxxmdU8sIBCopKW0DGNofxfumBtWFN/huCi9Nerk6c9Vp8WLEznc3zRaZ
	 krB7nuxbjz53jMbpZtPgTlC5oAvL3hv4fmjUWmpc0hVicKwSbi+mMjNxXyEqtMg+d7
	 FnJ881MoYYEAAco+Y5XvFH6oUPEIGC6oLxEX/IZ3UMrk1PCMvOIcGYEPAmskBzrWA9
	 ijEHaj+4uq7tA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F3rePgB3971988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 11:53:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 11:53:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 11:53:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 5/5] wifi: rtw89: check path range before using in rtw89_fw_h2c_rf_ps_info()
Date: Tue, 15 Jul 2025 11:52:59 +0800
Message-ID: <20250715035259.45061-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715035259.45061-1-pkshih@realtek.com>
References: <20250715035259.45061-1-pkshih@realtek.com>
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

The variable 'path' from rtw89_phy_get_syn_sel() as index of array could
be 3, but array size is 2. Fortunately, current chip->rf_path_num is
smaller or equal to 2, so it is safe. To prevent mistakes in the future,
add a checking and avoid Coverity warnings.

Addresses-Coverity-ID: linux-next: 1644716 ("Out-of-bounds write")
Addresses-Coverity-ID: linux-next: 1644717 ("Out-of-bounds write")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d26626bed960..a26465ff6a68 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6153,7 +6153,7 @@ int rtw89_fw_h2c_rf_ps_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 		path = rtw89_phy_get_syn_sel(rtwdev, rtwvif_link->phy_idx);
 		val = rtw89_chip_chan_to_rf18_val(rtwdev, chan);
 
-		if (path >= chip->rf_path_num) {
+		if (path >= chip->rf_path_num || path >= NUM_OF_RTW89_FW_RFK_PATH) {
 			rtw89_err(rtwdev, "unsupported rf path (%d)\n", path);
 			ret = -ENOENT;
 			goto fail;
-- 
2.25.1


