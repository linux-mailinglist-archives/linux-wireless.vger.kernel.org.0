Return-Path: <linux-wireless+bounces-17359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2DAA0A6DB
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9790167520
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 01:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8474915C0;
	Sun, 12 Jan 2025 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jqEdIqs0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C2E79E1
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736646137; cv=none; b=ncMuPaZ//xOzsYxq4Dsdt34Q1c2V/NNQ4TkSCOtfKyE+mA5BtGUTGZ5Uo/EUf6KBo7Tq1bmG/WhGgWt9D2D/afZzuunr/AvE1vRNaL7eHoglAD6fc39C5ag87DakhTFNytde2+sghqs9XZONuOzdeJSnJTzymWTdzWp+h3jhl6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736646137; c=relaxed/simple;
	bh=XeQN7KCQMlUAJ/QhIsO+RPn+Yc1dnOwsVoNo11KVq3I=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date; b=aEN1ZZETUjEsaWaFwOaeF0EdY5K5CRVJMkEAKu/k2criUjxfrt3Pl8FUi/ZI1vIpG0wmliQ/IksHKSVlqmqX7sns04QXGcgzRMUntk39Oxtu2+i/EwjuUsrCrDDRzm0TGmVoAfUpHSGDZwC/wjjYOsXSBS0u1CivDrR52H3tmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jqEdIqs0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C1g3JI11576346, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736646123; bh=XeQN7KCQMlUAJ/QhIsO+RPn+Yc1dnOwsVoNo11KVq3I=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=jqEdIqs0TIsjV+aiG64537G57mCfg3M73CI0YNW45/KXlSB8gIJDS60szSKToCAkQ
	 ZEU3B77GP3WqKgg0ua7pRSSBmTR4Zh089XxsiKzYwyuPnnNw6QjUXJfi5dpz1C5Tyz
	 Mqrr/l6GWsMas74pamxnLme8Ck4FkqsB/qP5C3r1l5NIw4QZ06/UWzRSuxh02D9jYv
	 qb5xekvVlWwzMgeJYp5omYgMwTHWiERYFFetrP7wLYY23+m7Vk4m0VMsHooqke8ZWF
	 JxQoil2YI/q4+NEeFqZDfsalxSSwrbUTex5fphBbiLB981gdAzNjwG59ceknuzpdw+
	 sd/i+ZcV2ac3Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C1g3JI11576346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 09:42:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 09:42:04 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 09:42:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-firmware@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>,
        <phhuang@realtek.com>, <phhuang@realtek.com>
Subject: pull-request: update rtw89 firmware by rtw-fw-2025-01-12
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <82c98b21-326f-4694-86cb-5d6af04a9166@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 09:42:03 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

Update rtw89 firmware including RTL8852B, RTL8852BT, RTL8852C and RTL8922A.

Thank you
Ping-Ke

---

The following changes since commit 7673dffd5e3324a726caf8bfc0f1a005862f5f16:

  Merge branch 'robot/pr-0-1736442209' into 'main' (2025-01-09 17:11:19 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-01-12

for you to fetch changes up to f495ed8a143a4e1844cd18f875c82f2823843d02:

  rtw89: 8852b: update fw to v0.29.29.8 (2025-01-12 09:33:44 +0800)

----------------------------------------------------------------
Kuan-Chung Chen (1):
      rtw89: 8922a: update fw to v0.35.52.1 and stuffs

Ping-Ke Shih (3):
      rtw89: 8922a: update fw to v0.35.54.0
      rtw89: 8852c: update fw to v0.27.122.0
      rtw89: 8852b: update fw to v0.29.29.8

Po-Hao Huang (2):
      rtw89: 8852b: update fw to v0.29.29.7
      rtw89: 8852bt: update fw to v0.29.110.0

 WHENCE                  |   1 +
 rtw89/rtw8852b_fw-1.bin | Bin 1242808 -> 1244784 bytes
 rtw89/rtw8852bt_fw.bin  | Bin 897512 -> 913992 bytes
 rtw89/rtw8852c_fw-1.bin | Bin 2180616 -> 2375560 bytes
 rtw89/rtw8922a_fw-3.bin | Bin 0 -> 1725278 bytes
 5 files changed, 1 insertion(+)
 create mode 100644 rtw89/rtw8922a_fw-3.bin

