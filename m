Return-Path: <linux-wireless+bounces-26884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F9B3D6ED
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 05:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCECA7A6776
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 03:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE11E1E16;
	Mon,  1 Sep 2025 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Mc63MSvs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2348CFC
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695876; cv=none; b=UTjf8jUoo5SxOZfexbLR4lPYx42vyZMW1cSaCCMMDoVUArOduGd4VZUD7yrz+ScVhAra6bI3GEcaupscxgeHSoPK7LPoQk4rCULLBhBLoRm5lU94Xmvy9EtAVtOdEZf+4TkzJUrXbPMtqzJv4oMaPSF1gri5qmfk6zdQPxXUCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695876; c=relaxed/simple;
	bh=eI4907Qrv3hwYYwyCrAvptDCV94GCQRVhh5Stf4IC5g=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=t5ssepjBTLBPbhPSMItn2QPKc74ayP1obVYKWqwjsh+T9hFAA5IYIoKp4wrl9S0leGHVK5Ic3IEkJLfHzsI3a6B9AjNPYC6KSpkbtXcohLcy2gcY3SQlo+fyVyLH9IeEwxvC0UJjk9345a/vsfgfju8mLronquzl+hBPz/Uyxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Mc63MSvs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58134VEr8183162, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756695871; bh=EgLsCOhFjAq0sIiJtm7v2np6V+JT+w1BPmrMeSmLYkQ=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=Mc63MSvsbL0qzZToBPwwHU2TYxz2E6u/qak2j2ceNG4OfzZHlXlE8JWhLjSupwOog
	 ivpynaj9BgIk7BpLxPjGAmDbggZBPkbOTkBhAAI6bc1yDLa+5d/s2/XbaUF3TCN2Ps
	 9CmnBrM+TF623LvgbUt4VjyW4TfVIMn6N56iIY3yQG92pkpWSra9RFqdpbE/gk44Tw
	 1Yayc3j3rXSRV79AMuezjDJp8UHemp1q0fo4gK70BLLOY2Y4a7uclR0vp95ByeIwPG
	 vDcOOWCi5HwqKYToiwLz2aJr5HGRuwKCIkh+G+G1vA2MOC9GYUXAR3+A4dqBuedLqw
	 3PtDdRWLPKX8g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58134VEr8183162
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 1 Sep 2025 11:04:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 1 Sep 2025 11:04:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 1 Sep
 2025 11:04:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH rtw-next 01/10] wifi: rtw89: pci: move chip ISR definition out from chip generation
In-Reply-To: <20250826085152.28164-2-pkshih@realtek.com>
References: <20250826085152.28164-1-pkshih@realtek.com> <20250826085152.28164-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <fb83b43b-5a04-4dc2-a172-71cee1f96efa@RTKEXHMBS06.realtek.com.tw>
Date: Mon, 1 Sep 2025 11:04:31 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The existing WiFi 6 chips can share the same ISR (interrupt status
> registers), but the coming WiFi 7 chip 8922DE can't share the same
> definition with existing WiFi 7 chip, so move the definition to an
> individual struct.
> 
> Don't change logic at all.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

10 patch(es) applied to rtw-next branch of rtw.git, thanks.

5cc73513f9b2 wifi: rtw89: pci: move chip ISR definition out from chip generation
862132fbfc89 wifi: rtw89: pci: prepare interrupt related registers and functions for 8922DE
d6303028ae55 wifi: rtw89: pci: use RDU status of R_BE_PCIE_DMA_IMR_0_V1 instead for 8922DE
7bd90ec75e76 wifi: rtw89: pci: add struct rtw89_{tx,rx}_rings to put related fields
a86a0fea192c wifi: rtw89: pci: define TX/RX buffer descriptor pool
2d7514829950 wifi: rtw89: pci: add group BD address design
83d823ab27da wifi: rtw89: pci: abstract RPP parser
110f3c11f440 wifi: rtw89: pci: add RPP parser v1
571ce803c282 wifi: rtw89: abstract getting function of DMA channel
e83a2a996b5c wifi: rtw89: add getting function of DMA channel v1

---
https://github.com/pkshih/rtw.git


