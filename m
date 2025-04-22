Return-Path: <linux-wireless+bounces-21805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDC4A95A9F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46408172217
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6558215A856;
	Tue, 22 Apr 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nIffhjgR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1034156678
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286425; cv=none; b=FhnYg3vLKypb2yFkdi8D2UnWLp2G1M5GdBPmEt50mfbj6QtCUbFG6G4/cxolUnV8iqhOFMHlkMPY+3LxXFDb+iCx39dD+93EiAaH6sE38FRIOfCD9AyApiEtHCEhVJbtPjCzxw264ozSngAL78G37ETKzWUpwRyAHjO1kRvzkgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286425; c=relaxed/simple;
	bh=zkEsvz9HdVcTdKxc1Wr2iHMYcPN6BZI4DbeGAkNIqQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z09NLy7skmVAJBX1r4EpSfgBcwji5OAZtAq5zfERGUpp7qM7Hv/I51OGfa42BEdEwk+MmDl3lDsVK74raPOljuFlWJdz9TpsRWDYpD/uodQmMDMlGhr6DNRqnWd8rQPXfmrKsC7Vzlkql4IUFw+/QFzM3uhkXp+Eb1D9VmEUfOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nIffhjgR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1kvoX73859465, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286417; bh=zkEsvz9HdVcTdKxc1Wr2iHMYcPN6BZI4DbeGAkNIqQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=nIffhjgRA5+sLUeYG1O8iDmqAoJX89OpE4C1TsXhYIYyzzUlerP49IT6tu4K5ydlf
	 vZp9WxFgBWZfQctQqV6CgSDeG9jLoLJK8tCda9DuR5t0rocsqgwiQghvqj3xh2Daj1
	 KF9jdiqXoPxWAZxU1dsydG946t9sO+qfY4TlG3FBeDEir4tkTdmL7xuRt7Sh6kSzwI
	 RQJdKzkHedwW9/iSXqkh13KZzdo6s2esyCfDW0BHX0OiB2b7qW9qZi1GbIrXKe98/t
	 agHGMBKJ+CV4qkGQ65lgt1A01LjdGL0p5OxKyoMS+60t2AlHl7w7XPhc/mS7bc6ivK
	 DuIQT+yCwOE2A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1kvoX73859465
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:46:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:46:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:46:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/12] wifi: rtw89: fine tune STA + P2P concurrency
Date: Tue, 22 Apr 2025 09:46:08 +0800
Message-ID: <20250422014620.18421-1-pkshih@realtek.com>
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

Mainly this patchset is to fine tune time slot assignment for STA + P2P
concurrency. Since the TSF of connected AP is fixed and roaming is
possible, it is not possible to arrange GO TSF with a fixed offset.
Therefore, adjust time slot case by case to have better user experience.

The patch 1/12 is to enlarge time that driver determines AP is gone.
In field, some AP stop issuing beacon somehow. With larger time,
connection can stay over 24 hours.

The patch 2/12 is to update ACPI format for TAS, which we can specify
to enable certain countries.

Kuan-Chung Chen (2):
  wifi: rtw89: 8922a: increase beacon loss to 6 seconds
  wifi: rtw89: acpi: introduce country specific TAS enabling

Zong-Zhe Yang (10):
  wifi: rtw89: add suffix "_ax" to Wi-Fi 6 HW scan struct and func
  wifi: rtw89: refactor flow that hw scan handles channel list
  wifi: rtw89: mcc: make GO announce one-time NoA for HW scan process
  wifi: rtw89: don't re-randomize TSF of AP/GO
  wifi: rtw89: mcc: make GO+STA mode calculate dynamic beacon offset
  wifi: rtw89: mcc: handle the case where NoA start time has passed
  wifi: rtw89: mcc: update entire plan when courtesy config changes
  wifi: rtw89: mcc: support courtesy mechanism on both roles at the same
    time
  wifi: rtw89: mcc: refine filling function of start TSF
  wifi: rtw89: mcc: avoid that loose pattern sets negative timing for
    auxiliary GO

 drivers/net/wireless/realtek/rtw89/acpi.c     |  45 +++
 drivers/net/wireless/realtek/rtw89/acpi.h     |  16 +
 drivers/net/wireless/realtek/rtw89/chan.c     | 191 +++++------
 drivers/net/wireless/realtek/rtw89/chan.h     |   8 +
 drivers/net/wireless/realtek/rtw89/core.c     |   4 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  18 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 315 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h       |  23 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  14 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |   5 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  11 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   2 +
 drivers/net/wireless/realtek/rtw89/regd.c     |  13 +-
 drivers/net/wireless/realtek/rtw89/sar.c      |  14 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |   1 +
 15 files changed, 479 insertions(+), 201 deletions(-)

-- 
2.25.1


