Return-Path: <linux-wireless+bounces-10264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D8893290E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 16:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102BF285E95
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E28A1AAE3D;
	Tue, 16 Jul 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nucRSNlw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A2719E7DC;
	Tue, 16 Jul 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140144; cv=none; b=XlsFHNSFrKGYnPyWP9JfFn6XTJPNNdllPwX7VVPLOkGnO8ULyM62QUSiH5hvlzxs07LwI2bwo1HRi4Kx9n5JQvZGXdCy3OgO/Qwln0DyO5M+3+VJYV9lGxzEYIeQ/qkI7fgLzOJJkU1N8GQXsXGpxgX53QFcNT06zmLBsoqslxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140144; c=relaxed/simple;
	bh=SIucrbmhZqyMTuOmVJeRoHzWhoIQOE0Ug9b8r4PES5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKEehwD+Y7sVHchVOfIIk2BicQt8i53eeNCONz0f7oDOyswi1tpYast+g3UETUJkKzSSR0ZGe2yDjhq974rK58HYzwTJRCwieO7zh0XYiCgdy7iV1Tpj6JUnnLMPhQNMxVZTq/NWmp/hUT2pGAatD2HmMVQdu2em5jMTdYYcyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nucRSNlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D0AC4AF10;
	Tue, 16 Jul 2024 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140143;
	bh=SIucrbmhZqyMTuOmVJeRoHzWhoIQOE0Ug9b8r4PES5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nucRSNlwXWcDkv3lM1dXFDKR8AmcaacT8KC7lLLcsvxhpNML9a8w2YsR0tO+IKXJm
	 IA9KvjWu1xsOLsm59F8mnXApUmjIkh7H2xg6kQkHjMtzE0kcnuzsIbFLC7jhoL169v
	 hsZ3EF8XeSuUh1+MGUxNF3JeNMCtn2dDj+SO9tL9j0pcsj+j5LAS/kN+w9kn1Jmyln
	 Q83uIchloGuBSVev7IH2LzdkHygy/0yK3mV5vg11hrmHv+jPoF0v+2d+oM8ewCk5KJ
	 sOtCANDXXiAiB0lFCBi1H22gQDvQvTJVb6MyTSE7aNE5T2eDyQa16UEF4S9GFPoysH
	 B53jKpBcohM8g==
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
Subject: [PATCH AUTOSEL 6.1 13/15] wifi: iwlwifi: properly set WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK
Date: Tue, 16 Jul 2024 10:28:10 -0400
Message-ID: <20240716142825.2713416-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142825.2713416-1-sashal@kernel.org>
References: <20240716142825.2713416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
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
index 801098c5183b6..4e8bdd3d701bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -532,7 +532,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->features |= NL80211_FEATURE_WFA_TPC_IE_IN_PROBES;
 
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_KEK_KCK_MATERIAL,
-				  IWL_FW_CMD_VER_UNKNOWN) == 3)
+				  IWL_FW_CMD_VER_UNKNOWN) >= 3)
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK;
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
-- 
2.43.0


