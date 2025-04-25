Return-Path: <linux-wireless+bounces-22088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E666A9D63D
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 01:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0824C35C3
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69011297A54;
	Fri, 25 Apr 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klZhKzog"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39303297A4D;
	Fri, 25 Apr 2025 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745623812; cv=none; b=O1e/Nv3FRi+ranZ+8r7X0P+EuNb27SBv9wI/88D9dCI8T0BTZ1f4cMAPQbdHlMwByZOzbTh7eZQGCpAGUX+asftxlm9+qG6nXIQIB5bknjVyHEtOB8Pazx8y+PF3EiHI+BRegkTn/du7Jkxo5ZxRSnx83XAasd8BrRLO+F5sjQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745623812; c=relaxed/simple;
	bh=QSyq1trff9DKHD1MwLobjiiSlC5pK3WBhh0TKGXnek8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LNWEfZCTiU318lOa9P4/K726TbWjTGYwovxe4Z1SrF2PnI+tWgTfGNZmEIZpTAKMf7gJ/hNC1ZpLIu6Z4FA/mw6QL7yVON9NTDrFobiwnQLJup08ypmORBxpH3t0qQoKjBB4tkNJ1hDFYm7pR+dh7y2B5Yr4SBEErGQnP4+FUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klZhKzog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C844FC4CEE4;
	Fri, 25 Apr 2025 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745623811;
	bh=QSyq1trff9DKHD1MwLobjiiSlC5pK3WBhh0TKGXnek8=;
	h=Date:From:To:Cc:Subject:From;
	b=klZhKzog9YrzVChCgHdCQbT6ge9AZT6EFuJKNAxh3Bn3UcGwSilyK7zuUkFqq4RdT
	 Jlr7GNuCKr7cZ99Fm4Fjrcj0k0fR/rfmz/Rtm8GfLF9+JUEXkl2TmuH+aMwualnrm7
	 JOshNfQKzuf6uiCrQ4r+a2KIIROch6k/A6MLheWu1nX8LTSQeESBVH02Ovhk8fZC5E
	 FwADFstVO/ZyEIyvyNi74BY9gx+iy3qiHr9p1BJxYndxRhsR01TzdLq/0VLISo5i52
	 DLbFUj+F/M2eXPNvqFF1IPEwWYi7APb2P8WJYD/rRKlb2RNkNp2Qy0F9WuHntHTSWt
	 ZwZFz16pYez6Q==
Date: Fri, 25 Apr 2025 17:30:06 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: iwlwifi: mld: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <aAwa_iCPs_g5Vgjm@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warnings:

drivers/net/wireless/intel/iwlwifi/mld/tlc.c:499:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mld/rx.c:1862:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mld/d3.c:867:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c  | 44 ++++++++++----------
 drivers/net/wireless/intel/iwlwifi/mld/rx.c  | 24 +++++------
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c | 23 +++++-----
 3 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index dc736fdc176d..8f600d8438a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -863,23 +863,21 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 			u32 cipher)
 {
 	struct ieee80211_key_conf *key_config;
-	struct {
-		struct ieee80211_key_conf conf;
-		u8 key[WOWLAN_KEY_MAX_SIZE];
-	} conf = {
-		.conf.cipher = cipher,
-		.conf.keyidx = key_data->id,
-	};
+	DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
+			WOWLAN_KEY_MAX_SIZE);
 	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
 
+	conf->cipher = cipher;
+	conf->keyidx = key_data->id;
+
 	BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_GCMP_256);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_TKIP);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_BIP_GMAC_128);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_BIP_GMAC_256);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_AES_CMAC);
-	BUILD_BUG_ON(sizeof(conf.key) < sizeof(key_data->key));
+	BUILD_BUG_ON(__member_size(conf->key) < WLAN_KEY_LEN_CCMP);
+	BUILD_BUG_ON(__member_size(conf->key) < WLAN_KEY_LEN_GCMP_256);
+	BUILD_BUG_ON(__member_size(conf->key) < WLAN_KEY_LEN_TKIP);
+	BUILD_BUG_ON(__member_size(conf->key) < WLAN_KEY_LEN_BIP_GMAC_128);
+	BUILD_BUG_ON(__member_size(conf->key) < WLAN_KEY_LEN_BIP_GMAC_256);
+	BUILD_BUG_ON(__member_size(conf->key) < WLAN_KEY_LEN_AES_CMAC);
+	BUILD_BUG_ON(__member_size(conf->key) < sizeof(key_data->key));
 
 	if (!key_data->len)
 		return true;
@@ -887,32 +885,32 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 	switch (cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_GCMP:
-		conf.conf.keylen = WLAN_KEY_LEN_CCMP;
+		conf->keylen = WLAN_KEY_LEN_CCMP;
 		break;
 	case WLAN_CIPHER_SUITE_GCMP_256:
-		conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
+		conf->keylen = WLAN_KEY_LEN_GCMP_256;
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
-		conf.conf.keylen = WLAN_KEY_LEN_TKIP;
+		conf->keylen = WLAN_KEY_LEN_TKIP;
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_128;
+		conf->keylen = WLAN_KEY_LEN_BIP_GMAC_128;
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_256;
+		conf->keylen = WLAN_KEY_LEN_BIP_GMAC_256;
 		break;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
-		conf.conf.keylen = WLAN_KEY_LEN_AES_CMAC;
+		conf->keylen = WLAN_KEY_LEN_AES_CMAC;
 		break;
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-		conf.conf.keylen = WLAN_KEY_LEN_BIP_CMAC_256;
+		conf->keylen = WLAN_KEY_LEN_BIP_CMAC_256;
 		break;
 	default:
 		WARN_ON(1);
 	}
 
-	memcpy(conf.conf.key, key_data->key, conf.conf.keylen);
-	key_config = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
+	memcpy(conf->key, key_data->key, conf->keylen);
+	key_config = ieee80211_gtk_rekey_add(vif, conf, link_id);
 	if (IS_ERR(key_config))
 		return false;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index c4f189bcece2..0627e16737b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1858,17 +1858,10 @@ void iwl_mld_sync_rx_queues(struct iwl_mld *mld,
 			    const void *notif_payload, u32 notif_payload_size)
 {
 	u8 num_rx_queues = mld->trans->num_rx_queues;
-	struct {
-		struct iwl_rxq_sync_cmd sync_cmd;
-		struct iwl_mld_internal_rxq_notif notif;
-	} __packed cmd = {
-		.sync_cmd.rxq_mask = cpu_to_le32(BIT(num_rx_queues) - 1),
-		.sync_cmd.count =
-			cpu_to_le32(sizeof(struct iwl_mld_internal_rxq_notif) +
-				    notif_payload_size),
-		.notif.type = type,
-		.notif.cookie = mld->rxq_sync.cookie,
-	};
+	DEFINE_RAW_FLEX(struct iwl_rxq_sync_cmd, cmd, payload,
+			sizeof(struct iwl_mld_internal_rxq_notif));
+	struct iwl_mld_internal_rxq_notif *notif =
+				(struct iwl_mld_internal_rxq_notif *)cmd->payload;
 	struct iwl_host_cmd hcmd = {
 		.id = WIDE_ID(DATA_PATH_GROUP, TRIGGER_RX_QUEUES_NOTIF_CMD),
 		.data[0] = &cmd,
@@ -1878,8 +1871,15 @@ void iwl_mld_sync_rx_queues(struct iwl_mld *mld,
 	};
 	int ret;
 
+	cmd->rxq_mask = cpu_to_le32(BIT(num_rx_queues) - 1);
+	cmd->count =
+		cpu_to_le32(sizeof(struct iwl_mld_internal_rxq_notif) +
+			    notif_payload_size);
+	notif->type = type;
+	notif->cookie = mld->rxq_sync.cookie;
+
 	/* size must be a multiple of DWORD */
-	if (WARN_ON(cmd.sync_cmd.count & cpu_to_le32(3)))
+	if (WARN_ON(cmd->count & cpu_to_le32(3)))
 		return;
 
 	mld->rxq_sync.state = (1 << num_rx_queues) - 1;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index f054cc921d9d..96e16769fb1c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -495,20 +495,19 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 
 int iwl_mld_send_tlc_dhc(struct iwl_mld *mld, u8 sta_id, u32 type, u32 data)
 {
-	struct {
-		struct iwl_dhc_cmd dhc;
-		struct iwl_dhc_tlc_cmd tlc;
-	} __packed cmd = {
-		.tlc.sta_id = sta_id,
-		.tlc.type = cpu_to_le32(type),
-		.tlc.data[0] = cpu_to_le32(data),
-		.dhc.length = cpu_to_le32(sizeof(cmd.tlc) >> 2),
-		.dhc.index_and_mask =
-			cpu_to_le32(DHC_TABLE_INTEGRATION | DHC_TARGET_UMAC |
-				    DHC_INTEGRATION_TLC_DEBUG_CONFIG),
-	};
+	DEFINE_RAW_FLEX(struct iwl_dhc_cmd, cmd, data,
+			sizeof(struct iwl_dhc_tlc_cmd));
+	struct iwl_dhc_tlc_cmd *tlc = (struct iwl_dhc_tlc_cmd *)cmd->data;
 	int ret;
 
+	tlc->sta_id = sta_id;
+	tlc->type = cpu_to_le32(type);
+	tlc->data[0] = cpu_to_le32(data);
+	cmd->length = cpu_to_le32(sizeof(*tlc) >> 2);
+	cmd->index_and_mask =
+			cpu_to_le32(DHC_TABLE_INTEGRATION | DHC_TARGET_UMAC |
+				    DHC_INTEGRATION_TLC_DEBUG_CONFIG);
+
 	ret = iwl_mld_send_cmd_with_flags_pdu(mld,
 					      WIDE_ID(IWL_ALWAYS_LONG_GROUP,
 						      DEBUG_HOST_COMMAND),
-- 
2.43.0


