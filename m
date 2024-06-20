Return-Path: <linux-wireless+bounces-9264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC190FC69
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 07:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE64F1C20D14
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 05:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA40381DE;
	Thu, 20 Jun 2024 05:58:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AC2744C
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863122; cv=none; b=UWaGsYpkcZ5tmKWv15jLIzsCYAY2NhkJkuqitkN+WzVaoyxLadiATEMPev/XSW4HeWzigBOhp9J2wZuT8S9updMj4GlkINBcZEq+8+lrb+xeRh0X6xGMiLLFV5APTMJUb+NLv9geuKUc9iEeJTU45gsZq6B+zV/2TdqERrw59Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863122; c=relaxed/simple;
	bh=zSxsCDR40RJxQiciNVHO7J9NuyHOatUrpSwAyMHSYPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C9jqq4kgtI3P0popSHCXUUD5U5bUpld4p7rk9TLrmJWnkGtu4HaRt95qcFliH2OjpoKdwR/pIGFdy3RXfQ7fr1YFhrIB4tjao5PEKyq1zOn0ZisaybnWhVbTkjd3DkhhScgOjVzbKIeT++IPErUwkCGjXCvr1X0oXSyCX4VnYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45K5waCvB2577625, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45K5waCvB2577625
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 13:58:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 13:58:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Jun
 2024 13:58:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH 0/7] wifi: rtw89: support WoWLAN for more chips and some fixes
Date: Thu, 20 Jun 2024 13:58:18 +0800
Message-ID: <20240620055825.17592-1-pkshih@realtek.com>
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

Some WiFi 6 chips support WoWLAN with different firmware command formats,
and firmware uses the register of WoWLAN reason, so extend to support
them accordingly. During development, we found some drawbacks, so correct
them.

Chih-Kang Chang (7):
  wifi: rtw89: wow: append security header offset for different cipher
  wifi: rtw89: wow: update WoWLAN reason register for different FW
  wifi: rtw89: wow: update config mac for 802.11ax chip
  wifi: rtw89: wow: fix GTK offload H2C skbuff issue
  wifi: rtw89: wow: prevent to send unexpected H2C during download
    Firmware
  wifi: rtw89: wow: enable beacon filter after swapping firmware
  wifi: rtw89: add polling for LPS H2C to ensure FW received

 drivers/net/wireless/realtek/rtw89/core.c     |  3 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 80 ++++++++++++-------
 drivers/net/wireless/realtek/rtw89/fw.h       |  6 ++
 drivers/net/wireless/realtek/rtw89/mac.c      | 29 +++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 20 -----
 drivers/net/wireless/realtek/rtw89/reg.h      |  7 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  6 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  6 +-
 drivers/net/wireless/realtek/rtw89/wow.c      | 33 +++++---
 drivers/net/wireless/realtek/rtw89/wow.h      | 30 +++++++
 15 files changed, 177 insertions(+), 65 deletions(-)

-- 
2.25.1


