Return-Path: <linux-wireless+bounces-3605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA5A855A3C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 06:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C06B237D7
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 05:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F308F6F;
	Thu, 15 Feb 2024 05:58:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62C4A12
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976716; cv=none; b=oI4bsbcjAWhZMzsk3/5JcyW+22ZXyKm7BGocm/bbinxUBdJG4ZAOPhyvILNWIYHRPA8rsvd9hltXbu/qGIy+eILY1lsDOcpaPnDlPW68BueOmn+wlCQTi4CIKei1Tfuy6YfEbYLmwmvhh/6pcZ1NkerKWGpBPSMz6QfQ79ZRtFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976716; c=relaxed/simple;
	bh=qb67oZlnBFf47XPWAfLUAajhX3qjPEAIlXTY65Mon0k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QdznfpR34st+Yu+Ah8LPl4D1tt9yOOWgGhU+MZnW3eMQm8jaoaJsna07dcYuslQptp6mJjYr9d701R/vXbPooWG0wlold1IGane7rf/GPzflF/UyoKVmBk2LHxjO4+PA7RsEXA6nGPWbeq0jzdrYmNTcoW0tonewLwrEcIoe0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41F5wRvdD2372756, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41F5wRvdD2372756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 13:58:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 15 Feb 2024 13:58:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 15 Feb
 2024 13:58:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: 8922a: add chip_ops::set_channel() and helpers
Date: Thu, 15 Feb 2024 13:57:37 +0800
Message-ID: <20240215055741.14148-1-pkshih@realtek.com>
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

The set_channel() is main function to configure operating channel, and also
configure settings related to channel, such as spur elimination. When
switching channel from one to another, hardware could stay abnormal state,
so a helper is used to stop TX/RX during that period, and also reset
hardware state before starting to work at new channel.

Ping-Ke Shih (4):
  wifi: rtw89: 8922a: add set_channel MAC part
  wifi: rtw89: 8922a: add set_channel BB part
  wifi: rtw89: 8922a: add set_channel RF part
  wifi: rtw89: 8922a: add helper of set_channel

 drivers/net/wireless/realtek/rtw89/phy.c      | 119 ++++
 drivers/net/wireless/realtek/rtw89/phy.h      |   6 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  78 ++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 534 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 143 +++++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.h |   5 +
 6 files changed, 884 insertions(+), 1 deletion(-)

-- 
2.25.1


