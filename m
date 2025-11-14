Return-Path: <linux-wireless+bounces-28952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A4CC5B761
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9F33BDD19
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD32DEA61;
	Fri, 14 Nov 2025 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OBp+4rkj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DDE2DC34D
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100155; cv=none; b=ds07F5KqzoEy9LFkFhUQxzMyTFoi/UKOhoT0Kkta2CGPWotgaVtcKTtL47hzG2XEDQPHLi8iwE8zSGfbjUaWNuRpHZGz1rGJYbLm8rH+lqnDU1FCsDLcRxUnLHNo43HpH4+GPNV2gKfERX6wAZYgxS5IT2m1eYLmoohGobEp0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100155; c=relaxed/simple;
	bh=wOmFDUtwXJXmNiyVugwkeeADXuQ4CFDE3c4RHCxsFE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwyaBRiSkoWmT5HilVrM3VkgkFy34+bvxto7spIdEBOTktInX5961w0kwm3ixjJGWqWyOUFg1HY81OwWBWlAeky8AKi5HLM/nMue6QGY5ebmQ3ARSwD2kIUB2CSsVuuNVmklTbGK2+J0f/jpKzlZ4UaoSpMc56HZ4RWAdXQJuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OBp+4rkj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE62V9301037625, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100151; bh=jrtDPHAKwj6Oxb2o6oa2IurHzBjabJSllw1yCaSPhZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=OBp+4rkj0vxEAOsXkBjArEFJWD4e/nWEXU9fGAcaQKnSm/6TUemKyOZBU9i1QaDOz
	 24ecy7Hawb0JM9iUy99wEClOjJV/02/99tE6G/HfP0HnsKbPQQoHKu0CHArcDGU17S
	 s4OeGczKWPo9hlWVz3xM3wKNC/QI8Ll+qv40oZNTlwDZlOTNmgA4+BEPLzte0HKzWV
	 zwJ6bDEfkTgCGVbiuKIh1E6wbqGzu2Ic0a4iH87LG79wCEiesoRB3JI0H/95frmgsO
	 zRCkIeEU/1myOKUdsUkLW5I4tcsIuZV/4ujD/VyN/fCpiNwaPLathDscBhRoNwtvu2
	 g+DWmRtTW8xyQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE62V9301037625
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:02:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:31 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:02:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 05/14] wifi: rtw89: mac: remove undefined bit B_BE_PPDU_MAC_INFO
Date: Fri, 14 Nov 2025 14:01:19 +0800
Message-ID: <20251114060128.35363-6-pkshih@realtek.com>
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

The bit is defined during test chip development, but formal chips don't
have this. Remove it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
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


