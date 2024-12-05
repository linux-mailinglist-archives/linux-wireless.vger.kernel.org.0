Return-Path: <linux-wireless+bounces-15917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3489E4DA4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 07:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BCA168F45
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 06:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AF6156F5D;
	Thu,  5 Dec 2024 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TpyGZlJD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DE391
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733380496; cv=none; b=ZVpvof9AOkOvgqfxqqf9i6PJQ/c4qfNQE3TWPxlLIdD0knFKKSshtgG/TrS4STy4HBjoUZg1xSXKA+d/4aOy5bGn4DaJb8AGjErGp57bf9jzudi4XTt/vJZQVrwenMgLbPYU6GkmNKMJDAQLv2OuKEXC1DIY/rTy5LtuqVB22r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733380496; c=relaxed/simple;
	bh=+7khvcnl19JjbT2wiczZzqbTODvcnQDKBgtaZ/KApAk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=i9rq4FCYpiEcJCyb1+9ZZqPyRliIPlo7tYdo6osPHsHJxGqw/ytRhNh4U63VqqsjuKxZNEwMEt5iOIE0DS8hoy2UJB6E62upuhAKHAb0KDHUtew4TEPhw0Wxf9av3bzQT3/UZzX2oaaTL+YkBcD6WdsABTO8yyus9ck18tVueng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TpyGZlJD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B56YnYU22511388, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733380489; bh=+7khvcnl19JjbT2wiczZzqbTODvcnQDKBgtaZ/KApAk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=TpyGZlJD8dIGyjG1e++icGb15BeDf30ldK2ie6ZLTiHsNDg3o5C0RjYBp/mv6tfG7
	 pZNB8JDtcN2qCfxyHcM6HCGU/Q3sBFJis6iqCvAWk7smirfwKjGkr2smCmgx9UQ8rx
	 FwwW4K9mqsmd8AY5haiL/9jBDIVS56yq7sZJUgHywSNSEg/rWN4T8Fgvqb+7Qn2LFc
	 xWspU6VQm9Of583vfG2oGGpbuVj79b72wX73loa5Y/HX3MtbRHPsXjsP6yFBLnCLzL
	 hNs84WvD55kR2XYHxpwenOCNIx6HABNTeTattF4KiGUXm5eHrpMLfpMcI8I5XvqrSx
	 QyQcYcjwO8I2A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B56YnYU22511388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 5 Dec 2024 14:34:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 14:34:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 5 Dec
 2024 14:34:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/6] wifi: rtw89: 8922a: Extend channel info field length for scan
In-Reply-To: <20241128055433.11851-2-pkshih@realtek.com>
References: <20241128055433.11851-1-pkshih@realtek.com> <20241128055433.11851-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <abc404fc-d350-46d5-bb95-a8c0acbb92e7@RTEXMBS04.realtek.com.tw>
Date: Thu, 5 Dec 2024 14:34:49 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Extend the bitfield for duration in channel info to 16 bits.
> Update the related format in H2C and C2H, then increase firmware
> format sequence to 3.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patch(es) applied to rtw-next branch of rtw.git, thanks.

05b6555feedd wifi: rtw89: 8922a: Extend channel info field length for scan
d56c261e5214 wifi: rtw89: 8852b: add beacon filter and CQM support
3374c63111b0 wifi: rtw89: 8852bt: add beacon filter and CQM support
b6853ed2be27 wifi: rtw89: 8922a: use RSSI from PHY report in RX descriptor
148cd1e184cf wifi: rtw89: refine link handling for link_sta_rc_update
7b98caea3967 wifi: rtw89: add crystal_cap check to avoid setting as overflow value

---
https://github.com/pkshih/rtw.git


