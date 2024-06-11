Return-Path: <linux-wireless+bounces-8804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCF290420E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E72528D9AE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62E61CFA9;
	Tue, 11 Jun 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZE7+uMV+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097C1EB21
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125105; cv=none; b=ewRMKmf2YElk3OhM98s/jSdjzVtqlVJ4fh354xbrg0r5zzbuwIejwUrxcIWpROC6QmpbkYVMQusk+GBKj47oqrZmMId7QvcvDdzbk6Y2bY7FgrGZcMO7QjoubXziUK4U8ERIqJ4iWo3FMx0lgrreOA8+Oq428B6rx0xnPummQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125105; c=relaxed/simple;
	bh=APVzMLSve7KNEZWoXD7M2LkktVyFDne234/i7cMd6Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QpbUawSICmrYSqUwmFvISITzSUXM83Tl2yymsVU6tF3apmakloUGdolEavcCw1RCSOEDTR82PriIA2NAgsghWXq7v5r/1/5CnoUvIVZfstcysTyNgSwbIIV/rwheTKOf9Q5j7Y41MIHWZ2G/qDIlZ70pSh+EhwqwdrvFVFQ7j9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZE7+uMV+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=3v2wNHR5M70phZMaxepwnBAtXq5Ap8HzqNbvoIlfFO4=; t=1718125103; x=1719334703; 
	b=ZE7+uMV+3OTjqRKxRuEQh5R16jXpOk70GWBd7/MS3SSgq2L9QsjuCn69r0ceCxRy6k3LOcHSg+X
	hyxR4zbK0okCQNhYDBM/1CTkEK4up71QvTT0X7GfflDj2dlprVDXEkwoIWfCHXdF+roF3oZmxi6kh
	87wQu/Iga7HIt/mDh0TjdF99GvyTrgLp+CGoljn4x9lZYQY1isdsk4jCjaIGr+z5by7wwX0GK8GrB
	5Q6QEtc3ZIZDjk1JYa7GrZKywfxyoITyFj/GPbxYKUmUhJQVjFJ+YxGyVxI0o0EwOGdh9fo53C7cw
	5hXOikc6fPl7LIsZm+Q4FUprXN5m7Kcn/w1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sH4pA-00000008tF8-0dxx;
	Tue, 11 Jun 2024 18:58:20 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+cd6135193ba6bb9ad158@syzkaller.appspotmail.com
Subject: [PATCH wireless] wifi: cfg80211: wext: set ssids=NULL for passive scans
Date: Tue, 11 Jun 2024 18:58:16 +0200
Message-ID: <20240611185816.1568ff55ede1.I516eed4993495eee54290364e35535b93857fd5d@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In nl80211, we always set the ssids of a scan request to
NULL when n_ssids==0 (passive scan). Drivers have relied
on this behaviour in the past, so we fixed it in 6 GHz
scan requests as well, and added a warning so we'd have
assurance the API would always be called that way.

syzbot found that wext doesn't ensure that, so we reach
the check and trigger the warning. Fix the wext code to
set the ssids pointer to NULL when there are none.

Reported-by: syzbot+cd6135193ba6bb9ad158@syzkaller.appspotmail.com
Fixes: f7a8b10bfd61 ("wifi: cfg80211: fix 6 GHz scan request building")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 2f2a3163968a..d7485e26f4fc 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3493,8 +3493,10 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 			memcpy(creq->ssids[0].ssid, wreq->essid, wreq->essid_len);
 			creq->ssids[0].ssid_len = wreq->essid_len;
 		}
-		if (wreq->scan_type == IW_SCAN_TYPE_PASSIVE)
+		if (wreq->scan_type == IW_SCAN_TYPE_PASSIVE) {
+			creq->ssids = NULL;
 			creq->n_ssids = 0;
+		}
 	}
 
 	for (i = 0; i < NUM_NL80211_BANDS; i++)
-- 
2.45.2


