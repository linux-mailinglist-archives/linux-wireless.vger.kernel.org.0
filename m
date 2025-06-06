Return-Path: <linux-wireless+bounces-23782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02671ACFB10
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 04:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB116F317
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 02:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9001CEAD6;
	Fri,  6 Jun 2025 02:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IOlbOQ/J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBA29A2
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175406; cv=none; b=H2Y1mhUz3PVppz2jIxGLF++MG6Z4sAwthL+7E0wSe4w6d7sM3GpTQxJveBMf4IclMjsQgGiDvBpLFsHS9DpsKUgfC0pAP8pX1HZ8aiRpGE9lhCk9SnVA5ZzOlRkEGiVr8XiD+MMu6a8lM7j/9YI2/Lxeuwt22eqjCzDbUqOfWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175406; c=relaxed/simple;
	bh=AGg4Df5sjPwv+T5Fb0u7eTQphblPMapd0wjg9XkxCWc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IwBbpxl2JKHKZSFL4U36tn7/XivHmFDPGASMvykOOxx3pyMtvDX5EodPznYK97u3O+rC2TADZYk9griS3G6b6HHDH0wStfKUMt+D+ESnHSDoaBaVMohVpgo9+14AnoiDMiXq69D0ydchd+3QEw3Wfvu6X4DvdzBLEKD1dnBFKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IOlbOQ/J; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55623LoH42620760, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749175401; bh=3CObNDdWOiXHMfTLzTZsjmENtHYVEQP9uP+Jz/UcGdo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=IOlbOQ/JaxPzR7G2369FURw7TqQTIZCyw73dhWbD/6lONKPDvUEHsAdsWRlLoEV1v
	 0UPAJ1EDXKy9VpOPJEyYTic9P9vxi93E++Jx1p65gtrovEK7vO/8S8fMNCVUXpYYjd
	 BAt594/DGeqhPtwPVoYV8cXwoDa+zq1x965yp74Qnt+idC0YhKKmRWffGdv1bj15JV
	 WCVkucJUijfvElsjpYGSCQua8+wqIpmCWypQSdWCNinmIEiNAaPvhPo0o4WOBUXYU3
	 LPNz+BSdLF3aEjZWSaE2S0m06r9JcxCNPm3qu3fTm8ae9z3qidhQYzDDwE9mTXjZ9x
	 33C45r74KB9tA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55623LoH42620760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 10:03:21 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Jun 2025 10:03:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Jun
 2025 10:03:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 0/6] wifi: rtw89: update firmware features/commands/events
Date: Fri, 6 Jun 2025 10:02:56 +0800
Message-ID: <20250606020302.16873-1-pkshih@realtek.com>
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
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Update firmware commands/events formats, including RF TSSI command, IQK
command, WiFi role event, and RF channel info for LPS, accordingly
for coming firmware. Also, add feature of beacon loss V1 format for
RTL8852C.

Kuan-Chung Chen (3):
  wifi: rtw89: 8852c: increase beacon loss to 6 seconds
  wifi: rtw89: add chip_ops::chan_to_rf18_val to get code of RF register
    value
  wifi: rtw89: 8922a: pass channel information when enter LPS

Ping-Ke Shih (2):
  wifi: rtw89: rfk: support IQK firmware command v1
  wifi: rtw89: mac: add dummy handler of MAC C2H event class 27

Zong-Zhe Yang (1):
  wifi: rtw89: fw: add RFE type to RF TSSI H2C command

 drivers/net/wireless/realtek/rtw89/core.h     | 14 +++
 drivers/net/wireless/realtek/rtw89/fw.c       | 92 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       | 22 ++++-
 drivers/net/wireless/realtek/rtw89/mac.c      |  1 +
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/ps.c       |  2 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 45 ++++++++-
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 52 +----------
 13 files changed, 183 insertions(+), 51 deletions(-)

-- 
2.25.1


