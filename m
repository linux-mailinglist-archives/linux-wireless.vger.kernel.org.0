Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980BC152470
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 02:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgBEBWo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Feb 2020 20:22:44 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:47055 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727745AbgBEBWo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Feb 2020 20:22:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580865763; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=nvU8Bm7e64yia8HQ3RtvUNluoAWYe9/80/taN/q3odc=; b=niZal6Mmzcp1n4k0yzGgUvNORL0dPDHeCYYf00WWRsKju2SlJ5Gu/fhngHZavCYivG3by9rh
 BGMj5fBekrX+/G+qVaxYNYdPQF0+9zqIv3fJX5nHzr/xV+BGVvAn3+jJfgA+GiiVSHQfRdCY
 O0IWGS2GvB/PKX+U+VnaY5xwc8I=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3a18e0.7effc153fa40-smtp-out-n02;
 Wed, 05 Feb 2020 01:22:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A5CDC433CB; Wed,  5 Feb 2020 01:22:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from CHECSTP284781-LIN.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59258C43383;
        Wed,  5 Feb 2020 01:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59258C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] ath11k: fix rcu lock protect in peer assoc confirmation
Date:   Wed,  5 Feb 2020 06:52:28 +0530
Message-Id: <1580865748-31286-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath11k_mac_get_ar_by_vdev_id() get protected under rcu lock
and unlock. peer association confirmation event get used this API
without rcu protection, so corrected it.

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index a9b301c..9cbe038d 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5345,15 +5345,18 @@ static void ath11k_peer_assoc_conf_event(struct ath11k_base *ab, struct sk_buff
 		   "peer assoc conf ev vdev id %d macaddr %pM\n",
 		   peer_assoc_conf.vdev_id, peer_assoc_conf.macaddr);
 
+	rcu_read_lock();
 	ar = ath11k_mac_get_ar_by_vdev_id(ab, peer_assoc_conf.vdev_id);
 
 	if (!ar) {
 		ath11k_warn(ab, "invalid vdev id in peer assoc conf ev %d",
 			    peer_assoc_conf.vdev_id);
+		rcu_read_unlock();
 		return;
 	}
 
 	complete(&ar->peer_assoc_done);
+	rcu_read_unlock();
 }
 
 static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *skb)
-- 
1.9.1
