Return-Path: <linux-wireless+bounces-23592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C94ACD1CF
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBA03A89D3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 00:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DAA339A1;
	Wed,  4 Jun 2025 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IepF5P48"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51913A265;
	Wed,  4 Jun 2025 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998447; cv=none; b=e+xcXO7KCYDOAG5nJ61CrCOgT3fnZlNLiF6OYz09al8dnBkFRgtAiwtuoitqJfvDmgC/hiMF34TRDu/k8/JkFFnsLJEzf2l96HOgPmbvXnZ+dPP5bv2yZ2JnNXc35VQFkgqLYB0+EWj5QAD7oiGApqhn+hEOA9oyyhrczpiNEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998447; c=relaxed/simple;
	bh=0KjZ6jbg/cTqOlL4jaiirb3ZZ16p0OrxMSCm0JPDxw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qvdn6N+yp8+UZE6M2UMlRDNgQgt34G9wOqEzGw++Enoxp665iC6XiAib8YmrtQiOFTCs2ZLG1QOjFOv4gBm4NS/vZIKLdpEDAc8niXNo0aKNWKJv7KaOnzV6rij0j0BzoH+3rACFNy/94HRmVrdCZfDJRSMWHc2H1WnhMQWQ7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IepF5P48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B9DC4CEEF;
	Wed,  4 Jun 2025 00:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998447;
	bh=0KjZ6jbg/cTqOlL4jaiirb3ZZ16p0OrxMSCm0JPDxw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IepF5P48jUVROn2Wg/BwxInRKXHRqRzZlZ3qG18WVq8uVh9m9TSDmvT3EI3sKBUG7
	 w4MPBzpZ3GXBUAsairTkZdHdTfn+8hnsgG2jjFE0AyBdF71MpRsmavVh9fisIQ4NP2
	 bbS7cNwus7taYHriikYj87IKxWMuchjUK/xRUFZqH7+FUmRSCCRa0rv9xwBNcNx4vC
	 CrhFgn3ZA2HVaZq1lWA1b56eI04dJFdH4WhA3zK+aztOyL4e3V3q9EBZVnbLZ0ydeQ
	 tuslvTWcnoEP2PwBxU13SzMWYWPOwOL3DsmUJp4YCkK2v4wmuidZDknTvLiPz0lKI8
	 R3WnNKYfR/SnQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Muna Sinada <muna.sinada@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 082/118] wifi: mac80211: VLAN traffic in multicast path
Date: Tue,  3 Jun 2025 20:50:13 -0400
Message-Id: <20250604005049.4147522-82-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005049.4147522-1-sashal@kernel.org>
References: <20250604005049.4147522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
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
index 20179db88c4a6..d6af02a524af3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4526,8 +4526,10 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
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


