Return-Path: <linux-wireless+bounces-6717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805918AE577
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 14:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0A8288E22
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 12:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DFE64CCC;
	Tue, 23 Apr 2024 12:00:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3560279
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873612; cv=none; b=Ne4yBaio7E3VK01nYRiMFwaS2j0BMXOUbBL8MJ+ab6NXUrAn4fBsD8c9Nb/pFSa98jWngy+j/or7vJXlfo3Su4iX2X3s8RxEbGse9IEwJtUa+RFuSFHJojvMDesTNMmrpRszRGom38EumFT0miPpeSqnE86RTWHNUV0PLK6ZkPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873612; c=relaxed/simple;
	bh=yvnNKqZ6uDCoQiSkDNg9piid+M26SkSeTgIH7xAsXFc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=pIPXwXNj78+kIcrYEwcIjLWCSkuPLX6xLYmzaricObGIgUKqT2v3yDqXtUKpdhb5MwNBaXxOV574KfSu9XyLo52EDSpKOZE7OZL0KYY8ZkD5gvNERyhcQnk/+R37y9rIAqTPQF9UiiBaX7RYvWOke+AO8hfWVx3BvzzYb+9+e2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43NC07yZ41218160, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43NC07yZ41218160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:00:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 20:00:07 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 20:00:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH 1/9] wifi: rtw89: coex: Allow Bluetooth doing traffic during Wi-Fi scan
In-Reply-To: <20240418021207.32173-2-pkshih@realtek.com>
References: <20240418021207.32173-1-pkshih@realtek.com> <20240418021207.32173-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <bf6dede5-37ff-4405-923f-15ff90299abc@RTEXMBS04.realtek.com.tw>
Date: Tue, 23 Apr 2024 20:00:06 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> The Wi-Fi/Bluetooth slot are toggled by firmware timer when Wi-Fi doing
> firmware scan, and Wi-Fi slot don't allow Bluetooth do traffic when
> Wi-Fi slot. It will trigger Bluetooth audio lag in a random rate, because
> Bluetooth can not have enough time slot to keep enough data to play audio.
> This patch make Bluetooth can do traffic during Wi-Fi slot, this can help
> Bluetooth to collect audio data in time.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

9 patch(es) applied to rtw-next branch of rtw.git, thanks.

a4f19fd7dcea wifi: rtw89: coex: Allow Bluetooth doing traffic during Wi-Fi scan
b5d8d19de284 wifi: rtw89: coex: Add v7 firmware cycle status report
ac83ba93b22d wifi: rtw89: coex: Add version 3 report map of H2C command
89d06325364a wifi: rtw89: coex: Add PTA path control condition for chip RTL8922A
c95d34c7d676 wifi: rtw89: coex: Update Bluetooth polluted Wi-Fi TX logic
b952cb0a6e2d wifi: rtw89: coex: Add register monitor report v7 format
de656c77c72e wifi: rtw89: coex: Add GPIO signal control version 7
45deb9e6a60b wifi: rtw89: coex: Add coexistence firmware control report version 8
4ea11e4db355 wifi: rtw89: coex: Re-order the index for the report from firmware

---
https://github.com/pkshih/rtw.git


