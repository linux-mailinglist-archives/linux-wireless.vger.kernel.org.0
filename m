Return-Path: <linux-wireless+bounces-24805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976EDAF859C
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 04:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0EF486145
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 02:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57084282F5;
	Fri,  4 Jul 2025 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ufQMioh8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422B2594
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 02:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751596635; cv=none; b=jYrOrcgB/wberj2SJCUAxjseOm1tAn4T78YMYGp3MH767AfEvC/dWJ5aRd6lxf2ZDRgFhPlbhubcih+PTeivU08JEntuJQH4U7pblExgx+M/2RvQvJhmpbGBPCtA/oMYWANj8irJg0QBBBdaC8CaenmynFYBv+jzV/wu2LGSN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751596635; c=relaxed/simple;
	bh=J8ZtWSA9DgFezs58W/ngCvvl8QHpJPnATBTbrqsb7eQ=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=GbygeWE4Eiye9dYjywkNV+12Og6jBx67USKmPPCOuwMIt9GM99sP1M93C03NRT1tLLOKtOdiTG5CkQYudySEoEJs+p7O3sZ//3d5xJwLyDQXtZgO1rwZvpUXIy6MlZXCWGyRuBNj4qW/SCreTfX4UWQI/rmpzA/lphcFUb83fzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ufQMioh8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5642b9t053588278, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751596629; bh=2ZoJYAiCDejpVz9L19241yiK0eetFvCxpRmVBX89B6s=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=ufQMioh8h+N67UXXL3F+czq99slexJNs78ZKuPNX4ODvm3RkSIDuaYwBqqH45tWnO
	 a5jcGoMDlem0K/habANgg97zMLQkw+DLk7j59s9uzjo7Zwn+L6SLMrAxPYikta3DvH
	 KkLS4O54HmPE0frV2gzlx1qWgBM2m6kGWIg99IfTOLjEX+tCwbEvI6vv11U6x2pnVK
	 1pkIAetKmeFbbIoTSpQKNpXpAUf9x9j7rLp1ETQRZ0Hxw44nVUHjRSCfAHs/EfnrTn
	 Q4IcocCWLurZGpkCIRrTBFqa1ar/0GsLKQ1sb42Wbm0BdMdbO4HwUU1pnA/Pr1Y5HE
	 EJ4NhwHRzvR0A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5642b9t053588278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 4 Jul 2025 10:37:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Jul 2025 10:37:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 4 Jul
 2025 10:37:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH rtw-next 1/6] wifi: rtw89: 8851b: rfk: extend DPK path_ok type to u8
In-Reply-To: <20250627035201.16416-2-pkshih@realtek.com>
References: <20250627035201.16416-1-pkshih@realtek.com> <20250627035201.16416-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <762c74a9-fc9e-4a45-a698-a5d5e8c52178@RTEXMBS04.realtek.com.tw>
Date: Fri, 4 Jul 2025 10:37:33 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Originally the type of path_ok is bool to denote that DPK is ready on
> certain path and can be enabled. For RTL8851B, hardware design can support
> more than one calibration set, so use type u8 instead to record the
> hardware set in current use.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patch(es) applied to rtw-next branch of rtw.git, thanks.

626afc6cd536 wifi: rtw89: 8851b: rfk: extend DPK path_ok type to u8
64d0633f1c47 wifi: rtw89: 8851b: set ADC bandwidth select according to calibration value
408d55331f96 wifi: rtw89: 8851b: adjust ADC setting for RF calibration
de2a9b283760 wifi: rtw89: 8851b: update NCTL 0xB
56624544c8a6 wifi: rtw89: 8851b: rfk: update DPK to 0x11
58f1510a8b6d wifi: rtw89: 8851b: rfk: update IQK to 0x14

---
https://github.com/pkshih/rtw.git


