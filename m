Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96311A035F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2020 02:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgDGAJT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 20:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgDGABN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 20:01:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 593562080C;
        Tue,  7 Apr 2020 00:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217672;
        bh=09QvhtRGrOLEMW1wLzmWFmr4KotkIXwu4+Ba9yZJCU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WlE54Wd9VTJUvsU56h/1b7oOVlE8Dmi/LkEmAra2BquzKcy8WpTrRZXE1tuewyb97
         2B/UfbZMQG3L9gqPzxm4VwD48i4yZGBjmaGRvVzuujAakl5HFR2w2AGy4qsNLci5K7
         uvxRBV8hMvUDH9rL7gu7QVjBioOTnqblz8wNZVns=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 10/35] iwlwifi: mvm: Fix rate scale NSS configuration
Date:   Mon,  6 Apr 2020 20:00:32 -0400
Message-Id: <20200407000058.16423-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407000058.16423-1-sashal@kernel.org>
References: <20200407000058.16423-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit ce19801ba75a902ab515dda03b57738c708d0781 ]

The TLC configuration did not take into consideration the station's
SMPS configuration, and thus configured rates for 2 NSS even if
static SMPS was reported by the station. Fix this.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20200306151129.b4f940d13eca.Ieebfa889d08205a3a961ae0138fb5832e8a0f9c1@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 29 ++++++++++++++-----
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 80ef238a84884..ca99a9c4f70ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,7 +27,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -195,11 +195,13 @@ rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 {
 	u16 supp;
 	int i, highest_mcs;
+	u8 nss = sta->rx_nss;
 
-	for (i = 0; i < sta->rx_nss; i++) {
-		if (i == IWL_TLC_NSS_MAX)
-			break;
+	/* the station support only a single receive chain */
+	if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+		nss = 1;
 
+	for (i = 0; i < nss && i < IWL_TLC_NSS_MAX; i++) {
 		highest_mcs = rs_fw_vht_highest_rx_mcs_index(vht_cap, i + 1);
 		if (!highest_mcs)
 			continue;
@@ -245,8 +247,13 @@ rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
 	u16 tx_mcs_160 =
 		le16_to_cpu(sband->iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_160);
 	int i;
+	u8 nss = sta->rx_nss;
 
-	for (i = 0; i < sta->rx_nss && i < IWL_TLC_NSS_MAX; i++) {
+	/* the station support only a single receive chain */
+	if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+		nss = 1;
+
+	for (i = 0; i < nss && i < IWL_TLC_NSS_MAX; i++) {
 		u16 _mcs_160 = (mcs_160 >> (2 * i)) & 0x3;
 		u16 _mcs_80 = (mcs_80 >> (2 * i)) & 0x3;
 		u16 _tx_mcs_160 = (tx_mcs_160 >> (2 * i)) & 0x3;
@@ -307,8 +314,14 @@ static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 		cmd->mode = IWL_TLC_MNG_MODE_HT;
 		cmd->ht_rates[IWL_TLC_NSS_1][IWL_TLC_HT_BW_NONE_160] =
 			cpu_to_le16(ht_cap->mcs.rx_mask[0]);
-		cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_NONE_160] =
-			cpu_to_le16(ht_cap->mcs.rx_mask[1]);
+
+		/* the station support only a single receive chain */
+		if (sta->smps_mode == IEEE80211_SMPS_STATIC)
+			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_NONE_160] =
+				0;
+		else
+			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_NONE_160] =
+				cpu_to_le16(ht_cap->mcs.rx_mask[1]);
 	}
 }
 
-- 
2.20.1

