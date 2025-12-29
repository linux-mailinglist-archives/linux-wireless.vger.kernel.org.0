Return-Path: <linux-wireless+bounces-30147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B27CE5C5B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 04:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D247030062C6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 03:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248F1FBEB0;
	Mon, 29 Dec 2025 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EA2Z2l2u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1524224F3
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977786; cv=none; b=nF8ug+xWuMpYPyESZ3xbhPluLZhuTNan/yxZhvcZK3WsNLXrOBLBaFtQZ58xhePLVJt4NIZg7CX/FAxxIC72werNItf8MhyrXM0Arnk/swzXoiQNsGFe0MHSC9RuhfdAv/wLOJ4mGtJZIDk638X9v2CmcwBD3g1eawf3qs3prQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977786; c=relaxed/simple;
	bh=QhpXdTignPpk+NxJmWpjkPUjuYrfuElNNQFgngPd5ps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b+jd60Pu1GGy3fMoym2OqlEsmkiYeIwlsf+3HLeIgeYw8AKxfNZRHajGem5pugOko1X7Jp9S256AmnPUTv2jR1wCGWMyjgW30jVYJeN8mVJEGr7U5hKw45ULzmmNVJ/kGqg0LEFlkocrURDQvKMCX6SpHE1CFzbm4I00UA2jbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EA2Z2l2u; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BT39gKA2282401, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766977782; bh=G0SxEPnmDxwfOe2h3ZjgcXk+f5CGLGVNAlJRVW0iIpE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=EA2Z2l2u+o0825gUFlNAMtWpSEyqeTmFfkWFMfXiChn99p0EVVLB7YOSNeXV/cUur
	 5aqsuzw+/dAvc+bWJWSPRL3zlTlaYixFyFLLefOFepnO3QtTHUXiPwu4nVnzkQv0Vt
	 zEVCPyCrJSs5/Ebw7bxKtsy63t2lBIMLAS9RUVE9r5LFp6ax3XxKwopqWMZHBA07k8
	 0kKlmlClo+wDiBeH/oOJl6ROXFTBNUIJX6kIt9Vn/P8dvaSbevuJoNs/a5vs0B2C/z
	 /HPXkt5GXMC/jhJ2Ba/Yt7nmPZqf3Aqr8Nq7KtqC/0eyD030Jvq7wd04qjFN74IAYs
	 wcAIE4iyA4ksw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BT39gKA2282401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 11:09:42 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:09:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:09:42 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 29 Dec 2025 11:09:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 00/12] wifi: rtw89: more preparations for 8922D and refine of MCC
Date: Mon, 29 Dec 2025 11:09:14 +0800
Message-ID: <20251229030926.27004-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The first eight patches are preparations to abstract common flow for
8922D, including WoWLAN, TX/RX aggregation capabilities, hardware chip ID,
and default quirks.

Patches 8 and 9 are to refine MCC that two channels are operating
simultaneously.

Patch 10 is to correct 6GHz power type; patch 11 is better beacon loss
handling.

v2:
 - patch 7/12: add enum reference of AID and CID to comment

Chih-Kang Chang (2):
  wifi: rtw89: refine TX nulldata judgement when scan with 2 OP channels
  wifi: rtw89: 8922a: configure FW version for SCAN_OFFLOAD_EXTRA_OP
    feature

Chin-Yen Lee (3):
  wifi: rtw89: wow: use struct style to fill WOW CAM H2C command
  wifi: rtw89: wow: add WOW_CAM update function for 8922D
  wifi: rtw89: wow: abstract DMA check register for RTL8922DE

Dian-Syuan Yang (1):
  wifi: rtw89: enhance connection stability when triggering beacon loss

Kuan-Chung Chen (1):
  wifi: rtw89: define TX/RX aggregation and MPDU capability per chip

Ping-Ke Shih (4):
  wifi: rtw89: wow: change type of WoWLAN pattern mask to __le32
  wifi: rtw89: efuse: read hardware version from efuse for WiFi 7 chips
  wifi: rtw89: read chip ID for RTL8922D variants
  wifi: rtw89: add default quirks as features to chip_info

Zong-Zhe Yang (1):
  wifi: rtw89: regd: 6 GHz power type marks default when inactive

 drivers/net/wireless/realtek/rtw89/core.c     |  40 ++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  26 ++-
 drivers/net/wireless/realtek/rtw89/efuse.c    |   4 -
 drivers/net/wireless/realtek/rtw89/efuse.h    |   6 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c |  26 +++
 drivers/net/wireless/realtek/rtw89/fw.c       | 166 +++++++++++++-----
 drivers/net/wireless/realtek/rtw89/fw.h       | 126 +++++++------
 drivers/net/wireless/realtek/rtw89/mac.c      |  11 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |  13 ++
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   1 +
 drivers/net/wireless/realtek/rtw89/pci_be.c   |   7 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   7 +
 drivers/net/wireless/realtek/rtw89/regd.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   6 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  |   2 -
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   6 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   8 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   8 +-
 drivers/net/wireless/realtek/rtw89/wow.c      |   4 +-
 21 files changed, 342 insertions(+), 142 deletions(-)

-- 
2.25.1


