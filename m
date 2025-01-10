Return-Path: <linux-wireless+bounces-17270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD187A08511
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 02:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE9B16913D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 01:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DEC1465B8;
	Fri, 10 Jan 2025 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZOD0EoxD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5F18C31
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 01:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736474079; cv=none; b=TSXazgKCu45TLF3hNeLKyNyu7WEg5pdDyeOFz+entu/p/DL5KchvZ4rX8t5xgM7+X+P49qYYhy9rfsJdQo7zLYsbYW1X6MxmhZ7wH38qdeNTK1Ty8vVXZT87JUcwUe9HXlskdEGcgZw7Z3IRBtqQdR9/GJ5CrPztqnA9OyRhAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736474079; c=relaxed/simple;
	bh=PJBG8Q/KWzHIbBjBc4mVjc9cLf6q9S1prHcsNoQyLCI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=astg7O2EI/6Mqqc2XPLDDxOWLw71BBo211Kn3h2EVBoObW5PcLxsrrGaSEsPXh8o2svLmeMBeWtxKUIkal7fqfeCmwzBevYZRhESNSMgny3FG3o7tjt2s/bVCk+7o8FX68HhgvlUH5+O3WEc/oWHw0GLOtXnbxqvBesUbxAjHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZOD0EoxD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50A1sW3813982801, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736474072; bh=PJBG8Q/KWzHIbBjBc4mVjc9cLf6q9S1prHcsNoQyLCI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ZOD0EoxDeVt2gN5hLMdHvywP5FKBxvgnKnY9EDa9CzK7X+/bRw2hdDLh6AcvNeVAH
	 P3yTb8/s3PBfquRAMb/muA+6kH0xK2tTUeTvst6BeTCy1k+lG3w1GCMrZcxBcU/keY
	 +Pzv+oJFSPOjAdZ/Hr+FmQCyMCEzuuhHbsi0dnkTezksuGwyRwZzxVKXviiviiTD85
	 MOku5mW+ypeVLqQgWZzJOsX7kbEkTC+yz7iJttXsP/g0520dTTeTGBlTP+E+tnMCZx
	 g0vLONGGIz/w+gQE6GBQzdmLlsYO9tuz2r/gJx8VTMmJijsztyjICGZu2TFuyzyQR5
	 K9gjOGIuhRdFA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50A1sW3813982801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 09:54:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 09:54:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 10 Jan
 2025 09:54:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 0/3] wifi: rtw89: coex: improve user experience of BT A2DP while WiFi connecting
Date: Fri, 10 Jan 2025 09:54:13 +0800
Message-ID: <20250110015416.10704-1-pkshih@realtek.com>
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

The BT A2DP lag sound might present while WiFi connecting. Implement
separated policy for connecting and preserve time for BT interleaved with
RF calibration while WiFi is connecting.

Ching-Te Ku (3):
  wifi: rtw89: coex: Add protect to avoid A2DP lag while Wi-Fi
    connecting
  wifi: rtw89: coex: Separated Wi-Fi connecting event from Wi-Fi scan
    event
  wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.2

 drivers/net/wireless/realtek/rtw89/coex.c     | 100 ++++++++++--------
 drivers/net/wireless/realtek/rtw89/coex.h     |   2 +
 drivers/net/wireless/realtek/rtw89/core.h     |   3 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   6 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   6 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   6 ++
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   6 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   6 ++
 8 files changed, 92 insertions(+), 43 deletions(-)

-- 
2.25.1


