Return-Path: <linux-wireless+bounces-23589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21DACD196
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 02:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5353A374B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 00:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CCF282E1;
	Wed,  4 Jun 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0mM3VY0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05661FFE;
	Wed,  4 Jun 2025 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998392; cv=none; b=Jefwj7xouI4PHvg3mbmrx1Eaq7puPgu8F3j5KWscLhJl9Kmh740Iw5HkX1YxXAbtvGi48l8W7Lko6Q6Ahid649rn3UktInqFcvc9JQHBoHnOaYqte2dr0r2OQz2Gsc5mCzufj9XUkI+XyLtTeOmPhJiGFvc0fsM1dV4gMRA/mtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998392; c=relaxed/simple;
	bh=/jRi3XCSAt5tvrdykx0ifVGMEOP/JVR1Em2Y/tRHjK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWYeWnAJjdHMNe8TlpKlnehg6r1Akus5vEl6scpmp4WdPiJsDXkNMqMCz7pxq2q1yN4SCHrgGBGbKBx/qHhaWNP0/mP9sjRCdQ3gSqWDXftPBoqwLuw6uqlYlK/0cSjev8Ha9NKDbZf3X9MCBjc54ZoJJia/Cy+LN3R7HRup5Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0mM3VY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86F9C4CEED;
	Wed,  4 Jun 2025 00:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998391;
	bh=/jRi3XCSAt5tvrdykx0ifVGMEOP/JVR1Em2Y/tRHjK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0mM3VY0p6er3/mg4LVCoh8XyDKF75gJ+mFucJISvOczDxvUpxL5xStm0a56KLyLh
	 VtM90PVsMCXip+IFCwLcP0ApuEhqpknirEAMB99F8+jxGAmSod5OzfQ2DHFg+EHIPH
	 mAYu1klci7rE4EtBQK7gTw+gA6aVKqeDSBBz2t9bt7kvxRQ40KNCCySdtgSuanwxIp
	 LobiASmiOU4ksWAiEtmilibpbfs3A2lWbhjIN2TdEPoss9Aznjbe9yAizjElSt7DIA
	 nmJTqEq7RdEb/sja/6hkA0/M/t/w1wZxa7t61mkZMeZbWf6r5Tf5A3/c1TS7Q3Gf6a
	 Ke8E71KQXCJYg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Rouven Czerwinski <rouven@czerwinskis.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 059/118] wifi: mac80211: do not offer a mesh path if forwarding is disabled
Date: Tue,  3 Jun 2025 20:49:50 -0400
Message-Id: <20250604005049.4147522-59-sashal@kernel.org>
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
index c94a9c7ca960e..91444301a84a4 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -636,7 +636,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 				mesh_path_add_gate(mpath);
 		}
 		rcu_read_unlock();
-	} else {
+	} else if (ifmsh->mshcfg.dot11MeshForwarding) {
 		rcu_read_lock();
 		mpath = mesh_path_lookup(sdata, target_addr);
 		if (mpath) {
@@ -654,6 +654,8 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 		rcu_read_unlock();
+	} else {
+		forward = false;
 	}
 
 	if (reply) {
@@ -671,7 +673,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	if (forward && ifmsh->mshcfg.dot11MeshForwarding) {
+	if (forward) {
 		u32 preq_id;
 		u8 hopcount;
 
-- 
2.39.5


