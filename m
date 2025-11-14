Return-Path: <linux-wireless+bounces-28947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D16C5B746
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623D13BDF84
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02672DFA3B;
	Fri, 14 Nov 2025 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PYd3dkco"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1D2DC338
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100133; cv=none; b=PxHrGOUsXJHE7wQcdmv1Gps+++aZoYabA87sr9vKgw59dl+Mxh8/KB/8XiHrorotUw1/ELj6kGkNy6SFKHIQcUoGabvA6GR0i8BSydkUMbLy9cU4NIW/tEbEAnlvxn+sZyZoVYcAsnmV3j5nRKKoYDry8hDfoj4hOV7YK9k/TcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100133; c=relaxed/simple;
	bh=iVMUr+Z3V/e7O/T+YKnUhCdiyozbYzsptXtwKZgTd/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bwh+Vx5brrgDpA1VXLPp21E7GL/90tyhfGie/3ex4ZK+mN/A5feuR+lk+9o9vyk/A19VOaR1nKHEKZ4dw2EADbW6pJ5T8gWRJyklWPpJevVoRyovFrRYnVjhwBZgXIiEI5x8fM3IdHO/z/KdsCMRA5OXrVe03oMpCqHb+hlRZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PYd3dkco; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE624Qz81036435, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100124; bh=45Ww8zazqkFIRbnLkQ2A1BHPuINbsMIAh76VHHDDbCc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=PYd3dkcoZtZw2vjGXHZ8HnykWWhH3xo0vy8KiwNTvwzc9aYzxRFTtmO+Q4z5MddFX
	 FaQtW+N7hZsfUCR/Wp7agIrHiL+G1NZhPHYCEE15aYM7V69Gf+4vT1BLo3Ui4PmdRS
	 r7wOx/XqYjl+Lmk6O+6LMX8QsFZpxefxCXoGqjMWqlTpWWU/pdikqyU1j1mxkdDLCr
	 5Xb+ZLFVSeANiCuNWm6uedbujry9E0/W87Yxg9iYOGIpXHCAgEkFZtjfUoGbw8zi7t
	 ONHf1B5GVPLt13R46el5GGNY70Wj1lX+p6Ai9rAMl+361WlzP/saNPAp10U+8Oo1bV
	 QbcaihaRJIWEA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE624Qz81036435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:02:04 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:04 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:02:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 00/14] wifi: rtw89: update common flow related to FW, MAC and PHY for coming RTL8922D
Date: Fri, 14 Nov 2025 14:01:14 +0800
Message-ID: <20251114060128.35363-1-pkshih@realtek.com>
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

v2:
 - patch 6/14: use rtw89_write32() to write R_BE_SECURE_BOOT_MALLOC_INFO
 - patch 9/14: add missing '\n' to debug message

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


