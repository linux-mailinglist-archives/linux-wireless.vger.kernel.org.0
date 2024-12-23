Return-Path: <linux-wireless+bounces-16705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9C9FA8F6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 02:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4721885B9A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 01:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958DB125DF;
	Mon, 23 Dec 2024 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="H4fH+3dv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1364C8E0;
	Mon, 23 Dec 2024 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734917531; cv=none; b=QlBxFmQsbB52n7KiPz/49HOmuS7yYMntAea1T80LdCimlAt3ETUrrjxnxUxUYcVN5VhRBWtGUyDqkbROXfIinNcN+B//CRZM4sJ9Va/qFz326SjTg0wfkLUh+64KDh1cKsgVdzNqcY5tIG3RvAwH9dzYGJ2qoP4rB46RGbMh/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734917531; c=relaxed/simple;
	bh=AGmeTzEq9UDMYEhQQcG+ExKe7SM7Zbb3FWck4yZ3IuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSTGK1Nzg9O8wy8FmhkPf6ALfETw7TcXdl1lKnX2aFBXUTEtPd/mBcDScPhiPP3NKMFl+glMFbPGl3Do7hE9fj4Ss1VarF/dD6h4tJBo78yTBv+tk7nGIyluzjt3S6/rre7QnpoGc46UOdw0PsnWc2aOKSbcnEaASMTorQaFdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=H4fH+3dv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=DbXfKvLpIWDd4oi4nV/mrOrMUSqMKMcgv5qSUZjB48Y=; b=H4fH+3dv8MxTpG05
	562NyLhjBw+5asXOL2J2srw70OqB9xqfRIXSndbiAb1YhlmAr9gFjbVTl/QKdDCCAw5tIYFBZIiJo
	yxzUPag+TEzC/f4UWhHiJ5LUZZfcwbTBSb9ZzEbMT0kTB7riLYgNWGw58OlC8AknGkv1ugfZLl0Yh
	Hc0n14CGjwBTDSwrbBUnCATeLUsAzDpqWjOfGVOm69tnlG3RrqvPa3qK2YbdPEmP/6b5T2mqnPWvg
	Aq5HX5TlStkQKYHIdgiZ66pv2ffj1CW/z9K+LGGvcp9ZtRCav54y7PcC6LqkkQnU/4Fv91RkXsm2O
	SNYGpnG996FkOjxIbg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPXIj-006oGv-1L;
	Mon, 23 Dec 2024 01:32:05 +0000
From: linux@treblig.org
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/6] iwlwifi: Remove unused iwl_mvm_rx_missed_vap_notif
Date: Mon, 23 Dec 2024 01:31:58 +0000
Message-ID: <20241223013202.340180-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223013202.340180-1-linux@treblig.org>
References: <20241223013202.340180-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

iwl_mvm_rx_missed_vap_notif() was added in 2019 by
commit 449a29d0fead ("iwlwifi: mvm: add notification for missed VAP")

but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 23 -------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 --
 2 files changed, 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 51ee62ae70fb..40e419523d08 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1975,26 +1975,3 @@ void iwl_mvm_channel_switch_error_notif(struct iwl_mvm *mvm,
 		ieee80211_channel_switch_disconnect(vif);
 	rcu_read_unlock();
 }
-
-void iwl_mvm_rx_missed_vap_notif(struct iwl_mvm *mvm,
-				 struct iwl_rx_cmd_buffer *rxb)
-{
-	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_missed_vap_notif *mb = (void *)pkt->data;
-	struct ieee80211_vif *vif;
-	u32 id = le32_to_cpu(mb->mac_id);
-
-	IWL_DEBUG_INFO(mvm,
-		       "missed_vap notify mac_id=%u, num_beacon_intervals_elapsed=%u, profile_periodicity=%u\n",
-		       le32_to_cpu(mb->mac_id),
-		       mb->num_beacon_intervals_elapsed,
-		       mb->profile_periodicity);
-
-	rcu_read_lock();
-
-	vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, true);
-	if (vif)
-		iwl_mvm_connection_loss(mvm, vif, "missed vap beacon");
-
-	rcu_read_unlock();
-}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2ad615293c75..79771c9d4557 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2093,8 +2093,6 @@ void iwl_mvm_mac_ctxt_recalc_tsf_id(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif);
 void iwl_mvm_probe_resp_data_notif(struct iwl_mvm *mvm,
 				   struct iwl_rx_cmd_buffer *rxb);
-void iwl_mvm_rx_missed_vap_notif(struct iwl_mvm *mvm,
-				 struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 					struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_channel_switch_error_notif(struct iwl_mvm *mvm,
-- 
2.47.1


