Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9443011E72A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 16:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfLMP6O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 10:58:14 -0500
Received: from nbd.name ([46.4.11.11]:56222 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbfLMP6O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 10:58:14 -0500
Received: from pd95fd344.dip0.t-ipconnect.de ([217.95.211.68] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ifnKU-00073u-M6; Fri, 13 Dec 2019 16:58:10 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH v2 4/7] iwlwifi: use new bss_color struct
Date:   Fri, 13 Dec 2019 16:57:59 +0100
Message-Id: <20191213155802.25491-4-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213155802.25491-1-john@phrozen.org>
References: <20191213155802.25491-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We will be removing the bss_color element. Lets use the new he_bss_color
struct instead.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b74bd58f3f45..f0bf42f91af1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2225,7 +2225,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	struct iwl_he_sta_context_cmd sta_ctxt_cmd = {
 		.sta_id = sta_id,
 		.tid_limit = IWL_MAX_TID_COUNT,
-		.bss_color = vif->bss_conf.bss_color,
+		.bss_color = vif->bss_conf.he_bss_color.color,
 		.htc_trig_based_pkt_ext = vif->bss_conf.htc_trig_based_pkt_ext,
 		.frame_time_rts_th =
 			cpu_to_le16(vif->bss_conf.frame_time_rts_th),
-- 
2.20.1

