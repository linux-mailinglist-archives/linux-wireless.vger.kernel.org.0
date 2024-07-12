Return-Path: <linux-wireless+bounces-10201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5456D92F68A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 09:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81F9B22BDA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 07:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC513E020;
	Fri, 12 Jul 2024 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="u/0kdyo7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B598913DDB8
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720770779; cv=none; b=fx12pgmZHhKut+qklv5BurmOXH1JJs/IRtJ8RJZS/AzT6tfYIOFJHld3jZrREcs32NnVM+0+yIKoLsBZfzUFZsljwfeOu0t+lL2xTzGRBvKQt2If/m0HiU2N5rvtaz9uv6zqXVSjPyOQGAOgBGNPv7rMk9TB5EVqW9tAVXwV8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720770779; c=relaxed/simple;
	bh=n7BK5RgRfeg0x/nPko4/zXA++cc4fTWmZ0PFuoQKsDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TyB2ZAR/RsMzSiK3USfS8JEoZth25bNzDyY7mupXUJAEpMUSgSyojA015l5TvXtnMR/CpnR0qGLSS5G3yckb/Jg6zB8coXUyi7IUOhWoS4H6m51K5tRIfYpxCl/KgRO24RAGaghIWRzVZgb37sUIYyEe5fA/tfyuaCatMo1jjYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=u/0kdyo7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46C7o2j15285366, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720770603; bh=n7BK5RgRfeg0x/nPko4/zXA++cc4fTWmZ0PFuoQKsDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=u/0kdyo7/bvAKpZB6V2OpHn/JmpOQFTfN7LxlDZKz4QTwb8cHH+xA0ZNMVlpfPNhR
	 KnR8vq1RZBQelgrKg8xB708iuVRwzKPnkJf0Yktmh/pAsOC8gIlBQXbo/SqcI2rQzh
	 1R+BQp9GpaDf0R4qMXqJoYXrQ/EFmQPasyVfukdTAA5dO/lMMJsBvx4QZ1vb7+4y/h
	 jDu1LHqudwusZhLCc/mO5JHR+UyXoGsCKdVJWm82GFLxgn2X6oAp1Qc1D7GhsnSb1v
	 PXaT1+bb2SGxuNPDTS0ceCGvN8a2c/Ff7g0GaL42yD8dmBb2lRd9n9RpmeXEHbvGgP
	 BLlTcZU8n/LiA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46C7o2j15285366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 15:50:02 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:50:03 +0800
Received: from localhost.localhost (172.21.69.104) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Jul
 2024 15:50:02 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: mac80211_hwsim: correct MODULE_PARM_DESC of multi_radio
Date: Fri, 12 Jul 2024 15:49:38 +0800
Message-ID: <20240712074938.26437-1-kevin_yang@realtek.com>
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

Correct the name field in multi_radio's MODULE_PARM_DESC.

Fixes: d2601e34a102 ("wifi: mac80211_hwsim: add support for multi-radio wiphy")
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 714e1f04b0cb..77be2d187a26 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -71,7 +71,7 @@ MODULE_PARM_DESC(mlo, "Support MLO");
 
 static bool multi_radio;
 module_param(multi_radio, bool, 0444);
-MODULE_PARM_DESC(mlo, "Support Multiple Radios per wiphy");
+MODULE_PARM_DESC(multi_radio, "Support Multiple Radios per wiphy");
 
 /**
  * enum hwsim_regtest - the type of regulatory tests we offer
-- 
2.39.0


