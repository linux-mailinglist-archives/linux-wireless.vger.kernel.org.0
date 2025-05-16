Return-Path: <linux-wireless+bounces-23041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1D8AB9331
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 02:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337DF1B6478F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 00:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916754B1E50;
	Fri, 16 May 2025 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="F8ue4qad"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CF4B1E73
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747355425; cv=none; b=MFeeVL/VINZiN/IQofVNM3KeCaCeGtf/qupcBCwvZbRmkRVTBswxGxmqh/c7Dgk7kFUXvyoBmZ8VokRPkjQ1li6BXAplQTLHkGfILEO5dqAMigAdmAFpPNWBPtvtOoRFJsKhvUh37PieV6obLI6NeQtxaP2uFL2ycXBEFXrnQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747355425; c=relaxed/simple;
	bh=itFOYY2HY1vbIObp7bYr37I6Y45UN3UroxdN1RQwcoY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=unv9EbdhF16FOExIWsTCzSoO8n64b06n23fCSmc0Xvl+7jlOXyBKyaWTLL9S1nVnrhpjhmAfKViojBSqN71LA0JRG3XL5zUIFgowWSQnO7R8xjS94WepjS/7Z7lDW6BN8aKaE6ODBDOVJbVcG/Qre7UmJUTmDyS2EbSI/BhMwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=F8ue4qad; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54G0UKuN4034447, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747355420; bh=itFOYY2HY1vbIObp7bYr37I6Y45UN3UroxdN1RQwcoY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=F8ue4qadHF0zHDf+tfEqhvZ7MxX663VpXXCZwsm5q02/YAWcBnGdxeVNQJBj4M2ow
	 jDprABdvddWHTSm5R/aJzEvdcY9tf///amJCxrPid5WCsZud5PzF4dfqWwc/oNNnsv
	 xprEg+20fvUk6CIYVQk1Rw+fX0zVZzKwFlgKlLDh+OsJt3LIAOPW4upmMSX3CmIMGQ
	 ybKH5E14z0sA1L/iU4Nc4Mr4291lVxeCXRqkthTILLzErXpsw2kUJZ/BKqBPM9eqGR
	 C8SFJ8fbUHFCoHE/v5wAaECPjOO4UHFDvuwkNRA98R0b/V0zn3eIQVvGfqjwd4RUqb
	 6y00iCsjMMNzw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54G0UKuN4034447
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 08:30:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 May 2025 08:30:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 May
 2025 08:30:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <dian_syuan0116@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: leave idle mode when setting WEP encryption for AP mode
In-Reply-To: <20250507031203.8256-1-pkshih@realtek.com>
References: <20250507031203.8256-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <02083cf6-9dc5-4ae1-a09b-a8386257a1c1@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 May 2025 08:30:18 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Dian-Syuan Yang <dian_syuan0116@realtek.com>
> 
> Due to mac80211 triggering the hardware to enter idle mode, it fails
> to install WEP key causing connected station can't ping successfully.
> Currently, it forces the hardware to leave idle mode before driver
> adding WEP keys.
> 
> Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d105652b3324 wifi: rtw89: leave idle mode when setting WEP encryption for AP mode

---
https://github.com/pkshih/rtw.git


