Return-Path: <linux-wireless+bounces-13741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D12995C62
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9AB1F249FB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320616FC3;
	Wed,  9 Oct 2024 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Kz40PGMp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F737462
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434597; cv=none; b=FOdfllTG6EY3y+2FkdA+pk4KnQXH+5OUmV0CgK5vK0sCh7YPW0ly1IV9iZB8PMy5Mx5sNi57JBH319+ZsCGfmZDDOIMB0WX/P2mEEDJit0CWsG8Pu/IfFXiteZtjQ7nG6G+cZdJzrFygS1x1d2ySZkLv3gn3vd4j2tf/7OOo1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434597; c=relaxed/simple;
	bh=NIwrwKyQxWHIVp1OEXHf0Gs/ukBwBLpT+1DQMHCuc9c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GCFzABcDLxeVYnJASBvltsdP+TYEd1UQfaQModBCYFQsC6OOZxwthyTpfef3iaCsInAhDYWOl8650Gyhnhw+xgBx0uqUXRBW/GeJHPd1wGhb8EcY7yZV1qthqSMQbNiIMPiL8X6QijxSEx8Qu/f8K7YeATK+uKgpsIMUBVPioT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Kz40PGMp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4990hCUO14153067, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728434592; bh=NIwrwKyQxWHIVp1OEXHf0Gs/ukBwBLpT+1DQMHCuc9c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Kz40PGMpmC3ZWf4foENLmaufGutC2pzpAd1CT5DbYiu7T8g6pR11Vim4aM+svk9YP
	 9WocQKPJhR7xqCqj96P7ZfSnSRxbAh7JPjG7a4kJP96ZBjRcO7KsEpGeDFqN9EaxPu
	 agt+5+uorK1LTG8fEbDIFPZtKvwiGCP5p9drnJ8tRpSnrJrY71cf25Xoy0So/1Brc/
	 Cr+hVJoiAdhjFYiZzjyFGtZZYKiWfRdkRRmBTwyzRlVJx8kL/PEhBkqJE3AmiMBKp6
	 VO1z0pYWEYx1ILFvAwXzLEo6jKXy4LCUfRGfmCYU1XgeMwm5VCOSDCy/B8dMN64su5
	 l/Z/hK2RQHkNQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4990hCUO14153067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Oct 2024 08:43:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 08:43:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Oct
 2024 08:43:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: correct improper data types found by Coverity
Date: Wed, 9 Oct 2024 08:42:54 +0800
Message-ID: <20241009004300.8144-1-pkshih@realtek.com>
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

First patch is to be intended to cast u64 in arithmetic to avoid Coverity
confusing. The others are to use 'int' instead of 'u32' as type of error
code, which are suddenly not to follow coding convention.

Ping-Ke Shih (6):
  wifi: rtw89: wow: cast nd_config->delay to u64 in tsf arithmetic
  wifi: rtw89: pci: use 'int' as return type of error code in
    poll_{tx,rx}dma_ch_idle()
  wifi: rtw89: 8851b: use 'int' as return type of error code
    pwr_{on,off}_func()
  wifi: rtw89: 8852b: use 'int' as return type of error code
    pwr_{on,off}_func()
  wifi: rtw89: 8852bt: use 'int' as return type of error code
    pwr_{on,off}_func()
  wifi: rtw89: 8852c: use 'int' as return type of error code
    pwr_{on,off}_func()

 drivers/net/wireless/realtek/rtw89/fw.c        | 2 +-
 drivers/net/wireless/realtek/rtw89/pci.c       | 6 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 4 ++--
 6 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.25.1


