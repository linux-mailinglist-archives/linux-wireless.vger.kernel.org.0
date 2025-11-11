Return-Path: <linux-wireless+bounces-28817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83194C4B2B9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 03:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F85F34BF64
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 02:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D091330217E;
	Tue, 11 Nov 2025 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XsMA3SPU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53E26E14C
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826974; cv=none; b=dsfrgJau6P0ysJ0rg6v6nMFYbpJ7wYKQQUb2URutBZ04Y+SGFX7wgxaBXlugZX3/RMFYgoVoCj8BsykjtikHUnCt78tSItk4TpqCr3VntYsaddo82wWW2sa//wTAvguxFSfDcmM9PPQOhqa42/pdS4CUY/zvah2E0g5U5H4Cp2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826974; c=relaxed/simple;
	bh=WFeRECLxPy4CYsjAf/SLVpDzt4J09Anti3MF/sUahto=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=qncbP715DT4zUlunQTFCY6mK6rpn35Hb7M5zt1KrUhlkKHKljAsIhkQmcdmW4k0bhB0T3Z0uWMbF/zJKyzOeosH2VTF8Lvh2+oLIp2rlItO3tr2YQMwwvihNaHqnoXO3KTEmy6enUS2sxt7x2V9o4NNh46k4NX9/xGnZB54Ngvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XsMA3SPU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB29Qn542890019, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762826966; bh=hzFT4ETEMytd6FggovRzW3eJPiXlXuLFK0jiX2+wbQ4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=XsMA3SPU5SDQDCnkNdTDI53Dl4anNeb411RkhRdmYXK8x71Ies44N9hiU5PwFtMlH
	 fdFRI86csEwFUwzzE2XUAIcYRRxRoOLgoR7jFUHK5p6UiTBoW0z9ifohLJzVc2rYwR
	 5qvflYRPnEJuphll3yRquEISdw00CUrdOFAMnlUxu58SUrRr5dzTEEHcyLrsPR7dSo
	 6SiSQOgrdeqeoGZQQcX3cqU4pHGtzgfBYUrtHqDDRrDsRmnP9jFf98SIokHhCbXB2J
	 V6EkJSaz8A+a6AHaWFrU56u6uU0RE3ovApJQVpm9dVme7kMPebKFZor4PswlCrcD5g
	 eXdKzx33/Uc0g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB29Qn542890019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 10:09:26 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:09:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 10:09:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next 1/6] wifi: rtw89: Use the correct power sequences for USB/SDIO
In-Reply-To: <dec13310-06eb-429e-acb8-4c5b62656836@gmail.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com> <dec13310-06eb-429e-acb8-4c5b62656836@gmail.com>
Message-ID: <9bfc52ca-ee48-4ddc-8244-1f8020ae9bd1@RTKEXHMBS04.realtek.com.tw>
Date: Tue, 11 Nov 2025 10:09:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Make rtw89_mac_pwr_seq() select the right parts of the power sequences
> based on the interface type.
> 
> This is only relevant for RTL8852A. The other chips don't use power
> sequences.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

6 patch(es) applied to rtw-next branch of rtw.git, thanks.

233542f5b4a8 wifi: rtw89: Use the correct power sequences for USB/SDIO
0eea5e0f03db wifi: rtw89: Add rtw8852a_dle_mem_usb
c19b106609f3 wifi: rtw89: Add rtw8852a_hfc_param_ini_usb
1dfd11e70022 wifi: rtw89: 8852a: Accept USB devices and load their MAC address
0029ccab53ac wifi: rtw89: Add rtw8852au.c
623c177323ec wifi: rtw89: Enable the new rtw89_8852au module

---
https://github.com/pkshih/rtw.git


