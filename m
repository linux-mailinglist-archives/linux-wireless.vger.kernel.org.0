Return-Path: <linux-wireless+bounces-20867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E067A727A6
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 01:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB86189264C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 00:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A3B10F2;
	Thu, 27 Mar 2025 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9GO/qTB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49086182;
	Thu, 27 Mar 2025 00:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743033845; cv=none; b=l02pbzvfxEJrVGph9vbPGCQjXuKpH1+r7WKe3UFaAIjJukl5uKtnHMB1Z1GEK9j1vxime1HgH+gHQd+y+MO6Jv4gWG3oKyY69JFAEomcY0QDnZtAvEz5LiB9mWo0FzlSD8QgGaHQZ5/xgymW6vcQys2TdkQ5zVafcvRMaq9f/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743033845; c=relaxed/simple;
	bh=vK0aPQQu7t8WWcg47RuiGPjQTiNHQdOEcdVdPR0YyKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PEusYnOUNYdmdrTP/1t1RMgkG74I9QqAT6RHjNHn3w+WGumruQ5rhcgPvt/axLTzgXZLibvmK1q4JLNRItNs2ZJJS7dXJ89JIUCqAXfuGZjoGVrJJKZS6FWL3oGHG+EyDM8okjSZD1wQnYZh91ZG3rv//QccQgoNhsB4JPV9j5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9GO/qTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B02C4CEE2;
	Thu, 27 Mar 2025 00:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743033844;
	bh=vK0aPQQu7t8WWcg47RuiGPjQTiNHQdOEcdVdPR0YyKA=;
	h=Date:From:To:Cc:Subject:From;
	b=h9GO/qTBYVjiZara2QwSntQo/6uSzCCMUNsvUgS9FqUiBmCbolrjAZkPMPCBiREeL
	 DHWSiC5MvlUJzj26om+jinzzG3lqIv5H2z4jIO5XfZ5hqI0UHBcq/mZ5x/a5uo2KO5
	 9F4QIo0zNS0jL6qWBS8tyMlll2tvARx6LT+6IKbJRN/okYMjQq7WhhFmKcNp6vpuOX
	 g4Z3eGgsjx6QRCYoERLj+iR8DKacZ15NR+2Duddtblb/GH7Q0QhFcTYLBTUQCi15qV
	 +Rch8ozFRX4+kc20WabVcBGE3MNhcE3R+De//npbsbfQ3eMiDfFvNxbTas3UnG1bmk
	 jfe1/O2C5Bg1A==
Date: Wed, 26 Mar 2025 18:04:02 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: iwlwifi: mvm: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-SV8gb6MuZJmmhe@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:

drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:6430:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1e916a0ce082..5d8f50a455d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6426,17 +6426,10 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 				     bool sync,
 				     const void *data, u32 size)
 {
-	struct {
-		struct iwl_rxq_sync_cmd cmd;
-		struct iwl_mvm_internal_rxq_notif notif;
-	} __packed cmd = {
-		.cmd.rxq_mask = cpu_to_le32(BIT(mvm->trans->num_rx_queues) - 1),
-		.cmd.count =
-			cpu_to_le32(sizeof(struct iwl_mvm_internal_rxq_notif) +
-				    size),
-		.notif.type = type,
-		.notif.sync = sync,
-	};
+	DEFINE_RAW_FLEX(struct iwl_rxq_sync_cmd, cmd, payload,
+			sizeof(struct iwl_mvm_internal_rxq_notif));
+	struct iwl_mvm_internal_rxq_notif *notif =
+			(struct iwl_mvm_internal_rxq_notif *)cmd->payload;
 	struct iwl_host_cmd hcmd = {
 		.id = WIDE_ID(DATA_PATH_GROUP, TRIGGER_RX_QUEUES_NOTIF_CMD),
 		.data[0] = &cmd,
@@ -6447,15 +6440,21 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 	};
 	int ret;
 
+	cmd->rxq_mask = cpu_to_le32(BIT(mvm->trans->num_rx_queues) - 1);
+	cmd->count = cpu_to_le32(sizeof(struct iwl_mvm_internal_rxq_notif) +
+				 size);
+	notif->type = type;
+	notif->sync = sync;
+
 	/* size must be a multiple of DWORD */
-	if (WARN_ON(cmd.cmd.count & cpu_to_le32(3)))
+	if (WARN_ON(cmd->count & cpu_to_le32(3)))
 		return;
 
 	if (!iwl_mvm_has_new_rx_api(mvm))
 		return;
 
 	if (sync) {
-		cmd.notif.cookie = mvm->queue_sync_cookie;
+		notif->cookie = mvm->queue_sync_cookie;
 		mvm->queue_sync_state = (1 << mvm->trans->num_rx_queues) - 1;
 	}
 
-- 
2.43.0


