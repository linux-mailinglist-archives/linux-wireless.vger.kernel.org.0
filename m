Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD7E3D18F8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 23:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhGUUkj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 16:40:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57368 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhGUUkj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 16:40:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626902475; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zjV4jmZT73UwCRIovvhGz/A7dljJJOvqTPpXAp2qC80=; b=jIcSAcSItNxGVqk8kfO6uze7CueVymYYFlQStbFdiin8k1BX3cKWsBFpPdN/vNA6eR4/QiZ0
 S7AKNfBUNfkoyfKlTCJUQWi98c4s7fCT+lNuYpfzw/a9KSt2R7FKiC3G1kOX9fRgNCdHowxe
 KRNIdkzPziCJEZcR7LTclrqkeUI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60f88fc196a66e66b2b40ed3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 21:21:04
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6AB3C433D3; Wed, 21 Jul 2021 21:21:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49F98C4360C;
        Wed, 21 Jul 2021 21:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49F98C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 09/12] ath11k: Add wmi peer create conf event in wmi_tlv_event_id
Date:   Thu, 22 Jul 2021 00:20:26 +0300
Message-Id: <20210721212029.142388-9-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721212029.142388-1-jouni@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: P Praneesh <ppranees@codeaurora.org>

When the driver sends a peer create cmd, the firmware responds with
WMI_PEER_CREATE_CONF_EVENTID to confirm the firmware received
WMI_PEER_CREATE_CMDID. Since the peer create conf event is not handled
in ath11k_wmi_tlv_op_rx, we are getting unknown event id warning prints
during peer creation.

Add WMI_PEER_CREATE_CONF_EVENTID in wmi_tlv_event_id and handle
the same as unsupported event id under wmi logs.

warning prints:
[ 4382.230817] ath11k_pci 0000:01:00.0: Unknown eventid: 0x601a

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <ppranees@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 1 +
 drivers/net/wireless/ath/ath11k/wmi.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 020b2b7ee3c8..6d2696db1e07 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7130,6 +7130,7 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_TWT_ENABLE_EVENTID:
 	case WMI_TWT_DISABLE_EVENTID:
 	case WMI_PDEV_DMA_RING_CFG_RSP_EVENTID:
+	case WMI_PEER_CREATE_CONF_EVENTID:
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
 			   "ignoring unsupported event 0x%x\n", id);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 16b3f48bb378..2587d22f42ce 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -663,6 +663,9 @@ enum wmi_tlv_event_id {
 	WMI_PEER_RESERVED9_EVENTID,
 	WMI_PEER_RESERVED10_EVENTID,
 	WMI_PEER_OPER_MODE_CHANGE_EVENTID,
+	WMI_PEER_TX_PN_RESPONSE_EVENTID,
+	WMI_PEER_CFR_CAPTURE_EVENTID,
+	WMI_PEER_CREATE_CONF_EVENTID,
 	WMI_MGMT_RX_EVENTID = WMI_TLV_CMD(WMI_GRP_MGMT),
 	WMI_HOST_SWBA_EVENTID,
 	WMI_TBTTOFFSET_UPDATE_EVENTID,
-- 
2.25.1

