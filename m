Return-Path: <linux-wireless+bounces-7994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A49B8CCFDB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A71C20F19
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2BA13D2A8;
	Thu, 23 May 2024 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VtmCJ/mv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59313CA99
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458639; cv=none; b=ioFXMpEBydcBpz3TxleZnunfSWzmEjUFF7f4ilFxgPvS0AT7NifjbSSBAIZeBFJTdSy48566k1dmvkGXQNnRlepTRop4LroDbUexW2FaTn4GABEMZDSLWrv3mUbZ+P2fieJzys9DXhYuKKVRmSl2kUXKOh1kk6lw6/ACDxtSdB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458639; c=relaxed/simple;
	bh=P7962Bbz7IDd0BSPZEWS+AgDkYw+Rd/Hyk79fKdOK2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qj3NuuiwS4FQoyn2N66BUVATr00NBt6+itbjFwrZwAAOe0kKmimcHtCyZhmvQ7TixXnh3xflUDd4A9+awePEu1obYruC6iNyLyP8cn0N8aF8V1tHaD4RK7Gkdxd+Df0XnseVB5+3C7mN0XVzZ8go2FuXnZnMFqWiaxuV00e2XaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VtmCJ/mv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=NdNhGoVC59EX2cDSkBO16q5+J1dp5xpqAxyeGe+9zz4=; t=1716458637; x=1717668237; 
	b=VtmCJ/mvrRuV3V4vjpiihwkVmI2fK2U8IiV8h1+GJ1n+b+USlT4FSnXNQqf/1lfX3ux/tmdh3J4
	tw4NBVfBwDSm0jIwteCEwi5sGyET4fQsx8OrI5mSQRGgK5KLri6eAchTpcgaLEa8GnLLmnLGXcF7Z
	1wgrbxH0otTMPaqAx7jjDZJdAIqXKOwW+L7QAomSI2BU7GQxP8k/dRDKmgDc0SYC7uA7dnM4uFbKR
	JgzXxqxmMPu46EsCIVAaY5xYTZ3vOBK4atsKHST+Oc9JoCdrUaom8SrDMZykj4GJF0yD4t+kJ5Fvw
	8zPazlBRXqAA8IwVOoTCGL1Uq4w3B8MOYuOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5Ig-00000005wEj-0DMk;
	Thu, 23 May 2024 12:03:54 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: handle HW restart during ROC
Date: Thu, 23 May 2024 12:03:52 +0200
Message-ID: <20240523120352.f1924b5411ea.Ifc02a45a5ce23868dc7e428bad8d0e6996dd10f4@changeid>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If we have a HW restart in the middle of a ROC period,
then there are two cases:
 - if it's a software ROC, we really don't need to do
   anything, since the ROC work will still be queued
   and will run later, albeit with the interruption
   due to the restart;
 - if it's a hardware ROC, then it may have begun or
   not, if it did begin already we can only remove it
   and tell userspace about that.

In both cases, this fixes the warning that would appear
in ieee80211_start_next_roc() in this case.

In the case of some drivers such as iwlwifi, the part of
restarting is never going to happen since the driver will
cancel the ROC, but flushing the work to ensure nothing
is pending here will also result in no longer being able
to trigger the warning in this case.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/offchannel.c  | 35 ++++++++++++++++++++++++++++++++++-
 net/mac80211/util.c        |  3 +--
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 76965d64a0fa..3fd7b1adbfab 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1978,6 +1978,7 @@ void ieee80211_offchannel_stop_vifs(struct ieee80211_local *local);
 void ieee80211_offchannel_return(struct ieee80211_local *local);
 void ieee80211_roc_setup(struct ieee80211_local *local);
 void ieee80211_start_next_roc(struct ieee80211_local *local);
+void ieee80211_reconfig_roc(struct ieee80211_local *local);
 void ieee80211_roc_purge(struct ieee80211_local *local,
 			 struct ieee80211_sub_if_data *sdata);
 int ieee80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 65e1e9e971fd..28d03196ef75 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -8,7 +8,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2019, 2022-2023 Intel Corporation
+ * Copyright (C) 2019, 2022-2024 Intel Corporation
  */
 #include <linux/export.h>
 #include <net/mac80211.h>
@@ -413,6 +413,39 @@ void ieee80211_start_next_roc(struct ieee80211_local *local)
 	}
 }
 
+void ieee80211_reconfig_roc(struct ieee80211_local *local)
+{
+	struct ieee80211_roc_work *roc, *tmp;
+
+	/*
+	 * In the software implementation can just continue with the
+	 * interruption due to reconfig, roc_work is still queued if
+	 * needed.
+	 */
+	if (!local->ops->remain_on_channel)
+		return;
+
+	/* flush work so nothing from the driver is still pending */
+	wiphy_work_flush(local->hw.wiphy, &local->hw_roc_start);
+	wiphy_work_flush(local->hw.wiphy, &local->hw_roc_done);
+
+	list_for_each_entry_safe(roc, tmp, &local->roc_list, list) {
+		if (!roc->started)
+			break;
+
+		if (!roc->hw_begun) {
+			/* it didn't start in HW yet, so we can restart it */
+			roc->started = false;
+			continue;
+		}
+
+		/* otherwise destroy it and tell userspace */
+		ieee80211_roc_notify_destroy(roc);
+	}
+
+	ieee80211_start_next_roc(local);
+}
+
 static void __ieee80211_roc_work(struct ieee80211_local *local)
 {
 	struct ieee80211_roc_work *roc;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 43625ca87d5e..927f752a0209 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2175,8 +2175,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		local->in_reconfig = false;
 		barrier();
 
-		/* Restart deferred ROCs */
-		ieee80211_start_next_roc(local);
+		ieee80211_reconfig_roc(local);
 
 		/* Requeue all works */
 		list_for_each_entry(sdata, &local->interfaces, list)
-- 
2.45.1


