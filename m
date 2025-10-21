Return-Path: <linux-wireless+bounces-28140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC682BF6D03
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 15:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0240D4EF47C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9230E2F39D0;
	Tue, 21 Oct 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OPPyE1xK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91902253EB
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053666; cv=none; b=Sw3Ma+L75UgHN6D5ithJVMGyEJtYZ84Q3ZupoQBNDe+YiGPoys83D7CuuSWhbXOEV0O1eF3RtajcEIjLmiV5uCpYgS0tn0m6sNeRptAQXNw7/og6CoowVF9A41LfzgMfNz3v4yMsIshpzpvNekStthVpH1H9ElCb3Y7Gnbq4mpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053666; c=relaxed/simple;
	bh=TSxcIehMshmWOZvgjJGKlvyuQIkXAT04o0hUeo20YFw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mhiHnNbN8iVil2EE0ZnNeEKfnsp3RZZSZn9OCbYJdPNaBNrdY9ZnMoG/hO6WEOcX425/YTp75e7eUPe9Cq9wkhPmgrI8m3E4sLjbnhANcFoIkABQJDXSCVnS51tO/lE+2HagKyybJ6gcfDX5hWxFgsGtUBRxPXSkHe6Mj4BjeJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OPPyE1xK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59LDYIR703088091, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761053658; bh=Y7RSkWejKFMnYUbm7nCq/8+qPXKNAG1HBHRckE0IL1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=OPPyE1xKtHnLCmMt/WvWz51zKdxcPaZhLGQgSltyRJhO0+677+aLF0/0mS0/tQvOX
	 F7jbTWS9Kg76t9t+Q4Q1BnZZyJzh2cYVlYS1qBlyTizR9D36sGM/UbxmsLEl/uHTCA
	 UxN+ksApnfqpxdA9NHPrzmgw3d9P40/jXnvbHzI5hSMgER3o4DmDOcXayaqChbUGJ2
	 8nA9f3dZ/V4eYG/ykcTfWjwM3aP5rhb4Pv2z1Ou5AYtEm64N5WPUk9iYWt4sVjSAPA
	 rgogSsMQ5XrNsUOPjeit2WKePf78Tjd91fnvQaxCy7TuVzfVFobm+skb/JlMLXoXgV
	 RN3VKuBNuve+Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59LDYIR703088091
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 21:34:18 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:18 +0800
Received: from [127.0.1.1] (10.22.225.127) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 21 Oct 2025 21:34:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <emma_tsai@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [rtw-next 0/8] wifi: rtw89: some fixes and improvements
Date: Tue, 21 Oct 2025 21:33:54 +0800
Message-ID: <20251021133402.15467-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

First two patches are to prevent potential racing in C2H work queue,
because it doesn't add locks properly. Third is MLO link switching
handling. Forth is to support fix rate of EHT rate. Fifth is to correctly
apply country code programmed in efuse.

Also, correct RF setting to improve RTL8852C performance. The next one
is to recover firmware from abnormal states if power-save functions
work improperly. The last one is to improve scan time in 6 GHz band.

Chin-Yen Lee (1):
  wifi: rtw89: restart hardware to recover firmware if power-save
    becomes abnormal

Jui-Peng Tsai (1):
  wifi: rtw89: improve scan time on 6 GHz band

Kuan-Chung Chen (1):
  wifi: rtw89: 8852c: fix ADC oscillation in 160MHz affecting RX
    performance

Ping-Ke Shih (2):
  wifi: rtw89: splice C2H events queue to local to prevent racing
  wifi: rtw89: use skb_dequeue() for queued ROC packets to prevent
    racing

Zong-Zhe Yang (3):
  wifi: rtw89: mlo: handle needed H2C when link switching is requested
    by stack
  wifi: rtw89: support EHT rate pattern via bitrate mask
  wifi: rtw89: regd: apply ACPI policy even if country code is
    programmed

 drivers/net/wireless/realtek/rtw89/core.c     | 31 +++------
 drivers/net/wireless/realtek/rtw89/core.h     | 12 ++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 39 ++++++++---
 drivers/net/wireless/realtek/rtw89/mac.c      |  7 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 64 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 39 ++++++++++-
 drivers/net/wireless/realtek/rtw89/ps.c       | 23 ++++++-
 drivers/net/wireless/realtek/rtw89/regd.c     | 22 +++----
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 59 +++++++++++------
 9 files changed, 227 insertions(+), 69 deletions(-)

-- 
2.25.1


