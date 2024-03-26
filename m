Return-Path: <linux-wireless+bounces-5260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8342F88B6BC
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 02:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BB51C31CBF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 01:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3791CAB5;
	Tue, 26 Mar 2024 01:22:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69361BF58
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416120; cv=none; b=VgiQ1zRO56YBx84HIdrhRgvnaLbUhBHTilt/VI/CrS4HyZQRyIArgFZPfZ8Lo7i9LyC1oDFd1bZHpXWW1GBCtxKvfztg00zwtKx5hSbHNt4/lmbauH7RtzLEnd3VzD5wHksNTzV9+K1/IW7KDJOAfyadNGNzhel1KANAPvqGpI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416120; c=relaxed/simple;
	bh=J/qb+7xNJoBXCZQrlrAmOQqh9Tib5iErWfxPRaQA2nE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=suC+Mvjxs1wD7BD6A/1YZt3xoOmasp49PVHbfZ2GC8rpDukMZDCwHF0hioC+ipY4gzNGS+yKhNpgodexfe0FbCwWBbSb1jb/Lj2qRnszZ37ERM3KKUKOjbmRdYO0fiRl/3xkG6d0kfstGEoCasSUgy2/BWQxqx89OfoOtikKjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42Q1LgCB23435110, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42Q1LgCB23435110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 09:21:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 09:21:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Mar
 2024 09:21:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: coex: Prevent doing I/O during Wi-Fi power saving
In-Reply-To: <20240320075047.31810-1-pkshih@realtek.com>
References: <20240320075047.31810-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <45afda7b-db1e-485d-af67-21fc13577fc8@RTEXMBS04.realtek.com.tw>
Date: Tue, 26 Mar 2024 09:21:43 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> Fix Wi-Fi 2.4Ghz throughput drop over than 40% when Bluetooh is idle.
> The code flow will read registers during Wi-Fi power saving, and be
> returned, which results in incorrect counters to do mechanism judgment.
> Adjust the code flow. Will leave Wi-Fi power save mode first then update
> counters.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

c2c0de23f91b wifi: rtw88: coex: Prevent doing I/O during Wi-Fi power saving

---
https://github.com/pkshih/rtw.git


