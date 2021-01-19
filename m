Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090EC2FB3CB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 09:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbhASIMR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 03:12:17 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:23918 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731642AbhASILQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 03:11:16 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2021 03:10:27 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611043851; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BhAMRyR+5Tx1OgUKVRW+my+n85OwcVw4F3vY5dgl3x0=; b=kd7WoelIr/6TRB0qwBS27q1B1ddv88K5pXLouqHiaUJHwm2on/a+I7/ScB3oyJd+Pqr4gNL8
 YdbVk7byGOxwQOwKQImDIKEko1DoWOf76POoi4QswqWn4Q8OVhlpVkeDaV3C/7spgw0VMX87
 ik/8C7O6YvlJZYzwH7ArN3Uvd9A=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 600694018a0374a5013c51d7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 Jan 2021 08:10:41
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54CE9C43461; Tue, 19 Jan 2021 08:10:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DA96C43463;
        Tue, 19 Jan 2021 08:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DA96C43463
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V6 4/4] mac80211: CSA on non-transmitting interfaces
Date:   Tue, 19 Jan 2021 00:10:27 -0800
Message-Id: <20210119081027.5133-5-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210119081027.5133-1-alokad@codeaurora.org>
References: <20210119081027.5133-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Trigger ieee80211_csa_finish() on the non-transmitting interfaces when
CSA concludes on the tranmitting interface.

Modify offset in beacon generation to reflect multiple BSSID element
length.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v6: CSA is triggered on all interface, not only transmitting.

 net/mac80211/cfg.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9c4346f69a7b..11a22a3b9cab 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3239,6 +3239,17 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 
+	if (sdata->vif.multiple_bssid.flags & IEEE80211_VIF_MBSS_TRANSMITTING) {
+		struct ieee80211_sub_if_data *child;
+
+		rcu_read_lock();
+		list_for_each_entry_rcu(child, &sdata->local->interfaces, list)
+			if (child->vif.multiple_bssid.parent == &sdata->vif)
+				ieee80211_queue_work(&child->local->hw,
+						     &child->csa_finalize_work);
+		rcu_read_unlock();
+	}
+
 	ieee80211_queue_work(&sdata->local->hw,
 			     &sdata->csa_finalize_work);
 }
-- 
2.25.0

