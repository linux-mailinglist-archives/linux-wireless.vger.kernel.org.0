Return-Path: <linux-wireless+bounces-23907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36922AD2B2C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 03:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09674188A22D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 01:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6B61714B2;
	Tue, 10 Jun 2025 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mBXG587q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BCB29D19;
	Tue, 10 Jun 2025 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749518438; cv=none; b=Jh1URt6fcpQZe486j9spIVQzHDc4u+hkFT0H3HGib9U22oVaajQN/8hQ9QURn1u4gRY6OXjw+Tz1qhOSWLaBtXrwuYXx1hDRgj5ukSFNl8QB2PAWkD5Ng/Y/bg7mFiGyYOr2eHeErOBeFLbBR88+I7PdxOjhfC+5LkxTz0myCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749518438; c=relaxed/simple;
	bh=cM23n6uiyIm0rU+feuBCMfLiJRbypAe34gyr0xRyO7k=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=USOY7teXR2osyilrWBEaEdexIyY1e42U336Au7XgLuySfqjH1A+uGGB7VVgWM5g6olobLtqoqJKATCuso1jQ4613t+DU75hyou/nIe2Uc46zVkmppdR9Z5qon9WQeb+Q0kgM/U9rRaKFnj6uS+giMjzFSMGj2SD1czeFAy2b5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mBXG587q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A1KVYa81877506, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749518431; bh=f+C89OLNTJLqm7tctjLTcwKe3fypzJO2eXcQDk6EifE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=mBXG587qM5dAIMOF6nm2P7+Y01wwle133ZiJguyU7s/2kKWN4twG3Bi3X1qyZhSF+
	 2IJUTRmSoiX24/mjY4reTFMaI0i0Wge7Y/7kDVpIhizN6rv+NvqIA28lzonKJKQoqS
	 5rhsOKnDEtK1mliWZpfiEOIzAetJqILMVG+kn+JgL4M2OREjjedHjOXudxW4SJ8bLP
	 3k1CES5zuGGKkI/KYfuBcBOQEdufRfbmoF2lTmu0YVEB+QbMlPun1EejyMg0CcOJZd
	 5ZNlPq4r2ZytAtfPmIBMimbmhfj1tiEFwmX6qBzQZ/AieHUMc5fLRpEExMDtown6DG
	 cD6vC7gAFziXg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A1KVYa81877506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 09:20:31 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 09:20:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 09:20:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ping-Ke Shih
	<pkshih@realtek.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtlwifi: Constify struct rtl_hal_ops and rtl_hal_cfg
In-Reply-To: <2c3f3d8d8b2f7dcb8cc64cebe89e55720d1d733d.1747500351.git.christophe.jaillet@wanadoo.fr>
References: <2c3f3d8d8b2f7dcb8cc64cebe89e55720d1d733d.1747500351.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1573e244-e719-4e2f-9812-f9ba905387ff@RTEXDAG02.realtek.com.tw>
Date: Tue, 10 Jun 2025 09:20:30 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'struct rtl_hal_ops' and 'struct rtl_hal_cfg' are not modified in these
> drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> Constification of rtl_hal_cfg is only needed in rtl8192cu/sw.c
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   10167	   5512	    128	  15807	   3dbf	drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   10743	   4936	    128	  15807	   3dbf	drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

4c95423b6f01 wifi: rtlwifi: Constify struct rtl_hal_ops and rtl_hal_cfg

---
https://github.com/pkshih/rtw.git


