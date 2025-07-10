Return-Path: <linux-wireless+bounces-25149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12495AFF7FC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5928A171A45
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E719E7D1;
	Thu, 10 Jul 2025 04:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="U0Om1NQ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F92F3E
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121491; cv=none; b=RYXKEEpTUsfr6/D9PjCE/Pw6jsCW48FDQIj9aAM//KC8Aebaiby15ldrdcjAbl7ehoEz5xFaupBcY3JliFEYgzHjurVwPQeMRSNhPwtKqd4Hi6FquSwQyhP4bRPE/aEfGX8FjVBORltAe3tOvDPKYV0W/qL5lQA+/KF6S7qrQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121491; c=relaxed/simple;
	bh=v45YGXRIIVVUk1+ForF0YuqoswRDINCf/eI1UED0A7I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nWAYTtSzr1JlLsadxhPZVuCRjvpuDWA5IMO/9uMU1vbQbM0j8eRxfJx3GZcQCy+JHxP65v0ZJJb4NLgzkCd6Rp27Ps7gAlNxAF3mcal8k+AifMhCjahD0roKsNvbzE4A4gzBMkBpoIy8F72bcF2HU7Nqd4PX/xkiOOHz2IJ8UCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=U0Om1NQ9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4OitS62455768, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121484; bh=EQdKqt+ls/Wuye+drPBznnBHD4UYHiWi+IZbou1rZAg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=U0Om1NQ9DlNX8Zqq34M9k1MsxG4nBm0QLCOkOAGMmsUV28kHTo0dRVVW+31ch47D1
	 lg788N/GDoYkTswQcoB5vVjuVkWPLC+DgUpyzgWYhr3dIguK4tZ9oAj0U33ztACx/G
	 ZaILFJzO1jn7uXhp2Uax1FITfCCHjHfIVzRuu7kYX2H2C1W3rok3BOqmmF0ocf/h8j
	 zhuob21SlxDTaiuNIZ9+tt1Vp8MVUhkmfz4u3Axhm0PFRm8MMzbOkvpejE3kg5iiDj
	 Uon6Z4yZe3N2KsrKgry29dfsL07rTAh3arXXBAoo/Wo02zjRIzwQWlI769kQcFwrnR
	 kF30aKpqmjZGw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4OitS62455768
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:24:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:24:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:24:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/14] wifi: rtw89: more finetune on MCC feature
Date: Thu, 10 Jul 2025 12:24:09 +0800
Message-ID: <20250710042423.73617-1-pkshih@realtek.com>
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

To be better user experience during scanning on MCC, consider PD (packet
detection) and DIG (dynamic initial gain), and add second connection
channel as back OP channel to firmware.

Chih-Kang Chang (9):
  wifi: rtw89: mcc: add H2C command to support different PD level in MCC
  wifi: rtw89: add DIG suspend/resume flow when scan and connection
  wifi: rtw89: mcc: enlarge GO NoA duration to cover channel switching
    time
  wifi: rtw89: mcc: when MCC stop forcing to stay at GO role
  wifi: rtw89: extend HW scan of WiFi 7 chips for extra OP chan when
    concurrency
  wifi: rtw89: mcc: solve GO's TBTT change and TBTT too close to NoA
    issue
  wifi: rtw89: check LPS H2C command complete by C2H reg instead of done
    ack
  wifi: rtw89: update SER L2 type default value
  wifi: rtw89: tweak tx wake notify matching condition

Zong-Zhe Yang (5):
  wifi: rtw89: introduce fw feature group and redefine CRASH_TRIGGER
  wifi: rtw89: 8852bt: configure FW version for SCAN_OFFLOAD_EXTRA_OP
    feature
  wifi: rtw89: 8852bt: implement RFK multi-channel handling and support
    chanctx up to 2
  wifi: rtw89: 8852b: configure FW version for SCAN_OFFLOAD_EXTRA_OP
    feature
  wifi: rtw89: 8852b: implement RFK multi-channel handling and support
    chanctx up to 2

 drivers/net/wireless/realtek/rtw89/chan.c     | 187 +++++++++++++--
 drivers/net/wireless/realtek/rtw89/chan.h     |  15 ++
 drivers/net/wireless/realtek/rtw89/core.c     |  24 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  28 ++-
 drivers/net/wireless/realtek/rtw89/debug.c    |   2 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 225 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h       |  39 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      |  11 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   5 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 222 +++++++++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h      |   2 +
 drivers/net/wireless/realtek/rtw89/ps.c       |  28 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  12 +-
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c |  77 ++++--
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |   3 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  12 +-
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    |  69 ++++--
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |   3 +
 drivers/net/wireless/realtek/rtw89/wow.c      |   2 +-
 19 files changed, 829 insertions(+), 137 deletions(-)

-- 
2.25.1


