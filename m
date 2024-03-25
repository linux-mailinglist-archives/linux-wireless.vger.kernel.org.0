Return-Path: <linux-wireless+bounces-5197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AA388A897
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D601F39C6A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83EA1EF1D;
	Mon, 25 Mar 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RHqU7EcY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA30C144D31
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375517; cv=none; b=EKPt9ioHtGiggkDofFHVNJJLNjjbRHQdTyO11Opat5+IqT4fIF0s0iZam0zCS8PN3F5uLOKDy2+6NBSgxiiQROyJHvAf/6ZRSij0o4g6885U+jaHEnwwt69pvv/U93nG8yu/kxvlIgCRaunc5TdA9LbV37tcEHvhP27j+8/ZVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375517; c=relaxed/simple;
	bh=T9mPTJFdFAlJ/5JVcluvxN9ZlyxsQJe7jTARp57+rAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWZ+kPxg2zf5yEXQhnrvKdL/dx3QUfslVIn0caWhVEH1dCjdo1/V0smo74J/wpivLAGNZSRUMllDh6OXkHv32C3ut3YI3HsBvABuWqntoUfPv2unX3pLiXBMvcDxNj4fpVZsMMujmxmGCk3AvPBgxz3pTvztxl2zP/8rPadAY44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RHqU7EcY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=7licXzL4httiCp5hSTNrvtPUOGc2UkcCW0a7xMc5f/8=; t=1711375515; x=1712585115; 
	b=RHqU7EcYCQwo+4Ao/+phVG6459GQ77a5qB/1ceO2PsST0cB5k+qcvMzJ60TQ3e4xpadr8dUk9+T
	MyaQeHa9Hpa6Lsvhm/0GT/MwGrVSMqguAdArs9ntss0M2KMgqb0I09JM4EUHsZ1YvwqFCzCxfH+sL
	1Cvw+eu0VQqR+VuTK8wUaq9gxK/9DV6LwUr6ofEdASiNGDk4b9vhq27wt90W+RxhJ5T9oOZ3c0TUS
	ZmZFGWHQu6i4cfM/CYIfrGBB3Mbo7GCcAvI6AZfUlbxUKoKN3WWJ9nCq4VaEk7oj9r3L9QaygFZr2
	i5IOY6j5tDxCeTV5uXTvPUWLIaLaU4jCPyHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rokwp-0000000DrbV-0nzB;
	Mon, 25 Mar 2024 15:05:11 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: use kvcalloc() for codel vars
Date: Mon, 25 Mar 2024 15:05:03 +0100
Message-ID: <20240325150509.9195643699e4.I1b94b17abc809491080d6312f31ce6b5decdd446@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is a big array, but it's only used by software and
need not be contiguous in memory. Use kvcalloc() since
it's so big (order 5 allocation).

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6bf223e6cd1a..ac5ae7c05e36 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1604,8 +1604,8 @@ int ieee80211_txq_setup_flows(struct ieee80211_local *local)
 	local->cparams.target = MS2TIME(20);
 	local->cparams.ecn = true;
 
-	local->cvars = kcalloc(fq->flows_cnt, sizeof(local->cvars[0]),
-			       GFP_KERNEL);
+	local->cvars = kvcalloc(fq->flows_cnt, sizeof(local->cvars[0]),
+				GFP_KERNEL);
 	if (!local->cvars) {
 		spin_lock_bh(&fq->lock);
 		fq_reset(fq, fq_skb_free_func);
@@ -1625,7 +1625,7 @@ void ieee80211_txq_teardown_flows(struct ieee80211_local *local)
 {
 	struct fq *fq = &local->fq;
 
-	kfree(local->cvars);
+	kvfree(local->cvars);
 	local->cvars = NULL;
 
 	spin_lock_bh(&fq->lock);
-- 
2.44.0


