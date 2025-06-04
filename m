Return-Path: <linux-wireless+bounces-23596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 792D8ACD1AF
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 02:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C778E7A8083
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC0A1B87D9;
	Wed,  4 Jun 2025 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rA18Fqv4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1A13C9D4;
	Wed,  4 Jun 2025 00:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998475; cv=none; b=frNi06gOExcmDRZdzQeFfSO7821x2afAc6E0bBXJIYv4f/oH4QvJK14hLpjMo2+wAguCT4Lf//AW8hLP8mJu8jjUyfbzcUQxSI32ovbSTJQNaCwgVFr+70jf4KezO+PAX8IPb1t0axLdLU//9LTO3NENN3AKtpeduTUcKAPeapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998475; c=relaxed/simple;
	bh=tFGsvqvech7ksg56U9qoYPE0d2lElABxTC1KWEKJhGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hwKLi+zDkgHrcK+iNsaCZpZbZ+uVGpFe0NPDAw25ui6alCNEns2HdaEs7R0jRkBlUX7aLFAocR6I/0wGqH+89xzUf/OFND6bCaA69ifd5CCItkFRTIFKF3rgkcGRIYCqx0UZsGZTimeidYr4QnyrUybPSUsllIy/CkCfJHYYMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rA18Fqv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24C2C4CEED;
	Wed,  4 Jun 2025 00:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998475;
	bh=tFGsvqvech7ksg56U9qoYPE0d2lElABxTC1KWEKJhGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rA18Fqv4rK3j09osWtaynikIQQQ4wAUhz8o4WawjYAITOX3VFEF688aar7cSbjISM
	 iIYEYaksyLC0mstFr8ozTiQzzSb74DLyZn+VfqrSWmpZSnTEW5WprJeDn0H5sp32u3
	 1O5NgUipnw7FAS1NZqRT+ZtgD2jVTFbznM4J2BQwfAMXIGwEQLTC1pBFSYK4CVcq7C
	 qPMrIYiziAHJ85PceK65I0JE+lfcM/qmia0vusCtlA5K13GlHQqW4qyHwMnjrDwdPM
	 LDHOagRTRv5UogpBqcuZKmPLd1f25ndrswtWUehHTbIP44ZwXF/Jjba/NF8DIT4+t5
	 EynsOMPdX/+OA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.15 095/118] wifi: ath12k: make assoc link associate first
Date: Tue,  3 Jun 2025 20:50:26 -0400
Message-Id: <20250604005049.4147522-95-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit ead6d41116b81098061c878d9bfc0b1a6c629090 ]

In MLO scenario WCN7850 firmware requests the assoc link to associate
before any other links. However currently in
ath12k_mac_op_vif_cfg_changed() we are doing association in an ascending
order of link id. If the assoc link does not get assigned the smallest
id, a non-assoc link gets associated first and firmware crashes.

Change to do association for the assoc link first.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Link: https://patch.msgid.link/20250409-ath12k-wcn7850-mlo-support-v2-5-3801132ca2c3@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: ## Critical Bug Fix Analysis ### The Problem The
commit fixes a **critical firmware crash** in MLO (Multi-Link Operation)
scenarios for WCN7850 hardware. The commit message clearly states: - "If
the assoc link does not get assigned the smallest id, a non-assoc link
gets associated first and **firmware crashes**" - This indicates a
severe user-affecting bug that causes complete driver/firmware failure
### Code Analysis - What's Being Fixed **Before the fix:** The original
code processed MLO links in ascending link ID order: ```c
for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) { //
Process any link first, potentially non-assoc links ath12k_bss_assoc(ar,
arvif, info); } ``` **After the fix:** The new code ensures the
association link is processed first: ```c if (vif->cfg.assoc) { //
FIRST: Handle the assoc link specifically arvif =
wiphy_dereference(hw->wiphy, ahvif->link[ahsta->assoc_link_id]);
ath12k_bss_assoc(ar, arvif, info); // THEN: Handle remaining links,
excluding assoc link links &= ~BIT(ahsta->assoc_link_id);
for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
ath12k_bss_assoc(ar, arvif, info); } } ``` ### Why This Qualifies for
Stable Backporting 1. **Fixes User-Affecting Bug**: Firmware crashes
directly impact users by causing connection failures and system
instability. 2. **Critical Hardware Support**: The fix affects WCN7850
and QCN9274 hardware which are actively used Wi-Fi 7 chips in current
devices. 3. **Small, Contained Fix**: The change is minimal - just
reordering the association sequence. It doesn't introduce new features
or architectural changes. 4. **MLO is Production Ready**: MLO (Multi-
Link Operation) is part of the Wi-Fi 7 standard and is being deployed in
production devices. 5. **Firmware Dependency**: The commit addresses a
strict firmware requirement that "requests the assoc link to associate
before any other links" - this is a hardware/firmware constraint, not a
driver preference. 6. **Low Regression Risk**: - The fix only changes
the order of operations - It maintains the same logic but ensures
correct sequencing - The exclusion of the assoc link (`links &=
~BIT(ahsta->assoc_link_id)`) prevents double-processing ### Context from
Similar Commits All the provided similar commits were marked "NO" for
backporting because they were either: - Adding new MLO
features/functionality - Implementing new capabilities - Making
architectural changes This commit is fundamentally different - it's
fixing a **firmware crash bug** in existing MLO functionality. ###
Hardware Impact The fix specifically mentions testing on: - WCN7850
hw2.0 PCI (two different firmware versions) - QCN9274 hw2.0 PCI These
are current-generation Wi-Fi 7 chipsets actively deployed in consumer
and enterprise devices. ### Conclusion This commit fixes a critical
firmware crash that affects users of Wi-Fi 7 devices with MLO
capability. The fix is small, targeted, and addresses a fundamental
firmware requirement. It meets all criteria for stable backporting:
important bug fix, minimal risk, contained change, and affects hardware
in active use.

 drivers/net/wireless/ath/ath12k/mac.c | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index dfa05f0ee6c9f..3d925f208176b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3702,6 +3702,8 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 	unsigned long links = ahvif->links_map;
 	struct ieee80211_bss_conf *info;
 	struct ath12k_link_vif *arvif;
+	struct ieee80211_sta *sta;
+	struct ath12k_sta *ahsta;
 	struct ath12k *ar;
 	u8 link_id;
 
@@ -3714,6 +3716,35 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ASSOC) {
+		if (vif->cfg.assoc) {
+			/* only in station mode we can get here, so it's safe
+			 * to use ap_addr
+			 */
+			rcu_read_lock();
+			sta = ieee80211_find_sta(vif, vif->cfg.ap_addr);
+			if (!sta) {
+				rcu_read_unlock();
+				WARN_ONCE(1, "failed to find sta with addr %pM\n",
+					  vif->cfg.ap_addr);
+				return;
+			}
+
+			ahsta = ath12k_sta_to_ahsta(sta);
+			arvif = wiphy_dereference(hw->wiphy,
+						  ahvif->link[ahsta->assoc_link_id]);
+			rcu_read_unlock();
+
+			ar = arvif->ar;
+			/* there is no reason for which an assoc link's
+			 * bss info does not exist
+			 */
+			info = ath12k_mac_get_link_bss_conf(arvif);
+			ath12k_bss_assoc(ar, arvif, info);
+
+			/* exclude assoc link as it is done above */
+			links &= ~BIT(ahsta->assoc_link_id);
+		}
+
 		for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
 			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
 			if (!arvif || !arvif->ar)
-- 
2.39.5


