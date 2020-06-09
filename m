Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D561F37B5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgFIKQP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 06:16:15 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21739 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726286AbgFIKQN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 06:16:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591697773; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=SYZHDKFLt090IsjvZsaPJmHjYGvqOYYhHiC5BrpK1/o=; b=VMe3qxrou/m3h3G/L7WNzcFt3LvhqjnDJ74R4P9rC/Jyx3XH6t4TIwCaYv7jmbjaBbOobJQt
 Yuf36AJ+jhgElXgzqaWI+ZJpai+el8J/s5siQkeUZPi1ukpX66ZD+3uz94UDakzLlnP2uuYW
 CVy2qR/9yttKINIiZPtbIuwwfCA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5edf616c0206ad41d1dcc862 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 10:16:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 23835C43387; Tue,  9 Jun 2020 10:16:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from seevalam-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: seevalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 701EEC433CA;
        Tue,  9 Jun 2020 10:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 701EEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=seevalam@codeaurora.org
From:   Seevalamuthu Mariappan <seevalam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>
Subject: [PATCH] mac80211: Fix dropping broadcast packets in 802.11 encap
Date:   Tue,  9 Jun 2020 15:45:54 +0530
Message-Id: <1591697754-4975-1-git-send-email-seevalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Broadcast pkts like arp are getting dropped in 'ieee80211_8023_xmit'.
Fix this by replacing is_valid_ether_addr api with is_zero_ether_addr.

Fixes: 50ff477a8639 ("mac80211: add 802.11 encapsulation offloading support")
Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e9ce658..3374df0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4206,7 +4206,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	    (!sta || !test_sta_flag(sta, WLAN_STA_TDLS_PEER)))
 		ra = sdata->u.mgd.bssid;
 
-	if (!is_valid_ether_addr(ra))
+	if (is_zero_ether_addr(ra))
 		goto out_free;
 
 	multicast = is_multicast_ether_addr(ra);
-- 
2.7.4

