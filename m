Return-Path: <linux-wireless+bounces-12419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F5E96A900
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCC91F212AA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06741E1A2D;
	Tue,  3 Sep 2024 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj2T5XmZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA751D88BF;
	Tue,  3 Sep 2024 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396265; cv=none; b=Shu3swDfYx/ccYn8RM2KbwR4upukFNfYxLYpWXB2h+L0DTQwqp/bYLkaAP/7bNjJAoIVEero+8REf8des8TwjFgPKOVIJx8I3uYMRY64k5ifjrkLk9ACBzGHzANsXGvUTNbPUVp41AX+wVlHOkMgaWEcfTgiiQkdwdqR5jOdIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396265; c=relaxed/simple;
	bh=k9rr4eNXZj0ytidC7NQf0/31f/a67CD6lA3ksBB4HbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4+k00bW4y7L8MLcMq9xqOOQxwl8lpLxNfDOiHy4t9wlq8BsLhteH6ASXFSGHDRc6T0wcAxAvo3az2Dw5021PhKMYzJkyJaM/z4f+Es4lbKl5TbtK+wscLV57QJtVc8XuMFgGd9ys7FC6ytukzL/ZthFwYpgL1BE8kNkCKUIqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj2T5XmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2E0C4CEC8;
	Tue,  3 Sep 2024 20:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396265;
	bh=k9rr4eNXZj0ytidC7NQf0/31f/a67CD6lA3ksBB4HbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dj2T5XmZD5Klj73rCcmfsl0QvAggZ+zCSxFkBznCaqDsQKxCLYhNKjNDQQrSiaCku
	 1LoYe03fg9dqWf4Zr0v9tPtLL/kPuKsolG8VBWNAhdGK15clyCGT20wA4E77D5MBR9
	 WtQILqSJ80hXGFj54YAQy6EVT1ptBZVmnX7qST9esIqXnSyZpiAM1he7oIUnef6W6j
	 oGHBRLP/mvkAqe/rC8X3657c4vIwcpDdaEXpJnYf5hBmy6zFDaNfvgIdVwv7b7OI/J
	 2N5qhmJr22YDYLlHRSjo8A4zAuZTcwEI1pX+nHArFvlf01R8S4syroZhl+b8MHe00J
	 WgmUfeo98Bm7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	ayala.beker@intel.com,
	benjamin.berg@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/20] wifi: iwlwifi: mvm: fix iwl_mvm_scan_fits() calculation
Date: Tue,  3 Sep 2024 15:23:47 -0400
Message-ID: <20240903192425.1107562-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit d44162280899c3fc2c6700e21e491e71c3c96e3d ]

The calculation should consider also the 6GHz IE's len, fix that.
In addition, in iwl_mvm_sched_scan_start() the scan_fits helper is
called only in case non_psc_incldued is true, but it should be called
regardless, fix that as well.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240825191257.7db825442fd2.I99f4d6587709de02072fd57957ec7472331c6b1d@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 9ca90c0806c0f..c61068144c638 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -830,8 +830,8 @@ static inline bool iwl_mvm_scan_fits(struct iwl_mvm *mvm, int n_ssids,
 	return ((n_ssids <= PROBE_OPTION_MAX) &&
 		(n_channels <= mvm->fw->ucode_capa.n_scan_channels) &
 		(ies->common_ie_len +
-		 ies->len[NL80211_BAND_2GHZ] +
-		 ies->len[NL80211_BAND_5GHZ] <=
+		 ies->len[NL80211_BAND_2GHZ] + ies->len[NL80211_BAND_5GHZ] +
+		 ies->len[NL80211_BAND_6GHZ] <=
 		 iwl_mvm_max_scan_ie_fw_cmd_room(mvm)));
 }
 
@@ -3118,18 +3118,16 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		params.n_channels = j;
 	}
 
-	if (non_psc_included &&
-	    !iwl_mvm_scan_fits(mvm, req->n_ssids, ies, params.n_channels)) {
-		kfree(params.channels);
-		return -ENOBUFS;
+	if (!iwl_mvm_scan_fits(mvm, req->n_ssids, ies, params.n_channels)) {
+		ret = -ENOBUFS;
+		goto out;
 	}
 
 	uid = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params, type);
-
-	if (non_psc_included)
-		kfree(params.channels);
-	if (uid < 0)
-		return uid;
+	if (uid < 0) {
+		ret = uid;
+		goto out;
+	}
 
 	ret = iwl_mvm_send_cmd(mvm, &hcmd);
 	if (!ret) {
@@ -3146,6 +3144,9 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 	}
 
+out:
+	if (non_psc_included)
+		kfree(params.channels);
 	return ret;
 }
 
-- 
2.43.0


