Return-Path: <linux-wireless+bounces-4577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6AF878C5E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 02:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2A01F21214
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 01:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F46210E3;
	Tue, 12 Mar 2024 01:38:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC195EC3
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207516; cv=none; b=isN77oaC4MyYwH5aeCbNGHi17oFBiKh25mTlbFOwPD5vbosXU21HJ1IPgZacZOzN+ShjP8i2JjV0ajxGcNU9/xac2/SG7G19Fa9DvYnfMT4E1bX5HaW+IqK+JE67Y9SPV3cWeDFmfnULT+mY9f+9FvUvi9HQymttoekg4UT/iyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207516; c=relaxed/simple;
	bh=sBaawW/FnZ4SJ7p1aFmGljmnmCqxEUprrs0YUg5AYlM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WS7ZRi50/HBELCSSw1BgrmoUSZ08F//Y0Tmdn2j52ooaoClPsfuQMOvU7wde0ctK+cxK0PTeL0mM9zoAioXQ0ioDJmHQz+/24CtAx+goozGUE16czN8ybl7+BPpyI7Gs2PE06AP/QOUyjq6dVId3NvOyTsduyqrhMMdda2bdnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42C1cQH413941682, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42C1cQH413941682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 09:38:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 09:38:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 12 Mar
 2024 09:38:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/6] wifi: rtw89: add BT-coexistence materials for 8922A and enable 8922AE
Date: Tue, 12 Mar 2024 09:37:15 +0800
Message-ID: <20240312013721.17452-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The more BT-coexistence materials are added by this patchset to have
initial basic functions, and WiFi features of STA, AP and monitor modes
are also ready now, so we can enable 8922AE.

Since new files are added to Kconfig/Makefile, apply checkers of sparse
and smatch to this patchset, and no any error/warning is reported.

v2:
  - (patch 1/6) fix unused-but-set-variable warning reported by
    kernel test robot <lkp@intel.com>.

Ching-Te Ku (5):
  wifi: rtw89: coex: Add WiFi role info format version 8
  wifi: rtw89: coex: Add antenna setting function for RTL8922A
  wifi: rtw89: coex: Add TDMA version 7
  wifi: rtw89: coex: Add TDMA slot parameter setting version 7
  wifi: rtw89: 8922a: update chip parameter for coex

Ping-Ke Shih (1):
  wifi: rtw89: 8922a: add 8922ae to Makefile and Kconfig

 drivers/net/wireless/realtek/rtw89/Kconfig    |  15 +
 drivers/net/wireless/realtek/rtw89/Makefile   |  12 +-
 drivers/net/wireless/realtek/rtw89/coex.c     | 964 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/coex.h     |  72 ++
 drivers/net/wireless/realtek/rtw89/core.h     | 108 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  42 +
 drivers/net/wireless/realtek/rtw89/fw.h       |  27 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 156 ++-
 8 files changed, 1285 insertions(+), 111 deletions(-)

-- 
2.25.1


