Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB32752962E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 02:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiEQAs7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 20:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiEQAs7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 20:48:59 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5902C30F4F
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 17:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652748538; x=1684284538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ehcT4+FkHyfIyexUCzwzsh50H4NwjSQI7EjsJIMzAPc=;
  b=bPqiOz/h1DBHPjpINvYjv74c8vCMh58OoC/YEnfggZUGsVEmase8T3Gr
   5PT1I2XkDJPv58J1cCiC6l1tRCrStvpf4tOAcOm2bvxnd/weXQQU++ncw
   DW5o4ghxY2CrZa6Vz6fa8xsVCrF4Pu1+ai4JctYx/3ebgmA5r5iavboWq
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 May 2022 17:48:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 17:48:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 17:48:57 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 17:48:56 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] ath11k: Fix warning on variable 'sar' dereference before check
Date:   Tue, 17 May 2022 08:48:44 +0800
Message-ID: <20220517004844.2412660-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are seeing below warning:
warn: variable dereferenced before check 'sar'

Fix it by moving ahead pointer check on 'sar'.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Fixes: 652f69ed9c1b ("ath11k: Add support for SAR")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ee1590b16eff..7d574ad67e59 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8297,11 +8297,15 @@ static int ath11k_mac_op_set_bios_sar_specs(struct ieee80211_hw *hw,
 					    const struct cfg80211_sar_specs *sar)
 {
 	struct ath11k *ar = hw->priv;
-	const struct cfg80211_sar_sub_specs *sspec = sar->sub_specs;
+	const struct cfg80211_sar_sub_specs *sspec;
 	int ret, index;
 	u8 *sar_tbl;
 	u32 i;
 
+	if (!sar || sar->type != NL80211_SAR_TYPE_POWER ||
+	    sar->num_sub_specs == 0)
+		return -EINVAL;
+
 	mutex_lock(&ar->conf_mutex);
 
 	if (!test_bit(WMI_TLV_SERVICE_BIOS_SAR_SUPPORT, ar->ab->wmi_ab.svc_map) ||
@@ -8310,12 +8314,6 @@ static int ath11k_mac_op_set_bios_sar_specs(struct ieee80211_hw *hw,
 		goto exit;
 	}
 
-	if (!sar || sar->type != NL80211_SAR_TYPE_POWER ||
-	    sar->num_sub_specs == 0) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
 	ret = ath11k_wmi_pdev_set_bios_geo_table_param(ar);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to set geo table: %d\n", ret);
@@ -8328,6 +8326,7 @@ static int ath11k_mac_op_set_bios_sar_specs(struct ieee80211_hw *hw,
 		goto exit;
 	}
 
+	sspec = sar->sub_specs;
 	for (i = 0; i < sar->num_sub_specs; i++) {
 		if (sspec->freq_range_index >= (BIOS_SAR_TABLE_LEN >> 1)) {
 			ath11k_warn(ar->ab, "Ignore bad frequency index %u, max allowed %u\n",

base-commit: 14c24bc11b43da59fe41d79d3c1b29decc3d21f3
-- 
2.25.1

