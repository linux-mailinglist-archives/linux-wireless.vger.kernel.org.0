Return-Path: <linux-wireless+bounces-5858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ED4898342
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F6C1C20E68
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1E70CDB;
	Thu,  4 Apr 2024 08:38:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0144E70CC7
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219886; cv=none; b=tMo7LJa/O5pDlqK8uKAPQR7rRUEAQCxYKJ4QABFg5AS8bxic1EEOrWW4FXmq8frqvXZhm3CRJayxbJOxg+uoO1qR39LgZ/R6kf5TaNswpy25TsE+jSd87qSk89qXhS3miB3KIHyU0Hm7ctJg9BHv4QjnGgTqZq7nqmiNVApaXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219886; c=relaxed/simple;
	bh=NuV95ONaFuDfLwh9ctYYW/CrbThCBP9qgkH0DN7KFUY=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=sHMUd+YgWJF6kHTT5zu6WYqw9jJH9i2oS0EammHsmtOkWPUsaDJ7yUdtdD5rlJul7z6yw6O3Ah0rJJAgYyoZAdsGzZcMWslwIFcFn7exBbiuPc0l89Z1kL5o4wSqJdZs6pAEmcSkyPUM5/IK6eF7tTJaZxTSIFB5XfFMYeReuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4348c07P11787183, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4348c07P11787183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 4 Apr 2024 16:38:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 16:38:00 +0800
Received: from [127.0.1.1] (172.16.16.152) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 16:38:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2024-04-04
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <fc4ed5d9-e93d-4f5c-8f25-df28990ed363@RTEXMBS04.realtek.com.tw>
Date: Thu, 4 Apr 2024 16:38:00 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

This is first pull-request of rtw-next to wireless-next tree, more info
below. Please let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit c76936a7e1da6b755185ada84acb2c2b92fdd30c:

  wifi: mwifiex: Add missing MODULE_FIRMWARE() for SD8801 (2024-03-18 18:12:55 +0200)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2024-04-04

for you to fetch changes up to 155b10aba42800df16b71bc96876fb2a65a824c2:

  wifi: rtw89: 8922a: configure UL MU/OFDMA power setting (2024-04-04 15:54:05 +0800)

----------------------------------------------------------------
rtw-next patches for v6.10

Some fixes and changes of capabilities detailed in following:

rtl8xxxu:

 * enable MFP support

rtlwifi:

 * some cleanups

rtw88:

 * disable unsupported interface type of mesh point for all chips, and only
   support station mode for SDIO chips.

rtw89:

 * fixes of 8852b, 8852c and 8922a

----------------------------------------------------------------
Chia-Yuan Li (2):
      wifi: rtw89: disable txptctrl IMR to avoid flase alarm
      wifi: rtw89: download firmware with five times retry

Chih-Kang Chang (1):
      wifi: rtw89: 8922a: update scan offload H2C fields

Ching-Te Ku (1):
      wifi: rtw88: coex: Prevent doing I/O during Wi-Fi power saving

Dmitry Antipov (2):
      wifi: rtlwifi: drop WMM stubs from rtl8192cu
      wifi: rtlwifi: always assume QoS mode in rtl8192cu

Kuan-Chung Chen (1):
      wifi: rtw89: 8922a: configure UL MU/OFDMA power setting

Martin Kaistra (1):
      wifi: rtl8xxxu: enable MFP support

Ping-Ke Shih (4):
      wifi: rtw88: station mode only for SDIO chips
      wifi: rtw89: 8852c: add quirk to set PCI BER for certain platforms
      wifi: rtw89: 8852c: disable PCI PHY EQ to improve compatibility
      wifi: rtw88: remove unsupported interface type of mesh point

Po-Hao Huang (3):
      wifi: rtw89: 8922a: download template probe requests for 6 GHz band
      wifi: rtw89: 8922a: add beacon filter and CQM support
      wifi: rtw88: Set default CQM config if not present

Zong-Zhe Yang (1):
      wifi: rtw89: 8852c: update TX power tables to R69

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   9 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    | 195 ++++++---------------
 drivers/net/wireless/realtek/rtw88/coex.c          |   4 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |  14 +-
 drivers/net/wireless/realtek/rtw88/fw.h            |   2 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |   2 +
 drivers/net/wireless/realtek/rtw88/main.c          |  18 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  24 ++-
 drivers/net/wireless/realtek/rtw89/core.h          |  11 ++
 drivers/net/wireless/realtek/rtw89/fw.c            |  56 ++++--
 drivers/net/wireless/realtek/rtw89/fw.h            |   4 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  91 ++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h           |  13 ++
 drivers/net/wireless/realtek/rtw89/phy_be.c        |  18 ++
 drivers/net/wireless/realtek/rtw89/reg.h           |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   1 +
 .../net/wireless/realtek/rtw89/rtw8852c_table.c    |  90 +++++-----
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |  23 +++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |   1 +
 26 files changed, 369 insertions(+), 218 deletions(-)

