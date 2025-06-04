Return-Path: <linux-wireless+bounces-23636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19BDACD392
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E7F1882EDB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435E1F7554;
	Wed,  4 Jun 2025 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+XE8GTd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3961F6679;
	Wed,  4 Jun 2025 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998879; cv=none; b=JVKC/VepqVt0epBUdn84bAUJEKULpYSHtt+Bxo+S/8vg/cf3hkVXyYJ2gruOMO0EqM6xpC5M94xK2qS9p/ALD1p0kWE/x+hJZHoziIoAlFvhwjsbTrfKAbiGN0jtZWaVNtAOkjzS4rNJILObLSuzn6T5AnkuLPBrieWGGy84gAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998879; c=relaxed/simple;
	bh=bS+a4Wj3sXm8dQ1JWw2YZwTfm6RPL1ikJbQBwAJYelI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtHTwHnsEY+w9bM4AwugPIrW2kWp6ZNSzKM4vruYaYJl87nGdQYnW5u/vp8bpvok2vIIK2OSek5L/13tOz/kQo6eeZFjp/XHyNHgMYaSgRWvTgt43GD07TSgzn9+0B6rwq0NFBDQde/vaA9L3+rc4PaWfm9KoGNG44rwJjtkBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+XE8GTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FCBC4CEED;
	Wed,  4 Jun 2025 01:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998879;
	bh=bS+a4Wj3sXm8dQ1JWw2YZwTfm6RPL1ikJbQBwAJYelI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V+XE8GTdYK0lf5tOH6KT5/SusmOLWeHjg4su1+oXpWpQ4nyqa7s5076UgTjtQDTzU
	 YyKrGB+GDG7hi0JSV+W+kvmBhOAxgGMdRuEuHrR/I9gzzT1PqdUrBmMoVZjfC/JYKC
	 4PFaSEqC2p344vlJaMyqcIrY2EY+IIQY1jmESw/bR7w8xfQjAIV8JFe33oufZdw4U7
	 sYevPtZMxK9VC/e0DcRdZOsuVmrisGet+9fXrcn3rkZCxGpSy60b4JD/G7c84/uX/d
	 air2X3gXQZc6Zm5nRznzEzToA8XnEBkPr8/DDXx2Hg+NkT4kJNAzJuqsvfiGerVwSf
	 81cMyXWAa/M/g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Muna Sinada <muna.sinada@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 65/93] wifi: mac80211: VLAN traffic in multicast path
Date: Tue,  3 Jun 2025 20:58:51 -0400
Message-Id: <20250604005919.4191884-65-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005919.4191884-1-sashal@kernel.org>
References: <20250604005919.4191884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Muna Sinada <muna.sinada@oss.qualcomm.com>

[ Upstream commit 1a4a6a22552ca9d723f28a1fe35eab1b9b3d8b33 ]

Currently for MLO, sending out multicast frames on each link is handled by
mac80211 only when IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX flag is not set.

Dynamic VLAN multicast traffic utilizes software encryption.
Due to this, mac80211 should handle transmitting multicast frames on
all links for multicast VLAN traffic.

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Link: https://patch.msgid.link/20250325213125.1509362-4-muna.sinada@oss.qualcomm.com
[remove unnecessary parentheses]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: ## Backporting Analysis: YES ### Nature of the
Change This is a **targeted bug fix** that addresses a functional gap in
MLO (Multi-Link Operation) multicast handling for AP_VLAN interfaces.
The commit extends existing logic rather than introducing new features.
### Technical Assessment **The Problem Fixed:** The original code in
`ieee80211_subif_start_xmit()` only handled `NL80211_IFTYPE_AP`
interfaces for MLO multicast transmission, but completely missed
`NL80211_IFTYPE_AP_VLAN` interfaces. This created a behavioral
inconsistency where: - AP interfaces: Properly handled MLO multicast
transmission via `ieee80211_mlo_multicast_tx()` - AP_VLAN interfaces:
Fell through to normal transmission path, bypassing MLO multicast
coordination **The Fix Applied:** ```c } else if
(ieee80211_vif_is_mld(&sdata->vif) && - sdata->vif.type ==
NL80211_IFTYPE_AP && - !ieee80211_hw_check(&sdata->local->hw,
MLO_MCAST_MULTI_LINK_TX)) { + ((sdata->vif.type == NL80211_IFTYPE_AP &&
+ !ieee80211_hw_check(&sdata->local->hw, MLO_MCAST_MULTI_LINK_TX)) || +
(sdata->vif.type == NL80211_IFTYPE_AP_VLAN && +
!sdata->wdev.use_4addr))) { ``` This change: 1. **Extends existing
conditional logic** to include AP_VLAN interfaces 2. **Uses existing
infrastructure** (`ieee80211_mlo_multicast_tx()`) 3. **Adds proper
validation** (excludes 4-address/WDS mode via `!use_4addr`) ### Risk
Analysis: LOW RISK **Minimal Change Scope:** - Single conditional
modification in well-established code path - No new functions, data
structures, or APIs introduced - Uses existing MLO multicast
transmission infrastructure **Well-Contained Impact:** - Only affects
MLO multicast transmission for AP_VLAN interfaces - Preserved existing
behavior for all other interface types - Added validation ensures
appropriate application scope **Backward Compatibility:** - No changes
to external interfaces or user-visible behavior - No impact on non-MLO
or non-VLAN configurations - Maintains existing AP interface behavior
unchanged ### Comparison with Similar Commits This commit aligns with
**Similar Commit #4** (MLD address translation fix - Status: YES): -
Both are targeted bug fixes for MLO functionality - Both address
specific functional gaps rather than adding new features - Both use
existing infrastructure to correct behavioral issues - Both have minimal
risk profiles suitable for stable backporting **Contrasts with rejected
commits:** - Unlike Similar Commits #1, #2: This is not implementing new
MLO features - Unlike Similar Commit #3: This is not changing
encapsulation behavior - Unlike Similar Commit #5: This is not removing
functionality ### Production Impact **Functional Benefits:** - **Fixes
MLO+VLAN deployments**: Enables proper multicast operation in combined
MLO/VLAN environments - **Consistency**: Ensures uniform multicast
handling across AP and AP_VLAN interface types - **Reliability**:
Prevents potential multicast delivery issues in enterprise VLAN
configurations **Real-World Relevance:** - AP_VLAN interfaces are
commonly used in enterprise environments for traffic segmentation - MLO
is increasingly deployed in Wi-Fi 7 scenarios - The combination creates
practical deployment scenarios where this fix is needed ### Stable Tree
Criteria Compliance ✅ **Important bug fix**: Addresses functional gap
affecting MLO+VLAN deployments ✅ **Minimal risk**: Single conditional
extension with clear validation ✅ **No architectural changes**: Uses
existing MLO multicast infrastructure ✅ **Well-contained**: Affects only
specific interface type in specific scenario ✅ **Production relevant**:
Impacts real-world enterprise VLAN configurations This commit represents
a clear bug fix that resolves a functional inconsistency in MLO
multicast handling, making it well-suited for stable kernel backporting
according to established criteria.

 net/mac80211/tx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0ff8b56f58070..ef16ff149730a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4523,8 +4523,10 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 						     IEEE80211_TX_CTRL_MLO_LINK_UNSPEC,
 						     NULL);
 	} else if (ieee80211_vif_is_mld(&sdata->vif) &&
-		   sdata->vif.type == NL80211_IFTYPE_AP &&
-		   !ieee80211_hw_check(&sdata->local->hw, MLO_MCAST_MULTI_LINK_TX)) {
+		   ((sdata->vif.type == NL80211_IFTYPE_AP &&
+		     !ieee80211_hw_check(&sdata->local->hw, MLO_MCAST_MULTI_LINK_TX)) ||
+		    (sdata->vif.type == NL80211_IFTYPE_AP_VLAN &&
+		     !sdata->wdev.use_4addr))) {
 		ieee80211_mlo_multicast_tx(dev, skb);
 	} else {
 normal:
-- 
2.39.5


