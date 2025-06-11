Return-Path: <linux-wireless+bounces-23973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17FAD49C8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB864188EC20
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD21B87F2;
	Wed, 11 Jun 2025 03:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bpjA+R7B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2592EAF9
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614157; cv=none; b=d5KBK58D5MpJI80zw5k30onySPn4g4+BxxbELM9gAofDmGvLHGVViz6Cg7SRj0F6RUuJBEr4R9ajvaa6pScG0Gi+cZ4vJxHgMfjEhPhgtoCX1MDTRHNwe5LqbADe5qrwYLlLASXx++uo+H0x3TuVToo9yNakwbnjWaXcN73fKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614157; c=relaxed/simple;
	bh=/vclnt6MyZK3V/z1WfwwY+WkYa987HYnE9vnXgyqjWw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RbXKTYGgrow17qtkBA+qOJmyZK7csEOisNwoPgKwigIlysPCihQ8usUiKi4O3IJaIvBcyvT+09JW7/j8U4qmyYo5lYrTzciBbe41XYE9iKU/K7Pqkh1esRqT7oX1OpzeexFp4/gzOKcexAJYW/Ulwa6sbKjAOBg0Hwys/7K9Xk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bpjA+R7B; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B3to8eB4132051, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749614150; bh=y+ppp7dDUyZWrEee55DX/ZdsoH6WG91ois5QWG6aIMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=bpjA+R7BHQ0h0CVgkeObErm5dM5s3tNiUXmsl4Bt5FjuzJUaW+sp7u2S+OSxRuF3Z
	 peZfeWHrXMWo97TUGtWynGPogfoP+5WAcRDH74G2UxENac2cwcM8qWorWhLsyyn2B+
	 Zpeju6XzDexzK9rYOE0nNVt+RXu8HAn4t8apSZN9N+g5VFGc/X36bhBK7qcFf7xICF
	 OqOz5ykRmBPZUj+6Uoi/DlyGTfOc+NRt5ecaquWJ7/s23Sz0B4oox8IqLYjW1N++91
	 xcoIVlh67EnbN6OmG9+uN44uDxBtcgPFbE5gqtxogT0pnAfQ8ozBqvUpHC1/zchkzX
	 /CimdGKBb7SAg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B3to8eB4132051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 11:55:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 11:55:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 11:55:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 00/10] wifi: rtw89: coex: add logic related to MLO
Date: Wed, 11 Jun 2025 11:55:13 +0800
Message-ID: <20250611035523.36432-1-pkshih@realtek.com>
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

WiFi under MLO can operate on more than one channels (links)
simultaneously, and BT-coexistence mechanism needs to know the operating
channels/bands to assign timeslot for WiFi/BT. Iterate chanctx to fill
the information for coex.

To support MLO use case, the hardware is also added more settings, so
update to control hardware as wanted.

v2:
 - (patch 03/10) fix clang warning - set but not used

Ching-Te Ku (9):
  wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.63.0
  wifi: rtw89: coex: Implement Wi-Fi MLO related logic
  wifi: rtw89: coex: Update Wi-Fi status logic for WiFi 7
  wifi: rtw89: coex: refine debug log with format version and readable
    string
  wifi: rtw89: coex: Add H2C command to collect driver outsource
    information to firmware
  wifi: rtw89: coex: Update Pre-AGC logic for WiFi 7
  wifi: rtw89: coex: Update BTG control for WiFi 7
  wifi: rtw89: coex: Update hardware PTA resource binding logic
  wifi: rtw89: coex: Add PTA grant signal setting offload to firmware
    feature

Zong-Zhe Yang (1):
  wifi: rtw89: introduce rtw89_query_mr_chanctx_info() for multi-role
    chanctx info

 drivers/net/wireless/realtek/rtw89/chan.c |  195 ++++
 drivers/net/wireless/realtek/rtw89/chan.h |   45 +
 drivers/net/wireless/realtek/rtw89/coex.c | 1022 +++++++++++++++------
 drivers/net/wireless/realtek/rtw89/coex.h |    7 +
 drivers/net/wireless/realtek/rtw89/core.h |   99 +-
 drivers/net/wireless/realtek/rtw89/fw.c   |   40 +
 drivers/net/wireless/realtek/rtw89/fw.h   |    6 +
 drivers/net/wireless/realtek/rtw89/reg.h  |    1 +
 8 files changed, 1084 insertions(+), 331 deletions(-)

-- 
2.25.1


