Return-Path: <linux-wireless+bounces-15520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3753F9D32B8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 04:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6ED2811D6
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 03:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E901B7F4;
	Wed, 20 Nov 2024 03:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ORfbazGt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D612914
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732074099; cv=none; b=OeRSyz1LzFIq9n/1O5OAZxo1QE/sMkWWQW3alwPesIPEGkHm8n8cujkDmJEP0ppuctXYno0kX8MBcMeHDwE8HzwBGAFZDDuURbmfodzJD0ArTbJ2sraHxb+1ruWEF2IH+4yHR55Cj6w3grAnHLQPupDnhQMJW5XckY/q2FrQxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732074099; c=relaxed/simple;
	bh=SmJchLM8FoieiI6kAD0F8QV+p2QnfDnDXR/0wONwDic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rw9tJB8+zvq2ehYRIl0wA6Ay10tpIINGAuQBeW5NXzxDxeOYkD5U3d6hzayP+2fO6ISYGKv5PUmWp0zc7SMYMGhux/sIODuwhUdf5bEuztin6Mhzcu1RuMXuYw+tmqQOPuIY3/g2XJ5VTyvl4Xo9MbAJvU/do2sqSTHbERXgldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ORfbazGt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK3fXU513464729, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732074093; bh=SmJchLM8FoieiI6kAD0F8QV+p2QnfDnDXR/0wONwDic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ORfbazGtd7OdoHI53dx+s1BzlGA65GU16QAb1+dhAJNYuaATXl0c0IEEOE9n2Dx5o
	 wShV184cBJPvxsOCEvdvbZqH1e9o/CjgRuEfLZLqoT3VjN5fBL2qEIuOiogAX/nllk
	 dr4+aC/AIN4tzOoNQZzXL+bpYVuhXNcNCQ1N80IFIdACCf8dqvG9Af36fR4C9swDVV
	 w7IulFY864b3ARrBUow+xYQzNVifoVDnTjjAh8NSBM8rDDr10mgjZBrDC+4qlEsf/l
	 ckYvYcVHqk0FTayLvnXigAPd/6f9I1wwe9pHb1SdArOeYSVB75rVG1bYmGQNcKAoC2
	 EgWAqSPdGPUrA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK3fXU513464729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 11:41:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:41:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Nov
 2024 11:41:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH v3 0/6] wifi: rtw89: preparation for MLO including AP_LINK_PS feature, ieee80211_ops and links
Date: Wed, 20 Nov 2024 11:40:48 +0800
Message-ID: <20241120034054.13575-1-pkshih@realtek.com>
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

v3:
  - correct // style comment in patch 1/6
v2:
  - rebase on top of tree. no other changes.

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


