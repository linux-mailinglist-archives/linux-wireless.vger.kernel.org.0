Return-Path: <linux-wireless+bounces-19829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8555A5405C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 03:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB5518914A5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 02:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0930AEEA9;
	Thu,  6 Mar 2025 02:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QuMN1fRj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18EBE46
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227124; cv=none; b=NWDDXL5lrPRuq0/zuQE19Q8ed3OVRQBoZM0xVRwskk3QMxdiABNUPjzOx31vxwDk0UUXe4Gf58KtodP2ykzoaTT5Q0WMNQDFELvAwlZ2tk0IylQaKX8JZL0WNuzpbp9VP6Qc0Y5jD66b7YhLFrYdAJql7fe7bNtyzeJMfSWbzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227124; c=relaxed/simple;
	bh=Oth+LSB+/1XuCxw1L0rDqk3lUR8ffeoLvi8TcqqGsF8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EpBZQrZxlf3F1HwmaL4yC+TGn3uCUKQuHqshJeZuX+jnNkV21b/okmw7pHijIgqIrPDRNEsiETQLhuXZae1YRSXjQeSadzK/oluWJp9HA5oKNxmgyo3X/hK+zDhkp/owBg8zBTMbOC3N4dnrb0kUIrnnmkEeQc77PHdvoVAXqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QuMN1fRj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5262Bx5zA2495354, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741227119; bh=Oth+LSB+/1XuCxw1L0rDqk3lUR8ffeoLvi8TcqqGsF8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=QuMN1fRjA5MBQ61QxATGEpinovwk7ARwVNTft8koqXBrXmMYJgPljz6FKq5u3gD+h
	 eqrR82rl8AYEFfstqOCFhhyvG4kZetXFByVlw1auHCjkyt8HxzjyW+qR7vdKsinnIj
	 sqaPwAN7XDSGl2q0huWI1TXTEhqEq9w3ooOIFzx3AG8IeBoiu2ueCK60QUdwJBphBi
	 UKoLJGgcgfQ5VuCadiO43IPQ1q7fUie3HNLgbpK0fXYXwSXt9PeNaMs3THK5iLKGRx
	 HZI4XSdb09Awzm64P7WIO+wvn31sHigPxrA64+w6ga8kZAh0yLq7Lmadhyu3DWLbKs
	 pHgckIc/JIwKQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5262Bx5zA2495354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 10:11:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 10:11:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 6 Mar
 2025 10:11:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>
Subject: [PATCH rtw-next 0/5] wifi: rtw89: refine TAS and DAG
Date: Thu, 6 Mar 2025 10:11:39 +0800
Message-ID: <20250306021144.12854-1-pkshih@realtek.com>
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

TAS (Time Averaged SAR) and DAG (Dynamic Antenna Gain) are mechanisms
to use higher TX power under regulation to get higher performance.
Refine them by first four patches.

The last patch is to modify MAC register to resolve interoperability
problem with 11ax AP.

Dian-Syuan Yang (1):
  wifi: rtw89: set force HE TB mode when connecting to 11ax AP

Kuan-Chung Chen (4):
  wifi: rtw89: add support for negative values of dBm to linear
    conversion
  wifi: rtw89: refine mechanism of TAS
  wifi: rtw89: enable dynamic antenna gain based on country
  wifi: rtw89: 8922a: enable dynamic antenna gain

 drivers/net/wireless/realtek/rtw89/chan.c     |  10 +-
 drivers/net/wireless/realtek/rtw89/core.c     |   4 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  30 +-
 drivers/net/wireless/realtek/rtw89/debug.c    |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c       |   1 +
 drivers/net/wireless/realtek/rtw89/fw.h       |   6 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  26 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |   2 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  41 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |   7 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  32 +-
 drivers/net/wireless/realtek/rtw89/regd.c     |  27 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  |   6 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  55 ++-
 drivers/net/wireless/realtek/rtw89/sar.c      | 369 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/sar.h      |   5 +-
 drivers/net/wireless/realtek/rtw89/util.c     | 215 ++++++----
 drivers/net/wireless/realtek/rtw89/util.h     |   8 +-
 24 files changed, 658 insertions(+), 195 deletions(-)

-- 
2.25.1


