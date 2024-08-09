Return-Path: <linux-wireless+bounces-11155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8EE94C7F5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 03:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF181C21657
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 01:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948AB802;
	Fri,  9 Aug 2024 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tAVoPnGy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0A4748D
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166362; cv=none; b=GUYG7hFimtvtQud6IHO9GBsvWKuxpEu71Y0gKEpzJ19WhM0PHyFjXldl7kceTMO5Pe1q/cYytl4l5JDUocR+oAUzFuamWJrkTjkI3lMXn3HqBnut8qO76U7N6YHt/hTnrlXBeKx4NBgU5kT92s9DmCokiwO5dZI9T6H9f8ub3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166362; c=relaxed/simple;
	bh=vz0vKDPBnfAu2PTdvuZSSG5fcRGuzTnL3qV+PH7qmng=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=VEgSRtIhfSSn1TOPmKyUSZ5KyPnP225SWlvR16QCSHcuuvNcqHxgFsvPXvPnN2Zw4VMBVAbaP++sNyXLw8cCtPIp6UI4hL+9m/lKhDRNE3g/mT9mICqYyyoj9WIDWee977fWZm1lDQVLnvmXaMjxF4RboB5dx72jEN6fRZWw1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tAVoPnGy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4791J64z8150405, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723166346; bh=vz0vKDPBnfAu2PTdvuZSSG5fcRGuzTnL3qV+PH7qmng=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=tAVoPnGy6aadcU2dxr+qLb/jZuVv1IkPrSUIf9jhBEKwqjuQZtTRzvu43yMtrnNO2
	 oWBOm++ErssPe0JVzeCkmBl844kQYSnE4Hb6YDhmUNtt37YrWK4S8VrZEC+zM5dkrf
	 d/eln6vcNlpx7tPdRGb4Ih2JHNLy8Vdct3xU3OtYcuyhFphpIh+uaYEui15M83GvZo
	 3nigqvm/LbWJTAz8CxEVnVg0KGHoNqndO+wvjBBxg4rDEV/JyTtLuEO/UbMU735H0x
	 hBgEUCO75oi66dsP4zg0CZLlZv9pUK3Kzmv7cqVmUw3ZsnADl4vi7M6huWIMLM0T+1
	 uzFsbNzDtxAdg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4791J64z8150405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 09:19:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 09:19:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 09:19:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
Subject: Re: [PATCH v4 1/4] wifi: rtw88: usb: Init RX burst length according to USB speed
In-Reply-To: <ac569c6f-7129-4341-b523-901fe10cabff@gmail.com>
References: <ac569c6f-7129-4341-b523-901fe10cabff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1924fd75-afaf-4190-a69a-7efd055ae94a@RTEXMBS04.realtek.com.tw>
Date: Fri, 9 Aug 2024 09:19:06 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> This is needed in order to make USB RX aggregation work with RTL8811CU
> (and presumably RTL8822BU and RTL8822CU also).
> 
> I don't know what BIT_DMA_BURST_CNT, BIT_DMA_MODE, and BIT_DROP_DATA_EN
> are doing.
> 
> Tested with RTL8822CU, RTL8811CU, and RTL8723DU.
> 
> The RX speed is unchanged in my tests.
> 
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

fbbd8cb347e2 wifi: rtw88: usb: Init RX burst length according to USB speed
38ea04a79ad0 wifi: rtw88: usb: Update the RX stats after every frame
df3d8f463b1d wifi: rtw88: usb: Support RX aggregation
002a5db9a52a wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c

---
https://github.com/pkshih/rtw.git


