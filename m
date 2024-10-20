Return-Path: <linux-wireless+bounces-14237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5479A5201
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2024 04:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41434B249AA
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2024 02:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C1C376;
	Sun, 20 Oct 2024 02:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eGF+4/nH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417D33E1
	for <linux-wireless@vger.kernel.org>; Sun, 20 Oct 2024 02:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729392118; cv=none; b=rupIIEzwrKk+l+qdi2ys69DSN17tuW+1e5/IFmJEAXC4sD/dw5ZFZrCLEYGhxkBOl6ApKzFkBLO+aSLRutZlJGtGerZ/iMw73Qa71K2NmGa31Q3dKLtC7q6Ub6yEBpu+Z7P1abgBjBYJCTxcGzSNMLI2GUF3WBFMTMx3764VaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729392118; c=relaxed/simple;
	bh=9M34b+aMQyEye1GomkTypgKLUbOG2iUKZA16bdpdNaQ=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=fiL3/q29yqAr4k/CJpUU3rKacpHF5pzD/s1sZW1KYSUCLmz2jAdgkqBWCpmRkFPWBrtsmoEPwGB23n67CzTOIgjcUTl0ZEc4Zo05QtAKm8zAmHoAUCrPjlFO/JXE7RZEJnqXskFw3oTfvvJF8uKP2KJLzYn0Ni8phuUXQ/oFGSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eGF+4/nH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49K2frwC7274531, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729392113; bh=9M34b+aMQyEye1GomkTypgKLUbOG2iUKZA16bdpdNaQ=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=eGF+4/nHzm7VP6Xa0TPfpg+4tdCDXWBNqJUf0wTxcu+Xpqkml5HGutzTalgTX5QhZ
	 gYwTpgJhIwRZpcKN1PwPcTXi9x4p6ze92/EewILTSgP7IJIDuind3fbsA6ZaM3I6l+
	 oHizb5Q+XdNqwLaztCTJeK1xPVFIaoH0VmANYr51X+iWs4ZXukUwcB3MACypgYcJ0N
	 yoZ+PJiZZKOSPhpPtVlI/v/Agu8dAyd9gKn3+YUmKXaFxn5s3/S3BJYPhkIkbMLkMv
	 nUDjckIXOoK6O/xAWrm1rrgtVqkpjD48LqLEsWfJi1GSW10PPFoUgwd4CTu4uguh3H
	 tXXf1zqz7ZL9g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49K2frwC7274531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 20 Oct 2024 10:41:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 20 Oct 2024 10:41:53 +0800
Received: from [127.0.1.1] (172.16.22.200) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 20 Oct
 2024 10:41:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: sar: add supported UNII-4 frequency range along with UNII-3 of SAR subband
In-Reply-To: <20241009071619.16841-1-pkshih@realtek.com>
References: <20241009071619.16841-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <019486ce-c001-4a2e-9cfc-b63bd17a66a8@RTEXMBS04.realtek.com.tw>
Date: Sun, 20 Oct 2024 10:41:52 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The UNII-4 uses the same SAR value of UNII-3, so add UNII-4 frequency
> range and change the enum name to represent UNII-3 and UNII-4.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

062689f2cb6b wifi: rtw89: sar: add supported UNII-4 frequency range along with UNII-3 of SAR subband

---
https://github.com/pkshih/rtw.git


