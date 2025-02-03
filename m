Return-Path: <linux-wireless+bounces-18265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E367DA2513B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 03:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83557A1D3B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 02:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ACCA923;
	Mon,  3 Feb 2025 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="lDOJo0rq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173C33CA
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738549339; cv=none; b=FvrTZfz8lqb7vaWTufNM+nPJXGnUnaqZkJxBI4OFBJd6NRfRxNFZHQE2ybZSIiwLmRjE8B+74V+lts43INSMObcDHBm2WQ1+uuIouV1ACA3fe/LUQsW0tFj8r6qVYzOPX+0qC+mTbSEYD4KuW8r4OBV0kGIj2yoUtK3HB5lpJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738549339; c=relaxed/simple;
	bh=BxNFKuWoEDHVKWCZ82ttTnLG+fXJaXzFvFlb81oENrU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Dde+5ceadIw1VR1n+KaQIZzR8DHI4YjvxWRaPVq+qROmIa8w43sPGlrvZYN/81kf2SPdwS8S+LCNZlt8purmi/PyjV3OztTKeQRGMthl+GPRrlDokXHWH9VN1ojgz3C5zSZ87+bqpY4vlx9nWp87yDwAPgA4OT+CSXBrPyiJRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=lDOJo0rq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5132MF7X0939533, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738549335; bh=BxNFKuWoEDHVKWCZ82ttTnLG+fXJaXzFvFlb81oENrU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=lDOJo0rqN0x7FM8q0we/hHiNnOAapgywJkC2ArZbrtZOZRb9BM6SAcSrTOGHoUfqi
	 jGYE0FFTzdfqy3Lz7k686NbLMDIleGw4ae86r+2mLu3oJqaehg+Fba6MNYzQ5wJHnV
	 Pi4RrxAV+XOYO7YUyB65HL/rmQu0xCz/auuTzHkJ4o5257xfzggzOtiFXlQ/wrqe4w
	 wCko0U2xlsVwQeMWX/z2sqkByBb5O5k6WVWPjt8yGrGaNYHX0Gugzka9/3uQkp6tz4
	 sfSKoTwoX6DZeBuOs+zDN/STZ6H5/O3oUroqm5BrKrRzut6/Up/yJTomhYXKQ8k895
	 0kZ5t14ePjiYQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5132MF7X0939533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 10:22:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 10:22:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 10:22:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: cleanup unused rtwdev::roc_work
In-Reply-To: <20250120034004.21135-1-pkshih@realtek.com>
References: <20250120034004.21135-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c399a21d-c93b-47ca-8777-20c573588cae@RTEXMBS04.realtek.com.tw>
Date: Mon, 3 Feb 2025 10:22:14 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> The needed one was moved to rtwvif::roc_work. And, rtwdev::roc_work is
> unused. So, remove it.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

c281bdb88214 wifi: rtw89: cleanup unused rtwdev::roc_work

---
https://github.com/pkshih/rtw.git


