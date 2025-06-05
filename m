Return-Path: <linux-wireless+bounces-23763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7032DACEEA3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A56177A8A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A51211299;
	Thu,  5 Jun 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AtIYjVrp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7D218858
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123752; cv=none; b=Bz7Rnb761sIUuUEK1SB2tA+z6fRTtCkfVbjVzaHP8sagTR9ZiuCKXQcWXqGtXe0g7N1u+qu4XjVt6kXkUypSFpD+w74opKs9iCPD6dFUpMgcpFoPEy4HBA+59eapp2xUv4KFBywa/vzX5B1/b3rAT3WZU5328JtIG1B8ZRyACag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123752; c=relaxed/simple;
	bh=jtVgvzCDP3jga2LIXj6U7e9hXVngQ6HjhOdSnUGz6Ho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m+26EXQhQNDyYl1FXthO5xydy0V9TrTqRdA6lSx9sbRIpD/ArFc/FC/cZz2qCgXsXWCBB6yBPtUSsdw5G09CW8HA20xRyxRlkUSn6z2Bedc2fvtfS72cJdFy/shtRda2PP5+srBYUBxClv2/ldOZ0gy5LvxMsKSlMC9qBEwk6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AtIYjVrp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 555BgQ3E11470996, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749123746; bh=61O4171IRFOqXAXu4jKoq/Qwt4z+hPKzeZ5mHN4cubo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=AtIYjVrpVleQ3p48g70mT8nauEaMx5JrUg25rhcin5UadfVtrqzW1WdAyWq3FXtWS
	 29EvKzihZBGnXwEuPfoagnWFp5pQqd0fl3rJKKXDOinEKduwbkGD+XQNhf36Lhzjmh
	 FPSBY19TyyH2RtpEsJVLYKXu6ZwPvFIBsvX4C4AsjD2Dvix4XKMEF/ts6hcFBakgWY
	 hWj9cI3XYvmnrX2c7KNYqnlZra2l5S/epHKOQBETfcYa0v6QQ0/g1Y3nvzZ1Vx8zmI
	 Hb/S3jHcxrnwPE3/aFJ6n68kVPVRJIr1yYggGD4znRRzy6MCw0GMsWrseQ1s9MtXe+
	 rJ05MHrbTiU2A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 555BgQ3E11470996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 5 Jun 2025 19:42:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Jun 2025 19:42:26 +0800
Received: from [127.0.1.1] (10.22.226.54) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 5 Jun
 2025 19:42:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <damon.chen@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 0/5] wifi: rtw89: support channel switch and correct EHT settings
Date: Thu, 5 Jun 2025 19:42:02 +0800
Message-ID: <20250605114207.12381-1-pkshih@realtek.com>
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

First three patches are to support channel switch. The patch 4/5 is to
adjust EHT PHY status report for RX packets. The last patch is to correct
non-AP STA behavior under EHT 20MHz bandwidth.

Eric Huang (1):
  wifi: rtw89: add EHT physts and adjust init flow accordingly

Kuan-Chung Chen (1):
  wifi: rtw89: fix EHT 20MHz TX rate for non-AP STA

Zong-Zhe Yang (3):
  wifi: rtw89: chan: concentrate the logic of setting/clearing chanctx
    bitmap
  wifi: rtw89: chan: re-config default chandef only when none is
    registered
  wifi: rtw89: implement channel switch support

 drivers/net/wireless/realtek/rtw89/chan.c     | 58 ++++++++++---
 drivers/net/wireless/realtek/rtw89/chan.h     |  6 ++
 drivers/net/wireless/realtek/rtw89/core.c     | 40 +++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 72 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c      | 87 ++++++++++---------
 drivers/net/wireless/realtek/rtw89/phy.h      |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  1 +
 8 files changed, 215 insertions(+), 52 deletions(-)

-- 
2.25.1


