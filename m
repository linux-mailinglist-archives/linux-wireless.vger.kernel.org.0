Return-Path: <linux-wireless+bounces-30114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442FCDE4F0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 04:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 311C53003F69
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 03:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A51B1F4CB3;
	Fri, 26 Dec 2025 03:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OgroIJ8v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCBD1DED63
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766721110; cv=none; b=Sjdx2MNrIWyro2wZendYfzg+440PjUFuBo/loUqIjxPA8X3FKl7DO5k8PYG9KR6Rlk9wjbAw0Ffkq/kf5aKcclRZbISy4HtBeOe1GEeMtuKydBru1uvWJa0AlPurB6my9r/6XmT+9Xgu4WAJzt3404G67oL6iPco1Nz1p2dV8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766721110; c=relaxed/simple;
	bh=5AvuVSIenJuQwZSGHYMhvRfgTdKhtPOJLX0r+nRLprU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=f4t49l6G4jpOxBoSo4F16Zd1YKnzVfZuqKYfDTCbo1iIC8Biw57IME5eBsqqMT2SrASUpO/HSS4S3g+UvRZgiEeR/OrdXSlG4yyV6RSSMbgiB6uBmz4YF5TbYOaJM8fi2IjbRLP2b1VYguOX5aU5m5mIdWjjQ8mOqB1jHO1lrcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OgroIJ8v; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ3pjGA32873458, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766721105; bh=1Jxz/F2FvxaJoC/m2MSMaRPKY+QavUgdjTHiivPmYcs=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=OgroIJ8v4IeRe0jPegBmGH+AE2+EXNem4K6YiSbFvMa0cBgAcU6WpNHWgieAAMqia
	 GPb1iHlIt7In4W9l+5ENIAqwYYLytqX7D0cvOvSP3Lum5f3hl5wM/lG1/XlaVMRiha
	 MBXJpTYVSLMIkjCsWncSf6jYQor9je9yxSlIXQqe1MJ4VMAZdtfPiJNSHtSHC++4WU
	 zxkfvxGkAcqLQLBxjfElXLrq8/1qXgvhWbKQKuCzK+xgmx2IF4MuM3TODe5IUnbplk
	 rwFLSdHb8oNZxR290EWFPb8mZN979NCWCYgBDszldGzfCHFy2PP1CNVz/j/mkr+25E
	 5/Zv+V59JbFdg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ3pjGA32873458
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 11:51:45 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 11:51:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 11:51:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next v3 01/12] wifi: rtw89: 8852b: increase beacon loss to 6 seconds
In-Reply-To: <20251223030651.480633-2-pkshih@realtek.com>
References: <20251223030651.480633-1-pkshih@realtek.com> <20251223030651.480633-2-pkshih@realtek.com>
Message-ID: <4b1f966c-89cf-4164-868c-fa8311b7074d@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 26 Dec 2025 11:51:46 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> Intermittent beacon loss from a specific AP can lead to
> disconnections. Increasing the beacon loss threshold
> helps stabilize the connection.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

12 patch(es) applied to rtw-next branch of rtw.git, thanks.

6b3173804347 wifi: rtw89: 8852b: increase beacon loss to 6 seconds
fdbff298742e wifi: rtw89: mlo: fix missing TX null-data 1 during link switch
de1ba591d931 wifi: rtw89: mlo: fix incorrect link address in management frames
b0f1289fd617 wifi: rtw89: mac: reset power state before switching to power on
f4de946bdb37 wifi: rtw89: ser: enable error IMR after recovering from L1
44ec302e029d wifi: rtw89: ser: L1 skip polling status if FW runs event mode
2ac399c5f54a wifi: rtw89: debug: add ser_counters dbgfs
0ca9cb5b8dd2 wifi: rtw89: debug: support SER L0/L1 simulation via halt H2C
d38289fd1243 wifi: rtw89: refine C2H reg event polling timeout for LPS
7b0c36c96836 wifi: rtw89: warn unexpected polling value of XTAL SI
5e5f83fba483 wifi: rtw89: setting TBTT AGG number when mac port initialization
1b40c1c7571f wifi: rtw89: mcc: reset probe counter when receiving beacon

---
https://github.com/pkshih/rtw.git


