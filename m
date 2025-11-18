Return-Path: <linux-wireless+bounces-29066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD8C66E4A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 02:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF889357DA0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 01:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A992309F1B;
	Tue, 18 Nov 2025 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iGBmvwmR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE230FC00
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763430876; cv=none; b=D2Yn/l99VpN5OHCZ7Ffb0uIA3M+npQfDsnEuwrGsyaZmpSLMa6qzy74v1UW1wGhOH7PNl8FyMpILM/u9nwUwo3zTtnIOT0X1aSQKUVcKzaYxuoZYYTenyxPB1JVGac11RAkITY1U94TazvMd7QQni/jPagukbIPCQGUZip2dPMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763430876; c=relaxed/simple;
	bh=AKJ4nMQV1pK9UQnuUQijWNtrojD7ITvOFJ3jcU4sJXg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=jTjTXFvmcMEhUyI5irlrhgC56oAMqv87EV1QWhXUe3xMyggtu33FMLhej4szF5YmaKghiA2yPX2mbbfB1h0CXxDfmpugmgC/s41P4TTM77PUwZ340JGa7hj7uhezgkXvCZX7h6lAgK33FAVYML0Rix37/VajyUJnMFPi4D63eds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iGBmvwmR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI1sUKE1577460, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763430870; bh=64VVPznOLBd+xfSjWjpv0O1axlTq4xfivjJCCUBhkEk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=iGBmvwmRNqQNuEc1zc8iYoxx+t6TDfNEcnWYQ754Q/XTggv/kExhEzzo+qp6ahWbc
	 cuLOeklmcb9zN+6c/XoE6FSTsKxltiV9iGm5GpzFH6mpqw36C88pKG0zngcdBMZl30
	 b9ybpTt2NcWdEMcLInSGMNVcdxuJiVwqb+ZLQeiGbGq7u3LFxrMkxo+diLhWE5oDWG
	 VY9xaAln0an4WHy6T+gYqrZTynbUWaL5x2YkCT5pv0uWKABSXqa47nD54lslNeio4Y
	 ilsZSGAg58rpqHeMxWxX8BYQT0mUYvfke2788Yw8HHft7dCY8dcWn3ZQi4k4Dg+GAM
	 C8avauZSyITug==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI1sUKE1577460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 09:54:30 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 09:54:30 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 09:54:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 18 Nov 2025 09:54:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: Re: [PATCH v2 rtw-next 01/14] wifi: rtw89: flush TX queue before deleting key
In-Reply-To: <20251114060128.35363-2-pkshih@realtek.com>
References: <20251114060128.35363-1-pkshih@realtek.com> <20251114060128.35363-2-pkshih@realtek.com>
Message-ID: <9529871b-d080-4000-bdf7-8922aec13143@RTKEXHMBS04.realtek.com.tw>
Date: Tue, 18 Nov 2025 09:54:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> In the wpa_supplicant rekey flow, it sends an EAPOL packet 4/4 through
> nl80211_tx_control_port() and triggers wake_tx_queue() in the driver.
> Then, it sends nl80211_new_key() to configure a new key in mac80211.
> However, in wake_tx_queue(), a workqueue is used to process the TX packet,
> which might cause the driver to process the EAPOL packet later than
> nl80211_new_key(). This results in the EAPOL packet 4/4 being transmitted
> with the new key and IV, causing it to be dropped by the AP. Therefore,
> needs to flush TX queue before deleting the old key to ensure that the
> EAPOL 4/4 packet is transmitted using the old key.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

14 patch(es) applied to rtw-next branch of rtw.git, thanks.

3a12581fc292 wifi: rtw89: flush TX queue before deleting key
92db331de6de wifi: rtw89: fw: part size to download firmware by header info
a2a64fe23463 wifi: rtw89: mac: separate pre-init code before downloading firmware
12e84effcb6d wifi: rtw89: phy: calling BB pre-init by chips with/without BB MCU
d375434cbcea wifi: rtw89: mac: remove undefined bit B_BE_PPDU_MAC_INFO
7fefea11001d wifi: rtw89: mac: update wcpu_on to download firmware for RTL8922D
9df55e8d41aa wifi: rtw89: phy: consider type 15 in BB gain table
5607a141bf28 wifi: rtw89: phy: ignore DCFO if not defined in chip_info
1c2ada09628b wifi: rtw89: fw: print band and port where beacon update on
aa8d1a8805bb wifi: rtw89: align RA H2C format v1 for RTL8922A
239dd70d776c wifi: rtw89: fill addr cam H2C command by struct
fc2e8c873f46 wifi: rtw89: add addr cam H2C command v1
9dab26b9fa45 wifi: rtw89: update format of addr cam H2C command
09afd209a844 wifi: rtw89: correct user macid mask of RX info for RTL8922D

---
https://github.com/pkshih/rtw.git


