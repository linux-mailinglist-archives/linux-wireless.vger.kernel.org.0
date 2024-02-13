Return-Path: <linux-wireless+bounces-3507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F99E852A1F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 08:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B185284375
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 07:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDEF1B593;
	Tue, 13 Feb 2024 07:36:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBC1B263
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809776; cv=none; b=GI/rGHXLRRgoyOL/KiXoFLSOv7BxOE5fhOJhF2/40pjuMXGDD5nbq+NDpLoqKN5BfDKWr8otikZbIMwG6dqFmu6HD/TapanjlI2dDK6rE9ZEyUErlQH2Hxjx8570j/4z+G/V8EZHejWa4jnt11B+xA6SUDMyTTQvDG1lKD6cVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809776; c=relaxed/simple;
	bh=9wZjWpVnSRnCDTep3IYrhz2ZKvKegc8soIrmI6OqYSA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XlK6gWHKvoex6H4xX7mt2CaJAwuMTc9cXx7F6Q0W0CvRrlHPfFHqoFDWe39JMn3H4ZKunxNYxNVnBkFWmrqaxMOiLOM/WHlTz5x40GVaPPfz6noeG+I30AzD4qzr+tOAg70UORxmr34dUaaZepqzHldlQkkIeNhq8/ZMy0v4m+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41D7a0Pd91671588, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41D7a0Pd91671588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:36:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 13 Feb 2024 15:36:01 +0800
Received: from [127.0.1.1] (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 13 Feb
 2024 15:36:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] wifi: rtw89: support MCC for WiFi 7 chips
Date: Tue, 13 Feb 2024 15:35:09 +0800
Message-ID: <20240213073514.23796-1-pkshih@realtek.com>
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

Because WiFi 7 chips can support MLO, and MCC would consider combination
of MLO cases (not implement yet), so add new H2C commands and C2H events to
have more fields to support that.

By this patchset, we are adding basic MCC (STA + P2P) as WiFi 6 chips.

Zong-Zhe Yang (5):
  wifi: rtw89: fw: add definition of H2C command and C2H event for MRC
    series
  wifi: rtw89: mac: implement MRC C2H event handling
  wifi: rtw89: fw: implement MRC H2C command functions
  wifi: rtw89: chan: support MCC on Wi-Fi 7 chips
  wifi: rtw89: 8922a: declare to support two chanctx

 drivers/net/wireless/realtek/rtw89/chan.c     | 440 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     |   9 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 366 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 284 +++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  91 ++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  26 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   2 +-
 7 files changed, 1183 insertions(+), 35 deletions(-)

-- 
2.25.1


