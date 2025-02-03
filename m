Return-Path: <linux-wireless+bounces-18266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A59B5A25143
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 03:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F0A1883B40
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 02:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D421C156CA;
	Mon,  3 Feb 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dJdRrA8l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DCCAD23
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 02:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738550230; cv=none; b=ay3uiCX3xjv1oZQzl4U/5fK8OcQBRC4ePtpiP3b6g+E/Ds3Rcb4xW/7oJgaGOG2R7HVPHUzTEF0ryKrrBH80Bz6LMTuRAUNLksvgQEwiBNc128zMwBoSQo/o8ngf7h4LIE/xzIuO51xbvuqRBeGhy1Yw1Ck0Xo/y79QfOgppSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738550230; c=relaxed/simple;
	bh=ZpK0r6xVJOPnyPt8wREODBI1QdY4/+sGbtzqS9qah8g=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=cUhAiZ7mp23r2W4kOM46c3eNXxtM/S3g5+REneD2RlKVhC5Ih0N4AvCf5+yEo//SOtC3hQehjcHHVwOsxWm7UnDAuzFsV/pZsUGz86oP+rJF+NEvNr84SUI738RGxS2SfkNHi4IyAioLRtlW0lyu1OVauDTmFM0xaO5kczusNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dJdRrA8l; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5132b5fH5955907, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738550225; bh=ZpK0r6xVJOPnyPt8wREODBI1QdY4/+sGbtzqS9qah8g=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=dJdRrA8lCqLCFBsdhogaLm7zq/ECD0cu/PSwLLqNLXm8lkzE5cdEgFY5jnibbAQCr
	 M+EeswE4H1w/yZ1UacymcYEAl9PKboa/iF35GZ8W9TVfx5CrPiRzTD5pIrEyhD/UxD
	 iD/UVekCEiPB0FvO92ZPXkHT6Y920YWALQIt1eubXMYwybKFFACcMuQozLZMB6szXb
	 4g2JYksPVmQr+GyWfwX0qD/+DkneZrbTaFtkDor/ujv+ZnHtdBbcCGBQ1pcjBqRRiO
	 TtqqVHJmm+s63ZDgMXfc+UqUA2YSafJ+GIhjC9uTY1/Orl6/TLgUKM0ZkXJ+kgU85r
	 LVUm4v1uIjXFQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5132b5fH5955907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 10:37:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 10:37:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 10:37:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 01/10] wifi: rtw89: add wiphy_lock() to work that isn't held wiphy_lock() yet
In-Reply-To: <20250122060310.31976-2-pkshih@realtek.com>
References: <20250122060310.31976-1-pkshih@realtek.com> <20250122060310.31976-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <9f223436-29a6-493d-92d6-706797827521@RTEXMBS04.realtek.com.tw>
Date: Mon, 3 Feb 2025 10:37:04 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> To ensure where are protected by driver mutex can also be protected by
> wiphy_lock(), so afterward we can remove driver mutex safely.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

10 patch(es) applied to rtw-next branch of rtw.git, thanks.

ebfc9199df05 wifi: rtw89: add wiphy_lock() to work that isn't held wiphy_lock() yet
4afde17d2667 wifi: rtw89: use wiphy_work() to replace ieee802111_work()
831cceed3baf wifi: rtw89: debugfs: implement file_ops::read/write to replace seq_file
01fd45d9e102 wifi: rtw89: debugfs: specify buffer size allocated by devm_kazlloc() for reading
8fdf78f3cd5f wifi: rtw89: debugfs: use wiphy_locked_debugfs_{read,write}() if needed
bdf874dc3c76 wifi: rtw89: debugfs: use debugfs_short_fops
6ee1937d8bc9 wifi: rtw89: remove consumers of driver mutex
ed114a7ac636 wifi: rtw89: manual cosmetic along lockdep_assert_wiphy()
2345f351c7f5 wifi: rtw89: remove definition of driver mutex
8afa4ff99a00 wifi: rtw89: pci: not assert wiphy_lock to free early_h2c for PCI probe/remove

---
https://github.com/pkshih/rtw.git


