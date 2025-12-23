Return-Path: <linux-wireless+bounces-30057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 266ADCD7EF8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66AA830022D4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F922C21EA;
	Tue, 23 Dec 2025 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ktA7EP7h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057782BCF4A
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459233; cv=none; b=A9UJpnd/I4w+iFLIsQUqCwpYFyQcegPsyZOXD4NvRqo1S6YURr9z33k+pdj1tK1IRQZ3GJdiZxdMBEr6LmoxzGVjbKDGB4sik3xAg51GQzke74RexGJ9gseW0EC1IgnZIR0XKNuPltrOv2RgdEps3QREQswnUERYMkaCG1lvtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459233; c=relaxed/simple;
	bh=Ey8+0UJbmyt0i9Fh563ZyLRlPwMgeEfezWX/SjD1qmQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6WM8hXFUq8UJzK0J0ntp7deV7vSMt3GN/h20/hvodw7DFT5U69sfjWt4UHnKtSKsTguXMykfGwEJJMHe2oGA4JHKs4a513RWqa5sw/Z1Tbmuffv1130qK40OBjieWjs51FVM0Y/ZZhPO4RfqZgGrWWlpZ0VHi+6ez3v7EHnBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ktA7EP7h; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN373wwC571106, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766459223; bh=B+SBS91wFRncJZeY7cZL+7EfQIMr938Z5fmHp34xdgw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ktA7EP7h3tpsTH9hNX41T70DTfgI6kR5O5IUIng6jqzBsSOsALpWJji2mClOismTj
	 Z4duT5R8b6HuE/AzwYdpdKR9EP9RQxSzrwXpHwL0yL3OSKfpwHfWYkkorjeYTIYm/C
	 ydnfsgEcjlLDHJt1QMpCkdT4MzPolv9aa3rhL8fo56MO01qu19yXMnKCaW3SCJHj46
	 H/2Nuotj2MLY6vOZ/Echs8EBgkaGWVmTdH7kXFxA2iaVQExAs7nfXscth45pmooj20
	 ouboPqW+x/L4zgoPo40API8HpXF0A206nrEg+0M1raVmEUuyl2Ry3W7hdhU+hqoQ8M
	 1/MLUu6MzIjRw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN373wwC571106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 11:07:03 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:07:03 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:07:02 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:07:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v3 00/12] wifi: rtw89: refine MLO, MCC and SER functions
Date: Tue, 23 Dec 2025 11:06:39 +0800
Message-ID: <20251223030651.480633-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Refine MLO (by patch 2-3) found by test, MCC (by patch 9, 11, 12) getting
better connection stability and SER (by patch 5-8) supporting newer flow.

Others are random features and refinements found in field.

v3:
  - for patch 4/12, keep original behavior for WiFi 6 chips. Otherwise, it
    gets SER suddenly.

v2:
  - base on patchset "wifi: rtw89: correct use sequence of driver_data in skb->info"
  - handle USB to avoid warnings on two patches:
    4/12 "wifi: rtw89: mac: reset power state before switching to power on"
    10/12 "wifi: rtw89: warn unexpected polling value of XTAL SI"

Chih-Kang Chang (3):
  wifi: rtw89: refine C2H reg event polling timeout for LPS
  wifi: rtw89: setting TBTT AGG number when mac port initialization
  wifi: rtw89: mcc: reset probe counter when receiving beacon

Kuan-Chung Chen (3):
  wifi: rtw89: 8852b: increase beacon loss to 6 seconds
  wifi: rtw89: mlo: fix missing TX null-data 1 during link switch
  wifi: rtw89: mlo: fix incorrect link address in management frames

Ping-Ke Shih (2):
  wifi: rtw89: mac: reset power state before switching to power on
  wifi: rtw89: warn unexpected polling value of XTAL SI

Zong-Zhe Yang (4):
  wifi: rtw89: ser: enable error IMR after recovering from L1
  wifi: rtw89: ser: L1 skip polling status if FW runs event mode
  wifi: rtw89: debug: add ser_counters dbgfs
  wifi: rtw89: debug: support SER L0/L1 simulation via halt H2C

 drivers/net/wireless/realtek/rtw89/chan.c     |   5 +-
 drivers/net/wireless/realtek/rtw89/core.c     |  13 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +
 drivers/net/wireless/realtek/rtw89/debug.c    |  79 ++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       |  12 ++
 drivers/net/wireless/realtek/rtw89/fw.h       |   1 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  90 +++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h      |   5 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  37 ++---
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 144 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/ps.c       |   2 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |  32 +++-
 drivers/net/wireless/realtek/rtw89/ser.c      |  10 ++
 13 files changed, 391 insertions(+), 41 deletions(-)

-- 
2.25.1


