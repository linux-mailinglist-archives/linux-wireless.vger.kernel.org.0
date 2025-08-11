Return-Path: <linux-wireless+bounces-26253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D74B208F6
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9B318A343C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F052BEC2D;
	Mon, 11 Aug 2025 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZnFSp8Z7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8E2D3A83
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915921; cv=none; b=RqpW6G20ktUpdjc8sT8eAY4MltP2m5rRq6/ofotRZTa7Ail0LUcCd2pHId7KmJjT7tmd+zaTTrCJ5ogEfi6CuPnaqAPwtRD7v3Vy4coSDOg+sebnRDrKo7wdyRNhpvu1DDtd5x21VqPhbMF8jji7CwcnrWFw+ERqFRqjcG/Z8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915921; c=relaxed/simple;
	bh=eRqJvZcmiX+2+XBi6H53YGR07Di+83sJC+99MVrx960=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PQnpAhlh/7l4dyFg9efk+98FfTvIe2xRFp8afvHbSDCDHP2i46pu661qb+x9jsCAIsWoV+IlXHgy8+501ehQ+V4ix9Q9LsqLH74LzmGnDnz00BCHaCpFUErOXIKNCnbEfVqqtKQ2NCTsJww1Y69VVjT4PVaFv2zPrYXVkYq3Uek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZnFSp8Z7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57BCcZq55073195, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754915915; bh=Wf/5XcRjMS49HxzL4Fuw7psXJeY8CO1Nor7dGltemQA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ZnFSp8Z7xqDgeLInA+587WCYg3kcH+KienaklYa8/bypyxkvGUx3cJNMysryTQ6m0
	 uwScnJOaQ4QjdY3mER21NRGL5Hputv7q9vLVfRPAuNtpmvRjbOABZTpnZEo0bjZbU2
	 1irRdNRRm2s2FEjqutcpB0wmgZdc6FeUfdhRU47S7M2gj3zuN2HRwl2Py3ZCG2W5PJ
	 /gK907zcvkf0oTwER6nRcfDLkW9j1X/chGv5O4eplxn7YsakQgMhZEbPqyPi5+xlwk
	 ImPy4RxTXJgiARu6M5pweeapmXInYsjTeyCFpGK+T7ZegoTC/38c9C32k8Juvy60GC
	 Qzgv03baXi3gA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57BCcZq55073195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 20:38:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 20:38:36 +0800
Received: from [127.0.1.1] (10.22.225.179) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 Aug
 2025 20:38:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 0/8] wifi: rtw89: improve connection loss and 8851B performance
Date: Mon, 11 Aug 2025 20:37:36 +0800
Message-ID: <20250811123744.15361-1-pkshih@realtek.com>
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
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Connection loss might because beacon loss when device enters PS mode,
which expected to receive beacons on TBTT, but somehow it can't because
of beacons drift. Improve this by statistics beacon drift by patches 1-2.

Patches 4-5 are to improve RF calibration of RTL8851B to yield better
performance.

Patches 7-8 are to handle non-transmitted BSSID missed before.

Others are to correct settings along firmware definition.

Chih-Kang Chang (1):
  wifi: rtw89: 8852c: check LPS H2C command complete by C2H reg instead
    of done ack

Kuan-Chung Chen (7):
  wifi: rtw89: introduce beacon tracking to improve connection stability
  wifi: rtw89: debug: add beacon_info debugfs
  wifi: rtw89: wow: remove notify during WoWLAN net-detect
  wifi: rtw89: 8851b: rfk: update IQK TIA setting
  wifi: rtw89: 8851b: rfk: update TX wideband IQK
  wifi: rtw89: fix BSSID comparison for non-transmitted BSSID
  wifi: rtw89: fix group frames loss when connected to non-transmitted
    BSSID

 drivers/net/wireless/realtek/rtw89/core.c     | 463 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  51 +-
 drivers/net/wireless/realtek/rtw89/debug.c    |  61 +++
 drivers/net/wireless/realtek/rtw89/fw.c       |  93 +++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  27 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  30 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |   2 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |   3 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   9 +
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 159 +++---
 11 files changed, 810 insertions(+), 89 deletions(-)

-- 
2.25.1


