Return-Path: <linux-wireless+bounces-13162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E93B985970
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61EA1F246EA
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E0E18594A;
	Wed, 25 Sep 2024 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVyVZ85h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971281AB4;
	Wed, 25 Sep 2024 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264339; cv=none; b=lINHfb/0DHaEDcGdh0kMeoALOQgyWSRxZarV3MJC14a/mcicz5jGTMsyZTbqAkImTpiEx58v3O0joQ0SFja6MwLikJC+hfPA/X//y/lATUotAW0HHQjETshdMtz1TlvYZ/MouswlBaihS3qkbqtkAmrURoRVSRfTXZpLZXpBZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264339; c=relaxed/simple;
	bh=GBsbo7IFzTYhDq3+ukaOAtQG/zZeRYQZxfjfOTdqrnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4X+HObGQsvuZKYEW7NzR44utD0fsazhAR6sTdXlTJWl2kquzQWUishlkhNNY/+470EgGvOju4Z0NFHxXSoqPT/wYU6DFCthgI9kMMv7E3/r1bm/bHPaTOW+iLkqjMhg6USJkrgp2Cc16bE/4x6B40JQdE+Bx/C4yEqiNZ03FUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVyVZ85h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C60C4CEC3;
	Wed, 25 Sep 2024 11:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264339;
	bh=GBsbo7IFzTYhDq3+ukaOAtQG/zZeRYQZxfjfOTdqrnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVyVZ85hIHC3ChJ1+kSWRnlKd8hWtQSwGjwbYtRdsofaJel99ZGV0sg2DkN/zgqO6
	 +Jowrz56vTEUiW6BVu3bQvufCRdLOjlgQsOr7F1dpOnVgSEEncfJGTiX4Yqb+jkMUY
	 r1vTJfPlS8uIEpmHMji87jznlMA6MkaTXvDxuN/Z5ZfM6n5B4nl5jMUjR0Wwkbhtxo
	 hNG8ZkiNfdFhby43nEZk4kdycKJJ7woRv3GisiGd/HgnQqwfvUpHrgIFQwdqORMNxo
	 DhR1eRLYppvek/3EC/RN8iqiLw5rJQkhSyu8RvA2x+E9XW36Il9CKqHXv4E/RTlje7
	 p7qm0Vz7TnjUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	emmanuel.grumbach@intel.com,
	daniel.gabay@intel.com,
	shaul.triebitz@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 060/244] wifi: iwlwifi: mvm: avoid NULL pointer dereference
Date: Wed, 25 Sep 2024 07:24:41 -0400
Message-ID: <20240925113641.1297102-60-sashal@kernel.org>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 557a6cd847645e667f3b362560bd7e7c09aac284 ]

iwl_mvm_tx_skb_sta() and iwl_mvm_tx_mpdu() verify that the mvmvsta
pointer is not NULL.
It retrieves this pointer using iwl_mvm_sta_from_mac80211, which is
dereferencing the ieee80211_sta pointer.
If sta is NULL, iwl_mvm_sta_from_mac80211 will dereference a NULL
pointer.
Fix this by checking the sta pointer before retrieving the mvmsta
from it. If sta is not NULL, then mvmsta isn't either.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20240825191257.880921ce23b7.I340052d70ab6d3410724ce955eb00da10e08188f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 7ff5ea5e7aca5..db926b2f4d8d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1203,6 +1203,9 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	bool is_ampdu = false;
 	int hdrlen;
 
+	if (WARN_ON_ONCE(!sta))
+		return -1;
+
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	fc = hdr->frame_control;
 	hdrlen = ieee80211_hdrlen(fc);
@@ -1210,9 +1213,6 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (IWL_MVM_NON_TRANSMITTING_AP && ieee80211_is_probe_resp(fc))
 		return -1;
 
-	if (WARN_ON_ONCE(!mvmsta))
-		return -1;
-
 	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
 		return -1;
 
@@ -1343,7 +1343,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 		       struct ieee80211_sta *sta)
 {
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_sta *mvmsta;
 	struct ieee80211_tx_info info;
 	struct sk_buff_head mpdus_skbs;
 	struct ieee80211_vif *vif;
@@ -1352,9 +1352,11 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 	struct sk_buff *orig_skb = skb;
 	const u8 *addr3;
 
-	if (WARN_ON_ONCE(!mvmsta))
+	if (WARN_ON_ONCE(!sta))
 		return -1;
 
+	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
 	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
 		return -1;
 
-- 
2.43.0


