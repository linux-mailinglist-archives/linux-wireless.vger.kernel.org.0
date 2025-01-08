Return-Path: <linux-wireless+bounces-17192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4952A05818
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 11:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297BD1886D4B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 10:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2B41F3D3C;
	Wed,  8 Jan 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dVh44mKT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6467818B463;
	Wed,  8 Jan 2025 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331939; cv=none; b=ODIVBPrHEpaU/U/O9MOjhN8Ii4/aGtrn3pOnh8ulhq8vMWiaD8iOiLXC+Km7aCWSe8Y9CMdwPtEtfKvWjEUJS1pOv8HcAjmVhhl6EIBLw4llUufoFf+1jJnAGX9yt6j+WFFrZ9sYaGPKQmKBob7qnLryJMnSA/pl1u1Dmc9trgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331939; c=relaxed/simple;
	bh=6Rrm2FBFhUJVtb5cxlmW+QR5IW3y+5VjB9DlkBl/S3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BJYKibEfewnFpAt6f+SFpz996u/u3wq8jmShKuq+XllFxjEJ85OV5hmKKV8H3FxAMPf0wuNP8WUNEl6MqXo/8PDOJKe0l7lw5aIZwPshQGUjEc0Bwx+i7Fz/6JhPGDHWQpesN2CjaNRpH++6K0K8J74OBPC7qz8iZu9YQtkqWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dVh44mKT; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZqoKu
	HZMVEBBiT3kyfzHzJeM0FpcgUM9K7Q0ltaNBLI=; b=dVh44mKTztnwMZa1WmVrH
	OU6jq6TQiYiGYhsnf3pvKjb5M/hHipWJKju1QZgH1B/iNQNO1fXIDUKBD5gpwmSA
	kxIWd376UBGfsgUqe7pyKntGTv1urfDW/xw7MY4t/6E9P3Zo3tKJQnhdJFJ9ipoW
	cThJBktZnmbo80h5QZVcjY=
Received: from hello.company.local (unknown [111.205.82.7])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB3HtqKUn5nWp1iJw--.31579S2;
	Wed, 08 Jan 2025 18:25:15 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	phhuang@realtek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>
Subject: [PATCH] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
Date: Wed,  8 Jan 2025 18:25:12 +0800
Message-Id: <20250108102512.3477461-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgB3HtqKUn5nWp1iJw--.31579S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry3JFy5JF1kAF4xCr1rWFg_yoW5GFy7pF
	W8G3WrCrn5Jr13Xa13Zw4xuFW5G3WkGr1YkrWqk395Zwn5Xr1YyFyDKFyjv34Yvr1kZFy5
	ZFyjvr15W3sxWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPR6cUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbBZwTOIGd+SzaVZgAAsa

From: Liang Jie <liangjie@lixiang.com>

This patch ensures the correct calculation of `cfg_len` prior to the
allocation of the skb in the `rtw89_fw_h2c_scan_offload_be` function,
particularly when the `SCAN_OFFLOAD_BE_V0` firmware feature is enabled.
It addresses an issue where an incorrect skb size might be allocated
due to a delayed setting of `cfg_len`, potentially leading to memory
inefficiencies.

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
 drivers/net/wireless/realtek/rtw89/fw.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2191c037d72e..5eb4beb9e485 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5169,7 +5169,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	u8 macc_role_size = sizeof(*macc_role) * option->num_macc_role;
 	u8 opch_size = sizeof(*opch) * option->num_opch;
 	u8 probe_id[NUM_NL80211_BANDS];
-	u8 cfg_len = sizeof(*h2c);
+	u8 cfg_len;
 	unsigned int cond;
 	void *ptr;
 	int ret;
@@ -5178,6 +5178,11 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 
 	rtw89_scan_get_6g_disabled_chan(rtwdev, option);
 
+	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw))
+		cfg_len = offsetofend(typeof(*h2c), w8);
+	else
+		cfg_len = sizeof(*h2c);
+
 	len = cfg_len + macc_role_size + opch_size;
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -5246,10 +5251,8 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 					   RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_6GHZ);
 	}
 
-	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw)) {
-		cfg_len = offsetofend(typeof(*h2c), w8);
+	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw))
 		goto flex_member;
-	}
 
 	h2c->w9 = le32_encode_bits(sizeof(*h2c) / sizeof(h2c->w0),
 				   RTW89_H2C_SCANOFLD_BE_W9_SIZE_CFG) |
-- 
2.25.1


