Return-Path: <linux-wireless+bounces-20987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1F0A75EB8
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 08:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D7F1888BE3
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 06:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EF124B26;
	Mon, 31 Mar 2025 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BAdSnx0v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1F20E6
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401154; cv=none; b=O8pM2LTILBhzDBczfodQSCGDBmcPM72xTNMNy51Ciq19XfOEXtMHuEBA4FeAK0+96F7dNw7CBBuFRIyOifRhh/bk54ZOzLP2s/DkiHuV7DSxp7dHSSBxtMqoTzIQIUAfmF/k1RNxSr40/qMRSl0i3+HBbXlxBRyHbOGTbRkvOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401154; c=relaxed/simple;
	bh=QJcDUpcshZNozkH+fjeKChzE95Xi9U2mmvTrC223tCE=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=NEIXBL8PhUbJRfgFgObeP12IeRvKaMBSnEJa8bQ4a8ioM56beRHNjInpNZRnIGIahQv4NiwLiuJSxcj0INYWPKGrq+SpcBO34jDns7wbtgtKtqjtx0nJQpFl/tkVke41p25ztGxioa9N9T14+j5Y6tI0a4Aq26FHtYVgdtt4WqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BAdSnx0v; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52V65oUD22870904, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743401150; bh=QJcDUpcshZNozkH+fjeKChzE95Xi9U2mmvTrC223tCE=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=BAdSnx0v8v7hQb6mOnic8RKJaIukA9dbYLhVidLBUn0SBJAGolzX97khGritq/ZE6
	 NnvZ1dNjY5QA34jrw8tT4/77ovqyIrnaB2XvgLpuzLzsJNryx3rCn8aDjuQHDxJU3L
	 Z5d3nOjIPWu2JM+GV7ZsCiotI7t9cHPliOJOA+rA9GEHUf2HNRkD3riri52trvXynG
	 W/Itp0Vm4/1TqR3wAj6Ui4pkIQIvWk2CZJOipN3zkY8D63jlqDqNjYl/TLEe2rocWE
	 bPKY+mfj1L9/exqu49MRgabN1pCjk18R/ukWpzcxq+0BFfrRCvGaAGJRvHU7ABBWj5
	 WZq3+ugF2OK5Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52V65oUD22870904
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 14:05:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 14:05:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 31 Mar
 2025 14:05:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH rtw-next] wifi: rtw89: set 2TX for 1SS rate by default
In-Reply-To: <20250321034736.6269-1-pkshih@realtek.com>
References: <20250321034736.6269-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <73e9f894-6841-444e-9236-0125e28a8160@RTEXMBS04.realtek.com.tw>
Date: Mon, 31 Mar 2025 14:05:50 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> To improve performance in range, for 1SS rate, transmit the same signal
> on 2 antenna, which is called 2TX.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

81433a8a4f40 wifi: rtw89: set 2TX for 1SS rate by default

---
https://github.com/pkshih/rtw.git


