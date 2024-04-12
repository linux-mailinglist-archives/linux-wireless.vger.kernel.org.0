Return-Path: <linux-wireless+bounces-6245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BF28A2DDA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 13:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C774B223B3
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 11:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C4055E4A;
	Fri, 12 Apr 2024 11:59:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293793FE55
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923156; cv=none; b=oIlwxhtf0Anq6B73yKGNd0AJ9ziX40FPRzdc50DgWMHhVThfcFPR5PSoWYYsygjVuASz4BLpyz039fcAe1q0o1CJ5YFbzRlhL7IGiXb7Wzed8e/ZWXCpLR9TD8dv2jtjX3FdAgAIqgGrmM5LoMoHGru5xzsypRgBzdvoE6VXGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923156; c=relaxed/simple;
	bh=p3rz9rtBqn7WVacguocwRgAj6Vd2V2ZMpfAbFmjYLAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekcYmwxXYYLXt/5PajpdMA1NIuCAnpFL47GS1Ij75Zt3QbETReKQHBBicsEGIsK9mgnWgmBEUm4k/6bNzwDh+BDJj/SMDvyrBhzSmNNsn1Zm+AKQ0kEtZuvBj/HGAr+j6m0tcq7yjU8lQOg6VKGSpzhAdfOt2rlCfeBPT0MLeU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43CBxCoV52092961, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43CBxCoV52092961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 19:59:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 19:59:12 +0800
Received: from [127.0.1.1] (172.16.17.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Apr
 2024 19:59:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 1/8] wifi: rtw89: sar: correct TX power boundary for MAC domain
Date: Fri, 12 Apr 2024 19:57:22 +0800
Message-ID: <20240412115729.8316-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412115729.8316-1-pkshih@realtek.com>
References: <20240412115729.8316-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

TX power in MAC domain is signed 7 bits. (unit: based on txpwr_factor_mac)
The valid range should be [-64, 63].

While the original wrong bounds might not really be encountered, still make
them correct.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/sar.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
index bd7a657188d9..4ae081d2d3b4 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.h
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -7,8 +7,8 @@
 
 #include "core.h"
 
-#define RTW89_SAR_TXPWR_MAC_MAX S8_MAX
-#define RTW89_SAR_TXPWR_MAC_MIN S8_MIN
+#define RTW89_SAR_TXPWR_MAC_MAX 63
+#define RTW89_SAR_TXPWR_MAC_MIN -64
 
 struct rtw89_sar_handler {
 	const char *descr_sar_source;
-- 
2.25.1


