Return-Path: <linux-wireless+bounces-13454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE3E98ED5A
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 12:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C721F232D0
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 10:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6734615098A;
	Thu,  3 Oct 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SWiX9RXW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675614F9F8
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952757; cv=none; b=Nvpm6mYDoEvCrd97r4rS3jsPNHwBODFz9gKWcei7g+BCLWlAeG/wHLncjYvS/wvoxK87WZJo5BkQ8ecF9RtaNJH6y/XF5+L5PTuClkgA6g0xR8FLKzLst5o+StZocEPM3tR3XKJJEtdsbB42EOp0XdvrInBOx+Fb4tWB0DCRs08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952757; c=relaxed/simple;
	bh=rYDzdn8880i9S9dzcJuryovH+s3jfqAzZpZ+FP74104=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TMKgt3tfpu2s1Egq0XPyBaV8j9z0Z2LKYOnPmQRrZEU1JHdWgVWbM0Z0PiUryqa/sKEr+MOYNTvRGMc6uCMsWOlxkKaa76+PAVTt6Nl+EPPkaPhCKTsBKNfeSPDQANEExlnthBWa9g0TUGm2KCPJ1r4+M5hxAiKfq/jh7JPAN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SWiX9RXW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 493AqVckD3828687, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727952751; bh=rYDzdn8880i9S9dzcJuryovH+s3jfqAzZpZ+FP74104=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=SWiX9RXWfXZuG/51JCo8l+jgl0pZ9jvaJV3ziw7ZoyBpe9r4SXDeKaB5dCORoAOVh
	 sg/qN2e8sv3LYvNsAQRl6he2AxPwfLUuXRhTWvEuT2p86KmuooXNrKq5s49Ao85DzU
	 r/nskdZrrK3vmwztue4T/o3MT7aqm0iNxsFXBRFqpBZB5JJ49wyPziBg48ULKrzS9b
	 Gxk4feaXtY6Euui/ZGjScEemR3Y1PEQXKXSMPZy6Zn1UaYDcmxh1J5QvbJQJsdZF83
	 JWSytArT4z8p8QZLAbuYMXQSG0pXSKMyNG2btT+uVY+0vGSbtDU4/6jIeADoTwQnHj
	 IuvJDnWPc1dEg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 493AqVckD3828687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 3 Oct 2024 18:52:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 18:52:31 +0800
Received: from [127.0.1.1] (172.16.22.72) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 3 Oct
 2024 18:52:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 0/4] wifi: rtw89: coex: improve BT-coexistence mechanism for RTL8852BE and RTL8852BE-VT
Date: Thu, 3 Oct 2024 18:51:36 +0800
Message-ID: <20241003105140.10867-1-pkshih@realtek.com>
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

We found some unexpected results during verification of RTL8852BE and
RTL8852BE-VT, so update BT-coexistence to improve user experience.

Ching-Te Ku (4):
  wifi: rtw89: coex: Update priority setting for Wi-Fi is scanning
  wifi: rtw89: coex: Reorder Bluetooth info related logic
  wifi: rtw89: coex: Solved BT PAN profile idle decrease Wi-Fi
    throughput
  wifi: rtw89: coex: Add function to reorder Wi-Fi firmware report index

 drivers/net/wireless/realtek/rtw89/coex.c | 228 +++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h |   5 +-
 2 files changed, 161 insertions(+), 72 deletions(-)

-- 
2.25.1


