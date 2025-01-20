Return-Path: <linux-wireless+bounces-17720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43705A164E0
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 02:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287E33A6035
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 01:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D6A4C70;
	Mon, 20 Jan 2025 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GSnpAcb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9B199B8
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737336398; cv=none; b=Dv/H5shEfw4+n3ibeLUc3DCW+PjJ9hpaAC58LHlRCPUE+M4SCRKWymA59++5Ij4cP4gnKtiLeEFWb3vZIuP+d5CaKOZ11SL61+IJjSmZggwRCV3sy1Evmo8L6LP2sIahZsjnDwf0smxExDV7SRkJdhgEcYFcgccFmZOE4O+EqIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737336398; c=relaxed/simple;
	bh=p0T3M6b3PLBJkIXeDX/rbX3OcISc08PYSOyOdMtYNLw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=UTorCuEsm0DszZ6Wq4b3gEkAKuPuqaj8TwsVqGSlZeUUm6Tv8yOjyA16SjrMVjy8x9HPngkys6CGtRbPDFdOIhpqIDBfOTdIyirqsSQj5G/TwgTC/p9uN2XnoN70Yf8/kH0VnzU1UaGu7qj8gFWaYXHLbdQ1Hnrl5HS7mgmewJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GSnpAcb1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50K1QPMo82482806, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737336385; bh=p0T3M6b3PLBJkIXeDX/rbX3OcISc08PYSOyOdMtYNLw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=GSnpAcb1YEmfS8QYpe5Z9Z1Petc9oSZQH+0lB5aa01WEfAXYSA6fbS+YJDdSr/669
	 ls/Krq/bmS4efPgtTDoFhUnP7OS35PeWTZnMreaCD69i1BqP19F6+XajC8oDNeIOv2
	 UavLU/SDX/IidokyNLquZO5Ju0lB9P0x0Vq4xCG1nLHdgN482KZn/dKn2h06iNZbf5
	 ui3kLmyUOFCGoyc9QQ0emrgSABltaTfUEjUUvVzJw04WjY74BC2ToWs4NUxOykVvOE
	 haO4FhfsKASpiSR/bk1/lH7Ino0B+ftPOKaq1Yz3NSiOAFPnCf+EU8Gm9QhK9tf+kW
	 JtFvkD20IpS2A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50K1QPMo82482806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 09:26:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 Jan 2025 09:26:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 20 Jan
 2025 09:26:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH 1/3] wifi: rtw89: coex: Add protect to avoid A2DP lag while Wi-Fi connecting
In-Reply-To: <20250110015416.10704-2-pkshih@realtek.com>
References: <20250110015416.10704-1-pkshih@realtek.com> <20250110015416.10704-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <54145d9e-c7a4-49b4-93f0-1b4bce30d0e7@RTEXMBS04.realtek.com.tw>
Date: Mon, 20 Jan 2025 09:26:25 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> To get a well Wi-Fi RF quality, Wi-Fi need to do RF calibrations. While
> Wi-Fi is doing RF calibrations, driver will pause the Bluetooth traffic
> to make sure the RF calibration will not be interfered by Bluetooth.
> However, if the RF calibrations take too much time, Bluetooth audio
> will perform a lag sound. Add a function to make Bluetooth can do
> traffic between the individual calibrations to avoid Bluetooth sound
> lag. And patch related A2DP coexistence mechanism actions.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

5251fd321684 wifi: rtw89: coex: Add protect to avoid A2DP lag while Wi-Fi connecting
4a5734665215 wifi: rtw89: coex: Separated Wi-Fi connecting event from Wi-Fi scan event
dbb6a738f6cb wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.2

---
https://github.com/pkshih/rtw.git


