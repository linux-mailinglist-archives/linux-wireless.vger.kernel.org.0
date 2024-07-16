Return-Path: <linux-wireless+bounces-10263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F19328E4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 16:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614A82860A3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 14:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C561C19DF59;
	Tue, 16 Jul 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhXLcJUv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3B19DF54;
	Tue, 16 Jul 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140084; cv=none; b=ThFeZxobSESKt1/kAMbGF26qxzR+D1FOwGaT1h6Bt7vNDNl8AirvpSx9jXW4d+8jbv+RwA+3eDmeQG4sYfes+Lq+AjuE/o5pmoEucfuzEIiGugND441xWUxTeqvn08cQ4AQNIm/muu+BE8bf4xYFLmu9rwL2u8jkLbAGrShzFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140084; c=relaxed/simple;
	bh=qOWwlTCOD+fFJHDt1qdCncIJDfnrfXsltpRK1pZYfY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN9NOzvaSXrWAHp1SsBAE3VFNkN6mf1AAGkmdygNlAeMa+1SP9jjianpbHQkvkq4PuS7ldK/ucQPNyHSwFSdI/5A0W+h2zy9RYknGtIp9YgNy7cKz3UQ56ddSjRzTtIL6nVzOqGabW1CMMBz++fpM32UydYVr0bQispAsl2LNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhXLcJUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9389C4AF09;
	Tue, 16 Jul 2024 14:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140084;
	bh=qOWwlTCOD+fFJHDt1qdCncIJDfnrfXsltpRK1pZYfY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhXLcJUvj2GZk+B0tsqNZkd/IsvdnpXYXUAG32WgnHHw3GiBI9MecyomjZ5nJjpaV
	 5GXR6CaoGThJxGJD43C6D7ohWA1EEoc5wsKmmywyPihWnlQOxIS9fTBIT0IuSz5SXs
	 GqOWrdNjmtRmEQEErG89Oz3t96X4JZ082qGaonGSsSedjfyocaq9AXRCZ5kYOpen0h
	 1Tif7MEn7Gnh0iuDGcuYPwTE7pnMcZvDN8iSWWAKb6Fe/DrFf9fhdM49NBG6lNVOiM
	 l5wijUpZyiWWjrpf/LY8EEgdsu2iXuLlJnejCQdRSRENIhsFqKamBG2EBtQCLOAxVd
	 KDajgWRmIMvAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	emmanuel.grumbach@intel.com,
	ilan.peer@intel.com,
	shaul.triebitz@intel.com,
	benjamin.berg@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/18] wifi: iwlwifi: properly set WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK
Date: Tue, 16 Jul 2024 10:26:51 -0400
Message-ID: <20240716142713.2712998-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142713.2712998-1-sashal@kernel.org>
References: <20240716142713.2712998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit 4ec17ce716bdaf680288ce680b4621b52483cc96 ]

The WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK should be set based on the
WOWLAN_KEK_KCK_MATERIAL command version. Currently, the command
version in the firmware has advanced to 4, which prevents the
flag from being set correctly, fix that.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240703064026.a0f162108575.If1a9785727d2a1b0197a396680965df1b53d4096@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 375f401b14535..8a392d6226a29 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -600,7 +600,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->features |= NL80211_FEATURE_WFA_TPC_IE_IN_PROBES;
 
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_KEK_KCK_MATERIAL,
-				  IWL_FW_CMD_VER_UNKNOWN) == 3)
+				  IWL_FW_CMD_VER_UNKNOWN) >= 3)
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK;
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
-- 
2.43.0


