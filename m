Return-Path: <linux-wireless+bounces-30792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9738BD1BF64
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CEDB30090B8
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF317A303;
	Wed, 14 Jan 2026 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZZbTY317"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE61E1DEC
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354824; cv=none; b=kBKa6kttOTkZpLpo7TvmS4j3MleaT2XOaQdW5Yu4EAnQlS1zKKXzIkOjYSWFxFm6mNZ9vy4JlMS4Gl8uo+PtcfZ+uEbgEHF5Jhq1hhx3d+TjY131lfcz8tpqqIYKkThcwAxufKknrxlO4vUxZ7QV3+onASsGru3AId6avAibvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354824; c=relaxed/simple;
	bh=LXIvRFBI8z0JTNgxqZ/J6kgEcnuOBUazH2SQCnK0fSE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oE+0r59yTxhaG2J4tw8E+2Amsp4ErOOsKT3l+wsTsdPl7UMi3aleP/9Sn0PiriixLTmnACoW4eb76iAYw+8zg90dAYxOSEVVtzM84Oc89Xv5L57g8bcyHgceucHiNmZvWTXMLNiO6DyNJwPmJTo3TDP9V9PREkY4XDI9cmc4g0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZZbTY317; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1eJN114168539, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354819; bh=x7nO7SHqXXQSw7mc7QMAVVLKRSTlkk+z9EyIyWz3V48=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ZZbTY317IUTzHhOW8/vITSA6iCiu/hcnBsIn7U8euZBOASYOrTzb1QEB0rY5qjyVB
	 x7LgUQIqIiB6B47yoLY+M9mQo9r24QV4jmg8fHGe4U1dkr1WwoUyWroyQvJLS3Kbyu
	 oDC9QMfLnfvjZQIzTV4H7EOFwsT5qNFSNSWkyIHwuoR4YY2cI+tOcxP2tZv6art/0M
	 gZNvN8TiMrx6935wV4X+3MebBILckIZrn0eX+H9GHhC+TstY1vRWABSHBfIsyjMR4V
	 nOJfbQqyBPrl5SHUWIrlqe2ZaK1YgP7rBOyTHQj+nrAHeDyBetMd/kNKEU4ekFg/MS
	 l6b42/Rdd+Puw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1eJN114168539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:40:19 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:20 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:20 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:40:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 00/12] wifi: rtw89: refactor PHY flow/setting for RTL8922D
Date: Wed, 14 Jan 2026 09:39:38 +0800
Message-ID: <20260114013950.19704-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The RTL8922D uses different PHY settings like MAC part. Refactor to adopt
RTL8922D. Additionally, the last patch is to correct MLO connection for
a specific condition found by testing.

Eric Huang (2):
  wifi: rtw89: phy: extend register to read history 2 of PHY env_monitor
  wifi: rtw89: phy: update bb wrapper TPU init

Ping-Ke Shih (8):
  wifi: rtw89: mac: clear global interrupt right after power-on
  wifi: rtw89: phy: add {read,write}_rf_v3 for RTL8922D
  wifi: rtw89: phy: add ops rtw89_phy_gen_be_v1 for RTL8922D
  wifi: rtw89: phy: abstract start address and EHT of PHY status bitmap
  wifi: rtw89: phy: abstract BB wrap registers to share initial flow
  wifi: rtw89: phy: update BB wrapper RFSI
  wifi: rtw89: phy: write BB wrapper registers with flush
  wifi: rtw89: phy: refine initial flow of BB wrapper

Po-Hao Huang (2):
  wifi: rtw89: phy: fix incorrect power limit by mac_id
  wifi: rtw89: fix unable to receive probe responses under MLO
    connection

 drivers/net/wireless/realtek/rtw89/core.h   |   2 +-
 drivers/net/wireless/realtek/rtw89/fw.c     |   3 +
 drivers/net/wireless/realtek/rtw89/mac.c    |   2 +
 drivers/net/wireless/realtek/rtw89/mac.h    |  17 +
 drivers/net/wireless/realtek/rtw89/mac_be.c |  10 +
 drivers/net/wireless/realtek/rtw89/phy.c    | 160 +++++-
 drivers/net/wireless/realtek/rtw89/phy.h    |  20 +
 drivers/net/wireless/realtek/rtw89/phy_be.c | 563 +++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h    | 350 +++++++++++-
 9 files changed, 1095 insertions(+), 32 deletions(-)


base-commit: 292c0bc8acb687de7e83fc454bb98af19187b6bf
-- 
2.25.1


