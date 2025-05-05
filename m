Return-Path: <linux-wireless+bounces-22430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68699AA8CEF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C007A648F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7181C5D53;
	Mon,  5 May 2025 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BIpHew4/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA114B965
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429899; cv=none; b=C/jTicPaYrRTbEn+tN0vP6+aIWykmBMmemvVpE+CO0oiBAYXw8g8lmBf7fztMWUhoKCgGHoBmKUmrzCaoRqHF12nXQgsDIWruiUF4oVpAlrNu+bIJOxM9MynmjGi2o1G1yid1xyHOVsMFFjbq0QztmYKRuNlGJ9GxQnaUdWenZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429899; c=relaxed/simple;
	bh=v/C8KCPRnrqPT1VVWEjBlpmhXJdMpHYrxty8MNkxu7I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vfot85XS0QPkuUJcyMO0fWrFjCaJtEo2op+QQfC292uXeoOlaAgV3ugZknF8pbRqMhTpPshgjRQ8uWJI6o2Kwzd26Xwk4uDDk9SPVEQbfVUZ447MgoYtSfMiiKopAnHOM60+W6FXm5RVsKp/kUMEBuzAfvq1MwZoDKa75dUY76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BIpHew4/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457OqTE23831114, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429892; bh=v/C8KCPRnrqPT1VVWEjBlpmhXJdMpHYrxty8MNkxu7I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=BIpHew4/0EoG9QXZyK9KXOPEk3gvWXZh2fSKDQhGmX7aF7UIhVaNyQkrL6CJgruwj
	 LSrq3vwc7rx3p6YZxMZ9B0gieJBnshYVJB66QQLcJzs9PUvhMpvQ4+OxVnewAmMarm
	 RZYJLxWEN7ocwW2l5ztC1GcbUQ6toSHddgfzBnD+aifaLS8g7DwwSLvYPQwFD9xUOf
	 m0ZhL03cxOmtaXgwJlK6vriIfaI9lv5mf+S3e6qC1pWJDz25j7/h3VOLeD58BalGxm
	 CXF9ScoY+DKNFD862FtbGOWLL6vbcvTERQW7X0N+kVj9XpZAS+2DWcCuCElkjCPJ1M
	 HYdDZHWxdTusw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457OqTE23831114
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:24:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:24:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:24:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/11] wifi: rtw89: support MLO feature
Date: Mon, 5 May 2025 15:24:29 +0800
Message-ID: <20250505072440.45113-1-pkshih@realtek.com>
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

After adjusting code to control two HWs and TX/RX path, declaring MLO
capabilities and so on, start to support MLO feature by this patchset.
Currently only support MLSR with a simple rule to switch link. To test
and debug the flow to switch link, add a debugfs interface as a helper.

Po-Hao Huang (6):
  wifi: rtw89: allow driver to do specific band TX for MLO
  wifi: rtw89: send nullfunc based on the given link
  wifi: rtw89: add MLO track for MLSR switch decision
  wifi: rtw89: debug: extend dbgfs for MLO
  wifi: rtw89: debug: add MLD table dump
  wifi: rtw89: debug: add FW log component for MLO

Zong-Zhe Yang (5):
  wifi: rtw89: extract link part from core tx write function
  wifi: rtw89: chan: re-calculate MLO DBCC mode during setting channel
  wifi: rtw89: add handling of mlo_link_cfg H2C command and C2H event
  wifi: rtw89: debug: add mlo_mode dbgfs
  wifi: rtw89: declare MLO support if prerequisites are met

 drivers/net/wireless/realtek/rtw89/chan.c     |  32 +++
 drivers/net/wireless/realtek/rtw89/core.c     | 260 +++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h     |  17 ++
 drivers/net/wireless/realtek/rtw89/debug.c    | 138 +++++++++-
 drivers/net/wireless/realtek/rtw89/fw.c       |  47 +++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  49 ++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  39 +++
 drivers/net/wireless/realtek/rtw89/mac.h      |  14 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   2 +
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   1 +
 10 files changed, 556 insertions(+), 43 deletions(-)

-- 
2.25.1


