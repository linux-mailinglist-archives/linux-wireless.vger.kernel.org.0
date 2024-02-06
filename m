Return-Path: <linux-wireless+bounces-3241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EFE84BA8A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E75B290728
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FF213341F;
	Tue,  6 Feb 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ejj+StHo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AB1350DD
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235368; cv=none; b=Mcd3MSAj1REL/isVzPZHcZSd+bBfvyFTOJ+ameCi7LtEYGki0z6mfLY8Y5o+8CnAl3dwcgf+DZJCDrcYsIj0xkuKQbuGS9LFC/9bJA4TIb7VCrj9K6MkXpjwk8IscLy9vR9Z+b2D/xpsW/d0oS6rXOxxqledEKo76aaF2HtpU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235368; c=relaxed/simple;
	bh=LMeMhIkMgXkQBtVEmGNQfegeXLBykgbRGHUsxKQPkqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AK2CW4Z50aYEKl82k0M3ZWX4fJkpTisAOpG/zlZHze8jbTQyExJ7G9DXTokFIOM8GWIMgW9qL0YH1du0lGTsdCN9sfOU0mOmgvqQ+uira/Zaa+2NrSLznHQmm93k7d69RzeIxua78daO8Tr0RO8amafbkKvxakjsXIcjuySLRy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ejj+StHo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707235367; x=1738771367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LMeMhIkMgXkQBtVEmGNQfegeXLBykgbRGHUsxKQPkqU=;
  b=Ejj+StHoe/cNZqsziLd34zV93KtVJPxeWSHONhTepVXXP8deTUeKSZIX
   B0QOLMZJ8ojaaFbdE6rb3JCgjdzWS0iIgkNniNGCp1aRfbuQxJGQDSBHb
   q1buu7csQbvo9pTJ+9E83GwIxY7WROkbBFzVh5OT/yMAGoYIjhGGV9bTA
   2l49oddM57Brabnb+C4alKvg+Ovac7Jo4UXjwhMVizeqtrVAfZ8OQqFQh
   apdqP/47Gz+OLoaDI5Pxn6lu9lM76tauVlhR8j685ahHSkX0s9H1xDSqx
   +T+xAKLSdjZEucmH44rsoxQXCLutoKDdmWfoFb4V/e4dF7WoVoq0hZCV4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23252455"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23252455"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1349855"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/11] wifi: iwlwifi: mvm: move BA notif messages before action
Date: Tue,  6 Feb 2024 18:02:13 +0200
Message-Id: <20240206175739.825245e0803f.Ic607c57f43eb7c7ff122ffee8f3994fd040d578f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
References: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is always a bit confusing, the code first does all the
reclaim (with its own debug messages), and _then_ prints it
got a BA notification from firmware. Turn that around.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 3c887a8eebc0..dc3808e3c62e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -2211,6 +2211,12 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 				 tfd_cnt, pkt_len))
 			return;
 
+		IWL_DEBUG_TX_REPLY(mvm,
+				   "BA_NOTIFICATION Received from sta_id = %d, flags %x, sent:%d, acked:%d\n",
+				   sta_id, le32_to_cpu(ba_res->flags),
+				   le16_to_cpu(ba_res->txed),
+				   le16_to_cpu(ba_res->done));
+
 		rcu_read_lock();
 
 		mvmsta = iwl_mvm_sta_from_staid_rcu(mvm, sta_id);
@@ -2246,12 +2252,6 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 			iwl_mvm_tx_airtime(mvm, mvmsta,
 					   le32_to_cpu(ba_res->wireless_time));
 		rcu_read_unlock();
-
-		IWL_DEBUG_TX_REPLY(mvm,
-				   "BA_NOTIFICATION Received from sta_id = %d, flags %x, sent:%d, acked:%d\n",
-				   sta_id, le32_to_cpu(ba_res->flags),
-				   le16_to_cpu(ba_res->txed),
-				   le16_to_cpu(ba_res->done));
 		return;
 	}
 
@@ -2283,9 +2283,6 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 
 	rcu_read_unlock();
 
-	iwl_mvm_tx_reclaim(mvm, sta_id, tid, txq, index, &ba_info,
-			   tid_data->rate_n_flags, false);
-
 	IWL_DEBUG_TX_REPLY(mvm,
 			   "BA_NOTIFICATION Received from %pM, sta_id = %d\n",
 			   ba_notif->sta_addr, ba_notif->sta_id);
@@ -2298,6 +2295,9 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 
 	IWL_DEBUG_TX_REPLY(mvm, "reduced txp from ba notif %d\n",
 			   ba_notif->reduced_txp);
+
+	iwl_mvm_tx_reclaim(mvm, sta_id, tid, txq, index, &ba_info,
+			   tid_data->rate_n_flags, false);
 }
 
 /*
-- 
2.34.1


