Return-Path: <linux-wireless+bounces-14821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EDE9B942A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43524B21754
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE3F1C4614;
	Fri,  1 Nov 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7gFKhgf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4681C75E6
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474232; cv=none; b=f7MSZs0ujNRPWxTdwRo+rXUlUC7OMrATB3C2spuFGtafa6DHP4AuCipBvN5E1xqFoWifyZ3A1tL46L+3vP7mMl1qhkNDzyNe5zj7PqkKPK3+ozgdttV6KLo19q9LXE70hhaqOreS+VslpZLd69GwEhxfKw349kNkEapbWLoA8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474232; c=relaxed/simple;
	bh=xVqvdvjXVgNemJbHrDvtyzm+RRAz1gCC2ul25/KLpPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzuSkxFtSod43Keqt5wYyDZ7Hl4PV4wo9uZRRX/yMaNUaOT/LE0MC1tMcca1zDAOS0CilZoQ1D+6Rbt662eXsPPlY/g8V7kDS5p47YbBPvaMo89VTKgp0sSTK8yknY2uXj9aAtgdD+6EwZWvJhKgQ8DWm5eVUtsLlZXU52ms1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7gFKhgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDB0C4CED2;
	Fri,  1 Nov 2024 15:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730474231;
	bh=xVqvdvjXVgNemJbHrDvtyzm+RRAz1gCC2ul25/KLpPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7gFKhgff9b4ItzHa/qm8qESyanuFlDj6o35kXHmFuvmsGc17HSShBSZje0U/PI1/
	 F+4se/cUiUazznBdaz4PUpsOwNudRICoBIyEuunm7T/udpvN0wPc8U+LhOeMFC98Xc
	 Atco4vR/bgHFZrAM+J/TvEmu3ntv923uBmHTsFk+rHEflra6vvqu4bS4uog8PfqrxJ
	 FV/jXrwYRwIvmYDrMWuOZVrokXILACYFKBPV/93pG75qn8Pw511HIPZZnv99XgcpDL
	 92BgkgzjPX2QlDHPDacb8I495XdYRHJQ8JFL7PwaFFfJ7u0WbEns3ezleHZLrkGHcp
	 e2xqgGmtSZFxw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 4/8] wifi: ath12k: introduce ath12k_hw_warn()
Date: Fri,  1 Nov 2024 17:17:01 +0200
Message-Id: <20241101151705.165987-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101151705.165987-1-kvalo@kernel.org>
References: <20241101151705.165987-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

In the following patch we need to use ath12k_warn() but don't easily have
access to struct ath12k_base (ab) but do have access to struct ath12k_hw (ah).
So add a new warning helper ath12_hw_warn() which takes the latter but the log
output is still identical but uses the struct device pointer stored to struct
ath12k_hw.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h  | 2 ++
 drivers/net/wireless/ath/ath12k/debug.c | 6 +++---
 drivers/net/wireless/ath/ath12k/debug.h | 5 ++++-
 drivers/net/wireless/ath/ath12k/mac.c   | 2 ++
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 6faa46b9adc9..9c4e5fae8930 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -684,6 +684,8 @@ struct ath12k {
 
 struct ath12k_hw {
 	struct ieee80211_hw *hw;
+	struct device *dev;
+
 	/* Protect the write operation of the hardware state ath12k_hw::state
 	 * between hardware start<=>reconfigure<=>stop transitions.
 	 */
diff --git a/drivers/net/wireless/ath/ath12k/debug.c b/drivers/net/wireless/ath/ath12k/debug.c
index fe5a732ba9ec..ff6eaeafa092 100644
--- a/drivers/net/wireless/ath/ath12k/debug.c
+++ b/drivers/net/wireless/ath/ath12k/debug.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/vmalloc.h>
@@ -36,7 +36,7 @@ void ath12k_err(struct ath12k_base *ab, const char *fmt, ...)
 	va_end(args);
 }
 
-void ath12k_warn(struct ath12k_base *ab, const char *fmt, ...)
+void __ath12k_warn(struct device *dev, const char *fmt, ...)
 {
 	struct va_format vaf = {
 		.fmt = fmt,
@@ -45,7 +45,7 @@ void ath12k_warn(struct ath12k_base *ab, const char *fmt, ...)
 
 	va_start(args, fmt);
 	vaf.va = &args;
-	dev_warn_ratelimited(ab->dev, "%pV", &vaf);
+	dev_warn_ratelimited(dev, "%pV", &vaf);
 	/* TODO: Trace the log */
 	va_end(args);
 }
diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
index f7005917362c..90e801136bc6 100644
--- a/drivers/net/wireless/ath/ath12k/debug.h
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -31,7 +31,10 @@ enum ath12k_debug_mask {
 
 __printf(2, 3) void ath12k_info(struct ath12k_base *ab, const char *fmt, ...);
 __printf(2, 3) void ath12k_err(struct ath12k_base *ab, const char *fmt, ...);
-__printf(2, 3) void ath12k_warn(struct ath12k_base *ab, const char *fmt, ...);
+__printf(2, 3) void __ath12k_warn(struct device *dev, const char *fmt, ...);
+
+#define ath12k_warn(ab, fmt, ...) __ath12k_warn((ab)->dev, fmt, ##__VA_ARGS__)
+#define ath12k_hw_warn(ah, fmt, ...) __ath12k_warn((ah)->dev, fmt, ##__VA_ARGS__)
 
 extern unsigned int ath12k_debug_mask;
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 354fc21f2af2..9552a9495276 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10192,6 +10192,8 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 			goto err;
 		}
 
+		ah->dev = ab->dev;
+
 		ab->ah[i] = ah;
 	}
 
-- 
2.39.5


