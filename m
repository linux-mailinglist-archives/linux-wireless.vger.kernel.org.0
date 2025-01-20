Return-Path: <linux-wireless+bounces-17721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F5BA164E2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 02:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F9A3A0425
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A51E4C80;
	Mon, 20 Jan 2025 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q7hkBwzH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B987483;
	Mon, 20 Jan 2025 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737336551; cv=none; b=jc98/mKwl0yroVZ/N/wTa/7dcSlQjeIit6VfvoKQEbJDqPP/d9qY4JjMmiJk27vBM5mnnvn3ItoED+r5MvWa1mq0QFUfGIvacaAWPomyEAeMw2eSq5RotWOI35utQ/CDKubRe2jzFV0h/472TPQooMY1Eth/Wm6VMn7kDSFn2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737336551; c=relaxed/simple;
	bh=rWnduY7QypPlRiWIgAogQ9z2RuyvPQyaTz0GheyLS60=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=k8ycupzUCUqNd5dRBto5T3J9HJVIGhFdXcUa6TJ0L4eEV1RIXwEdf1wAJ0o636oZBkPHPcJpkMvQhu0bl6qQGqAqb8EC3rnDcYrmYbjukhFJ4MuNSyDi+9HTf7FZDmDrU59LqxxzGzKiucOHemXMmn6ZvNqJ/BkVm/RVe03MAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q7hkBwzH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50K1ShsY62484453, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737336523; bh=rWnduY7QypPlRiWIgAogQ9z2RuyvPQyaTz0GheyLS60=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Q7hkBwzHDymUP6iB6YRrH7zuj5MSktHfjdpaWXevbro5/NbtDt4lWsDnzpdg6BFsB
	 6oXsbo7dXKgRt5zdP8Y2DHmNO9rnNN/G3A4sQ/UoieTvVbn0Yds2+rNjkFsYVjo46+
	 rCBBmqb+DI+iPR1ZdJdr2MPZw0/Kp40vNC6lQ6o7k4VWxkolhblxmMkEbTJyiNtu//
	 8jCWgekb2F01Bj/ZrHw3+YDISmBL1F6x1M1pSR3kFAJGn40zb/qNpmGcvAsTWdROwr
	 BseheC+wtKxD2ft7LuYyUBt5eOvgAuwx0YjnBmcI/NaC1a9Job6z4aKlxrJv6UxUDW
	 YgVpmWC8ULQ3g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50K1ShsY62484453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 09:28:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 Jan 2025 09:28:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 20 Jan
 2025 09:28:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Liang Jie <buaajxlj@163.com>, <pkshih@realtek.com>
CC: <kvalo@kernel.org>, <phhuang@realtek.com>, <fanggeng@lixiang.com>,
        <yangchen11@lixiang.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Liang Jie <liangjie@lixiang.com>
Subject: Re: [PATCH v4] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
In-Reply-To: <20250112105144.615474-1-buaajxlj@163.com>
References: <20250112105144.615474-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1151cd14-9bd2-4d18-ae00-8e54d46465d9@RTEXMBS04.realtek.com.tw>
Date: Mon, 20 Jan 2025 09:28:43 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Liang Jie <buaajxlj@163.com> wrote:

> From: Liang Jie <liangjie@lixiang.com>
> 
> Ensures the correct calculation of `cfg_len` prior to the allocation of
> the skb in the `rtw89_fw_h2c_scan_offload_be` function, particularly when
> the `SCAN_OFFLOAD_BE_V0` firmware feature is enabled. It addresses an
> issue where an incorrect skb size might be allocated due to a delayed
> setting of `cfg_len`, potentially leading to memory inefficiencies.
> 
> By moving the conditional check and assignment of `cfg_len` before skb
> allocation, the patch guarantees that `len`, which depends on `cfg_len`,
> is accurately computed, ensuring proper skb size and preventing any
> unnecessary memory reservation for firmware operations not supporting
> beyond the `w8` member of the command data structure.
> 
> This correction helps to optimize memory usage and maintain consistent
> behavior across different firmware versions.
> 
> Fixes: 6ca6b918f280 ("wifi: rtw89: 8922a: Add new fields for scan offload H2C command")
> Signed-off-by: Liang Jie <liangjie@lixiang.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

361cb056e246 wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be

---
https://github.com/pkshih/rtw.git


