Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6BB729CBA
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbjFIOZM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbjFIOYv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:24:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF9930CB
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B278C612DC
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D91FC4339B;
        Fri,  9 Jun 2023 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320689;
        bh=w9jTiH5RnEdZVrbY21BlNuf+p+Weoy31ragwGttVmC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBlh3kZOaR8fe+jV7yi4wtiAivSjWbFfdPS6WuYUaleuAIyy5RJt4tV5PE/5/Eik6
         QxtMCqxlT1JE3he7EuvRsJKu4pnYkYNan6kowY+UpQOcL+XdO+nFC9XlRUbEs3ZVMF
         iamZdBNeYuttJ9nvSRhaGoAHvwspIlli1OjF5tEC8WXsbSExzUfp2xIRr4pCg2trk+
         WmWmLS0GihVwQgh+0lVGw+787hGY4SbGQXIVd70DOsy1Gj9JpYUYu6xpeTzMPQzTgO
         iv1YPmKn+PABV18QPkfmPNxzPu3CHeUvrWSIjQIhfNaztjd/KA0EwKLLVrkqbj7M2f
         bDh5RTrxWdYAg==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 05/15] wifi: ath11k: remove unsupported event handlers
Date:   Fri,  9 Jun 2023 17:24:30 +0300
Message-Id: <20230609142440.24643-6-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609142440.24643-1-kvalo@kernel.org>
References: <20230609142440.24643-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Now that we have a default handler there's no need anymore to list every
unsupported event id anymore, so remove that to clean this up.

While at it remove the pointless todo comment and change the debug message to
follow the preferred style.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 99beb7636835..6ce36879a503 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8663,19 +8663,6 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_TWT_ADD_DIALOG_EVENTID:
 		ath11k_wmi_twt_add_dialog_event(ab, skb);
 		break;
-	/* add Unsupported events here */
-	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
-	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
-	case WMI_TWT_ENABLE_EVENTID:
-	case WMI_TWT_DISABLE_EVENTID:
-	case WMI_TWT_DEL_DIALOG_EVENTID:
-	case WMI_TWT_PAUSE_DIALOG_EVENTID:
-	case WMI_TWT_RESUME_DIALOG_EVENTID:
-	case WMI_PDEV_DMA_RING_CFG_RSP_EVENTID:
-	case WMI_PEER_CREATE_CONF_EVENTID:
-		ath11k_dbg(ab, ATH11K_DBG_WMI,
-			   "ignoring unsupported event 0x%x\n", id);
-		break;
 	case WMI_PDEV_DFS_RADAR_DETECTION_EVENTID:
 		ath11k_wmi_pdev_dfs_radar_detected_event(ab, skb);
 		break;
@@ -8697,9 +8684,8 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_GTK_OFFLOAD_STATUS_EVENTID:
 		ath11k_wmi_gtk_offload_status_event(ab, skb);
 		break;
-	/* TODO: Add remaining events */
 	default:
-		ath11k_dbg(ab, ATH11K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
+		ath11k_dbg(ab, ATH11K_DBG_WMI, "unsupported event id 0x%x\n", id);
 		break;
 	}
 
-- 
2.30.2

