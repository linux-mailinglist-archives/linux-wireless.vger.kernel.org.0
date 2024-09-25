Return-Path: <linux-wireless+bounces-13200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58B985EDC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC25E1F23FA0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783B51D1512;
	Wed, 25 Sep 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiVhX8Ew"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5095A1D14ED;
	Wed, 25 Sep 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266392; cv=none; b=eSBr6IOFdolp2p0R0UPMZVemqIAcMwqIO5lZa3Gr9h/s5CKiBedkldB5ZiPzs6Rzy3NqSfeSvKp+xF7IXhJ5FFpFetJevRM6G2Yq2GpEKTIgSBY5b1vxZu/XfEKL3LAlg7oo3vv8nU0z1OMPHTb/XZ4AxyxAayQWd7QVKnTrMqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266392; c=relaxed/simple;
	bh=VOl6weqFhgZ6WU5xoKzUvvhTxU/jF9zPRAl3BXwNs+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djIYP54K3OWHlIJHc/66NY3UBTRWLkLU3Y9qA9rFFm9MvmT/irFwdZVX/fjKoiIjQTD9UZnjzd+h0lKQgxkr4klQE2psnLpd/r1k/dKbC5NSwVOE+sPWd0/ss+tYxH07TCWPj+j32B637ye7Qd9KJaOHVEKADMC8spLRi44L9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiVhX8Ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEBEC4CEC3;
	Wed, 25 Sep 2024 12:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266391;
	bh=VOl6weqFhgZ6WU5xoKzUvvhTxU/jF9zPRAl3BXwNs+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiVhX8EwNJrXJ7RToy/GFAyJY/i1xcnw2zICwxNaxXPnjHPVnofecHGAnfoTnfzPX
	 FdY3P4TYwQ4G8ZwJ/1YuCydsscvmaNJWWTs+DIFRLvZpjeFc0aun17lly0Gq4apI7n
	 qwcrcgYP0VJYVlrbq7ZSRbI70mldWs2+klglZglGmU3TZ7daDHlD1oxUZ+jy/jj0Xg
	 7VWmFriLaeCtUKDQFIB+3e3OqeN7ToHeB/OcC7BU93+Z87AObmUnTIM0i446Lf+bym
	 7R4aB07L5wHR0V/mjC3LuZsZir1ZaafQ66iMn7r/m5EmO74S+JgTUNcllp9tp6rtMX
	 2s4Erspi2jlTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	ilan.peer@intel.com,
	emmanuel.grumbach@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 044/139] wifi: iwlwifi: mvm: use correct key iteration
Date: Wed, 25 Sep 2024 08:07:44 -0400
Message-ID: <20240925121137.1307574-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 4f1591d292277eec51d027405a92f0d4ef5e299e ]

In the cases changed here, key iteration isn't done from
an RCU critical section, but rather using the wiphy lock
as protection. Therefore, just use ieee80211_iter_keys().
The link switch case can therefore also use sync commands.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240729201718.69a2d18580c1.I2148e04d4b467d0b100beac8f7e449bfaaf775a5@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index fe4b39b19a612..7c9234929b4f1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -141,7 +141,7 @@ static void iwl_mvm_mld_update_sta_key(struct ieee80211_hw *hw,
 	if (sta != data->sta || key->link_id >= 0)
 		return;
 
-	err = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, sizeof(cmd), &cmd);
+	err = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
 
 	if (err)
 		data->err = err;
@@ -159,8 +159,8 @@ int iwl_mvm_mld_update_sta_keys(struct iwl_mvm *mvm,
 		.new_sta_mask = new_sta_mask,
 	};
 
-	ieee80211_iter_keys_rcu(mvm->hw, vif, iwl_mvm_mld_update_sta_key,
-				&data);
+	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_mld_update_sta_key,
+			    &data);
 	return data.err;
 }
 
@@ -384,7 +384,7 @@ void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 	if (!sec_key_ver)
 		return;
 
-	ieee80211_iter_keys_rcu(mvm->hw, vif,
-				iwl_mvm_sec_key_remove_ap_iter,
-				(void *)(uintptr_t)link_id);
+	ieee80211_iter_keys(mvm->hw, vif,
+			    iwl_mvm_sec_key_remove_ap_iter,
+			    (void *)(uintptr_t)link_id);
 }
-- 
2.43.0


