Return-Path: <linux-wireless+bounces-27569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC12B8F38C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 09:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6BE3B015B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F82F0C78;
	Mon, 22 Sep 2025 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kP8vPkSR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017F1E9B3A
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 07:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525055; cv=none; b=bVfpywDiR9isFvzZ2/VWBsrzZHYdGY6tXFDMuujhN6jmrGJa7qP1gx3WR6xEj35eLduOu13jLj/vAtqSUMjJVueuQ4Th6XU/cKERBmcqtAX6NabYw2MERc7/1wPHx6mrbp5abBxY+gbcGBLYidUV6FQww8Kkp9QfGrJoZi+QA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525055; c=relaxed/simple;
	bh=lcaik8tIpp64nEfOQpPZQ2sK6r3eLM/4R8jPjtA6mro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UXYKkTVBOt4ZpW0j5clY/W88dN29Ikjs93fKxAvLkA+Uql972f+XQakgHpuc+BH/84Bmcq5X5mKq0+y92h6Pd4PlXgBZkgzy9aYw5J+9uFGrLQvjtemKHyREgvKKbLnbYPCZZdoCzHXs96tLJvBOq8xE+DjFeH1Z/2vHnp3yPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kP8vPkSR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58M7Ab2L24015231, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758525037; bh=Y+Kmd3+/ROLiA8U3qV9nwRew1v7pv/izY0TL27BpVI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=kP8vPkSRCBqE8+5iV15StxZZCBXzbdIq+rXtGSQgjyBG5feN4mXIY63pihnUCsnR7
	 qygn9cIcLW/kcp6ylyamhVdGYrONivnqmtfq9TvNgdk2CDYEXA88ymxNP2ODYkI77u
	 TGTCobJvuCJ1Vt118FC9I0m0NBjjNaydq6dy3bt7MgyvbLyuBwonrdW11fLNKkMlWv
	 GfOjlIcgweLv0RGWSXFx8kGktMwKK8RTxra6RvIZTTys/HIWjHmUIitZJnRptqAOy9
	 gjRy8J/sC4nL3k3aZ5e+pVIDn18pULzFFnATjcSqZIaKJR8AB5P+LPHuXBOaUyfjl+
	 Tx2tFfKirvZwg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58M7Ab2L24015231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 15:10:37 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 15:10:38 +0800
Received: from kevin-ThinkPad-T430s.realtek.com.tw (172.21.69.104) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Sep 2025 15:10:38 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <raja.mani@oss.qualcomm.com>
Subject: [PATCH v3 0/4] iw: support EHT and link id for setting bitrate
Date: Mon, 22 Sep 2025 15:10:13 +0800
Message-ID: <20250922071017.11954-1-kevin_yang@realtek.com>
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

Add support of parsing link id in util. Then, extend bitrate handling
for EHT rate/gi/ltf and link id.

---
Changes in v3:
	- nl80211 updates have been accepted
	- parse link-id field only at the beginning of argv in case mess

Changes in v2:
	- introduce parse_link_id() in util.c
	- tweak implementation in bitrate.c by using parse_link_id()
	- extend bitrate help text
---

Zong-Zhe Yang (4):
  iw: util: support parsing link id
  iw: bitrate: refactor description
  iw: bitrate: support EHT rate/gi/ltf
  iw: bitrate: support link id

 bitrate.c | 207 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 iw.h      |   1 +
 util.c    |  31 ++++++++
 3 files changed, 230 insertions(+), 9 deletions(-)

-- 
2.39.0


