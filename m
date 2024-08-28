Return-Path: <linux-wireless+bounces-12112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D01961EEB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F921F21AC7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 05:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371381547DD;
	Wed, 28 Aug 2024 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="sFJtC+zs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0122D512
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824362; cv=none; b=g229lY6J3tbw/HjRp1WKtk5Au9u8KvSROP+Zsb5PKmt4Ct7cw+Tv5OFfd9/apEq2mhjMdyxh+eTv4XWdtIz5lp08+TEGlXFjCgbRbmjHu5c4rMoKVlY6wnCBScAQ/kitK+f7Tp6LIxfW6EGLq7X19AFGuZ2BObyXzuDp5ZfVu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824362; c=relaxed/simple;
	bh=xi5dd8Cb7c0y/GDkeWz8vp3ZMRGtHXE+iBTQ6/1Ym18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=inmFzIsFA6z02ozHba1B35FqpUM08XJNg+eRsnkCTTBut0nrUQaKX4u/Q4ZyfIZHMkIFXXMClvUU7JPoZR/zwWbbm4nR0gwwk/nInXe60zKs87rkuFlLAITgg+JUfNSmmDWgE0CeGxov6/Lqr+hbknirLApSe2aK2F9bv4tobw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=sFJtC+zs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47S5qaE331895999, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724824356; bh=xi5dd8Cb7c0y/GDkeWz8vp3ZMRGtHXE+iBTQ6/1Ym18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=sFJtC+zsgvbrpCFFTCxEyqEx5s4bXP03zzsFsyP7A4pu4B4+E9LljTP15/AXji710
	 9qWatygGhVZcLO1lXKy5B2MUNhBNdswb9+eA4CcJIV91Xqj8ads/v2IEK0tt3iYhej
	 o8HX9eyZ8GzhP8Jj8cEDNZ/PIPKD249fm1pYZyZ1HpvPQWmcXXYI6IYNdAb/ZEkucX
	 qoFviXQ9pp73fDxTLLTJ2OiReBWCT3BbbGb0m8Zjdj9gU7CS9lJPNH1i+HV0Huyeoe
	 XapKDyS2QHBC6Z7xKIurH2OS8WlCaHex0NI+PC3KnTixDPGU0KjNNkyVpth/SAJpiN
	 f7LhlfeHiC+4Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47S5qaE331895999
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 13:52:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 13:52:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 28 Aug
 2024 13:52:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>
Subject: [PATCH 0/2] wifi: rtw89: refine two PHY features of DIG and RSSI
Date: Wed, 28 Aug 2024 13:52:15 +0800
Message-ID: <20240828055217.10263-1-pkshih@realtek.com>
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

DIG standing for dynamic initial gain is used for receiving coverage.
With better setting, it will have better ability to receive packets.
Otherwise, higher false alarm causes missing packets.

The second patch is to use frequency domain RSSI, which is higher accuracy
than original one. Since TX rate algorithm is also related to RSSI, this
can improve TX performance as well.

Eric Huang (2):
  wifi: rtw89: adjust DIG threshold to reduce false alarm
  wifi: rtw89: use frequency domain RSSI

 drivers/net/wireless/realtek/rtw89/core.c     | 73 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     | 17 +++++
 drivers/net/wireless/realtek/rtw89/phy.c      | 27 ++++---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  | 14 ++++
 .../wireless/realtek/rtw89/rtw8852b_common.h  |  9 +++
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 33 +++++++++
 drivers/net/wireless/realtek/rtw89/txrx.h     | 59 ++++++++++++++-
 12 files changed, 226 insertions(+), 11 deletions(-)

-- 
2.25.1


