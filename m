Return-Path: <linux-wireless+bounces-19691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C88AA4BB93
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946821893014
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26241F0E2C;
	Mon,  3 Mar 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sCb0ltea"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C81E570E
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996072; cv=none; b=LSL4yWKQNtDiNbxaLI2bLQSHiy0kk4xY0WI5b86ImClq66yv/CW5bunz/fkR6qjI0FCTlxY9fWCmomfcZI5NMPAF4yhpTEeuqcT1IVlR9f2wq3A1xQs7uLOr1ru4i0p4cqacHwdXjY91/R1eanFZukLgxJd9dRiWmx6kYAOPY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996072; c=relaxed/simple;
	bh=s6ZzXSjE2Oeeru6AM5NoGn96PyCmvCjYFWL/5ZI9UdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KS7dgpd5fZynU3rvzs0F15erjd0fZ/cZw3PoMSuqiWHwMYdUqcLLPH6LH1T3c+pMsqVnomlNtTkLtCRtEKPcDYfoZp0Nyxd7KkucZe6vLYvB5If5BIEDjWWNVnbZZdh5hO1Olzx4PdsrmOYKPi36LlPhAHh3y6Usq49zYRUsJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sCb0ltea; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+qCxcrF+YJkLnsHypvLQJijYuAmnYg1Hkk+XpMf9kDQ=; t=1740996071; x=1742205671; 
	b=sCb0lteavVEMy3zA6+wDLV1XLFUXblDtn1HkzfWDuZHX6f4G2hlazcIEGC9vpucNO+v0yXlwK8P
	TgCI1rhorDqH+DT/DukJv67/hADJnzCMJt5gzy5XwY+n8XxMbfHdN+96cQH927Zus4ePXe6uZebBR
	G19Px4KBeKe6S2c3K0pwqDgi4DeneNGe9ihGzleMbkdd5XRG3fYXCppDmbCBIYYGmXKAeELAJMIL8
	f0gnHyWCn6qyyKNitHJLOFWccTPG2VPiE6WlECaL7Huw3aGqu5kkrSGXH2ZXv6NbsqRDjcQnnyBGs
	ASA8NIoP/JC/tKywDy9bFsprJYp1nC3qqyTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tp2bi-0000000H5KZ-1w60;
	Mon, 03 Mar 2025 11:01:06 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: nl80211: disable multi-link reconfiguration
Date: Mon,  3 Mar 2025 11:00:59 +0100
Message-ID: <20250303110104.17744afe6975.Iab122c22137e5675ebd99f5c031e30c0e5c7af2e@changeid>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Both the APIs in cfg80211 and the implementation in mac80211
aren't really ready yet, we have a large number of fixes. In
addition, it's not possible right now to discover support for
this feature from userspace. Disable it for now, there's no
rush.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fdb2aac951d1..27d51aa5cdff 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16534,7 +16534,7 @@ static int nl80211_assoc_ml_reconf(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	err = cfg80211_assoc_ml_reconf(rdev, dev, links, rem_links);
+	err = -ENOPNOTSUPP;
 
 out:
 	for (link_id = 0; link_id < ARRAY_SIZE(links); link_id++)
-- 
2.48.1


