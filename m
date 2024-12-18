Return-Path: <linux-wireless+bounces-16559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143589F70D0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 00:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC297A1712
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 23:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4D21FCFD8;
	Wed, 18 Dec 2024 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Mf2Aa0bq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA51FCFF1
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734564543; cv=none; b=bjBhCnMtZHZb9SGG7gzP5aeIzwrPsaqBmkvPrFycrXHVkBiMKv63zS+YBJLJBU+H7zivr6Z6AtGk6Z2sAbwUxwiV0TQ5XsnU6yQW6HLEcDxm6dsEupKTOAhQcLM+a18dkz0e4xM0U7ATkJ0xa65J/na5lrpACWX/iIVAbTgXSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734564543; c=relaxed/simple;
	bh=r7trmXHM/3SlxvQb+6mukIQR4fiHRVs/N4p9zsuG960=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTA28jYQ8+cDN8ACV+YjgN9NpX0xCABrcz4qiE74DRwvDnRBKDNFrS0v9fxv0SEOADJ+rCLqh1meCAODhDcdSjD9CIQ6cthxcz+3oQS4vj6pjsdXmKd2ei7Oeiac75wcyjveQNjQzCm7iHnv+BJk04blpEwcF5AqjhVpQ4Rfyfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Mf2Aa0bq; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9CC3A307A60
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 23:29:00 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0892824006A
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 23:28:52 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 6ACEB13C2B1;
	Wed, 18 Dec 2024 15:28:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6ACEB13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1734564532;
	bh=r7trmXHM/3SlxvQb+6mukIQR4fiHRVs/N4p9zsuG960=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mf2Aa0bqZrlQa/NQIb6iEqa/Yax9Ev1hExsPb0HzmgzM17fUY35+DVrLG2JOEozDU
	 7+C0Q2UqlPlZQYuhPOpfjjzSs5yMXyfqiT9MFV2bA+l73hzzhkpbyAeEfMGlBqxbfn
	 K2WCtFGf2XJZr6rHZW2Mqx3nRIdyuuJAvJw/Ue+4=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 2/2] wifi: iwlwifi: Fix survey dump for be200 radios.
Date: Wed, 18 Dec 2024 15:28:49 -0800
Message-ID: <20241218232849.3156720-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241218232849.3156720-1-greearb@candelatech.com>
References: <20241218232849.3156720-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1734564534-CJBqT-yDerqU
X-MDID-O:
 us5;at1;1734564534;CJBqT-yDerqU;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

The old code did not assign channel, so survey dump was always
empty.  Instead, return the info from the phy ctxts since we
can at least fake out the channel busy time with that.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 21 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 18 ++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 07778d55878b..038bb41594fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6063,6 +6063,27 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 
 	memset(survey, 0, sizeof(*survey));
 
+	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ) {
+		/* None of the code below this if clause appears to work
+		 * on be200 radios, primarily because 'channel' is not assigned.
+		 * So special case this to do something useful on be200
+		 * radio:  Return channel and busy-time for the first 3
+		 * phy contexts.
+		 */
+		if (idx > 2)
+			return -ENOENT;
+
+		if (!mvm->phy_ctxts[idx].ref)
+			return 0;
+
+		survey->filled = SURVEY_INFO_TIME | SURVEY_INFO_TIME_BUSY;
+		survey->channel = mvm->phy_ctxts[idx].channel;
+
+		survey->time = jiffies64_to_msecs(mvm->phy_ctxts[idx].channel_time_accum);
+		survey->time_busy = jiffies64_to_msecs(mvm->phy_ctxts[idx].channel_busy_accum);
+		return 0;
+	}
+
 	if (!fw_has_capa(&mvm->fw->ucode_capa,
 			 IWL_UCODE_TLV_CAPA_RADIO_BEACON_STATS))
 		return -ENOENT;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 751d2c2bf541..a79263e9e5bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -105,6 +105,10 @@ struct iwl_mvm_phy_ctxt {
 	u32 channel_load;
 	u32 channel_load_by_us;
 	u32 channel_load_not_by_us;
+
+	u64 channel_time_accum; /* in jiffies */
+	u64 channel_busy_accum; /* in jiffies */
+	u64 last_jiffies; /* last time we accumulated the above */
 };
 
 struct iwl_mvm_time_event_data {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 7f285ee49097..ebb13df60a0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -783,6 +783,8 @@ static void iwl_mvm_handle_per_phy_stats(struct iwl_mvm *mvm,
 					 struct iwl_stats_ntfy_per_phy *per_phy)
 {
 	int i;
+	unsigned long jdiff;
+	u64 j = jiffies_64;
 
 	for (i = 0; i < NUM_PHY_CTX; i++) {
 		if (!mvm->phy_ctxts[i].ref)
@@ -793,6 +795,22 @@ static void iwl_mvm_handle_per_phy_stats(struct iwl_mvm *mvm,
 			le32_to_cpu(per_phy[i].channel_load_by_us);
 		mvm->phy_ctxts[i].channel_load_not_by_us =
 			le32_to_cpu(per_phy[i].channel_load_not_by_us);
+
+		if (mvm->phy_ctxts[i].last_jiffies) {
+			if (j > mvm->phy_ctxts[i].last_jiffies)
+				jdiff = j - mvm->phy_ctxts[i].last_jiffies;
+			else
+				/* jiffies wrapped, just count from zero, close enough. */
+				jdiff = j;
+
+			/* We know busy percentage, back convert this to total
+			 * time and total busy time.
+			 */
+			mvm->phy_ctxts[i].channel_time_accum += jdiff;
+			mvm->phy_ctxts[i].channel_busy_accum +=
+				(jdiff * mvm->phy_ctxts[i].channel_load) / 100;
+		}
+		mvm->phy_ctxts[i].last_jiffies = j;
 	}
 }
 
-- 
2.42.0


