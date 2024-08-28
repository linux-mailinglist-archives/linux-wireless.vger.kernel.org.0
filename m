Return-Path: <linux-wireless+bounces-12187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8ED9631BB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 22:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2500128516B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 20:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF8D1AC44C;
	Wed, 28 Aug 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ZsKMrrWG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CB1AAE3F
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876797; cv=none; b=i8aTRwqeXAGZKHY3/9wcjGiJAxzAwaPy4yX61aSDWujugNHwpVA7vaICxPKc+szj03++UnhInhqVmTgStVOwRZDIA5STIKiQ9Rvmn67BVMtHOBwHPgzlqs3AFcg9WNLYVq2IqiNcaMzRjAMckDMi8XD3FQlI84KEifIoBGBW7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876797; c=relaxed/simple;
	bh=rUzpzIQc7/5hv4Z3yNkWksgaZcXkhtQWacjy2RigLe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiptUK7pQKiQyEkoq5HVTf3UANIoQvUb/IC1B1TRfWjZGnO5tdzpjVHG44EH24t01kgCgja0eQOmQQurnEhLcfmCkf72o5oBjv/7RXLPCYt36ztoXVoVEcdwh6YW/cnp50lsYyRbGgYMxXQNAtQUFfw11Qj39Ke4Ugtd8s4GtNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ZsKMrrWG; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 02115A80070
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 20:26:32 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id A0AE413C2B0;
	Wed, 28 Aug 2024 13:26:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A0AE413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724876792;
	bh=rUzpzIQc7/5hv4Z3yNkWksgaZcXkhtQWacjy2RigLe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZsKMrrWGe5gmumnvWT31aCRHzpLeRx0QyP/YuLxh1pznkNgJ1dT1kfwXrYd5aSpIr
	 VE9T3AnwNke3bJBdY9n283EXWCaRJUMELtM2QzRxOvQcpY75NGcIUrDkSXUqeAYiZH
	 NXI4xNWCOQsgJ+Ux25ZF3As+l8CnoXViYP8pjbXc=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/2] wifi: iwlwifi:  Fix emlsr exit due to tput sampling too fast.
Date: Wed, 28 Aug 2024 13:26:30 -0700
Message-ID: <20240828202630.2151365-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240828202630.2151365-1-greearb@candelatech.com>
References: <20240828202630.2151365-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1724876793-g7ZynLhXcJiQ
X-MDID-O:
 us5;ut7;1724876793;g7ZynLhXcJiQ;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

I noticed that the tput check was running very often (and often
right after we entered emlsr mode), putting the radio in and
out of emlsr mode often.  That caused link instability as well
as poor performance.  Add timer so that we only
check stats after at least 5 seconds.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  5 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 12 ++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index f3fb37fec8a8..d4e232d2818b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -1112,6 +1112,11 @@ static void iwl_mvm_esr_unblocked(struct iwl_mvm *mvm,
 
 	IWL_DEBUG_INFO(mvm, "EMLSR is unblocked\n");
 
+	/* Don't block based on tput until at least our sample period,
+	 * by faking that we sampled just now.
+	 */
+	mvm->esr_tpt_ts = jiffies;
+
 	/* If we exited due to an EXIT reason, and the exit was in less than
 	 * 30 seconds, then a MLO scan was scheduled already.
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 22bec9ca46bb..5bbb8063bd1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1101,6 +1101,7 @@ struct iwl_mvm {
 	unsigned long init_status;
 
 	unsigned long status;
+	unsigned long esr_tpt_ts; /* last time we compared tput for ESR */
 
 	u32 queue_sync_cookie;
 	unsigned long queue_sync_state;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 41301070d23c..49442dd7ddd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -1035,6 +1035,8 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 #define SEC_LINK_MIN_PERC 10
 #define SEC_LINK_MIN_TX 3000
 #define SEC_LINK_MIN_RX 400
+/* Compare tput over this interval to determine in/out of ESR mode */
+#define MVM_ESR_TPT_INTERVAL (5 * HZ)
 
 static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 {
@@ -1061,6 +1063,10 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 	if (!mvmsta->mpdu_counters)
 		return;
 
+	if (!time_after(jiffies, mvm->esr_tpt_ts + MVM_ESR_TPT_INTERVAL))
+		return; /* check back later */
+	mvm->esr_tpt_ts = jiffies;
+
 	/* Get the FW ID of the secondary link */
 	sec_link = iwl_mvm_get_other_link(bss_vif,
 					  iwl_mvm_get_primary_link(bss_vif));
@@ -1084,6 +1090,8 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 		/*
 		 * In EMLSR we have statistics every 5 seconds, so we can reset
 		 * the counters upon every statistics notification.
+		 * NOTE:  This is not actually correct, I see this method called
+		 * often.  Thus the back-off timer 'esr_tpt_ts' above. --Ben
 		 */
 		memset(mvmsta->mpdu_counters[q].per_link, 0,
 		       sizeof(mvmsta->mpdu_counters[q].per_link));
@@ -1091,8 +1099,8 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 		spin_unlock_bh(&mvmsta->mpdu_counters[q].lock);
 	}
 
-	IWL_DEBUG_STATS(mvm, "total Tx MPDUs: %ld. total Rx MPDUs: %ld\n",
-			total_tx, total_rx);
+	IWL_DEBUG_INFO(mvm, "EMLSR: total Tx MPDUs: %ld. Rx: %ld sec-link tx: %ld  rx: %ld mvm-tput-thresh: %d\n",
+		       total_tx, total_rx, sec_link_tx, sec_link_rx, IWL_MVM_ENTER_ESR_TPT_THRESH);
 
 	/* If we don't have enough MPDUs - exit EMLSR */
 	if (total_tx < IWL_MVM_ENTER_ESR_TPT_THRESH &&
-- 
2.42.0


