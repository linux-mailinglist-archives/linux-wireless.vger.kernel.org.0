Return-Path: <linux-wireless+bounces-24212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC3BADCB2A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 14:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB2B3BC756
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A252DBF5F;
	Tue, 17 Jun 2025 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdUz+jdo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6242DE1E1;
	Tue, 17 Jun 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162966; cv=none; b=poYFJbX6mlKIJj7r3N/GrHVewTWSif1afUqbdtdhmCVBjuv9F6IzzLTFPRTwPbQcZ0s4iqcSNcLawftLqAA+2WI0HaxqQguid9TwJObj6lGBb903v4piihy3tFUdiBaIocyiIRBpIdtvLcflMwOYXq+Ke2yh5hr1gI9opN71vzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162966; c=relaxed/simple;
	bh=UJpfuz8qKAq6VflhBGYZWv+qIDDIElL/udp0ZibVWnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cxs3a21DryS6lnISDP7CJVfQMF2wf/aO2mJfB74QcUh+leb0iWRaiCnCOSF5AYovCAF1urELmZSSev+9wqCNbwpm+xB5C6ZpasulV/SZnN38MGzG/61WBf41vHorcVrD5SOhZj3M9BMwqvZ3soPUeWMgVKh9kfKNC3ogaOA+Z4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdUz+jdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A5CC4CEF0;
	Tue, 17 Jun 2025 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750162965;
	bh=UJpfuz8qKAq6VflhBGYZWv+qIDDIElL/udp0ZibVWnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdUz+jdoS6YnIlsS9JvQjvaHPUpVAR+ObZh/q2G0sjQZUs2OJn0JxEoOEU2Tvkihq
	 xUZMEZQ37hJnaODHBXzrTAOgKWX3WBTR/fk/3nVmLB5KxKCV4X9IsRzzTcXnip/ofn
	 ZVujJ47H6M3vAzoNfRPutBA2YWZk6TijDUg1EjaLgTjpwIH1b+gJRWYmhFH9a5GhFJ
	 CYvKXONr1MSsDZV3AYHJkEB2PYS3fNF4gv/fQWSuDe2EE5mVcleNM9UZtDS8OTHj5f
	 /rKRBkD/vHJ2jgFYEMj0BztAbZedmii+cgJQqVGnSlb1oRSQZh4XYAlnnA58BdxCQM
	 GkEgN1vo3IZYA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 12/12] wifi: ath10k: Avoid vdev delete timeout when firmware is already down
Date: Tue, 17 Jun 2025 08:22:21 -0400
Message-Id: <20250617122222.1968832-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617122222.1968832-1-sashal@kernel.org>
References: <20250617122222.1968832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.33
Content-Transfer-Encoding: 8bit

From: Loic Poulain <loic.poulain@oss.qualcomm.com>

[ Upstream commit dc9c4252fe0d7a7f1ee904405ea91534277305bf ]

In some scenarios, the firmware may be stopped before the interface is
removed, either due to a crash or because the remoteproc (e.g., MPSS)
is shut down early during system reboot or shutdown.

This leads to a delay during interface teardown, as the driver waits for
a vdev delete response that never arrives, eventually timing out.

Example (SNOC):
$ echo stop > /sys/class/remoteproc/remoteproc0/state
[ 71.64] remoteproc remoteproc0: stopped remote processor modem
$ reboot
[ 74.84] ath10k_snoc c800000.wifi: failed to transmit packet, dropping: -108
[ 74.84] ath10k_snoc c800000.wifi: failed to submit frame: -108
[...]
[ 82.39] ath10k_snoc c800000.wifi: Timeout in receiving vdev delete response

To avoid this, skip waiting for the vdev delete response if the firmware is
already marked as unreachable (`ATH10K_FLAG_CRASH_FLUSH`), similar to how
`ath10k_mac_wait_tx_complete()` and `ath10k_vdev_setup_sync()` handle this case.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Link: https://patch.msgid.link/20250522131704.612206-1-loic.poulain@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and code changes:

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **It fixes a real-world bug**: The commit addresses a specific issue
   where the driver waits for a vdev delete response that will never
   arrive when the firmware has already crashed or been stopped. This
   causes a 5-second timeout delay during interface teardown, which is a
   user-visible problem.

2. **Clear reproduction scenario**: The commit provides a concrete
   example showing how the issue manifests in SNOC (Snapdragon) systems
   when remoteproc is stopped before interface removal during system
   shutdown/reboot.

3. **Minimal and safe change**: The fix is small and follows established
   patterns within the driver:
   - It introduces `ath10k_vdev_delete_sync()` that mirrors the existing
     `ath10k_vdev_setup_sync()` function
   - Both functions check `ATH10K_FLAG_CRASH_FLUSH` before waiting,
     which is the standard way the driver handles firmware crash
     scenarios
   - The change is localized to the vdev delete path and doesn't
     introduce new behavior, just skips unnecessary waiting

4. **Prevents user-facing delays**: Without this fix, users experience
   unnecessary 5-second delays during system shutdown/reboot or when the
   firmware crashes, which degrades the user experience.

5. **Follows established patterns**: The fix uses the same approach as
   other parts of the driver (`ath10k_vdev_setup_sync()` and
   `ath10k_mac_wait_tx_complete()`) that already check
   `ATH10K_FLAG_CRASH_FLUSH` to avoid waiting for responses from a
   crashed firmware.

6. **Low regression risk**: The change only affects the error path when
   firmware is already marked as crashed. In normal operation when
   firmware is responsive, the behavior remains unchanged.

The commit is similar in nature to the historical commit #5 which was
marked as suitable for backporting - both deal with avoiding unnecessary
waits/timeouts when the firmware state makes it impossible to receive
the expected response.

 drivers/net/wireless/ath/ath10k/mac.c | 33 ++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 6b467696bc982..125d8ff0ab5c0 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "mac.h"
@@ -1022,6 +1023,26 @@ static inline int ath10k_vdev_setup_sync(struct ath10k *ar)
 	return ar->last_wmi_vdev_start_status;
 }
 
+static inline int ath10k_vdev_delete_sync(struct ath10k *ar)
+{
+	unsigned long time_left;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (!test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map))
+		return 0;
+
+	if (test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags))
+		return -ESHUTDOWN;
+
+	time_left = wait_for_completion_timeout(&ar->vdev_delete_done,
+						ATH10K_VDEV_DELETE_TIMEOUT_HZ);
+	if (time_left == 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static int ath10k_monitor_vdev_start(struct ath10k *ar, int vdev_id)
 {
 	struct cfg80211_chan_def *chandef = NULL;
@@ -5900,7 +5921,6 @@ static void ath10k_remove_interface(struct ieee80211_hw *hw,
 	struct ath10k *ar = hw->priv;
 	struct ath10k_vif *arvif = (void *)vif->drv_priv;
 	struct ath10k_peer *peer;
-	unsigned long time_left;
 	int ret;
 	int i;
 
@@ -5940,13 +5960,10 @@ static void ath10k_remove_interface(struct ieee80211_hw *hw,
 		ath10k_warn(ar, "failed to delete WMI vdev %i: %d\n",
 			    arvif->vdev_id, ret);
 
-	if (test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map)) {
-		time_left = wait_for_completion_timeout(&ar->vdev_delete_done,
-							ATH10K_VDEV_DELETE_TIMEOUT_HZ);
-		if (time_left == 0) {
-			ath10k_warn(ar, "Timeout in receiving vdev delete response\n");
-			goto out;
-		}
+	ret = ath10k_vdev_delete_sync(ar);
+	if (ret) {
+		ath10k_warn(ar, "Error in receiving vdev delete response: %d\n", ret);
+		goto out;
 	}
 
 	/* Some firmware revisions don't notify host about self-peer removal
-- 
2.39.5


