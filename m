Return-Path: <linux-wireless+bounces-28881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DD8C557BF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 03:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823F83A61E2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 02:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738AA25BEE8;
	Thu, 13 Nov 2025 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UULpwZRq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C1253B73
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002624; cv=none; b=ei80JW+7rQ3zVfPExNi4ls2fyvXhpUbd2HqIYfx1AUU5NuqsanKhOzXQINsg3UBGJsfW3tdh6SqUp5n+v60OqnJk/BKl0vIvaE2+9g4BF3mvoYbxWj68DqTXSctfz9fHHCpHnLE8ykD8IV/sRgs/tOtGevqlJAn4bfbHVHyA+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002624; c=relaxed/simple;
	bh=F8BoFLiHPlrfb0cLt4B+9X/zw+4rzmhsdLuvEPnCfWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ogeFe2F30EEWCaqHY3PE7AnoPcMPTtL/RCvIjXPlKhgW+ITUSldlYTzyOQE4qdKtmzlx9nL+3jbdYY1X/KZjKB+KQKdh1FlhU1xQxZy3cdBTTODgHyxKDNfA/tP363St60jC1I8OtttvbIFNrpRaEe6qDQNSWDKppPxrmAMoohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UULpwZRq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD2uvbcF2839303, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763002617; bh=SD06LT3lrTifTa6DNtyzomlzdluOG30wM44oKdIzeWc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=UULpwZRqTGzQ7RoOHeqroLAQeqjFziJD4ucA+SUOAaoKq147DvZudu2UC0EkDfl2D
	 nSvI4ZRM0qAO4sk9nCWxvsGg9QYJXVYO/XynuIcSvOJtQEjkoc1X8dU2BDMu9wWv1T
	 VAT9iMKzjMiGK8FhH/nyZ/OjDVaJAAIdWcVGGRjx0xercUj1GiHmT+rAxHWfWBtFhx
	 dPlBIBt/9CyvA4LG0QcKp8eUkgZMKQylCz2F1L6OFVfYBHDnD9lAaHl53mp7LTw+r4
	 bA10uX/TL3MojQs44LGrneR2pnBISe13w8E8oyhtUyl62N6T8431447n1gWS9y97Xw
	 qJ9UE3dULy9Gw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD2uvbcF2839303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 10:56:57 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:56:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 10:56:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH rtw-next 00/14] wifi: rtw89: update common flow related to FW, MAC and PHY for coming RTL8922D
Date: Thu, 13 Nov 2025 10:56:06 +0800
Message-ID: <20251113025620.31086-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

During development of RTL8922D, the FW, MAC and PHY are changed, so
prepare this patchset to make changes accordingly. Keep the same behavior
for existing chips.

Chih-Kang Chang (3):
  wifi: rtw89: flush TX queue before deleting key
  wifi: rtw89: update format of addr cam H2C command
  wifi: rtw89: correct user macid mask of RX info for RTL8922D

Ping-Ke Shih (11):
  wifi: rtw89: fw: part size to download firmware by header info
  wifi: rtw89: mac: separate pre-init code before downloading firmware
  wifi: rtw89: phy: calling BB pre-init by chips with/without BB MCU
  wifi: rtw89: mac: remove undefined bit B_BE_PPDU_MAC_INFO
  wifi: rtw89: mac: update wcpu_on to download firmware for RTL8922D
  wifi: rtw89: phy: consider type 15 in BB gain table
  wifi: rtw89: phy: ignore DCFO if not defined in chip_info
  wifi: rtw89: fw: print band and port where beacon update on
  wifi: rtw89: align RA H2C format v1 for RTL8922A
  wifi: rtw89: fill addr cam H2C command by struct
  wifi: rtw89: add addr cam H2C command v1

 drivers/net/wireless/realtek/rtw89/cam.c      | 173 +++----
 drivers/net/wireless/realtek/rtw89/cam.h      | 446 +++++-------------
 drivers/net/wireless/realtek/rtw89/core.c     |  30 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  23 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 101 ++--
 drivers/net/wireless/realtek/rtw89/fw.h       |  20 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  41 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   5 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   9 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |   6 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c   |   4 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  24 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 +
 drivers/net/wireless/realtek/rtw89/txrx.h     |   1 +
 drivers/net/wireless/realtek/rtw89/wow.c      |   6 +-
 21 files changed, 417 insertions(+), 479 deletions(-)

-- 
2.25.1


