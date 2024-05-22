Return-Path: <linux-wireless+bounces-7954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8C08CBF5C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 12:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCAC1C21603
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 10:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019B9405CC;
	Wed, 22 May 2024 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hr4SoziB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8BF823C3
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374500; cv=none; b=Qhx74Zq8BpHu2drTyyUrCQ4lvZHpEl+/JQiwpcIyic4A7+60ol/T6koCXXIdPmqf4AroTxfph8TpwOL81t2B8r6FkunLxohXNRGqOKgBbFPIjG40EKUReEHHL+kW9tUacDR+xbWQreExN0cNLI8Xi+sC3oJwXxNeZZpcD1p4MTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374500; c=relaxed/simple;
	bh=N0QfiNNYGw5mdqIm2JYiag9VEAFul5A1G3cWSFJB0pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQ4G2yNZijveJ2ZxH1ZHhmiA8Yd0MeKMM4cR8ccNCCWeTHJ3P2yzRMv4rF7LbjiKOhcvsunPxoP/EE4dyJddJ+7cASjCUDJC+pNtkA2nlghOgG1N18a0gbPvFZDMcFuUOc5Br6zr19i6i9uGZDO9KoDCJOGPVfrXvuwsKNp3up0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hr4SoziB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=tdwUimt9CgiIGk2iq6kBWe6uoDQY2BVrSf3Fj4DUZbU=; t=1716374498; x=1717584098; 
	b=hr4SoziB8ha+fLI6uQ2iQacwZc32T1lOFU/bjf6Dv6i9ra8/x1raT7v2yfAnN+pb0s2OTMMGsjo
	d38ATsiCUnIEneFUc+iScFZ4pl7ESfj15aVMBpySS4qVXuC579IyBdjrNigzXCBTiUZr85zA84uPW
	kE95ThnLzJ8lZOhlw+Tn3ey2PFDT7wxCj3dr/OijuAbN//btzDX6ylN2B/XPFbPylobmT+BlDS7FR
	VEh388VTt9ZmfhwwJWrbZC1fN45tSfz6nLSsC0PC3kDuYEIsdkQR6OwTPgjt+HnfmsSqKxWmAc79Q
	oBM+Ly0g12OL94bFAqVg73/XuVLTz0rjMv0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s9jPV-000000040Kz-1KAp;
	Wed, 22 May 2024 12:41:29 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH v2] wifi: cfg80211: fully move wiphy work to unbound workqueue
Date: Wed, 22 May 2024 12:41:25 +0200
Message-ID: <20240522124126.7ca959f2cbd3.I3e2a71ef445d167b84000ccf934ea245aef8d395@changeid>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Previously I had moved the wiphy work to the unbound
system workqueue, but missed that when it restarts and
during resume it was still using the normal system
workqueue. Fix that.

Fixes: 91d20ab9d9ca ("wifi: cfg80211: use system_unbound_wq for wiphy work")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: also move at resume time

---
 net/wireless/core.c  | 2 +-
 net/wireless/sysfs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 565511a3f461..62f26618f674 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -5,7 +5,7 @@
  *
  * Copyright 2005-2006	Jiri Benc <jbenc@suse.cz>
  * Copyright 2006	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2020-2021, 2023 Intel Corporation
+ * Copyright (C) 2020-2021, 2023-2024 Intel Corporation
  */
 
 #include <linux/device.h>
@@ -137,7 +137,7 @@ static int wiphy_resume(struct device *dev)
 	if (rdev->wiphy.registered && rdev->ops->resume)
 		ret = rdev_resume(rdev);
 	rdev->suspended = false;
-	schedule_work(&rdev->wiphy_work);
+	queue_work(system_unbound_wq, &rdev->wiphy_work);
 	wiphy_unlock(&rdev->wiphy);
 
 	if (ret)
-- 
2.45.1


