Return-Path: <linux-wireless+bounces-24403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E44AE5CE4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 08:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA25F4A6B51
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 06:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D417A23F294;
	Tue, 24 Jun 2025 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LbQklrvP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C246238D53
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750746954; cv=none; b=tMzlQU42FemwqMt52h2svoKpdxv0w2ts32WZZS+uCFMjTZFYaWTP7diY+15yYtVzf3KdYqCs+J5CG0CfUFhOZSk4MFyWElSm/VBngO1rSXV++DjOqgG9eAe+69j5ulLGNd2PMU0UgzTVyxzawaIqcXabEraMpSyzXOwJ0RjR2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750746954; c=relaxed/simple;
	bh=DK7tZduf7VduGzHfhLJSG7wZmRxMHy57p6WteF8bQgw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=boeRJIlKxa73GhJgNbGpW6BFvpLpgi6AoQnLa0mDIA2UJPv8J23PO+ePMYnyEirgKFUMx+rXeztaBXmC2KCvIHEI2Y4lXh/RbozhOOF9A//8Lw/4uLryELV5Ed5mTfaeCkU+j4noz6Xx7TofbwMh5fM50Ez99NCMMwgKE4WLu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LbQklrvP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O6Zoo263169729, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750746950; bh=AOWqXTjGYGWpLAyPLugcqEjFQCpEPNUrFPGfXRy2Y/M=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=LbQklrvPe+dNU2TwkhcvJOo57GW91z6k2d4mvDYiBWiRJAYUmsw7edlAxOw2LPeM2
	 MtrvB8YUxAbVCR3N3cpa47M4dqVZSJfkg4YQEBz+EgEQBls7RWHZKx/HyGNydvRrzr
	 wQFgx1lI/CXDrBkNfam+h8apQyoQ/gdBIdYHMKEbSPbH0h8L16Lu2ribs5hTXJC/YH
	 yLZWpTTfDhXeSun5Cot1bZuGWd/mW2cbDA+jzbIdaMJ1QY8MeyVxnhUXQ/eiR8zJ+R
	 YAeo1rH4g7sRP7TJxqb4qHAW23HGHgXlSfLkg4ldV7X5hvpe8EarlPjcLB3J9D7scf
	 AFcln4+3oAXWw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O6Zoo263169729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 14:35:50 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 14:36:04 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 24 Jun
 2025 14:36:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH rtw-next 01/11] wifi: rtw89: coex: Add v1 Bluetooth AFH handshake for WiFi 7
In-Reply-To: <20250616090252.51098-2-pkshih@realtek.com>
References: <20250616090252.51098-1-pkshih@realtek.com> <20250616090252.51098-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <826f0089-ffe9-4a3e-9f4c-8ebddddaac53@RTEXDAG02.realtek.com.tw>
Date: Tue, 24 Jun 2025 14:36:03 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> WiFi 7 generation has dual MAC, Coexistence need to find out the
> 2GHz WiFi connection in the connected links. And assign its channel
> to Bluetooth to make Bluetooth not to hop into WiFi channel.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

11 patch(es) applied to rtw-next branch of rtw.git, thanks.

d8643e681825 wifi: rtw89: coex: Add v1 Bluetooth AFH handshake for WiFi 7
39251e189e41 wifi: rtw89: coex: Enable outsource info H2C command
10a39b9fd7a1 wifi: rtw89: coex: Query Bluetooth TX power when firmware support
43be50111483 wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.71.0
fc9b3028aae8 wifi: rtw89: coex: Get Bluetooth desired version by WiFi firmware version
3ba79eaee051 wifi: rtw89: coex: Update scoreboard to avoid Bluetooth re-link fail
d997fb2f8c49 wifi: rtw89: coex: Assign priority table before entering power save
a7feafea4ce8 wifi: rtw89: coex: Not to set slot duration to zero to avoid firmware issue
8ef99ee5d278 wifi: rtw89: coex: Update Bluetooth slot length when Wi-Fi is scanning
206a8f999fcb wifi: rtw89: coex: RTL8852B coexistence Wi-Fi firmware support for v0.29.122.0
c5ef95e29166 wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 9.0.0

---
https://github.com/pkshih/rtw.git


