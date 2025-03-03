Return-Path: <linux-wireless+bounces-19693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF3A4BBA7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828391891FD3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 10:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1DC1E9907;
	Mon,  3 Mar 2025 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bbk09i0D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB21E570E
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996371; cv=none; b=cXjtIfsRQ0LJCuyS6PfQ6yZ6tYZv8NjZy5o0ZRUTmWxurEqrFJEqQVG4KQ8/FFk8Rch2WnzG0xIOwMYKvTGvVrWnh5+GKE4or8RtE3dz83VIdSocgr6He6IzhUl91Tnrt7xFxBFoakfiF1XkRHUvMRsRKLz3v713ShHz8yS6CO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996371; c=relaxed/simple;
	bh=cQlZbjoKSzqqTjwid/Ru0pMnApb0q6R+4NC73421qCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAFjsuTftarziFk7QBMb0cM/ObmvDWl3dtLyg+sLGjfFDpYacN675/u7Z4bVsmQcWQJRmoE1qZRButaSQAy5VbFQLN6H2H49/o7HG0yMDhic4dH8Ru9VM7w5V7UHScFcBMk7E3n5AoQCyFDlYciZHOLIHY4cL4PgP/oxJ0/dh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bbk09i0D; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=b07YiUJkSHqI+qKE8R7BYMf6Lt43OLzKt8l01yZPl24=; t=1740996370; x=1742205970; 
	b=bbk09i0DWs3fJFIc2i327a5HJwg1QA5bEnhp/AUdltrEavlIlvNO0i/EVugtIwvM1RTFaCNQBXh
	XHRd1544NraW6XMxArcah6r5VXRtGibAz/hgr5xIWb8SxBATmjI5qMA+0D1kOIzAr4OR+Q1QUuYnU
	0djGJhrOt+z0Wx6wkfoGApXI1Fs1hjMHXgCF88/HXNEVtaREqacOKIBTxZGa/SUo9S9TOUpz75jiF
	r4kh41PmzuvEG//L2sNhRDUHXNtS6a0Z+LJZcjrUMUoJFI6ybpK1p3isTxwEe1sjmBCA1CBj+gF1y
	Fy5PgS/hY3/lrRwjD1w7rln+rke1orz/zobA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tp2gZ-0000000H5Vx-3v8E;
	Mon, 03 Mar 2025 11:06:08 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless v2] wifi: nl80211: disable multi-link reconfiguration
Date: Mon,  3 Mar 2025 11:05:36 +0100
Message-ID: <20250303110538.fbeef42a5687.Iab122c22137e5675ebd99f5c031e30c0e5c7af2e@changeid>
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
index fdb2aac951d1..e87267fbb442 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16534,7 +16534,7 @@ static int nl80211_assoc_ml_reconf(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	err = cfg80211_assoc_ml_reconf(rdev, dev, links, rem_links);
+	err = -EOPNOTSUPP;
 
 out:
 	for (link_id = 0; link_id < ARRAY_SIZE(links); link_id++)
-- 
2.48.1


