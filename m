Return-Path: <linux-wireless+bounces-12302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9C7967D0D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 02:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3311C20C4E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 00:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4D2257D;
	Mon,  2 Sep 2024 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="r/QmIkmT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCAB23D2
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725237887; cv=none; b=avtylGC3U8y/hOZ5gi6aJidI3bY3BfnU/A2J4JI/1hpplzlZmY4uberS0CIZg7XmtGEq0CiPMApuScuXYD1oYNO4bxqf+h3NS/ES6gITSVoqsCujSQ1W4CcqlvfmKLcMAhEEQCWKNVDWnypBYCbf7825yegLw+38YeaVcY4cKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725237887; c=relaxed/simple;
	bh=wmnO2eZbbFnx+KZk7eYoGuh1/8D/shL8nA/jB/z2km0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=N2PVjBeFCuxMXQh3bqWXr5SaOOJx0qPDEtSseOzJu/D1R/VR6+TZZ+XPGTrT9bIro38QhKeCFN6bujWARJvnei8UBkEC00Pq9j3+OlKJafGS8JFk19d/ANv85csUGTNSgObBhbxM9aRjZFoeqi01lx+rp9S/mynSCTjtg/6GXCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=r/QmIkmT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4820iJM613440645, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725237859; bh=wmnO2eZbbFnx+KZk7eYoGuh1/8D/shL8nA/jB/z2km0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=r/QmIkmTl9kB4BeItGmxArz59lqQC3xgze1MjEp7sxiN/QKQ4F30Gv7BSWk7WRzYu
	 dWXDLJF48IsG7gz98Dr93lHXuAH3Ud5U70BFfPl1yCLVoSBWGKCAongyHfs+mv9phz
	 CoEotg/pVuAJVhPv7m3Uwe2aCaIutLA/uROdzyoOZss1DPwT3IY0eKrrDkM+o2iQqH
	 nS9romNaRNV+XxzbQ3f/ONsvUMz0M//ag2KkLPqnJ6KXzHiUheSYz+BTi+z+Qgee68
	 +LIz8LseLfBJ7QxklWNxLsXnroWdJaJYARj1lBrbsXJYYilFwz8wQBiCdGhZwXEkIg
	 FEqFYSLvlhWZA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4820iJM613440645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Sep 2024 08:44:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 08:44:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 2 Sep
 2024 08:44:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2] wifi: rtw88: Fix USB/SDIO devices not transmitting beacons
In-Reply-To: <49de73b5-698f-4865-ab63-100e28dfc4a1@gmail.com>
References: <49de73b5-698f-4865-ab63-100e28dfc4a1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <8d4ead5f-8ec7-4431-96f3-b1335916b90d@RTEXMBS04.realtek.com.tw>
Date: Mon, 2 Sep 2024 08:44:19 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> All USB devices supported by rtw88 have the same problem: they don't
> transmit beacons in AP mode. (Some?) SDIO devices are also affected.
> The cause appears to be clearing BIT_EN_BCNQ_DL of REG_FWHW_TXQ_CTRL
> before uploading the beacon reserved page, so don't clear the bit for
> USB and SDIO devices.
> 
> Tested with RTL8811CU and RTL8723DU.
> 
> Cc: <stable@vger.kernel.org> # 6.6.x
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

faa2e484b393 wifi: rtw88: Fix USB/SDIO devices not transmitting beacons

---
https://github.com/pkshih/rtw.git


