Return-Path: <linux-wireless+bounces-17384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC58A0A86C
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 11:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4C03A4A57
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 10:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1936C1A8F8E;
	Sun, 12 Jan 2025 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TSPJi6aG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39AC1A840D;
	Sun, 12 Jan 2025 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736679197; cv=none; b=SnhZEr/5Z4Z9MxepR4/uer+8kuumFF+B2FmBcVKXTXDTKiVy419umd2cjqaydWG8a0p9S999O6lIsCb+yDzJNzJc0WRRwuXVCkXqCveaGhK7lQVfaEbamjCFCNWaBWkDCjmtzxtvpwC/nqjNSVX2oE3DXDEyX3V0qrisz+KphmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736679197; c=relaxed/simple;
	bh=birV0m2TUYCxH3KwWA5B/e6Yhw24rOPaiRSP6FEaXr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KUhSCBD1IYf2cY9sBMDU5TY/oFwTNFk6v1eNC0BMlpk8azAktSfhnfglt45fOhaTQpwURuuv6bi7Mkr+rLJPBP9vyRcJByabud+h9fqDYJ4YuxpoU1eOyWk1ygUXYM/jBX4LaqQC3uViGXj2QsEI87wc5eGQcbzLbuHHxd6scWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TSPJi6aG; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Yv90L
	9yj0YdwWlTf+JeNOTMvl/SxjHh9t/iyEqBKgck=; b=TSPJi6aGUkF/ICT9SBL+f
	KmvK2wW/cr3XNnw1eD5hlknc4xTKnirGHQAXC+aU7vlpLrAfMauLMGcbHW6FDdb5
	LFt4OFyG3WUSzMQ1N/iUnkU74ulM44W2Qe5KzuMv6gNjZdr3ELpW8jTHqoUMAsED
	C7y4olnXURDuYTkNZgeo4E=
Received: from hello.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_83DnoNn2lc_Fg--.33526S2;
	Sun, 12 Jan 2025 18:51:48 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	phhuang@realtek.com,
	fanggeng@lixiang.com,
	yangchen11@lixiang.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>
Subject: [PATCH v4] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
Date: Sun, 12 Jan 2025 18:51:44 +0800
Message-Id: <20250112105144.615474-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_83DnoNn2lc_Fg--.33526S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4xZw4rWr1xXFWftrWkWFg_yoW5Zr1Dpa
	y8G3W8urn5Gr17Xr47Za1xZFZ5Ga1kGr1YkrWqk395Za1rXF1ayFyUKFWY9ryjvr4kZFy8
	XFyqvr13GasxWaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul_MfUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbBzw7SIGeDk+B+YAAAs6

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

Changes in v4:
- Rebase on the top of rtw tree(commit 4b6652b).
- Add scan_offload_ver used for SCAN_OFFLOAD_BE_V0 check.
- Link to v3: https://lore.kernel.org/all/20250109022557.1143215-1-buaajxlj@163.com/

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
index 5d4ad23cc..5cc9ab78c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5311,6 +5311,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	u8 macc_role_size = sizeof(*macc_role) * option->num_macc_role;
 	u8 opch_size = sizeof(*opch) * option->num_opch;
 	u8 probe_id[NUM_NL80211_BANDS];
+	u8 scan_offload_ver = U8_MAX;
 	u8 cfg_len = sizeof(*h2c);
 	unsigned int cond;
 	u8 ver = U8_MAX;
@@ -5321,6 +5322,11 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 
 	rtw89_scan_get_6g_disabled_chan(rtwdev, option);
 
+	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw)) {
+		cfg_len = offsetofend(typeof(*h2c), w8);
+		scan_offload_ver = 0;
+	}
+
 	len = cfg_len + macc_role_size + opch_size;
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -5392,10 +5398,8 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 					   RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_6GHZ);
 	}
 
-	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw)) {
-		cfg_len = offsetofend(typeof(*h2c), w8);
+	if (scan_offload_ver == 0)
 		goto flex_member;
-	}
 
 	h2c->w9 = le32_encode_bits(sizeof(*h2c) / sizeof(h2c->w0),
 				   RTW89_H2C_SCANOFLD_BE_W9_SIZE_CFG) |
-- 
2.34.1


