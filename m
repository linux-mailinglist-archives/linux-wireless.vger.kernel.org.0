Return-Path: <linux-wireless+bounces-13194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635E9985E74
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AB41C25420
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599FE1D043E;
	Wed, 25 Sep 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTSCNtAI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4A1D0439;
	Wed, 25 Sep 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266324; cv=none; b=ruMH/4Y3vD6vmwzbcrkyQBLr25N26g/or22Z2qIe6K/jmf2FyG1WKKjtwv6jncorTFxlpGsU6jCtbtYvuJ8cd3FVOvNUKG3MDZDrfV86a/UwoH9f5B3Pqumfn0dnNEwnBNZManibGr4+reVGUh7vBHrC3czRU0PrvEW+a1DBNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266324; c=relaxed/simple;
	bh=sdR78UZuwqODBmPftbc9lsJo5rbBnnCvvn12H87+OpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGfKM6DwcT1WTg4v+lxyNaMwFN+HIA+WNcwnhyAkMVAkK4ay98ihuT3BJxPqzVyf0Hn/KaGngVlMY0m78pRlr1dnpo+OM0eH5gNf/kvL88mxjELD1W9Jl+zWxoqbLtj0DnWIkrxzZlKx63+nRgfTl4X5zFkOi7qPBtxZP+mxm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTSCNtAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BE7C4CEC3;
	Wed, 25 Sep 2024 12:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266323;
	bh=sdR78UZuwqODBmPftbc9lsJo5rbBnnCvvn12H87+OpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTSCNtAIJvBd8HqnWE08FjWIBvCf4EmbJChTKnu7+RrLVFf8VwF6fMIIgGkllgmva
	 3Txm33IfK3kt+FpbUD4aC9e3zvTkGEhFKAgLm5UbHiYibgYbBX1PZ4PDIcakmBiGU+
	 KTagYIpKj01Cs/PsHOtmV6pwh7CFuC15MRnrj7aC9f1N3Qh/Ma6bYl/Sbsjjf6Zo8k
	 8476aODui5AAIsr9HgvhE1TJidPO8pk7h5i6+wXMNv53rnowwJNGetLpQoXHZpEopo
	 VoiGc/PWK7Z3PNZaAI/Br6B68PfcXdLfTd9V5qxvmFcap4HbziHp8CSvXt7uazTqxg
	 mcXB8+oNVO9Dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Issam Hamdi <ih@simonwunderlich.de>,
	Kretschmer Mathias <mathias.kretschmer@fit.fraunhofer.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 010/139] wifi: cfg80211: Set correct chandef when starting CAC
Date: Wed, 25 Sep 2024 08:07:10 -0400
Message-ID: <20240925121137.1307574-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Issam Hamdi <ih@simonwunderlich.de>

[ Upstream commit 20361712880396e44ce80aaeec2d93d182035651 ]

When starting CAC in a mode other than AP mode, it return a
"WARNING: CPU: 0 PID: 63 at cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]"
caused by the chandef.chan being null at the end of CAC.

Solution: Ensure the channel definition is set for the different modes
when starting CAC to avoid getting a NULL 'chan' at the end of CAC.

 Call Trace:
  ? show_regs.part.0+0x14/0x16
  ? __warn+0x67/0xc0
  ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
  ? report_bug+0xa7/0x130
  ? exc_overflow+0x30/0x30
  ? handle_bug+0x27/0x50
  ? exc_invalid_op+0x18/0x60
  ? handle_exception+0xf6/0xf6
  ? exc_overflow+0x30/0x30
  ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
  ? exc_overflow+0x30/0x30
  ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
  ? regulatory_propagate_dfs_state.cold+0x1b/0x4c [cfg80211]
  ? cfg80211_propagate_cac_done_wk+0x1a/0x30 [cfg80211]
  ? process_one_work+0x165/0x280
  ? worker_thread+0x120/0x3f0
  ? kthread+0xc2/0xf0
  ? process_one_work+0x280/0x280
  ? kthread_complete_and_exit+0x20/0x20
  ? ret_from_fork+0x19/0x24

Reported-by: Kretschmer Mathias <mathias.kretschmer@fit.fraunhofer.de>
Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
Link: https://patch.msgid.link/20240816142418.3381951-1-ih@simonwunderlich.de
[shorten subject, remove OCB, reorder cases to match previous list]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2b2dc46dc701f..b73ca37f452bf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10047,7 +10047,20 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 
 	err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms);
 	if (!err) {
-		wdev->links[0].ap.chandef = chandef;
+		switch (wdev->iftype) {
+		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_P2P_GO:
+			wdev->links[0].ap.chandef = chandef;
+			break;
+		case NL80211_IFTYPE_ADHOC:
+			wdev->u.ibss.chandef = chandef;
+			break;
+		case NL80211_IFTYPE_MESH_POINT:
+			wdev->u.mesh.chandef = chandef;
+			break;
+		default:
+			break;
+		}
 		wdev->cac_started = true;
 		wdev->cac_start_time = jiffies;
 		wdev->cac_time_ms = cac_time_ms;
-- 
2.43.0


