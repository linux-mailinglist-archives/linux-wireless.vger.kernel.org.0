Return-Path: <linux-wireless+bounces-2522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7629583D48D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34671C246B7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8137E1D543;
	Fri, 26 Jan 2024 06:35:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55741D535
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250905; cv=none; b=S0Sd0SAtkTPWfIUsYHJP5iUSdL9fteyuYqW0vc17pEeTJUcCQaPtE5bGJOqR4QWTDjfIlFyb33FSdW5R50Cw46UVBf9r9/pQr+n4iGnFA+x58kQEmvY9fkDA7Uk/g5LniLG/Eo+HjNiRS+oK+cnTYRzOFg9ALvJ4LtB2rIoJ6o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250905; c=relaxed/simple;
	bh=/h05wAKiZa/KbxtYJdmpxJ1xS+hXs2yHcnFn9lWYky4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3daOMbXaU/T8JMdmefTaBkkZWPLzK+ekEQYcbKe9FSRnU+vpqlbMHAmQh/QIluvEgL0dvhyU0bsxET8K/cCGWfweX8MvQKA7PoHrHdecXqPf+Da86Hk/tAG/TUUd6y81alC/q/RGnEifSnANwcU/mbjxP4783khNE/y7Pw/dUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40Q6Yvr362085647, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40Q6Yvr362085647
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:34:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 26 Jan 2024 14:34:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 14:34:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: 8922a: add more fields to beacon H2C command to support multi-links
Date: Fri, 26 Jan 2024 14:33:56 +0800
Message-ID: <20240126063356.17857-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126063356.17857-1-pkshih@realtek.com>
References: <20240126063356.17857-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

To support multi-links beacon, it needs more fields. But currently we still
only support legacy AP mode. Only update struct to fit expected size of
firmware.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index c5c801e9ce3c..ae69e455cd64 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1730,6 +1730,24 @@ struct rtw89_h2c_bcn_upd_be {
 	__le32 w9;
 	__le32 w10;
 	__le32 w11;
+	__le32 w12;
+	__le32 w13;
+	__le32 w14;
+	__le32 w15;
+	__le32 w16;
+	__le32 w17;
+	__le32 w18;
+	__le32 w19;
+	__le32 w20;
+	__le32 w21;
+	__le32 w22;
+	__le32 w23;
+	__le32 w24;
+	__le32 w25;
+	__le32 w26;
+	__le32 w27;
+	__le32 w28;
+	__le32 w29;
 } __packed;
 
 #define RTW89_H2C_BCN_UPD_BE_W0_PORT GENMASK(7, 0)
-- 
2.25.1


