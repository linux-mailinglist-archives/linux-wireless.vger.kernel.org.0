Return-Path: <linux-wireless+bounces-12186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629F9631BA
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 22:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA01284D8B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBC81ABEA7;
	Wed, 28 Aug 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="DWTrRypH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C86815749A
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876796; cv=none; b=uM46rUBPiEMhDyVt0ApHpQvs63s9XZAwNgI7w/5WtWsGqStXOw2goAvNe+eUrgtLmhOONR8l+HdKpmLbBbMqjWvMNlNlMCOCIH2RTahdukDQ7atPHpyASkUq59X7lw8v6uIJqZW2n6fqT9nVYSDAEfr2z3Br7koB7uS/pCRQVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876796; c=relaxed/simple;
	bh=uPdMv4BxE7F7s7PzXwRRrPGCM4aNvT7kBPQzAPjRiT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SoN1FMRVOf2oJLNYNUNypS8/k+SwMjcb4lze/imQ/GsDIzhm/Yc05HKXDf3e78A4wu/4m6G4ASKC1j2WYH1maEc9ScE9HmH98PWSEisl8DYsUKwT9HqQDwT6qrW75ouo4+6kx5UhS6tVvDGzKQhyG/KLurFw8QDd6ZuA9qSjNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=DWTrRypH; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 30744340085
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 20:26:32 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 9B01113C2B0;
	Wed, 28 Aug 2024 13:26:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9B01113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724876791;
	bh=uPdMv4BxE7F7s7PzXwRRrPGCM4aNvT7kBPQzAPjRiT0=;
	h=From:To:Cc:Subject:Date:From;
	b=DWTrRypHDvsmS2bESy0k7GQ6Axenq3VYe+xlBtYQnGiEifbHVwSHDuuG/+AuXoEIi
	 r5FZ8swO8/Qk6ukqSDnTfEm6NPnii2jo/cnOnsO+9pMeQxKQ7Phbs4/af3KlzaAL+u
	 kJiyYzWn6aa0WxEs2/8hPuoHHhxo054k9UJfcMXs=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/2] wifi: iwlwifi:  Fix eMLSR band comparison.
Date: Wed, 28 Aug 2024 13:26:29 -0700
Message-ID: <20240828202630.2151365-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1724876792-t7KJgrjSlWoR
X-MDID-O:
 us5;at1;1724876792;t7KJgrjSlWoR;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Do not make assumptions about what band 'a' or 'b' are on.
And add new reason code for when eMLSR is disabled due to
band.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 13 ++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index bb3de07bc6be..f3fb37fec8a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -16,6 +16,7 @@
 	HOW(EXIT_LOW_RSSI)		\
 	HOW(EXIT_COEX)			\
 	HOW(EXIT_BANDWIDTH)		\
+	HOW(EXIT_BAND)			\
 	HOW(EXIT_CSA)			\
 	HOW(EXIT_LINK_USAGE)
 
@@ -750,11 +751,17 @@ bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 	    iwl_mvm_esr_disallowed_with_link(mvm, vif, b, false))
 		return false;
 
-	if (a->chandef->width != b->chandef->width ||
-	    !(a->chandef->chan->band == NL80211_BAND_6GHZ &&
-	      b->chandef->chan->band == NL80211_BAND_5GHZ))
+	if (a->chandef->width != b->chandef->width)
 		ret |= IWL_MVM_ESR_EXIT_BANDWIDTH;
 
+	/* Only supports 5g and 6g bands at the moment */
+	if (((a->chandef->chan->band != NL80211_BAND_6GHZ) &&
+	     (a->chandef->chan->band != NL80211_BAND_5GHZ)) ||
+	    ((b->chandef->chan->band != NL80211_BAND_6GHZ) &&
+	     (b->chandef->chan->band != NL80211_BAND_5GHZ)) ||
+	    (a->chandef->chan->band == b->chandef->chan->band))
+		ret |= IWL_MVM_ESR_EXIT_BAND;
+
 	if (ret) {
 		IWL_DEBUG_INFO(mvm,
 			       "Links %d and %d are not a valid pair for EMLSR, a->chwidth: %d  b: %d band-a: %d  band-b: %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ac4e135ed91b..22bec9ca46bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -368,6 +368,7 @@ struct iwl_mvm_vif_link_info {
  *	preventing the enablement of EMLSR
  * @IWL_MVM_ESR_EXIT_CSA: CSA happened, so exit EMLSR
  * @IWL_MVM_ESR_EXIT_LINK_USAGE: Exit EMLSR due to low tpt on secondary link
+ * @IWL_MVM_ESR_EXIT_BAND: Exit EMLSR due to incompatible Bands
  */
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
@@ -382,6 +383,7 @@ enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_EXIT_BANDWIDTH	= 0x80000,
 	IWL_MVM_ESR_EXIT_CSA		= 0x100000,
 	IWL_MVM_ESR_EXIT_LINK_USAGE	= 0x200000,
+	IWL_MVM_ESR_EXIT_BAND		= 0x400000,
 };
 
 #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
-- 
2.42.0


