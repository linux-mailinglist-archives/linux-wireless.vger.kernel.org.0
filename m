Return-Path: <linux-wireless+bounces-30908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5DCD31957
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 14:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D27303096224
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C70019C566;
	Fri, 16 Jan 2026 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="TgAp9vmG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E8238C07;
	Fri, 16 Jan 2026 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568944; cv=none; b=IHKbYOUz9rKyQpFXPOp7wQ/SS2qvmgli0W+ALSkHxkC1C0/3xoSlLpLttuN31r++CUXIbHEMe8h8gen96wLoUrNduXs6yYslrJuS/dA0dPo8cjxmGGfrPZA5b4j5IdocGZ8Naowr4zXi3ToyoblSQQjWAgbX4M+HKC3OFicohUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568944; c=relaxed/simple;
	bh=xv00CCATSmTeXaIYkkdJ6zDj7eI291a/+G08Objxinc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WeZPXvjLzKrtKrnPCCnI4Lz5/xWHPFxxhJDBdQsQ7pMt1gMDya9do95mVhc+HzQRYxw8nt17ti7l/uXPW2CE3ZvDrvWe9UlPh1jVIPUNo9bqRETLceU4fmDCQASCUPpRqjWcNebguozZc64rIq1hMwOvNGfJWDr+uK1hWOl6LZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=TgAp9vmG; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30ede1889;
	Fri, 16 Jan 2026 21:08:57 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: pkshih@realtek.com
Cc: kevin_yang@realtek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2] wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()
Date: Fri, 16 Jan 2026 13:08:34 +0000
Message-Id: <20260116130834.1413924-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc6ec5c9303a1kunmb8fb1a691170f6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSE0eVh0dSU1MTUlKQkgaSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TgAp9vmG5lxtrfEr/YS3IdLvOcbqxCcQ/dXSy7TYpK77s/R1ZpPdYDEfgTJSRjM5LBEgzmLO/2cF3y52nsOq6cxV5xSjjCnlUHqPc1novFjOvtWLrUVgsaGQ/mRcgfY2851FYH2XguQWLB3Q2RU+JTstjm29anX8hpSYchI6MHk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=5afngJ/kZr7NpXiZyOx0eaTqnKmcBTTiI7s0Jrz2E+E=;
	h=date:mime-version:subject:message-id:from;

In __print_txpwr_map(), memory is allocated to bufp via vzalloc().
If max_valid_addr is 0, the function returns -EOPNOTSUPP immediately
without freeing bufp, leading to a memory leak.

Since the validation of max_valid_addr does not depend on the allocated
memory, fix this by moving the vzalloc() call after the check.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 036042e15770 ("wifi: rtw89: debug: txpwr table supports Wi-Fi 7 chips")
Suggested-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v2:
- Move memory allocation after validation check to avoid leak.

 drivers/net/wireless/realtek/rtw89/debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 1264c2f82600..987eef8170f2 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -825,10 +825,6 @@ static ssize_t __print_txpwr_map(struct rtw89_dev *rtwdev, char *buf, size_t buf
 	s8 *bufp, tmp;
 	int ret;
 
-	bufp = vzalloc(map->addr_to - map->addr_from + 4);
-	if (!bufp)
-		return -ENOMEM;
-
 	if (path_num == 1)
 		max_valid_addr = map->addr_to_1ss;
 	else
@@ -837,6 +833,10 @@ static ssize_t __print_txpwr_map(struct rtw89_dev *rtwdev, char *buf, size_t buf
 	if (max_valid_addr == 0)
 		return -EOPNOTSUPP;
 
+	bufp = vzalloc(map->addr_to - map->addr_from + 4);
+	if (!bufp)
+		return -ENOMEM;
+
 	for (addr = map->addr_from; addr <= max_valid_addr; addr += 4) {
 		ret = rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, addr, &val);
 		if (ret)
-- 
2.34.1


