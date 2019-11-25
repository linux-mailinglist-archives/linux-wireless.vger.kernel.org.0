Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1511091F2
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 17:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfKYQgV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 11:36:21 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:32822
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbfKYQgV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 11:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574699780;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=yfaZZPfeLlBJdrxz5mNJUpngArjVZ7ITlgiM98PmCCc=;
        b=RyapTd1PtHT0CZW9vTE1K4cp9qpFnV1ummDdeNlxJqWZTt8Es4koEXiizX2HbaRX
        qzkicLD2TtDC7/Oh1GzTyUSo9zh1LqGLVx71B2F9oXCgg5/4Rg3VIC5trYpjYHQcSAA
        pGN2SMQTjX9DQ7msO7Cd7JnOLnb21yloAvTUJa+4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574699780;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=yfaZZPfeLlBJdrxz5mNJUpngArjVZ7ITlgiM98PmCCc=;
        b=XuzI/rWmubb8NC4EnYo/JqUZtrg2TJvp7v5jo7kt/S6i2K4pD7gEgi87NkJsds2d
        Tk+3Y5o1Eqf2cwgX1PlqoVPOeR2i/M7LUTCQJ9er7jSDXjMZI+fxtE4gArltxlRJssa
        5dmN7bwicR9vN0h+VzEfuMAJCHuHjtgQFdk7Z/8E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F655C4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 2/8] ath11k: ignore event 0x6017
Date:   Mon, 25 Nov 2019 16:36:19 +0000
Message-ID: <0101016ea36bc740-09f7a971-81f3-48db-9b4a-567c8a2ebc48-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
References: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.25-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Everytime a new peer gets associated, we see the following message in the log
- ath11k c000000.wifi1: Unknown eventid: 0x6017
Ignore this event for now. We probably need to handle the event properly when
we add OMI support.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c |  1 +
 drivers/net/wireless/ath/ath11k/wmi.h | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 3d1d4d3c3f20..3ec5dd47cdc8 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5416,6 +5416,7 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_VDEV_DELETE_RESP_EVENTID:
+	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
 			   "ignoring unsupported event 0x%x\n", id);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 00c51cc83d47..1110da29cfcd 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -288,7 +288,6 @@ enum wmi_tlv_cmd_id {
 	WMI_PEER_REORDER_QUEUE_REMOVE_CMDID,
 	WMI_PEER_SET_RX_BLOCKSIZE_CMDID,
 	WMI_PEER_ANTDIV_INFO_REQ_CMDID,
-	WMI_PEER_OPER_MODE_CHANGE_EVENTID,
 	WMI_BCN_TX_CMDID = WMI_TLV_CMD(WMI_GRP_MGMT),
 	WMI_PDEV_SEND_BCN_CMDID,
 	WMI_BCN_TMPL_CMDID,
@@ -586,6 +585,18 @@ enum wmi_tlv_event_id {
 	WMI_WDS_PEER_EVENTID,
 	WMI_PEER_STA_PS_STATECHG_EVENTID,
 	WMI_PEER_ANTDIV_INFO_EVENTID,
+	WMI_PEER_RESERVED0_EVENTID,
+	WMI_PEER_RESERVED1_EVENTID,
+	WMI_PEER_RESERVED2_EVENTID,
+	WMI_PEER_RESERVED3_EVENTID,
+	WMI_PEER_RESERVED4_EVENTID,
+	WMI_PEER_RESERVED5_EVENTID,
+	WMI_PEER_RESERVED6_EVENTID,
+	WMI_PEER_RESERVED7_EVENTID,
+	WMI_PEER_RESERVED8_EVENTID,
+	WMI_PEER_RESERVED9_EVENTID,
+	WMI_PEER_RESERVED10_EVENTID,
+	WMI_PEER_OPER_MODE_CHANGE_EVENTID,
 	WMI_MGMT_RX_EVENTID = WMI_TLV_CMD(WMI_GRP_MGMT),
 	WMI_HOST_SWBA_EVENTID,
 	WMI_TBTTOFFSET_UPDATE_EVENTID,
-- 
2.7.4

