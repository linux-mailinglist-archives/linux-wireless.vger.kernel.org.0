Return-Path: <linux-wireless+bounces-26441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F27B2B5F9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 03:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB3019642FD
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 01:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B71D1DF246;
	Tue, 19 Aug 2025 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="npMmu+H+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD91DB122
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 01:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566867; cv=none; b=qEDqwQunKhu4GGLHjIg81McdTieoSlywSNQ6V8mpXEkKVFqIuxfK8Bo+QB/ftjvan3Oe+b067U9T4TgNLbaRbHlahp+lzDcwO89Fm7Zme/DeKQ7V0IMG3Sdkh2yOdDGUSeGwQQ/bhrRx7q55gmLYekbIYPouOJGEOU2S2kFpfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566867; c=relaxed/simple;
	bh=DrcKWFl4xAzDhkJVVDDd+D7pya/w7KRdVTe4wCodGXM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=hIZ58oe9n9oCaFrDdn4h3Iw8tw57qOjHZVmByttd42HeEgAwnUCbo+U/vsdx+zKDCoa9hyAt+yRvSI7SUs1DjqkTiCgmSbaj/DP4KWbdQgLLINd9qylB0FlAwYhHhHq4NvOgJY3ZO1Vg2X+opHow+PFqHQvfxMXXBBFWhXcDDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=npMmu+H+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57J1RWiiC1860401, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755566852; bh=64W4eg7JjMR4Qb77tMFRMAve5FXYVv+cwJXoXifUVck=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=npMmu+H+AMJa78gHYC4E9ojg62T3tXZOmwzblFTOpTvAVR5p+8DdKFYfmgkyL6Vzy
	 q3nU32dRCkj45+fpV/K9ddRTUAsNtsORc6uv4QcIrj/rGo8pf0xk7Qgudx3cVHF06w
	 Unz5qbO6KcYjTc/eO0WxZwQiTpF6Sg6QtLNq6wS/PeJU2ilMRjc93oMlpzj2D6HZZa
	 y/mFsJ0rH5ozCncFfR+bel8jP+Pb4hvxpbGQPB/R4rvYcfX0U6G1LDRRSj410/omuk
	 cA3ekW8PDUk/Nu9EgO8D5966MMDCatHM3b0kOgPFw5Q1pjWTYsLhDrysCppJKW0U4w
	 1YLLxNSndLYEA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57J1RWiiC1860401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 09:27:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 09:27:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 09:27:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH rtw-next 1/2] wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188
In-Reply-To: <2e5e2348-bdb3-44b2-92b2-0231dbf464b0@gmail.com>
References: <2e5e2348-bdb3-44b2-92b2-0231dbf464b0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1dd51e8a-d906-4a5f-8f72-7ac9994f4d25@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 19 Aug 2025 09:27:33 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> This ID appears to be RTL8188SU, not RTL8188CU. This is the wrong driver
> for RTL8188SU. The r8712u driver from staging used to handle this ID.
> 
> Closes: https://lore.kernel.org/linux-wireless/ee0acfef-a753-4f90-87df-15f8eaa9c3a8@gmx.de/
> Cc: stable@vger.kernel.org
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

e798f2ac6040 wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188
ec0b44736b1d wifi: rtl8xxxu: Don't claim USB ID 07b8:8188

---
https://github.com/pkshih/rtw.git


