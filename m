Return-Path: <linux-wireless+bounces-18279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413BEA25310
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 08:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E015E3A25D2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 07:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4361E7C24;
	Mon,  3 Feb 2025 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gbEGQ93n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D541E7C09
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738567792; cv=none; b=SWMsuYI0J/VLr3Fz7brle6d+7G2jFyvVvwXOchuFNKUrjde/vzBpKyQFlMCSHLDeidQgwJyjsCknaASI+gEvoIL+/eJ5S7gDC8ok7lXGxushWvIex8fkHTGPyS4znDkOBIvRj13ZZPjED5amFR1NNRX/a94iuVEc1468HxRY5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738567792; c=relaxed/simple;
	bh=U+AwvA1aEA88sQiNyCRPZmjf7FBTl9Q8ppZ1tTRU5qY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hrY1Q/QJV3FgYfJ0RgrTdNgEj1VHe7tGcPSxvqo74qQQiLg3DKAp4+bwk7fVqKmd4ZwZoO/z9XvHSbDgMWpdNxpA5i/5gzYUVG/i6As5O8e5WaXb6nEjeB+0xJzUtzNPwrBXvGkhBZSBN+lWtn8xBROg6eSPKeLjfxaFkEWWq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gbEGQ93n; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5137TjIF21321528, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738567785; bh=U+AwvA1aEA88sQiNyCRPZmjf7FBTl9Q8ppZ1tTRU5qY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=gbEGQ93njMgPOUxoZyzIMdfK5n1GOauByQCVn1aYrvFUvdQi+cuSouRqoC6pVSX3t
	 1DCpwwh+Fp7oBM3bx/eme5m5YgDi/Jo38RIRfFRW5ZaNFd7LMhsxkeHXMLij+ct+O3
	 cFFP5DYwKGeycXgnOxbr0H4sMJUdTAGFdCNAz1U8i6b5Qq0wpcw1dTCiD0M8FVLkWS
	 AhNxxShcASfz5PAjLthWRMQ/a5hpR+1iSE87FcT7l1zsM4wskfJLTYdcZMrfK9qN8p
	 Uu71tkrH3twzUp7PR5ejRWCmuIJWrP8yMScODvxS1rqBQ/SnhulJAv5rPxFZeS7USB
	 2CPJreOIH2YyQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5137TjIF21321528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 15:29:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 15:29:45 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 15:29:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>
Subject: [PATCH 0/4] wifi: rtw89: update firmware related stuffs
Date: Mon, 3 Feb 2025 15:29:07 +0800
Message-ID: <20250203072911.47313-1-pkshih@realtek.com>
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

This patchset contains some firmware stuffs. Patch 1/4 is to read hardware
version from efuse earlier to select proper firmware. The second patch is
to update firmware H2C command format related to configure more data in
PS mode, because at that moment firmware handles more works relying on
these data. The last two patches are to fix warnings reported by Coverity,
as firmware is released by us, the pointed problems should not happen.

Eric Huang (1):
  wifi: rtw89: ps: update H2C command with more info for PS

Ping-Ke Shih (3):
  wifi: rtw89: call power_on ahead before selecting firmware
  wifi: rtw89: fw: validate multi-firmware header before accessing
  wifi: rtw89: fw: validate multi-firmware header before getting its
    size

 drivers/net/wireless/realtek/rtw89/core.c | 28 +++++++----
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 58 ++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h   |  6 ++-
 drivers/net/wireless/realtek/rtw89/mac.c  | 29 ++++++++----
 drivers/net/wireless/realtek/rtw89/mac.h  |  1 +
 6 files changed, 103 insertions(+), 20 deletions(-)

-- 
2.25.1


