Return-Path: <linux-wireless+bounces-16260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037719ED033
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C36016A6DF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E320A1DE2C5;
	Wed, 11 Dec 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbiU8mAC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCED21DE2D7
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931846; cv=none; b=DjClpDk4RU7rRwGc00brsTFvT027TWCpQ4sEZt9F4cW7s2G8u91B4uFXsUJLbtaAd7NnX0EjCY9iiUVzAdfh7R/Zo0W82Mz54O6q6r9hDSs25zxHI7mdpLIAm4BSeFZ3H8/r40TkbyUt4mLjnCi+Jm/4rQ58tWUMqoy0dPVME9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931846; c=relaxed/simple;
	bh=7mKNlD/JX6tFo+pUM3mK0HTaLKCi/W316Selsy7IXGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l5AOa7eh7lVi9AwI5yHIotEABuku5i9L2sJARbfC8uKWDNR6sCRy7eRv9ZPI0n6BRsxgkOWQpnWE5W8U+m7lyBW1EhdWoWAkMikPXD3Vk6V1pP4Ou37PmbN26e0UW88Kyx0tiSE2Xe/LU1s+jJliWuH3/sBLNkp2cdu+LhMxbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbiU8mAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20E4C4CED4;
	Wed, 11 Dec 2024 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931846;
	bh=7mKNlD/JX6tFo+pUM3mK0HTaLKCi/W316Selsy7IXGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbiU8mACVVCnsAl9vrxjdbZRgm11ISXKZscoIwm+0sANU6DJf6qpHb5AHVtz2vclV
	 iH2kRidbSszQovCFdd1QYr8K+9UTv0dWYCm1fwDxyKniaaFETOW8zmfTayj3XhusCG
	 o2jE97RARQzLnZ/VnuIinG7Q8RP7w+RH2XRR6BwdZdTtgfJ+s38tGxW8HhGhRBh49P
	 e3JFBZbjwriUIudMnlHEpj4IBD1NK5dvFCfVEep3I55JaJHx8nU0o16O3bMGVY3G95
	 VDtsuAxos8zU+Cn4DpuosX/dIAfpO+K5oyWnjATVZL9aE30a8UYFZ6Zk720jFAIzkQ
	 w0HD4JXg/mxEw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 5/7] wifi: ath12k: add ATH12K_FW_FEATURE_MLO capability firmware feature
Date: Wed, 11 Dec 2024 17:43:56 +0200
Message-Id: <20241211154358.776279-6-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211154358.776279-1-kvalo@kernel.org>
References: <20241211154358.776279-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

To maintain backward compatibility with older firmware versions, introduce a
new feature bit, ATH12K_FW_FEATURE_MLO, to identify whether the firmware
supports MLO. If the firmware-X.bin does not have this bit advertised in the
feature, then MLO capability in the host will be disabled.

This applies only for QCN9274 chipsets.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 34 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/fw.h   |  3 +++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index ff79cb910523..0c6b35aac96e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1782,6 +1782,9 @@ static int ath12k_core_hw_group_create(struct ath12k_hw_group *ag)
 
 void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag)
 {
+	struct ath12k_base *ab;
+	int i;
+
 	lockdep_assert_held(&ag->mutex);
 
 	/* If more than one devices are grouped, then inter MLO
@@ -1790,10 +1793,35 @@ void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag)
 	 * Only when there is one device, then it depends whether the
 	 * device can support intra chip MLO or not
 	 */
-	if (ag->num_devices > 1)
+	if (ag->num_devices > 1) {
 		ag->mlo_capable = true;
-	else
-		ag->mlo_capable = ag->ab[0]->single_chip_mlo_supp;
+	} else {
+		ab = ag->ab[0];
+		ag->mlo_capable = ab->single_chip_mlo_supp;
+
+		/* WCN chipsets does not advertise in firmware features
+		 * hence skip checking
+		 */
+		if (ab->hw_params->def_num_link)
+			return;
+	}
+
+	if (!ag->mlo_capable)
+		return;
+
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		/* even if 1 device's firmware feature indicates MLO
+		 * unsupported, make MLO unsupported for the whole group
+		 */
+		if (!test_bit(ATH12K_FW_FEATURE_MLO, ab->fw.fw_features)) {
+			ag->mlo_capable = false;
+			return;
+		}
+	}
 }
 
 int ath12k_core_init(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/fw.h b/drivers/net/wireless/ath/ath12k/fw.h
index 3ff041f15fa0..273c003eff3b 100644
--- a/drivers/net/wireless/ath/ath12k/fw.h
+++ b/drivers/net/wireless/ath/ath12k/fw.h
@@ -23,6 +23,9 @@ enum ath12k_fw_features {
 	 */
 	ATH12K_FW_FEATURE_MULTI_QRTR_ID = 0,
 
+	/* The firmware supports MLO capability */
+	ATH12K_FW_FEATURE_MLO,
+
 	/* keep last */
 	ATH12K_FW_FEATURE_COUNT,
 };
-- 
2.39.5


