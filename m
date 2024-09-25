Return-Path: <linux-wireless+bounces-13160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A670985963
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ECBDB21FA3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1F819F416;
	Wed, 25 Sep 2024 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7XXNjly"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCE19E99D;
	Wed, 25 Sep 2024 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264324; cv=none; b=P2UpT63Z92Smg1lCdc1FqNKLVl9FUa5ar4NJGg1CDGu+rjhhecvLEf9qe0mjH08PtvjiMzxDH9IlqkuRBaoHsI06WqLCXn6dMuGo8xvRNizWpsJz/Fuz+xDN2zhXbrfLwbo2iL7l3+rSwWmZn4npkykU2QsIizE705RcnQCNvv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264324; c=relaxed/simple;
	bh=u0WGDzyHk2ozun13cuN+XFL+fQx79XzLs6qyjqdWpV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWQc9YA72YGiOmk01SdP1kK/jZ7sE1GSO1QCu6RWjJDOY7fPVUq1Oj1Q7kzPzVTQaq38ExRM/LFQgOHSsi7L7KFnuFMyfZYPhdOyciKBT6D1bJoBGeNjsDgzpw5yT/kcWml0s39r912RjqCyGPqqlANKTH+kGwTlTYx1XU35Mcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7XXNjly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27425C4CEC3;
	Wed, 25 Sep 2024 11:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264324;
	bh=u0WGDzyHk2ozun13cuN+XFL+fQx79XzLs6qyjqdWpV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7XXNjlyU2eVVmduP8PYZ9DgXX8yG0d6qrF1X7OumSmc3c6lHtNLfZJdUaFdojitt
	 jWGUJsSDPfPI3zEvjH8pgoMXhmZgo4DPe8fN/eYriU7a8ZvdiI+gXuI4zxqNTlBi2z
	 RitZDAhoGBALMXfbRFuThUjRkrk7/Zv8bx/vOV1sjtkXF2Y6QcuN3zEjxwXfNZA3L0
	 P8wp48gsnPSsJgF+PUrvVPRH+G58pDSJP5kFytBlxvgtO0SHghag9h3wcucXwpNBDc
	 wBMmPz6AHLMrfvxLRc66uCN+vwmss1d6Cet8jftrtP4PSLX1HX96STbC78Su7MQuc3
	 TDGRITpfHKweA==
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
Subject: [PATCH AUTOSEL 6.11 058/244] wifi: iwlwifi: mvm: use correct key iteration
Date: Wed, 25 Sep 2024 07:24:39 -0400
Message-ID: <20240925113641.1297102-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index 8a38fc4b0b0f9..455f5f4175064 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -144,7 +144,7 @@ static void iwl_mvm_mld_update_sta_key(struct ieee80211_hw *hw,
 	if (sta != data->sta || key->link_id >= 0)
 		return;
 
-	err = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, sizeof(cmd), &cmd);
+	err = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
 
 	if (err)
 		data->err = err;
@@ -162,8 +162,8 @@ int iwl_mvm_mld_update_sta_keys(struct iwl_mvm *mvm,
 		.new_sta_mask = new_sta_mask,
 	};
 
-	ieee80211_iter_keys_rcu(mvm->hw, vif, iwl_mvm_mld_update_sta_key,
-				&data);
+	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_mld_update_sta_key,
+			    &data);
 	return data.err;
 }
 
@@ -402,7 +402,7 @@ void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
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


