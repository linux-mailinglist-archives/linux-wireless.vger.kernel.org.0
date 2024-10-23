Return-Path: <linux-wireless+bounces-14384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E309ACB42
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E07D1C21623
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F71BE23F;
	Wed, 23 Oct 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJBJN4aH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F31C0DFD
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690211; cv=none; b=PPGIzgkG0xArDLulJuAYOZ0EW3xl9tpPndTNVIB472vd6AHlOvAv+5IWCQSH/Md8aXfd4wqq1jj7z9mR//N/rJXhRcl2CsIXHJmE4lzzewlqjsAEDoZA9qcpvPTmHx18hxwZGAiqp0l7cXCYil8+Na6RHprKOmO6CbpLILMCXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690211; c=relaxed/simple;
	bh=WhqUp89niG73soI3Z+gPZdZCpLv8Zj5caHmZSK60xqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OISaabR4m/5foD+hmwR1yXP53Jl+oRx+bTxxx77G9O+JNpxd/hjD/iWmEHBz+yZ83KUjWh+qq+VuvPMGp0+ONgb5UeBnVNviYqMTfAVgQQdMzF2qbPXdkJJLSko4D2iVDKoY57hIf3dvFuiy8AbsX1sUS+FecMMdtqhtXaWAGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJBJN4aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C63FC4CEE4;
	Wed, 23 Oct 2024 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690211;
	bh=WhqUp89niG73soI3Z+gPZdZCpLv8Zj5caHmZSK60xqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJBJN4aHamrRHWxtdlUm5xRHP3fCAj/hA3O5WxXo6WkossJTgc2Q36qLdFDZln9Wl
	 zJwx0Q0dsmw6P0aTUPu1ZtDarZSAxyLGA8vxLMmimGqqDO6kv4TFxrlRacs5igePka
	 6q+cFxuB7T2sSuXmpm6fHggWMgjIWHWZsr4xQ25oInWYBoFaXenzb4rmyII3L6hhoS
	 QAA+IY9dzrjQfpPStp3Wmw/0btjsZ7Z25eODJbbWQ72xmO7lpqeiJ0aglGZk6ERzuX
	 RxGlVlzBGHfoFrn33byifhm2eRTqHHy4wgsk2kDSFMOoDIIKsKai4SlGkvuqQY70T1
	 QnpyC8GcYCIFQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 4/8] wifi: ath12k: introduce ath12k_hw_warn()
Date: Wed, 23 Oct 2024 16:30:00 +0300
Message-Id: <20241023133004.2253830-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023133004.2253830-1-kvalo@kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/debug.c | 4 ++--
 drivers/net/wireless/ath/ath12k/debug.h | 5 ++++-
 drivers/net/wireless/ath/ath12k/mac.c   | 2 ++
 4 files changed, 10 insertions(+), 3 deletions(-)

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
index fe5a732ba9ec..c5c8c7624cdb 100644
--- a/drivers/net/wireless/ath/ath12k/debug.c
+++ b/drivers/net/wireless/ath/ath12k/debug.c
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
index 3de6d605cd74..19c445cf52f1 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10193,6 +10193,8 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 			goto err;
 		}
 
+		ah->dev = ab->dev;
+
 		ab->ah[i] = ah;
 	}
 
-- 
2.39.5


