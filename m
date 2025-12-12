Return-Path: <linux-wireless+bounces-29696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8207DCB7BBE
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 04:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AC693005025
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 03:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711622512C8;
	Fri, 12 Dec 2025 03:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rzwEIRN3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23321E091
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 03:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509280; cv=none; b=fhAnL2s5M08Rujak/zoX9ffy+WJzR8cQdUSK56jwJ2jU07FhFQNPdcpvRu9uQH01qXuzwH9DB6sKz07/VgcyosJO9YUpNNsTq6X4lOE+2/lxWNX3xryDnXZqBuNn918e/d0Him+qDh4GdFsAZZKFr4/duSxA3DvEARJUGbghRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509280; c=relaxed/simple;
	bh=lDbhx/rz7tRV3/ITtZ7IiDrIYfk2GsAMqr9hdBD64XI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJZJFrMmqb2FdSZ+5O1pFYFL82DGF4ml0jRCYHXyaV2VxmGluDcPYl6Cz3h1dDsW5MOVspqlwvW1bqckRj75wArsJYH3x7UqOEvK0GBy8Qd1P9ZA/X/F7ehxYu72GFeIq6qljLlRXFHUW1t96L2x5NRS96rxSaVo1DHJ45mC7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rzwEIRN3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC3EaGZ23508822, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765509276; bh=r4OAP7wjMvGqWHi6q5hoGHiTSiECXKon/4rSyUchoC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rzwEIRN3QJ2hInxO8m5lTwfi6YkU9mVgJlPqXnwzD+Ow7e1Eg3AF79DIXRyvXlfqo
	 b8z48Rwi7z11kwvGt5O5LgMOSPobXOxJAowFoimF0fwcV+afCMOvS1ajt4aQP3wyTw
	 ZZeLeblvbBA2b45ArHP3HUXuHlougf+uCcQf7oUR1F8F7gEqDSYetKeQHPwe1eE7kf
	 RYY8ozarVsroLevlsL6JK3nl5spnLZ1IpMEVKwa2rCg0XIQDrVvJ1ldo9KIxFMoeVL
	 gaO6wszFodCoTU0TxTqqENICB8F6Ir4MhXdmowjQ/Bqz0jZwUr8VWkGWNX80aqcKJx
	 mEVh/0LIffWTw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC3EaGZ23508822
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 11:14:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 11:14:37 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 11:14:33 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 12 Dec 2025 11:14:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/12] wifi: rtw89: refine C2H reg event polling timeout for LPS
Date: Fri, 12 Dec 2025 11:13:00 +0800
Message-ID: <20251212031303.19882-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212031303.19882-1-pkshih@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chih-Kang Chang <gary.chang@realtek.com>

The each of C2H reg event have different polling timeout. Refine the
LPS C2H reg event polling timeout. Otherwise, during SER, the FW has
already crashed, the leave LPS check will wait until timeout expires,
causing the SER recovery to take too long.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 3 +++
 drivers/net/wireless/realtek/rtw89/fw.h | 1 +
 drivers/net/wireless/realtek/rtw89/ps.c | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4e51ffb5be21..fd49e651aeed 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7053,6 +7053,9 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 	else
 		timeout = RTW89_C2H_TIMEOUT;
 
+	if (info->timeout)
+		timeout = info->timeout;
+
 	ret = read_poll_timeout_atomic(rtw89_read8, val, val, 1,
 				       timeout, false, rtwdev,
 				       chip->c2h_ctrl_reg);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index cedb4a47a769..dfae652686cd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -120,6 +120,7 @@ struct rtw89_h2creg_sch_tx_en {
 struct rtw89_mac_c2h_info {
 	u8 id;
 	u8 content_len;
+	u32 timeout;
 	union {
 		u32 c2hreg[RTW89_C2HREG_MAX];
 		struct rtw89_c2hreg_hdr hdr;
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 3f69dd4361c3..abd8aee02b47 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -16,7 +16,7 @@
 
 static int rtw89_fw_receive_lps_h2c_check(struct rtw89_dev *rtwdev, u8 macid)
 {
-	struct rtw89_mac_c2h_info c2h_info = {};
+	struct rtw89_mac_c2h_info c2h_info = {.timeout = 5000};
 	u16 c2hreg_macid;
 	u32 c2hreg_ret;
 	int ret;
-- 
2.25.1


