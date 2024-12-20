Return-Path: <linux-wireless+bounces-16649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D58839F97AC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 18:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16D31891254
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB6721A453;
	Fri, 20 Dec 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5hLmrz0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92221A43B;
	Fri, 20 Dec 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714694; cv=none; b=eLGyrXPzHZPEOQwBOSC/u9NRTvOZ43Yf2MXGeAvE8H3Ms3LrqlD0MwxlqbRlJ4CSEFFonrL+J72efs5t7EhoLXeEqsF7ZCRDs2wAPHRITGd6J7y3+W5J0pYt96qpbjL9+TGiNAzeHYMHlQsgxhFJUk2Wc/I7IcmI6UMzDCoZQ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714694; c=relaxed/simple;
	bh=VV6KKTzpVo3hjmrO+OROnbwBZJ9ynx0um7DIRRvF6zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bzRC0E5OiMaZ3Db16Jnh6eoEDZTFsGBkx7PgjIroOh8ErAAHwkJ3zORKgmBducX1RFpRUwb2aIEDbu1ZV81GwhibQjDq9VA8MOzTmNcZ+H1LuWnxKyyAcXU64JPJYUxBvZn3RmLIBjS2cvd4gP9ROlt7AYOMoUJD1BIyA8RxBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5hLmrz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77048C4CEDC;
	Fri, 20 Dec 2024 17:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714694;
	bh=VV6KKTzpVo3hjmrO+OROnbwBZJ9ynx0um7DIRRvF6zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5hLmrz0SXwSHF0DfMKMyiOyvuUKgFr3sT9BH1KbPHIhPb3p7zY11VDm/+KLXUIvw
	 nq2uC8CwPMkYA1PfVHNVkr3pmyF0dIhCnnI3AAA0aMBGTQZAbFVA/O+/sv61HpdgQB
	 gIUQYPN/aniT48xdHeIe2mNOOi2/Ke7pAJyATANtNJu/q+Y3QbNinwq/uN4eEfIufj
	 DU7HM5A+ajjaTIiZgE5Im+zEGCJ9gonkaURkqEyr3WmsBAasCbFbjyOHFd+hlDaPjj
	 aG75s/V5lqX2LWzuEQdo9WCCxw/EKfGUGtwOHK/UuF4GGD7844DWEnsM/CjJsi4Wbf
	 84hLbTfYU6g0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Issam Hamdi <ih@simonwunderlich.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 02/29] wifi: mac80211: fix mbss changed flags corruption on 32 bit systems
Date: Fri, 20 Dec 2024 12:11:03 -0500
Message-Id: <20241220171130.511389-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Issam Hamdi <ih@simonwunderlich.de>

[ Upstream commit 49dba1ded8dd5a6a12748631403240b2ab245c34 ]

On 32-bit systems, the size of an unsigned long is 4 bytes,
while a u64 is 8 bytes. Therefore, when using
or_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE),
the code is incorrectly searching for a bit in a 32-bit
variable that is expected to be 64 bits in size,
leading to incorrect bit finding.

Solution: Ensure that the size of the bits variable is correctly
adjusted for each architecture.

 Call Trace:
  ? show_regs+0x54/0x58
  ? __warn+0x6b/0xd4
  ? ieee80211_link_info_change_notify+0xcc/0xd4 [mac80211]
  ? report_bug+0x113/0x150
  ? exc_overflow+0x30/0x30
  ? handle_bug+0x27/0x44
  ? exc_invalid_op+0x18/0x50
  ? handle_exception+0xf6/0xf6
  ? exc_overflow+0x30/0x30
  ? ieee80211_link_info_change_notify+0xcc/0xd4 [mac80211]
  ? exc_overflow+0x30/0x30
  ? ieee80211_link_info_change_notify+0xcc/0xd4 [mac80211]
  ? ieee80211_mesh_work+0xff/0x260 [mac80211]
  ? cfg80211_wiphy_work+0x72/0x98 [cfg80211]
  ? process_one_work+0xf1/0x1fc
  ? worker_thread+0x2c0/0x3b4
  ? kthread+0xc7/0xf0
  ? mod_delayed_work_on+0x4c/0x4c
  ? kthread_complete_and_exit+0x14/0x14
  ? ret_from_fork+0x24/0x38
  ? kthread_complete_and_exit+0x14/0x14
  ? ret_from_fork_asm+0xf/0x14
  ? entry_INT80_32+0xf0/0xf0

Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
Link: https://patch.msgid.link/20241125162920.2711462-1-ih@simonwunderlich.de
[restore no-op path for no changes]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 640239f4425b..50eb1d8cd43d 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1157,14 +1157,14 @@ void ieee80211_mbss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 				       u64 changed)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
-	unsigned long bits = changed;
+	unsigned long bits[] = { BITMAP_FROM_U64(changed) };
 	u32 bit;
 
-	if (!bits)
+	if (!changed)
 		return;
 
 	/* if we race with running work, worst case this work becomes a noop */
-	for_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE)
+	for_each_set_bit(bit, bits, sizeof(changed) * BITS_PER_BYTE)
 		set_bit(bit, ifmsh->mbss_changed);
 	set_bit(MESH_WORK_MBSS_CHANGED, &ifmsh->wrkq_flags);
 	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
-- 
2.39.5


