Return-Path: <linux-wireless+bounces-18702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B889CA2EC97
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 13:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926433A2558
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 12:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB79223318;
	Mon, 10 Feb 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SNynFsk8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60862223311
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739190706; cv=none; b=JMu/TmzmsTAxMEcmNO9p+pfX1Jedd5r4uoZqU0sXwb3t14Jpsos/6DkVhPKQkqxwqSv9NskgXQ8wOOsKJdX4nnBhR3x4t7XG4Lkz2ngspiNz3VI/Q8pb91DjilPLwmMjKzUCW8dMYKqE7ZUZi8xDfl0KvEIhM16rdpBCJfZgn/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739190706; c=relaxed/simple;
	bh=4mLTA+TCiiyvIjG2HJqEcqJfqStXPN6S+QZBKX/pRu4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ArnvD2CTToa+IQojf4fZH/QhDcWFuVem4WuolsabfudtVEgc5r+f5tPQimz+dM6bCUTgv0wV/ZC1jOmG1IAz7WhYX+EKIXjopDYZkfSfZ3ovjEW3GS0o+XRx3We6m1KcpvnjBXJDGxFW4DnRVgffbowZq4JMc+Dd5l8WMILr6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SNynFsk8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51ACVb0U22219614, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739190697; bh=4mLTA+TCiiyvIjG2HJqEcqJfqStXPN6S+QZBKX/pRu4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=SNynFsk8YADkQ0omeaNLIbXgEAWmXRt8Ssjmo2LZTUb2Rl61hzLKiDsVjV+0SmPmp
	 qrqiiMpfxP9kB09uSW212fxHdSuI44k/7UbzUOGVFUYCzN3owVTEMChX5dcICrGKfL
	 7n2DaaStbfQZaRigM9tfYhvxFf5qN3ZnCyGafWo1MfRhsFAHHdQCj18L2zx1P03fSU
	 Ja2dsA/wIVa/Yy+o+O84BGRKNl68Y1UVOd8wt+2+TxNSeltCiKMq6eKOSUgHXT0764
	 9z5iWaZnYSsCzQZJYtiZ6XV8dz8F/BVODD+r/+2E2xCH1KsAxPKOZDTIZ9kCbqUJdu
	 UT/cUY7i+NGJA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51ACVb0U22219614
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 20:31:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 20:31:38 +0800
Received: from [127.0.1.1] (172.16.24.241) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 10 Feb
 2025 20:31:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: debugfs depends on CFG80211's one
Date: Mon, 10 Feb 2025 20:31:05 +0800
Message-ID: <20250210123105.10466-1-pkshih@realtek.com>
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

The wiphy_locked_debugfs_read() and wiphy_locked_debugfs_write() used
by rtw89 are defined if CFG80211_DEBUGFS enabled. Add the dependency
accordingly.

Fixes: 8fdf78f3cd5f ("wifi: rtw89: debugfs: use wiphy_locked_debugfs_{read,write}() if needed")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502101810.3CUpUL7p-lkp@intel.com/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index b1c86cdd9c0e..205d7ecca7d7 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -123,7 +123,7 @@ config RTW89_DEBUGMSG
 
 config RTW89_DEBUGFS
 	bool "Realtek rtw89 debugfs support"
-	depends on RTW89_CORE
+	depends on RTW89_CORE && CFG80211_DEBUGFS
 	select RTW89_DEBUG
 	help
 	  Enable debugfs support
-- 
2.25.1


