Return-Path: <linux-wireless+bounces-3597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052378552E8
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 20:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889DD28F125
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 19:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A99139575;
	Wed, 14 Feb 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RTyjnGsp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8A6171A2;
	Wed, 14 Feb 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937725; cv=none; b=CPKLMawlkLewihLPuGZ5Tfh34Ee72r7ZnD3K21t4s5R4mhrK0b1BURC0YfNZHN7/+Da42cv9ZzF4LA9qXvMph7t2qRoaV+o+9wbQWkKCPpMZl91ekkcJFPqcrJpw1k3DSof+4DeKkXdnzhTu/UCIzqmk4KhDfq42MCVgnVMBY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937725; c=relaxed/simple;
	bh=XzSBrIIJ0UnxJ68PFDN9u8bIgdTrZHxJnIeFgw5PNiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjU0YqkbS6isFiIKus0R0XpN8K04YfVxdgiomMdXKLJdWt3QXkmewcsEjy4n2vA4lUQAxBUcieUzBzwI4fakeH4yPY6Ff7bKX44yMc58mWIjfTqnzS+OOCv6ndu0XPugdahzXjpF3ewsJiP01yzV3XXqxr9L87sbGTzb0pOflRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RTyjnGsp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=yCUVtE3NDfkLpnR/8JBWcXs7HbwnXQDMx914Ohyx+WA=; t=1707937722; x=1709147322; 
	b=RTyjnGsp7vr2o2QsJdVU6QFWbVQiMjXkKove2lK4ebWQhCenzjzCvsEE0NB8KqmE+d8rxoUPh7e
	ZlY//G6H6ggrLBiAsaSCpqb3Znbzco7J4hC7naYOQIthDkX4iPeGsfkd3fkdnm7SP3rRt2WeOTs1R
	J0jLNBq+pSEsrQjOfiSJWGtBcyrdBMphTrvkItzojFt2SeILwmde5VV8YzfDcWjX+WCQMjXUOeT5+
	rliYHqNulUKE4Y4kQZMancr86jPacSx0dI/n67/lTOAS5funsfgGpSrv7barkGjomWF3yqJp7kimC
	cBxpQrWa2UWnqF2y3M2KtNiIwjChZbsrVH/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1raKcZ-00000009KQS-3aCG;
	Wed, 14 Feb 2024 20:08:40 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org,
	syzbot+dd4779978217b1973180@syzkaller.appspotmail.com
Subject: [PATCH] wifi: nl80211: reject iftype change with mesh ID change
Date: Wed, 14 Feb 2024 20:08:35 +0100
Message-ID: <20240214200837.64262a35ce9f.I725cb866e9580e48371888c91840e0a955669437@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It's currently possible to change the mesh ID when the
interface isn't yet in mesh mode, at the same time as
changing it into mesh mode. This leads to an overwrite
of data in the wdev->u union for the interface type it
currently has, causing cfg80211_change_iface() to do
wrong things when switching.

We could probably allow setting an interface to mesh
while setting the mesh ID at the same time by doing a
different order of operations here, but realistically
there's no userspace that's going to do this, so just
disallow changes in iftype when setting mesh ID.

Cc: stable@vger.kernel.org
Fixes: 29cbe68c516a ("cfg80211/mac80211: add mesh join/leave commands")
Reported-by: syzbot+dd4779978217b1973180@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b09700400d09..bd54a928bab4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4197,6 +4197,8 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 
 		if (ntype != NL80211_IFTYPE_MESH_POINT)
 			return -EINVAL;
+		if (otype != NL80211_IFTYPE_MESH_POINT)
+			return -EINVAL;
 		if (netif_running(dev))
 			return -EBUSY;
 
-- 
2.43.0


