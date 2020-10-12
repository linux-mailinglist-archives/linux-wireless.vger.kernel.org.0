Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D188228B217
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 12:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgJLKRn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 06:17:43 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:64035 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLKRm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 06:17:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602497861; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=UPiWIf3a7g6nBgwN1U/mK17E/USuMUjgFV9Ty/FOJLE=; b=aCO3hvCwuXWzbni7UjLX3S7If66plC5KxHzbbIs1TK1k0YBqJxTPiKPiJHiibu7G7ph4Q57S
 1enzNLc+y1Ti8W5mDrbGA8MO/TaX/ymOLayO28KhQW9scexAgEwh+3arVreuuf6ir3hRP8+V
 yo2ukCqrkBmROlQtYuY9uLCvtUo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f842d45d6d00c7a9e6a235c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Oct 2020 10:17:41
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54226C433CB; Mon, 12 Oct 2020 10:17:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-station.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C26AC433C9;
        Mon, 12 Oct 2020 10:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C26AC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: fix ZERO address in probe request
Date:   Mon, 12 Oct 2020 18:17:33 +0800
Message-Id: <20201012101733.24137-1-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Host needs to pass at least on bssid with all 0xff to firmware in
WMI_START_SCAN_CMDID, otherwise the bssid and receiver address
in probe requeste are all ZEROs.

This also fixed some hidden AP connection issue because some AP
doesn't respond to probe request which receiver address are all
ZEROs.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index adde14a390ec..9e56544e2cb9 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1946,6 +1946,11 @@ void ath11k_wmi_start_scan_init(struct ath11k *ar,
 				  WMI_SCAN_EVENT_DEQUEUED;
 	arg->scan_flags |= WMI_SCAN_CHAN_STAT_EVENT;
 	arg->num_bssid = 1;
+	/* fill bssid_list[0] with 0xff, otherwise
+	 * bssid and RA will be ZEROs in probe request.
+	 */
+	eth_broadcast_addr(arg->bssid_list[0].addr);
+
 }
 
 static inline void
-- 
2.28.0

