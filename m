Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6FC115331
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 15:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFOeH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 09:34:07 -0500
Received: from nbd.name ([46.4.11.11]:36414 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfLFOeH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 09:34:07 -0500
Received: from tmo-101-57.customers.d1-online.com ([80.187.101.57] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1idEgG-0004Lm-Qt; Fri, 06 Dec 2019 15:34:05 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 4/7] iwlwifi: use new bss_color struct
Date:   Fri,  6 Dec 2019 15:33:58 +0100
Message-Id: <20191206143401.4080-4-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191206143401.4080-1-john@phrozen.org>
References: <20191206143401.4080-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We will be removing the bss_color element. Lets use the he_bss_color
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

