Return-Path: <linux-wireless+bounces-30949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03511D3A2E7
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 10:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE78F3029D2A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367B8354AD3;
	Mon, 19 Jan 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hy4rXcH0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9826CE3F;
	Mon, 19 Jan 2026 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814801; cv=none; b=E5ODLpA+ITmcp/lCZDonvWNWO/RH36ckUvHAiGefE6BK9niMDGmP1nENekx5/0tBNfnvcjCEs/oAmJ+jgFAkXaGlWWuKJ7rdCj9+Bp3L21Cgaz83penLDXDyQHeNb1irBmctRz99fZk+rb78hgBM0L0GiG+GnQ86Qg2tKmFRHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814801; c=relaxed/simple;
	bh=o0kuMU5juVWuKGYu/c3Cd1coripRch4ZvrzNU+cTuN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nNxjyLkdyTVyzvstwycaqFZhOFmQQDFfngMxfHZ9CHgipHUyfQ89LS6/6M6VE5Jnz7cuePBlN5Fbf1bJCChkthH2zUEuwMICeit7tqJJ/WaI8rkjTReczzNU27MPjRP/6vpULhjPtsMibeVNxftOkhKLWfGclMoDnOY9CQBhiw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hy4rXcH0; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3124dcc82;
	Mon, 19 Jan 2026 17:26:27 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: briannorris@chromium.org
Cc: francesco@dolcini.it,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] wireless: mwifiex: Fix memory leak in mwifiex_11n_aggregate_pkt()
Date: Mon, 19 Jan 2026 09:26:25 +0000
Message-Id: <20260119092625.1349934-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd593bb2103a1kunmc908799e1aed9e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSkxLVh0eSRpLH0xMHksYT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hy4rXcH0jrh80QMzh7sx185DA0rnYyXElbXCaH+N2E7F0ugy3DcdsPPxS2wdDiAoGjF23M5Y+ahAkVMOKu4n/NeIajUVJ4yZcPqmQ/0ZeSvM4TMIzJwFUJuiUeVnn7vFTJgWrrmUAxel+wEac9NCDwEOrRUKBKxXA/giK+5SKCo=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=8NdTvbfugYlWZFb8DzlWfrdyciwRnxl8b7jCszXhr04=;
	h=date:mime-version:subject:message-id:from;

In mwifiex_11n_aggregate_pkt(), skb_aggr is allocated via
mwifiex_alloc_dma_align_buf(). If mwifiex_is_ralist_valid() returns false,
the function currently returns -1 immediately without freeing the
previously allocated skb_aggr, causing a memory leak.

Since skb_aggr has not yet been queued via skb_queue_tail(), no other
references to this memory exist. Therefore, it has to be freed locally
before returning the error.

Fix this by calling mwifiex_write_data_complete() to free skb_aggr before
returning the error status.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/wireless/marvell/mwifiex/11n_aggr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_aggr.c b/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
index 34b4b34276d6..042b1fe5f0d6 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_aggr.c
@@ -203,6 +203,7 @@ mwifiex_11n_aggregate_pkt(struct mwifiex_private *priv,
 
 		if (!mwifiex_is_ralist_valid(priv, pra_list, ptrindex)) {
 			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+			mwifiex_write_data_complete(adapter, skb_aggr, 1, -1);
 			return -1;
 		}
 
-- 
2.34.1


