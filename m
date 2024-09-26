Return-Path: <linux-wireless+bounces-13208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B3986A43
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 02:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225701C204F8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B8C2B9B3;
	Thu, 26 Sep 2024 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZhFtglm3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32C22EE8;
	Thu, 26 Sep 2024 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727310671; cv=none; b=c7E93Y7e/A6kqQk6qnOajdB6IQG4Jyuydsl9RkTEkvzMo8dpRU5Du0QMt7lNQTY6IxFXtvsJk06HtqGH0h3gO1OPrmESXZjUEP6zYc/JBWXweNa5SqosrZwXDe6JL9PqI3F3TRZShd55MUvvwvMRlmTkYb3zlap6/36wazdph4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727310671; c=relaxed/simple;
	bh=Dm7hJ/xRMsVkfJa5R/uvZPyhRcQ74cKBeu84PCeYNIQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YWSLjQAC/qPyzkM/6FWgaJzoyXlfHaCFiV5rIycj+li2uN0N1JoV7+8153qoAHjrN6XirKIJifaAPGbEj1n0zip0J0FfF53Q86uMNVewyEeeflkrpqQNQ+3ls2mGOPbeIRe7ItxbwGMd8c/tInMRMsEvIpIcuNUFFYCL1ALB1gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZhFtglm3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48Q0UuyA61152563, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727310656; bh=Dm7hJ/xRMsVkfJa5R/uvZPyhRcQ74cKBeu84PCeYNIQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ZhFtglm31Pw1SNibJk4kWjBAdpHh1sZyL6Rjra5sHxNQ5JG+8qhFgRhA/I6WaQCrn
	 Qwpi7zTSx81NlPLjAZNUBckDus8/DVUGLvddo5CCuRaAL4WW/fwu6YLThGmXdUVa9j
	 eJ3HE5d9veHoJnM0ZS6O3raNNFFD2MzWWN3E/8yBoiRmfmYejYVusxf1ahgZ9P4Qc0
	 CiHxJpcprdtr+hN6+YksqX/Hpf2vxZ9vKJ3uSUnWazPnNTyvTO+YesQEdfdYaaI4Wc
	 5y+TKhlBMuaMtSRpBEwS206JLQmFdCIXtIk8T7GdM0rm/OPEA02wFS7/GPUlTeX4VU
	 VCrG/PCCvw+AA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48Q0UuyA61152563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 08:30:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 08:30:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 26 Sep
 2024 08:30:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <stable@vger.kernel.org>
CC: <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>
Subject: [PATCH stable 6.6] Revert "wifi: cfg80211: check wiphy mutex is held for wdev mutex"
Date: Thu, 26 Sep 2024 08:30:17 +0800
Message-ID: <20240926003017.5427-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

This reverts commit 268f84a827534c4e4c2540a4e29daa73359fc0a5.

The reverted commit is based on implementation of wiphy locking that isn't
planned to redo on a stable kernel, so revert it to avoid warning:

 WARNING: CPU: 0 PID: 9 at net/wireless/core.h:231 disconnect_work+0xb8/0x144 [cfg80211]
 CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.6.51-00141-ga1649b6f8ed6 #7
 Hardware name: Freescale i.MX6 SoloX (Device Tree)
 Workqueue: events disconnect_work [cfg80211]
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from __warn+0x70/0x1c0
  __warn from warn_slowpath_fmt+0x16c/0x294
  warn_slowpath_fmt from disconnect_work+0xb8/0x144 [cfg80211]
  disconnect_work [cfg80211] from process_one_work+0x204/0x620
  process_one_work from worker_thread+0x1b0/0x474
  worker_thread from kthread+0x10c/0x12c
  kthread from ret_from_fork+0x14/0x24

Reported-by: petter@technux.se
Closes: https://lore.kernel.org/linux-wireless/9e98937d781c990615ef27ee0c858ff9@technux.se/T/#t
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 net/wireless/core.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index c955be6c6daa..f0a3a2317638 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -228,7 +228,6 @@ void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
 static inline void wdev_lock(struct wireless_dev *wdev)
 	__acquires(wdev)
 {
-	lockdep_assert_held(&wdev->wiphy->mtx);
 	mutex_lock(&wdev->mtx);
 	__acquire(wdev->mtx);
 }
@@ -236,16 +235,11 @@ static inline void wdev_lock(struct wireless_dev *wdev)
 static inline void wdev_unlock(struct wireless_dev *wdev)
 	__releases(wdev)
 {
-	lockdep_assert_held(&wdev->wiphy->mtx);
 	__release(wdev->mtx);
 	mutex_unlock(&wdev->mtx);
 }
 
-static inline void ASSERT_WDEV_LOCK(struct wireless_dev *wdev)
-{
-	lockdep_assert_held(&wdev->wiphy->mtx);
-	lockdep_assert_held(&wdev->mtx);
-}
+#define ASSERT_WDEV_LOCK(wdev) lockdep_assert_held(&(wdev)->mtx)
 
 static inline bool cfg80211_has_monitors_only(struct cfg80211_registered_device *rdev)
 {
-- 
2.25.1


