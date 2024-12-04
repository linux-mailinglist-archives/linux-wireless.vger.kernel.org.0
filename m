Return-Path: <linux-wireless+bounces-15894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8D9E3FB5
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 17:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C376B282BDE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE1D20C48F;
	Wed,  4 Dec 2024 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX/2GEib"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4E20CCC9
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329942; cv=none; b=taHUEuhtzbe5WvdzGaGCjbi+U0IBR4kqPOHNZv5Ij2szbgyMqf2tYY2Sa/0NcqYsIsWXYCSUg7F6F30nLxNpZ03QY00ZY6yr9jnuj58vQz6nyZxsChStCZ67pqeTny5FhAqkQU7VsrHYeeLd3+iHWPm+wRKsCg03uziPH7AKyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329942; c=relaxed/simple;
	bh=1KYYy0zChNWRS9t83bRH1vuBONCPFVUq/ubaS1cNmg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGuqKBEfhOwCO4I4kpjG0ym4C3p+DAw+wAn20mucsSrnl78x/FmIABHwiEF40q/pjNTdszO1T9myxZVQCdKTWqYhNikNJpvmZrj/RQ//DGqvDH53EChmW1bz3Ot9M1wNS1c5WZgi5FHvwtp/YyaaE7Or8gQZF5MtlNA/qlLfR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX/2GEib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEF6C4CEDD;
	Wed,  4 Dec 2024 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733329941;
	bh=1KYYy0zChNWRS9t83bRH1vuBONCPFVUq/ubaS1cNmg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NX/2GEibDlwpXchzlM/bFTyGQSvHxtkrO2Pu1L2QnFMdPb1v3FaBYdR05vLVK6UOj
	 1nwNCtQ2cTvGU4nw0JTJ851fuOpPNEdSgXY4CYuPHrBmyaW80RUBcEhtpN5xR2wgwc
	 vO9b+BZQAVfphTHAjvikN4hDKumcty6dlnwdAqrVlaCIKoPikK9gYwZKrB8KWxwSHv
	 9yPzglSSRJj1ZLZKSTWQcAKjF8tz89cb6LX5jJy97s2UeL6kWmgDzWWK/uWoIqf979
	 6VyTrsWHJCF130bSrYbB/A0Z9ATYsLcBC9ACxakHuVrPHY//8IdmZV8eNQAGAC0EQ4
	 9Wcpj1MP17+lw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/7] wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp
Date: Wed,  4 Dec 2024 18:32:11 +0200
Message-Id: <20241204163216.433795-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204163216.433795-1-kvalo@kernel.org>
References: <20241204163216.433795-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

At present, the mlo_capable_flags in ath12k_base is used to indicate whether
the chip supports inter (QCN9274) or intra (WCN7850) chip MLO. However, it’s
possible that the chip supports neither, especially with older firmware
versions. Additionally, if intra chip MLO is not supported, inter chip MLO will
also be non-functional. Therefore, having two separate flags for this is
unnecessary.

Therefore, rename this flag to single_chip_mlo_supp. At the same time convert
it into a bool data type. Also, get rid of the enums defined earlier.

For the QCN9274 family of chipsets, this will be set only when firmware
advertises the support during the QMI exchange.

For the WCN7850 family of chipsets, since the event is not supported,
assumption is made that single chip MLO is supported.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  2 +-
 drivers/net/wireless/ath/ath12k/core.h | 23 ++---------------------
 drivers/net/wireless/ath/ath12k/qmi.c  | 13 +++++--------
 3 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 4da147f7bfac..568c9b6e2c1c 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1325,7 +1325,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	ab->dev = dev;
 	ab->hif.bus = bus;
 	ab->qmi.num_radios = U8_MAX;
-	ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
+	ab->single_chip_mlo_supp = false;
 
 	/* Device index used to identify the devices in a group.
 	 *
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 9ddced140056..d93ba844f61d 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -816,21 +816,6 @@ struct ath12k_soc_dp_stats {
 	struct ath12k_soc_dp_tx_err_stats tx_err;
 };
 
-/**
- * enum ath12k_link_capable_flags - link capable flags
- *
- * Single/Multi link capability information
- *
- * @ATH12K_INTRA_DEVICE_MLO_SUPPORT: SLO/MLO form between the radio, where all
- *	the links (radios) present within a device.
- * @ATH12K_INTER_DEVICE_MLO_SUPPORT: SLO/MLO form between the radio, where all
- *	the links (radios) present across the devices.
- */
-enum ath12k_link_capable_flags {
-	ATH12K_INTRA_DEVICE_MLO_SUPPORT	= BIT(0),
-	ATH12K_INTER_DEVICE_MLO_SUPPORT	= BIT(1),
-};
-
 /* Master structure to hold the hw data which may be used in core module */
 struct ath12k_base {
 	enum ath12k_hw_rev hw_rev;
@@ -996,12 +981,8 @@ struct ath12k_base {
 
 	const struct hal_rx_ops *hal_rx_ops;
 
-	/* mlo_capable_flags denotes the single/multi link operation
-	 * capabilities of the Device.
-	 *
-	 * See enum ath12k_link_capable_flags
-	 */
-	u8 mlo_capable_flags;
+	/* Denotes the whether MLO is possible within the chip */
+	bool single_chip_mlo_supp;
 
 	struct completion restart_completed;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 20382b751829..efcf2dfac4ac 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2023,14 +2023,14 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	u8 hw_link_id = 0;
 	int i;
 
-	if (!(ab->mlo_capable_flags & ATH12K_INTRA_DEVICE_MLO_SUPPORT)) {
+	if (!ab->single_chip_mlo_supp) {
 		ath12k_dbg(ab, ATH12K_DBG_QMI,
 			   "intra device MLO is disabled hence skip QMI MLO cap");
 		return;
 	}
 
 	if (!ab->qmi.num_radios || ab->qmi.num_radios == U8_MAX) {
-		ab->mlo_capable_flags = 0;
+		ab->single_chip_mlo_supp = false;
 
 		ath12k_dbg(ab, ATH12K_DBG_QMI,
 			   "skip QMI MLO cap due to invalid num_radio %d\n",
@@ -2176,12 +2176,9 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 		goto out;
 	}
 
-	if (resp.single_chip_mlo_support_valid) {
-		if (resp.single_chip_mlo_support)
-			ab->mlo_capable_flags |= ATH12K_INTRA_DEVICE_MLO_SUPPORT;
-		else
-			ab->mlo_capable_flags &= ~ATH12K_INTRA_DEVICE_MLO_SUPPORT;
-	}
+	if (resp.single_chip_mlo_support_valid &&
+	    resp.single_chip_mlo_support)
+		ab->single_chip_mlo_supp = true;
 
 	if (!resp.num_phy_valid) {
 		ret = -ENODATA;
-- 
2.39.5


