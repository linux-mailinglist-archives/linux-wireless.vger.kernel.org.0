Return-Path: <linux-wireless+bounces-10555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9893DDC3
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 10:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448B52833DB
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3A72F877;
	Sat, 27 Jul 2024 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="H/dB1ODc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1418641
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722067633; cv=none; b=UOxZMmkFKa74TXxjknVufVnrIcQFtb/ScI5k/ZXPO85EeG173hXNP32zlazuJZBfNqACQLCMOOV4acbuCNZJRZ+W1ufhHaictz47c9bngrlq1wElC2B7E4Du+7VxXy4WXUtdfERz5nlqrp2RaNJEaLI59j07wrUDfeEoAnmoEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722067633; c=relaxed/simple;
	bh=rjC0dNu45CN41d/wnqxy7JCjXC8LoKl1IwfThCoW5zI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JQCCqwaVZrEQJTFdF14kwFmN/Xt2dHT7tTosc5L8n6fTPYo8BFGcsc7rJjP5N/i44IpLtImhDhXRlddhD9a9zb+EJzBE1o7hjGYQqqtaKvDTkJlzyYa06SpStRZP78ax9mYHp/81oKpUkQ2OBOQOw4DJy6KqWHsmQUd1nGlZf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=H/dB1ODc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46R876VE01417413, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722067626; bh=rjC0dNu45CN41d/wnqxy7JCjXC8LoKl1IwfThCoW5zI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=H/dB1ODcUb/FH9C1v0ecQ52S1N59HemC680IRfjdhMIStnSqjf1bVuZ/wXbfb1/k+
	 80G/PDuDKNLS+n+nZmwOo+OGlw2g9ZgDQUBhIzYYNr8uvygtWXI9ZEo64m0yjyiRJq
	 IAlpgXISvKEC59vHasf83ldFPrATcVm9jpf2xOfXdMOLLCASAxtjg22/nwayRzuQoY
	 O+aMQuX89th9irpObW3Sgcp8FX6i1UBXCpkpBqEJme1RAOUH6DqDfabIegSLfW7ekw
	 b5cNHl4z1bXqn4g6TOpejLFip83GxUpGomC40PbYX542Kprr8ZCg1VHbWR/XCi8mTA
	 TXAWTsc0sOluA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46R876VE01417413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 16:07:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 27 Jul 2024 16:07:06 +0800
Received: from [127.0.1.1] (172.16.17.30) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 27 Jul
 2024 16:07:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 0/7] wifi: rtw89: refine use of vif/chanctx and MCC
Date: Sat, 27 Jul 2024 16:06:43 +0800
Message-ID: <20240727080650.12195-1-pkshih@realtek.com>
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

Originally rtw89 uses simple vif/chanctx combinations for SCC and MCC, and
use static/hardcode vif/chanctx somewhere. However, we are going to support
MLO in coming days, so refine the code to configure hardware by vif/chanctx
dynamically by this patchset.

Zong-Zhe Yang (7):
  wifi: rtw89: chan: refine MCC re-plan flow when unassign chanctx
  wifi: rtw89: mcc: stop at a role holding chanctx
  wifi: rtw89: rename sub_entity to chanctx
  wifi: rtw89: pass rtwvif to RFK channel
  wifi: rtw89: pass rtwvif to RFK scan
  wifi: rtw89: fw: correct chan access in assoc_cmac_tbl_g7 and
    update_beacon_be
  wifi: rtw89: pass chanctx_idx to rtw89_btc_{path_}phymap()

 drivers/net/wireless/realtek/rtw89/chan.c     | 186 +++++++++++-------
 drivers/net/wireless/realtek/rtw89/chan.h     |   6 +-
 drivers/net/wireless/realtek/rtw89/coex.c     |   2 +-
 drivers/net/wireless/realtek/rtw89/coex.h     |  10 +-
 drivers/net/wireless/realtek/rtw89/core.c     |  60 +++---
 drivers/net/wireless/realtek/rtw89/core.h     |  53 ++---
 drivers/net/wireless/realtek/rtw89/debug.c    |   2 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  23 +--
 drivers/net/wireless/realtek/rtw89/fw.h       |   2 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   4 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  10 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  10 +-
 drivers/net/wireless/realtek/rtw89/regd.c     |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  15 +-
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c |  36 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  11 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  50 ++---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   9 +-
 .../wireless/realtek/rtw89/rtw8852b_common.c  |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c |  50 ++---
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   9 +-
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    |  44 ++---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  11 +-
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |  42 ++--
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  13 +-
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c |   8 +-
 drivers/net/wireless/realtek/rtw89/sar.c      |   2 +-
 27 files changed, 366 insertions(+), 310 deletions(-)

-- 
2.25.1


