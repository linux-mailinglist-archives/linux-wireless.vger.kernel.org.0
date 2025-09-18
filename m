Return-Path: <linux-wireless+bounces-27448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A158BB827E9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 03:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544D51B280CE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 01:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F109D222565;
	Thu, 18 Sep 2025 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WCFQqz5D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31E21FF23
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758158983; cv=none; b=eAbzQ8Vek1T47CvO7iObnNpnNR3GZjX9GFlCvsHHpfKLvl+g8TtAbCFi+3PFpZkhdPFtAxCvyfnfVRqvHs3Pu8Pc5XRBbGRbNMYyMPtLprxiUumXiOsw3LqJOIAqNZY30ZyZWfnO+SjgReLdFWntHe316hKlDZ2I/+LIqgI7o14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758158983; c=relaxed/simple;
	bh=Kb0dSH6iqHyJ+KpHdlDX99UYbTTAKfNQNReJ3sh/c+g=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Jd3xX704Bhf0LbA5lctIFolJ4c8oJLF/mqY9qWYV0xM9wFCzK5DQ25Rh7bMZyl8RcUPqwPnaNfwHhRS7tjO9cBT1SVXoWfxAPxJPxEucqyCij6+b1pNADwdUqqzrvGRaK2WuJSSO/8yHo9oDsKdu8pAbOE6CeIFUyJ4u8ZNCgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WCFQqz5D; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58I1TaW321170373, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758158976; bh=EwYwhYa80wRLzhA991mgFKrQTzq7HwaJmBSfhUkU/1k=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=WCFQqz5DICp7bQWkVUziNMOVQz5k6+3IyqjUZpK+woibAbu4gBI2W10K9AKQIu7wI
	 PwUtcoxPeuX15frSb3ootlfvfdUBCgIGhzv+32ISb2Lyuc4Xe2TLUqnXOOj4xVWBRc
	 FrBSdUb1qULyS1TKmr47WBBVG5B7BaYQmBUz2KoChiV5jyqSwPONBnwx0sSWHscAhO
	 GkirD9jGH2iuAY0C4ust3ac6hoInr3S5AIi9vnd3jY7f2FeObBO//zLlVlHldJQdyV
	 MDX6OxG7dpQTkdlYAVL204ri8HjRQO0SzQLU6F6zzzkxSYveN7GFLs/nAN8qPOZmII
	 DY+9mKUHd1vMg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58I1TaW321170373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 09:29:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 18 Sep 2025 09:29:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Thu, 18 Sep
 2025 09:29:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 01/11] wifi: rtw89: chan: allow callers to check if a link has no managed chanctx
In-Reply-To: <20250915065213.38659-2-pkshih@realtek.com>
References: <20250915065213.38659-1-pkshih@realtek.com> <20250915065213.38659-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <872faeb1-777f-4759-9baf-b22f7bbadfac@RTKEXHMBS06.realtek.com.tw>
Date: Thu, 18 Sep 2025 09:29:37 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Originally, to directly align with the chanctx design, getter of managed
> chanctx returned a default channel when a link doesn't own a chanctx yet.
> Then, callers could simply use the return without trivial NULL checking.
> 
> But in MLD HW settings of next chip, there will be a special case that a
> caller needs to check if a link has owned chanctx or not to determine
> CCK hardware circuit working on HW-x. So, add a func *_or_null for this
> first.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

11 patch(es) applied to rtw-next branch of rtw.git, thanks.

df3d55a63f9a wifi: rtw89: chan: allow callers to check if a link has no managed chanctx
19989c80734c wifi: rtw89: use ieee80211_tx_info::driver_data to store driver TX info
4e79a5cc01c5 wifi: rtw89: disable RTW89_PHYSTS_IE09_FTR_0 for ppdu status
e156d2ab36d7 wifi: rtw89: obtain RX path from ppdu status IE00
298f39f0d9c3 wifi: rtw89: phy: initialize AFE by firmware element table
e6badd999a87 wifi: rtw89: debug: support SER L0 simulation
5ff9e80de2a8 wifi: rtw89: 8852b: enable beacon tracking support
bc2a5a12fa62 wifi: rtw89: renew a completion for each H2C command waiting C2H event
a27136f1050a wifi: rtw89: open C2H event waiting window first before sending H2C command
8e72c3a6255a wifi: rtw89: 8922a: add TAS feature support
533e60e1ca99 wifi: rtw89: wow: enable TKIP related feature

---
https://github.com/pkshih/rtw.git


