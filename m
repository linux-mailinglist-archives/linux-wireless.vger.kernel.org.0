Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDBA6F7713
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 22:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjEDUdf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 16:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjEDUdO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 16:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4C119D4C;
        Thu,  4 May 2023 13:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61878637FD;
        Thu,  4 May 2023 19:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CC5C4339E;
        Thu,  4 May 2023 19:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229673;
        bh=JAPuOxWhBsan5hPSxnWhnAjp48qyhtSOWi8YeO40rHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cu1od6yiYl6+QhM4w1/uF1a9KVAn6x4jflQZmyuwKLDyyIm/6+u16vBgXWQxFY9C5
         RmuIQlm71lBKFjECZXsRwanYkLR7wpHCBosERwP4PRajfg85f9ryKAHKwksTaXKYpy
         o+mcKOdKqzYBrE4eCnGoEdzf3jOJjXMTwfF5ogfn38/mSSkBFBmdrcp+UGZWfWakop
         YWoyRSzrUdWb6I3Z+diIWZQpP1Bn5GudsiDPyiLIge0Jd22sXd/sogEzdqMJm13os0
         q36LsixosTRKG30pmsPHi9nSDfCxCp6vJUpRHbYntIR3aeUzePcsBq3doPTpEZwEy2
         cB2ydHDjHy6Yw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, avraham.stern@intel.com,
        shaul.triebitz@intel.com, ilan.peer@intel.com,
        greearb@candelatech.com, mordechay.goodstein@intel.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 34/49] wifi: iwlwifi: fix iwl_mvm_max_amsdu_size() for MLO
Date:   Thu,  4 May 2023 15:46:11 -0400
Message-Id: <20230504194626.3807438-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit b2bc600cced23762d4e97db8989b18772145604f ]

For MLO, we cannot use vif->bss_conf.chandef.chan->band, since
that will lead to a NULL-ptr dereference as bss_conf isn't used.
However, in case of real MLO, we also need to take both LMACs
into account if they exist, since the station might be active
on both LMACs at the same time.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230417113648.3588afc85d79.I11592893bbc191b9548518b8bd782de568a9f848@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 37 +++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ba944175546d4..542cfcad6e0e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -788,10 +788,11 @@ unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 				    struct ieee80211_sta *sta, unsigned int tid)
 {
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	enum nl80211_band band = mvmsta->vif->bss_conf.chandef.chan->band;
 	u8 ac = tid_to_mac80211_ac[tid];
+	enum nl80211_band band;
 	unsigned int txf;
-	int lmac = iwl_mvm_get_lmac_id(mvm->fw, band);
+	unsigned int val;
+	int lmac;
 
 	/* For HE redirect to trigger based fifos */
 	if (sta->deflink.he_cap.has_he && !WARN_ON(!iwl_mvm_has_new_tx_api(mvm)))
@@ -805,7 +806,37 @@ unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 	 * We also want to have the start of the next packet inside the
 	 * fifo to be able to send bursts.
 	 */
-	return min_t(unsigned int, mvmsta->max_amsdu_len,
+	val = mvmsta->max_amsdu_len;
+
+	if (hweight16(sta->valid_links) <= 1) {
+		if (sta->valid_links) {
+			struct ieee80211_bss_conf *link_conf;
+			unsigned int link = ffs(sta->valid_links) - 1;
+
+			rcu_read_lock();
+			link_conf = rcu_dereference(mvmsta->vif->link_conf[link]);
+			if (WARN_ON(!link_conf))
+				band = NL80211_BAND_2GHZ;
+			else
+				band = link_conf->chandef.chan->band;
+			rcu_read_unlock();
+		} else {
+			band = mvmsta->vif->bss_conf.chandef.chan->band;
+		}
+
+		lmac = iwl_mvm_get_lmac_id(mvm->fw, band);
+	} else if (fw_has_capa(&mvm->fw->ucode_capa,
+			       IWL_UCODE_TLV_CAPA_CDB_SUPPORT)) {
+		/* for real MLO restrict to both LMACs if they exist */
+		lmac = IWL_LMAC_5G_INDEX;
+		val = min_t(unsigned int, val,
+			    mvm->fwrt.smem_cfg.lmac[lmac].txfifo_size[txf] - 256);
+		lmac = IWL_LMAC_24G_INDEX;
+	} else {
+		lmac = IWL_LMAC_24G_INDEX;
+	}
+
+	return min_t(unsigned int, val,
 		     mvm->fwrt.smem_cfg.lmac[lmac].txfifo_size[txf] - 256);
 }
 
-- 
2.39.2

