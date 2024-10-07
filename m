Return-Path: <linux-wireless+bounces-13643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25A0993795
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 21:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E57BB2193C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847211DA0FC;
	Mon,  7 Oct 2024 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="d0Hm6miL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5713698F
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330443; cv=none; b=DeNLgioJNNz6K1iN9E8+WKRxB2y36Otj64R20OzWPJM96qyUf5aG7VhiVwslo96d9GNYIY5BUyzQjo+kuC4CNfIezqvLZ3sIAhudhQIIkjBJH9PijsXmx3TTlrLLHpB01ziQ/MW3b16aOMBZuqSxXtCZX86X76jrYH2k/CuNfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330443; c=relaxed/simple;
	bh=b2VQOi3H/kz3Ridj+EEeLof1sqWridwQNuvRroN6lOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJY6w04mUd+CuRyci/GLpiJioabV/FYTlMV3aO+DdVDINKmff8iS/b4ef78eFhfphIYEdsvyg9JUClOPE0OPTZGrXeEb7OpMP/6HOp9e5X4HdzT9at51Jiitcofdvi6BuIFzcJ37SGsBydbPkFnKBim2ktsKRVGlQvyREq2EaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=d0Hm6miL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Snz8romZscymZOBAa6mqWVPm+OWXGtOCWtjoHDFIcuk=; t=1728330440; x=1729540040; 
	b=d0Hm6miLJu9+cmj1bU8uisi0qnz99Qz7r5xLJCaI7RX73+74xX1bdKNTNCiqUFRaO4BGr+pJ0VJ
	cFjTTf2pmBfRD4NreDfCrS3/aG07rfJjCykNmYK7iIF09ILm46CjrrG1RhntaKZie/e3bL8ZHh+BM
	DcwHZLNxvxAhMSKbgnNjySQMx3U3wjT15E8wjQFGsVO3e07tAAhZHkMoqTjxMheaifMazQXHAlg+M
	CZuzQFpkps9kwhM5eICss3QFDNmkwHBhZdUb2Kj+OZaQ5QCbWzKDoNaodr6vix+q65RuKIlbcf8BO
	43qz3MCcVNMYGkv2RzgDra61OF2nvPz/JOuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxthN-00000003VzY-35LC;
	Mon, 07 Oct 2024 21:47:17 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: cfg80211: unexport wireless_nlevent_flush()
Date: Mon,  7 Oct 2024 21:47:16 +0200
Message-ID: <20241007214715.3dd736dc3ac0.I1388536e99c37f28a007dd753c473ad21513d9a9@changeid>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This no longer needs to be exported, so don't export it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/iw_handler.h   | 6 ------
 net/wireless/wext-compat.h | 6 ++++++
 net/wireless/wext-core.c   | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
index fc44fcca1d5c..804587b7592b 100644
--- a/include/net/iw_handler.h
+++ b/include/net/iw_handler.h
@@ -413,12 +413,6 @@ struct iw_spy_data {
 /* Send a single event to user space */
 void wireless_send_event(struct net_device *dev, unsigned int cmd,
 			 union iwreq_data *wrqu, const char *extra);
-#ifdef CONFIG_WEXT_CORE
-/* flush all previous wext events - if work is done from netdev notifiers */
-void wireless_nlevent_flush(void);
-#else
-static inline void wireless_nlevent_flush(void) {}
-#endif
 
 /* We may need a function to send a stream of events to user space.
  * More on that later... */
diff --git a/net/wireless/wext-compat.h b/net/wireless/wext-compat.h
index 8251ca5df8ae..f680dd134582 100644
--- a/net/wireless/wext-compat.h
+++ b/net/wireless/wext-compat.h
@@ -5,6 +5,12 @@
 #include <net/iw_handler.h>
 #include <linux/wireless.h>
 
+#ifdef CONFIG_WEXT_CORE
+void wireless_nlevent_flush(void);
+#else
+static inline void wireless_nlevent_flush(void) {}
+#endif
+
 int cfg80211_ibss_wext_siwfreq(struct net_device *dev,
 			       struct iw_request_info *info,
 			       struct iw_freq *wextfreq, char *extra);
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 838ad6541a17..f023f9bddf45 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -20,6 +20,7 @@
 #include <net/netlink.h>
 #include <net/wext.h>
 #include <net/net_namespace.h>
+#include "wext-compat.h"
 
 typedef int (*wext_ioctl_func)(struct net_device *, struct iwreq *,
 			       unsigned int, struct iw_request_info *,
@@ -356,7 +357,6 @@ void wireless_nlevent_flush(void)
 	}
 	up_read(&net_rwsem);
 }
-EXPORT_SYMBOL_GPL(wireless_nlevent_flush);
 
 static int wext_netdev_notifier_call(struct notifier_block *nb,
 				     unsigned long state, void *ptr)
-- 
2.46.2


