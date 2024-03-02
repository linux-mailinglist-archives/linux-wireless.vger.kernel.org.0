Return-Path: <linux-wireless+bounces-4313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759AD86EDA8
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 01:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DAF1F23ADD
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 00:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3F210E3;
	Sat,  2 Mar 2024 00:59:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE6A32
	for <linux-wireless@vger.kernel.org>; Sat,  2 Mar 2024 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341175; cv=none; b=LT8jclxeZ6JQ18dTDcymeJSioBFQh6j4aJEiePUBc+qmWEHQWYPThBc7+2BUQPWK67MngcLoNSZmVOIX8B1vfvoEI3pTgNnsATmEK/NoeAgGQ7xuj7aPkDnytOtPR340tMeuU4OZ8xcf4mf9ZLemmUfcPQQnvI6qIajlUgQCgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341175; c=relaxed/simple;
	bh=QdHmS+q7ejLhMX8OkupYBjW5d3Z7K9guz4FRxBKZzq0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JVwudhhFxk9bqJsXIcFn/IVc5SKoVNwkgKnxpOm4GOnF98YYxp90AChzT9z0BJRRBC2uoG9dY2473P1LBRU7eXAtVxMPw+pdFdcfq1pf2gOVuJIXf0ckgDJBBEcUGoC/Q+TX5qIGK7mDg36RVXjgG69sLSQy9twWBLEeT4sGlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4220xQa252370257, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4220xQa252370257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 08:59:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sat, 2 Mar 2024 08:59:26 +0800
Received: from [127.0.1.1] (172.16.16.155) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 2 Mar
 2024 08:59:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/7] wifi: rtw89: wow: update registers for WiFi 7 generation chips
Date: Sat, 2 Mar 2024 08:58:21 +0800
Message-ID: <20240302005828.13666-1-pkshih@realtek.com>
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

The WiFi 7 chips use different (but similar) registers to control WoWLAN
functions, so update them accordingly. Then, we have basic WoWLAN features
as existing WiFi 6 chips.

Chin-Yen Lee (7):
  wifi: rtw89: wow: update WoWLAN reason register for different chips
  wifi: rtw89: wow: update WoWLAN status register for different
    generation
  wifi: rtw89: update DMA function with different generation
  wifi: rtw89: wow: update config mac function with different generation
  wifi: rtw89: update suspend/resume for different generation
  wifi: rtw89: wow: set security engine options for 802.11ax chips only
  wifi: rtw89: wow: move release offload packet earlier for WoWLAN mode

 drivers/net/wireless/realtek/rtw89/core.h     |  9 +--
 drivers/net/wireless/realtek/rtw89/fw.h       |  9 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      | 41 ++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  9 +++
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 49 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c      | 29 +++++----
 drivers/net/wireless/realtek/rtw89/pci.h      | 30 +++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c   | 64 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/reg.h      | 35 ++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  2 +-
 drivers/net/wireless/realtek/rtw89/wow.c      | 48 +++-----------
 16 files changed, 265 insertions(+), 65 deletions(-)

-- 
2.25.1


