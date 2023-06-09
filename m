Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA2729CBF
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbjFIOZO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241241AbjFIOYv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:24:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8530E7
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4BCC6588A
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C7EC433EF;
        Fri,  9 Jun 2023 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320690;
        bh=bIXOhkdYQhSQR8JZ30iIBHwinCo/evyXgSHTlkstMps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClblRSdF8vJkfKZWMrdoLmUohHlT3uySzpTv/CfUiqyxp1n2Eg3aAwn7Eyz1vjZd7
         hlWkGo6pqTZJq2r7FrDf83JXm6p4+nOLSge0yA3GVVutjmraWf8pVbm2G8f9aV5ePc
         mMwpPBMV6MSJjDrXwy/yC+svwVZ88dzRkAJ5NelEq/6Q/w1EJka7Oa5i948CFTXSGN
         APES1I0VhoWePVnwGH5UX4GgDATuDR/v5kmbQ/uF9iESxpNNBg3xhPv5PnCcux7aFS
         39LuSkybmoJeeWFkz7bl4AbeEU7VPrTmfXPrJy0Y9BDvywBBnrMV/4ifEyoHR3+7Aa
         BM6a43nSNC9Dw==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 06/15] wifi: ath11k: wmi: cleanup error handling in ath11k_wmi_send_init_country_cmd()
Date:   Fri,  9 Jun 2023 17:24:31 +0300
Message-Id: <20230609142440.24643-7-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609142440.24643-1-kvalo@kernel.org>
References: <20230609142440.24643-1-kvalo@kernel.org>
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

The error handling doesn't follow the preferred style so fix that.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 6ce36879a503..3b26e227e80c 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2866,21 +2866,25 @@ ath11k_wmi_send_init_country_cmd(struct ath11k *ar,
 		cmd->cc_info.regdom_id = init_cc_params.cc_info.regdom_id;
 		break;
 	default:
+		ath11k_warn(ar->ab, "unknown cc params flags: 0x%x",
+			    init_cc_params.flags);
 		ret = -EINVAL;
-		goto out;
+		goto err;
 	}
 
 	ret = ath11k_wmi_cmd_send(wmi, skb,
 				  WMI_SET_INIT_COUNTRY_CMDID);
-
-out:
 	if (ret) {
 		ath11k_warn(ar->ab,
 			    "failed to send WMI_SET_INIT_COUNTRY CMD :%d\n",
 			    ret);
-		dev_kfree_skb(skb);
+		goto err;
 	}
 
+	return 0;
+
+err:
+	dev_kfree_skb(skb);
 	return ret;
 }
 
-- 
2.30.2

