Return-Path: <linux-wireless+bounces-18268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94162A25146
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 03:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6101883C29
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 02:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5713C156CA;
	Mon,  3 Feb 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="i9O2hqzm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23846AD23
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 02:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738550586; cv=none; b=Gz9vpyw7788OXjNremPGRRkQlfrBl0YhTEFwqR6LcajRg+NPp7XJxOddLvnKg6XiX35cWW96FbPC622ldAnqzG8C8Q61oBYuZtKmgMIr1hU2KKVYAIpG/SYjq9bOGiah8nalWv9W0nb3GaG5q3doUrr1n60DxgTRbKd2Y+sxf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738550586; c=relaxed/simple;
	bh=F2ytxOSXCAsomoV+kK2H2z3Ta+rQPH7zHROAEwjKTTc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=hf0Gx5H/dBxPlFXszVxO758HSlyNoU9lfcwTDvpUNzzb3eH03h81diaNuZAco5v5CDwBGfohrJ9tiVkSbnV0ivnQ1G0bb4NrvPOmLbcpq6S6Ghqz94TvxERWQfsfIqh1BvwV/6Yw++H4aWow8IMu9hPh7W3aHDcF4vpq93fUNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=i9O2hqzm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5132h0mrD977850, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738550580; bh=F2ytxOSXCAsomoV+kK2H2z3Ta+rQPH7zHROAEwjKTTc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=i9O2hqzm+aaJMuNzvYKydjMKcp9f2QpMBucH2mCXsNzOquRs1SEHIk/6Dm79Fs3fB
	 YcxyqvBHhtpAZlWjjFsyCxq/KyTlx8hLzoABPaJUQ4nFgayhT6V+GlPys19fMudJvk
	 axis8c6TYW8UyTYD9khRDenxZXX3a+NP0mu7HJ9z5zGJyKYf6rRpNdsk5ovz1ysJb5
	 MAEqPEcoKDugg+cWbde5/00uGIPcBrMa/47uKW5it1yzdkmPeY0y0KWfXrU8AaZf5q
	 NnWkTzvXDt8/m5425y/2fLc7YrsxnoeUg6wLsKkwL67yMaJoFs7n04b8WTGdI1Rnv9
	 QS5KRM/cvNXVw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5132h0mrD977850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 10:43:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 10:43:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 10:43:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtw88: Don't use static local variable in rtw8822b_set_tx_power_index_by_rate
In-Reply-To: <8a60f581-0ab5-4d98-a97d-dd83b605008f@gmail.com>
References: <8a60f581-0ab5-4d98-a97d-dd83b605008f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <e241ca0b-d869-4919-866d-40f1b01b00bf@RTEXMBS04.realtek.com.tw>
Date: Mon, 3 Feb 2025 10:43:00 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Some users want to plug two identical USB devices at the same time.
> This static variable could theoretically cause them to use incorrect
> TX power values.
> 
> Move the variable to the caller and pass a pointer to it to
> rtw8822b_set_tx_power_index_by_rate().
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

00451eb3bec7 wifi: rtw88: Don't use static local variable in rtw8822b_set_tx_power_index_by_rate
0d1d165eff9d wifi: rtw88: Don't use static local variable in rtw8821c_set_tx_power_index_by_rate

---
https://github.com/pkshih/rtw.git


