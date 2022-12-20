Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE23652025
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 13:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiLTMHI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 07:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLTMHG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 07:07:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEF715FD7
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 04:07:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A0CA6132F
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 12:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD1BC433D2;
        Tue, 20 Dec 2022 12:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671538024;
        bh=H8hOmQQXa73xd1vfaYZBM6AE2cK7nY9g5yp5NjMcdZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unmmMtD0wPOaTDkTNSs8pgTQNYNPgSBGuDLpsDn51lkT6oEJWx1PqynePy5fHOHIE
         UG2WC/0r3p6buehOZ4xXPWvZV+jmogsCsqL1ulRAKOC7iVrdxVORqPiVqmF9eUqyaM
         t1/lmgCQ8aFhRDYjcPcPCMds6XpiVHnP5S9FsyHsxx1EBi2XrG68F9r2XS7M81AZpP
         Hd7J3yw5+DwBh72baaSI+afxvaFbV2hu8mLevzPfM8BbMqxGjB6ELQoTKP5jjHaYQU
         av1gXjgriiH/Yqc5Rmpmjh6NJ4RsArv6f04UCekJnzl9mnksODTG1Bn70u/rIG8888
         L7+dik1uXGaCA==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] wifi: ath12k: wmi: delete PSOC_HOST_MAX_NUM_SS
Date:   Tue, 20 Dec 2022 14:06:55 +0200
Message-Id: <20221220120655.19389-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221220120655.19389-1-kvalo@kernel.org>
References: <20221220120655.19389-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Both PSOC_HOST_MAX_NUM_SS and WMI_MAX_NUM_SS are set to 8. The host assumes
that the values are the same but there's no check for that, so things will
break if either of the values change. It's simpler and safer to have just one
define so delete PSOC_HOST_MAX_NUM_SS and use WMI_MAX_NUM_SS everywhere.

No functional changes.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 10 +++++-----
 drivers/net/wireless/ath/ath12k/wmi.h |  4 +---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 338082719631..f6df14149531 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -428,7 +428,7 @@ static int ath12k_pull_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 	arg->ppet.numss_m1 = le32_to_cpu(ev->ppet.numss_m1);
 	arg->ppet.ru_bit_mask = le32_to_cpu(ev->ppet.ru_info);
 
-	for (i = 0; i < PSOC_HOST_MAX_NUM_SS; i++)
+	for (i = 0; i < WMI_MAX_NUM_SS; i++)
 		arg->ppet.ppet16_ppet8_ru3_ru0[i] =
 			le32_to_cpu(ev->ppet.ppet16_ppet8_ru3_ru0[i]);
 
@@ -520,7 +520,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		cap_band->he_ppet.numss_m1 = le32_to_cpu(mac_caps->he_ppet2g.numss_m1);
 		cap_band->he_ppet.ru_bit_mask = le32_to_cpu(mac_caps->he_ppet2g.ru_info);
 
-		for (i = 0; i < PSOC_HOST_MAX_NUM_SS; i++)
+		for (i = 0; i < WMI_MAX_NUM_SS; i++)
 			cap_band->he_ppet.ppet16_ppet8_ru3_ru0[i] =
 				le32_to_cpu(mac_caps->he_ppet2g.ppet16_ppet8_ru3_ru0[i]);
 	}
@@ -541,7 +541,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		cap_band->he_ppet.numss_m1 = le32_to_cpu(mac_caps->he_ppet5g.numss_m1);
 		cap_band->he_ppet.ru_bit_mask = le32_to_cpu(mac_caps->he_ppet5g.ru_info);
 
-		for (i = 0; i < PSOC_HOST_MAX_NUM_SS; i++)
+		for (i = 0; i < WMI_MAX_NUM_SS; i++)
 			cap_band->he_ppet.ppet16_ppet8_ru3_ru0[i] =
 				le32_to_cpu(mac_caps->he_ppet5g.ppet16_ppet8_ru3_ru0[i]);
 
@@ -559,7 +559,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		cap_band->he_ppet.numss_m1 = le32_to_cpu(mac_caps->he_ppet5g.numss_m1);
 		cap_band->he_ppet.ru_bit_mask = le32_to_cpu(mac_caps->he_ppet5g.ru_info);
 
-		for (i = 0; i < PSOC_HOST_MAX_NUM_SS; i++)
+		for (i = 0; i < WMI_MAX_NUM_SS; i++)
 			cap_band->he_ppet.ppet16_ppet8_ru3_ru0[i] =
 				le32_to_cpu(mac_caps->he_ppet5g.ppet16_ppet8_ru3_ru0[i]);
 	}
@@ -1935,7 +1935,7 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 			cpu_to_le32(arg->peer_he_cap_phyinfo[i]);
 	cmd->peer_ppet.numss_m1 = cpu_to_le32(arg->peer_ppet.numss_m1);
 	cmd->peer_ppet.ru_info = cpu_to_le32(arg->peer_ppet.ru_bit_mask);
-	for (i = 0; i < PSOC_HOST_MAX_NUM_SS; i++)
+	for (i = 0; i < WMI_MAX_NUM_SS; i++)
 		cmd->peer_ppet.ppet16_ppet8_ru3_ru0[i] =
 			cpu_to_le32(arg->peer_ppet.ppet16_ppet8_ru3_ru0[i]);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c193aea704a2..84e3fb918e43 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -43,8 +43,6 @@ static inline s32 a_sle32_to_cpu(a_sle32 val)
 	return le32_to_cpu((__force __le32)val);
 }
 
-#define PSOC_HOST_MAX_NUM_SS (8)
-
 /* defines to set Packet extension values which can be 0 us, 8 usec or 16 usec */
 #define MAX_HE_NSS               8
 #define MAX_HE_MODULATION        8
@@ -2233,7 +2231,7 @@ struct ath12k_wmi_pdev_band_arg {
 struct ath12k_wmi_ppe_threshold_arg {
 	u32 numss_m1;
 	u32 ru_bit_mask;
-	u32 ppet16_ppet8_ru3_ru0[PSOC_HOST_MAX_NUM_SS];
+	u32 ppet16_ppet8_ru3_ru0[WMI_MAX_NUM_SS];
 };
 
 #define PSOC_HOST_MAX_PHY_SIZE (3)
-- 
2.30.2

