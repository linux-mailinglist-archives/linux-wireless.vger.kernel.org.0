Return-Path: <linux-wireless+bounces-6244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE18A2DD9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 13:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407DB2834CE
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB38A5577C;
	Fri, 12 Apr 2024 11:59:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810E3FE55
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923152; cv=none; b=lKD7FY/f7tBhWnrEfCpaYYoXPUM6ezsHr0oSqtSGT7uG3TL346EOWz3J6y9Esc0ovj7n1lHRbwkIYL8V+Yne6XwuJUissZQO7bD9oQikkDGccvF0WAhJbGookjNmqrPBKKt8exscrhp5PKQOCMTUJ9QFkPbyd1a+HW6cfTryxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923152; c=relaxed/simple;
	bh=BNVTjBVq/+6sBmy1Pq+QSVOZCWqw0oouE4CNAHMd9w0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wg1L0r7GYQk80ZkaCQW4HnYsNaj9ilHOZEdH9IRQCrqpnorZWtxXaSeCa9HtLqy8kD0bSkoQTS5WEQFKoxjNvrquSZDYv1o7JhediCDiz9FSJJiSXgNtrN05YFNCbEBqhyL5rpbSuznuTrWoRvGvUsdEyfOaODOhqo+4BGAyFAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43CBx7TF12092958, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43CBx7TF12092958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 19:59:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 19:59:07 +0800
Received: from [127.0.1.1] (172.16.17.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Apr
 2024 19:59:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 0/8] wifi: rtw89: configure 5.9 and 6 GHz channels and power type by BIOS settings
Date: Fri, 12 Apr 2024 19:57:21 +0800
Message-ID: <20240412115729.8316-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The regulations of 5.9 and 6 GHz channels and power type are ongoing to
define, and certain platforms don't get certifications for certain channels
or 6 GHz SP power type. To control these platforms working on expected
channels and power type, define control fields in BIOS to restrict.

The change of power table is large, so split it into patches 3/8 and 4/8.
We are planning to move them into firmware file like WiFi 7 chips.

Zong-Zhe Yang (8):
  wifi: rtw89: sar: correct TX power boundary for MAC domain
  wifi: rtw89: fw: scan offload prohibit all 6 GHz channel if no 6 GHz
    sband
  wifi: rtw89: 8852c: update TX power tables to R69.1 (1 of 2)
  wifi: rtw89: 8852c: update TX power tables to R69.1 (2 of 2)
  wifi: rtw89: regd: block 6 GHz by policy if not specific country
  wifi: rtw89: regd: extend policy of UNII-4 for IC regulatory
  wifi: rtw89: acpi: process 6 GHz SP policy from ACPI DSM
  wifi: rtw89: regd: handle policy of 6 GHz SP according to BIOS

 drivers/net/wireless/realtek/rtw89/acpi.c     |   47 +
 drivers/net/wireless/realtek/rtw89/acpi.h     |   21 +-
 drivers/net/wireless/realtek/rtw89/core.c     |    3 +
 drivers/net/wireless/realtek/rtw89/core.h     |    4 +
 drivers/net/wireless/realtek/rtw89/fw.c       |    4 +
 drivers/net/wireless/realtek/rtw89/regd.c     |  156 +-
 .../wireless/realtek/rtw89/rtw8852c_table.c   | 2616 -----------------
 drivers/net/wireless/realtek/rtw89/sar.h      |    4 +-
 8 files changed, 206 insertions(+), 2649 deletions(-)

-- 
2.25.1


