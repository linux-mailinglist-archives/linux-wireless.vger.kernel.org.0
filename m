Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F4B1C5FB1
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 20:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgEESJ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 14:09:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57266 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729315AbgEESJ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 14:09:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588702168; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=e+cNv4pp0MnD6PBcCuO7QvvHJHPqO4LqyJPULd9ZkI8=; b=dHUBkdW7rgBQFWK7VRNszL9UJOAKuiwqhxS3HunsfEzfncPevM3Aw8a0y86GDz6iGqF4GfZ/
 92xBShVgFS/eJqwU2amHl+FvkZOYw3Ev7+3n8DsHjCG4xR0Xu0UG4lhxBsHYVBjvIYObVf/k
 5hl3cmdIxA/+hMFfClHMkbkHv7w=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb1abc9.7fea82f08928-smtp-out-n01;
 Tue, 05 May 2020 18:09:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5EF66C433CB; Tue,  5 May 2020 18:09:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from c-gsamin-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: seevalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E1F2C433F2;
        Tue,  5 May 2020 18:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E1F2C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=seevalam@codeaurora.org
From:   Seevalamuthu Mariappan <seevalam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>
Subject: [PATCH] mac80211: Fix station dump inactive time after sta connection
Date:   Tue,  5 May 2020 23:38:46 +0530
Message-Id: <1588702126-11364-1-git-send-email-seevalam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When USES_RSS is enabled, last_rx becomes zero in first few
minutes after sta connection in sta_get_last_rx_stats. This
leads to inactive time showing current jiffies in msecs.

Station 8c:fd:f0:02:10:dd (on wlan0)
        inactive time:  4294701656 ms
          .
          .
        connected time: 2 seconds

Fix this by avoid overwriting last_rx with percpu_stat's last_rx
if it is zero.

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
---
 net/mac80211/sta_info.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f8d5c25..df40c0a 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2089,6 +2089,9 @@ u8 sta_info_tx_streams(struct sta_info *sta)
 
 		cpustats = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
 
+		if (!cpustats->last_rx)
+			continue;
+
 		if (time_after(cpustats->last_rx, stats->last_rx))
 			stats = cpustats;
 	}
-- 
1.9.1
