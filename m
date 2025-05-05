Return-Path: <linux-wireless+bounces-22530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDE0AAA71F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4899D98670C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A46297B7A;
	Mon,  5 May 2025 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/QlIOkk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C16C297B75;
	Mon,  5 May 2025 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484540; cv=none; b=hBp7KpvkCVVosemaLIUPv5nTUrqByEuDstYFpo91MrRzdlBs1mv2PRowN71s6DGW4E7GZrq7JuJyQHuYD8outSY2nrtT6JrFbyb+jw8HQRqftwPYifcVwZ6XK860cdR21HKX0iSMi4PV0NfakLucqCoaIuunx29JkwxshfIOHeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484540; c=relaxed/simple;
	bh=A7YBZER4NVFjAJ7tvspLNKlg7zKWYHVFs/X4cwpDQ+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgPD/fL24kpxJSN8yvAgYEWBrtgmSs1Q8waKqYO6skqzK9sgZNqLd9fwYZqNaZ+my351AuRjVk6eCjZkCMQOqd0t28YAHuxH3i5RR//Ml+w/hEfDpr7Ek0INP1IGBiRIeKhgBZaUSE26/yowyey/mwyTjpvDmRAwfQwh93v/HZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/QlIOkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21078C4CEE4;
	Mon,  5 May 2025 22:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484539;
	bh=A7YBZER4NVFjAJ7tvspLNKlg7zKWYHVFs/X4cwpDQ+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/QlIOkkpgumvrXnms0b4oUGTqXzFU4d0JwCWWW6Z2d4KqIDMiQyDzoQSIYSFGE2L
	 ggXUQijEmPgk9IuZa0fwZzyaTBeIqp64qifmjVHmhJ5DDm90YWCSpZRgItU48X7tqb
	 0/IFjRvr+XaSVXXJhu3vnYXFOjErMdzBMrUaD1kvj8a+4njVyEwIAEB+obbnBmSOF2
	 +RKgEqLK3Qe4MUdT1xXhyqenAOHSQ8WJ4kDmmKm4Ud+YNt4Cz2CpvjzFW9Ci+UcIG5
	 1lR+wYAV8xqr1U2YgfKw/PjMMkK56cm6B7iwnxeeXcnyQ8H+5xWjKZ98qwsq4q1qk/
	 TsGLwN+vLXBzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 523/642] wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
Date: Mon,  5 May 2025 18:12:19 -0400
Message-Id: <20250505221419.2672473-523-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 8f0076726b66a70727a1bef5c087c60291e90ad8 ]

The existing code is suitable for chips with up to 2 spatial streams.
Inform the firmware about the rates it's allowed to use when
transmitting 3 spatial streams.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/08e2f328-1aab-4e50-93ac-c1e5dd9541ac@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/fw.c   | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h   |  1 +
 drivers/net/wireless/realtek/rtw88/main.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 02389b7c68768..6b563ac489a74 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -735,6 +735,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 {
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
 	bool disable_pt = true;
+	u32 mask_hi;
 
 	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
 
@@ -755,6 +756,20 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 	si->init_ra_lv = 0;
 
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+
+	if (rtwdev->chip->id != RTW_CHIP_TYPE_8814A)
+		return;
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO_HI);
+
+	mask_hi = si->ra_mask >> 32;
+
+	SET_RA_INFO_RA_MASK0(h2c_pkt, (mask_hi & 0xff));
+	SET_RA_INFO_RA_MASK1(h2c_pkt, (mask_hi & 0xff00) >> 8);
+	SET_RA_INFO_RA_MASK2(h2c_pkt, (mask_hi & 0xff0000) >> 16);
+	SET_RA_INFO_RA_MASK3(h2c_pkt, (mask_hi & 0xff000000) >> 24);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
 void rtw_fw_media_status_report(struct rtw_dev *rtwdev, u8 mac_id, bool connect)
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 404de1b0c407b..48ad9ceab6ea1 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -557,6 +557,7 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_DEFAULT_PORT		0x2c
 #define H2C_CMD_RA_INFO			0x40
 #define H2C_CMD_RSSI_MONITOR		0x42
+#define H2C_CMD_RA_INFO_HI		0x46
 #define H2C_CMD_BCN_FILTER_OFFLOAD_P0	0x56
 #define H2C_CMD_BCN_FILTER_OFFLOAD_P1	0x57
 #define H2C_CMD_WL_PHY_INFO		0x58
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 62cd4c5263019..a61ea853f98d9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -191,6 +191,7 @@ enum rtw_chip_type {
 	RTW_CHIP_TYPE_8703B,
 	RTW_CHIP_TYPE_8821A,
 	RTW_CHIP_TYPE_8812A,
+	RTW_CHIP_TYPE_8814A,
 };
 
 enum rtw_tx_queue_type {
-- 
2.39.5


