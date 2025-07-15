Return-Path: <linux-wireless+bounces-25432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A34DB04F85
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27DC178D96
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 03:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0802D12E2;
	Tue, 15 Jul 2025 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ib6miPSB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1828D836
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551610; cv=none; b=gLM8uHEkQBp5trMdfSeVNp0y3VFoWpCpOhSrnRa52PSP+TQ9NNHtUSUUGKtkJ0130UOtDlayktE48LY0livPT6lTTA9sYKRBRfzilWlEdmc5P+FUyhF7wIVeiQDG8JS215GFoIXqW+sxzLRvqsTKcMDpB5K8l9oFamnfN+aOMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551610; c=relaxed/simple;
	bh=70JHEAaepH2XpOLMLIGhW8ghuHLWG94tzbxofTy23Mw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KmjRQNyRIDaCrDMQAbVNUmE0YpXSI6aA25eZQIFVyR2WHexB09c1ExBypylf+W/gnvhJnII1qI25uqWsM7IvfNCib+k4F5VQZUAh4rRg1Uddld9fjDaqmc7Nse6yOXlBkNdeEXmdW8K3khSm+aoX7C/3RZD9vuNa4kEfojTwMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ib6miPSB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F3rOLM13971435, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752551604; bh=kj8KMi5xCaerdqmQBuf3iCPU9u8EVddWKFWnXey6Oec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ib6miPSBUDroe3qcoLlusTBFrm/xiNdL6JqmvjUIe71Dtf9rh1Hqf+mNweXp+K1L0
	 sEMOjLQE7sfGTbQP5Es+vcmBXv2nKeYNP24+gHaq3WEq6LcfUTED6cvMDiE6dmhdpo
	 9QRLLBSEYBZgnf+IWYEuRBvjFHoSjnZi2dGLTx/8ithxegjFPLIghLu8ocZ1IjepsY
	 X+tkXl9qK5EoZVaKx6VeW2sgKPl9Chl1hZ0vq4Cmb5HDy/ZoJF4g183zJzJIMU2mpr
	 PBx2JV5VtylVH78s/VcH8GcCBarj2nrprKSHDnGDyvk5hJZDxqrJqOd4xAafbIyFBV
	 TPkhwHVqWOIuA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F3rOLM13971435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 11:53:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 11:53:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 11:53:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 0/5] wifi: rtw89: apply settings to improve robustness
Date: Tue, 15 Jul 2025 11:52:54 +0800
Message-ID: <20250715035259.45061-1-pkshih@realtek.com>
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

First two patches are to reduce/detect hardware errors. The third is to
fill preamble puncturing setting for EHT along mac80211 data. The forth
is to prevent events of previous scan leak to next scan request for
uncertainly late event work. The last is just to avoid Coverity warnings.

Chia-Yuan Li (2):
  wifi: rtw89: trigger TX stuck if FIFO full
  wifi: rtw89: mac: reduce PPDU status length for WiFi 6 chips

Kuan-Chung Chen (1):
  wifi: rtw89: dynamically update EHT preamble puncturing

Ping-Ke Shih (2):
  wifi: rtw89: purge obsoleted scan events with software sequence number
  wifi: rtw89: check path range before using in
    rtw89_fw_h2c_rf_ps_info()

 drivers/net/wireless/realtek/rtw89/chan.c     | 47 ++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  4 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 76 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       | 19 +++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 10 ++-
 drivers/net/wireless/realtek/rtw89/mac.h      | 25 ++++++
 drivers/net/wireless/realtek/rtw89/pci.c      |  4 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 drivers/net/wireless/realtek/rtw89/wow.c      |  2 +-
 14 files changed, 189 insertions(+), 4 deletions(-)

-- 
2.25.1


