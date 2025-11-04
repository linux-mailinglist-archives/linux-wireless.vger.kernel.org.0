Return-Path: <linux-wireless+bounces-28519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC1DC2F749
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 07:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0173B3FDF
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E02BD03;
	Tue,  4 Nov 2025 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fZCrwSmZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03331B7F4
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238247; cv=none; b=EffD/ltPC+Hc/rNtKwdYxbd4vXGCT9NmMzDc8ZNhtu9bHbxIYPfndDnmMzuh6cpVau3D03o2OK1TD0EDrl44Xf7C1LXk1LWz1Go/tv7/l7vFgD/s0thAiOM2xuHGobgg674CI1EceNafSKhe7tN97yn9+ocWY0Bx4H+LCdw8qO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238247; c=relaxed/simple;
	bh=4AnK3us8IwJo5YdFePHARIVeyWxc/DJRbd3XSvmlKhs=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=bQd7ZVZbhmFzHqEJSHiVCM0jOd4QfktW13krQAen2Z6qgskYKb6PpDL532yVeWVeVSjK5S9iS+ANM7kZzW8l1N+BhETdX/snugxh86dMdVAlN2A1OnzI4QDVGl59+Ir1y+PF2FyC9X6BSgOz86CfR8T04Yjux2VWQPUnRJj0fQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fZCrwSmZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A46bApgD2835612, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762238230; bh=nig4mx5fZwUn1M7paOc+JtiVSq3/kEU5oCOSPmEALww=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type;
	b=fZCrwSmZh+UVsR12/SE3HXclWJrPs07xh3mA1D2EuA5+0RwonXTh+1gdCTNTS8Yog
	 dFNH03riu2qCOAvuUjEiZJeQacdr0DDZfd9/ZDHSwcOCPy11LCByHcu/3PUfSJrYRp
	 ESCJiwb7bJUQ+WfGZ6rjyMtbmeZrE3dwVkRWDM/Gb9sY/dqrqXM/ECs1MXbLKBRw1i
	 EjsTQ2RCYSmnbPrXRA9HVeE88zpSLcidZnCRw7miz8O9a0LRWt3/eaY1ejU0Mucv9i
	 cK9Hl6kp9mkMyzdUKp8/tPorvLhk23O1cVFx8b+T5YPvaIPrvz9aK/Y06z8+/h0VWE
	 b6sbBgXL/ISCw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A46bApgD2835612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 14:37:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 14:37:11 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 14:37:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 4 Nov 2025 14:36:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-firmware@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <kevin_yang@realtek.com>
Subject: pull-request: update rtw firmware rtw-fw-2025-11-04
Message-ID: <6896693c-d69a-441f-90d3-0c9ee850eb78@RTKEXHMBS04.realtek.com.tw>
Date: Tue, 4 Nov 2025 14:36:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

The RTL8852BT v0.29.127.0 and RTL8852B v0.29.128.0 need new BT-coexsitence
flow to support them, or BT will get degraded performance. So, revert them
and re-add them with increasing format suffix. When driver updates
BT-coexistence flow, it will declare to support these new format.

Others are to fix XTAL issue for PS resume, including RTL8852BT, RTL8852B
and RTL8851B.

Thank you
Ping-Ke

---

The following changes since commit 4a1728d0f464fbd73560239e2d907f8f3f5614a0:

  Merge branch 'robot/patch-1-1762131560' into 'main' (2025-11-03 17:39:46 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-11-04

for you to fetch changes up to fba88675d06c6828f4492632d00e57fd9d660da3:

  rtw89: 8851b: update fw to v0.29.41.5 (2025-11-04 14:24:51 +0800)

----------------------------------------------------------------
Chin-Yen Lee (5):
      Revert "rtw89: 8852bt: update fw to v0.29.127.0"
      rtw89: 8852bt: update fw to v0.29.122.1
      Revert "rtw89: 8852b: update fw to v0.29.128.0"
      rtw89: 8852b: update fw to v0.29.29.14
      rtw89: 8851b: update fw to v0.29.41.5

Zong-Zhe Yang (2):
      rtw89: 8852bt: update fw to v0.29.127.0 with format suffix -1
      rtw89: 8852b: update fw to v0.29.128.0 with format suffix -2

 WHENCE                   |   2 ++
 rtw89/rtw8851b_fw.bin    | Bin 1162024 -> 1164440 bytes
 rtw89/rtw8852b_fw-1.bin  | Bin 1290952 -> 1242472 bytes
 rtw89/rtw8852b_fw-2.bin  | Bin 0 -> 1290952 bytes
 rtw89/rtw8852bt_fw-1.bin | Bin 0 -> 937688 bytes
 rtw89/rtw8852bt_fw.bin   | Bin 937688 -> 918776 bytes
 6 files changed, 2 insertions(+)
 create mode 100644 rtw89/rtw8852b_fw-2.bin
 create mode 100644 rtw89/rtw8852bt_fw-1.bin

