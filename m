Return-Path: <linux-wireless+bounces-9629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5799919D14
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 03:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684FEB223F1
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 01:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844462139DC;
	Thu, 27 Jun 2024 01:57:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D74C6D
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453457; cv=none; b=qxkZ1g1d/7AOhGxVxP8FgbRep3kphPlBqovemybzwxIqIqhV6PdhTUA1/YUdBDFWc9+JV77+mCHltRQIn2MfSwj5FfXisCpbdKQrWdEMy0VMCY/GRJkVfPe6SyhvBXTpWB/8iltF4jLNdg912FALxeDmlFEAd4DV+/WZ43c4sbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453457; c=relaxed/simple;
	bh=7zojWKuinUbccwi1FMnkPYdpiUYywqb2nve3VdjXhQo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=m2agHPl9n6GRakLgV6MceF+904JwI4JTBiAriv1YiFxCgybySTmQxiwXG2wqz301Qz/H038Z7crJ8CISM0Ugmch3wSdkEBtnEQox2y8hluK5wZ7IDVn8k0OJf7sL8EW51YcooCY8fpi2f3DdLTFQb7SD0oHlES6LLDgeV6bkSDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45R1vC5612502203, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45R1vC5612502203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:57:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 09:57:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Jun
 2024 09:57:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: 8188f: Limit TX power index
In-Reply-To: <20240624140037.231657-1-martin.kaistra@linutronix.de>
References: <20240624140037.231657-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <e6896e44-91b8-4f41-aac6-49d8c8fc13be@RTEXMBS04.realtek.com.tw>
Date: Thu, 27 Jun 2024 09:57:11 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

> TX power index is read from the efuse on init, the values get written to
> the TX power registers when the channel gets switched.
> 
> When the chip has not yet been calibrated, the efuse values are 0xFF,
> which on some boards leads to USB timeouts for reading/writing registers
> after the first frames have been sent.
> 
> The vendor driver (v5.11.5-1) checks for these invalid values and sets
> default values instead. Implement something similar in
> rtl8188fu_parse_efuse().
> 
> Fixes: c888183b21f3 ("wifi: rtl8xxxu: Support new chip RTL8188FU")
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d0b4b8ef083c wifi: rtl8xxxu: 8188f: Limit TX power index

---
https://github.com/pkshih/rtw.git


