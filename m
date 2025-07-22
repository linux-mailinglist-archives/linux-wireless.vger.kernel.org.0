Return-Path: <linux-wireless+bounces-25796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF9B0D13F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 07:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653F4542D3E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2B02882B6;
	Tue, 22 Jul 2025 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="JGVReFLj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F67139D;
	Tue, 22 Jul 2025 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753162349; cv=pass; b=Y6qErfCo5Ntl10nvGTq+PTffOKRtkNTjO8xuXe89odOGX2UPeHFeNwW8574BU53UP4z046pjdTF7ktUehrRu9tuhIMBMZLJEVUNzqQ6ZTI0Dzcisc9bMRDfTHpgLmRRhhP+8kvLTHtiLMsMgLepuFHtsC0RAX8aa8osUWaOD+OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753162349; c=relaxed/simple;
	bh=bUY11S13/6MVy4QS27ZozYt1jsEVGwuuCzVS1McUayM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fnUv1W6hIsXcDyboQZ4vcuOTyDzQ7pIkRAdkCyObeie6m+1WXykvXkOfkXFmTfbgdrpFwGApTEI1RXUc/1uuttphB+UhVkyanRiuZeD8MJ3+HK4HXELGJr/m/VnIMOZSVxhg6bxaLBdB3yzvpCHmIP6+z5sScmUMYAuRE4GBIXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=JGVReFLj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753162307; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C+aLutokWiTyaf0z0rekZO8jCLn04C4oWIPYFOHB0ISyfU/lZbI/sskWtL1JbXnZPvY+kV5KWM9z0DSbIEITS2O68YDWN5K7/rXJ7EaghTycqxQnUQvG8r9nxCb4+j+S39SUR9RooF6c3Qoq1gRjCihRbFwTNdPilcn4E/aT6zE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753162307; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5Q6iMEIwGl68fheKRd/l4+lC7AlYzE3zdk14QF/Z4a4=; 
	b=N1rVk1mFBevE03nCoCcGTxa3Fu4H28u9t9fVFOx9cSv1zCSq7b0cwKOynyHeocdMEumKBBbreF1PGEdhwiWE6zf5lrvVTwPewLzpERwI0MQsr3I21SDmvKDgAe92STpcOV9JJmoSWntoSRfKkwWSe8NQ7XlNlbMHw4/MBACd/O4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753162307;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=5Q6iMEIwGl68fheKRd/l4+lC7AlYzE3zdk14QF/Z4a4=;
	b=JGVReFLjfAi9/3RpbIEolp6ubOJtw6logedRk6OwVQVZPJs+TQbp7deuaaJtXyCJ
	Lxr6JbUKyyyyOYl6hWHrrWy7sdB3aIw2J/vIPNMOw6Zv+fl4PmHadK5n+S+PjXvNHGW
	GXgQrEeDpQBIWiko7B/7dyzbIJYu+3WfjYk5adxE=
Received: by mx.zohomail.com with SMTPS id 1753162304932604.0388171987082;
	Mon, 21 Jul 2025 22:31:44 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
	kbuild test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Sven Eckelmann <sven@narfation.org>,
	Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	stable@vger.kernel.org,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Muna Sinada <quic_msinada@quicinc.com>,
	Anilkumar Kolli <quic_akolli@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Miles Hu <milehu@codeaurora.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again
Date: Tue, 22 Jul 2025 10:31:21 +0500
Message-Id: <20250722053121.1145001-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Don't deinitialize and reinitialize the HAL helpers. The dma memory is
deallocated and there is high possibility that we'll not be able to get
the same memory allocated from dma when there is high memory pressure.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Cc stable and fix tested on tag
- Clear essential fields as they may have stale data

Changes since v2:
- Add comment and reviewed by tag
---
 drivers/net/wireless/ath/ath11k/core.c |  6 +-----
 drivers/net/wireless/ath/ath11k/hal.c  | 16 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/hal.h  |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 4488e4cdc5e9e..34b27711ed00f 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2213,14 +2213,10 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	mutex_unlock(&ab->core_lock);
 
 	ath11k_dp_free(ab);
-	ath11k_hal_srng_deinit(ab);
+	ath11k_hal_srng_clear(ab);
 
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 
-	ret = ath11k_hal_srng_init(ab);
-	if (ret)
-		return ret;
-
 	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	ret = ath11k_core_qmi_firmware_ready(ab);
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index b32de563d453a..e8ebf963f195c 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1359,6 +1359,22 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_hal_srng_deinit);
 
+void ath11k_hal_srng_clear(struct ath11k_base *ab)
+{
+	/* No need to memset rdp and wrp memory since each individual
+	 * segment would get cleared ath11k_hal_srng_src_hw_init() and
+	 * ath11k_hal_srng_dst_hw_init().
+	 */
+	memset(ab->hal.srng_list, 0,
+	       sizeof(ab->hal.srng_list));
+	memset(ab->hal.shadow_reg_addr, 0,
+	       sizeof(ab->hal.shadow_reg_addr));
+	ab->hal.avail_blk_resource = 0;
+	ab->hal.current_blk_index = 0;
+	ab->hal.num_shadow_reg_configured = 0;
+}
+EXPORT_SYMBOL(ath11k_hal_srng_clear);
+
 void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
 {
 	struct hal_srng *srng;
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 601542410c752..839095af9267e 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -965,6 +965,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 			  struct hal_srng_params *params);
 int ath11k_hal_srng_init(struct ath11k_base *ath11k);
 void ath11k_hal_srng_deinit(struct ath11k_base *ath11k);
+void ath11k_hal_srng_clear(struct ath11k_base *ab);
 void ath11k_hal_dump_srng_stats(struct ath11k_base *ab);
 void ath11k_hal_srng_get_shadow_config(struct ath11k_base *ab,
 				       u32 **cfg, u32 *len);
-- 
2.39.5


