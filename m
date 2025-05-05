Return-Path: <linux-wireless+bounces-22517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A3AAA67E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F335318916DC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D753D3278E7;
	Mon,  5 May 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcKUtw7D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1C3278E1;
	Mon,  5 May 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484485; cv=none; b=S1xWfCqARCnpMKh3Tq+6cLjzGT2LjWgWuFDCxPdoXZnKoSj2rp4QH74D4leTlRQJhYxLJrYYg2hy+OA7+V8+QP2Rdy8dc44EJrH5n18nHhhmE0nZyslY1v8tc47EIGg5NcJaaimURFS0Ufl62E9MiIHb9Ui5yIQ6fBH9g76ggF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484485; c=relaxed/simple;
	bh=28MycwQojl4yf0AI0YpWwlRGwTopcRDThnxfc93eX6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9rbJRiSzHsstG6XUNUlEaHgVYXBB+7o0+LmPb7cgaSB7+2ugLQWfnR8kiJwF3ldeR+tmEMB6c9BZlaJaiq37pKoZEMWPRL2Q7SQJIRglV+nmy7e7+ACYgeTWx1qUtav/ZQS3ZXkJxVTcTlqOcSlbdvMrxhB/jzwKOhf2abvRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcKUtw7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D868C4CEF3;
	Mon,  5 May 2025 22:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484485;
	bh=28MycwQojl4yf0AI0YpWwlRGwTopcRDThnxfc93eX6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcKUtw7Dh1L6U3jReQ0KXYCuSxuX9pqRjTF68Qd9XQQ2iZFUlq6wrKw+m6GYYFK1s
	 fJlvmr5zU3oop+W12JdE3D3J9TZX2LABGoGeVoukhj1ant3Gsuq7Bsu4ZIlZizr++v
	 eO7A8RSaGgt3MiVkUyKFtR3nHCsllB1LZss6KHgg/6pVt3sA/Ik2vPe51HGJO5Hgrh
	 1FxMXBHWcTcWIlKSKU9P6gAwzyZJJPQ9BYbBzHNQGGGLmoew13orzUOA6qFFar6BFJ
	 htfBhIH22/6z+qZkrdg47O6KhKDFNg4Vs/LmsYg0A7xmcjYjDKk3wtIomIt7cVhWSN
	 yaeJEldgwuWuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aaradhana Sahu <quic_aarasahu@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 494/642] wifi: ath12k: Enable MLO setup ready and teardown commands for single split-phy device
Date: Mon,  5 May 2025 18:11:50 -0400
Message-Id: <20250505221419.2672473-494-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Aaradhana Sahu <quic_aarasahu@quicinc.com>

[ Upstream commit 5cec2d86c7f4242fb30a696d8e6fd48109bf3e8f ]

When multi-link operation(MLO) is enabled through follow-up patches in
the single split-phy device, the firmware expects hardware links
(hw_links) information from the driver.

If driver does not send WMI multi-link setup and ready command to the
firmware during MLO setup for single split-phy device, the firmware will
be unaware of the hw_links component of the multi-link operation. This may
lead to firmware assert during multi-link association.

Therefore, enable WMI setup, ready and teardown commands for single
split-phy PCI device.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250207050327.360987-2-quic_aarasahu@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/core.c | 33 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/mac.c  |  9 +++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 212cd935e60a0..ffd173ff7b08c 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -887,10 +887,41 @@ static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
 	ath12k_mac_destroy(ag);
 }
 
+u8 ath12k_get_num_partner_link(struct ath12k *ar)
+{
+	struct ath12k_base *partner_ab, *ab = ar->ab;
+	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k_pdev *pdev;
+	u8 num_link = 0;
+	int i, j;
+
+	lockdep_assert_held(&ag->mutex);
+
+	for (i = 0; i < ag->num_devices; i++) {
+		partner_ab = ag->ab[i];
+
+		for (j = 0; j < partner_ab->num_radios; j++) {
+			pdev = &partner_ab->pdevs[j];
+
+			/* Avoid the self link */
+			if (ar == pdev->ar)
+				continue;
+
+			num_link++;
+		}
+	}
+
+	return num_link;
+}
+
 static int __ath12k_mac_mlo_ready(struct ath12k *ar)
 {
+	u8 num_link = ath12k_get_num_partner_link(ar);
 	int ret;
 
+	if (num_link == 0)
+		return 0;
+
 	ret = ath12k_wmi_mlo_ready(ar);
 	if (ret) {
 		ath12k_err(ar->ab, "MLO ready failed for pdev %d: %d\n",
@@ -932,7 +963,7 @@ static int ath12k_core_mlo_setup(struct ath12k_hw_group *ag)
 {
 	int ret, i;
 
-	if (!ag->mlo_capable || ag->num_devices == 1)
+	if (!ag->mlo_capable)
 		return 0;
 
 	ret = ath12k_mac_mlo_setup(ag);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ee595794a7aee..6325ac493f82c 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1084,6 +1084,7 @@ int ath12k_core_resume(struct ath12k_base *ab);
 int ath12k_core_suspend(struct ath12k_base *ab);
 int ath12k_core_suspend_late(struct ath12k_base *ab);
 void ath12k_core_hw_group_unassign(struct ath12k_base *ab);
+u8 ath12k_get_num_partner_link(struct ath12k *ar);
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 9c3e66dbe0c3b..9123ffab55b52 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11140,6 +11140,9 @@ static int __ath12k_mac_mlo_setup(struct ath12k *ar)
 		}
 	}
 
+	if (num_link == 0)
+		return 0;
+
 	mlo.group_id = cpu_to_le32(ag->id);
 	mlo.partner_link_id = partner_link_id;
 	mlo.num_partner_links = num_link;
@@ -11169,10 +11172,16 @@ static int __ath12k_mac_mlo_teardown(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
 	int ret;
+	u8 num_link;
 
 	if (test_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags))
 		return 0;
 
+	num_link = ath12k_get_num_partner_link(ar);
+
+	if (num_link == 0)
+		return 0;
+
 	ret = ath12k_wmi_mlo_teardown(ar);
 	if (ret) {
 		ath12k_warn(ab, "failed to send MLO teardown WMI command for pdev %d: %d\n",
-- 
2.39.5


