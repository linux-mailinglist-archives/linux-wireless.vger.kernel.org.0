Return-Path: <linux-wireless+bounces-20018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F337EA577C0
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 03:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B50174044
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 02:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2651465AE;
	Sat,  8 Mar 2025 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="AcwxcBBk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D9C8EB
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 02:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741402743; cv=none; b=u85arU5yilYCzIDeoNiKuZvgWBs9bsJP81D/sO+zjaR5D7PZaRmCJFtOzCxROTbfacqGByasaT3s7bZ7h0/HgIFCCdow+mepGdsunrw6bhX6R2jbIGx6rQ1G+M73JkNYhjScZuN++AMu3sl5LlXtqo7qh2O5d8171710nrzWjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741402743; c=relaxed/simple;
	bh=0t0z8QOaUHNOOWxJfc0dqKMEHZoRdlYsG8RMIZJrcQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i4mvGUp2YgsAFqi+oqNPGa47t9iNqh2w5vO3tiQ2xtPNxQoY2XB2/1uaKjxOt8Aso75hBabmxIQhqOqkAWh6ErDlgrxqtS0Y8ByzATVtojFpvjsI3cTKzHRJEnsDlilJRv78RbyxOh8w1x0aOIf184bnNtXwu3d1C3zD56UUg2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=AcwxcBBk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5282wpQ432568075, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741402731; bh=0t0z8QOaUHNOOWxJfc0dqKMEHZoRdlYsG8RMIZJrcQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=AcwxcBBk7ev8KjgS+eKfpfNvxcw7RcUoTc8BmFv7iqDSsz+dKMv5s7VRvA2aoWDaP
	 BW3h4LM4azor7QhFgmXffnYbZvlf0UMfsk+I27lfv6rrrz+b9ujCN0yFG74YkZE/pU
	 cYtx3YnvVqrnoJqK6dgqnZpTcs7AHxB0hgGEMONvDK2gKqUwMQ16vkdOjHAgdkLkoo
	 vd4HIMVd95B/OCDqO1RUClfSYyp91N9OGLMBU1hSO7QYD9rVHjDlov+OOQ6iPm+rqG
	 0atDjEEd3SRoBV5CPK/ezfB+JQUUsccZj1oEUUdul5zHYdTgkwje1w8NmnJGm5OgZH
	 aMbNG3mHZzS4w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5282wpQ432568075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 8 Mar 2025 10:58:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 8 Mar 2025 10:58:47 +0800
Received: from [127.0.1.1] (172.16.23.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 8 Mar
 2025 10:58:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 0/4] wifi: rtw89: coex: update to support new firmware 0.29.122.0
Date: Sat, 8 Mar 2025 10:58:28 +0800
Message-ID: <20250308025832.10400-1-pkshih@realtek.com>
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

The format of firmware commands/events of 0.29.122.0 for coex is changed,
so implement the changes accordingly.

Ching-Te Ku (4):
  wifi: rtw89: coex: RTL8852BT coexistence Wi-Fi firmware support for
    0.29.122.0
  wifi: rtw89: coex: Fix coexistence report not show as expected
  wifi: rtw89: coex: Add parser for Bluetooth channel map report version
    7
  wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.4

 drivers/net/wireless/realtek/rtw89/coex.c | 16 +++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.25.1


