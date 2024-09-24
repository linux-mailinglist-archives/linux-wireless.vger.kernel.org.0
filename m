Return-Path: <linux-wireless+bounces-13094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC51983AC5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 03:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424C51F2282E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BACC38C;
	Tue, 24 Sep 2024 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QcOiYXtI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5FC8CE
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727141349; cv=none; b=p00b3xVdVzCvhSiPLai3Dq/i2ntMWiOS7Eicn4URZe1yB5Fc4dDuuQukBOtBJDSf6mDKQwvr/GmnEcqK8VSdA9VXOr1lPF/Qy6HaawX3wEbZD+5Glp4uLM7nLOe2Q/gsU0jDyoHjJ7//EFG7pBstfg8yYICySxuBNQemipQrbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727141349; c=relaxed/simple;
	bh=Mk0GZqhrmZCq9dqMZwPLzrbg6bODCQdw/qzrcSUANlw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Zhowt5uz3XNkFzNZxTXIMJBWt2xt9PlKsrpaUZoXAF8KkuK1KH6+nfshKfiokjOXUN8BXHO5f2ONqIln5va7szAAYp5oF3qB7xjVY0xgrbDGxICN3IyBbviI8OkzI0dokikde5t1luT6PJexwX8c+Si8YGprtKY4xeBWaTuPEVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QcOiYXtI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48O1T30N02175668, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727141343; bh=Mk0GZqhrmZCq9dqMZwPLzrbg6bODCQdw/qzrcSUANlw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=QcOiYXtIbnfiOgmikmQROV8kYcRyu6mxPramYoMCdjpx0+OD0EPy7pMjLLhtrUqDS
	 zOfERv/YZYVRKAxf8i9yUUPOiDeIAZyTB3wcyjKJDOSpaDNQ3mby+EenJUz/axfxBU
	 bKLymu5grZERSOqXAjQfpGjR4rOYTXNNhOe1Dbd1cJhHaxvvnqCdXXnGs0NiGjNOX3
	 paGvLGJnqzTcsj4QLYkp6KTkGey3xhbKQuDuK8P0wxGmsAelB4V0++SWhR/DSCkOH3
	 ggC6GUrF4lnKCaUtBtCMjBX0E3lR8o94bF8w11vvhoUcCdmjHIvc65E6TIEmHQEGlX
	 1jpixwUYhnU+g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48O1T30N02175668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 09:29:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 09:29:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 24 Sep
 2024 09:29:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/7] wifi: rtw89: rename rtw89_vif to rtw89_vif_link ahead for MLO
In-Reply-To: <20240916053158.47350-2-pkshih@realtek.com>
References: <20240916053158.47350-1-pkshih@realtek.com> <20240916053158.47350-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <89518cb0-9811-437e-b7d1-ab481ceb7756@RTEXMBS04.realtek.com.tw>
Date: Tue, 24 Sep 2024 09:29:02 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> This is an intermediate version that is separated from subsequent major
> MLO changes, so some functions' namings are not really determined here.
> e.g. struct rtw89_vif_link *vif_to_rtwvif_safe(struct ieee80211_vif *vif)
> 
> No logic is changed.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patch(es) applied to rtw-next branch of rtw.git, thanks.

2f7dae17c48c wifi: rtw89: rename rtw89_vif to rtw89_vif_link ahead for MLO
9ee282193440 wifi: rtw89: rename rtw89_sta to rtw89_sta_link ahead for MLO
89bac818bbd2 wifi: rtw89: read bss_conf corresponding to the link
04911c0fe874 wifi: rtw89: read link_sta corresponding to the link
26d460e13f84 wifi: rtw89: refactor VIF related func ahead for MLO
72e9457c1954 wifi: rtw89: refactor STA related func ahead for MLO
aad0394e7a02 wifi: rtw89: tweak driver architecture for impending MLO support

---
https://github.com/pkshih/rtw.git


