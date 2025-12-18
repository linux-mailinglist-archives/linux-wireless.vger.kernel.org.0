Return-Path: <linux-wireless+bounces-29881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A533CCA7AC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 07:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4B6F300BB9E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 06:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20B2322B76;
	Thu, 18 Dec 2025 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vQ0ioHu5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70E320A34
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039494; cv=none; b=I9G2c6glv8RPrmQ1xe5CYPBIoY1ZQ0IYtKm/3vWePknH3DaAeqBoRWPYmrJMP7u/62DZnllj2ZKJpBw7oUEkw7Bvh1vqH4d1utZcTPwrH0T4pQO/HTHjdFOejjzE9SQuNFbHteClv7KJWtq9DhUtQFfjc0bMukhuZZt1MbnWlIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039494; c=relaxed/simple;
	bh=2HkOwa2Qo3nJtB1iQ+q/mlaldyhHuYs6S9aFtQTAves=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I971KQTsqulFrM83+iPovESUZutGnCRIbAnIJ5iuYmt+aK035u9rqbVx+TpJkuk7UlUJSyCVpEF9G1dmcNvVhfVuyxVgzbJDXygEpIiOW4GC2PEqFuuhmFk7HCwlfZaputoH4URv7cM815+p+5HeVboYO5/XYYJTi1KoFjZ4Crw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vQ0ioHu5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BI6VOAQ03322934, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766039484; bh=nVi/s94Dco/LCIlISCd00l/eP6yzn8LUy9xArFouDdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=vQ0ioHu5tjGApkQmqjzFB52sqi0puPlsdkjz4P4pW8ZMHG7c52vx8X5n8m6uEMiy3
	 PZs8/YHcl9xpXzz4SDu0hnmBmCT/sTtl9ZCKBVyUJu+2Y7yPaYRq8COtyjmpQ7bBuy
	 e9wQykLtKo0AvW5SItcalSondkbxt0sbCzT+9Ac2CuvL1uB5BcUryeMDGMje6ZAstv
	 IA/NGxCAJGfJOxBM8z1VdgjCP595/VgtFB+0KwoXlQGkkuooqhS53v/L93ZH6lnwcm
	 lqwT1bE5xOt+yF64wQXEmTmq5FgsaoftrknjcMKqFcXI15F/sfgCSh4iCuYzKR7ZRk
	 x2gTLkEeikVRg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BI6VOAQ03322934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 14:31:24 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:31:24 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:31:24 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Dec 2025 14:31:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 00/12] wifi: rtw89: refine MLO, MCC and SER functions
Date: Thu, 18 Dec 2025 14:31:05 +0800
Message-ID: <20251218063117.26278-1-pkshih@realtek.com>
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
 drivers/net/wireless/realtek/rtw89/debug.c    |  79 +++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       |  12 ++
 drivers/net/wireless/realtek/rtw89/fw.h       |   1 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 154 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h      |   5 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  37 +++--
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 144 +++++++++++++++-
 drivers/net/wireless/realtek/rtw89/ps.c       |   2 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |  32 +++-
 drivers/net/wireless/realtek/rtw89/ser.c      |  10 ++
 13 files changed, 455 insertions(+), 41 deletions(-)

-- 
2.25.1


