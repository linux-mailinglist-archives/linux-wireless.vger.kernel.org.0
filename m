Return-Path: <linux-wireless+bounces-7087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0108B9365
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 04:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC331C21FB5
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 02:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA9A171AA;
	Thu,  2 May 2024 02:25:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F16A17BB7
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616722; cv=none; b=FxucHsNbPzG/pMo5Wdqh14jtvrnotcBTxjtoRGvL9AoiIHcYZ/rqriV5pm19dhRBOxwkzNCEesJMeBbK1aQAWIG3oLOFBSADgaCQHhXLgfSHs6PMn8AHEkNGtmsO3yurwWdZFPHhxfiW9PvDsSGLXuyk/MXRxEqyWQVqdKWMBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616722; c=relaxed/simple;
	bh=WvVtu0ITeGpDvvPtGlxhKBojohUwficcjBKs7kC56zQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z3S3wGKZ+P3uRVwBG7GdK/gUYiC4SDTVoHg/ROcAjGpz9ywYZeI0qNgBCBqe00v/0AclMlJv/Fo9ew2lD+HX3JLgWnA3DASbqPyZlVXBHB8RrlCe449ujEhpqBOnf/uxCJQVbiEy21AFL+CrPO3JoxVdgqNUw7FrtgeyqAUqn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4422PGD102026244, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4422PGD102026244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 2 May 2024 10:25:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 10:25:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 10:25:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH v2 00/12] wifi: rtw89: wow: support more exchange in WoWLAN mode
Date: Thu, 2 May 2024 10:24:53 +0800
Message-ID: <20240502022505.28966-1-pkshih@realtek.com>
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

Driver offload template frames to firmware as helpers to exchange keys and
ARP response by firmware.

First two patches are to prepare flows required by WoWLAN. Patches 5/12
and 6/12 are to access H2C command via struct instead of macros, which
don't change logic at all. That last one is to support ARP response by
firmware. Others are to maintain variant keys for variant ciphers between
mac80211/driver/firmware.

v2:
  - fix undefined reference to `rtw89_wow_parse_akm' found by kernel test
    robot with alpha-randconfig-r051-20240501 config that CONFIG_PM is
    not defined. (patch 3/12)

Chih-Kang Chang (10):
  wifi: rtw89: wow: refine WoWLAN flows of HCI interrupts and low power
    mode
  wifi: rtw89: wow: parsing Auth Key Management from associate request
  wifi: rtw89: wow: prepare PTK GTK info from mac80211
  wifi: rtw89: use struct to access firmware command h2c_dctl_sec_cam_v1
  wifi: rtw89: use struct to fill H2C of WoWLAN global configuration
  wifi: rtw89: wow: construct EAPoL packet for GTK rekey offload
  wifi: rtw89: wow: add GTK rekey feature related H2C commands
  wifi: rtw89: wow: update latest PTK GTK info to mac80211 after resume
  wifi: rtw89: wow: support 802.11w PMF IGTK rekey
  wifi: rtw89: wow: support WEP cipher on WoWLAN

Chin-Yen Lee (2):
  wifi: rtw89: wow: send RFK pre-nofity H2C command in WoWLAN mode
  wifi: rtw89: wow: add ARP offload feature

 drivers/net/wireless/realtek/rtw89/cam.c      | 120 ++-
 drivers/net/wireless/realtek/rtw89/cam.h      |  71 +-
 drivers/net/wireless/realtek/rtw89/core.c     |   7 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  51 ++
 drivers/net/wireless/realtek/rtw89/fw.c       | 334 +++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       | 466 +++---------
 drivers/net/wireless/realtek/rtw89/mac.c      |  43 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |   7 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  26 +
 drivers/net/wireless/realtek/rtw89/ps.c       |   3 +-
 drivers/net/wireless/realtek/rtw89/wow.c      | 716 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/wow.h      |  57 ++
 12 files changed, 1509 insertions(+), 392 deletions(-)

-- 
2.25.1


