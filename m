Return-Path: <linux-wireless+bounces-26297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C819FB2202C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 10:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75901894AFF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030F1311C3B;
	Tue, 12 Aug 2025 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PLsEdhY1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B7442C
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985773; cv=none; b=mdYDPGje2aA+w3NBcBqo9FhNM+Lo7jb7kNufWKkTTasqZXu6Hovk0VDQU6MZb5WRKxdJ2c9Wf+4QETHf2TaKMUrnkKUJWEIq6VNA7vIicRXsPokLeQXH6rG6swmrFGTppayQOfuLsWwEIeuHeHKQD1OVT/IfqdsXgJIizfcnuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985773; c=relaxed/simple;
	bh=3t0jMAi8ildOgDKlvAA/X3NZ4tEMt+Xc5LZFatWO7TE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=dJIib3TQC5E7D8x1ut1tJi0cpccW4l8pB96CaK5n0828SPtA0KDxLY4aK+Un2XiMF9mBc18vHzXzt/WPXQubHwMk2+I+nI4AnJLAD2ISSyQxdoERUxzOpHZnD3zI/tVDUgQTRV8emc5d8T0yVjggfCGp1QiZbUCsk3B60Wblyp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PLsEdhY1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57C82kEK22114909, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754985767; bh=ff2Y1U0hCQS0oy3EbCSmuCEVI6f/7zkke3pgAz3iecQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=PLsEdhY1SazFJfOSojpD8+K/cD5fT1rvbiGOBkmxWbzqz8bcWUU29OXaweCSy2zGM
	 uCdEJ7Cifb6zoZwcCMmbnMH5Wh7Dzcekcjb1SUOKXhfjf2EHSulb/jhp3NnkP5SeMc
	 t/szbACF1H7omkadJxLoRP+yqOtQKXzxPnW6JgGDcbyfTVxw+/YggADmT3XSB1DmNx
	 LV5FZhcBWQNRIA0JJIWoGgvXedMP1IkvdDQFXEFar1OzHhz4mfipY6WuPKiYjqnszW
	 wUxipPsW8P+vun4K+2obHGTIVrRhJg+ISa5fjnPwI7Ewuezjb8Nr6CUfpaUMOAbhcx
	 nkEmPPGML/cfA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57C82kEK22114909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:02:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 16:02:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Aug
 2025 16:02:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <piotr.oniszczuk@gmail.com>, <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device registers before power-on
In-Reply-To: <20250724004815.7043-1-pkshih@realtek.com>
References: <20250724004815.7043-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <3b698bd1-84fc-47f6-a332-449268bb2ab7@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 12 Aug 2025 16:02:45 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The register REG_SYS_CFG1 is used to determine chip basic information
> as arguments of following flows, such as download firmware and load PHY
> parameters, so driver read the value early (before power-on).
> 
> However, the direct IO is disallowed before power-on, or it causes wrong
> values, which driver recognizes a chip as a wrong type RF_1T1R, but
> actually RF_2T2R, causing driver warns:
> 
>   rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
> 
> Fix it by using indirect IO before power-on.
> 
> Reported-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com/T/#t
> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

58de1f91e033 wifi: rtw88: sdio: use indirect IO for device registers before power-on

---
https://github.com/pkshih/rtw.git


