Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5105D9EF
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 02:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfGCA6F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 20:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfGCA6E (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 20:58:04 -0400
Received: from localhost.localdomain (unknown [151.66.29.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7617C21901;
        Tue,  2 Jul 2019 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562106610;
        bh=IQYXJVlBUlC831WalHB2bhgVvHz89YLqKEGXjMcTCg0=;
        h=From:To:Cc:Subject:Date:From;
        b=bjqgQLj0YRaftjYzc8EqduYTOVwYi5dd97CSSGwfTMHPZ55r/IHuXOeA/WKsuTTKy
         uAxYFuaoUa++7FrHyDTFOA9SQoT9WOU7QZtLJs5407Lejp13ZJgC5trXCsGihKtB/z
         cZeXjA3e0kz2LEoNN2sJRwZZk8P1Fxl9BqSTbtLM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mac80211: fix possible memory leak in ieee80211_assign_beacon
Date:   Wed,  3 Jul 2019 00:29:47 +0200
Message-Id: <770285772543c9fca33777bb4ad4760239e56256.1562105631.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Free new beacon_data in ieee80211_assign_beacon whenever
ieee80211_assign_beacon fails

Fixes: 8860020e0be1 ("cfg80211: restructure AP/GO mode API")
Fixes: bc847970f432 ("mac80211: support FTM responder configuration/statistic")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/mac80211/cfg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a1973a26c7fc..b8288125e05d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -935,8 +935,10 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 
 	err = ieee80211_set_probe_resp(sdata, params->probe_resp,
 				       params->probe_resp_len, csa);
-	if (err < 0)
+	if (err < 0) {
+		kfree(new);
 		return err;
+	}
 	if (err == 0)
 		changed |= BSS_CHANGED_AP_PROBE_RESP;
 
@@ -948,8 +950,10 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 							 params->civicloc,
 							 params->civicloc_len);
 
-		if (err < 0)
+		if (err < 0) {
+			kfree(new);
 			return err;
+		}
 
 		changed |= BSS_CHANGED_FTM_RESPONDER;
 	}
-- 
2.21.0

