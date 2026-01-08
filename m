Return-Path: <linux-wireless+bounces-30544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E00C4D03E23
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD8073067458
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227C484A04;
	Thu,  8 Jan 2026 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QRq0d5HD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836694849F7
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873807; cv=none; b=rl1Biyu0IOncN5ITPk05BsFFedYndiXu7Xi15h1HFyMB7IQbJ5ThqBW2itQlWfAROK/1UI0DhDFkHBgYkEOhfIsSQ/07J75QcvYfD0MbMyNbkutLFIL2cx/iQDHPNUKPNGrkTEnqghhwfiYzf0FI1+G12M2+HqlIJS4G+GaDvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873807; c=relaxed/simple;
	bh=REGt7qGY85gr5V6v0kWD8otmta9laUlydi3kTpkBZgk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=goEt1guQe158uZYc5WHg2hZraOmEpv6wX8MQHkMhmrqQONpXrYvE527+YQo5BEhbRQcJQk9kfyggCIenBZOeBviFfvT0cF/umgsHmLR+HOjLIOFzpyRZ/KpcAoUXuzJVaWUKloIrwnpBmOkCJcQ6k7D7Jq/CLV8nFtcOzLA/q6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QRq0d5HD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C3KpD4969679, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873800; bh=6OAZZffn3DoZkgVQ/l3hwAYAPMjDMiVeLIMNvydxdZg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=QRq0d5HDb6lK5+3zzsCO6xveZLgRZYMQFdI1BNmZ223X0XTOHOcD1KyaqqhXRQLj0
	 wJ6b9TGKfYcXxu5B3qtx0Qknx8jx/DHAJ2iWfSCAi3AY8TxetbEqnDEzBFEyaSypFE
	 h7aWyFcZlpx+C9iwTLTL7S95r3gNLMxK1T1Ig6wDIums26Yi/eejfJv3mvasvJuXf0
	 4dKfu6R14v+ZgRtoLa25J5naLpIJwkF/Hv4XWyrYFBQ4JUZs0N4JxQFnXvwrA6gitO
	 WgWD600A1sBXBi2RF80dQbNIzmmd4hPsDnte6ybjzAmzns9BQW2GbmrZIlyXYrDnuw
	 hl5BH/6Fs17Mg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C3KpD4969679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:03:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:20 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:20 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:03:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 00/13] wifi: rtw89: prepare changes of MAC part for RTL8922D
Date: Thu, 8 Jan 2026 20:03:07 +0800
Message-ID: <20260108120320.2217402-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The MAC part changes of RTL8922D includes helper of coex, quota of
PLE/MPDU/WP, pre-load, pre-init, EDCCA and etc. Add them according to
hardware changes.

Chia-Yuan Li (1):
  wifi: rtw89: coex: update coex software control for RTL8922D

Ping-Ke Shih (12):
  wifi: rtw89: coex: make coex scoreboard as chip info
  wifi: rtw89: coex: update scoreboard value according to power state
    for two BT
  wifi: rtw89: mac: remove unnecessary return from
    rtw89_fwdl_secure_idmem_share_mode()
  wifi: rtw89: mac: add dle_mem and ple_{min,max}_qt quota for RTL8922D
  wifi: rtw89: mac: set quota 13 for PLE SNRPT
  wifi: rtw89: mac: update MPDU quota according to chip DLE definition
  wifi: rtw89: mac: update WP quota for RTL8922D
  wifi: rtw89: mac: define preload_init for generations
  wifi: rtw89: mac: configure DMA_STOP1 by predefined mask
  wifi: rtw89: mac: separate functions of CMAC power and function enable
  wifi: rtw89: mac: add an entry to enable MAC function in preinit
  wifi: rtw89: mac: set EDCCA configurations for RTL8922D

 drivers/net/wireless/realtek/rtw89/core.c     |   1 +
 drivers/net/wireless/realtek/rtw89/core.h     |  36 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  70 +++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  49 ++-
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 348 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/pci.h      |  25 --
 drivers/net/wireless/realtek/rtw89/pci_be.c   |   4 +
 drivers/net/wireless/realtek/rtw89/reg.h      | 294 ++++++++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 +
 14 files changed, 767 insertions(+), 66 deletions(-)


base-commit: baef3d5d96d2f7530011cdebd7aeecdc85cd93a7
-- 
2.25.1


