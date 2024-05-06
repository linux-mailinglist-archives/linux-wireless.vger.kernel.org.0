Return-Path: <linux-wireless+bounces-7241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37D28BD54A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9253E1F22A73
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970813C69F;
	Mon,  6 May 2024 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OK/l5hm4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2287158860
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023139; cv=none; b=Oj1tmOF3BbXCnJvC5LXmEkPEqjvOSe3CX44+otWlemwP3+HErPbQ0H9lhD74Dn0jUr2NMAqnfnSojcRoeF4lFmhIXBkD5bbap/kGeIFNzQL5e0E4U4wKVxgYxpJ+7w5CzzgLxtE7T6zqxJqAJLUjdrGV76z1qeZor/YM/MOT7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023139; c=relaxed/simple;
	bh=B56wj43p9B/hgUTLOfK4AINNs7J9AdBiIzFzBc+f/WA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYnwMz0kppBfv52Rb8Tlz39syBCy/T89/VcLo6LD35sPax/zB15AUwuLURLaniaMdjrzcRuJ3B410A71xNDLQL0sWy0vM0ks+xvEtUOg11wY/d0t/MpB1XvWIWl3wikgEZzCuwV3HnMFzbKmjal1XW2x7O8pcyGxLpPRMQQt8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OK/l5hm4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=WKmgukKSi4F3BHO90F+AzCSSflyYMVEbVsdoB8llS1M=; t=1715023138; x=1716232738; 
	b=OK/l5hm48lueJ7DD6G+KjPjSJPT0WDQ8YsE6iBZdiwo5s+k3yombvgxnA3hIn9lBkOZap73MgdD
	QTrG06j2PtuWXjvhzr6Pw2ywsudCLmdyieE12eo04NlxJ5+Hwh6CSrLzYp7l5uH31F1NBk0mC0qTH
	kd76gZFysuMkDXV3zKDFGrnLwf+lIk4xsJuL80U/2JFR2/TN2jxIkUtHe0YeNKu5i0su+qdPguFWs
	I5aeswbtq8ROlgt3psz7Na9ydOe1Yzyrd2Q4Y3RRZXAlA3wbwrddzdy/S2Yi7gzlCg4VtTp662hix
	W5aIr1iB7KbOQ9/nOgLdyTKuyw5eNunV87dA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43rT-00000008AMU-0mC2;
	Mon, 06 May 2024 21:18:55 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: fix TTLM teardown work
Date: Mon,  6 May 2024 21:18:52 +0200
Message-ID: <20240506211853.e6471800c76d.I8b7c2d6984c89a11cd33d1a610e9645fa965f6e1@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The worker calculates the wrong sdata pointer, so if it ever
runs, it'll crash. Fix that.

Fixes: a17a58ad2ff2 ("wifi: mac80211: add support for tearing down negotiated TTLM")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 04a125a9ffd1..4493e63e3722 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6841,7 +6841,7 @@ static void ieee80211_teardown_ttlm_work(struct wiphy *wiphy,
 	u16 new_dormant_links;
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
-			     u.mgd.neg_ttlm_timeout_work.work);
+			     u.mgd.teardown_ttlm_work);
 
 	if (!sdata->vif.neg_ttlm.valid)
 		return;
-- 
2.44.0


