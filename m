Return-Path: <linux-wireless+bounces-30899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D931FD2D80D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 08:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B563A303DD13
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 07:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092682D640D;
	Fri, 16 Jan 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="RTKjgr6s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD82848B2;
	Fri, 16 Jan 2026 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549732; cv=none; b=VhUWrOOVJPEEcwN2OYeRUIvuHohRk5nwUchF8Il3h4WSrEWltT9QCy9xlpAwtqNJdoXjaCa85JGOuHKu4S8nhAG4qKo1f6+1z3ASITKA/LnwOOrwWQJ7yJjE8GHZpCuV+wMLPtbt5quG6SIwdrzPrJCqpKfatngy74JdO/2OCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549732; c=relaxed/simple;
	bh=SXmSKLaZilz/ABCbnvyR0NanPtN+T7HjKbENbNLq7Lo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZMJ3+TBwjzGSyIJew+CzxecYIyre0I26Qu+kh7fHo0tgu2WEoxeJgeKpsjstLHOHuRHVFzUVLeo7yVbfkevh8ZG1h/gvN1hkmtrTchhezz+kSnKoMFErRrWRhIg8yFx6SKaqqwIpzELjkk+B9XU3trco3jMzGbL4/UFy1ht1pJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=RTKjgr6s; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.215.202.202])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30e3f2910;
	Fri, 16 Jan 2026 15:48:38 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: pkshih@realtek.com
Cc: jianhao.xu@seu.edu.cn,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()
Date: Fri, 16 Jan 2026 07:48:36 +0000
Message-Id: <20260116074836.1199951-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc5c7185403a1kunme606c84b1080ce
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTkJDVkxLTk8aTRgYGh1CSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJSk5VSUtJVUlLSVlXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=RTKjgr6scGjydf8sgtZqYvoOWCv/v8FtLa6yId6LyZASkpfZhgnF1zZLR3DcHyPUbEKPzqmQRWUkeRgtjsDNqH/NwwhNXElD07YWPiLfcYihvslRW1dk1Icb/WcDjqyzMxKmXhpS33Tf+06nsFNXf9PNq0kwby55q0gCQx8kCaY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=p3ZwP+y0SF0NQyKSa1HXam3emAoRLPF9aez90DrNUyI=;
	h=date:mime-version:subject:message-id:from;

In __print_txpwr_map(), memory is allocated to bufp via vzalloc().
If max_valid_addr is 0, the function returns -EOPNOTSUPP immediately
without freeing bufp, leading to a memory leak.

Fix this by freeing the temporary buffer bufp in the error path.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 036042e15770 ("wifi: rtw89: debug: txpwr table supports Wi-Fi 7 chips")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 1264c2f82600..c7bd1d0212b6 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -834,8 +834,10 @@ static ssize_t __print_txpwr_map(struct rtw89_dev *rtwdev, char *buf, size_t buf
 	else
 		max_valid_addr = map->addr_to;
 
-	if (max_valid_addr == 0)
+	if (max_valid_addr == 0) {
+		vfree(bufp);
 		return -EOPNOTSUPP;
+	}
 
 	for (addr = map->addr_from; addr <= max_valid_addr; addr += 4) {
 		ret = rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, addr, &val);
-- 
2.34.1


