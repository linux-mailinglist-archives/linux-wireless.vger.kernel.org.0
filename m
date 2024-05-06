Return-Path: <linux-wireless+bounces-7231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809628BD509
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 20:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBA8B242C2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F72158D9D;
	Mon,  6 May 2024 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WjQkzsIR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCFE158DB0
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021947; cv=none; b=iFH/9FnevaiDkdqPBTiogKuBGH4JoH+d4zwPT3ZJgbMnNd/Y8j4KGlmKKSAWJYDdcaYE9kCb7Fr3KlhDloS3Qdrx7j1Ut2fiUv/xNKMPZhAADJ/7k4inCKL7LxREofQE1LsRr5moexXHqEn+bd9YwUoTGhMVnmJeS4Z+YS2Z3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021947; c=relaxed/simple;
	bh=bQ9N0lpXsmM7ISmrJPkxG9vcgDdQpjjMHeFj4ojxzZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gyw8bCwn3IwbnWciaZbdSh05M+HaVLIAVOZb+jPGQysvmWHz4rHQYwXvkmj0RdL/W6kJD2dpyhTaRLxPyrfzMEvZJHHOnqxgIBYE4NTa6Sp2R4fmfKn1sL3AY0uoy9OtHaHoZJeyM+9xCGcfxKs5CWQYm6tBie8Mo2Bk8CXBULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WjQkzsIR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=va3L4TJj1iXYkkOu5TlFmzEV1vC+OMi5V1dzN170Z+c=; t=1715021944; x=1716231544; 
	b=WjQkzsIRouhuyEC8K9LgrqSL9CzGBF21JERPXJKp4pylTNuqzl/vZNz8PFCLWS7r0BMqf2VAAhj
	gD57f3O7eesiy0X2DT2cbBIhpyuJDUN9dAym71u7N2B95v9XJX+kw1vxaC5sGIfd8/hS6DBY0FgZ+
	K7Wxh9z2orxWytf3gRh4lCRdI98wfWcA/zjKMqKyISn2DKv1Kf0pAUN3cPYbQqIYXauavWMgclLXM
	IEXUmmvO+WIrHPRfVPBcS6i5jzzpBEVs9t6TY8SinsyQXR8UsT9jodjDMYZ0rJRwb1hkMdjxYbbdD
	bEzGCBYLbjQimPT9cv/wPk6kchdeMGr5vrig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43YC-0000000894b-04tR;
	Mon, 06 May 2024 20:59:00 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: cfg80211: fully move wiphy work to unbound workqueue
Date: Mon,  6 May 2024 20:58:58 +0200
Message-ID: <20240506205858.821feba1c419.I3e2a71ef445d167b84000ccf934ea245aef8d395@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Previously I had moved the wiphy work to the unbound
system workqueue, but missed that when it restarts,
it was still using the normal system workqueue. Fix
that.

Fixes: 91d20ab9d9ca ("wifi: cfg80211: use system_unbound_wq for wiphy work")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3fb1b637352a..4b1f45e3070e 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -431,7 +431,7 @@ static void cfg80211_wiphy_work(struct work_struct *work)
 	if (wk) {
 		list_del_init(&wk->entry);
 		if (!list_empty(&rdev->wiphy_work_list))
-			schedule_work(work);
+			queue_work(system_unbound_wq, work);
 		spin_unlock_irq(&rdev->wiphy_work_lock);
 
 		wk->func(&rdev->wiphy, wk);
-- 
2.44.0


