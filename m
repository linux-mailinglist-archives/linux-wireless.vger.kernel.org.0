Return-Path: <linux-wireless+bounces-10716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B9B94275D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 09:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FAE28448C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 07:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7321B18B495;
	Wed, 31 Jul 2024 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jiYimF4p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0B16938C
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409532; cv=none; b=TOcmWZUc4POI3nwSD8QvvMnxAQviQRl2tZXs9fC/5T7wHFQ+ZIWWZgcnFOUeUMX3ohaiURtW0xCjPM/fGwa6u+M0zLIhfuqw2JHJUiE+bJVikch49QmgAaZU8a5ddPchXJEyTNZyUuE2EF9yFkGiq8HmRU4Ztdw7Wc0lDdiFbTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409532; c=relaxed/simple;
	bh=0PE3u7JAeR0lh4nwvl4uxEGBcvAWU2cVVw2VGYIZDMM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QJXxEvTDnuqe71kN5ZEdu6+MA/w5LbeXKqgvDoN6Os9wMTohYv+K7eBIEvu8si6/DbNWFIKv2+cEHHPwEV8rPkn3PI7yjcsqFLHTsdJFAFlsQOmYCPNApU+5XOBmQAIuUBEdpl8h0xevuKAaqedHW6GNCUm++sfqipThtNn7uCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jiYimF4p; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46V75Pq742075350, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722409525; bh=0PE3u7JAeR0lh4nwvl4uxEGBcvAWU2cVVw2VGYIZDMM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=jiYimF4pzCA+OFyYwq2D+/xFh3ETsQnGpQ9isDUIZogjJFh74einNsqV1mDJWtfPK
	 P6QeeNM5c8onuUI09tXaBFaIrS8sqBnH+MOvw7iPoPMDVSGKlqnbmUEpeZmPs5+eyZ
	 UiKvTpMxDFeINqQzwHv0ygsj6kWVSbj2d8Qr2yr0chbBiBojewfQb4v3VKmGIQBzfD
	 bbVtRTcys9sA39XLKQ7SJNwsWOo4q2XKUIO/tVUz5PRBivfXwsvjwvaI6PTI8HjCGK
	 JK1d9SYHo7IcQnpobb0SlELPIxBvynLJANN7FB6YD0qyBWzz3qZZnhFyRjR1G1g6km
	 ka2LoNqS3n66A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46V75Pq742075350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 15:05:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 15:05:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 31 Jul
 2024 15:05:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH 0/5] wifi: rtw89: increase 8922a firmware format to 1 and support HW encryption for unicast management
Date: Wed, 31 Jul 2024 15:05:01 +0800
Message-ID: <20240731070506.46100-1-pkshih@realtek.com>
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

First two patches are to support new firmware command formats, so needs
to increase supported firmware format to 1, which old driver will not
use this kind of new firmware.

Newer chips RTL8852C and RTL8922A can support unicast management encryption,
enable them accordingly by patch 4/5.

Other two patches are to fix issues we found during testing.

Chih-Kang Chang (1):
  wifi: rtw89: avoid to add interface to list twice when SER

Dian-Syuan Yang (1):
  wifi: rtw89: correct VHT TX rate on 20MHz connection

Kuan-Chung Chen (2):
  wifi: rtw89: 8922a: new implementation for RFK pre-notify H2C
  wifi: rtw89: add support for HW encryption in unicast management
    frames

Po-Hao Huang (1):
  wifi: rtw89: 8922a: Add new fields for scan offload H2C command

 drivers/net/wireless/realtek/rtw89/cam.c      | 12 ++-
 drivers/net/wireless/realtek/rtw89/core.c     | 29 ++++---
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 84 +++++++++++++------
 drivers/net/wireless/realtek/rtw89/fw.h       | 19 ++++-
 drivers/net/wireless/realtek/rtw89/mac.c      |  7 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  4 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  7 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  5 +-
 drivers/net/wireless/realtek/rtw89/util.h     | 18 ++++
 15 files changed, 147 insertions(+), 46 deletions(-)

-- 
2.25.1


