Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631BA331DBB
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 04:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCIDzR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Mar 2021 22:55:17 -0500
Received: from z11.mailgun.us ([104.130.96.11]:53357 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhCIDzK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Mar 2021 22:55:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615262110; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+Cx2eTHKTQqcrQzUFEgfIILgwrjky/NstyMB0z3N/8s=; b=s1iU8rMH0yHATku7+AKcKEP9SSuP1ElOi50D7tJZIIdYCkmGmY0boju1cSq03qGgj93dIgjN
 qe35i5Yqn7PHs8PimzlEgnkBo6RhxC0OO6tAJkKqO/32unzM5ZEuLt852Jt9IAdbphp0hyMW
 fWwFnhby//8P/47l+yIwiva+YzM=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6046f18b7b648e24368e3083 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Mar 2021 03:54:51
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E033DC43461; Tue,  9 Mar 2021 03:54:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43038C433ED;
        Tue,  9 Mar 2021 03:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43038C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v8 4/4] mac80211: CSA on non-transmitting interfaces
Date:   Mon,  8 Mar 2021 19:54:37 -0800
Message-Id: <20210309035437.6131-5-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210309035437.6131-1-alokad@codeaurora.org>
References: <20210309035437.6131-1-alokad@codeaurora.org>
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
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v8: No changes from v7

 net/mac80211/cfg.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e72c0a4a26c3..ccafa39f7ad6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3238,6 +3238,17 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
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

