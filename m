Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1B4C2B41
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 12:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiBXL4M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 06:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBXL4M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 06:56:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95456254550
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 03:55:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EB43B825AD
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 11:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01897C340E9;
        Thu, 24 Feb 2022 11:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645703739;
        bh=GW8VsTIv8BXctQU44tUWIK1GWbivLjGdkDJaT6BfhOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7zHEHU5KDSstg+ne/kQu17JTGrYOPvlhs8IM7zdGk75A/Pi8bJtzkVmvXUzbkvAY
         /YX2psVPhcUOktnY8hCO+aE6ellMHPBzCb6eZ0kiyngaHPGPzZO7NlZsCNNFrMUY91
         AEZiP/JDIEeDSsu7s7GKzwZtZacEzi6U82m3L/+vef9TcskN4KKfmR7pcA4oyGV5sv
         8XqkG3ZVis7JEaBS20wZcDmMVpF1MOSuoqwDeSo+uqQE5dcsHw5bpJtEZIcLgsk+of
         CxIV28oqBPXSFHJVeuzxlzhK9NNP7zGhiN2q3HY/eskTn9EVVpb1EM/1TLKy15XHE1
         4mkMrXR3+Ixmg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        quic_alokad@quicinc.com, john@phrozen.org, nbd@nbd.name,
        ryder.lee@mediatek.com, money.wang@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v14 mac80211-next 2/3] mac80211: MBSSID channel switch
Date:   Thu, 24 Feb 2022 12:54:59 +0100
Message-Id: <6fde4d7f9fa387494f46a7aa4a584478dcda06f1.1645702516.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645702516.git.lorenzo@kernel.org>
References: <cover.1645702516.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Trigger ieee80211_csa_finish() on the non-transmitting interfaces
when channel switch concludes on the transmitting interface.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/cfg.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f7324a6d4a78..464d2896fbbc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3251,9 +3251,31 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 void ieee80211_csa_finish(struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_local *local = sdata->local;
 
-	ieee80211_queue_work(&sdata->local->hw,
-			     &sdata->csa_finalize_work);
+	rcu_read_lock();
+
+	if (vif->mbssid_tx_vif == vif) {
+		/* Trigger ieee80211_csa_finish() on the non-transmitting
+		 * interfaces when channel switch is received on
+		 * transmitting interface
+		 */
+		struct ieee80211_sub_if_data *iter;
+
+		list_for_each_entry_rcu(iter, &local->interfaces, list) {
+			if (!ieee80211_sdata_running(iter))
+				continue;
+
+			if (iter == sdata || iter->vif.mbssid_tx_vif != vif)
+				continue;
+
+			ieee80211_queue_work(&iter->local->hw,
+					     &iter->csa_finalize_work);
+		}
+	}
+	ieee80211_queue_work(&local->hw, &sdata->csa_finalize_work);
+
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(ieee80211_csa_finish);
 
-- 
2.35.1

