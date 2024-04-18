Return-Path: <linux-wireless+bounces-6476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFBD8A908B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 03:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4120EB21B97
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 01:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072379F0;
	Thu, 18 Apr 2024 01:19:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468179EF
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403151; cv=none; b=WPpceh1GPFfFUXcQooIJqpIuxtfmrbLSvfy+ieEDnBF2wqLkHKcw29y2+977C4Qe5anmJOxZdYUAhzFaLgXMlhqSYQ9VKFs1ONz1sPVjbQnLoFrdgv2+M0lioVJc6isb/zNywa+LdYIDTeav64LXmJvg9/8mIhmZvsLd5UCpwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403151; c=relaxed/simple;
	bh=Izd9h6XzlTCcAe3YUUiA1nFabM6s6ZHksktPgXXJel0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Q9vhxjRvUKlvNGq87a2I6YZGz4WoEekZrRietHg+lKYidPhUOSGDO3hx82mUJcOrRMNrCHUcpltDjUQzxx57CGvtSvqubXm4m1939b5/Qbxtdw41VFqU5mPv7vOjKR7OWOHIlRcGSOJGQG+wyIiBAtxwVzSnUlZJOD00+qFbfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I1J6vsC3940476, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I1J6vsC3940476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 09:19:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 09:19:07 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 09:19:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/8] wifi: rtw89: sar: correct TX power boundary for MAC domain
In-Reply-To: <20240412115729.8316-2-pkshih@realtek.com>
References: <20240412115729.8316-1-pkshih@realtek.com> <20240412115729.8316-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <66d83a10-9292-4dd0-adc8-3d61b7e39750@RTEXMBS04.realtek.com.tw>
Date: Thu, 18 Apr 2024 09:19:06 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> TX power in MAC domain is signed 7 bits. (unit: based on txpwr_factor_mac)
> The valid range should be [-64, 63].
> 
> While the original wrong bounds might not really be encountered, still make
> them correct.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patch(es) applied to rtw-next branch of rtw.git, thanks.

df0fa9d0d23a wifi: rtw89: sar: correct TX power boundary for MAC domain
bb38626f3f97 wifi: rtw89: fw: scan offload prohibit all 6 GHz channel if no 6 GHz sband
a08f9f21668b wifi: rtw89: 8852c: update TX power tables to R69.1 (1 of 2)
969efe4ef837 wifi: rtw89: 8852c: update TX power tables to R69.1 (2 of 2)
01e67a62fd30 wifi: rtw89: regd: block 6 GHz by policy if not specific country
d3c846367e31 wifi: rtw89: regd: extend policy of UNII-4 for IC regulatory
d03aeddf34ca wifi: rtw89: acpi: process 6 GHz SP policy from ACPI DSM
5a84cc876350 wifi: rtw89: regd: handle policy of 6 GHz SP according to BIOS

---
https://github.com/pkshih/rtw.git


