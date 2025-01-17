Return-Path: <linux-wireless+bounces-17623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61584A14A1F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 08:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DAF7A3779
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 07:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E711F76D8;
	Fri, 17 Jan 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ohlQ65Gs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36681F78F4
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098942; cv=none; b=IH4KwYJdktFj5/lwWaUYTEtOfGB9lSihTT8p4GN2j/XD8hBAvHyVZ8DZH94oSUMThcYqfFrtkzWOVHKKn+5F5UnrG4bu3NwlVkAVPFAvHdYS0MgUx9RoiVnuEfNvTCJ67HntoDcHqQ61jfS5PcUoXnNfFXIA3QsgpvR/q+y6aMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098942; c=relaxed/simple;
	bh=Q+tImX3v/C/8FR1rNYV32RCqgd2D3oKUKRjY8vIM3Rw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZEqePa6vjvifMC+LYKLwBZgwNUZrp2eYvqV9a+Gr7zwYHm5xm3SgiF/Z6GKtXx3w21h1Atnkdch1/pD0JuF+IiyLYxKdl1f75jnMQC+bCPUUhcTt4ScZPIpTloRLu3Q2f8ZlspGUiRWbIQipJTyavkWuVw1SU5uiNu2CM2Xa9SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ohlQ65Gs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50H7StMcA2337730, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737098935; bh=Q+tImX3v/C/8FR1rNYV32RCqgd2D3oKUKRjY8vIM3Rw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ohlQ65Gs/NKZHXDZHxkJu/BcHDlcMnP/jf3oi0R7wpd+HXMaUc34TGFtDB9iVko7i
	 YvtnoVTAds4l66Dxr7t7KJ3gNSEccBVuu2dktLn1q5qb/1z+ZvRKEpYht7nRzZCV9u
	 ojE0bpSJwMOs1FtfmkxwMv9kKmpNuKbqz14l6PcPq+LnHrZPs1tdys9rYydZDP7iD9
	 ZWJNaLvAIHHF64+sMhys6Z9hGP05si2G3exmcBJ9duWro4zQDMPYmY7Y6aWEvEFBXa
	 EnNgAldGkAGsx9PioxIOMwiAipkl8K4enkBA4ElcolRGYyp0B6IRn1VPMCvHDEXJit
	 vpNlSzO0Mh70w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50H7StMcA2337730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 15:28:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 Jan 2025 15:28:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 Jan
 2025 15:28:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: enhance dynamic mechanism per PHY
Date: Fri, 17 Jan 2025 15:28:20 +0800
Message-ID: <20250117072828.16728-1-pkshih@realtek.com>
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

To support MLO, two PHY work simultaneously. Enhance dynamic mechanism
to support two PHY from one.

The logic are almost the same, so create two context instances for PHY 0/1.
For hardware registers, only set registers according to certain PHY.

Ping-Ke Shih (8):
  wifi: rtw89: phy: rename to RTW89_PHY_NUM as proper naming
  wifi: rtw89: phy: add PHY context array to support functions per PHY
  wifi: rtw89: phy: support env_monitor per PHY
  wifi: rtw89: phy: support DIG per PHY
  wifi: rtw89: phy: support ch_info per PHY
  wifi: rtw89: phy: support EDCCA per PHY
  wifi: rtw89: phy: support EDCCA log per PHY
  wifi: rtw89: phy: disable CFO track when two PHY are working
    simultaneously

 drivers/net/wireless/realtek/rtw89/coex.c     |  38 +-
 drivers/net/wireless/realtek/rtw89/core.c     |  17 +-
 drivers/net/wireless/realtek/rtw89/core.h     | 100 ++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  14 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   2 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 703 ++++++++++--------
 drivers/net/wireless/realtek/rtw89/phy.h      |   7 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   5 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  15 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  15 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  15 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  15 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  15 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  15 +-
 drivers/net/wireless/realtek/rtw89/sar.c      |   3 +-
 16 files changed, 603 insertions(+), 378 deletions(-)

-- 
2.25.1


