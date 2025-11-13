Return-Path: <linux-wireless+bounces-28886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CBBC557C5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 03:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FBF2346F51
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 02:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE40253B73;
	Thu, 13 Nov 2025 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QM/sHMD/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A8246333
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002645; cv=none; b=XEB8+XvhRd20cZatzY1WwW/tGE39YCF1CHcmtSrLLFcw9XvNoKej/7dRYJ7MM07Uv2AGbMoXUUPQLs8ERYCjgyGjeGWVYavSRkLe4X3vQl3hX+4sMajIOYJ7pQgwr2nRG3avv7KomogQwbx84UoJL0zKVnl++Jat9OF/gMp45eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002645; c=relaxed/simple;
	bh=ODAZhuspNCDuajvNYwQXyducvQa1gxGBdNaxZFF28JU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpvtDffo5QK8zr68oFmfAeTIrkgiOIi0f+hcJCMqST7qa8yWvMUBqPc9hdXZcDyKITqbb69AY+cdp0aZE7CFMzp4HelCRduQ75Bab4va+9efqA2BKebMspWry9/e3ltZF1oO+AA7O9GyehWo/6CjjouRfEg4VvEJvXW399SPg7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QM/sHMD/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD2vLepD2839398, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763002641; bh=t//nwnO+nX+L1KXmtPeE6eGJnujoapJW5DXQSVQFBwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QM/sHMD/SDfOwtys7zYxHuAW2/ncJws2Vcxn2M74hjvzjliMXWqrZOOQ30S0jL7+v
	 8XxfDoKqc7MGwf86w9HaXQPV+esd76bULbqZLhFgQCOFfDohv9sp+wFKE3JjFAG5dV
	 L1/V+AthhiWM3EcIVC77Ztnzl5YBIKhsnYCZMxn0J1hW3rqN5ksP/UP7cfE3CMSd8o
	 F+4wRByUI9UGBQFL38dm7JaGuh9YQLXUSpvvsfFuFmY829AMShfJODAL7MWP41UXE8
	 OySODJBIw1dxTBuRtmpBA1PiWA1NOuLTQEitQQsXc1g9G4vmciWoxMlHgo8xXVMEQT
	 sGqoaWiHlGMLw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD2vLepD2839398
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 10:57:21 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:22 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 10:57:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH rtw-next 05/14] wifi: rtw89: mac: remove undefined bit B_BE_PPDU_MAC_INFO
Date: Thu, 13 Nov 2025 10:56:11 +0800
Message-ID: <20251113025620.31086-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113025620.31086-1-pkshih@realtek.com>
References: <20251113025620.31086-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The bit is defined during test chip development, but formal chips don't
have this. Remove it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 2 +-
 drivers/net/wireless/realtek/rtw89/reg.h    | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index ef69672b6862..c3620db8aff6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2020,7 +2020,7 @@ int rtw89_mac_cfg_ppdu_status_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool enab
 	}
 
 	rtw89_write32_mask(rtwdev, R_BE_HW_PPDU_STATUS, B_BE_FWD_PPDU_STAT_MASK, 3);
-	rtw89_write32(rtwdev, reg, B_BE_PPDU_STAT_RPT_EN | B_BE_PPDU_MAC_INFO |
+	rtw89_write32(rtwdev, reg, B_BE_PPDU_STAT_RPT_EN |
 				   B_BE_APP_RX_CNT_RPT | B_BE_APP_PLCP_HDR_RPT |
 				   B_BE_PPDU_STAT_RPT_CRC32 | B_BE_PPDU_STAT_RPT_DMA);
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ed1d958bc49e..152fd8366dd7 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7476,7 +7476,6 @@
 #define B_BE_PPDU_STAT_RPT_ADDR BIT(4)
 #define B_BE_APP_PLCP_HDR_RPT BIT(3)
 #define B_BE_APP_RX_CNT_RPT BIT(2)
-#define B_BE_PPDU_MAC_INFO BIT(1)
 #define B_BE_PPDU_STAT_RPT_EN BIT(0)
 
 #define R_BE_RX_SR_CTRL 0x1144A
-- 
2.25.1


