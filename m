Return-Path: <linux-wireless+bounces-23650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE75ACD421
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37218188FC2B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384620D4FF;
	Wed,  4 Jun 2025 01:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WavufAx7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAA1DED5B;
	Wed,  4 Jun 2025 01:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999005; cv=none; b=SCzmVhj/+GU28tFoWhu39f6+1rz3ucEzwSzWWL3KsEtAJDrlr4mTNc6t4xD7OhsnzsCi0UrmvohNQFDvtmf0Z1P91cwTKULQClpHKE4Qsp/YgqNd3umQTejPYvX7bmuh+IfgstiOVZcfUhWzOXDf8+4VxEzJ01nzfAjD89eVKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999005; c=relaxed/simple;
	bh=gHz9Mi2wsiZLAHt56CLuwjHIXmjruR+siUg8F2DgVWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqHeVVUyMvzjTsGQQT43Cp9Lv68Mu/2kyu+YVFhwVNFHmmW/etwiEtgSu52T8Tge1rVGkhP38+dCdBPGFpi0T+56n41/DA/9uJFLSsztsE0Nk4o1a8u6E/9UIVdc4zfs6JUpv26drZWhKDCY6yt0VP2BfBpQu7OvP3Ce4e2lH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WavufAx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7088FC4CEED;
	Wed,  4 Jun 2025 01:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999005;
	bh=gHz9Mi2wsiZLAHt56CLuwjHIXmjruR+siUg8F2DgVWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WavufAx7CHhJ/xVYq9sWbKkBuwKSiLkflPJscXBIHS6SfqZ7qNh3A+gXwGIVSV0n2
	 0ZVYjBHV3imwlBhmgohsVr17HqEieRv+aqwUBfEXvtR31qNZ2vgXeia8Ak4ePy0GNK
	 evAioyDUyMq2nqZe840fPkKixICjFFYIOIHQ4eOinEkoGYsmU6tHN5NeiBvqyt++qG
	 /xvtKTZo9PaiN/YNgbDJx8zE67B8hwN4QCbdJ/1a86sN6k1/9IOm2+p1dDb2z9oMG2
	 cRlQApE1qPtE6qWIR7nCSpKuipFvCCwLcituM9IHSXajNF2OxARqMxEOkWqclXeL+Y
	 c2B5441bEtAPg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Muna Sinada <muna.sinada@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 41/62] wifi: mac80211: VLAN traffic in multicast path
Date: Tue,  3 Jun 2025 21:01:52 -0400
Message-Id: <20250604010213.3462-41-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010213.3462-1-sashal@kernel.org>
References: <20250604010213.3462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
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
index 45a093d3f1fa7..ec5469add68a2 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4507,8 +4507,10 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
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


