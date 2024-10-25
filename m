Return-Path: <linux-wireless+bounces-14492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5919AF763
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 04:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD1E282647
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 02:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A5614375A;
	Fri, 25 Oct 2024 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RhOOFsKp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1386AE3
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729823156; cv=none; b=SmKpceTHgdIb69FbbMGnGLEIi8EOV6SbApqq6ktKHXYAZfoy6mlYAIvC+S+dfTshArxSCN3r1u/APQr8uG+snyW5iyt4gEWXpCK2RkCic4R/nGEHUvF5zpGEyDxaOKZYcaKNrUFZgzIcn/uDXpD2G+zvVZ63k4glG0RqUfPF3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729823156; c=relaxed/simple;
	bh=lmA1Qy199U68R7uI18W9AyX9B1CH8iJ6fXdv37uhMDQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=jqf7A3SiEoxB8kNdtHMrCnPTvPWCP1RiiQuPe6K6+MnqswqeM5egPRIClxCGXtHYS5JonMgPdrMJNzs497Iero2cC7W9wUkqzn9hnL0nvVfO0uKKG94Fg9R+ok7BUcB04ukfz1vt+quoe00JKoPTiNMdJvDqrVWDXDAGDiPQK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RhOOFsKp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49P2PpAmA4098653, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729823151; bh=lmA1Qy199U68R7uI18W9AyX9B1CH8iJ6fXdv37uhMDQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=RhOOFsKp3tKDkzzMINX/R2HOc+hgVzQGLKxfjIr9BCNywHsRT4X5lTaw7ENEvUBW7
	 v7UU6P2JLgJZepgjtPU2UNu+fDG1DGARA8Mqr03TGjC5G5o0mdrcijUAgVSEHO+5/y
	 Yc/tCIUaA6vo3F+qlkoOr/0ldcMnLzRfep7Rg4jH783izumfppiMOjYEOYAKsJfCS5
	 gVgurY4NxC7E4MOAIekxCAz2Om0Yc398WziAHI0WW2W/n7Pmx0vPA7B3nJv0JpSsxu
	 7qM9Q7uX7TBCzZTWndAo6BZAhIA6uT9C5c1mjVtHTiDTkZfP1OkFscg3GaSADd45AH
	 eYnMURPWLS7ig==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49P2PpAmA4098653
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 10:25:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 10:25:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 25 Oct
 2024 10:25:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: Fix TX fail with A2DP after scanning
In-Reply-To: <20241021063219.22613-1-pkshih@realtek.com>
References: <20241021063219.22613-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <f03b399f-0d60-489a-a737-78aa93a6d1cf@RTEXMBS04.realtek.com.tw>
Date: Fri, 25 Oct 2024 10:25:51 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> There might be some racing between BT and WiFi after scan. Since
> one of the TX related register will be modified by both FW and
> rtw89_set_channel() in driver, which could cause Tx fail. Reorder
> the calling sequence to only notify coexistence mechanism after
> rtw89_set_channel() is called, so that there are no concurrent
> operations.
> 
> Fixes: 5f499ce69b8d ("wifi: rtw89: pause/proceed MCC for ROC and HW scan")
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

f16c40acd319 wifi: rtw89: Fix TX fail with A2DP after scanning

---
https://github.com/pkshih/rtw.git


