Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D83D5101
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfJLQ3g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:29:36 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48772 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729428AbfJLQ3g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:29:36 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGr-00062r-TI; Sat, 12 Oct 2019 19:29:34 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:17 +0300
Message-Id: <20191012192536.65ef798e21ef.I71f4adb7558c32a0d45ce0e292f6659f5b0f8569@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012162924.19848-1-luca@coelho.fi>
References: <20191012162924.19848-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 06/13] iwlwifi: mvm: fix old-style declaration
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

There expect the 'static' keyword to come first in a
declaration, and we get warnings like this with "make W=1":

drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:427:1: warning:
 'static' is not at beginning of declaration [-Wold-style-declaration]
drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:434:1: warning:
 'static' is not at beginning of declaration [-Wold-style-declaration]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 8465dfe5d90b..a7d5bd1c1206 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -339,14 +339,14 @@ int iwl_mvm_init_fw_regd(struct iwl_mvm *mvm)
 	return ret;
 }
 
-const static u8 he_if_types_ext_capa_sta[] = {
+static const u8 he_if_types_ext_capa_sta[] = {
 	 [0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
 	 [2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	 [7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 	 [9] = WLAN_EXT_CAPA10_TWT_REQUESTER_SUPPORT,
 };
 
-const static struct wiphy_iftype_ext_capab he_iftypes_ext_capa[] = {
+static const struct wiphy_iftype_ext_capab he_iftypes_ext_capa[] = {
 	{
 		.iftype = NL80211_IFTYPE_STATION,
 		.extended_capabilities = he_if_types_ext_capa_sta,
-- 
2.23.0

