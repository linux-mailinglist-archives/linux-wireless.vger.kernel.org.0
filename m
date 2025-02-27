Return-Path: <linux-wireless+bounces-19538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 686B4A47EA3
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 14:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7B3188C64C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9927D224246;
	Thu, 27 Feb 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KKQXM1w7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2922837F
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661971; cv=none; b=hm6C9q5GfKudn5PrC6nqcRgYpqkE+gMm/1efIHfUG6o5EoT6bFbkS3D9aeBM/z+H6NK6fqFLDZl3mUKgdMzjFqr9KBD3NZXEXp9ZhzhQ1y+8qmnvUK41Hl0o7KN3ioB/1nEQc2pnCanyfPaUJvJxkJzGJMb5iKaCc6o3o6i1lJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661971; c=relaxed/simple;
	bh=v3ywQeivL9E/RIyzAyzVLmmPBn9iDoF048wR2D3AYO0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XvHifBsHirngr1Qv1MjelkFz9NbH+sxw6auNCwIsuoHapOojoZRDUQXhkkK9GmL0/ebyXG6A6NNyRG/N456waXwRz4+nDyJVVSGgmW541qY+CZmjvlFr1yNWVI36MWoUqVims1Y9c523nfVNl8CpnJS5enSN1jitF974/DewHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KKQXM1w7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51RDCiDC22008947, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740661964; bh=v3ywQeivL9E/RIyzAyzVLmmPBn9iDoF048wR2D3AYO0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=KKQXM1w7mJfDEXQGtuPcB/EB+iAk/ea1xLIuAiQbID/zXq0sgNhaduMo7TifW85nm
	 VG8JvBf1wwlTY/k197mGaN8bk3y5cTveVrbRZYJKZ2ioupi/xVptvqU4vNucHvzxnk
	 Ae/hTKWbLDbwhTp8sBD/2YXIuoQ7D/Vvh30JY0g9q5K0yQIDmw7FPS+AbYc23kOdTh
	 exOMO6RuFAu+BUtR7JkkTyKw/+ar6AtAZ6DusWzqSaejDzqTO5dY2dKJ9+FZ8Zl24c
	 mo7c+UOzCc7tXP5BSSGAbGzfI3+8uEtDUxbbfiwvJ3hv7Kq77p1DIEscPgC4jl9UYQ
	 oqq0RZ3eSv2Sw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51RDCiDC22008947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 21:12:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 21:12:45 +0800
Received: from [127.0.1.1] (172.16.24.143) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Feb
 2025 21:12:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH rtw-next v2 0/4] wifi: rtw89: fw: update role_maintain H2C command
Date: Thu, 27 Feb 2025 21:12:24 +0800
Message-ID: <20250227131228.8457-1-pkshih@realtek.com>
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

The role_maintain H2C command is to tell firmware the role of a mac_id,
and two additional fields are added by this patchset to support coming
MLO.

The patch 3/4 is to correct message format by the way.

The patch 4/4 is to prevent breaking users that use obsolete firmware.

v2:
 - add patch 4/4 that is structural dependency

Ping-Ke Shih (2):
  wifi: rtw89: fw: correct debug message format in
    rtw89_build_txpwr_trk_tbl_from_elm()
  wifi: rtw89: fw: don't reject firmware in blacklist to prevent
    breaking users

Po-Hao Huang (2):
  wifi: rtw89: fw: use struct to fill role_maintain H2C command
  wifi: rtw89: fw: update role_maintain H2C command for roles operating
    on band 1

 drivers/net/wireless/realtek/rtw89/fw.c | 42 +++++++++++++++----------
 drivers/net/wireless/realtek/rtw89/fw.h | 28 ++++++-----------
 2 files changed, 36 insertions(+), 34 deletions(-)

-- 
2.25.1


