Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EFE512993
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Apr 2022 04:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiD1Cgx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 22:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241567AbiD1Cgw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 22:36:52 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DA099695
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651113218; x=1682649218;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CLYNYNqMRNLAa9ekYqI5LWGrZYM8agx/nL847tzuF4Q=;
  b=TzBR1dUq2JOgRZobfdllxlPq+bpIum3iMva215VJVAtqYSspdjXr2dKl
   qxR8gVmEG/TMhiq1yuIQEdyJSLyIj1Gn4vwHPdScr168Usjg/ilxErsk0
   eVbtWAs8fJEvgg6RBqPFqY8qNPZS9X3T7R+BB2+4CihN2+4ZjBxa2t6lK
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2022 19:33:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 19:33:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 19:33:37 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 19:33:35 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: change management tx queue to avoid connection timed out
Date:   Wed, 27 Apr 2022 22:33:20 -0400
Message-ID: <20220428023320.4007-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the phase of wlan load, it has hw scan and 11d scan which sent to
firmware by ath11k, then hw scan and 11d scan will use about 14 seconds,
and meanwhile ath11k_reg_update_chan_list() is running in workqueue of
ath11k_base, and wait for 11d scan/hw scan finished. When the hw scan
finished, mac80211 will start to connect and send management packet,
at this moment, ath11k_reg_update_chan_list() is still waiting for 11d
scan finished, so wmi_mgmt_tx_work of ath11k will not run and thus the
tx management packet also not send out and lead authentication timed
out.

log:
INFO kernel: [  187.885322] wlan0: authenticate with 72:6c:57:43:9f:90
INFO kernel: [  187.937266] wlan0: send auth to 72:6c:57:43:9f:90 (try 1/3)
INFO kernel: [  188.626944] wlan0: send auth to 72:6c:57:43:9f:90 (try 2/3)
INFO kernel: [  189.650999] wlan0: send auth to 72:6c:57:43:9f:90 (try 3/3)
INFO kernel: [  190.651917] wlan0: authentication with 72:6c:57:43:9f:90 timed out

Change wmi_mgmt_tx_work to another queue workqueue_aux of ath11k_base,
then connection success.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index da994d89d69d..1957e1713548 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5600,7 +5600,7 @@ static int ath11k_mac_mgmt_tx(struct ath11k *ar, struct sk_buff *skb,
 
 	skb_queue_tail(q, skb);
 	atomic_inc(&ar->num_pending_mgmt_tx);
-	queue_work(ar->ab->workqueue, &ar->wmi_mgmt_tx_work);
+	queue_work(ar->ab->workqueue_aux, &ar->wmi_mgmt_tx_work);
 
 	return 0;
 }

base-commit: 3637b73b8e805d011202e2bf10947f2d206695d4
-- 
2.31.1

