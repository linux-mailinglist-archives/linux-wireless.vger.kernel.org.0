Return-Path: <linux-wireless+bounces-13181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98174985CB3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 14:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC242868A1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5821D2F5B;
	Wed, 25 Sep 2024 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAU5548L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D141CC8B6;
	Wed, 25 Sep 2024 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265612; cv=none; b=Kv/SJRV0SKfGSOH44Xt1zSopwMy2sbI9uuRBiq5ikD6MH6a20d19m7+60kd29zCaDvwAz25NgV4XzhgRRrt5DrWFeLWDn0UXDtz08e8gunSQNExfREC6vT+TysHl6rZBg9/hzlP15rRYzDmH/y/eHMrA5p5kWDQCFJMOyeaRDeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265612; c=relaxed/simple;
	bh=u0WGDzyHk2ozun13cuN+XFL+fQx79XzLs6qyjqdWpV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOjCVMS6je+r6+QFuBHW8I+/JvwPZH7wQBJ5FG/o1HqNHefcMk0KvR6nkOzJZi/S9MFJQANBBwGpdRNkNPHUFfWZMi/PBs+OjMuuC2UYjc4AGHlCn8geyhftwJ16EPyWcX1rSOqIdd1G8LiRS9ElTxC4qdccJcKdFrrl8D8Mi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAU5548L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A30C4CEC3;
	Wed, 25 Sep 2024 12:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265612;
	bh=u0WGDzyHk2ozun13cuN+XFL+fQx79XzLs6qyjqdWpV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAU5548LAXi+YspB4G8rdwTVjFWU4I+8Wc54UqKpm4vhPgVFVKrPkpVP0v2hbL66+
	 hwyt3rBjaOLt/3sEIWYXR/XRX8g36VNIE4bOGU2t0+24qCkefwKlRB9782jcjqI6NH
	 mTdY7ZKVIcBvjiTwzXNzsRoC8SPVpJxR7RA9q+eFO3zYXymMDWNbkVQx0j+DL6O10Y
	 DaOPQ7BABLyBVOOALMamO+UE2K3U3pyCpFqIHkWtX/6sF+1R8jtGQMw1nuW+MBAj1i
	 kQ0h5ql+gIcMhNo8FXP5sEln/2wMahmotZnYc2hIbik3N6Mtfq5Bkxfy1SHvrJ5NZX
	 FymmpuIVJM7iA==
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
Subject: [PATCH AUTOSEL 6.10 049/197] wifi: iwlwifi: mvm: use correct key iteration
Date: Wed, 25 Sep 2024 07:51:08 -0400
Message-ID: <20240925115823.1303019-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


