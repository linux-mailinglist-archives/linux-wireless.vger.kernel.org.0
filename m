Return-Path: <linux-wireless+bounces-17206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6547A06A6E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 02:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C835216681A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 01:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4D8BEC;
	Thu,  9 Jan 2025 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jr8q4LmH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C15E17BA1;
	Thu,  9 Jan 2025 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736387474; cv=none; b=tn5h9mBPAtZHy9LYwd7NSjuJBnkC+MaMGXzDaR57zuFvMRMxX8ykxsIAN0lxc8sTSruJvEGXnAVWsSWnOOS6qKdPS9sBrRc2KPfS0kwPZSjswV0RjMIOgXL5gCSVEIEMRF5UVn/pCVZ6+5wFVwr+gxq3oNHc5M/L1lr3zNs1j2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736387474; c=relaxed/simple;
	bh=Vny1YKVKvHvmEkjsNQnh66wwszro31tMzIvE4PlL51k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bsxJBgJC9yQohOeHdRk0SRSJBI+L0QAqafl06uSJKuo8XeqauFLOxqjs2X06YOpSQqL7F6Duttrw7HBG7L7t65bhWHmRaLY7ADKNaLDnrneVe/7ygnO3gmbV9FLBwMPPXmuiTQ1ZwMZNUTtAzqW4x8X+CfcGdjEWMTzovKhwc1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jr8q4LmH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BtiTF
	KCFSQA031LB/g8P11O/vwolgTQgBUAf430Dqks=; b=jr8q4LmHUIdGt2D618Z2u
	CHFccZbdJvGhlmJ/S+3PU6jopsgDW6j/l/0xRsj9HBsKN45JrgQv/PYBy5rYcHhX
	10Bfr33e+K+i+X1cFlA/H38gvsP33zrH4HXBdyS6fwfi/Lj6JGdsWD2Tk6yXcvfb
	/MmETVH0U675pnbSBy0fcM=
Received: from hello.company.local (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBHeeVqK39n_IqODg--.53002S2;
	Thu, 09 Jan 2025 09:50:35 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	phhuang@realtek.com,
	fanggeng@lixiang.com,
	yangchen11@lixiang.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>
Subject: [PATCH v2] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
Date: Thu,  9 Jan 2025 09:50:32 +0800
Message-Id: <20250109015032.1070045-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBHeeVqK39n_IqODg--.53002S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4xZw4rWr1xXFWftrWkWFg_yoW5Xr45pF
	W8J3WrGrn5Gr13Ww47Zws7ZFZ8Ja1kKr4jyrWqk395Zw15XF1SyFyDKFyYvryjvrWkZFy5
	ZF1jvr15GasxWaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul_MfUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbioAzPIGd-JiZv7QAAsZ

From: Liang Jie <liangjie@lixiang.com>

Ensures the correct calculation of `cfg_len` prior to the allocation of
the skb in the `rtw89_fw_h2c_scan_offload_be` function, particularly when
the `SCAN_OFFLOAD_BE_V0` firmware feature is enabled. It addresses an
issue where an incorrect skb size might be allocated due to a delayed
setting of `cfg_len`, potentially leading to memory inefficiencies.

By moving the conditional check and assignment of `cfg_len` before skb
allocation, the patch guarantees that `len`, which depends on `cfg_len`,
is accurately computed, ensuring proper skb size and preventing any
unnecessary memory reservation for firmware operations not supporting
beyond the `w8` member of the command data structure.

This correction helps to optimize memory usage and maintain consistent
behavior across different firmware versions.

Fixes: 6ca6b918f280 ("wifi: rtw89: 8922a: Add new fields for scan offload H2C command")
Signed-off-by: Liang Jie <liangjie@lixiang.com>
---

Changes in v2:
- Standardized the format of the commit log.
- Optimized the handling logic for cfg_len.
- Link to v1: https://lore.kernel.org/linux-wireless/20250109012356.1015198-1-buaajxlj@163.com/

 drivers/net/wireless/realtek/rtw89/fw.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2191c037d72e..2be1bee724ca 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5170,6 +5170,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	u8 opch_size = sizeof(*opch) * option->num_opch;
 	u8 probe_id[NUM_NL80211_BANDS];
 	u8 cfg_len = sizeof(*h2c);
+	u8 ver = U8_MAX;
 	unsigned int cond;
 	void *ptr;
 	int ret;
@@ -5178,6 +5179,11 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 
 	rtw89_scan_get_6g_disabled_chan(rtwdev, option);
 
+	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw)) {
+		cfg_len = offsetofend(typeof(*h2c), w8);
+		ver = 0;
+	}
+
 	len = cfg_len + macc_role_size + opch_size;
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -5246,10 +5252,8 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 					   RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_6GHZ);
 	}
 
-	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw)) {
-		cfg_len = offsetofend(typeof(*h2c), w8);
+	if (ver == 0)
 		goto flex_member;
-	}
 
 	h2c->w9 = le32_encode_bits(sizeof(*h2c) / sizeof(h2c->w0),
 				   RTW89_H2C_SCANOFLD_BE_W9_SIZE_CFG) |
-- 
2.25.1


