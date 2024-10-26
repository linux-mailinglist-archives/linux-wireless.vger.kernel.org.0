Return-Path: <linux-wireless+bounces-14576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767E29B1928
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 17:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB4B1F21910
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8629464A8F;
	Sat, 26 Oct 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OavfMbRi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-72.smtpout.orange.fr [80.12.242.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112242AAD;
	Sat, 26 Oct 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956907; cv=none; b=cpEsq0YfqDcbqjdKa/j60dZPL5JRUMkjH+NuFGIJBtEXAkiHGZipjh8yaZ504rlq0smEXT1brc7Fud+yMSg3kx/iubQEfWtKLhKcBzPPI8TGbRrSEOOPWIYuyjso0waFrs2LdRmK9/Tae6t/BTTWX0J72UQIbISirsApZubrAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956907; c=relaxed/simple;
	bh=q0wFGvQNEXFxoWWcyEln5NmTQ3Zd/GO9h+dUjTGdXEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fli1/8iE+J43c4zuO/YFFcPCQULPtxZLXVsMiovI8/oGGkjJDdm7maJ6X2t4jCOPuEbmz1O4P5iDdLblzcF0WqhKqZbm60oqJGNARDHZSUadBa2zHW2L0JQ0lF0QcxNPhi1eDTsQqTXqWWStAdhEacBXlm7+oky0fX/s5aW8tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OavfMbRi; arc=none smtp.client-ip=80.12.242.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 4ioetj5Ryfe2v4ioetca9f; Sat, 26 Oct 2024 17:35:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729956901;
	bh=ah32deZFqehUA+7YVjigqrMZ336hzswVoe6QO6zHvM0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=OavfMbRiLm/L901yWoIEDArxt+EFwwRZcmuS6GChSaN+NnkBZvq38ssbPsLc+9Lrm
	 eKcQPjvGgjtaZR1pYuDJUrGN8rz2oaY04b3NtO6UWDK1m00A73pptp/7li1ipNz/qL
	 4CYYfJLYafZeenkdUTMFWx4l7qNLFyPrgR5eSKfvaEjKoYdug9Y41vsNBvIC3btfQB
	 6CWZyQQNO2lfA1vp13CxtLKPK5/0p7OvXXGfGRSSMxw+ZtsDxRI7oFUA6EWybL5JEE
	 sL3zYZPV0icxH+ZaI35+HRavu4PTi8C7NubFbe6ivI4jPZtlnIcTgldQSGxSUa60fb
	 um9e9JlYPdwbA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Oct 2024 17:35:01 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Johannes Berg <johannes@sipsolutions.net>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: cfg80211: Fix an error handling path in nl80211_start_ap()
Date: Sat, 26 Oct 2024 17:34:49 +0200
Message-ID: <eae54ce066d541914f272b10cab7b263c08eced3.1729956868.git.christophe.jaillet@wanadoo.fr>
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

Changes in v2:
  - Fix the subject

v1: apparently never reached lore, certainly because of the duplicated
subject with [1]

[1]: https://lore.kernel.org/all/eca90eeb4d9e9a0545772b68aeaab883d9fe2279.1729952228.git.christophe.jaillet@wanadoo.fr/
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


