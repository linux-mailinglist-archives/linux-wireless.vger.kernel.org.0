Return-Path: <linux-wireless+bounces-30267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3854CEDF7A
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 08:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA3E303A1B4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 07:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8893101B8;
	Fri,  2 Jan 2026 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i0lQG2zm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CB63101B6
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767337751; cv=none; b=NDlVU5VknhZukbhcdITrs0nLvSC/pZU1SQTPuhP0bPfac/cl2MeqKmQ1Jp1GlkmLp6iPyiTtaUL/YxVGZUdKbF4DOjz9n2BsNTUY9fx0YvCMINH28e4AFYvhE9oXbKrD6Hhvb1l9nZcNfivTywRMxUH7NrkoUPE0H/zcQA7H4rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767337751; c=relaxed/simple;
	bh=RNpIxOtn8sxUcgDEkI6NbMX/AUIcKdTFAe4jQ+hHIZ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TvQyhnY+KGwgoyBQyMIm66aD7TsOglpv+pKmGoSpCj5GRlyovuJAgtRuyaNiO+ZG3JGXUV9OQ7meTjk5aAlGD8FHIlznkNsixgBt/hEE1p7ti0ijCaPbwf3LORUZYQPWlPjMoHlqiSdQFSCoj5GmOKIS3SGXZjeA4G1p0KsK2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i0lQG2zm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60278xT02486876, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767337739; bh=lRsOGeIcVNEwYExN9XtkOMpFhi0ztyqPk0bvnw0+qMI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=i0lQG2zmkmiN+p3PXab+8tWB0JzXI9MsK40luVE2e5TJ5A5taEe4SKGOwfz2LXKxX
	 C4ajghxp+Gd9hkWvR+qCtpcwNlDtra2juI/d+Ilpg1ZQed35yRmjbOn2lsUl5neKUu
	 yOrKz7bBtnDzHml9dX4S2VW71IF4TQ4h80ZSpJKgkXMdMl9t82/l7pyr3nNILrZ1/f
	 BYopj5HfS5IJzeFX1XEzO8QtO6XzC9mSiNXuyvd7SBmcEn6d8sHxzD3+LHZ7u/msLD
	 ibGJUc4pR5bpkjmq1S3+VwiinkOZ48O1JTflF5F/FLAo3HrDsyiJ2cFXypy2Tys1Jx
	 G5c6EM2s0r6/Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60278xT02486876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 2 Jan 2026 15:08:59 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 2 Jan 2026 15:09:00 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 2 Jan 2026 15:09:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 00/10] wifi: rtw89: prepare TX/RX WD and D/C-MAC H2C command for RTL8922D
Date: Fri, 2 Jan 2026 15:08:30 +0800
Message-ID: <20260102070840.62047-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8922D use different TX/RX WD (to assist in TX and RX per packets) and
D/C-MAC command format (to assist in TX/RX per association). Add them
accordingly.

Patch 9/10 is to consider hardware AID in firmware element.
Patch 10/10: The RACK (received ack by firmware) every 4 commands are not
             necessary for WiFi 7 chips. Remove the logic.

Ping-Ke Shih (10):
  wifi: rtw89: update TXWD v3 for RTL8922D
  wifi: rtw89: update query RXDESC v3 for RTL8922D
  wifi: rtw89: fw: add DMAC v3 H2C command for RTL8922D
  wifi: rtw89: fw: add CMAC H2C command to initialize default value for
    RTL8922D
  wifi: rtw89: fw: add CMAC H2C command for association for RTL8922D
  wifi: rtw89: fw: add CMAC H2C command for TX AMPDU for RTL8922D
  wifi: rtw89: fw: add CMAC H2C command for TX time for RTL8922D
  wifi: rtw89: fw: add CMAC H2C command for punctured for RTL8922D
  wifi: rtw89: fw: consider hardware AID for firmware elements
  wifi: rtw89: fw: set RACK bit every 4 H2C command for WiFi 6 chips
    only

 drivers/net/wireless/realtek/rtw89/cam.c  | 134 ++++++
 drivers/net/wireless/realtek/rtw89/cam.h  | 129 ++++++
 drivers/net/wireless/realtek/rtw89/core.c | 131 ++++++
 drivers/net/wireless/realtek/rtw89/core.h |  28 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 514 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h   | 171 ++++++-
 drivers/net/wireless/realtek/rtw89/mac.h  |  12 +
 drivers/net/wireless/realtek/rtw89/txrx.h |  22 +
 8 files changed, 1125 insertions(+), 16 deletions(-)

-- 
2.25.1


