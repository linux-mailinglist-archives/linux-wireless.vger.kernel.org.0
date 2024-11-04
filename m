Return-Path: <linux-wireless+bounces-14862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3BE9BB1AE
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41871F231DB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66B21B3939;
	Mon,  4 Nov 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIURNw5H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88061B3933;
	Mon,  4 Nov 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717477; cv=none; b=Wyht/zBbtRFTjBNcA/D4laDYDNU2ccJ4rfdaXNdLAObyfWGMK8v8FWoC5WJozdNT8EI5AQgkEfs7rFnOoG2DW+8VC1JPPWuHXyPay02y4kmJEUBsVnZfH2iv1t/3iFcOdAAZaubSVkDHwiPs8nnx+JKtMzqKySsBgUd8R0ISWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717477; c=relaxed/simple;
	bh=078z344qK136gdKc1G9op3WRZgmwYwDZ0bUamHeqYQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0B7XHSp5ciMg0l+/jIwv4b233ZVfZ4v0W1E+IjG8LBYNDiRib8IHNtuvkpMX3obZt3iMpl7Jq8mi+lp15FgIJGqpyWaC14/aXoAQBDHYaeq2qwvPnN1KNRztMEX2bDRTXagg4Wz/DXwcxc0V6ofjX06OTwaHoE3HuojGD4AyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIURNw5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93EDC4CECE;
	Mon,  4 Nov 2024 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717477;
	bh=078z344qK136gdKc1G9op3WRZgmwYwDZ0bUamHeqYQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIURNw5HqvuTf8Y7d63bGrIjb8bUTlQVSs0fzsM6qHCfspyn63NB+vb634oBcyImp
	 uGXkU4KanrhX69FflsUNLZUDo8+54ZFqI/rC2xNObwdExq4YkXWiyPO/VqzwMzYMP4
	 I68HizVHIzQcx8HT0cTZWmWq39EOyHfbRPPx+IHDXK4GSOp3ENcrlET58HzsRvTagd
	 RG5En2+OWUgTDoQfOKp/Wzl4ryfQh3aLKFm3Mk/ePAUvExnQfZQ8JeBpiGpIE9xuwC
	 Uvh0yAfuYo0wwUq+CpLcofwv0NC/B2PI73HdET46erZGSaIToY/TlBbCb3l/wEQUY0
	 ywTC/UjaNON/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	shaul.triebitz@intel.com,
	gregory.greenman@intel.com,
	yedidya.ben.shimol@intel.com,
	benjamin.berg@intel.com,
	emmanuel.grumbach@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 10/21] wifi: iwlwifi: mvm: Use the sync timepoint API in suspend
Date: Mon,  4 Nov 2024 05:49:46 -0500
Message-ID: <20241104105048.96444-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit 9715246ca0bfc9feaec1b4ff5b3d38de65a7025d ]

When starting the suspend flow, HOST_D3_START triggers an _async_
firmware dump collection for debugging purposes. The async worker
may race with suspend flow and fail to get NIC access, resulting in
the following warning:
"Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)"

Fix this by switching to the sync version to ensure the dump
completes before proceeding with the suspend flow, avoiding
potential race issues.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20241010140328.9aae318cd593.I4b322009f39489c0b1d8893495c887870f73ed9c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/init.c | 4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c  | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index d8b083be5b6b5..de87e0e3e0725 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -39,10 +39,12 @@ void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 }
 IWL_EXPORT_SYMBOL(iwl_fw_runtime_init);
 
+/* Assumes the appropriate lock is held by the caller */
 void iwl_fw_runtime_suspend(struct iwl_fw_runtime *fwrt)
 {
 	iwl_fw_suspend_timestamp(fwrt);
-	iwl_dbg_tlv_time_point(fwrt, IWL_FW_INI_TIME_POINT_HOST_D3_START, NULL);
+	iwl_dbg_tlv_time_point_sync(fwrt, IWL_FW_INI_TIME_POINT_HOST_D3_START,
+				    NULL);
 }
 IWL_EXPORT_SYMBOL(iwl_fw_runtime_suspend);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 99a541d442bb1..f4f87edb86e5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1398,7 +1398,9 @@ int iwl_mvm_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 
 	iwl_mvm_pause_tcm(mvm, true);
 
+	mutex_lock(&mvm->mutex);
 	iwl_fw_runtime_suspend(&mvm->fwrt);
+	mutex_unlock(&mvm->mutex);
 
 	return __iwl_mvm_suspend(hw, wowlan, false);
 }
-- 
2.43.0


