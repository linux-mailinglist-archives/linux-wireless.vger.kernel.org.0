Return-Path: <linux-wireless+bounces-22558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3968AAA9AE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998C83A45F0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1793679AE;
	Mon,  5 May 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLTRXMMo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B3529A3EC;
	Mon,  5 May 2025 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485052; cv=none; b=CzxO0x9xWsLvRlY9JXRYU/5DspBDR7R/uv2qDzQaXbnaCXNBolKwxEsF1wn2X8JnFWMCmpnd0vOGFOtxv6lHFyWalaW1TKMiIWlACbBnWgSh1xOt7OzvP4P9gJucSpKty/m8RBu/FD0O7pvkM/oKRqCZMD5k7rFNrv5oNmV5dMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485052; c=relaxed/simple;
	bh=xlEAAQ5akJKtVJ5XsixfuB2tCpVwfqVZv6z2P0/TBFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WPkxre25fN3y2mmL6yr92dMTYreOAidLyXleVN1h+2xcgQ3pmedabKeEE0WFE4bRwo0k8OV1b5JKmUlNRUfxojInz3izZhVsGkUv0QVf5ci5gLNluYQqSRR3Lto5YcF1wm+YW2FHGbz1XkxBiOlDWDXerwpMPdkfeIwa3cSOwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLTRXMMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C40FC4CEE4;
	Mon,  5 May 2025 22:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485052;
	bh=xlEAAQ5akJKtVJ5XsixfuB2tCpVwfqVZv6z2P0/TBFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLTRXMMolhooXbapq4ZQh7ehv9rx9r1fVX2aKTKwVSdDwA13Uf3qyvLgLMsfAvzs0
	 sAvtBKwG4X2N4fDJsxARmA5SZEEmCbBzE6rx8HYtpn6qdLpvihwYO6jEVdtBpKcHc0
	 XNcdlhV/GHfaXMbUDefe9e157ooGPLyI3KNkchMjm6/aNq3w6xJ87FvrgYKHFuaDy/
	 Ek1BOfPg7c3UwcslvjfpQ5xck+OeTsQDdT4VqVUouLp70qSmt/KpLs7YwL61HMyBMz
	 c8DYVVAqskqF0nURfEfPi8smzTT6dRgXRnqx71DMunkS93VD64l5mv9zPczMk0DOjm
	 WBcVFd8oSWOeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux@treblig.org,
	ilan.peer@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 143/486] wifi: iwlwifi: mvm: fix setting the TK when associated
Date: Mon,  5 May 2025 18:33:39 -0400
Message-Id: <20250505223922.2682012-143-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

[ Upstream commit 3ad61970ac9e164be1b09b46c01aa942e8966132 ]

When running secured ranging and the initiator is associated with
the responder, the TK was not set in the range request command.
Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308231427.603dc31579d9.Icd19d797e56483c08dd22c55b96fee481c4d2f3d@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 55245f913286b..2ed7a0d77ef83 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -773,7 +773,11 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 			target.bssid = bssid;
 			target.cipher = cipher;
+			target.tk = NULL;
 			ieee80211_iter_keys(mvm->hw, vif, iter, &target);
+
+			if (!WARN_ON(!target.tk))
+				memcpy(tk, target.tk, TK_11AZ_LEN);
 		} else {
 			memcpy(tk, entry->tk, sizeof(entry->tk));
 		}
-- 
2.39.5


