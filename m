Return-Path: <linux-wireless+bounces-14577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B039B19C4
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 18:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81B01C21072
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABB51386B4;
	Sat, 26 Oct 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iyjbS9op"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEED225D7;
	Sat, 26 Oct 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729959799; cv=none; b=rlnBfp6yO3Oy/QEUn96bTQIVXGGUOK/u8B8ghIeUcQ32a6Mkxeb68NCqk5FILmtE5AlzX48G2NcfEAYE/qEgLCapI4Mcfz5R/eYu+Be6aGPDFJCho4sPib/jpC9pXKazHe4PY9ZUJTnkO6ICM7wWfWQcHS5WccDggyoNAa8qslg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729959799; c=relaxed/simple;
	bh=gl0XiPLYaqdtqKKx4lPB9skPJRd+FpZJgXItJNF9m0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kha1wIJScKADyGQojX45uI1Kg8b2+XGenxKyj4c/yFw2lRnWx9QFn/g0I7xmo6v6GTp1oMczZYr0oysPx12XkGB8LrHhSkPXEwp/u9GKhlhcaMH1toHzaCG7quWJfNwF60GIYJeWACzHI6ygOgKEPfKxhVEGA2wcYassG3Am5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iyjbS9op; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 4hm8ti93L6VsB4hm8tSAdp; Sat, 26 Oct 2024 16:28:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729952901;
	bh=3mCVTqLTLwLxDDxxUVv7c+N1HoRAEqgJx3RUI6Owy48=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iyjbS9opdblEW7ao/BnvEMIWt92+ICTcHrMkjYn8grOFmGOPYd7Pih3mxGR3flbKK
	 TkEp5gTUhGGD/6pALo2Ba2eKCI632ykQjht8kBhBuIbEHgAa0i7+pPHlc7E2qys3OO
	 R3rEQmtNhb6n0fjejSSRPMZ2ruOW2Ron+BvFmPHY3deJyVHrEsn6ZhQhTbeUe2DNKs
	 LXTV9QlQckHH5tEhx1YWSoEmtsttUxPxKI5ILhRB05iruMQD7tYuRTn8ahFhXs3sV6
	 14TmBa1QZajLQLN/SRFwcRhiOxZUrnfxQS8l0SgNDTEyMXq8RaJTP2BECLLj6cHMjj
	 YS/CHI0k8A1qw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Oct 2024 16:28:21 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Johannes Berg <johannes@sipsolutions.net>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] rtnetlink: Fix an error handling path in rtnl_newlink()
Date: Sat, 26 Oct 2024 16:28:08 +0200
Message-ID: <881a292603df853c52c6197ea23cc44ed9141b86.1729952851.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All error handling paths go to "out", except this one. Before the commit in
Fixes, error in the previous code would also end to "out".

So, go to "out" also in this case to free some resources before returning.

Fixes: 62262dd00c31 ("wifi: cfg80211: disallow SMPS in AP mode")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 net/wireless/nl80211.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1ac8a196f376..d9cc33474b85 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6273,8 +6273,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_SMPS_MODE] &&
-	    nla_get_u8(info->attrs[NL80211_ATTR_SMPS_MODE]) != NL80211_SMPS_OFF)
-		return -EOPNOTSUPP;
+	    nla_get_u8(info->attrs[NL80211_ATTR_SMPS_MODE]) != NL80211_SMPS_OFF) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
 
 	params->pbss = nla_get_flag(info->attrs[NL80211_ATTR_PBSS]);
 	if (params->pbss && !rdev->wiphy.bands[NL80211_BAND_60GHZ]) {
-- 
2.47.0


