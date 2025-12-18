Return-Path: <linux-wireless+bounces-29890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC7CCA7CD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 07:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCA2530A09BF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 06:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5903271FE;
	Thu, 18 Dec 2025 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aCt1elb9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAACA327BFE
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039550; cv=none; b=gBLeTmLKPomeCN1S/1cTrs6J1NY11b9xTqMBUo+zEAr7kBBu4kmbojRVComaRCzx0bBGBzSmGaH2Xqh+2U9BXmUOFGMY6cwHXqpDHYKbCKtTOlMg106B2xpRXdhire9MVCA2ojblLKPU83Ln/s4YMQZvfWLlAf4d1hsMik4BuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039550; c=relaxed/simple;
	bh=lDbhx/rz7tRV3/ITtZ7IiDrIYfk2GsAMqr9hdBD64XI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULjV49r9ERFSG80NK5udHUMqIxju+grc0YWNTK33rwRN9Bp6fzEqBkjLRvcL7jXJVNquHKbA5d6w4S0RyaJz/bqhIAJBTMFpSurrRixExWEoYPBrzyM9P+O10Q1//DW+JXd9Qj8OD3n7vJcM4hxp2T6if3HHqRBMr0W8Sj7I46Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aCt1elb9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BI6WP8203338865, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766039545; bh=r4OAP7wjMvGqWHi6q5hoGHiTSiECXKon/4rSyUchoC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aCt1elb9zrgSfFAdf1hRaCuOLhSEChhAkn3Hi1B4t/zkxLUZy71fKCSpZzq5BMXlr
	 eymG1VN5zb/ZFDBbjiyt7IKsBOhALpVJYsyUY0+wundg1PI5Vthu1EjhXaInyKSqP0
	 oawPzCfribqCqeYaQP+BbEg+eIvguSTy7iRUbrWuXU6MJ8uQmnFxGE2rUrfb3Q7jxE
	 LCJbQjN1Uaqc71xfxOaomvIZRxBnBrlFf0vuZqbODqYPJZSxqMbouZxznU1gFMMX1F
	 oZy+IOb6+eZ8bp1KhagwnaWrLgw4wZqKbN3w8StoPwP2nh+tYmMr5KqkTMWmJ+hmKE
	 f9Q5I7ZCe4Z5A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BI6WP8203338865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 14:32:25 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:32:25 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Dec 2025 14:32:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 09/12] wifi: rtw89: refine C2H reg event polling timeout for LPS
Date: Thu, 18 Dec 2025 14:31:14 +0800
Message-ID: <20251218063117.26278-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251218063117.26278-1-pkshih@realtek.com>
References: <20251218063117.26278-1-pkshih@realtek.com>
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


