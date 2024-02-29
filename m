Return-Path: <linux-wireless+bounces-4229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2FF86C2C8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6501F23AB1
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6304C619;
	Thu, 29 Feb 2024 07:46:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36A47F73
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192779; cv=none; b=pwl6HOiWjDg9NqinyywB7PLFEFN9IqrOd1r6rnXqttVMh+NSKNlo6r/SGdgZxHkA4cS6ZHfnjBUfNjcBWLON2J/YL3tMkgHxtC7co7GYzFow0h9UzpMJ/u7vFk5AA18H+BGaZm60z2O3n3z8/vcLKxF5YEZHQG68T2ea3d0j+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192779; c=relaxed/simple;
	bh=FBbfPqbmV+HelVe/UDyphIgGVCiIRNT5yyoe8/asKDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o/a5//GHbYiENHMEtUvNT0PzftSSLELovy/iRlCw38zN8y8LYCVN1fHClWEWm2CUApP6pr324plurqA1F+WxyiWnvAEllOKFPg39ox4mK91NeHCGTBqwgqC7DWjFnElqyBvhjoYIScgLD9dgvaVlaWchLfyaN7NQ2njQob8mn8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T7k89T11229751, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T7k89T11229751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 15:46:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 29 Feb 2024 15:46:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 15:46:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: 8922a: add BT-coexistence materials to initialize 8922A
Date: Thu, 29 Feb 2024 15:45:06 +0800
Message-ID: <20240229074514.219276-1-pkshih@realtek.com>
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

BT-coexistence adds new format of H2C command to use u8 data type as
possible as it can to reduce endian transformation, such as le16_to_cpu().
8922A is first chip to use these new format, so prepare these stuffs before
enabling 8922AE. The new format is also needed by newer firmware of other
chips, so also prepare for existing chips in advance. 

First two patches are helpers of MAC to control grant to BT for WiFi. The
other patches are to add new introduction format used by newer firmware.

This patchset is partial patches related to BT-coexistence, and I will
send out remaining five patches by another patchset in coming days.

Ching-Te Ku (6):
  wifi: rtw89: coex: add init_info H2C command format version 7
  wifi: rtw89: coex: add BTC ctrl_info version 7 and related logic
  wifi: rtw89: coex: Reorder H2C command index to align with firmware
  wifi: rtw89: coex: add return value to ensure H2C command is success
    or not
  wifi: rtw89: coex: When Bluetooth not available don't set power/gain
  wifi: rtw89: coex: Add coexistence policy to decrease WiFi packet
    CRC-ERR

Ping-Ke Shih (2):
  wifi: rtw89: mac: add coexistence helpers {cfg/get}_plt
  wifi: rtw89: 8922a: add coexistence helpers of SW grant

 drivers/net/wireless/realtek/rtw89/coex.c     | 393 ++++++++++++------
 drivers/net/wireless/realtek/rtw89/coex.h     |  20 +
 drivers/net/wireless/realtek/rtw89/core.h     |  90 +++-
 drivers/net/wireless/realtek/rtw89/debug.c    |   9 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 112 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  45 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   8 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |  25 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 117 ++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  49 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 150 ++++---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  64 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  64 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  64 ++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 112 +++++
 15 files changed, 1061 insertions(+), 261 deletions(-)

-- 
2.25.1


