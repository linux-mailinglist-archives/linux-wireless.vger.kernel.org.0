Return-Path: <linux-wireless+bounces-28515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0AC2EE2E
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 02:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B96484E01FD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 01:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7C52236FD;
	Tue,  4 Nov 2025 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MzP0FgJb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46422FE0E
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221188; cv=none; b=etAUzqoV678OdaLapWWNE3lYHflzXzeFu2i7IxWWahSf6LrkgQGxQaYXCitdIJZy14zaQsbJpNK6kJP9Ec0U1qSDPuXd5S51UFyt8eX0/SMbIhLQkiiQZwTtpbXLlkVZmHwCt6behyOOTwyE/fH8IAxMjJ7arwK4nyx83REt09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221188; c=relaxed/simple;
	bh=KhYYrdFAmoRnqpo+L3LSswmk36oOy07lL2Zcoe8L9so=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=gPo9wgVW8ft/RoCJqcG/DpGr1MdIE236L0kAx9exNWGgfq2rUaro6+Az3zSVdDAeb4nMm1mH60lJqm64Muv0vNH4rFi2acPBxsts9+uYkWkcBmYDd6w++j13t/uilB4OEAk9qWBJ3pC45wmftETEIVZ8Z/gsPH0YYSKH+t7UI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MzP0FgJb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A41r0q452466303, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762221181; bh=5pyCFQsKMlTrLjwErrb/Gw8l9W5KLBu3vPOiVGG7xKo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=MzP0FgJbXv+1oi/O+TIeO8bmC4eJEy8V3/EMJZulAJzfEk4V0asLPb1ztPGeBBULb
	 bOXtstOib86dmZim54B5zd4xkRFMMAEdzjUzfXunEPdhlWpwL9O6zLabJJ7x4ojXoK
	 c0x5ponBpE42zrwH05zCKfuUBVbagdFU2Wk0jTcyuhk0FAtJGGY4bghSby4j2tdAOE
	 c4d2RCB52n2s/an9jxGcJ1YM5daP7F6dRuhkPTh7cVb0Zc1pzirrWfI392zfqdxpTe
	 g86PSnlLHbEHdYE7Hp0SgPc9EQQYV7hP2c0kYiKUcKIsxwLGwZIOzmy1ecCsdGm8Ku
	 iT1ShHBrssMbg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A41r0q452466303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 09:53:01 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 09:53:01 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 09:53:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 4 Nov 2025 09:53:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v4 01/12] wifi: rtw89: 8832cu: turn off TX partial mode
In-Reply-To: <3904dd9f-2178-41e5-95c2-7a9f6268e935@gmail.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com> <3904dd9f-2178-41e5-95c2-7a9f6268e935@gmail.com>
Message-ID: <206354cb-1b1e-4718-a1c6-f6c5c9b0aec9@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 4 Nov 2025 09:53:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> The TX partial mode in USB devices will cause timeout to wait for payload,
> causing SER 0x999 and disconnection. Turn off this mode according to
> design suggestion.
> 
> rtw89_8852cu 2-4:1.0: FW status = 0xee001108
> rtw89_8852cu 2-4:1.0: FW BADADDR = 0x18605fc8
> rtw89_8852cu 2-4:1.0: FW EPC/RA = 0x0
> rtw89_8852cu 2-4:1.0: FW MISC = 0x1010000
> rtw89_8852cu 2-4:1.0: R_AX_HALT_C2H = 0x999
> rtw89_8852cu 2-4:1.0: R_AX_SER_DBG_INFO = 0x71020010
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f554
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f556
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
> rtw89_8852cu 2-4:1.0: --->
> err=0x999
> rtw89_8852cu 2-4:1.0: R_AX_SER_DBG_INFO =0x71020010
> rtw89_8852cu 2-4:1.0: R_AX_SER_DBG_INFO =0x71020010
> rtw89_8852cu 2-4:1.0: DBG Counter 1 (R_AX_DRV_FW_HSK_4)=0x00000000
> rtw89_8852cu 2-4:1.0: DBG Counter 2 (R_AX_DRV_FW_HSK_5)=0x00000000
> rtw89_8852cu 2-4:1.0: R_AX_DMAC_ERR_ISR=0x00000000
> rtw89_8852cu 2-4:1.0: R_AX_DMAC_ERR_IMR=0x00000000
> rtw89_8852cu 2-4:1.0: R_AX_CMAC_ERR_ISR [0]=0x00000000
> rtw89_8852cu 2-4:1.0: R_AX_CMAC_FUNC_EN [0]=0xf000803f
> rtw89_8852cu 2-4:1.0: R_AX_CK_EN [0]=0xffffffff
> rtw89_8852cu 2-4:1.0: R_AX_CMAC_ERR_IMR [0]=0x00000000
> rtw89_8852cu 2-4:1.0: [CMAC] : CMAC1 not enabled
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

12 patch(es) applied to rtw-next branch of rtw.git, thanks.

030b8d5878e8 wifi: rtw89: 8832cu: turn off TX partial mode
89acd6c49322 wifi: rtw89: Add rtw89_core_get_ch_dma_v2()
994944aa58f8 wifi: rtw89: usb: Move bulk out map to new struct rtw89_usb_info
7697701d6c03 wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_pre_init() for RTL8852CU
199afd3af12c wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_post_init() for RTL8852CU
32e0381e8603 wifi: rtw89: Fix rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
97259766b18e wifi: rtw89: 8852c: Fix rtw8852c_pwr_{on,off}_func() for USB
a86589908460 wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
19faad8c729d wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
6bc2711085a5 wifi: rtw89: 8852c: Accept USB devices and load their MAC address
406849000df4 wifi: rtw89: Add rtw8852cu.c
0d971ffdae58 wifi: rtw89: Enable the new rtw89_8852cu module

---
https://github.com/pkshih/rtw.git


