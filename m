Return-Path: <linux-wireless+bounces-6478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 207D98A910B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 04:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7891F2241B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA963F8DE;
	Thu, 18 Apr 2024 02:12:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B9929A9
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 02:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406349; cv=none; b=poOI2JbFdt3i7wG5ZXA9E/o8ajOezx8hc+wyZMkGffwPzvrJNvSDkQz36DuL4QQUvUa0FuM/v3aDNv8evOhCTZyJof6hVmTWNm85zl9+f8fy4a+cOlHhG7PkJzcJC1Lg3+YABB34XT8fSyhCEzVlaTOHWLcFVgV13DUIeeByv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406349; c=relaxed/simple;
	bh=c2wMQI9QnkcIQRuZ/Iboza4NGprI4UYVpgw2zKBHFOE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ixQQqvI7bDkb/SAkfQzocS39DD955LECeGSDcAZGUmwC7LRt8aXDxaX5OqvILNUL5UHEhS8HiiVWnjdw58eHtCDOPYjEd8Vz68inzVGWyrniNqcDFHyA08kCybos2Da8e7sk/330zW7CfDMELPWAS+eWOQd7pRM7fEmxDixqNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I2COIA03994681, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I2COIA03994681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 10:12:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:12:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:12:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 0/9] wifi: rtw89: coex: update BT-coexistence mechanism for 8922A
Date: Thu, 18 Apr 2024 10:11:58 +0800
Message-ID: <20240418021207.32173-1-pkshih@realtek.com>
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

Weeks ago we update basic BT-coexistence code to initialize registers that
are needed during WiFi card initialization, and current patchset is to
add new firmware commands/events format used by 8922A firmware.

The more patches will be added later to complete BT-coexistence mechanism
for 8922A.

Ching-Te Ku (9):
  wifi: rtw89: coex: Allow Bluetooth doing traffic during Wi-Fi scan
  wifi: rtw89: coex: Add v7 firmware cycle status report
  wifi: rtw89: coex: Add version 3 report map of H2C command
  wifi: rtw89: coex: Add PTA path control condition for chip RTL8922A
  wifi: rtw89: coex: Update Bluetooth polluted Wi-Fi TX logic
  wifi: rtw89: coex: Add register monitor report v7 format
  wifi: rtw89: coex: Add GPIO signal control version 7
  wifi: rtw89: coex: Add coexistence firmware control report version 8
  wifi: rtw89: coex: Re-order the index for the report from firmware

 drivers/net/wireless/realtek/rtw89/coex.c | 827 +++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/coex.h |  36 +
 drivers/net/wireless/realtek/rtw89/core.h | 134 +++-
 drivers/net/wireless/realtek/rtw89/mac.c  |   2 +-
 4 files changed, 875 insertions(+), 124 deletions(-)

-- 
2.25.1


