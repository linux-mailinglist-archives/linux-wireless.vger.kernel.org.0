Return-Path: <linux-wireless+bounces-18263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A015DA2512F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 03:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8F87A1EC6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 02:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20624C85;
	Mon,  3 Feb 2025 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="blSOAHDD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8712E7F
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738548229; cv=none; b=lVq+Mp2x3yNZ9bHnaRSFI5qz9yyffQcT8WGeXw7zZXlXnNTwaSXQeaIHVac0hQKOz3HGr97YtWBqfa2iF5zikzYeu1ciztt6o4HOGqkNLKfQcLs1UX0RCDxS1aKz1n/AtZ0ZAg0ljH7btGlUuLoUYlBNMMoG2D85Fsxi2P0XLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738548229; c=relaxed/simple;
	bh=V/zIPRvRZM5dIL8bjjDjQYVvhMWteiB4d4FeEmdENCc=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=Ps7GX2dnv3YKzciD0k4ob3C+GScsC8biyAG8uD1Giz9bL2s+MTa/rcHm9JGVnJCoIdbJ2KU+d9Dnbg6rHmw3yE6fvu6tLa99cLsJUC5QPp9v1KX8JdjxdWfvuYejC/5tqjEJ+2x4w9oxBn4AyY/9RGWrcYHFKeiluRM1xUac6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=blSOAHDD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51323h092923177, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738548223; bh=V/zIPRvRZM5dIL8bjjDjQYVvhMWteiB4d4FeEmdENCc=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=blSOAHDDnCVjvBz11fkhdOL1SyG3oVzw4egG1MPsxlu+1I1GkvOi7m4DHpQtJmpYk
	 in3PqgXNN2ajiZJ/SjxC1JZXv3dvB7fsGgttaEmTYE4HKhrWVffEEOhBUIpWMbjZ5D
	 PdKsN0FJbzREUpeAZnd8n6gfF25ti3QmqbERpdG/fVA6g158fKxaRyivb6RFsjCNJD
	 /LVOgF/KlYPCY03aNbyrM6y5MAquaCrbY2PfpnJjLHoDKmkchDz9lvra1YqxgtAgeF
	 F9AVqvGHXH69T7fT3RCHWqZuucJ7wPz7BOMnLVgiO5lok2EdTeg7FBfMsDIcdWJfDB
	 wArzyLvrnynUg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51323h092923177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 10:03:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 10:03:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 10:03:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/8] wifi: rtw89: phy: rename to RTW89_PHY_NUM as proper naming
In-Reply-To: <20250117072828.16728-2-pkshih@realtek.com>
References: <20250117072828.16728-1-pkshih@realtek.com> <20250117072828.16728-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <7a74f686-73bd-4b20-9cf0-5c2b3b016a11@RTEXMBS04.realtek.com.tw>
Date: Mon, 3 Feb 2025 10:03:42 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The meaning is number of PHY, not maximum ID of PHY. Change to proper
> naming.
> 
> No change logic at all.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patch(es) applied to rtw-next branch of rtw.git, thanks.

f0dc53a7b77f wifi: rtw89: phy: rename to RTW89_PHY_NUM as proper naming
57a6cdf2feaf wifi: rtw89: phy: add PHY context array to support functions per PHY
11a625160a32 wifi: rtw89: phy: support env_monitor per PHY
dc0ac60f2a92 wifi: rtw89: phy: support DIG per PHY
786e485c61ef wifi: rtw89: phy: support ch_info per PHY
af5fa884e22f wifi: rtw89: phy: support EDCCA per PHY
0a51f04a9afe wifi: rtw89: phy: support EDCCA log per PHY
076652f56ed6 wifi: rtw89: phy: disable CFO track when two PHY are working simultaneously

---
https://github.com/pkshih/rtw.git


