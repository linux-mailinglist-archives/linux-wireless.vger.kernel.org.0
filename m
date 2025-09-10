Return-Path: <linux-wireless+bounces-27214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978E9B517AE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 15:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5301C8549D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 13:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC3C1F2BA4;
	Wed, 10 Sep 2025 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="e2lpHrw8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008482877FE
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509888; cv=none; b=M4spy5R1AZ9et66jmXnN9x7gVCEhM99A4XmxCEz6genNwMHorblTLc26E7A2c8E1mulAcx4OI+DP5cAFUa81C4JN4FYN3iNlP7bsx+lojPGhxo865y+67cjVDmeQpFLW9H5NfhhsNM4OzRsOsKf6fsVKhhSR8Sel6bqsZ2nJdMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509888; c=relaxed/simple;
	bh=v9PSXHWVO6JNQXp/vXchh029dy3zIog6zrw6Jmi5zNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyXpwG5q6Z77+RVZ0aQFgt+Vwai5OlUZbHgMzsuslU8URxCoT+q72G7kTyeRdn1mvZT7uNywVu3FhcN6iBsIB24A4Kk5PNTp08rndYR2l3YXa5cKSEDSD0e1g/SdpSgSbmRqhpLCs0RC3x0KcjPPB+K4c9R8/FtuIH4ip4ZMq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=e2lpHrw8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=UspXaPy4TejC9qphVDxefE/uHMbadkItdKBe5hkGgMI=; t=1757509887; x=1758719487; 
	b=e2lpHrw8Qj+5Jc0QMQ06uouq3406fBcglRw26H2+ID+nX1IHgbDIeLVipdOH+qrC+UZ8u8m5eij
	vkxAj5cltusDrOzwwXc4AwD92NAjhN3qmXPvJQjEuOer7GDBgc4xF5hDh8TjBR73wPHbqsg6iUrym
	X2whOLuLc6DnZ87kth45mx4VH0PhfUyCS9qRekdPJel3IFnQTYYwhVXLWqfp4GSPXVouwzsEXvQUs
	08erV8rI/9QxXR0S12A+MLCeUzb2cJ8KyMNr/94+Dawf2RXmkga1HP/jTlgwWUmPHH/EZKslWlJPu
	SZ/DeXlGCbP+HxopLJpqSZBegAun658e3Xsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwKbc-0000000CtiZ-0OYr;
	Wed, 10 Sep 2025 15:11:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless v2] wifi: nl80211: completely disable per-link stats for now
Date: Wed, 10 Sep 2025 15:11:21 +0200
Message-ID: <20250910131121.33909-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

After commit 8cc71fc3b82b ("wifi: cfg80211: Fix "no buffer
space available" error in nl80211_get_station() for MLO"),
the per-link data is only included in station dumps, where
the size limit is somewhat less of an issue. However, it's
still an issue, depending on how many links a station has
and how much per-link data there is. Thus, for now, disable
per-link statistics entirely.

A complete fix will need to take this into account, make it
opt-in by userspace, and change the dump format to be able
to split a single station's data across multiple netlink
dump messages, which all together is too much development
for a fix.

Fixes: 82d7f841d9bd ("wifi: cfg80211: extend to embed link level statistics in NL message")
Link: https://patch.msgid.link/20250910103824.e63765f59b2d.Ibb2f3663109922148a8f0067f56ef919039c5409@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f2f7424e930c..852573423e52 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7575,7 +7575,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 				NETLINK_CB(cb->skb).portid,
 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
 				rdev, wdev->netdev, mac_addr,
-				&sinfo, true) < 0)
+				&sinfo, false) < 0)
 			goto out;
 
 		sta_idx++;
-- 
2.51.0


