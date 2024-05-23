Return-Path: <linux-wireless+bounces-7996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 168748CD002
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3AB1F23601
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9954813DBA0;
	Thu, 23 May 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pLm+TB8b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0042F13D619
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458992; cv=none; b=WPXhwlZi6R1GmCr6PTmtIGuG7Zt/pd/vvIGxLAWCyf7PstkZWlW+r4l+U2AMBSMP5BjlabhVicsb5DTJLcGIZukiLSCxdrKntEmeJExaO7tJQBEBFJeg1V/j4iSzwDVAuRsE7LVGuWsAx4SXtAcHlR5kCmkP34LX3iM00pIogA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458992; c=relaxed/simple;
	bh=3yGalTvJ0x39Eb5Pi/x5jkW4UiEtOV/QYJVOWcVcSOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssWeKPXD04gqgHWLiZOxJz9KDdv1JW5sV62l7zI63PbrGGvMgOHqTeKigsQwTsiEIbN+9X9tNy1p12vuz8GZ8tZf49hVuo2EKEmVJYjeVxv7vrfrGDmijTIypH7Xy22hPCOVcZ95MgpGH35GzJUKPhxXKjGuIcgI7N9HbIBc71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pLm+TB8b; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=X5EodKGvHS/S2pgpLvPTMQ0EdVLRbrsNWK63Rrh3v/w=; t=1716458991; x=1717668591; 
	b=pLm+TB8blysq51SCPJrkjzaz8ZJl5yxL5Q09KAy6fBlID+daJRfR/ztH+vN2mcses58OI16GlYk
	6WE5UfTejc56nvZTVfh0scVKf4tW5ruTyQSicEzm0jE6RK1192TjT4kVkfz2gF7cBZ2QyM6zCFKhs
	NNxQV0vNXCDJruMizt1hwjpOyWHYmhvN3Igljry1eXi3VH7mtYFIR2phRZCURNABnKIagdw9QRoMx
	UbfzpCSrW5K5OcShe8tbXqS44HsTpJ+crbWYYlZ2Zsj2G0KZiuRzyYn20Fr8FTUuSYr7r0/sNYsZk
	BglHb/RWS/5L4tsco3rcH1K+eTVfvjbiPKSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5OO-00000005wvn-1U9k;
	Thu, 23 May 2024 12:09:48 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 1/8] wifi: nl80211: expose can-monitor channel property
Date: Thu, 23 May 2024 12:09:42 +0200
Message-ID: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It may be possible to monitor on disabled channels per the
can-monitor flag, but evidently I forgot to expose that out
to userspace. Fix that.

Fixes: a110a3b79177 ("wifi: cfg80211: optionally support monitor on disabled channels")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6ba988a6f5a2..b10799710fe0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1204,6 +1204,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_6GHZ_AFC_CLIENT))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_CAN_MONITOR) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_CAN_MONITOR))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
-- 
2.45.1


