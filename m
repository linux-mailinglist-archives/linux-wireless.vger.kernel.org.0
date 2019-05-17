Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C3216AD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfEQKF1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 06:05:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbfEQKF1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 06:05:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 81A5160E40; Fri, 17 May 2019 10:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558087526;
        bh=3FI+6YxD0MYgDR1vZht6lE9W7jGoaioQtNuUb8hI5Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cz/ghU3ahjbA7G5CeJhZC5pO7SZ5evlFbMeEttDIJ/GwRUnGct3PXlIr/cEC91JRB
         SrG/OmJzgXWRF+MgXUxEv1LK0ofxCG2MpORQRclhhOGtaGst8ZEzK3sBwEInC58eTN
         v0Du+IPi/g38/W+7HMHxJuZgkeQXYw9zsAkVN7ms=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from aambure-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aambure@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1EA060E3E;
        Fri, 17 May 2019 10:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558087526;
        bh=3FI+6YxD0MYgDR1vZht6lE9W7jGoaioQtNuUb8hI5Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cz/ghU3ahjbA7G5CeJhZC5pO7SZ5evlFbMeEttDIJ/GwRUnGct3PXlIr/cEC91JRB
         SrG/OmJzgXWRF+MgXUxEv1LK0ofxCG2MpORQRclhhOGtaGst8ZEzK3sBwEInC58eTN
         v0Du+IPi/g38/W+7HMHxJuZgkeQXYw9zsAkVN7ms=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1EA060E3E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aambure@codeaurora.org
From:   Abhishek Ambure <aambure@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Abhishek Ambure <aambure@codeaurora.org>
Subject: [PATCH 2/2] ath10k: correct wmi_tlv command params to enable pktlog for WCN3990
Date:   Fri, 17 May 2019 15:35:16 +0530
Message-Id: <1558087516-666-3-git-send-email-aambure@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558087516-666-1-git-send-email-aambure@codeaurora.org>
References: <1558087516-666-1-git-send-email-aambure@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PKT log enable command expects pdev id in enable params which is missing
in current configuration. Fill pdev id in pkt log enable wmi command for
correct configuration.

Fixes: ca996ec56608 ("ath10k: implement wmi-tlv backend")
Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-00963-QCAHLSWMTPL-1

Signed-off-by: Abhishek Ambure <aambure@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 2 ++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 582fb11..8a209f8 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -2981,6 +2981,8 @@ static void *ath10k_wmi_tlv_put_wmm(void *ptr,
 	tlv->len = __cpu_to_le16(sizeof(*cmd));
 	cmd = (void *)tlv->value;
 	cmd->filter = __cpu_to_le32(filter);
+	cmd->pdev_id = __cpu_to_le32(0);
+	cmd->reserved = __cpu_to_le32(0);
 
 	ptr += sizeof(*tlv);
 	ptr += sizeof(*cmd);
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.h b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
index 65e6aa5..5226283 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -1923,6 +1923,7 @@ struct wmi_tlv_vdev_stats {
 } __packed;
 
 struct wmi_tlv_pktlog_enable {
+	__le32 pdev_id;
 	__le32 reserved;
 	__le32 filter;
 } __packed;
-- 
1.9.1

