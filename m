Return-Path: <linux-wireless+bounces-12514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B31C96CC50
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 03:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501EB1C21CAB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 01:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90208462;
	Thu,  5 Sep 2024 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Hm0jZnEG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF86635
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 01:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725500051; cv=none; b=tZp9sUyL8FEUTvtDML8IwyGiplT6QC6o+pyqzkr9cnZXDp8RBbu1rGMOOyqsOoQNFCwNezQ+SnJwdPObV1HKnnpTTWdMErBt9f9cYI9dNonlsx3k3AKLNtOfgSj8CcqAXgDv97G6Hq6x24S2Tf7SSpZOFMn8DpDietrA6/D1lwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725500051; c=relaxed/simple;
	bh=z1qRAYy9LJ0WESY0+cWj1vkcn+UL9OpP6oLVqz3yxfU=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=KXvu4dxON+Q60l1Ij6E70AAuxJ8+LBWZZU9CtZH/ZpfvSPhYokolM94G4qnPrCada+E8JMQBhThBNtXLnUbQ4kjgEeqzoX7MEq56eeheGJ0FlzYEA6YJvNZj8ZyPqLKl/kYpa+oxBB2s40MDpqRT5XC8fNx2di9mKPdaMCtMArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Hm0jZnEG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4851Y6hrC3103640, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725500046; bh=z1qRAYy9LJ0WESY0+cWj1vkcn+UL9OpP6oLVqz3yxfU=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=Hm0jZnEGAwV/E38rQ83lzADk4n31gCOaU5VbuhxxQ9yCI5Y3M9YxJg4UBAmpDGyvC
	 Xuywjzw2YLnUEZB9LLM9C33VPFAlTSPQXj1KIZ7a8yyqZ7IUjbwtZDM4DbgTym3b5A
	 qwDdTz/uQMiSNMLYouTbqv3L/jbl7zsdIUfG7YTz0HjdyY7F/VpSXKm/I4PUAw0z0d
	 HecW2G2u/9NV5R4Mg9rBJV7PEjfMEuFC586ZQEkHwtZlDLEOR1eS8PinG5TzNmwDFy
	 w5rJrffUnzjuPR6nSERIJhCxWAAvrNoERMd0m8EW/7UcN+XMMkCSSx5or74v+cSagV
	 2Xk+vaiB1AJhg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4851Y6hrC3103640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 5 Sep 2024 09:34:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 09:34:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 5 Sep
 2024 09:34:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2024-09-05
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <02ae85d2-f1f5-452e-8c91-be9c9882a7e1@RTEXMBS04.realtek.com.tw>
Date: Thu, 5 Sep 2024 09:34:06 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit daaf0dd0398d5e93b7304f35184ca182ed583681:

  wifi: mwifiex: keep mwifiex_cfg80211_ops constant (2024-08-16 13:07:03 +0300)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2024-09-05

for you to fetch changes up to ed2e4bb17a4884cf29c3347353d8aabb7265b46c:

  wifi: rtw89: avoid reading out of bounds when loading TX power FW elements (2024-09-05 09:13:44 +0800)

----------------------------------------------------------------
rtw-next patches for v6.12

The rtw89 is continuously adjusting code to support MLO. The major changes
are listed below:

rtw88:

 * fix USB not transmitting beacon in AP mode

rtw89:

 * complete BT-coexistence code for RTL8852BT
 * fix throughput degrade of VHT rate for RTL8851B/8852A/8852B/8852BT
 * enable WoWLAN net-detect for more one chip, RTL8922A

----------------------------------------------------------------
Bitterblue Smith (1):
      wifi: rtw88: Fix USB/SDIO devices not transmitting beacons

Chia-Yuan Li (1):
      wifi: rtw89: limit the PPDU length for VHT rate to 0x40000

Chin-Yen Lee (4):
      wifi: rtw89: 8852a: adjust ANA clock to 12M
      wifi: rtw89: wow: add wait for H2C of FW-IPS mode
      wifi: rtw89: wow: add net-detect support for 8922ae
      wifi: rtw89: wow: add scan interval option for net-detect

Ching-Te Ku (4):
      wifi: rtw89: coex: Update report version of Wi-Fi firmware 0.29.90.0 for RTL8852BT
      wifi: rtw89: coex: Update Wi-Fi role info version 7
      wifi: rtw89: coex: Bluetooth hopping map for Wi-Fi role version 7
      wifi: rtw89: coex: Add new Wi-Fi role format condition for function using

Dmitry Kandybka (1):
      wifi: rtw88: remove CPT execution branch never used

Eric Huang (2):
      wifi: rtw89: adjust DIG threshold to reduce false alarm
      wifi: rtw89: use frequency domain RSSI

Kuan-Chung Chen (2):
      wifi: rtw89: 8852c: support firmware with fw_element
      wifi: rtw89: 8922a: add digital compensation to avoid TX EVM degrade

Ping-Ke Shih (4):
      wifi: rtw89: remove unused C2H event ID RTW89_MAC_C2H_FUNC_READ_WOW_CAM to prevent out-of-bounds reading
      wifi: rtw89: correct base HT rate mask for firmware
      wifi: rtw89: debugfs: support multiple adapters debugging
      wifi: rtw88: assign mac_id for vif/sta and update to TX desc

Zong-Zhe Yang (10):
      wifi: rtw89: pass chan to rfk_band_changed()
      wifi: rtw89: 8851b: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8852a: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8852bx: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8852c: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8922a: use right chanctx whenever possible in RFK flow
      wifi: rtw89: rename roc_entity_idx to roc_chanctx_idx
      wifi: rtw89: introduce chip support link number and driver MLO capability
      wifi: rtw89: wow: fix wait condition for AOAC report request
      wifi: rtw89: avoid reading out of bounds when loading TX power FW elements

 drivers/net/wireless/realtek/rtw88/coex.c          |  38 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |  13 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |  13 +-
 drivers/net/wireless/realtek/rtw88/main.c          |  30 +-
 drivers/net/wireless/realtek/rtw88/main.h          |  14 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |  11 +-
 drivers/net/wireless/realtek/rtw88/tx.h            |   1 +
 drivers/net/wireless/realtek/rtw89/chan.c          |  12 +-
 drivers/net/wireless/realtek/rtw89/coex.c          | 508 +++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.c          | 107 ++++-
 drivers/net/wireless/realtek/rtw89/core.h          | 118 ++++-
 drivers/net/wireless/realtek/rtw89/debug.c         | 180 ++++----
 drivers/net/wireless/realtek/rtw89/debug.h         |   2 +
 drivers/net/wireless/realtek/rtw89/fw.c            |  93 ++--
 drivers/net/wireless/realtek/rtw89/fw.h            |  67 ++-
 drivers/net/wireless/realtek/rtw89/mac.c           |  26 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   1 -
 drivers/net/wireless/realtek/rtw89/phy.c           |  49 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   6 +
 drivers/net/wireless/realtek/rtw89/ps.c            |   7 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |   7 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  21 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  | 138 +++---
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h  |  18 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  34 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.h      |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c  | 292 ++++++------
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h  |  17 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  23 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |  29 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.h   |  24 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  | 211 +++++----
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h  |  20 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |  31 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 188 ++++----
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h |  20 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  21 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  | 260 ++++++-----
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h  |  17 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      | 124 ++++-
 drivers/net/wireless/realtek/rtw89/txrx.h          |  59 ++-
 drivers/net/wireless/realtek/rtw89/wow.c           |   3 +-
 42 files changed, 1971 insertions(+), 886 deletions(-)

