Return-Path: <linux-wireless+bounces-10467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 987D093AC3A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 07:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6EA1F213AB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 05:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A726725632;
	Wed, 24 Jul 2024 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="toek9Bn5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16041208D7
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721798803; cv=none; b=qSvfdyCgaYdV5oY5M8gOkr1kSr3D+p9al9FEF8yBy5WxKyCYaSNJCR83LUY/P87r3PXRkhuRev4WuOXGgypbUG1ykx8IeBLNTl5fxuYEMpd6FKr4xq0BHuHJ3OVFU1OAK9YGR1rbmyPBf6BccfYX795L6XMh8YDXIb1ZfsZZowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721798803; c=relaxed/simple;
	bh=wX6G6KX6vw8eiZJceY+n/1p6TS87N8BZSS6j3Lel8N0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WCeXkQ/tkrkljYboK+vxkPwYKlPL+ML9jJeqy0pIDIhIx62s42RTyxt8fB5E9R+1KU3rMi8umKvvtfRXUHm+WwTeQlIhW11YoMpvMZ4FV2uUfbUHIP6Qi07DBhpE2nY6xw1qWyAT5W1dHiCfyF5i0+6RO03Hh22vKbN5Rgy02LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=toek9Bn5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46O5QcOV21894491, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721798798; bh=wX6G6KX6vw8eiZJceY+n/1p6TS87N8BZSS6j3Lel8N0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=toek9Bn5QCDenrEz/PWGArDTRHvmCfSFdLUH/pBNw6qyeBESsK7vPbzNQ4jXk7KDy
	 FkeVNG6F+Q2r/JT6i46zWve+TyaVR85k+edJEZ+8dMfUgqPTT+LnANKDkbs6/4OvP8
	 az+NLhfdtODLcZTDa6b01Y0l0I/B/h/6kO8cgHhBlImWqAyAP7Zn8flmfI0l1nLH7K
	 g6tvHP9+ysra6sMD0tGvQQ/BPMLQBegBNYlsDmmy1P8vrUIx1Oc8Yo0n8f+geHdKB/
	 iA1CRaJw2gpdUWys8DHb5fVQNQC0Nxlv4fm3YqvPw2uXGYXoYi0/0wOqduDKSlquZq
	 HoNL6hL+HVP0A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46O5QcOV21894491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 13:26:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 13:26:38 +0800
Received: from [127.0.1.1] (172.16.23.66) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Jul
 2024 13:26:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 0/4] wifi: rtw89: add features of 1SS EVM statistics and rfkill, and fix of IDMEM mode
Date: Wed, 24 Jul 2024 13:26:22 +0800
Message-ID: <20240724052626.12774-1-pkshih@realtek.com>
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

Four patches in this patchset. First two are to add features of 1SS EVM
statistics and rfkill. Third is to reset I/D MEM mode of WiFi CPU to
prevent boot abnormal. The last is just to correct typo.

Kuan-Chung Chen (2):
  wifi: rtw89: add EVM statistics for 1SS rate
  wifi: rtw89: add support for hardware rfkill

Ping-Ke Shih (1):
  wifi: rtw89: 885xb: reset IDMEM mode to prevent download firmware
    failure

Zong-Zhe Yang (1):
  wifi: rtw89: fix typo of rtw89_phy_ra_updata_XXX

 drivers/net/wireless/realtek/rtw89/core.c     | 117 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  12 ++
 drivers/net/wireless/realtek/rtw89/debug.c    |   5 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  21 +++-
 drivers/net/wireless/realtek/rtw89/phy.c      |   8 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |   2 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |  24 ++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  11 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  11 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  11 ++
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  11 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  11 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  11 ++
 drivers/net/wireless/realtek/rtw89/txrx.h     |   8 +-
 15 files changed, 244 insertions(+), 21 deletions(-)

-- 
2.25.1


