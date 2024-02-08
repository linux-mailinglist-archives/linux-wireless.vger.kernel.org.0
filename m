Return-Path: <linux-wireless+bounces-3316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056F884D7CA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 03:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59661C213D4
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D971DDD5;
	Thu,  8 Feb 2024 02:30:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B011E4BF
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359406; cv=none; b=eDietie3iezbvW2INrKev44PBSid54zgJeEfngJNFv+4zbAwZsUV5ggVsxrUdHYJt4z+tICi5Disw+12F62PFduJI1LlxYCryzmui3kERcsiiFF/lRQJqmSehrE6956Kc1YD+ke2K9vDCTOEE2cJUKg9WBMSBQDrIs4zqplfK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359406; c=relaxed/simple;
	bh=4anTWcIkkHi0TT4n1HG10rIQtDTv+PkbDnVY0y9rMvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw12VBUcWcEHBSo9IGsRYOwznqlsdGk7P1tk3UQqFzHaHzvCWy9Scv6FSN/w8IWmiIna7Go+yqUJOtjIQ5p9fNVI/Leudx11GGqJSrerS5fGoSacAyZEZwKoi2uOG/OU0/P9vba72XrysvM3OgbbkKNFXJVyfULHuVgOAvlX4tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4182TxDX2191882, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4182TxDX2191882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 10:29:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 8 Feb 2024 10:29:59 +0800
Received: from [127.0.1.1] (172.16.17.45) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 8 Feb
 2024 10:29:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 04/11] wifi: rtw89: mac: correct MUEDCA setting for MAC-1
Date: Thu, 8 Feb 2024 10:28:50 +0800
Message-ID: <20240208022857.14379-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208022857.14379-1-pkshih@realtek.com>
References: <20240208022857.14379-1-pkshih@realtek.com>
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

Consider mac_idx as an argument to set this register to disable QoS NULL
update MUEDCA timer.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index e2e0a7549b53..fdbfb76f97ee 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -995,7 +995,8 @@ static int tmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	u32 reg;
 
-	rtw89_write32_clr(rtwdev, R_BE_TB_PPDU_CTRL, B_BE_QOSNULL_UPD_MUEDCA_EN);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TB_PPDU_CTRL, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, B_BE_QOSNULL_UPD_MUEDCA_EN);
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMTX_TCR_BE_4, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_BE_EHT_HE_PPDU_4XLTF_ZLD_USTIMER_MASK, 0x12);
-- 
2.25.1


