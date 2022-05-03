Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B629E517CFF
	for <lists+linux-wireless@lfdr.de>; Tue,  3 May 2022 08:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiECGHw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 May 2022 02:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiECGHv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 May 2022 02:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCC33334C
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 23:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B4916154B
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 06:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643EBC385AF;
        Tue,  3 May 2022 06:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651557859;
        bh=EvdgrcgpdiBbXp+X43whOkPl5MOnDiwPgm4Llg/4DbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekjL7rR0faEVTP1ESde3+frYFdxJjhLBcFe39c4k3cFA8XCdO4uT38ENex3X32npZ
         i5CupZg1VnT+R4J9AL1nkZj/Pc74LZ0QsX6cBuIWAG78bK0G4tMyXryTFDh/cDNpNY
         Bc7JsfTwHqZ6OntjewQoYIXbapc3Big5meisW5i3m8+F3GkJWsHThUb/HswY3t1w/8
         RGnuT368GHAlrchbbPUAtwzU8nzBVV0ZiEU6jCFF3LfeEkt3hH+oTaEcZ3zxLRVdNe
         aEsfdrqqz9IWAv5aFeAgk5z81jo25FtA/1nOmE774ysxWxSU+Vf+fssOw6NwD89qWV
         RN9TNhfmiGTvw==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] ath10k: mac: fix too long lines
Date:   Tue,  3 May 2022 09:04:15 +0300
Message-Id: <20220503060415.24499-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220503060415.24499-1-kvalo@kernel.org>
References: <20220503060415.24499-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

checkpatch warns:

drivers/net/wireless/ath/ath10k/mac.c:2696: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath10k/mac.c:6942: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath10k/mac.c:6948: line length of 91 exceeds 90 columns

These were introduced by commit 046d2e7c50e3 ("mac80211: prepare sta handling
for MLO support").

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 06a51a48c1d9..3570a5895ea8 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2692,8 +2692,10 @@ static bool ath10k_mac_sta_has_ofdm_only(struct ieee80211_sta *sta)
 static enum wmi_phy_mode ath10k_mac_get_phymode_vht(struct ath10k *ar,
 						    struct ieee80211_sta *sta)
 {
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
+
 	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160) {
-		switch (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
+		switch (vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
 		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
 			return MODE_11AC_VHT160;
 		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ:
@@ -6926,6 +6928,9 @@ static int ath10k_mac_validate_rate_mask(struct ath10k *ar,
 					 struct ieee80211_sta *sta,
 					 u32 rate_ctrl_flag, u8 nss)
 {
+	struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
+
 	if (nss > sta->deflink.rx_nss) {
 		ath10k_warn(ar, "Invalid nss field, configured %u limit %u\n",
 			    nss, sta->deflink.rx_nss);
@@ -6933,19 +6938,19 @@ static int ath10k_mac_validate_rate_mask(struct ath10k *ar,
 	}
 
 	if (ATH10K_HW_PREAMBLE(rate_ctrl_flag) == WMI_RATE_PREAMBLE_VHT) {
-		if (!sta->deflink.vht_cap.vht_supported) {
+		if (!vht_cap->vht_supported) {
 			ath10k_warn(ar, "Invalid VHT rate for sta %pM\n",
 				    sta->addr);
 			return -EINVAL;
 		}
 	} else if (ATH10K_HW_PREAMBLE(rate_ctrl_flag) == WMI_RATE_PREAMBLE_HT) {
-		if (!sta->deflink.ht_cap.ht_supported || sta->deflink.vht_cap.vht_supported) {
+		if (!ht_cap->ht_supported || vht_cap->vht_supported) {
 			ath10k_warn(ar, "Invalid HT rate for sta %pM\n",
 				    sta->addr);
 			return -EINVAL;
 		}
 	} else {
-		if (sta->deflink.ht_cap.ht_supported || sta->deflink.vht_cap.vht_supported)
+		if (ht_cap->ht_supported || vht_cap->vht_supported)
 			return -EINVAL;
 	}
 
-- 
2.30.2

