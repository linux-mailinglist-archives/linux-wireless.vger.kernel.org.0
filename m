Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6E84EF8FC
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350115AbiDARcn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 13:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350111AbiDARcl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 13:32:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E1D1AA8E6
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 10:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D690B82593
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 17:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ADAC3410F;
        Fri,  1 Apr 2022 17:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648834249;
        bh=9u43NB96IkwkW9C2rkSjk9B1Oivm1z1nwWy7IAMbEYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMLd7n/kEO2kTox1PZXfGkjsy/2uQuDt0UWz5kyVS22ARjDU/ly4iN8wRTK3NK9K9
         xl0eC4otonisR2duGb1ot6gyadQnjwUv/IpkjbutDLzgawU2/ilwAF8F0EguM8sfJ5
         oF11KPnrRPLSZkX07kR12l53M9V4f7tkIn/ClcpAqqfPbUNR9uWxLC6g/K34jwJkH/
         ha5kBkA16Rmysyy3qzWGKRJBqpyx2FL0SKlres/1d0tTdlcwqNvbu01oIk7hw8jAIh
         KRUw/O5Fx7kmMUw5srJtZi8z/OOoOlcfYnUocZnvxteD9XwGuB+NX3+nRLd3yBxwqQ
         KSa6lEUiNAFlQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] ath11k: mhi: remove unnecessary goto from ath11k_mhi_start()
Date:   Fri,  1 Apr 2022 20:30:42 +0300
Message-Id: <20220401173042.17467-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220401173042.17467-1-kvalo@kernel.org>
References: <20220401173042.17467-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

No need to have goto for a return statement, so simplify the code. While at it,
print warning messages if power up calls fail.

No functional changes.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 706de7b0b4a1..a372ebb184a1 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -463,22 +463,24 @@ void ath11k_mhi_unregister(struct ath11k_pci *ab_pci)
 
 int ath11k_mhi_start(struct ath11k_pci *ab_pci)
 {
+	struct ath11k_base *ab = ab_pci->ab;
 	int ret;
 
 	ab_pci->mhi_ctrl->timeout_ms = MHI_TIMEOUT_DEFAULT_MS;
 
 	ret = mhi_prepare_for_power_up(ab_pci->mhi_ctrl);
-	if (ret)
-		goto out;
+	if (ret) {
+		ath11k_warn(ab, "failed to prepare mhi: %d", ret);
+		return ret;
+	}
 
 	ret = mhi_sync_power_up(ab_pci->mhi_ctrl);
-	if (ret)
-		goto out;
+	if (ret) {
+		ath11k_warn(ab, "failed to power up mhi: %d", ret);
+		return ret;
+	}
 
 	return 0;
-
-out:
-	return ret;
 }
 
 void ath11k_mhi_stop(struct ath11k_pci *ab_pci)
-- 
2.30.2

