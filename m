Return-Path: <linux-wireless+bounces-18481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 018CCA28156
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 02:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1D418837AC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 01:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D91C522A;
	Wed,  5 Feb 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OrSJ69XS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3842F5A
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738719194; cv=none; b=QkrAQNxgBFvFmJCa5V32HoYkvrUUdpovSddsA7xFl8OsOBZe2GLh7tKFRO8DX4a8Y24GxheVeskypieF6rfvNKJjE194iA2QkOPPtaV/Hjj2S1VHG5YAklp/5I3W2Q2+CfhiZAufK8O7WzCS+l6O915oDLa6W2txcNqmSG1uSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738719194; c=relaxed/simple;
	bh=0fRu6PYQj9QSyJvvwGFEcWy1/00onsYtFKtJPsm8MM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iP4WTNbZtR3/LnuQi2jhyFK737vGPc5SoD5BXS+7Al1QMsXqppy4OTKvjevikclvpjeRgUZGOB+/41yqTSd4LpZaqspqFIMKc0e+FbYhddbKt0sXzOP0c30XFU/x5gB6kXpKveLrlmwpw4BqAKVl6KGUnY+o59ZHc4THk4xrpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OrSJ69XS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5151X9rP4761237, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738719189; bh=0fRu6PYQj9QSyJvvwGFEcWy1/00onsYtFKtJPsm8MM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=OrSJ69XSaSfV3w5W+64gjqsXnfIKKaJag63huJ86g8WP9MC0s5o/ZYekfsVDsy8AN
	 l8X2cxaP0G/CA/mg1jHjVD58ye8SVgDhzMmB87z+w4Ya60AJwUK5dAyxhz/7vGZfrS
	 HqcWpEyPuF4eLWj24Hpq3UHwYqjUYE31UXDu2TtitZ3qTfm5/++uA+/KAnhj7oC9kd
	 rs+GsvbOJuT3XaCbL1piBaGCy96jgvMZRdv8mcb59jdl8ssNmm+YbGn3hSbJYX/g20
	 i6Q+NTKh2/uVeBn8pKTB7OskdzXmcbQI82ZgOzgsjwAiYQM160wJGy30RGYraNXI2X
	 xHpA2kdsZkpsA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5151X9rP4761237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 09:33:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Feb 2025 09:33:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 5 Feb
 2025 09:33:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 0/3] wifi: rtw89: coex: improve user experience with TWS Bluetooth devices
Date: Wed, 5 Feb 2025 09:32:30 +0800
Message-ID: <20250205013233.10945-1-pkshih@realtek.com>
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

To play A2DP smoothly on TWS (True wireless stereo) Bluetooth devices,
fine tune BT-coexistence mechanism to fit characteristic of this kind of
devices. Then, no lag sound while listening music and using WiFi.

Ching-Te Ku (3):
  wifi: rtw89: coex: Assign value over than 0 to avoid firmware timer
    hang
  wifi: rtw89: coex: To avoid TWS serials A2DP lag, adjust slot
    arrangement
  wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.3

 drivers/net/wireless/realtek/rtw89/coex.c | 24 ++++++-----------------
 1 file changed, 6 insertions(+), 18 deletions(-)

-- 
2.25.1


