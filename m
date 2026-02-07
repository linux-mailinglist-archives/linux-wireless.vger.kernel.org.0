Return-Path: <linux-wireless+bounces-31632-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDN6AvP2hmkvSgQAu9opvQ
	(envelope-from <linux-wireless+bounces-31632-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Feb 2026 09:25:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBA910539F
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Feb 2026 09:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2ED593006231
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Feb 2026 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF42FD7BE;
	Sat,  7 Feb 2026 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQEWHiaU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC52E6CB3
	for <linux-wireless@vger.kernel.org>; Sat,  7 Feb 2026 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770452708; cv=none; b=Keei7KoLP9VBDWasrNnF5glRU3uy8oF3BBd372dS8t7OVN9NRAmSYBK0OscyBbKF9WIQp5sTZpwkYsL61/dS4LyKVhhmCFs3m9SB4FtQCn8Ew18FtEdrhzWn4UmFdhxN9MQwgyOAJ7dYA6s+vwFb6N+NNg3gTEs9U0cFLrEQic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770452708; c=relaxed/simple;
	bh=8mHbMVQTEBdkgJH1+s9Q9dyxHjqjtcqt2kenf65/lo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpQdboVfvV9sChJ17gfhaz44fUOLTFmrMGkOQFw6KRLvidLXHXCK5Zx+aBJ1XklCeM3k9MyEmsjkWhwjKgPWGaJ3Br30aoRoqZ3eXBQOt7Yx8K4YpL6luOUIoHuVtSJvZyXUI9U6FMkQYTvIYUtU6UMiETq+4aqzHXwq2TWY828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQEWHiaU; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e0d5c446cso3438268e87.0
        for <linux-wireless@vger.kernel.org>; Sat, 07 Feb 2026 00:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770452706; x=1771057506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6r1Tf3h0z0iSBNclliMh/VjEPgxlX2G5be+P4mBu2BQ=;
        b=NQEWHiaUesHcFfbtPhYKf1o0NYGZOtnOQko5foO9mUaq3hr+rzvkdsw47MEY4fa7lp
         cGR+ZCiR4TrYJe+T6Hmkg9oi0W3Z/oXnLHzccn/E/3Cc7XO7rikJ+N2Dgjgmbsm8PbnZ
         NJnTlAgr1NUp16haa85OOwghG9ZVjDNrqUP5HrYvconeduoAcO3u2BJ0+AMG7ozUzGBm
         PfOa7KDKf4No5mi4Ab/qskyOJ7PKl05kMOAv/5aAIFUn6zQzGn6bZl53jpRIJ3RGEZr1
         IPnFVWP89Up6YwO5DI5+ETjhi14rPbqQ0On0W7GjiqQzYof3Urud7zwRwH1rsVattojc
         pf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770452706; x=1771057506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r1Tf3h0z0iSBNclliMh/VjEPgxlX2G5be+P4mBu2BQ=;
        b=OCvCJ1p807LbNNcu8t7u2Y6a0FB61OcHCelrLucILbnWPWnRT9KEQwXDexOvSZuibt
         Glka+rLGhwglwt82lYv5tBZ5fRKeMTqfotcNyFoSjtXUIQK/Nv+uOrThjwVZJicfgg64
         N79cjdDghdDAXy36qKNRgvtVVmRCTgxsjdDs8zbUJ8zXyOgbj85i3k0l1Zkf29VapHMd
         ccqKMO27/LJpH+Zvz2Q3Jqn7aHisn5BAyoGgdfG+Ql7Vo75Ht9N2lSO1B1k11pbwcr/1
         u4PFt07gJE/zEn9yRRAJ17vKEENzWvzcFoV8EApJ7d+E3pIARo4r5C3VmgEAAuVQOp3t
         rScQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4Vz9Jq1Kvq3xhsDHz8VvWJZ++CcJF+JuW37O+I8GhQDPcbj+tzA313s4qvhZgpwRfuOe3VVfPVUZ9TW+5yA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ugcDImhCUwpfEtIanrJtHTCI7gURxRvEiecTrkM4/ejO91wV
	zOwoPlUQjWtIf3brgOKomKMBKaPI5m9BmScmvCt5+RQNypjGJlcsZ5pr/xEv/w==
X-Gm-Gg: AZuq6aIuDLlVO4I16uR7k3MDNsRrYntMqQhMrEtZulKX9OtUioKk6JVIO4talysW7lI
	4q3JEPeSpBvprlLUvSfm1G/eBjUWps2EP5wr8BvkwBiJJigUuwNvnHkeNhcCxEbQpFerixdw9I/
	RsOcYKPJm3cbmefbMj2+QjXEwRWvXZN6rtoxygza8hG4+8fT6/P5T5Z5YxVTz1l+GvK8NwfQ8JH
	FRdpmC5bL8oMK2HDliEdX/MqGzAhK2TBjoFWYzt8rcpjkwUyjmGFVWIPr879PnJHlc+fZEPtDp7
	MUeinWpF191RQfN/UDjuutDCD0pP5gxDGCKYpro6a/R3vCb4AOktPZ81MqhJJ4AT9TPoKkGa5Ml
	UjSKqOlF70fvrm9QUu18jtdDJOnp4LG+kazNXD99y//tJsqywRFPuhBoX7N524F0k9Ryvbd+L2t
	vGY93/S3/Y8KVhKHUYoRMY1ApfASgTUclGR8yzmYXntFW/o/ClgbfBCySR+tNG4qnifBIjpu2qZ
	QOgRzUVDytxbwM=
X-Received: by 2002:a05:6512:1593:b0:598:faf6:1009 with SMTP id 2adb3069b0e04-59e451834f9mr1551959e87.53.1770452705558;
        Sat, 07 Feb 2026 00:25:05 -0800 (PST)
Received: from localhost.localdomain ([176.33.64.73])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b63b043esm10666841fa.32.2026.02.07.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 00:25:03 -0800 (PST)
From: Alper Ak <alperyasinak1@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Alper Ak <alperyasinak1@gmail.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Raja Mani <rmani@qti.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath10k: Fix error handling in ath10k_ahb_clock_init()
Date: Sat,  7 Feb 2026 11:24:24 +0300
Message-ID: <20260207082424.596554-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,qca.qualcomm.com,qti.qualcomm.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31632-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alperyasinak1@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0CBA910539F
X-Rspamd-Action: no action

The devm_clk_get() function never returns NULL, it only returns valid
clock pointers or an ERR_PTR() on failure. Using IS_ERR_OR_NULL() is
incorrect and causes static analyzer warnings about passing zero to
PTR_ERR() when the theoretical NULL case is handled.

Fixes: 8beff219c528 ("ath10k: add clock ctrl related functions in ahb")
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 drivers/net/wireless/ath/ath10k/ahb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index eb8b35b6224d..7456f885d2b5 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -87,24 +87,24 @@ static int ath10k_ahb_clock_init(struct ath10k *ar)
 	dev = &ar_ahb->pdev->dev;
 
 	ar_ahb->cmd_clk = devm_clk_get(dev, "wifi_wcss_cmd");
-	if (IS_ERR_OR_NULL(ar_ahb->cmd_clk)) {
+	if (IS_ERR(ar_ahb->cmd_clk)) {
 		ath10k_err(ar, "failed to get cmd clk: %ld\n",
 			   PTR_ERR(ar_ahb->cmd_clk));
-		return ar_ahb->cmd_clk ? PTR_ERR(ar_ahb->cmd_clk) : -ENODEV;
+		return PTR_ERR(ar_ahb->cmd_clk);
 	}
 
 	ar_ahb->ref_clk = devm_clk_get(dev, "wifi_wcss_ref");
-	if (IS_ERR_OR_NULL(ar_ahb->ref_clk)) {
+	if (IS_ERR(ar_ahb->ref_clk)) {
 		ath10k_err(ar, "failed to get ref clk: %ld\n",
 			   PTR_ERR(ar_ahb->ref_clk));
-		return ar_ahb->ref_clk ? PTR_ERR(ar_ahb->ref_clk) : -ENODEV;
+		return PTR_ERR(ar_ahb->ref_clk);
 	}
 
 	ar_ahb->rtc_clk = devm_clk_get(dev, "wifi_wcss_rtc");
-	if (IS_ERR_OR_NULL(ar_ahb->rtc_clk)) {
+	if (IS_ERR(ar_ahb->rtc_clk)) {
 		ath10k_err(ar, "failed to get rtc clk: %ld\n",
 			   PTR_ERR(ar_ahb->rtc_clk));
-		return ar_ahb->rtc_clk ? PTR_ERR(ar_ahb->rtc_clk) : -ENODEV;
+		return PTR_ERR(ar_ahb->rtc_clk);
 	}
 
 	return 0;
-- 
2.43.0


