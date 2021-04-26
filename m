Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068B436B9A3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 21:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhDZTG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 15:06:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35783 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233464AbhDZTG2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 15:06:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619463946; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=iPDSFuKc5Tfrz/NQSjCNOIONCtgxmE1s+TK9MwRkbVQ=; b=Zke5sElamF1BWIr8d5LuyMlnzu2+ENngimpsEkDvUd2AaY3FlnwkIcZG60MLVbpS7qIrlkaV
 2eoJ0XlT0PId7R51tDvZNmF2Cd57ANApyy5bDIWtdXOuUWjx90NyVgHvmPO8AoilDf10jxpa
 Plo8WGGtF+LrA0W57mxuDjlorMs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60870f0af34440a9d4a2d6d4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Apr 2021 19:05:46
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4CAFEC43144; Mon, 26 Apr 2021 19:05:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8EF6C433D3;
        Mon, 26 Apr 2021 19:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8EF6C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v10 4/4] mac80211: CSA on non-transmitting interfaces
Date:   Mon, 26 Apr 2021 12:05:34 -0700
Message-Id: <20210426190534.12667-5-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426190534.12667-1-alokad@codeaurora.org>
References: <20210426190534.12667-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Trigger ieee80211_csa_finish() on the non-transmitting interfaces
when channel switch concludes on the transmitting interface.

The mutex wiphy->mtx is released before locking sdata->local->iflist_mtx
to avoid deadlock with any other code path which may be using the same
mutexes in opposite order.

Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v10: Used iflist_mtx instead of rcu_read_lock() as most other accesses
     to sdata->local->interfaces do so.

 net/mac80211/cfg.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index db21e1a621b1..5ca75a23d54c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3254,8 +3254,21 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 
-	ieee80211_queue_work(&sdata->local->hw,
-			     &sdata->csa_finalize_work);
+	if (sdata->vif.mbssid.flags & IEEE80211_VIF_MBSSID_TX) {
+		struct ieee80211_sub_if_data *child;
+
+		wiphy_unlock(sdata->local->hw.wiphy);
+		mutex_lock(&sdata->local->iflist_mtx);
+		list_for_each_entry(child, &sdata->local->interfaces, list)
+			if (child->vif.mbssid.parent == vif &&
+			    ieee80211_sdata_running(child))
+				ieee80211_queue_work(&child->local->hw,
+						     &child->csa_finalize_work);
+		mutex_unlock(&sdata->local->iflist_mtx);
+		wiphy_lock(sdata->local->hw.wiphy);
+	}
+
+	ieee80211_queue_work(&sdata->local->hw, &sdata->csa_finalize_work);
 }
 EXPORT_SYMBOL(ieee80211_csa_finish);
 
-- 
2.31.1

