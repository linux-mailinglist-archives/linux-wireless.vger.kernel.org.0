Return-Path: <linux-wireless+bounces-27260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F2B5486B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 11:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981901881F79
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B421286890;
	Fri, 12 Sep 2025 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mRB79Uet"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84BB266B6F
	for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670887; cv=none; b=A1bDEKdb1y7uhChNIATnzvZ+5syBvrEPuEdQllTYSCL/W1DCKzZ31QWgztPDtExBlboIq8f6RAJBmIA8eTcSZzC/top/4nhYG4MZ+zzibxiU+DNdaam6Y7fbs7macJBEpTJWO6Z5gEfOWANDSu5wjiaZntb81itk0Y+ebR6ZnGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670887; c=relaxed/simple;
	bh=6UEMhJkY+JTY7oihHwpGsK3YtSdo5sn2L2oCZT6wKFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tU1He0QXBVCqG5UAbqrhxkdAi+iNaIK7+fz5aD0shJqgGnMddctSIfniH3JC7ecoD2MUKnqEoC+LwB1acUcp57Os3a3c+6KyRItjP0NhS68Xaib/MPburi4mqxrs51/2DPWBqHKGOJP6FBAMouh2avEX5aecv29nANd2cIFQLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mRB79Uet; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58C9sYyeD495133, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757670874; bh=+p60lqifCsl+HNZSKjU0VMyHUuWWlshsr/U0jBuvOWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=mRB79UetTqoXy2CgIs2Jsj5up5j0nmFwTXTdtQLdB3RMnhG3oX94eCLFalsTRcFyE
	 dr0uXLUF8vp2qhBZKFaahQJH66/hgb4njz6KAM4AzVh6vaIiqsQFKFssB0FnXgde7I
	 AT0/6xqTC8BEE256x1v4BJejZZ8CPAcZAVRq6H0oKJq+TqzitlCJW2bm17AtkYU3VP
	 iHUrN3JY+o7aiB1OZKPRdf3bPU9jJagk7tZ8ta4DrvuzAi3b41W4JmbUKQ4Ab7ACdl
	 luuaAdBPPEjuGcwq7xUARMGY63KkivSjX6aIWz8v20xPs8vjkvJZkyxizjjUbBDPa4
	 wS8jnsjQTb5Mg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58C9sYyeD495133
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 17:54:34 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Sep 2025 17:54:34 +0800
Received: from localhost.localhost (172.21.69.104) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Sep
 2025 17:54:34 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] iw: support EHT and link id for setting bitrate
Date: Fri, 12 Sep 2025 17:54:18 +0800
Message-ID: <20250912095423.27266-1-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Update nl80211.h for EHT txrate definitions. Then, extend bitrate
handling for EHT rate/gi/ltf and link id.

Zong-Zhe Yang (5):
  iw: update nl80211.h
  iw: info: extended features print EHT beacon rate
  iw: bitrate: refactor description
  iw: bitrate: support EHT rate/gi/ltf
  iw: bitrate: support link id

 bitrate.c   | 228 +++++++++++++++++++++++++++++++++++++++++++++++++---
 info.c      |   1 +
 interface.c |  32 ++++++--
 iw.h        |   2 +-
 nl80211.h   |  51 +++++++++++-
 5 files changed, 294 insertions(+), 20 deletions(-)

-- 
2.39.0


