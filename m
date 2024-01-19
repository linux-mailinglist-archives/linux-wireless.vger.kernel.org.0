Return-Path: <linux-wireless+bounces-2232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFA5832587
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86134B224F8
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9684DDAE;
	Fri, 19 Jan 2024 08:16:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558D2D61E
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652167; cv=none; b=luER/TOA7lna0dYKggSo5pZtE4F5GG4SNAwShmIIcbeR0hxt+8XF5nzaR+q2FxVzrQYjfItTbimy21FDpDVAsqYlweV6TT8zUgB4I/T+07eY1g0aUgTjhJnZ/f9hhaSQ5D3oW80vPBYOf8rGk2oysXd6wKaj99igd5QzSjc7MP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652167; c=relaxed/simple;
	bh=UuLoHeP3J32ll8ZmqvYSQhdQcmgLnErGtadG4dUBfiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nu3kWhkZllMvWpppIjzGCK5XT+XLDUDhCkucF30TwnIU6tTEKvPywKpb1kI+08ovxvUZqb5YEFFICILw0U5axNaisHHzvQd6NmV86qAOcH6cjnB/ZSLp+eKnK/OSdxkVTCIujULPGYP/SqD52cm9kmQLUfXcK4uUEbX0YbG8TUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40J8Fx7622212502, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40J8Fx7622212502
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 16:15:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 19 Jan 2024 16:16:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jan
 2024 16:15:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] wifi: rtw89: fix disabling concurrent mode TX hang issue
Date: Fri, 19 Jan 2024 16:15:01 +0800
Message-ID: <20240119081501.25223-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119081501.25223-1-pkshih@realtek.com>
References: <20240119081501.25223-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

When disabling concurrent mode and switching to a single interface, the
TX might stuck. The reason is TBTT prohibit area circuit still enable
to block TX. To disable tbtt prohibit area circuit need to delay 2ms to
make it effective. However, we only delay 2us in original code. So we
fix it.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b224d06e5f3c..eb94e832e154 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4072,7 +4072,7 @@ static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvi
 
 	rtw89_write32_clr(rtwdev, R_AX_BCN_DROP_ALL0, BIT(rtwvif->port));
 	rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_TBTT_PROHIB_EN);
-	fsleep(2);
+	fsleep(2000);
 }
 
 #define BCN_INTERVAL 100
-- 
2.25.1


