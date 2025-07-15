Return-Path: <linux-wireless+bounces-25474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F40CB05C36
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 15:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB841C21EAB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C761A2E2EE7;
	Tue, 15 Jul 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="b1VUHq9Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806EB2D8790;
	Tue, 15 Jul 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585948; cv=pass; b=SnkOC1kvhmQP/lmEBf3rV7E+2fuMSj/+5krtE6eUWvbxEuimwmZHiK3A7z/jHHABzthDoMBsBMulqey8JOJBC+dSjNIGHxm3cy3c/s7KaY1VlLbrUKyZH2TPUSntIA+Jl7gi+Sf3sbH9JaoDozl31f7bKUr+JeNUuDrBQ4HAXXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585948; c=relaxed/simple;
	bh=2zJRQ+ItpFJo3jrAD8g74nIQYMU7RF/5aDiGKgW0sD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jxMzlOH5Czy//0kNEmm9DZI/Cy/z7RDCwVzGeip+2L25yWKhsmDqzqU/7rluUDA93sLDkgAeMIiUO8kZOu55pHLmFimC2vGV/mPlfjwnoq9bIDIapKjEVeWFiHdHOh6t4y0Cfq5yABX4q2QWuiGHCme4ifH8tIhjfPcfrt/7s/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=b1VUHq9Z; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752585847; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZVG2fuf9IkoShLnMJ+0FksgGRRohYKjrlPa30aqFmRitabW7R2nYYmsCwDJjC54xAaf0rmrqRRPz50UiDJdUGcwL7mJqMB1XW6LT3Ui5t5acdCTeU7sxm6sBxMex5Sli76K5JABMUigTEu/zuOt1LiEP8qn08+ty2y4xz7MG0dc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752585847; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yDPjmv3LEWDCBb9fA78/k0Uz/0ozwN9L8y+fFs46MNU=; 
	b=OU8dCDgwZT1HsjCe3ad9QPeWr6zUmuOPv1c83KvsLVKBBo5stH+tEycJGEVr1nNl9MAOUdJqPSaT6GXz9xCDqaVaLCDHkweHPLc1AV7CwTM6HVl4ugxQQ1pNgNTZkTZhsJusoK33kWqYxaRoJdvtM0XXpAhw/dpcBrL0hafL/3w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752585847;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=yDPjmv3LEWDCBb9fA78/k0Uz/0ozwN9L8y+fFs46MNU=;
	b=b1VUHq9Z909pI6HmnxYCx+SQ8VQCp663xgQ6zTE/pJxicvsyUdnEzm1B36tmlwJG
	zk6pH0PCH9MvUhd/ubbjWbWUkpqLgCsVv+xQTKwokQWYeXzqnPjNLYPDWS18LHD3vH4
	pMgxYD9pohvpKufEpnOutmzhYWwAUuTWFmpMNQD4=
Received: by mx.zohomail.com with SMTPS id 1752585844627311.6253288130798;
	Tue, 15 Jul 2025 06:24:04 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	kbuild test robot <lkp@intel.com>,
	Ganesh Sesetti <gseset@codeaurora.org>,
	Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
	Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
	Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	stable@vger.kernel.org,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Sriram R <quic_srirrama@quicinc.com>,
	Rajkumar Manoharan <rmanohar@codeaurora.org>,
	Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
	Bhagavathi Perumal S <bperumal@codeaurora.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again
Date: Tue, 15 Jul 2025 18:23:50 +0500
Message-Id: <20250715132351.2641289-1-usama.anjum@collabora.com>
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
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Cc stable and fix tested on tag
- Clear essential fields as they may have stale data
---
 drivers/net/wireless/ath/ath11k/core.c |  6 +-----
 drivers/net/wireless/ath/ath11k/hal.c  | 12 ++++++++++++
 drivers/net/wireless/ath/ath11k/hal.h  |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

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
index b32de563d453a..dafa9bdbb3d32 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1359,6 +1359,18 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_hal_srng_deinit);
 
+void ath11k_hal_srng_clear(struct ath11k_base *ab)
+{
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


