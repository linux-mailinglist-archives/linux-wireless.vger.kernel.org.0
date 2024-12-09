Return-Path: <linux-wireless+bounces-16106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFA89E9E7A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171B7282502
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F8B197A7A;
	Mon,  9 Dec 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/qGUdZl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E387153BF6
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770467; cv=none; b=SPqPpAfSTKLl7+9+wzWG/tfBMbk6vO3qU0TMPeettY5tcebmXluxW9yVgti58UkoRRyRxQib2XyDRJvu82IOFhayU0lgeUZFRPTVEBDH9flz4Ep/J9BQ9A0ZBx++yUgZM8oumjZOojOqYCamT+GyNHUlxSrakN9PcTuxvMHDjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770467; c=relaxed/simple;
	bh=Z/R7g7fEQlRtz94pv6c2LJlmem3SXt6N/CdFdM0AE0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxTLtaCC380wC6sp8uvND8TX5FDDKwVct65Bq4j7F1YpB+oHBjCRK7s1G9gCTwyacoBhyoX7Jg2+D27qw9HzopXn3GW1gjne6ezd4YDTP34+Q1CvaSKC6Jj3V2cVdjQDCzxhckefRNVJyB/GQc5eY6v9dffM0C6AmIrmoXwuhqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/qGUdZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27216C4CEE2;
	Mon,  9 Dec 2024 18:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770466;
	bh=Z/R7g7fEQlRtz94pv6c2LJlmem3SXt6N/CdFdM0AE0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/qGUdZlMc7iEuwB4NtW/KrLc+79XO6nhPqm3EElwRPY/bve7KKljiNcLzQPD4L9T
	 cN9dswY5vR0qN2qlNpc4D1TthuCtazUDSCdyLmDpAzqKeO2TBU0fZiq1Wy8C6YZJ+c
	 En8TtEKQtqtYFGv4RnpPNSnZWBiV9P2ATIA24tRsS2J8hzEElYGTXwOPDECCV6QeDJ
	 1VBp/T773JkN/7DVALF3hWwQ91HDKU5xOMQlRvpdo4RhW+Qu7jL1gr26IXZKlOJzSU
	 3eUYkMoZX0dfD9mjYc9DbjcsWPLkO7uUF4gOZxrNp4LC2fEsNEX2fSoZKXolsXfk4n
	 jSvo2SqJ8SkzQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/9] wifi: ath12k: add helper function to init partner cmem configuration
Date: Mon,  9 Dec 2024 20:54:15 +0200
Message-Id: <20241209185421.376381-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209185421.376381-1-kvalo@kernel.org>
References: <20241209185421.376381-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

In the Inter Multi-Link Operation, the primary device is expected to receive
the partner device buffer. Therefore, each device initializes the partner
device buffer in their cmem configuration. So add a helper function to
initialize the partner device buffer in their cmem configuration.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  5 ++++-
 drivers/net/wireless/ath/ath12k/dp.c   | 13 +++++++++++++
 drivers/net/wireless/ath/ath12k/dp.h   |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index af642b466ea0..ff79cb910523 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -930,7 +930,7 @@ int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag)
 
 static int ath12k_core_mlo_setup(struct ath12k_hw_group *ag)
 {
-	int ret;
+	int ret, i;
 
 	if (!ag->mlo_capable || ag->num_devices == 1)
 		return 0;
@@ -939,6 +939,9 @@ static int ath12k_core_mlo_setup(struct ath12k_hw_group *ag)
 	if (ret)
 		return ret;
 
+	for (i = 0; i < ag->num_devices; i++)
+		ath12k_dp_partner_cc_init(ag->ab[i]);
+
 	ret = ath12k_mac_mlo_ready(ag);
 	if (ret)
 		goto err_mlo_teardown;
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 9a7df54bf570..9e5a4e75f2f6 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1522,6 +1522,19 @@ static int ath12k_dp_cmem_init(struct ath12k_base *ab,
 	return 0;
 }
 
+void ath12k_dp_partner_cc_init(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+	int i;
+
+	for (i = 0; i < ag->num_devices; i++) {
+		if (ag->ab[i] == ab)
+			continue;
+
+		ath12k_dp_cmem_init(ab, &ag->ab[i]->dp, ATH12K_DP_RX_DESC);
+	}
+}
+
 static int ath12k_dp_cc_init(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index d3f3d39a1cd0..7700828375e3 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1806,6 +1806,7 @@ void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif);
 void ath12k_dp_free(struct ath12k_base *ab);
 int ath12k_dp_alloc(struct ath12k_base *ab);
 void ath12k_dp_cc_config(struct ath12k_base *ab);
+void ath12k_dp_partner_cc_init(struct ath12k_base *ab);
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab);
 void ath12k_dp_pdev_pre_alloc(struct ath12k *ar);
 void ath12k_dp_pdev_free(struct ath12k_base *ab);
-- 
2.39.5


