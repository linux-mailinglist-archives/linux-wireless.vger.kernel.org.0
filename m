Return-Path: <linux-wireless+bounces-14296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D305E9A9CA8
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 10:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810DE1F2322A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596E315B102;
	Tue, 22 Oct 2024 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NUNpMygn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB780BF8
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585901; cv=none; b=uM2HP+0x9e3SCPjzbT1mbMv+68td5Q9kKBQi+v5joBMdytuw6EYWvRpIAvYazv2tEUo7TtH7DWr4Fx9enpOkxeX2oUBmMyS30sI3k5wOl/Pyh4o7vlxTbbvd7tBvyUAFi3ERdqH+tbcV+9CVym33J4G1E817A6jrnBgqrLu8kP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585901; c=relaxed/simple;
	bh=V5nEOUoXMfC5w7AuS4q8zm2TswCGzvZ9p6wk54vzDho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qkcOiR6/+5mRUG6v6XK0+ERMxUBWoKow6FFye90XQFqNa7l8dgWGmhmyiE2QykwYp78Suew5KPw7QRcbTC6Zibwqb4Zk8MgNvpq1DaJT7F0vrwSEuyRhbphAEWsUcpjH48CF5qnbSe7iuR5Wfa2RuYInxt/eq4rm1zjVkEWvszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NUNpMygn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49M8VVOJ03771795, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729585891; bh=V5nEOUoXMfC5w7AuS4q8zm2TswCGzvZ9p6wk54vzDho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=NUNpMygnMtPLerJjMt+yMFg1uBzv/3wqdahRT3a4z+JV9W+px5WprAPv/tJ/mH6JR
	 oxlloLwJoWxbLk52DvYfkAy4OjTRSRkTHmJtD2zcf/Pe1AlWEit+ykp9I7DZOkZl9D
	 o1DoOOjvLGimm6mlNvfsyGPOH1isLi9oMLaJiDqJRkZjXWRoqqcF9ysYyziIrDl2DU
	 24s7q9hQRzyC52OgYieW7tCypmWKRskgRXRFUOOBzqJTQI47cxup7/1+DBX3Lpdwxq
	 E4GQKIEEVMTLvayp43wrQcV5pZs/ycPIrxe2RSkEK2v2YRPozgd+/MQZH4WD3E49BH
	 Rk/3hVf3oh0PA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49M8VVOJ03771795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 16:31:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 16:31:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Oct
 2024 16:31:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 0/5] wifi: rtw89: configure encryption/decryption and channels for MLO
Date: Tue, 22 Oct 2024 16:31:01 +0800
Message-ID: <20241022083106.149252-1-pkshih@realtek.com>
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

A patchset to prepare more materials related to MLO. First two patches are
to configure encryption/decryption to support MLD address, and latter
three patches are to adjust chanctx to fit MLO and MCC cases, and to
notify channel settings to firmware to have correct RF calibration.

Po-Hao Huang (2):
  wifi: rtw89: Add header conversion for MLO connections
  wifi: rtw89: Add encryption support for MLO connections

Zong-Zhe Yang (3):
  wifi: rtw89: chan: manage active interfaces
  wifi: rtw89: tweak setting of channel and TX power for MLO
  wifi: rtw89: 8922a: extend RFK handling and consider MLO

 drivers/net/wireless/realtek/rtw89/cam.c      |  51 +++++
 drivers/net/wireless/realtek/rtw89/cam.h      |  24 ++-
 drivers/net/wireless/realtek/rtw89/chan.c     | 183 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/chan.h     |   8 +
 drivers/net/wireless/realtek/rtw89/core.c     | 131 +++++++------
 drivers/net/wireless/realtek/rtw89/core.h     |  32 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       |  23 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   2 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  18 +-
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c |  61 +++---
 11 files changed, 412 insertions(+), 127 deletions(-)

-- 
2.25.1


