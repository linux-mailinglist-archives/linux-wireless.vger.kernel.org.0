Return-Path: <linux-wireless+bounces-17209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8458FA06AE7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 03:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4396B1887999
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 02:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306BE22339;
	Thu,  9 Jan 2025 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pz5RHZAd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C3BE5E;
	Thu,  9 Jan 2025 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736389616; cv=none; b=nydi1o/7cCXsZ5Pebq6dE6c4Q7AlokmaFQvR/hae5q7OuIssaEtDpAavP98GTHfNuuFa2D3T8Ie3XKm3K0zTeMMZ1nkXomSLc85ol0XO8ZcHtFeQa6ZReqNnmqBbR9GA2qj1Io0NeuRFZMhNUrDtzV5OH9N8HSnDYwYX3IawzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736389616; c=relaxed/simple;
	bh=XPmDOvfLNVDCTCK52xkSzs6ziSDS7bNJhAFfZdE9h4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g39dpRZm6yxvXvQsu9LS+ZIWXCLECRGJmecDjXpcjsdtuNQ4FN2jhfeqcJBmMY0P0R868T3BKPy5cePUxCi1rceVz/yQWDBChCUfPfy1ThAXcfkqSuEJOc0Agt98stumX1tPDgKL/ynvKHMy+YveDiJcWFLifaJpZyrZrLuylD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pz5RHZAd; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XTfl0
	GAV9D7ZHdj9FdFO2FA+oG1aIDeiLociirNWYGg=; b=pz5RHZAdAJhvLoEGmiKhp
	7B7abeAGuVmcNgikNjyrDsZG0w4QeUtSSSey2lo3obpAWWtpgWkaOs+S5GyJtB+M
	r5hpsiKdx2ZtmEYh63/fm/iYBs5KCLB0xuIcruN9bjx9TIhukcLJ5a6e0i+PTSMW
	dorj68FsLaEoRaGBWXUTWo=
Received: from hello.company.local (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDHzxS8M39nB5uRDg--.60405S2;
	Thu, 09 Jan 2025 10:26:05 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	phhuang@realtek.com,
	fanggeng@lixiang.com,
	yangchen11@lixiang.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>
Subject: [PATCH v3] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
Date: Thu,  9 Jan 2025 10:25:57 +0800
Message-Id: <20250109022557.1143215-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDHzxS8M39nB5uRDg--.60405S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4xZw4rWr1xXFWftrWkWFg_yoW5Wr18pF
	W8J3WrWrn5Gr13Ga17Zw4xZFZ5Ja1kGr12krWqk395Zr45XF1SyF9rKFWYvryYvrWkZFyr
	XF1jvr13GasxW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul_MfUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbBZw-PIGd-LrF3nAAAsr

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

Changes in v3:
- Resolved "reverse X'mas tree" issue.
- Link to v2: https://lore.kernel.org/all/20250109021148.1114317-1-buaajxlj@163.com/

Changes in v2:
- Standardized the format of the commit log.
- Optimized the handling logic for cfg_len.
- Link to v1: https://lore.kernel.org/linux-wireless/20250109012356.1015198-1-buaajxlj@163.com/

 drivers/net/wireless/realtek/rtw89/fw.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2191c037d72e..429f63c19e32 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5171,6 +5171,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	u8 probe_id[NUM_NL80211_BANDS];
 	u8 cfg_len = sizeof(*h2c);
 	unsigned int cond;
+	u8 ver = U8_MAX;
 	void *ptr;
 	int ret;
 	u32 len;
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


