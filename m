Return-Path: <linux-wireless+bounces-16286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7BB9EDE99
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 05:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BF5282E74
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 04:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97713C918;
	Thu, 12 Dec 2024 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="HwhV7sPD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4B2195
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 04:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978734; cv=none; b=RYNywiriljpCKNKyml8KJEbFLVqVsE0M0maxvI3Ch7QD3d1SvsJxxWvOlvH1xDYD9kXwa2aK4mwKAuBSCuNIfG9VqYSvQYsM+qItDiob+uYvj9fqDDBcnQ6jSwU2BV3I/sCsV8/B8j39EtgLvYnnARuwRXXnSV1FuNrM0JXB+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978734; c=relaxed/simple;
	bh=e5CDiDF9aTWrqcXdwCPHrIp+GI21qhHvn2tcBn7NOWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JL/hvVMm4wZVSWny/jpca2hhfOWOcyQePH7Mx5IrFahdRs+gP5Zy/L8bW5HXIoatqRPprMz+y9X7ChWTBaEKirbUhVE/riV7JeLqPbUvWY5/u0LBw/IDyuvUN4ieqHjtsCRZe3xQSAgxzNIbLVIP8vBqctnLfUVoQeF5wWDKrNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=HwhV7sPD; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E69FF280065
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 04:45:29 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 5933013C2B0;
	Wed, 11 Dec 2024 20:45:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5933013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733978729;
	bh=e5CDiDF9aTWrqcXdwCPHrIp+GI21qhHvn2tcBn7NOWM=;
	h=From:To:Cc:Subject:Date:From;
	b=HwhV7sPDIQKWnVchJlysb0McWRAac5AGGptFz95HezWjhinjyPkpiBUB0FgjSIqdk
	 j7ra60szo7nuFP9yA2FB8QsCiGFzJIaJV2OuNOOhMNwLQvTU95/um+d0UBiqSG8lJW
	 S+7ymHjX5E3n/GlAmu4aaS+sfmgx0rRiP3kTjFkM=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: iwlwifi:  Fix survey dump for be200 radios.
Date: Wed, 11 Dec 2024 20:45:22 -0800
Message-ID: <20241212044522.922351-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1733978730-72ODRH8hiBsk
X-MDID-O:
 us5;ut7;1733978730;72ODRH8hiBsk;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

The old code did not assign channel, so survey dump was always
empty.  Instead, return the info from the phy ctxts since we
can at least fake out the channel busy time with that.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 19 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 18 ++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fb341d8e8cdb..ec01350bbb34 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6080,6 +6080,25 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 
 	memset(survey, 0, sizeof(*survey));
 
+	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ) {
+		/* None of the code below this if clause appears to work
+		 * on be200 radios, primarily because 'channel' is not assigned.
+		 * So special case this to do something useful on be200
+		 * radio:  Return channel and busy-time for the first 3
+		 * phy contexts.
+		 */
+
+		survey->filled = SURVEY_INFO_TIME | SURVEY_INFO_TIME_BUSY;
+		if (idx > 2)
+			return -ENOENT;
+
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
index 42545b611b97..a4e789290dd6 100644
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
index 8230a9576428..3ac62ad0144b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -865,6 +865,8 @@ static void iwl_mvm_handle_per_phy_stats(struct iwl_mvm *mvm,
 					 struct iwl_stats_ntfy_per_phy *per_phy)
 {
 	int i;
+	unsigned long jdiff;
+	u64 j = jiffies_64;
 
 	for (i = 0; i < NUM_PHY_CTX; i++) {
 		if (!mvm->phy_ctxts[i].ref)
@@ -875,6 +877,22 @@ static void iwl_mvm_handle_per_phy_stats(struct iwl_mvm *mvm,
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


