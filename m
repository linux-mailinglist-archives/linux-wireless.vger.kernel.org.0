Return-Path: <linux-wireless+bounces-10323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AAB93467D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 04:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38AD1F220C7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 02:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F71018EB0;
	Thu, 18 Jul 2024 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="a0bho/xb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D73175A5
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721271141; cv=none; b=c2bkjzMJud+OOO0vf9tTD+jN04xi14MLxIzEgazxN+RGOOlAOFEwczGKnGkxG2eu8Zwa+mX1W4NkbNVpig+ObT5XEduI6lUpsEv7vTFz6hcjGRGhyExIqESQE1nYZbVXutF6+Cv+L9q/Mm6vSlx8TVEsFzSJye/dSVrsmIk8XP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721271141; c=relaxed/simple;
	bh=FSRxXRYbOMTDJJ5Wr2uhD7sDY9wRQ8IeCakCHv5npPg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hzaEr+S3rtHKfqS1wIJzLgwyREFT4FnenECs7qNou/pZtaOF9XJb/XcUooj6s6UezubMw8+z2AvEZRIWQW/IA5qgxZo3NE3I6OG8ImBcweAUqx3t1od8PY0YxnoFRqn2XewKbE8knYYitijM8ZiTgcoaVifRQjhJWj2BlPe8Mhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=a0bho/xb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46I2qFyaD2860426, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721271135; bh=FSRxXRYbOMTDJJ5Wr2uhD7sDY9wRQ8IeCakCHv5npPg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=a0bho/xbHDH6jB6jvuCRaP9xpOcoHuMdsdN5Nu/pwYxH36jPhdTfMaf03ITA2bjY3
	 JrRD5Q/0JSz0RS4WXbmIgQo9uPNifEVfHdMmXCtp9Kb3fZHBWMXAbAddQb5F0v8oz0
	 2dbdLPtIxC0c0ep8KLdLrKVgDE3bSegPDo6Q/3q/NyUlj8XwOUVpCQbBvbGgjFGknT
	 64t0l8Wi3Ai1luMoFi0EluQm/IJMyrElJLkr+EHHUGC8LVg0A3a0hoVIeaJXI13Bun
	 ZsDbgpMxxEQu/s/l3yGg4JQmQdz9+U+gnA6KCkUMoVekkfWqydJZOLzNHvRnnUVLNj
	 MW2N29/P9qn7g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46I2qFyaD2860426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 10:52:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 10:52:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Jul
 2024 10:52:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: 8852bt: enable 8852BE-VT
Date: Thu, 18 Jul 2024 10:51:32 +0800
Message-ID: <20240718025138.18777-1-pkshih@realtek.com>
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

Add remaining materials and enable 8852BE-VT. Fow now, STA, AP and P2P
modes can work well, and throughput is around 900+ Mbps for TX/RX. Only
BT-coexistence code needs further update to work with BT enabled.

Ping-Ke Shih (6):
  wifi: rtw89: 8852bt: add set_channel_rf
  wifi: rtw89: 8852bt: add chip_info of RTL8852BT
  wifi: rtw89: 8852bt: add chip_ops of RTL8852BT
  wifi: rtw89: 8852bt: declare firmware features of RTL8852BT
  wifi: rtw89: 8852bte: add PCI entry of 8852BE-VT
  wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig

 drivers/net/wireless/realtek/rtw89/Kconfig    |  12 +
 drivers/net/wireless/realtek/rtw89/Makefile   |   8 +
 drivers/net/wireless/realtek/rtw89/coex.h     |   2 +
 drivers/net/wireless/realtek/rtw89/fw.c       |   4 +
 drivers/net/wireless/realtek/rtw89/fw.h       |  17 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   7 +
 drivers/net/wireless/realtek/rtw89/mac.h      |   6 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  58 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    | 830 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852bt.h    |   2 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 226 +++++
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |   3 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  93 ++
 13 files changed, 1264 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bte.c

-- 
2.25.1


