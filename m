Return-Path: <linux-wireless+bounces-8388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5576B8D79F4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 03:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBAD28136D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 01:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AC015C9;
	Mon,  3 Jun 2024 01:46:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCEE631;
	Mon,  3 Jun 2024 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717379209; cv=none; b=IAx61accnckjszzjZWvquJdSv1+G9LKm86zQwuqh5U4lZCYeNjrw+7GFXHuzVfQhEEIjxNSlsr+oqZ1SS6jCsk5XMEgbwn9hTBzbvowg+e9+uhlIGT8ABWqrS5uYf/9Y4WT97S8MfMP/uIVzC+0eZkfMq3iV8ZNVV01qHmxdblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717379209; c=relaxed/simple;
	bh=MBEvYpJ3XNUQU+0R0PKIw0/tcECMjyn8VNsz2Mp0e6A=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=sQl5lUSeNn9SIqI7U0TvXElsk7HWB3PyLQ5RUnsuUI2eBVOUL2zZ6cHZdBiu3fvVVSKhEzhcizt05rqIB2M49vKB9/kH5L6lE4nTtmRr+MWLS/pOHXuJK4j7Wp92rpeb7o9MyNGIYpkZZcu3DcogRmnnRm7repKo7S4Fs6Rmcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4531kY6f92151776, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4531kY6f92151776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Jun 2024 09:46:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 09:46:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Jun
 2024 09:46:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, <pkshih@realtek.com>
CC: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jiapeng Chong
	<jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] wifi: rtw89: chan: Use swap() in rtw89_swap_sub_entity()
In-Reply-To: <20240529020244.129027-1-jiapeng.chong@linux.alibaba.com>
References: <20240529020244.129027-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <a1c83c7f-4f37-41dc-9491-887589e0e819@RTEXMBS04.realtek.com.tw>
Date: Mon, 3 Jun 2024 09:46:33 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Use existing swap() function instead of keeping duplicate source code.
> 
> ./drivers/net/wireless/realtek/rtw89/chan.c:2336:32-33: WARNING opportunity for swap().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9174
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

9373ed280651 wifi: rtw89: chan: Use swap() in rtw89_swap_sub_entity()

---
https://github.com/pkshih/rtw.git


