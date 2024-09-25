Return-Path: <linux-wireless+bounces-13153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B69698583A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47731F216FE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284C1891D2;
	Wed, 25 Sep 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1t4jkxi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5B175D39;
	Wed, 25 Sep 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264233; cv=none; b=RFTfgds+latD5fo+jy4qPukkrrwZu5+aOnZ+ESGj2Qhp1nKv8WAah52ia5nkRkFc41dYnR8yntEtd6+D449AS2GVzf0fi6j/AuM3D/2StJ8kUELLXNDnGwHnOOvOHEuRnD4Sa8i4KqjRt5/RkhkifFWXN1hc6cllv/f1MTSKhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264233; c=relaxed/simple;
	bh=VznNeOfa9mAiXck3yvozKYyOsh5qI3c5igMK/gXNY3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU8swH1ikDxZmd+4S3ePXwL6Q5/M1NS488RpruD/KO8bV9E8VdY3Ygx8O2eaEYDlP0Hr4AA1UYQf/5bl9tEiVf4olfd4CwhO6LJ4tEVnVWXBuEouXuDRBIzJr6BYN15FxebJdF/h4f7TIWtJiED8z3zJCn5GtyLah/xIPsm5ql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1t4jkxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08475C4CEC3;
	Wed, 25 Sep 2024 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264232;
	bh=VznNeOfa9mAiXck3yvozKYyOsh5qI3c5igMK/gXNY3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1t4jkxi+ONfyfCzrd9vZ4Oefmbk6/7hsjcdglrR3dlFg80m5gkf0hIfkaUBSHTcF
	 EUMls3gspIhVsAvMMj/6bHSBPM/DETSmsGlpFo3bZDq8SDbFRVn6pXPo+NYqfCkDum
	 eNBNU3oc/191qJmrReb5HdB/9j50fz5hZIDNa97wJp0BVfXyDc37U8cudnabHhSv+T
	 ISIC9nAtPTInc6Na5tv29QfkZswqpctp0ofcqLo9mZ04tXLXFxEWIa7wfpA6NqiBPN
	 VTY29Qs8KAzixi0VaSlIAK+vplfzeHYyDXFvKFGecJGyGPixGH753Z2zkH4kDX4Kwp
	 XhRS0roxkoyhg==
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
Subject: [PATCH AUTOSEL 6.11 012/244] wifi: cfg80211: Set correct chandef when starting CAC
Date: Wed, 25 Sep 2024 07:23:53 -0400
Message-ID: <20240925113641.1297102-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index 7397a372c78eb..b368e23847ddb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10143,7 +10143,20 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 
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


