Return-Path: <linux-wireless+bounces-7375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D0B8C0B7D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 08:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1591F22AFF
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 06:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9BD1494C7;
	Thu,  9 May 2024 06:23:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9A323D
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235814; cv=none; b=k/00RjLZqeqStAukpZE8sCEZsALb7qZMcsRE0wTFJtKBMs53Q3/u+c25HUFnQL3nOtg8ZViGrP1KkHREMB4zj/PMddS2YGQW5gp1K6IY+GMc0U+V4yPbXrOqgAIB1qTHl41kNmXlCO0l/3o7VeAicRPoR6GIg5+2/hx0HLkI5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235814; c=relaxed/simple;
	bh=Uu9VEdNpLTRZfoCao7ZIwXUb5Gg9OZsdDZNOGQpWF60=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=nNYZOLu7Ig2GHojFAeSjhU0ohC/UdnQYG/qcR3rpW4V5xw0/VEdFa2QDgtTuq7CW18r8wVS7MPh2sydw8O5kRgfjnBmbvyDNLFiDj1V8QzKAP/HpTe3/2rqBdZgpNhHSK2l5Q6C86AiplVH9YdXWcK/jBY9qz3JAJpI2y5SKgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4496NP4201291493, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4496NP4201291493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 May 2024 14:23:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 14:23:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 9 May
 2024 14:23:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
Subject: Re: [PATCH] wifi: rtw88: usb: Fix disconnection after beacon loss
In-Reply-To: <ecbf0601-810d-4609-b8fc-8b0e38d2948d@gmail.com>
References: <ecbf0601-810d-4609-b8fc-8b0e38d2948d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <5fc4ad6b-5af8-469b-9665-d41ddb6d465f@RTEXMBS04.realtek.com.tw>
Date: Thu, 9 May 2024 14:23:25 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> When there is beacon loss, for example due to unrelated Bluetooth
> devices transmitting music nearby, the wifi connection dies soon
> after the first beacon loss message:
> 
> Apr 28 20:47:14 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>  CTRL-EVENT-BEACON-LOSS
> Apr 28 20:47:15 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>  CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1
> 
> Apr 28 20:47:24 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>  CTRL-EVENT-BEACON-LOSS
> Apr 28 20:47:25 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>  CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1
> 
> Apr 28 20:47:34 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>  CTRL-EVENT-BEACON-LOSS
> Apr 28 20:47:35 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>  CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1
> 
> When the beacon loss happens, mac80211 makes rtw88 transmit a QOS
> NULL frame and asks to confirm the ACK status. Even though rtw88
> confirms to mac80211 that the QOS NULL was transmitted successfully,
> the connection still dies. This is because rtw88 is handing the QOS
> NULL back to mac80211 with skb->data pointing to the headroom (the
> TX descriptor) instead of ieee80211_hdr.
> 
> Fix the disconnection by moving skb->data to the correct position
> before ieee80211_tx_status_irqsafe().
> 
> The problem was observed with RTL8811AU (TP-Link Archer T2U Nano)
> and the potential future rtw88_8821au driver. Also tested with
> RTL8811CU (Tenda U9).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

28818b4d871b wifi: rtw88: usb: Fix disconnection after beacon loss

---
https://github.com/pkshih/rtw.git


