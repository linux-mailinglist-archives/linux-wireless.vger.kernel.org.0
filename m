Return-Path: <linux-wireless+bounces-3896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FEB85F191
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 07:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DF4283EA4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD2FF9D8;
	Thu, 22 Feb 2024 06:44:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25965D533
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708584241; cv=none; b=DFHlivdwknEeqw5n0tk0ITyzKA9c8kWg5NZ5hfWtNvD0dQBxKHFrZ+xVe6UKUCHRBF6PT+YeoV5rMYJHCR+7CpmCHwO/kV4NSh5HtOWufo0uHDPwLKDqTTgWo7yorrIBZ9wmTjlEgdI8vnqzrAoPZIQOjlv2XCFREAUvUFezJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708584241; c=relaxed/simple;
	bh=4qIOIpMklv7HuxjVC4s82Y3YKR4n1cpF6oPbD9LE2r4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q2UTwUu/mai3FNUxfjfnR22apSwcKEhoVpi1twHg2k1OPex9yIcLmgIj4w+edQdzw6TKXsjO3ES5aTHzw/MzN5ZFihg5eGEQOVn/nUbiB5epsSnxiloepTftjuWQapiw/WkNG59SBJtdaoF7AxU8cLYawNmfS8Af1IxJiLcEEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41M6hkgC71486318, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41M6hkgC71486318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 14:43:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 22 Feb 2024 14:43:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Feb
 2024 14:43:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: rtw89: update scan features, EHT beamforming capability and PCI setting
Date: Thu, 22 Feb 2024 14:42:55 +0800
Message-ID: <20240222064258.59782-1-pkshih@realtek.com>
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

Some missing stuff are found during verification, update them accordingly.

The remaining patches to enable 8922AE (WiFi 7) are BT coexistence and
WoWLAN stuffs, and I will provide patches in coming weeks.

Chin-Yen Lee (1):
  wifi: rtw89: pci: implement PCI CLK/ASPM/L1SS for WiFi 7 chips

Kuan-Chung Chen (2):
  wifi: rtw89: advertise missing extended scan feature
  wifi: rtw89: Update EHT PHY beamforming capability

 drivers/net/wireless/realtek/rtw89/core.c   | 10 ++--
 drivers/net/wireless/realtek/rtw89/fw.c     |  4 +-
 drivers/net/wireless/realtek/rtw89/pci.c    | 50 ++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/pci.h    | 30 ++++++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 52 +++++++++++++++++++++
 5 files changed, 129 insertions(+), 17 deletions(-)

-- 
2.25.1


