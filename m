Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCFE3DDAFC
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhHBO2p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:28:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50912 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233940AbhHBO2o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:28:44 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYvf-001xts-Ul; Mon, 02 Aug 2021 17:28:33 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:28:19 +0300
Message-Id: <iwlwifi.20210802172232.1cedf2ca7bb6.I2e609c28eaa301436e6740f4f1beca838f69a96a@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802142829.109448-1-luca@coelho.fi>
References: <20210802142829.109448-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.5-pre1
Subject: [PATCH 02/12] iwlwifi: mvm: set replay counter on key install
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When installing a (new) key, set the replay counter so that
after FW restart the firmware has the correct value of the
replay counters.

This doesn't have a large effect - for frames that reach
the driver, it will do a replay check, and when installing
a new key, the counter is normally zero to start with (not
for GTK though, if joining the BSS for the first time).

Since this only affects frames handled entirely by the FW,
and that's restricted to a few unicast management frames,
the only affect here is for those after a firmware restart.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 9c45a64c5009..0ec84d8ff9e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3190,6 +3190,20 @@ static struct iwl_mvm_sta *iwl_mvm_get_key_sta(struct iwl_mvm *mvm,
 	return NULL;
 }
 
+static int iwl_mvm_pn_cmp(const u8 *pn1, const u8 *pn2, int len)
+{
+	int i;
+
+	for (i = len - 1; i >= 0; i--) {
+		if (pn1[i] > pn2[i])
+			return 1;
+		if (pn1[i] < pn2[i])
+			return -1;
+	}
+
+	return 0;
+}
+
 static int iwl_mvm_send_sta_key(struct iwl_mvm *mvm,
 				u32 sta_id,
 				struct ieee80211_key_conf *key, bool mcast,
@@ -3274,6 +3288,45 @@ static int iwl_mvm_send_sta_key(struct iwl_mvm *mvm,
 	u.cmd.common.key_flags = key_flags;
 	u.cmd.common.sta_id = sta_id;
 
+	if (key->cipher == WLAN_CIPHER_SUITE_TKIP)
+		i = 0;
+	else
+		i = -1;
+
+	for (; i < IEEE80211_NUM_TIDS; i++) {
+		struct ieee80211_key_seq seq = {};
+		u8 _rx_pn[IEEE80211_MAX_PN_LEN] = {}, *rx_pn = _rx_pn;
+		int rx_pn_len = 8;
+
+		ieee80211_get_key_rx_seq(key, i, &seq);
+
+		if (key->cipher == WLAN_CIPHER_SUITE_TKIP) {
+			rx_pn[0] = seq.tkip.iv16;
+			rx_pn[1] = seq.tkip.iv16 >> 8;
+			/* hole at 2/3 in FW format */
+			rx_pn[4] = seq.tkip.iv32;
+			rx_pn[5] = seq.tkip.iv32 >> 8;
+			rx_pn[6] = seq.tkip.iv32 >> 16;
+			rx_pn[7] = seq.tkip.iv32 >> 24;
+		} else if (key_flags & cpu_to_le16(STA_KEY_FLG_EXT)) {
+			rx_pn = seq.hw.seq;
+			rx_pn_len = seq.hw.seq_len;
+		} else {
+			rx_pn[0] = seq.ccmp.pn[0];
+			rx_pn[1] = seq.ccmp.pn[1];
+			/* hole at 2/3 in FW format */
+			rx_pn[4] = seq.ccmp.pn[2];
+			rx_pn[5] = seq.ccmp.pn[3];
+			rx_pn[6] = seq.ccmp.pn[4];
+			rx_pn[7] = seq.ccmp.pn[5];
+		}
+
+		if (iwl_mvm_pn_cmp(rx_pn, (u8 *)&u.cmd.common.rx_secur_seq_cnt,
+				   rx_pn_len) > 0)
+			memcpy(&u.cmd.common.rx_secur_seq_cnt, rx_pn,
+			       rx_pn_len);
+	}
+
 	if (new_api) {
 		u.cmd.transmit_seq_cnt = cpu_to_le64(pn);
 		size = sizeof(u.cmd);
-- 
2.32.0

