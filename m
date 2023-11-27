Return-Path: <linux-wireless+bounces-114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0547FA635
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4331C20DC7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C676B374CE;
	Mon, 27 Nov 2023 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsgMvRhK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF42374C5;
	Mon, 27 Nov 2023 16:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BFCC433C7;
	Mon, 27 Nov 2023 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102034;
	bh=s8f7ejt6/6A/AIKa6sJs8NlXnpAnYLCNcVR7yofQBJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JsgMvRhKBl6PnzS9ItHmj3EGCaHJXg/wa2vfw54wgB1WF8Umbv12JcXRE1oEldS2X
	 d+tuMKSmovorfeVEd+H8TX0WgncpcYbkyNTp3GVvb4nEzCdnAhv295QB72ozEAxYEM
	 zY9HFQe0u0BCB+sjaI1y1QEVCRFifdt5jUMCOUyMPYEj0iUFlinaDaUWpgU2bTfeEv
	 RWnROdB9hFH1GoXJtYNxBpKRLkGLWiNuXVI6s5xUBEeMoUaifJiu0X57hBthAnP7AJ
	 colAu1cpiPAlC7xqKlfN4Y+EwsO4FE7bln0CMI9CyuW4O7sZWAvps/cE/9ij7uE79R
	 ojQQ2z2Ntc3hQ==
From: Kalle Valo <kvalo@kernel.org>
To: mhi@lists.linux.dev
Cc: ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH RFC v2 7/8] wifi: ath11k: thermal: don't try to register multiple times
Date: Mon, 27 Nov 2023 18:20:21 +0200
Message-Id: <20231127162022.518834-8-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127162022.518834-1-kvalo@kernel.org>
References: <20231127162022.518834-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Every time the firmware boots we call ath11k_core_qmi_firmware_ready() which
ends up calling ath11k_thermal_register(). So we try to register thermal
devices multiple times. And when we power off the firmware during
suspend/hibernation (implemented in the next patch) we get a warning in resume:

hwmon hwmon4: PM: parent phy0 should not be sleeping

Workaround this similarly like ath11k_mac_register() does by testing
ATH11K_FLAG_REGISTERED.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/thermal.c b/drivers/net/wireless/ath/ath11k/thermal.c
index c9b012f97ba5..80abf472fb87 100644
--- a/drivers/net/wireless/ath/ath11k/thermal.c
+++ b/drivers/net/wireless/ath/ath11k/thermal.c
@@ -162,6 +162,9 @@ int ath11k_thermal_register(struct ath11k_base *ab)
 	struct ath11k_pdev *pdev;
 	int i, ret;
 
+	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
+		return 0;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
-- 
2.39.2


