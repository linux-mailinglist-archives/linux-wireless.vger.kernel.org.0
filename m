Return-Path: <linux-wireless+bounces-13225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E1798744C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D931C20EDF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A4EEC3;
	Thu, 26 Sep 2024 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="U8YBS3nj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435B19BBC;
	Thu, 26 Sep 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356567; cv=none; b=VnAnjN9Ym8jGx+IYoGQy9aE54iFlJSMOZxNUoGQMVFOJWzlBxNrxLeRvdr3sVExiTM7+Z+R2qfomxuS7yami27ADiVfZVihztAPZcWMrlznTT+YvxMWdPkkKGe/2wl6w40J5TZ02wBLfR/WvLY+M3fJmsNPuEkkCXVu2VPLmUqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356567; c=relaxed/simple;
	bh=lueK3mVYIFgwnaYP6LogRjyIlNpCpoXyTdJGDeZ58kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b6BtkXIbJkHQp5+nAi6COXSFTaWUTHHeTY7/kbKdc8Xt7EO3fKIoxkIMD2HiipUReqn5gQ2SXQxpbAq7eDcXue7R8Pwg0diWEy+kKAItFj8UkZAMfihTaGYikidkdb2hP0FA6U/hr5vZmvgXDrspZTjUFE1lRz9zPDXUx8nP3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=U8YBS3nj; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 62E0F40769D4;
	Thu, 26 Sep 2024 13:16:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 62E0F40769D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727356563;
	bh=SvxikRyOVv44ivV6cUfSd3gOqQC5Llsj2c+VFw95kcE=;
	h=From:To:Cc:Subject:Date:From;
	b=U8YBS3njE/SD8ict7LBw4pdcFK+xUMIh3C3hdQKwJoOFTDUq1gMn+3dOF2qUOwkaM
	 3dBku/aLr+vZ2IIdYkx/76xS7DvmcfHRm5emsiAmsGYkXgMyS4/0vctCb7np7auc76
	 CcI1LBBIUYIR7CvElXzAeYi4CG8uO8CqhbG6Hq68=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 5.15] Revert "wifi: cfg80211: check wiphy mutex is held for wdev mutex"
Date: Thu, 26 Sep 2024 16:15:52 +0300
Message-Id: <20240926131552.34898-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 89795eeba6d13b5ba432425dd43c34c66f2cebde.

The reverted commit is based on implementation of wiphy locking that isn't
planned to redo on a stable kernel, so revert it to avoid warnings in
different parts of wireless stack where wdev_lock() is held, like:

WARNING: CPU: 0 PID: 4296 at net/wireless/core.h:220 cfg80211_is_all_idle net/wireless/sme.c:662 [inline]
WARNING: CPU: 0 PID: 4296 at net/wireless/core.h:220 disconnect_work+0x236/0x320 net/wireless/sme.c:676
Modules linked in:
CPU: 0 PID: 4296 Comm: kworker/0:4 Not tainted 5.15.166-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events disconnect_work
RIP: 0010:wdev_lock net/wireless/core.h:220 [inline]
Call Trace:
 <TASK>
 process_one_work+0x8a1/0x10c0 kernel/workqueue.c:2310
 worker_thread+0xaca/0x1280 kernel/workqueue.c:2457
 kthread+0x3f6/0x4f0 kernel/kthread.c:334
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:287

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 net/wireless/core.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index be186b5a15f3..1720abf36f92 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -217,7 +217,6 @@ void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
 static inline void wdev_lock(struct wireless_dev *wdev)
 	__acquires(wdev)
 {
-	lockdep_assert_held(&wdev->wiphy->mtx);
 	mutex_lock(&wdev->mtx);
 	__acquire(wdev->mtx);
 }
@@ -225,16 +224,11 @@ static inline void wdev_lock(struct wireless_dev *wdev)
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
2.39.5


