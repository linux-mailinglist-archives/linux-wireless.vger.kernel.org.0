Return-Path: <linux-wireless+bounces-23648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C28DACD411
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDEC189A989
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A09F43146;
	Wed,  4 Jun 2025 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUqBjmKN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CAD20B804;
	Wed,  4 Jun 2025 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998994; cv=none; b=U9VPGScasxwvS3RVZr1UgO20cE3lbDc/nIEw1yZJpcQNqmQ0mn5RYXXfMJKW0mVqq61JmeSLOvWDPTrYF8GbVv159jyT/04P6ndGa50f3YDOtYobsbhlbsblSuilBd7dPDtzG0QpeOkrcjIhJLBv5Sx/cSrHroT7l71nKjtbGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998994; c=relaxed/simple;
	bh=BMk8zEnpyldgSIr9etxjg5IctGd7RMmP5qFlEz6K0LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoJQbL3q5x27KiOxR7Uxm1JDoQFVsLcW73RMMPsWBQBMQEPrYuwZB04MBUHwJt6VxAkhyttLoC/iMB9g12n9fHwZJ+2tZ+6xs5TY2Uyj5fv/oZdRX95gqLaMNeW2PT4Rqs0PSakpSZH7NW+yBHWdAbqEpD6HaJyN+2DGDGRY47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUqBjmKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A9FC4CEEF;
	Wed,  4 Jun 2025 01:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998993;
	bh=BMk8zEnpyldgSIr9etxjg5IctGd7RMmP5qFlEz6K0LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUqBjmKNHyrmIECFC05m3M+3d5fCMaU3MqqhjL/FZ2LMrd8kBc22z9ugT620bGkTN
	 uNTCq2TuvTM5j8Qa41Bt6MFZ2CxX/RUx+vPL+WpNH2Nr9TsfRImbti/y5xy4dGPrV1
	 PPXQu4i+kKJILjGHNdea5ZwP4aGRouV8RSqR3RLdMUPBRoao0YkQAhNQSAZ6wNvWWk
	 /sNjOI3asB7SAeyKsmObA/gTOG4aqBIWEG/083B9tf1boEjTNbGdcc85qgOu7UsP3K
	 j2C+EqI07HgnJu2roxWmgENoSlZUS8wvcknSzpmnz8pKN0J8wJIphu32C92FfDvw/G
	 yzMDj7lAKfsYg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Rouven Czerwinski <rouven@czerwinskis.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 33/62] wifi: mac80211: do not offer a mesh path if forwarding is disabled
Date: Tue,  3 Jun 2025 21:01:44 -0400
Message-Id: <20250604010213.3462-33-sashal@kernel.org>
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

From: Benjamin Berg <benjamin@sipsolutions.net>

[ Upstream commit cf1b684a06170d253b47d6a5287821de976435bd ]

When processing a PREQ the code would always check whether we have a
mesh path locally and reply accordingly. However, when forwarding is
disabled then we should not reply with this information as we will not
forward data packets down that path.

Move the check for dot11MeshForwarding up in the function and skip the
mesh path lookup in that case. In the else block, set forward to false
so that the rest of the function becomes a no-op and the
dot11MeshForwarding check does not need to be duplicated.

This explains an effect observed in the Freifunk community where mesh
forwarding is disabled. In that case a mesh with three STAs and only bad
links in between them, individual STAs would occionally have indirect
mpath entries. This should not have happened.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Reviewed-by: Rouven Czerwinski <rouven@czerwinskis.de>
Link: https://patch.msgid.link/20250430191042.3287004-1-benjamin@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and the code, here is my assessment:
**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## 1. Bug Fix Analysis The commit fixes a clear
logical bug in the mesh networking HWMP (Hybrid Wireless Mesh Protocol)
path selection algorithm. When `dot11MeshForwarding` is disabled, the
code was incorrectly: - Still performing mesh path lookups for PREQ
(Path Request) messages - Potentially replying with mesh path
information even though forwarding was disabled - Creating indirect mesh
path entries when it shouldn't ## 2. Code Analysis Looking at the
changes in `/net/mac80211/mesh_hwmp.c:619-676`: **Before the fix:** -
Line 639: `} else {` - The final else branch handles the case where the
target is neither local nor broadcast - Lines 640-656: This section
performs mesh path lookup and potentially replies with path information
**regardless** of forwarding status - Line 657: `} else {` - Only sets
`forward = false` but after potentially harmful operations **After the
fix:** - Line 639: `} else if (ifmsh->mshcfg.dot11MeshForwarding) {` -
Now conditions the mesh path lookup on forwarding being enabled - Lines
657-659: `} else { forward = false; }` - Clean fallback when forwarding
is disabled ## 3. Impact Assessment This is a **contained, low-risk
fix** that: - **Fixes incorrect behavior**: Prevents mesh nodes from
providing routing information when they won't actually forward packets -
**Prevents resource waste**: Avoids unnecessary mesh path lookups when
forwarding is disabled - **Improves network correctness**: Fixes the
inconsistency where nodes advertise paths they won't use - **Addresses
real-world issue**: The commit message mentions this was observed in the
Freifunk community ## 4. Comparison with Similar Commits This fix aligns
perfectly with the **YES** backport examples: **Similar to Commit #1
(mesh: Do not send PREQ if HWMP is disabled):** - Both prevent
sending/processing mesh protocol messages when a feature is disabled -
Both are small, surgical fixes to logical conditions - Both prevent
waste of network resources **Similar to Commit #3 (fix mesh path
discovery):** - Both fix incorrect mesh path handling logic - Both have
small, focused changes - Both include explicit mention of fixing
behavior observed in real deployments **Similar to Commit #4 (fix mesh
forwarding):** - Both are mesh forwarding-related fixes - Both are
minimal changes with clear intent - Both fix protocol correctness issues
## 5. Stable Backport Criteria Check ✅ **Fixes important bug**: Yes -
incorrect mesh protocol behavior ✅ **Small and contained**: Yes - only 4
lines changed, well-isolated ✅ **No new features**: Correct - only fixes
existing logic ✅ **No architectural changes**: Correct - just reorders
existing conditions ✅ **Low regression risk**: Very low - change is
localized and logical ✅ **Clear side effects**: None beyond the intended
fix ## 6. Risk Assessment The change is **extremely low risk** because:
- It only affects the specific case where `dot11MeshForwarding` is
disabled - It makes the code behavior more consistent (when forwarding
is off, don't provide path info) - The change is in line with the
intended semantics of the forwarding flag - It's a pure logic fix
without touching data structures or complex algorithms This commit
represents exactly the type of fix that stable trees are meant to
include: a small, well-understood bug fix that improves correctness
without introducing regression risk.

 net/mac80211/mesh_hwmp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index c6395551f5df0..54930b06c3a4a 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -634,7 +634,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 				mesh_path_add_gate(mpath);
 		}
 		rcu_read_unlock();
-	} else {
+	} else if (ifmsh->mshcfg.dot11MeshForwarding) {
 		rcu_read_lock();
 		mpath = mesh_path_lookup(sdata, target_addr);
 		if (mpath) {
@@ -652,6 +652,8 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 		rcu_read_unlock();
+	} else {
+		forward = false;
 	}
 
 	if (reply) {
@@ -669,7 +671,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	if (forward && ifmsh->mshcfg.dot11MeshForwarding) {
+	if (forward) {
 		u32 preq_id;
 		u8 hopcount;
 
-- 
2.39.5


