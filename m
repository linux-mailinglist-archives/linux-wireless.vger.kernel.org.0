Return-Path: <linux-wireless+bounces-12264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A69E6966154
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504571F21061
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D639319992C;
	Fri, 30 Aug 2024 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MWzljtrn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357721917C8;
	Fri, 30 Aug 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019569; cv=none; b=mMyzeeeAg5Po5w95kBBsGJVrwy7jqrusmpj0SJxBgBNmVBmjN6ec2c8LRkOyy+kpK11GI9syWwi3tBMI1iDitb7+xcuOEikUWf+bmLyFeoWTGK8is5TFrVp9+LHnC0dUVeqQbJl3ct1/saix1ykHw1FTEkb6uQ2/bK9Na3YH8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019569; c=relaxed/simple;
	bh=vExsAHAoGllOr1t2tx2Hu9Hx8Zr9OFpwTAEbV5uIQKI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=KFGCua45jvSgJ6at0J1BrlyE07W0rat2eeTV+OUCuJlYs590Fpa0VntoaEsSRRmFh3Szf4Ah1oUNORq4FbMBFjBnRoFARIbm/Yn6JvX9YNlh7xJ+gfc9vGBJkCfej8Zjc7h1V4ErIfW4lgprysGQcykGboxlZdk2Cgt4Cz9LqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MWzljtrn; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1725019557;
	bh=OA1aR3D6P1yKqxLc97SjhIL90dq/6HD+PrvzA+JcrbM=;
	h=From:To:Cc:Subject:Date;
	b=MWzljtrnq74Ov4lDNkBlbDjH0kc+IdRrvSDrKHMpC/UHwJwVIvaJpeBYAWfopBS91
	 /BMpZCJ+MzKOa8dZjo/TaKUgIcoDPYXPqo4zQkOiKyReuH+saE7JTfyLQQmwY/OJeM
	 MYfQKVEkpI2hgQr2w7d+TYj9zQYKu4GYg8dSOGRc=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 9B9724D; Fri, 30 Aug 2024 20:02:27 +0800
X-QQ-mid: xmsmtpt1725019347t06pasczv
Message-ID: <tencent_A64CA96B962349E369B349EA01EBC53C3505@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahN2F7hMEA1AVw+JUb7RBJt6sTjs23qCy/OS5FN4fOGKhiTx4KdQ
	 D/HZi7E1nEusnimX1P2/8k+Iy9G6z1dD4iTIDMtCCN6aHgXGwUFTQ8h1Wn9aB1zsY9+TNABMdVxo
	 hPjy2LfueW00uXt2E8iRr0wbOayJ5VoWbhEXFqwJa4hHdparD3tlPlgvvFFhd1+vCl16Ss5st04P
	 tFHhUMPS27Iay60LoGHeoM2JyT4/JHdKNqcK1tueNLcxX3N7gkX6nYN32U3MSVN8vvrtWqNq+rr3
	 UzCOkyxGIxDJsqe2No5yd4GthrX7VXZsWqkK4dnX4NQRMTWbYDKGCN+D8A0WaqzBYgpV8B+a8AHy
	 C0+lhohDqukjNq521opqeX2yRaRY89KBJlda+U+n14DFty6SrHUa6uKOquSRAy0+ru2Dw+EdLGxu
	 tgFyG6BHEhzXWdq0fsZhVzS2Tlp/BrJaUE4A2MUaeyIjte1xhXN8YneNKpbuXz0E3lcPC8bbzKbr
	 gx585I2MAD2KvQGIv77trrQqHq+VNH+N01SbHsLKw5Q278JSivg4d2K6nigIk6tO0OnunRW3PopU
	 mEV2vq++QWfyx5OXlJFIPQC5J0XvL/oe2KyTZxe94RLYpaLIMsoueVDek4LNlDT3lTSg+F+BVbYX
	 b3zNum3vklVkwlJDEFs3bMzI51CNSjNyOj5hRz0gyukHw1lRv1rAgw4bbwzLaZRIRAzWkR3agmq9
	 EhJCWS8S6EJFbgvhHVnkHLTO7EW6gpyCi3bis/kyEZgzi4MUU3p0MTmQ/DoGQIum8ZeIHYfv7I28
	 ipTZ/ZZgJlnyUyF1+AipASAhbEaSJovXl+V0Q3xZmA5TPU8FhZ6VGRGQQokGxsAa95VqLtEfBzoL
	 vggH5WA65f4rMyRglkwinvFLBWbcv7d8bt8sE20cA8376QBO3mR5EmulFrTMUAF7HZXwfErQSboq
	 MJfsrvtKapFaF33B2TWB/k3fN6CdPlpir7OSdy2D9Kj5Nf09uUpWyoPUWS7TdE+SehLoZt7Y5Ttb
	 xgSltRo4UtXARiGDilj9e8W1f4E2DhcRjdpjvLlaebE1eubDuaa/awcioNQIo=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org,
	corbet@lwn.net
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ath11k: Fix potential RCU dereference issue in ath11k_debugfs_htt_ext_stats_handler
Date: Fri, 30 Aug 2024 12:02:27 +0000
X-OQ-MSGID: <20240830120227.1025690-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the `ath11k_debugfs_htt_ext_stats_handler` function, the `ar` pointer
obtained via RCU lock is accessed after the RCU read-side critical
section might be unlocked. According to RCU usage rules, this is illegal.
Reusing this pointer can lead to unpredictable behavior, including
accessing memory that has been updated or causing use-after-free issues.
The `ath12k_debugfs_htt_ext_stats_handler` function in the
`drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c` file provides a good
example to follow for addressing this issue.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

To address this issue, the RCU read lock is now kept until all accesses
to the `ar` pointer are completed. A `goto exit` statement is introduced
to ensure that the RCU read unlock is called appropriately, regardless of
the function's exit path.

Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
---
 drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index 870e86a31bf8..325377e00818 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -4572,15 +4572,14 @@ void ath11k_debugfs_htt_ext_stats_handler(struct ath11k_base *ab,
 	pdev_id = FIELD_GET(HTT_STATS_COOKIE_LSB, cookie);
 	rcu_read_lock();
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, pdev_id);
-	rcu_read_unlock();
 	if (!ar) {
 		ath11k_warn(ab, "failed to get ar for pdev_id %d\n", pdev_id);
-		return;
+		goto exit;
 	}
 
 	stats_req = ar->debug.htt_stats.stats_req;
 	if (!stats_req)
-		return;
+		goto exit;
 
 	spin_lock_bh(&ar->debug.htt_stats.lock);
 
@@ -4599,6 +4598,8 @@ void ath11k_debugfs_htt_ext_stats_handler(struct ath11k_base *ab,
 
 	if (send_completion)
 		complete(&stats_req->cmpln);
+exit:
+	rcu_read_unlock();
 }
 
 static ssize_t ath11k_read_htt_stats_type(struct file *file,
-- 
2.34.1


