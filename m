Return-Path: <linux-wireless+bounces-3312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 976AA84D7C6
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 03:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8722835E7
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 02:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283461C6A8;
	Thu,  8 Feb 2024 02:29:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AF81C68E
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359388; cv=none; b=bNtG3e+m6ieuFE8lEBLmTGDfEO202GES57BuP72UuKTrCpH4sLo7HIU6LwqnMT1ba2ywRM8l2tMONSSfjcJ8qtekYnL3BkHvYjFw310ELvs5SDfKXKjF+0GQPqfSwrulDim2ZO4CITAzmJmokNEndm6ghIfHFln/SyPhhPRqP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359388; c=relaxed/simple;
	bh=7PtBnJMb+F5FuWk7tBVqWUHBJger1YXTkzMOJy/L9gA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jTL5LDsaisc0alHKLF5NsARjUP0UgIYHRTsJAeAEUI5wgyal+oxzVOegZ5A6ni73ACSU9qudyzCLm7vA6efM02WQkBrX47U/s0z316MRjYRv0khebP6kheJzxsaQBHSh/NlFenmyZbtux6ZWdwJN4fSw6j6aLQvQgJLDZ3g7leg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4182TaH62191857, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4182TaH62191857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 10:29:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 8 Feb 2024 10:29:36 +0800
Received: from [127.0.1.1] (172.16.17.45) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 8 Feb
 2024 10:29:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/11] wifi: rtw89: enable DBCC for WiFi 7 chips by default
Date: Thu, 8 Feb 2024 10:28:46 +0800
Message-ID: <20240208022857.14379-1-pkshih@realtek.com>
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

We are going to implement MLO for WiFi 7 chips, so enable hardware DBCC
support that turns on MAC-0/-1 and PHY-0/-1, and configures MAC quota
buffer as desired. During these development, we found some registers are
not properly set for MAC-1 and PHY-1, so correct them along with this
patchset.

Chih-Kang Chang (1):
  wifi: rtw89: 8922a: implement AP mode related reg for BE generation

Ping-Ke Shih (8):
  wifi: rtw89: correct PHY register offset for PHY-1
  wifi: rtw89: load BB parameters to PHY-1
  wifi: rtw89: mac: return held quota of DLE when changing MAC-1
  wifi: rtw89: mac: correct MUEDCA setting for MAC-1
  wifi: rtw89: mac: reset PHY-1 hardware when going to enable/disable
  wifi: rtw89: use PLCP information to match BSS_COLOR and AID
  wifi: rtw89: 8922a: correct register definition and merge IO for
    ctrl_nbtg_bt_tx()
  wifi: rtw89: change qutoa to DBCC by default for WiFi 7 chips

Po-Hao Huang (1):
  wifi: rtw89: reference quota mode when setting Tx power

Zong-Zhe Yang (1):
  wifi: rtw89: differentiate narrow_bw_ru_dis setting according to chip
    gen

 drivers/net/wireless/realtek/rtw89/core.c     |  8 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  4 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 58 ++++++++----
 drivers/net/wireless/realtek/rtw89/mac.h      |  5 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 93 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 42 ++++++---
 drivers/net/wireless/realtek/rtw89/phy.h      |  1 +
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 19 ++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 36 ++++++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 37 +++-----
 10 files changed, 242 insertions(+), 61 deletions(-)

-- 
2.25.1


