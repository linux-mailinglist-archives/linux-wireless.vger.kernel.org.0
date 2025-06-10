Return-Path: <linux-wireless+bounces-23913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9043AAD2BE6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 04:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EA416F898
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 02:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E8D25A337;
	Tue, 10 Jun 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RQMWJdEL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD052EB11
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749521903; cv=none; b=uqJA0O7yww5sV77H3cs79K/9l+wb7r3XVzt44j96EFpxmr8uPlMezj13VKwVD6DRkkcWlJDUMAyzoV54OFMroq6QhSTCVsQmEQWL9MzfZQqB3nx6unp7kAHrdytw7jmj/swPi+GsOLFR6RLGHPjTbdTGgKBBcQLUq7p9RbwiKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749521903; c=relaxed/simple;
	bh=7kFMd634iVAofkVcobQWUtdERIyijRRTDh8fIPvJkdU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=PCNfSQcK2y0RqfxPZj8kmFXIDZE9GFk4N/vRRbEa5YmzJYGDfQ1yeWsCwkuilMXdqE7IlwnUEhfXf4SfcA2inTBMgrGA3mn71fXD1/TtLupkDSIMRhgbr2mr7E5Kqk0b1XI1d3UoIMpu4o4OHn+WBAf8TA8hrRhvx2caWxA4WJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RQMWJdEL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A2IIq142115093, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749521898; bh=rdPGNZ8LTZsp1pe/t3HQEnpAdCBqvWg0yjXV/Ft7F2M=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=RQMWJdELYY3wuQzSmN8F4bbgGl1Bgph5poVrVwTDmqtmjkg6MYM/BAMPPV58D2aL2
	 9KeU7QLoiKrAPzI0JPWVG/uAjJyfmx5CSTCwcFpuTG2bWARGWxR00WIXnQWh4wsR/2
	 JnE3juFbfH4hKtqrc9Etk/TXw6njGSL5Krgx8xRMw6iFRSahPuyP1Q8BRJdxFaALYi
	 f/5N3XGPxVoMqjtgYJU1Nco4O8/illNX8txO1lyJcDM3ntbOzUCMrmMD23WA+bHPRq
	 oHLzqe1hv7YlTMpielimIKOjAVv2bxp2t9W1ySgV3PE2vLisW0cJ3t9ZnlLtlTbusW
	 8IDpDMiMHAQbw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A2IIq142115093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 10:18:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 10:18:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 10:18:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 1/6] wifi: rtw89: 8852c: increase beacon loss to 6 seconds
In-Reply-To: <20250606020302.16873-2-pkshih@realtek.com>
References: <20250606020302.16873-1-pkshih@realtek.com> <20250606020302.16873-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1ed5490b-2036-4a8f-845f-676afcae7258@RTEXMBS04.realtek.com.tw>
Date: Tue, 10 Jun 2025 10:18:16 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> Intermittent beacon loss from a specific AP causes the connection
> to be lost. Increasing the beacon loss count can make the
> connection more stable.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patch(es) applied to rtw-next branch of rtw.git, thanks.

4bcef86b1331 wifi: rtw89: 8852c: increase beacon loss to 6 seconds
29dc4c560219 wifi: rtw89: fw: add RFE type to RF TSSI H2C command
b9b8828fdf8c wifi: rtw89: rfk: support IQK firmware command v1
b0efb82651af wifi: rtw89: mac: add dummy handler of MAC C2H event class 27
d310eaf4ad51 wifi: rtw89: add chip_ops::chan_to_rf18_val to get code of RF register value
389e578dd280 wifi: rtw89: 8922a: pass channel information when enter LPS

---
https://github.com/pkshih/rtw.git


