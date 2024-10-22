Return-Path: <linux-wireless+bounces-14328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8DB9AB0A6
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 16:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3B91F2404B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7301A08B8;
	Tue, 22 Oct 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LKiToaJm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0051A00F2;
	Tue, 22 Oct 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606668; cv=none; b=PyX9X+2cHlzejzTuwxXM0KgHadu7fVdfm+Ll1R5PcSseYlreo+JlbPogESvEBZFQX4Ow/5rYP0/TbGEapRCCRqxpK3cIkgItFWQPzVjIsU8JgTpKxay9tsw56giywbLHADxWqrf9efW2Z/h0sS2vkMCjqhOuf5NzgmmdG74d1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606668; c=relaxed/simple;
	bh=68WdYzIarQVjRHSchfunh+oOLTQrpXXpJWnb1pF3ttE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQ5Ws/k8MllkQQ75KCUPSzaaSt1jQhM1doejutafN3JpGYmrR8jTKt55p/jjc9EAOOv9R2fm54hvV+ex9yHFoum6+eVlkhNNymjAB2OmHIcnwzQqGBKrE72EIxe2Kpj3rozsLUTxixNCylq+sB2bmtpb1nb42y77lS7vdIPEp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LKiToaJm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=wAWaw7uJMG1uA564YAQqUUha8AMLR3EufJ78OEJdlh4=; t=1729606666; x=1730816266; 
	b=LKiToaJmdtr8gAVEHp4k94botLNG5RHMKnnxFL2S0A1ETQwbtYDfLLnGYpp0RxLFDYBuFPkVARN
	cSkAz0BJ2kZp9f6wc0pzrv+ZgTDKV3ExN4Lea3Q4JwPaIiDvSIHOV0mqc/56RX6oe160s88WIqiAA
	dX60ztnYiq52EEgydOy8qDcz8iaNbxWggP4zOxTCxmJnDZKwh2NlmZyoBjo2NmtkFsDti04w4XCuE
	x0dvVsv1zmNmDA3mJqJRaYcEsAhpOeq0lJ32nm7klXuQrOmrcgedL2kixEXf45wlTBiu3UMCG/x1p
	VFz5jLA8/8FLXA7UOrE6JxUiExpZRVlhmbIg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3Fhg-00000001lpE-0fRR;
	Tue, 22 Oct 2024 16:17:44 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+36218cddfd84b5cc263e@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: clear wdev->cqm_config pointer on free
Date: Tue, 22 Oct 2024 16:17:42 +0200
Message-ID: <20241022161742.7c34b2037726.I121b9cdb7eb180802eafc90b493522950d57ee18@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When we free wdev->cqm_config when unregistering, we also
need to clear out the pointer since the same wdev/netdev
may get re-registered in another network namespace, then
destroyed later, running this code again, which results in
a double-free.

Reported-by: syzbot+36218cddfd84b5cc263e@syzkaller.appspotmail.com
Fixes: 37c20b2effe9 ("wifi: cfg80211: fix cqm_config access race")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4c8d8f167409..d3c7b7978f00 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1280,6 +1280,7 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	/* deleted from the list, so can't be found from nl80211 any more */
 	cqm_config = rcu_access_pointer(wdev->cqm_config);
 	kfree_rcu(cqm_config, rcu_head);
+	RCU_INIT_POINTER(wdev->cqm_config, NULL);
 
 	/*
 	 * Ensure that all events have been processed and
-- 
2.47.0


