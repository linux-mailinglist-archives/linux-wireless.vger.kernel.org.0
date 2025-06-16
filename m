Return-Path: <linux-wireless+bounces-24124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B459ADA7FE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 08:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D5116D95E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 06:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6211D1C2335;
	Mon, 16 Jun 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rOkLj5Qo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB2175A5
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054271; cv=none; b=mqezdHR+EbZr8t8Oxnpg7JAgPOGDnunfeioLJg70YrZOhvgvuQHSYnUebIgQZ6xixO68ddRzUYfafNwuUGldSU5CUW70/obIyrKVR1t91I6gyqRAB0I6kkphAVXxrPDBt0Zp8LY1s2n2cJ8JyQs2/q+42Upp+T1g1pIr9T03VyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054271; c=relaxed/simple;
	bh=JDofK++Wb8ndDXoJWpVmZI3L1fpyfNeOw1aLefkGM+Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Z2YU9Rm3iiDRK/BBLoGGiq9V1UC8Nj2yVyEFRFfCCIIWRYAE6JMMk1pmKdx8o20YtiI1lWfg4odppePHkhpmcsXrrIzpxFbTjD4sjKktYxqNxPUQ0hQ9+vMP/6mod6/R9ejlduNAbDwZchvayA17VCtDj3EyC4VtfIs1SJHXUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rOkLj5Qo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G6B5PP04181935, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750054265; bh=reDuHhP11JkKly7Xyz8gMqytjSZOAOx3FPqp9X0+O6c=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=rOkLj5Qo/NflZNE3lP19x4t2eKa4+b08I0EMeV38VIqdtInjXudN1UUwB3REwFrth
	 NmwrSH6XganU8j3X3z5gX9M+QKYurbmVA6QnEcXEuu0yStSalOb1GOY1G8BCXDjcIS
	 Tt/p3TT3wut9/VCvOdPMbFmITX75z99Izd5gUWkw/oQ81twilR00+t9um6n9Ym/dll
	 FZJSZUJOW/x958Qk95hzpUMDmfXAarS76xX2R8KjWgQfeD6Ghf7BAOJQvFP7NP7Af8
	 dagrhoW/H/2wl9o6rUvpAgezMxdm/xijV9S2a9k0EAyLl/xXDwHaV8IJry/IVQVzKp
	 ZrwEfEiKU7YPQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G6B5PP04181935
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 14:11:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 14:09:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 14:09:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next v2 01/10] wifi: rtw89: introduce rtw89_query_mr_chanctx_info() for multi-role chanctx info
In-Reply-To: <20250611035523.36432-2-pkshih@realtek.com>
References: <20250611035523.36432-1-pkshih@realtek.com> <20250611035523.36432-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <312d8621-3902-4e05-8793-8d43fe7983a4@RTEXMBS04.realtek.com.tw>
Date: Mon, 16 Jun 2025 14:09:10 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Add Wi-Fi 7 MLO related multi-role (MR) chanctx descriptors and query
> function. They are designed for other components, e.g. coex, which are
> interested in the following info.
>  * whether a MLD exists and how many active link
>  * the number of AP mode and station mode respectively
>  * how many chanctx and the number of 2/5/6 GHz respectively
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

10 patch(es) applied to rtw-next branch of rtw.git, thanks.

cbaf1110af41 wifi: rtw89: introduce rtw89_query_mr_chanctx_info() for multi-role chanctx info
1625d70f523b wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.63.0
ccd57356f311 wifi: rtw89: coex: Implement Wi-Fi MLO related logic
26c62dca8243 wifi: rtw89: coex: Update Wi-Fi status logic for WiFi 7
fac16e4147a2 wifi: rtw89: coex: refine debug log with format version and readable string
825f5514127a wifi: rtw89: coex: Add H2C command to collect driver outsource information to firmware
1683ae3e0069 wifi: rtw89: coex: Update Pre-AGC logic for WiFi 7
4cb9092289ec wifi: rtw89: coex: Update BTG control for WiFi 7
7d1b3c22fe0f wifi: rtw89: coex: Update hardware PTA resource binding logic
0bc2aef36949 wifi: rtw89: coex: Add PTA grant signal setting offload to firmware feature

---
https://github.com/pkshih/rtw.git


