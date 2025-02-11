Return-Path: <linux-wireless+bounces-18744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E26FA304C3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 08:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23423A8070
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEDE1EF08D;
	Tue, 11 Feb 2025 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="N7ApL+yV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2051EEA51
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260020; cv=none; b=oUZOTtuzj8sw44kymwRV+XGJxA8ykl2EOMAEd2uLeVn413ZQ0kvYYfN6pJht6sm/aafl2AktyYtqo2q17Y7fb8Svi61shzpLzU5rS1epQoP8E2j8HVyLpoG1XLFAiAIjxrAT5p3xrxBeC3RC3JI0W+DAA9/AwvoZftwYXUEYNi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260020; c=relaxed/simple;
	bh=IKp9qAtAQx/xuSOeDDkOcfz8vZ8JHnZmeMKaORV2iBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRcJzXFReg56OHh132de+XJp3Xq0xuJJqOc9nHBw+GfESfXfLY/fq6+e90/ThYC0rVBDzpKvjeRaOhj+JlVvdmEkLjsK1anoMymVajcVsP36aQrPH3IMbfjzlHOg4zL3Og1ktRlhBIZxWc9CuIRtUMzYMl+nA3Uy/ApgDROmYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=N7ApL+yV; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id EE3E3652BA
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 10:41:28 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:8f4f:0:640:c72e:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id EFB4A60091;
	Tue, 11 Feb 2025 10:41:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JfIL4w0Oga60-NY8sBPZ5;
	Tue, 11 Feb 2025 10:41:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1739259680; bh=+bDhnz8eDj/ZR0qwqiriagvCdZpqjSH5XemtcULhTik=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=N7ApL+yVWHwHrf+NLLdLhPtlyq6ACxyofPowlKaXDiByh4TjZkxEqfvG6A5ldVDW6
	 nltaYioVKqAOjCvApcghNnrHc7/o/nKzGQgG2AqHTvIsF7DsDtDyfmbAKRkMtJxbxE
	 VaWk2TcHvYSfE1Ce0JD9p6vTlqAfPaC8JzEz1r1g=
Authentication-Results: mail-nwsmtp-smtp-production-main-47.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: rtw89: simplify rtw89_debug_priv_mac_reg_dump_select()
Date: Tue, 11 Feb 2025 10:39:14 +0300
Message-ID: <20250211073915.648418-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify 'rtw89_debug_priv_mac_reg_dump_select()' by using
the convenient 'kstrtoint_from_user()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 09fa977a6e6d..339f9f6672fd 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -924,17 +924,10 @@ rtw89_debug_priv_mac_reg_dump_select(struct file *filp,
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	char buf[32];
-	size_t buf_size;
 	int sel;
 	int ret;
 
-	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	ret = kstrtoint(buf, 0, &sel);
+	ret = kstrtoint_from_user(user_buf, count, 0, &sel);
 	if (ret)
 		return ret;
 
-- 
2.48.1


