Return-Path: <linux-wireless+bounces-17360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2555FA0A6DC
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DC91889761
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 01:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1361A46B5;
	Sun, 12 Jan 2025 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DY0b0zI8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7BBA3F
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736646245; cv=none; b=q5/PEC+l3hvaBSRQK5eO+1wIOtTqlzHOJY1PEasugRuZbRwPq3xgZX2KHZehN+iiTVkbP8pd4WQ1yOQEQHotQhwMMLkOzfYRc3yDnccoX8ms+9l/z+4+6X6OfL19NCTdacM83pRjr/W8H7J8t33MhWoeIXmhiuPrakw6D5AzSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736646245; c=relaxed/simple;
	bh=eKOPkQWXOdw0InB6c7EpfJvBm82KfmuwTTrZ5Rss+aI=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=rV+qayIWUHJodN7WWOLgADP77se1okOeQNCCI3OFBolSvndbQy5WGPO2yiWu5Q91x7/tF//1mdwsODjj82Tio/OVuwQ4kDoepRe6wBk6aj7qHHr6SNHntgAZJdl3vnS+5QdRKakzmWuhxcUUQnV4ec7EQIF8D1ZatszG90CGBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DY0b0zI8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C1i0m051592543, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736646240; bh=eKOPkQWXOdw0InB6c7EpfJvBm82KfmuwTTrZ5Rss+aI=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=DY0b0zI85b8Oc9PizDQPXbCk+3IWh9OEABtCkygtdc+Tb6l1XoMCAXKUMWtCV57y+
	 37JGC3Y1i1m4/6ElBlY2IFelZ2OXZNrpPmosBImn/t1+VKXjlMHR4V4WPVRyAshhQe
	 AeF0wFft54ycnLB/QCAxAJgcphu7DX8PfSO8gQDrOGr/o1vs/P524C4lj73MT1C43C
	 A6gFDaXTsC7fMJPOs7uAWgN3WoWcjuEBL4MUabPjBhZMZkG+H71wVg/hLqF5vSGcyE
	 Su1G/KCLE8I3/UMNcmWUKhtjPBwGTQVQJVRxjZBYlwsDiIskfYuSELkmI7uvgXEvhJ
	 U7g7mYDUazMGQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C1i0m051592543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 09:44:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 09:44:01 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 09:44:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] wifi: rtw89: read hardware capabilities part 1 via firmware command
In-Reply-To: <20250108020955.14668-2-pkshih@realtek.com>
References: <20250108020955.14668-1-pkshih@realtek.com> <20250108020955.14668-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <4a6c200e-59c5-4f69-a1b3-ebfdf11ec92f@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 09:44:00 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Firmware after version 0.35.51.0 defines and exports more hardware
> capabilities, which driver will consider reported QAM field as
> EHT MCS capability to register hardware.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

3f0e6890890a wifi: rtw89: read hardware capabilities part 1 via firmware command
456ad3210a88 wifi: rtw89: 8922ae: add variant info to support RTL8922AE-VS

---
https://github.com/pkshih/rtw.git


