Return-Path: <linux-wireless+bounces-5513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2868910B8
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 02:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1F6B236DA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 01:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A0C3A1CD;
	Fri, 29 Mar 2024 01:54:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAED39855
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677257; cv=none; b=C2Jxn09GOBgy/j2iEO4R6sJUjQQTjqzKmCxVDmyAt8roQAQxpnVoplnEMWLZnxxo53Olmd2yLWJFzFLUbMh1Tzg9umvueN+BcJxJ3ng1Tg2+EAwfv7rj3dD1PzSOslDFJmRTCskEpF1eeNtVWG81u4oKMSF/1PsHH1ynunqC77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677257; c=relaxed/simple;
	bh=91mbm98HWmsv7hU1aB6s5Vzek8PcL85SqRNkaXKyvF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qMRjHkCetEgGVskrYkNVFtWcyQo07TLyHJpY4dVbf2i8Eh9jwjl8pGgjeDE9NIP+C2AqHOlYCFY35PTsT/ftGMzE9s0qjrk93nORm+dHm+W2VnLwG8QhXCQTXgEuciEA50XeaX4CQBUOFlbW0E1nP7T1WxgwrVPeeAtUpME1Q7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T1sCT813183191, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T1sCT813183191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 09:54:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 09:54:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 29 Mar
 2024 09:54:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 0/4] wifi: rtw89: improve compatibility of download firmware and PCI PHY
Date: Fri, 29 Mar 2024 09:52:47 +0800
Message-ID: <20240329015251.22762-1-pkshih@realtek.com>
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

RTL8852BE was reported possibly failed to download firmware during stressed
suspend/resume test. Add retry mechanism to avoid this rare failure caused
by abnormal hardware state.

For RTL8852CE, set PCI PHY parameters to improve compatibility to avoid
card lost during stressed reboot test. Since some parameters are only
needed by certain platforms, add quirks for them.

Also, update 5.9GHz TX power table of IC for RTL8852C.

Chia-Yuan Li (1):
  wifi: rtw89: download firmware with five times retry

Ping-Ke Shih (2):
  wifi: rtw89: 8852c: add quirk to set PCI BER for certain platforms
  wifi: rtw89: 8852c: disable PCI PHY EQ to improve compatibility

Zong-Zhe Yang (1):
  wifi: rtw89: 8852c: update TX power tables to R69

 drivers/net/wireless/realtek/rtw89/core.c     | 18 ++++
 drivers/net/wireless/realtek/rtw89/core.h     | 10 ++
 drivers/net/wireless/realtek/rtw89/fw.c       | 27 ++++--
 drivers/net/wireless/realtek/rtw89/pci.c      | 91 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h      | 13 +++
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../wireless/realtek/rtw89/rtw8852c_table.c   | 90 +++++++++---------
 .../net/wireless/realtek/rtw89/rtw8852ce.c    | 23 +++++
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 11 files changed, 225 insertions(+), 51 deletions(-)

-- 
2.25.1


