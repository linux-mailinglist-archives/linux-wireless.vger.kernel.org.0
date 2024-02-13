Return-Path: <linux-wireless+bounces-3530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EABA85307C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4922840D6
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AE242076;
	Tue, 13 Feb 2024 12:27:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADDA3FB1F
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827239; cv=none; b=UEp5MNl7O6GVeKkJ4hy8nPLMU1KL2YsVv1hZweLjY3lE6p4OHB6bTrGE9HhXc7c6wFdr+m9tO6rAH8Wn77Z5uRXgi2vBsgN3h4R1tZS8L6Eo/GLpnuzdX0vFYexR/6Es+WeWSlA0x2xYtdvcBLPpgMtrOqcJ66phStflQbDrMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827239; c=relaxed/simple;
	bh=9z+VTXo1c0WVDTB0JWplF+io5ROYwA4e6H00dB3iBrI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b1taQ8Olw3vao6gfWgpruxQncXBxcZESfeVOv0gx8T+kF4Ln5Pr2O80Q0Q8tgteCVh8XqtZf2Ld38GSKqK5D3fVM/7xfsvI37HuurC7MCaBdIV8LR2+QnKR9QFxTnGDAqFEp30yKxjKRDZy9Yi0d5MrwuS0GMdceaf2fyGxl/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41DCR33601721161, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41DCR33601721161
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 20:27:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 13 Feb 2024 20:27:04 +0800
Received: from [127.0.1.1] (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 13 Feb
 2024 20:27:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <johannes.berg@intel.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: fw: remove unnecessary rcu_read_unlock() for punctured
Date: Tue, 13 Feb 2024 20:25:56 +0800
Message-ID: <20240213122556.9593-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The rcu_read_unlock() is accidentally added, and sparse warn:

  drivers/net/wireless/realtek/rtw89/fw.c:2807:17:
    warning: context imbalance in 'rtw89_fw_h2c_assoc_cmac_tbl_g7' - unexpected unlock

Fixes: b82730bf57b5 ("wifi: cfg80211/mac80211: move puncturing into chandef")
Cc: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 540ea16f048e..7f0c8cfb3e2d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2808,7 +2808,6 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 
 		h2c->w4 |= le32_encode_bits(~punct,
 					    CCTLINFO_G7_W4_ACT_SUBCH_CBW);
-		rcu_read_unlock();
 		h2c->m4 |= cpu_to_le32(CCTLINFO_G7_W4_ACT_SUBCH_CBW);
 	}
 
-- 
2.25.1


