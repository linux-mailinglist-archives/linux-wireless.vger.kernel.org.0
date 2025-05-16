Return-Path: <linux-wireless+bounces-23044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A91AB9341
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 02:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578887AA646
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDACB4683;
	Fri, 16 May 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="twJS9hCQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28028EA
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747356001; cv=none; b=tjq1p/EjfpWxF4rjc42NO70VW0Jw93/pKJx6e5WAgSsEjk0QmvLXEs3VnPoJqjBq9iqWq7koo4XuxDfiRHSOA4wByDfyXgSW/Q5Z/+kaej+/WLeTnpsrr8nyG9ctXIuv9Jq4E6Vq4VWfkZsBu4kkkTgTJIQc5OaGh74E+byBM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747356001; c=relaxed/simple;
	bh=f65VsB/xV4ZuZ0AKvHCRp8ZrYTYTrffv3YmPvIDVoSc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=jpmCJdkJWJEZZAkEYVlLT0Zj56V4HltpOz5Y2y4FpRvjMO2jChhHDGkUs6E9DjfA0YRauS+mq96vNWQmVOS/zA2uBjDlYhgC92aNLsrEZvukq5rCd6cyHH8JIC1Vs3EOjgujnuvktCAIbDzSoTLZDA3miegpMkmvXv9fIZj2MRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=twJS9hCQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54G0dt5vB040686, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747355995; bh=f65VsB/xV4ZuZ0AKvHCRp8ZrYTYTrffv3YmPvIDVoSc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=twJS9hCQo47Uzn/HfkMFO9yEIbkuxg1q3YGHkfPNuG1e7cNtBznJHCl/PfL1AQ7Bb
	 6+7wU6VEx7BBdW491CwMad6QnbQq7fZ1EdAtpcDoVkq5IVlk9qRbK7LVrjRHo+buL+
	 HM8W8dz755sPApNqfEG9TAisBIFBC+3K1RIzeg9500C19hRaxTD1YJZnt5I49yUv0V
	 IZh2QVVEL+sEXilMeCoRg4G2ysTphs7D2cQ1ypAMFVXJSLIqhnOAnHWz28S7+1urxn
	 QLNF08Tb5+E95q7J31aZhp9hN7oIPwCDyZpzYZRQAPtPsbYL5F2s4WsB9sfFcga8sk
	 e8YkIAdrE3kKA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54G0dt5vB040686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 08:39:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 May 2025 08:39:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 May
 2025 08:39:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v2 1/2] wifi: rtw88: usb: Reduce control message timeout to 500 ms
In-Reply-To: <1e35dd26-3f10-40b1-b2b4-f72184a26611@gmail.com>
References: <1e35dd26-3f10-40b1-b2b4-f72184a26611@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <045ab5ec-8599-4e9d-9ffd-c43e1e7096b5@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 May 2025 08:39:55 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> RTL8811AU stops responding during the firmware download on some systems:
> 
> [  809.256440] rtw_8821au 5-2.1:1.0: Firmware version 42.4.0, H2C version 0
> [  812.759142] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: renamed from wlan0
> [  837.315388] rtw_8821au 1-4:1.0: write register 0x1ef4 failed with -110
> [  867.524259] rtw_8821au 1-4:1.0: write register 0x1ef8 failed with -110
> [  868.930976] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: entered promiscuous mode
> [  897.730952] rtw_8821au 1-4:1.0: write register 0x1efc failed with -110
> 
> Each write takes 30 seconds to fail because that's the timeout currently
> used for control messages in rtw_usb_write().
> 
> In this scenario the firmware download takes at least 2000 seconds.
> Because this is done from the USB probe function, the long delay makes
> other things in the system hang.
> 
> Reduce the timeout to 500 ms. This is the value used by the official USB
> wifi drivers from Realtek.
> 
> Of course this only makes things hang for ~30 seconds instead of ~30
> minutes. It doesn't fix the firmware download.
> 
> Tested with RTL8822CU, RTL8812BU, RTL8811CU, RTL8814AU, RTL8811AU,
> RTL8812AU, RTL8821AU, RTL8723DU.
> 
> Cc: stable@vger.kernel.org
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Link: https://github.com/lwfinger/rtw88/issues/344
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

490340faddea wifi: rtw88: usb: Reduce control message timeout to 500 ms
80fe0bc1659c wifi: rtw88: usb: Upload the firmware in bigger chunks

---
https://github.com/pkshih/rtw.git


