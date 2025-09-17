Return-Path: <linux-wireless+bounces-27421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAB6B7F5F8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E732F483112
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 05:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAAB263889;
	Wed, 17 Sep 2025 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kgv2OJ+v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B4264A60
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088576; cv=none; b=dAg3OrSafiaX9WCImaumASGw9MXeSfDX/gwQ+TmWUiVmnab+p9B9n89LfQY8nN5T8Zmn0r6QJrXKHW8Bb8IDPIWmXN4a01piNOK7lnmjvGQfPdsn/6EhjeOXwE3hI5jGpk0s9Qk8ePQdXkMd1Tlk+e5Y0EXGyq9Vz0yTJcA6k/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088576; c=relaxed/simple;
	bh=9bK3B6M4eAVoFitX1TSFO5LE6BKcB27URtNon7If83Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=paWydiv6XOeVlYlDuK9006c2dWY+NgVbAe75XBHDmgzs8wqzp5ulNM2hSH7cUXYGInvTZtET+8xQ1zStFUYZTCun27WT5keeaIH2EHgfEa5PsdmHHSg1etUsrrVbF8hNrxIpY4Zwclfi2U1f+5m1fOVlK1hw8FitYa+K9IWPdlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kgv2OJ+v; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58H5txZJ33954254, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758088559; bh=PMCOhpMt/bgfjQ5kbQ3sXdHK8JskbDzjqkF74YOc4OU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=kgv2OJ+vnOgiejSeSDDNJactK1glaeXlAWMWh7vMgenkGoT8eH765LuLMgOELAcCV
	 AnCAPtsoMrUIGNtODqEjgvCCV1khVaCBXEtzxkck21bkl8sZN+F/hEMWa918mMqkCX
	 /YUxjUn0MyDXW4bwon/gJxUxOXf5dRoGG0GPjBRNY/sNIusYwUeTXCRjuhouK/w7EN
	 ghs5O9h59ztE4xBCtDV4NQ96YWwWtNzV61xXc2HQmzSauo+7kGxl0LKZKXoCl0HwYR
	 MRuwFK678mvFMaK0ZyTw9+40knHOxH69C6oQV036wO+ikM2MRmuHqJtYG+flCq9JE2
	 IuDzFcCurVbtQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58H5txZJ33954254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:55:59 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 17 Sep 2025 13:56:00 +0800
Received: from kevin-ThinkPad-T430s.realtek.com.tw (172.21.69.104) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Sep 2025 13:56:00 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <raja.mani@oss.qualcomm.com>
Subject: [PATCH v2 0/6] iw: support EHT and link id for setting bitrate
Date: Wed, 17 Sep 2025 13:55:37 +0800
Message-ID: <20250917055543.27499-1-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Update nl80211.h for EHT txrate definitions. Support parsing link id.
Then, extend bitrate handling for EHT rate/gi/ltf and link id.

---
Changes in v2:
	- introduce parse_link_id() in util.c
	- tweak implementation in bitrate.c by using parse_link_id()
	- extend bitrate help text
---

Zong-Zhe Yang (6):
  iw: update nl80211.h
  iw: info: extended features print EHT beacon rate
  iw: util: support parsing link id
  iw: bitrate: refactor description
  iw: bitrate: support EHT rate/gi/ltf
  iw: bitrate: support link id

 bitrate.c | 207 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 info.c    |   1 +
 iw.h      |   1 +
 nl80211.h |  51 +++++++++++++-
 util.c    |  40 +++++++++++
 5 files changed, 288 insertions(+), 12 deletions(-)

-- 
2.39.0


