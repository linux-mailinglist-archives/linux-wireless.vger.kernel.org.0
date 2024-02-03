Return-Path: <linux-wireless+bounces-3068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D635B847DDC
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 01:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646F71F2AE54
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 00:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCFD626;
	Sat,  3 Feb 2024 00:33:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3E622
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920418; cv=none; b=p0wUdN0Ig9071SwdSvtZJUVMD6TGE7yAdgARXuBJJxQyWn7APL1OgTb88y2nmLnz2Mw4rmvpUxgqFlRfgOXR6HkUzBH+NOdoliB32seK4rrpv3q3Jn4brX4dLRz0JLcOFAtmJC1JySEmLytgkLcYpQvhWQATOafEovlxRBEwyaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920418; c=relaxed/simple;
	bh=t1QD/HaNJ8fP0UavPWDtfQjiDac8zWLfH0U10n7OVUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FEEMCgYADtwAOB4XIE3WCoUP57/uZdyUIKiNeTzoHHOnuBFJn4DfUBJWX4uizsE0EpsFYxfEh/FuN5uiifWUweolvCC+GI388J63RVQn+bJa4oKPTfB14qjq17eXBIsd+hy+1GQJPWwutdRsr+WklyzN95YaDio0qoySI49qYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4130XQ5D02300742, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4130XQ5D02300742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Feb 2024 08:33:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sat, 3 Feb 2024 08:33:27 +0800
Received: from [127.0.1.1] (172.16.16.254) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 3 Feb
 2024 08:33:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: fw: support firmware secure boot
Date: Sat, 3 Feb 2024 08:32:47 +0800
Message-ID: <20240203003251.10641-1-pkshih@realtek.com>
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

Firmware secure boot is to ensure firmware running on chip is the one
which is signed and released officially. Without this, it will be failed
to download firmware result from wrong security key data.

The main difference between secure and non-secure boot is content of
secure section, which is one type of many firmware sections, and is to
provide key data.

The basic steps for key data are:
 1. read cryptography method and key_index from efuse (patch 2/4)
 2. parse firmware file to select secure section by the information of
    step 1 (patch 3/4)
 3. download firmware with selected secure section and key data (patch 4/4)

Ping-Ke Shih (4):
  wifi: rtw89: fw: consider checksum length of security data
  wifi: rtw89: fw: read firmware secure information from efuse
  wifi: rtw89: fw: parse secure section from firmware file
  wifi: rtw89: fw: download firmware with key data for secure boot

 drivers/net/wireless/realtek/rtw89/core.h     |  15 +
 drivers/net/wireless/realtek/rtw89/efuse.h    |   1 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c | 142 +++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 296 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h       |  47 ++-
 drivers/net/wireless/realtek/rtw89/pci.c      |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   3 +
 7 files changed, 484 insertions(+), 22 deletions(-)

-- 
2.25.1


