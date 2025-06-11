Return-Path: <linux-wireless+bounces-23945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867EFAD47EB
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A4E17AEFF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 01:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C417942AA4;
	Wed, 11 Jun 2025 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VZMhtF34"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFD34685
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605742; cv=none; b=kzlv6YCv01boVdwJJ9blA8yf1WDoI17dyxy9UNE271hYMX5G+oo6tQMkXz7Nz++bMX+Xe9w6Kot8+CQwTK9b5DV/tc7W7YOpBzOHDcNnBBVxX2vD+8ayrBfYZe0mIpy1WIVvWyX1WSjhWhQ1qEohhEvtcly6K8h6gqnSJk8GCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605742; c=relaxed/simple;
	bh=5aE2FVJTGLyA826oSkyUBVcU8NvNMxCKkw1YNKJkeMg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fZNRBV8AGVgGRgIY5k3e3IWTBg8OLHI3Q8NQFRYSaOMpHwZCZoEAXomDxt/9PlO4lJC8HTrR5LaTKzN6fwQQAqRn+xJ8LWjSTe6jQDx/NM+Dya0mfa7pEVZttwm6N8hBI3ShsMB8AVEc9q1cRDZrRDnFui0Uiw1rUuDSFhEg4FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VZMhtF34; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B1Za3yA3937327, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749605736; bh=wJYeCWlt/ryWuDRVO7EaqQCP9nczCPtwdruGjOBzwt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=VZMhtF34xpDSLWBMmmU8stKQbc/4y39d6dGu7AY8c4lzKw3LmwsIPPrx2O75mxSJk
	 TMC4U2qwBV48rxUYD9fyA/y58BPj3hTbXqYTNSgSvSWAV6iMqV05Vs9HW9fZOshRSK
	 0mUJlo3cUQ1p//4gBLX2xvmmYCbNx0ubP4cKcVLmxoxomEhoyXf5hpHWftVhgfOrZA
	 vHxZhc7O4n54f1zeoh1aVqVNc4uN9tGHqsBBtstVHCpkiDvYm+gRIId2p09KCkeS4Y
	 3wV71Mq0NgBCw1jPK1uJxyG1IScEjCgF8DzvITLexGPimRJ4gGwu42is8IsENvdLXp
	 lbSPikde+uNHQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B1Za3yA3937327
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:35:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 09:35:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 09:35:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/10] wifi: rtw89: coex: add logic related to MLO
Date: Wed, 11 Jun 2025 09:35:00 +0800
Message-ID: <20250611013510.15519-1-pkshih@realtek.com>
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

WiFi under MLO can operate on more than one channels (links)
simultaneously, and BT-coexistence mechanism needs to know the operating
channels/bands to assign timeslot for WiFi/BT. Iterate chanctx to fill
the information for coex.

To support MLO use case, the hardware is also added more settings, so
update to control hardware as wanted.

Ching-Te Ku (9):
  wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.63.0
  wifi: rtw89: coex: Implement Wi-Fi MLO related logic
  wifi: rtw89: coex: Update Wi-Fi status logic for WiFi 7
  wifi: rtw89: coex: refine debug log with format version and readable
    string
  wifi: rtw89: coex: Add H2C command to collect driver outsource
    information to firmware
  wifi: rtw89: coex: Update Pre-AGC logic for WiFi 7
  wifi: rtw89: coex: Update BTG control for WiFi 7
  wifi: rtw89: coex: Update hardware PTA resource binding logic
  wifi: rtw89: coex: Add PTA grant signal setting offload to firmware
    feature

Zong-Zhe Yang (1):
  wifi: rtw89: introduce rtw89_query_mr_chanctx_info() for multi-role
    chanctx info

 drivers/net/wireless/realtek/rtw89/chan.c |  195 ++++
 drivers/net/wireless/realtek/rtw89/chan.h |   45 +
 drivers/net/wireless/realtek/rtw89/coex.c | 1019 +++++++++++++++------
 drivers/net/wireless/realtek/rtw89/coex.h |    7 +
 drivers/net/wireless/realtek/rtw89/core.h |   99 +-
 drivers/net/wireless/realtek/rtw89/fw.c   |   40 +
 drivers/net/wireless/realtek/rtw89/fw.h   |    6 +
 drivers/net/wireless/realtek/rtw89/reg.h  |    1 +
 8 files changed, 1081 insertions(+), 331 deletions(-)

-- 
2.25.1


