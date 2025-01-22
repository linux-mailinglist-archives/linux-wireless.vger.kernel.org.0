Return-Path: <linux-wireless+bounces-17813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8018A18B97
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 07:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082571627C0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 06:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA72175D47;
	Wed, 22 Jan 2025 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CKb5+I7X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7C14A619
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525820; cv=none; b=j0at9mP1XVe8Ej25QBoy5DCjIpFcbNgb/ayB57a2R4yIXCaVDP6hF/efTlDWztdKomaJQaWzAsFK49hCblEvwAtMSLAYbxx/pVWyVwNLDs0+LmQEPVJeFSx12Gig82JBuhK9axyz1jS6sf1FXCQxWx/Dupq0McPvECylVBbXGBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525820; c=relaxed/simple;
	bh=tzLaFDMmoOnIZItKbUceuCOmfLTFrevSKI3QEEtFglw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XbUbSScoQaNYYwnBUOtGfiUze1H0bWBaCSlvWPfs/Hyp29IvhhAYnw2BspVkXIpFr2IozG+SvWxXCRL4OTonNqDnhWPE9KDpe8jPgbOzdFQKJG3QxPuvbtr41guCgb8/CiYtKvK8fnBwpUrCoE7EG03VeDvsajVCcOfnfgws/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CKb5+I7X; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50M63XnpC2493985, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737525813; bh=tzLaFDMmoOnIZItKbUceuCOmfLTFrevSKI3QEEtFglw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=CKb5+I7XU8+LB2XD6/GIP4IshiXM0inlvGcg4CyJ43LeMMLFrHBPlM19kipPGhwy1
	 8SoOp/VuEqO/SpfglM4+dZ4E6RikwHigvOKCla8/EnRkFG/jtHHaQHnRnp06Lxrl6p
	 66hzhDqwHtaOayUe5gn1keDSm06anazuS1hzNqKhjrnFeNeX6Gl3qyUv51pZM9pQ2S
	 yaINgvhH+aFXWL2fQYwBxBMt0Cp0jcpzWdKi1k+7Ge11XWkTRJUOZMJ7oie/oS8hFN
	 CGDZA3317F+nP3wFvx/5/0h5iWeLirTh6f4pbIS2CHKSYmgPJyC0ax3lDgNvHr+Psq
	 sNLaJ6/zAjqNA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50M63XnpC2493985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 14:03:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 14:03:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 Jan
 2025 14:03:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/10] wifi: rtw89: switch to wiphy lock and work
Date: Wed, 22 Jan 2025 14:03:00 +0800
Message-ID: <20250122060310.31976-1-pkshih@realtek.com>
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

The driver mutex is to synchronize ieee80211_ops and works, but it isn't
easy to mange and causes AB-BA locks problem, which we have adjusted to
avoid but the code isn't smooth.

Nowaday, wiphy lock can make thing simple and easy, and also switch to
wiphy lock is easy by reference of ath12k [1]. The debugfs neeeds special
treatments to use wiphy_lock [2], and debugfs_short_fops [3] can save
some spaces.

The plans in this patchset is to switch from (A) to (B) and to (C) as
below. Current code has two patterns (A) and (B), so fist step is to
change (A) to (B), and then just remove mutex_lock() of driver to get (C).

      (A)                      (B)                  (C)
                         wiphy_lock()          wiphy_lock()
                         ...                   ...
  mutex_lock()           mutex_lock()
  ...                    ...                   ...
  mutex_unlock()         mutex_unlock()
                         ...                   ...
                         wiphy_unlock()        wiphy_unlock()
 
The patches 1/10 and 2/10 are to change (A) to (B) for the codes except
to debugfs.

The patches 3/10 to 6/10 are related to debugfs. Originally, rtw89 uses
seq_file to output data, so we convert to use generic file_ops::read/write
with scnprintf() to be compatible with wiphy_locked_debugfs_{read,write}().
This is also good to specify output buffer size to avoid duplicate IO
during debugging.

After patches 1/10 to 6/10, all have become (B), so remove driver mutex
by patches 7/10 to 9/10. Among them, patch 8/10 is a manually comsmetic
patch to be expected.

The last one patch is a special deal to early_h2c, which is a list of H2C
commands for debug purpose.

This patchset has structural dependency with existing two patchset:
 - wifi: rtw89: enhance dynamic mechanism per PHY
 - wifi: rtw89: cleanup unused rtwdev::roc_work

[1] ath12k switch to wiphy_lock: https://lore.kernel.org/linux-wireless/20240821153728.2121600-1-kvalo@kernel.org/
[2] wiphy_lock for debugfs: https://lore.kernel.org/linux-wireless/33ea3a62b4257b6ef789c30fa8f7bf7e9f1865b5.camel@sipsolutions.net/
[3] debugfs_short_fops: https://lore.kernel.org/linux-wireless/20241009181339.0b1a6eaef573.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid/

Ping-Ke Shih (10):
  wifi: rtw89: add wiphy_lock() to work that isn't held wiphy_lock() yet
  wifi: rtw89: use wiphy_work() to replace ieee802111_work()
  wifi: rtw89: debugfs: implement file_ops::read/write to replace
    seq_file
  wifi: rtw89: debugfs: specify buffer size allocated by devm_kazlloc()
    for reading
  wifi: rtw89: debugfs: use wiphy_locked_debugfs_{read,write}() if
    needed
  wifi: rtw89: debugfs: use debugfs_short_fops
  wifi: rtw89: remove consumers of driver mutex
  wifi: rtw89: manual cosmetic along lockdep_assert_wiphy()
  wifi: rtw89: remove definition of driver mutex
  wifi: rtw89: pci: not assert wiphy_lock to free early_h2c for PCI
    probe/remove

 drivers/net/wireless/realtek/rtw89/chan.c     |   28 +-
 drivers/net/wireless/realtek/rtw89/chan.h     |    2 +-
 drivers/net/wireless/realtek/rtw89/coex.c     | 2805 +++++++++--------
 drivers/net/wireless/realtek/rtw89/coex.h     |   16 +-
 drivers/net/wireless/realtek/rtw89/core.c     |  145 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   38 +-
 drivers/net/wireless/realtek/rtw89/debug.c    | 2062 ++++++------
 drivers/net/wireless/realtek/rtw89/fw.c       |   23 +-
 drivers/net/wireless/realtek/rtw89/fw.h       |    3 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  281 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |   45 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |    8 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |    6 +-
 drivers/net/wireless/realtek/rtw89/regd.c     |    6 +-
 drivers/net/wireless/realtek/rtw89/sar.c      |   60 +-
 drivers/net/wireless/realtek/rtw89/sar.h      |    5 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |   17 +-
 drivers/net/wireless/realtek/rtw89/util.c     |   11 +
 drivers/net/wireless/realtek/rtw89/util.h     |    5 +-
 drivers/net/wireless/realtek/rtw89/wow.c      |    7 +-
 20 files changed, 2988 insertions(+), 2585 deletions(-)

-- 
2.25.1


