Return-Path: <linux-wireless+bounces-30953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3C6D3A6FE
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 12:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEFBA30581FE
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B203128CA;
	Mon, 19 Jan 2026 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="VmA/Kzg9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A023EA94;
	Mon, 19 Jan 2026 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768822625; cv=none; b=uOX+yPpx04VwBk9rbKn1UOL9wL9spynRSvJ/FTNR3OCzqXHzgG/D3dBdT3lHsIJNf98qJerYPzKhwDqVON3JC4k3TPHTbbNCyV5lZCwh44tVqItHVRhttcg/ss8fp7HfpU7Iy0heZp8DvX0TQSA4Ec/OtFqnACyGz7GnVRLpm4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768822625; c=relaxed/simple;
	bh=p/T6ah1eGdcRY1k71f4XxfnYZEvlcwWGnDLchs96p0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YsCbb8BZAiSYRcokJoNXNFKXAYHLEiRs8DP7y3nhqC3hEcmRV00BUKrHj5kgsdLHPwREO83dSFlMb8drVTUxuGMnoeZ1+WCs8ye1PRcQLSPoMRHsjSIChyfz71FIOguUdrJU8ut7HuHBYO3H/8+8S2DPBsGHu/coTYlt/O6pn/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=VmA/Kzg9; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31281983f;
	Mon, 19 Jan 2026 19:31:48 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: chunkeey@googlemail.com
Cc: johannes.berg@intel.com,
	quic_rdevanat@quicinc.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] wifi: p54: Fix memory leak in p54_beacon_update()
Date: Mon, 19 Jan 2026 11:31:45 +0000
Message-Id: <20260119113145.1433315-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd6067c3f03a1kunm434330ac1b48b6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0kYVk5LHh5JTElCT0hPT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VmA/Kzg9BuWupQX/n56853A+XiROBJTkpANwQ2YLCg3RtKQXPYGuR3DvPDWXekxZJaw2GIEBvZd/hTy6tppUiVpPLuTPAfMKo8WUgMiMS3pRpJ76Zais4zSTZOav8H/KbqoF2viK/h/PKiBV8mucSGkXpQbFUf+m0iOU6GfMUVg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=53tL9ZWFTwbeAzf/8P+65IpatcAokVrvM7G2LLIPHZI=;
	h=date:mime-version:subject:message-id:from;

In p54_beacon_update(), beacon is allocated via ieee80211_beacon_get().
If p54_beacon_format_ie_tim() fails, the function returns immediately
without freeing the allocated beacon skb, leading to a memory leak.

Since no other references to this memory exist, it must be freed locally
before returning the error. Fix this by freeing the buffer using
dev_kfree_skb_any() in the error path.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 0ac0d6cedf61 ("p54: Move mac80211 glue code")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/wireless/intersil/p54/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index 2ec3655f1a9c..57a62108cbc3 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+++ b/drivers/net/wireless/intersil/p54/main.c
@@ -143,8 +143,10 @@ static int p54_beacon_update(struct p54_common *priv,
 	if (!beacon)
 		return -ENOMEM;
 	ret = p54_beacon_format_ie_tim(beacon);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb_any(beacon);
 		return ret;
+	}
 
 	/*
 	 * During operation, the firmware takes care of beaconing.
-- 
2.34.1


