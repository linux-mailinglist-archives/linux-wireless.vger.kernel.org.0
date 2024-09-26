Return-Path: <linux-wireless+bounces-13224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04FF98744A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 15:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE341C2110E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22800F9FE;
	Thu, 26 Sep 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="rVDKN7PB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2144D8C8;
	Thu, 26 Sep 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356545; cv=none; b=tGdtZUEeu87WFvfZkyffAlTh63sro3qeLbqBs7gtKpj638qw6cwc6i3ibK/pcZX2dLIHyfs+y02vG8pr9+IKwu2mM9uC8eDSP+94VZCwjY7CRcBFzcrRXnIM01z8riF03EtuNDtvKJyamL1cKmf+e7cmOcBIzMeUp8Xgs3h3C0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356545; c=relaxed/simple;
	bh=Li+NL/XbowcT+3OQ1OlrXptD+jGxB2P+QLxIIe9FIvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B767iHcvQ6URAJ81SOoYzX3y/PL2qcivbyTV9ikrMsX9hfRIXn53V08zd0DBhAosKQNX0h9YT/+I4JBoM9X/HUQDf3XPwTTmWW5o5ySWJAdyaNO/H5gBKHFdtdxlxLGrp1eFbUutgtuvljUw2LKnnEflXGaqr93vrModrlt8Na4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=rVDKN7PB; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1A22840769D4;
	Thu, 26 Sep 2024 13:15:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1A22840769D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727356541;
	bh=V+1BZuk4NADDOeMBUufinelDNbmT7wM3ps2z/rjNJpg=;
	h=From:To:Cc:Subject:Date:From;
	b=rVDKN7PBCgiGyh+UHOSHd79VqylkxFbk6bMGovFBy+NyutDD6FwWwHWsWXv0n7v/R
	 wgpwIWZ0Ae4ZjMjGYyaUMSce7dzgXOB6Fz74lxrSPdRbuAbdvQr3MCxBvgFWgL2/Mk
	 fi5xMb43n9l71gtypxNkFKXVozMDOSU/xnoPa2hY=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 6.1] Revert "wifi: cfg80211: check wiphy mutex is held for wdev mutex"
Date: Thu, 26 Sep 2024 16:14:37 +0300
Message-Id: <20240926131437.34326-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 19d13ec00a8b1d60c5cc06bd0006b91d5bd8d46f.

The reverted commit is based on implementation of wiphy locking that isn't
planned to redo on a stable kernel, so revert it to avoid warnings in
different parts of wireless stack where wdev_lock() is held, like:

WARNING: CPU: 0 PID: 4727 at net/wireless/core.h:231 cfg80211_is_all_idle net/wireless/sme.c:692 [inline]
WARNING: CPU: 0 PID: 4727 at net/wireless/core.h:231 disconnect_work+0x246/0x340 net/wireless/sme.c:706
Modules linked in:
CPU: 0 PID: 4727 Comm: kworker/0:8 Not tainted 6.1.111-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events disconnect_work
RIP: 0010:wdev_lock net/wireless/core.h:231 [inline]
Call Trace:
 <TASK>
 process_one_work+0x8a9/0x11d0 kernel/workqueue.c:2292
 worker_thread+0xa47/0x1200 kernel/workqueue.c:2439
 kthread+0x28d/0x320 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 net/wireless/core.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index 8118b8614ac6..ee980965a7cf 100644
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
2.39.5


