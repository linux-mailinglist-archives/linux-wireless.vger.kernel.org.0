Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7EC49DA3D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 06:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiA0Fdw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 00:33:52 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:39341 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiA0Fdv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 00:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643261631; x=1674797631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0LNGn4Augm8ykglUCzO1NAeXrbYBC//4ak+/9v2H5R8=;
  b=nheW+XyduqWt8bhChMuvpHMQo1RnDL5gRgSm+D8zqmEiy7kWYhgDW2sJ
   XPK5BbDWO3bdsLttR5uLsSYUB4N4OxUWPIAPIq3dhk2m4uxO9HhxjvWYG
   o78SVgE+rX4F6C7Ajz19JLGGxkeh7WUmFTJ2SN8QlzODorumg7Mevnftv
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 26 Jan 2022 21:33:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:33:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:51 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:49 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH RFC 4/8] ath11k: Cap NSS of HE peer to radio supported NSS
Date:   Thu, 27 Jan 2022 11:03:25 +0530
Message-ID: <1643261609-13500-5-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cap NSS of HE peer to radio supported NSS during assoc, this
is needed as the WCN6750 FW expects peer NSS to be <= radio
supported NSS, this will fix the FW assert because of peer
NSS being greater than max NSS supported by the radio.

Since we are capping the NSS to the NSS that radio supports,
this change should not impact other supported hardware.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2402405..55cdee9 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2274,6 +2274,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 			max_nss = i + 1;
 	}
 	arg->peer_nss = min(sta->rx_nss, max_nss);
+	arg->peer_nss = min_t(u32, arg->peer_nss, ar->num_rx_chains);
 
 	if (arg->peer_phymode == MODE_11AX_HE160 ||
 	    arg->peer_phymode == MODE_11AX_HE80_80) {
-- 
2.7.4

