Return-Path: <linux-wireless+bounces-7153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B4A8BB8A0
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 02:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA461C21637
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 00:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A2629;
	Sat,  4 May 2024 00:13:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238A36D
	for <linux-wireless@vger.kernel.org>; Sat,  4 May 2024 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714781582; cv=none; b=Rj5ZQSCFeOhzZw0+NOql0JGVY6HNarBMtsYHmrefENCf2IERwhQ3Vi8u3uQNsmrBkieiI3l20+Ed4fgy0TiUK8BYjyuTHdTeZYXk/NUcSHUVuU00wuxNiO2OWvUyBIfwL5pIgm2TgHtFPVDZ8XGDobSuPqzDR6O/oOc5QtxjYC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714781582; c=relaxed/simple;
	bh=Ur5gnyUWT2z8w8z3AX3jafnqqK85C4TwnyAk3CeAUnE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=ghPTDGKV2Sw2jg+pCAxtixpOsGEB9M9Or8kbAekVHLqUzkUldGTe7V57eg/dkGsKuheGIaHx9g2QHX+laxgp06UeCN59bIH+WdUX9nY8ea1Z3iXdmfnQiEFFWwAfrGs8/Y3XjwA4EjL+E6n9A02H3Rtg2nvivwi2u/HU1vJLD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4440Cuu264006461, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4440Cuu264006461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 4 May 2024 08:12:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 4 May 2024 08:12:56 +0800
Received: from [127.0.1.1] (172.16.16.175) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 4 May
 2024 08:12:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: Re: [PATCH v2 01/12] wifi: rtw89: wow: send RFK pre-nofity H2C command in WoWLAN mode
In-Reply-To: <20240502022505.28966-2-pkshih@realtek.com>
References: <20240502022505.28966-1-pkshih@realtek.com> <20240502022505.28966-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <57b44415-5dc6-42cb-8962-58db7f5ae7ab@RTEXMBS04.realtek.com.tw>
Date: Sat, 4 May 2024 08:12:55 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> 802.11be WiFi chips need a RFK (RF calibration) notify H2C command after
> downloading WoWLAN firmware to make sure RF TX/RX work fine when leaving
> power save mode, so add it to correct RF TX/RX in WoWLAN mode.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

12 patch(es) applied to rtw-next branch of rtw.git, thanks.

a79264e8c7d3 wifi: rtw89: wow: send RFK pre-nofity H2C command in WoWLAN mode
baaf806e4632 wifi: rtw89: wow: refine WoWLAN flows of HCI interrupts and low power mode
92790c4e50d2 wifi: rtw89: wow: parsing Auth Key Management from associate request
803a96f477be wifi: rtw89: wow: prepare PTK GTK info from mac80211
9076bf365e13 wifi: rtw89: use struct to access firmware command h2c_dctl_sec_cam_v1
786737b6b708 wifi: rtw89: use struct to fill H2C of WoWLAN global configuration
ed9a3c0d4dd9 wifi: rtw89: wow: construct EAPoL packet for GTK rekey offload
0291633afef8 wifi: rtw89: wow: add GTK rekey feature related H2C commands
ff53fce5c78b wifi: rtw89: wow: update latest PTK GTK info to mac80211 after resume
940cd99625de wifi: rtw89: wow: support 802.11w PMF IGTK rekey
e765370fdced wifi: rtw89: wow: support WEP cipher on WoWLAN
58ed86e1666b wifi: rtw89: wow: add ARP offload feature

---
https://github.com/pkshih/rtw.git


