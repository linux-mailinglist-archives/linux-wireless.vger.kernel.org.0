Return-Path: <linux-wireless+bounces-30213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D87DCEBA1F
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85C1F3041A5D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7645315D49;
	Wed, 31 Dec 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="l4y5FhQu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36D2E62A4
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172032; cv=none; b=qxlI8c9TeSJ5Tf2HWcPaVSxDqvneoIHeC/oB0/SD1t2Mypw2ySs9kHOKlAeXW2rhRxmXMihILWKVa69/SfSKQbIoTgLG3pdUPzq/cT7iNtlFr3UkzlQNrjWkNFQCXLikDKqh4XmGhfReaZuVV9jyINyKjQ3UyoyaQW/Dj4xvnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172032; c=relaxed/simple;
	bh=Rl33aeNxJyKLSDjtBLF/OtWTFoa0m64HOhiRTCeGPKo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mM2uATGea5tiyg6tGkUCKj9LVNuxHZe3N+HGlOFWFYH3Wr/neWtWk/ur+iYHrNLbCIOBOqsuLng9RBvjOe7r4OadPrbQn2U6MrYpbyQRKZS2yd8B2wWzP1qt52gaHYJaWg3BytyfJuOE+04+5pI78ehj5g59ub3cAa0fnCs/sUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=l4y5FhQu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV975uaC880518, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172025; bh=d8Mb753+b89y7bM0jArS2Zn0VvAgZVKYzdrMe5nYxEU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=l4y5FhQuBNh+5uTb2+rS34K415dcOBv2PerjXAwOjOUZUMsIaVPOfL1S7U5Ua5IOh
	 KrEDNtek3EBA/iNOhmc9a47uAd/cBCCLtBxo4s/fm9x1GZYPV+F2NHNUburmMxc6/6
	 rHxKmQWUCfbatcxXO+B9QF+0iu0XCtLqLjRlj/BjmwR1gr3E0r0vpdLaS1J/8XDA/r
	 NcEj4sARAb1wnVDKPj+TlEbHJvzkAq/YgAVC4icQLbDCnv6KNS57hCrhZYWhWUds4Y
	 DypVX1K3RUmAOUqXx5gYS4cT4Rj3BXABRxzXuucd9vQVlVmPvJTMQ3o2aP06s0pH+7
	 1PP2M0/WEkojg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV975uaC880518
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:07:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:05 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:05 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:07:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/11] wifi: rtw89: handle changes of RFK pre-notify
Date: Wed, 31 Dec 2025 17:06:36 +0800
Message-ID: <20251231090647.56407-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The RFK (RF calibration) pre-notify is a H2C command which carries channel,
chip information and etc to firmware, and then RFK in firmware can
configure proper registers for corresponding parameters. However, there
are many format versions, add to support these firmware.

Patch 10/11 is a potential issue found by Fuzz test.
Patch 11/11 is necessary for a RTL8852BE variant, which RFE type is 5.

Chih-Kang Chang (2):
  wifi: rtw89: rfk: add rtw89_fw_h2c_rf_pre_ntfy_mcc for new WiFi 7
    firmware
  wifi: rtw89: rfk: update rtw89_fw_h2c_rf_pre_ntfy_mcc format

Dian-Syuan Yang (1):
  wifi: rtw89: 8852b: refine hardware parameters for RFE type 5

Kuan-Chung Chen (1):
  wifi: rtw89: fix potential zero beacon interval in beacon tracking

Ping-Ke Shih (1):
  wifi: rtw89: rfk: update RFK pre info V2 for RTL8922D

Zong-Zhe Yang (6):
  wifi: rtw89: pre-handle RF calibration on link when needed
  wifi: rtw89: fw: change FW feature map to a BITMAP
  wifi: rtw89: fw: introduce helper for disabling FW feature
    configuration
  wifi: rtw89: 8922a: tweak RFK_PRE_NOTIFY FW feature configuration to
    align handling
  wifi: rtw89: refine mis-ordered entries in FW feature table
  wifi: rtw89: fw: change WITH_RFK_PRE_NOTIFY to be a FW feature group

 drivers/net/wireless/realtek/rtw89/chan.c     |  33 ++++
 drivers/net/wireless/realtek/rtw89/chan.h     |   2 +
 drivers/net/wireless/realtek/rtw89/core.c     |  43 ++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  47 +++--
 drivers/net/wireless/realtek/rtw89/fw.c       | 174 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  31 +++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   3 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  19 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  24 ++-
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c |  48 ++++-
 11 files changed, 381 insertions(+), 45 deletions(-)

-- 
2.25.1


