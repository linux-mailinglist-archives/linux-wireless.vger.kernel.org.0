Return-Path: <linux-wireless+bounces-26533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0658B30171
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685C2601F45
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD5634166B;
	Thu, 21 Aug 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISZ1aC2T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B335E341AA4
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798482; cv=none; b=fS2UdrNSLdRA0T8B5iCK+p/upJZ3JPIxnwFUmJEt/+JPwsfZJrfzL0BGR0B1TfXNoP2AgJI/ijqXvZ/Ptafvl+ojeEQr8Wcd9ibDr/42dqCQqfpcOQ/FamWjn7jKROYPoTyksVGeZfXRdRfQ10c9Reh3WG2NBgpOhJmDOAZDa6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798482; c=relaxed/simple;
	bh=EFJoisswneMjSQdWwubdNCs1NA5n3hD9HJ4E8uB1HWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uF9+eyVE/xo4eDmiY6TA+8X1p/vnpiGO5xg4fEE8PDIQq5ZguL/kT1F6DjgPi8tiWbogo9HvT1WygKNyi9SkguOo1D4raPm6uhPHlc31ZiyjIB3B1o4RRS4z/1svVF+FeGcSqx/RwKSYTgNRdfrjtPXPhrRmnb5BUBPpFLfMDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISZ1aC2T; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798481; x=1787334481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EFJoisswneMjSQdWwubdNCs1NA5n3hD9HJ4E8uB1HWc=;
  b=ISZ1aC2Tf5glEuFy4CBQfO+g+EezT5NQTMq9xkPcFx4b82GKB8RDEafb
   ut4fKE8CangTiPMYz/GRPpt8xwMs6ByuKmPKctXyqmExIoC/BNCT0shad
   XIqSgKhPpm4TFxF0Skx6L0IqUSASelyY8U3t2TZzIQo17WP6tlPl4knRt
   oq6SKWxlWPc2LIhHF+/y60GvQZlyk/DIK1luJigq4HG2Y69Rxs8LigLMr
   SluTrTY/aV1gRZj1uespdZIo71L5sZhX8MyWi9NNBXWmTUpT2tmLprToY
   ZIPn1k0udr7CIpMveoos9dtei7dfzzTTp7gi+GMotAYVXOsw++laZQcNe
   w==;
X-CSE-ConnectionGUID: tlF8RpPsT3aZUZWP69krmQ==
X-CSE-MsgGUID: WFiP/MQpSZyrlZHBKJ9f0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806068"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806068"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:00 -0700
X-CSE-ConnectionGUID: LUcjfTQeT12Afq88dcGTfQ==
X-CSE-MsgGUID: 1Wb4lJiES/6wghHgJyJjRw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:47:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 06/15] wifi: iwlwifi: mvm/mld: correctly retrieve the keyidx from the beacon
Date: Thu, 21 Aug 2025 20:47:17 +0300
Message-Id: <20250821204455.e0aea411cd2a.I4220348147541a1478b02389475426047ecf84bc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
References: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

key->icv_len already includes the pn length and the keyidx length.
In fact it is the size of the MMIE, so subtracting it from the overall
length will actually bring us to the beggining of the MMIE and not of
the keyidx inside it.
Also, we also need to consider a 16 byte long MIC.

Fix the code to correctly retrieve the keyidx.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 13 ++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  9 +++++++--
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 53cac9d8018c..20d866dd92c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1611,8 +1611,6 @@ iwl_mld_rx_with_sta(struct iwl_mld *mld, struct ieee80211_hdr *hdr,
 	return sta;
 }
 
-#define KEY_IDX_LEN 2
-
 static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 				struct ieee80211_hdr *hdr,
 				struct ieee80211_rx_status *rx_status,
@@ -1626,6 +1624,7 @@ static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 	u8 keyidx;
 	struct ieee80211_key_conf *key;
 	const u8 *frame = (void *)hdr;
+	const u8 *mmie;
 	u8 link_id;
 
 	if ((mpdu_status & IWL_RX_MPDU_STATUS_SEC_MASK) ==
@@ -1674,11 +1673,15 @@ static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 			goto report;
 	}
 
-	if (mpdu_len < key->icv_len + IEEE80211_GMAC_PN_LEN + KEY_IDX_LEN)
+	/* get the real key ID */
+	if (mpdu_len < key->icv_len)
 		goto report;
 
-	/* get the real key ID */
-	keyidx = frame[mpdu_len - key->icv_len - IEEE80211_GMAC_PN_LEN - KEY_IDX_LEN];
+	mmie = frame + (mpdu_len - key->icv_len);
+
+	/* the position of the key_id in ieee80211_mmie_16 is the same */
+	keyidx = le16_to_cpu(((const struct ieee80211_mmie *) mmie)->key_id);
+
 	/* and if that's the other key, look it up */
 	if (keyidx != key->keyidx) {
 		/* shouldn't happen since firmware checked, but be safe
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index d8be2f6124c1..d35c63a673b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -332,6 +332,7 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 	struct ieee80211_key_conf *key;
 	u32 len = le16_to_cpu(desc->mpdu_len);
 	const u8 *frame = (void *)hdr;
+	const u8 *mmie;
 
 	if ((status & IWL_RX_MPDU_STATUS_SEC_MASK) == IWL_RX_MPDU_STATUS_SEC_NONE)
 		return 0;
@@ -375,11 +376,15 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 			goto report;
 	}
 
-	if (len < key->icv_len + IEEE80211_GMAC_PN_LEN + 2)
+	if (len < key->icv_len)
 		goto report;
 
 	/* get the real key ID */
-	keyid = frame[len - key->icv_len - IEEE80211_GMAC_PN_LEN - 2];
+	mmie = frame + (len - key->icv_len);
+
+	/* the position of the key_id in ieee80211_mmie_16 is the same */
+	keyid = le16_to_cpu(((const struct ieee80211_mmie *) mmie)->key_id);
+
 	/* and if that's the other key, look it up */
 	if (keyid != key->keyidx) {
 		/*
-- 
2.34.1


