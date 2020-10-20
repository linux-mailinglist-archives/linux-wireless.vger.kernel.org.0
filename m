Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBF729421E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390185AbgJTSb0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 14:31:26 -0400
Received: from z5.mailgun.us ([104.130.96.5]:36470 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390119AbgJTSbZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 14:31:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603218685; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=6vVnGA4PxuyQ/Qlmrr2ztitii1Gs/yi5o9JkBmPqHHY=; b=GqEQosdxVP8qAN7BOv9Y0jcNnjYiftxUcCC+8ZZ5NgPGvasWnz+5LP4wHeTM8++zckZBL7MY
 hbqVQdwhz0iX4GlWMkIeWM1LDVhr3sWLhuP+N6dppTN+7UWIk0jbfptlgQV/A4tINPf8xN4z
 XuWiVTExh2izO9Q7ckBJKSPkuUo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f8f2cfaf9168450ea03f0be (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Oct 2020 18:31:22
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77681C433FE; Tue, 20 Oct 2020 18:31:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8FE8AC43382;
        Tue, 20 Oct 2020 18:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FE8AC43382
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v2 3/4] ath11k: support TXOP duration based RTS threshold
Date:   Tue, 20 Oct 2020 11:31:10 -0700
Message-Id: <20201020183111.25458-4-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020183111.25458-1-pradeepc@codeaurora.org>
References: <20201020183111.25458-1-pradeepc@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HE operation IE in beacons is constructed based on userspace params,
which firmware might not be aware of. This causes firmware not to
configure TXOP duration based RTS threshold which could cause mismatch
in behaviour with respect to what is being advertised in beacons. This
patch sends HE operation IE fetched from beacon to firmware using
WMI interface for configuration.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7f8dd47d2333..b44b67760e02 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1948,9 +1948,25 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BSSID && !is_zero_ether_addr(info->bssid))
 		ether_addr_copy(arvif->bssid, info->bssid);
 
-	if (changed & BSS_CHANGED_BEACON_ENABLED)
+	if (changed & BSS_CHANGED_BEACON_ENABLED) {
 		ath11k_control_beaconing(arvif, info);
 
+		if (arvif->is_up && vif->bss_conf.he_support &&
+		    vif->bss_conf.he_oper.params) {
+			param_id = WMI_VDEV_PARAM_HEOPS_0_31;
+			param_value = vif->bss_conf.he_oper.params;
+			ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+							    param_id, param_value);
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+				   "he oper param: %x set for VDEV: %d\n",
+				   param_value, arvif->vdev_id);
+
+			if (ret)
+				ath11k_warn(ar->ab, "Failed to set he oper params %x for VDEV %d: %i\n",
+					    param_value, arvif->vdev_id, ret);
+		}
+	}
+
 	if (changed & BSS_CHANGED_ERP_CTS_PROT) {
 		u32 cts_prot;
 
-- 
2.17.1

