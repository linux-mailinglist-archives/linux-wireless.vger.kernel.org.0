Return-Path: <linux-wireless+bounces-7378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E230E8C0D20
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 11:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB011C2101D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4DD14A4D6;
	Thu,  9 May 2024 09:07:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0DA14A0BE
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245632; cv=none; b=lZvjMvF8PzxXBbNpcuLhRMQ3I3gIqizKmm/N+nfqX+WoZp1V3D4D6cGRX7q5J+c+a0rKSnjI15SUGkWQ+It+nzfpjvZFJkA/VBlZvuF0rushGTIWG1wqCCIaveh7g8fliy8j7Vjfmey9aUCBWaDGkpBB4nZo5MnJEBJP1cBuulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245632; c=relaxed/simple;
	bh=Q41lfe0obyzX/FTezyS3IXQURC/xFvpvzfJ+W4UIwJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q5CignNi2zZp6N7vhUWHp1pgRQ/JZ4xyABRIs9uQ5y0hEZiFDc/HMA8W2GnbHosMl+iKB4nUM9WI/ANUZ71xx+89DHn3D0/AKPDjUWWXunjAKHDoXFfyXS4WVdgn3qEWjJAyC17/sxLVs9U6Zz3Cl94tHD2vPL+wnyOf6Cz2E/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4499773b81425565, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4499773b81425565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 9 May 2024 17:07:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 17:07:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 9 May
 2024 17:07:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 0/4] wifi: rtw89: adjust security CAM, mac80211_ops and mac_id for coming MLO
Date: Thu, 9 May 2024 17:06:42 +0800
Message-ID: <20240509090646.35304-1-pkshih@realtek.com>
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

Originally rtw89 design is to WiFi 6 chips, and things are limit to single
link (i.e. deflink). The security CAM is used to install keys, which one
CAM entry can share to multiple links (the same MLD), so we adjust to
maintain the CAM as a common pool, instead of binding to address CAM that
belongs to single link.

Also adjust use of bss_info_changed to vif_cfg_changed/link_info_changed,
which are still compatible to existing ones.

MAC_ID is to represent an instance ID of a link, so more than one MAC_ID
are used by a MLD. However, assignment of MAC_ID for links of a MLD should
follow rules of hardware design (MAC_ID of 2nd link = MAC_ID of 1st link
+ 16). Prepare supported number of MAC_ID in chip_info.

Zong-Zhe Yang (4):
  wifi: rtw89: ser: avoid multiple deinit on same CAM
  wifi: rtw89: cam: tweak relation between sec CAM and addr CAM
  wifi: rtw89: switch to register vif_cfg_changed and link_info_changed
  wifi: rtw89: support mac_id number according to chip

 drivers/net/wireless/realtek/rtw89/cam.c      | 79 ++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.c     | 48 ++++++-----
 drivers/net/wireless/realtek/rtw89/core.h     |  5 +-
 drivers/net/wireless/realtek/rtw89/debug.c    | 16 ++--
 drivers/net/wireless/realtek/rtw89/mac.c      |  7 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 42 ++++++----
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 drivers/net/wireless/realtek/rtw89/ser.c      |  8 +-
 12 files changed, 134 insertions(+), 76 deletions(-)

-- 
2.25.1


