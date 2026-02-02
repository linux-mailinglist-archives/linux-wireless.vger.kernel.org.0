Return-Path: <linux-wireless+bounces-31466-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOJKBpfBgGl3AgMAu9opvQ
	(envelope-from <linux-wireless+bounces-31466-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:24:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A335CE26F
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 281813002E3C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E7437A494;
	Mon,  2 Feb 2026 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNzlokGC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E0366833
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045449; cv=none; b=A+NtYXjwBMPXUl/PgvacxzJs8YcxS1fTCOBufXAdI5ptnxP6LYWe2Ef40QCv6zfjS+AokaeuJXLKxCDyh/8sjuyNCFLmtZ7C0jduh/KZjUq9vj6mfmVvNWjoacq602Q/S8pY7wZA/qmEueznzE659UnnvdatuF1MqczqarIBs80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045449; c=relaxed/simple;
	bh=lSH4WdJZQFQKbcuOTcqByxROAsgttdinJuGz3TKVfQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnXwCMuTzRLqVjPoWyK+BpirurBpGSjVAdsWY3fSbr6he+n5rf/bqXVEH/qhFwK30qx/hbNkXTF9lQ2D7VScW9p2Rvam7zQyThR6Mby9CQ2jlvPD2uGcX/rtKjDRH8scGwYbofhZKd3ZNvF+G+EBVy9iRR7fKGeRz+osdB0NbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNzlokGC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso2483742b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 07:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770045447; x=1770650247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUARgzGPJhRK4HrRb+3HfBCK/Wz2+3KoUtSkwanfWJY=;
        b=lNzlokGC6j/ZdoNNGXsVcFhFugiSeNN20OHJh2yg0aceVHgPTKmF3laego62adn9AD
         00nFjQbqxKCqF8SxOoRDidgzD5cLuz/tji0s65OpwTkcME/Yy1lVYCdKJti5QQE+6PNQ
         zBlDGaJL6/7+hD/RMy1qJhG/X13iG1ADzCQg4b8iocwamsXhS1jaDNQ2Qj7RQfGiHpMe
         f2I5T/1Faju8Nm0FdJKJuRHUUj1IO7+lV3a6V0VYzK/5dqlhAy4f8EhdM5UAraOad9fQ
         /6DC6ZPTmpuG93VZCLZo1RFbdl3RekidijC2yLum3gBloqRY9O3lYxRAD1/cX0scBc/V
         4AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770045447; x=1770650247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUARgzGPJhRK4HrRb+3HfBCK/Wz2+3KoUtSkwanfWJY=;
        b=rh+5kjKE2ZdMgYp9ACrzx6PfdZSrOdv/6pi/z0LXzlxbAWUerYuZ0UHu2Zcw1aAm+6
         PjFc6v47aD8jCqKYjVZVDAmRsKJ1QwEc59tOFvmpV5vdsUNAnddsvZS4W0X6Py5+v8kg
         dTd9lRu8isWvBGqOx4WSxxgyaXIJQoprzlIleAdXSZtKnfVFTAHrppE/QFFHXREQYYHi
         sOpxqbb4bYLW8dpoFlcVBpNUw6GJuiW72bCDTxEM6nEKMSvkvFtYwEyjg9FyVFTq2nYh
         Lxziv91h0rEY9ychSfojcNdq+F2E3wscS8XLs2qDMium7ovzTUutJBjkCUeklildHN+p
         +1AA==
X-Forwarded-Encrypted: i=1; AJvYcCWBSqXLgqlOcfwXw5RgbZ4zYkErIy9yV1kKEY9/WbZyMSSLNFE5Duv+Wt+lOHYyOjlAMk3zySXVrs9++LfdLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YygCAoN8CPpJ0WpWn216c7KBMW4A4n7FRIdgiqAznWYYBKXEqmk
	810IwugwVgdejwWUdyJ1K4sJjTg8OcPZmodGyVdyjghnyc6k2Zm8dNc9
X-Gm-Gg: AZuq6aIJaeN1UQdt10+W4hedpBk3ZGNX8kcoMPgJJRpk55Ku+NM3M7hALe7t15nesV7
	IamLLAhmpuztGrABG3l4YGpngwYUfMQ8iRdQDpJ3rH3vprbWOdeAo27/9bCHWphquX3mjFm58yo
	H2sfBqRYyUhEALRBG/TsAa/GB/E67z8d6GGIXS1QlqwQdW3/hjxGZWjcZrVCTsoNAWYy1Nt0Gz7
	33T2K7MVc6rILRKpwozSdPypxRz36mwynZ+buzeP0Q8iXXTq1uteE8tgNkYqyleU8UobLEH1wRW
	2B4BF16gwGntEzU1e89uGJ1mhdoFgK0UlFVoflkSwLxN5ufyNBqS/IaT+kmMUE+JhbRgh32MuWF
	ZotSGZzEF44jG1FN8K9S2bw/66eXeQudtc5oEkxQmqGbkgDttFvWvg845Bl/VUCGVYzjFBAGRlj
	F2NhwpJgwFyi2WZBq4y/rH3n8jmmKO6o+I2w==
X-Received: by 2002:a05:6a00:3026:b0:7e8:4471:ae6d with SMTP id d2e1a72fcca58-823aa7376d1mr11367711b3a.57.1770045447289;
        Mon, 02 Feb 2026 07:17:27 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:6b:a50d:4972:6cd4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b58f38sm16843432b3a.24.2026.02.02.07.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:17:26 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: jjohnson@kernel.org,
	kvalo@kernel.org
Cc: quic_bqiang@quicinc.com,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH] wifi: ath12k: fix CMA error and MHI state mismatch during resume
Date: Mon,  2 Feb 2026 20:47:20 +0530
Message-ID: <20260202151720.49904-1-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[quicinc.com,vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-31466-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A335CE26F
X-Rspamd-Action: no action

Commit 8d5f4da8d70b ("wifi: ath12k: support suspend/resume") introduced
system suspend/resume support but caused a critical regression where
CMA pages are corrupted during resume.

1. CMA page corruption:
   Calling mhi_unprepare_after_power_down() during suspend (via
   ATH12K_MHI_DEINIT) prematurely frees the fbc_image and rddm_image
   DMA buffers. When these pages are accessed during resume, the kernel
   detects corruption (Bad page state).

To fix this corruption, the driver must skip ATH12K_MHI_DEINIT during
suspend, preserving the DMA buffers. However, implementing this fix
exposes a second issue in the state machine:

2. Resume failure due to MHI state mismatch:
   When DEINIT is skipped during suspend to protect the memory, the
   ATH12K_MHI_INIT bit remains set. On resume, ath12k_mhi_start()
   blindly attempts to set INIT again, but the state machine rejects
   the transition:

   ath12k_wifi7_pci ...: failed to set mhi state INIT(0) in current
   mhi state (0x1)

Fix the corruption and enable the correct suspend flow by:

1. In ath12k_mhi_stop(), skipping ATH12K_MHI_DEINIT if suspending.
   This prevents the memory corruption by keeping the device context
   valid (MHI_POWER_OFF_KEEP_DEV).

2. In ath12k_mhi_start(), checking if MHI_INIT is already set.
   This accommodates the new suspend flow where the device remains
   initialized, allowing the driver to proceed directly to POWER_ON.

Tested with suspend/resume cycles on Qualcomm Snapdragon X Elite
(SC8380XP) with WCN7850 WiFi. No CMA corruption observed, WiFi resumes
successfully, and deep sleep works correctly.

Fixes: 8d5f4da8d70b ("wifi: ath12k: support suspend/resume")
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/net/wireless/ath/ath12k/mhi.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 45c0f66dcc5e..1a0b3bcc6bbf 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -485,9 +485,14 @@ int ath12k_mhi_start(struct ath12k_pci *ab_pci)
 
 	ab_pci->mhi_ctrl->timeout_ms = MHI_TIMEOUT_DEFAULT_MS;
 
-	ret = ath12k_mhi_set_state(ab_pci, ATH12K_MHI_INIT);
-	if (ret)
-		goto out;
+	/* In case of suspend/resume, MHI INIT is already done.
+	 * So check if MHI INIT is set or not.
+	 */
+	if (!test_bit(ATH12K_MHI_INIT, &ab_pci->mhi_state)) {
+		ret = ath12k_mhi_set_state(ab_pci, ATH12K_MHI_INIT);
+		if (ret)
+			goto out;
+	}
 
 	ret = ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_ON);
 	if (ret)
@@ -501,16 +506,21 @@ int ath12k_mhi_start(struct ath12k_pci *ab_pci)
 
 void ath12k_mhi_stop(struct ath12k_pci *ab_pci, bool is_suspend)
 {
-	/* During suspend we need to use mhi_power_down_keep_dev()
-	 * workaround, otherwise ath12k_core_resume() will timeout
-	 * during resume.
+	/* During suspend, we need to use mhi_power_down_keep_dev()
+	 * and avoid calling MHI_DEINIT. The deinit frees BHIE tables
+	 * which causes memory corruption when those pages are
+	 * accessed/freed again during resume. We want to keep the
+	 * device prepared for resume, otherwise ath12k_core_resume()
+	 * will timeout.
 	 */
 	if (is_suspend)
 		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_OFF_KEEP_DEV);
 	else
 		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_OFF);
 
-	ath12k_mhi_set_state(ab_pci, ATH12K_MHI_DEINIT);
+	/* Only deinit when doing full power down, not during suspend */
+	if (!is_suspend)
+		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_DEINIT);
 }
 
 void ath12k_mhi_suspend(struct ath12k_pci *ab_pci)
-- 
2.51.0


