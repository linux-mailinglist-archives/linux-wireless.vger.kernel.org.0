Return-Path: <linux-wireless+bounces-15040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E309C0034
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C373B1C20402
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 08:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636938FB0;
	Thu,  7 Nov 2024 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NOx4Yabe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DA198A19
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968885; cv=none; b=dOCKqqHoFRiY735OMqNfGfflBQKjcuyE/nNqthpxVEy4TJyUPplgaySfzG/NvTYIEyQzqNDLC18tG9V/R/GH9ba1X5H8fcvUB4PfEf9nSgIMYf8D1hc+LLAFIVLjb1Vr0ZKVSMeDIF+LK9EGftU/Swom/42zrDxgxK8s/OqmPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968885; c=relaxed/simple;
	bh=CzywtCc5+LWj0o8PwbxgBlNe8jGoSiTtfvydPbu0YvU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NUDg0eoBP13wDFYRRa8j9ucA6/xrEiaIgZ2Ly6Ab3jTHaEOCWupJQPF/x29K0MTg/mZxaIuDq4yySOuI1hENujzxWz65vmp5bqPgztEKlH+G3/S8y2CzglCHyTy8YUXJK/+w8ciWFDZicB3tqyy62A7brs6X5VKhpreWSsWsrho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NOx4Yabe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A78fKz054173688, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730968880; bh=CzywtCc5+LWj0o8PwbxgBlNe8jGoSiTtfvydPbu0YvU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=NOx4YabekhD76BFaHHOpevrJrWVbh4S89jlAB4a+w+j0sRsGdQtV0Snz55Wl3Kq4x
	 fSGXBM4SVvTIpeTY1laBLT+heiwKHMtJ9CNpjPQR49B345IYhgpT+q7Ri1b4MDAc9S
	 ZVFsJroCCo4Yyi5yNNeUJBYBFuiV/1l+kvNnoDH1a52oekZGgHwYG2SmlR3YgSMYi/
	 pw3y4WKPnRDIkLljUjHxERxbTVgv+swM0GtB6ZYFZXwejRZZWXVh+EbYFyTk4vaIvG
	 FEWo1bD4K6t0V7pvKJ1DnVCQI5FuVa9P3cpT6Wo9+WQN0xLrS3LyWDEUgPmEehi5PM
	 uCIMuEJy0CQDA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A78fKz054173688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 7 Nov 2024 16:41:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 16:41:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Nov
 2024 16:41:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 0/6] wifi: rtw89: preparation for MLO including AP_LINK_PS feature, ieee80211_ops and links
Date: Thu, 7 Nov 2024 16:40:35 +0800
Message-ID: <20241107084041.20775-1-pkshih@realtek.com>
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

Add more materials for MLO. First one is AP_LINK_PS feature. Then
implement ieee80211_ops related to links. The last two are to consider
link_id instead of -1.

Zong-Zhe Yang (6):
  wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
  wifi: rtw89: register ops of can_activate_links
  wifi: rtw89: implement ops of change vif/sta links
  wifi: rtw89: apply MLD pairwise key to dynamically active links
  wifi: rtw89: pass target link_id to ieee80211_gtk_rekey_add()
  wifi: rtw89: pass target link_id to ieee80211_nullfunc_get()

 drivers/net/wireless/realtek/rtw89/cam.c      |  32 +-
 drivers/net/wireless/realtek/rtw89/cam.h      |   5 +
 drivers/net/wireless/realtek/rtw89/core.c     |  45 ++-
 drivers/net/wireless/realtek/rtw89/core.h     |  59 ++++
 drivers/net/wireless/realtek/rtw89/fw.c       |  71 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  19 ++
 drivers/net/wireless/realtek/rtw89/mac.c      |  50 ++++
 drivers/net/wireless/realtek/rtw89/mac.h      |   7 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 280 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/ser.c      |   1 +
 drivers/net/wireless/realtek/rtw89/wow.c      |   5 +-
 11 files changed, 560 insertions(+), 14 deletions(-)

-- 
2.25.1


