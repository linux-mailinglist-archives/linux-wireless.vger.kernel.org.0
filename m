Return-Path: <linux-wireless+bounces-22605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7202DAAB60C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CB1503B71
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0145929AB1A;
	Tue,  6 May 2025 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDY+OE3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10A23579F1;
	Mon,  5 May 2025 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485074; cv=none; b=rj2JSH3UOJuh7T19UF3A/WfYeq5vQw3FSTgEKlX/XneOon/hclzTBrjzBmZ3YpUOGpL/vT+uHoDEL5imYKrz2OQ2i5CXplOXtHvf47hmToehRRDiAmYU8zdyj4x2JUbZuhOOHzjfwwKC1SHL/axUpCurUPnesnGfGoWDi/JBE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485074; c=relaxed/simple;
	bh=5UYltFtK9fHPV7+8c5lZv+Yq4pxdhEUuN2aJzPU8pnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjesD4nmAGeg/LCEFmv2vl7fVRByGTPxQfEwPsp/c6ARy/hqVltiFwUWxr8ZA2LnDZrZEqpJyPmPreh4yjISqt3vCSUzPu0CWjPis4pWtoMMedjvFrggSbK92w7p1mUNvl5KyTzgKFWwd2Lh1Cg8GHPr7s8epGY629idMbuudZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDY+OE3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44971C4CEFC;
	Mon,  5 May 2025 22:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485073;
	bh=5UYltFtK9fHPV7+8c5lZv+Yq4pxdhEUuN2aJzPU8pnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDY+OE3DotyCPCpJ+Valb0HjaPk+66UjNbg2xCTUAUeWR9JP92x3ENJtnzX2m4bfb
	 +x+dwxTjIxLQX6befE7Xvaaj/78ehIJYIPlJ32GHh3NmHCDZjzqJRqKfEd0C5EXsxC
	 FNvoKdc8lIfA2Sl0kKI/jrM2uweMkrUGxTEWLD2W8ZnXrd7zX4/hBLbNU5oEq27ljb
	 ESz6vUWATJOeBnxDeWnjm3HmsGTVnrlaqQSPzq88Hx1xF57NbXX2k1+60NVNSMLUrr
	 plrU3Gwwc9vr6iWVpgEo3B1aCAqVEFpUeQ5Sb71MnQn7t2Shg8olnuR9n1rO7/Irqo
	 1BA3aBDaZtqpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 152/486] wifi: mac80211: fix warning on disconnect during failed ML reconf
Date: Mon,  5 May 2025 18:33:48 -0400
Message-Id: <20250505223922.2682012-152-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 0e104aa3676d020f6c442cd7fbaeb72adaaab6fc ]

If multi-link reconfiguration fails, we can disconnect with a local link
already allocated but the BSS entry not assigned yet, which leads to a
warning in cfg80211. Add a check to avoid the warning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308225541.699bd9cbabe5.I599d5ff69092a65e916e2acd25137ae9df8debe8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ad0d040569dcd..f000026ab714a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4033,7 +4033,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 			struct ieee80211_link_data *link;
 
 			link = sdata_dereference(sdata->link[link_id], sdata);
-			if (!link)
+			if (!link || !link->conf->bss)
 				continue;
 			cfg80211_unlink_bss(local->hw.wiphy, link->conf->bss);
 			link->conf->bss = NULL;
-- 
2.39.5


