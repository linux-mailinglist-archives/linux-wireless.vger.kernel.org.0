Return-Path: <linux-wireless+bounces-18264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB704A25136
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 03:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B22F16336A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 02:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18FF1CAAC;
	Mon,  3 Feb 2025 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cJ1ZxpEx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57F12E7F
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738548901; cv=none; b=BL/jKUYN/WRfL1plnCgBlqsTDcHhfupn+JucFDqrBCmD32UiSIVx9yycZu0uy4MNVooMvrIoy+Tp+6JDSmBjv8cYLZGpUsdH+EvrRXTJYkrYo8kE+EKnw1wHj2UlTb9qpbn3dcKfBe8OkVjfNs/X/nq0c331EhwKLM/oaPCTzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738548901; c=relaxed/simple;
	bh=q1UHobL53M1WRTbqBm+SR2EVwlP7Zc0kIn9O++bcKsE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=SGm2GFlGyTXmS2+caamJ1PYh/8wpaySF0lvS2eEf+KLjWqX8PDu82bhIB9hbj0sxT5wt5edGfSU0iDqmEQ+5cBbM+TZqHt73RpUPOXn/fJzqIgbLbq0HKvCtg0qD1rGkiTs+EnSJ/eG/4bDZsjlaKHkTbgq1vk8gnuQEI/crmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cJ1ZxpEx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5132EvawE932832, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738548897; bh=q1UHobL53M1WRTbqBm+SR2EVwlP7Zc0kIn9O++bcKsE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=cJ1ZxpExH6d7uBUskTrNBpwpLpwFzyNOqvIcGFm/GVNFxNTZ1RKjM0xHEU6otlr8B
	 HCa9bZ1UQ/NVnvTKRypyQYfVgLdTsDywpuwUk3y5eXES/gjTMmvE7jj1r+Zp1n0+Iy
	 5xkQ+Snt2FoQ0TwZHiOghdZ3VromeYAMr0/uFu6qqaOV4o0hojDo9zvvmmiCQaqZp+
	 9yeW97Im4itYYT5f2jQRN24SkqsCrrFBo7k9mfP1MuKjK17n9lnWcWqkuwuEiTvRVY
	 gaMO48gAlsG0/sZ57X5xmcpySZKvwbBxrYeyL3c7vGHaWBDsUewS+vZQkJZPZlA2dJ
	 bFCcwp4K3kQDw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5132EvawE932832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 10:14:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 10:14:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 10:14:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/3] wifi: rtw89: regd: support loading regd table from fw element
In-Reply-To: <20250120032723.19042-2-pkshih@realtek.com>
References: <20250120032723.19042-1-pkshih@realtek.com> <20250120032723.19042-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <fc9d2a66-57f4-4cfc-931d-10dc9bc41b56@RTEXMBS04.realtek.com.tw>
Date: Mon, 3 Feb 2025 10:14:56 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Regd table is a table that we use to describe how to map Realtek RF TX
> power settings on different countries. Originally, a common regd table
> for all chips is implemented in driver. However, in order to work on all
> chips, the common regd table might have some trade-off. So now, there are
> also an individual regd table for some chips. And, we support loading it
> from FW element.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

e7196b32a43d wifi: rtw89: regd: support loading regd table from fw element
79a36fc56bea wifi: rtw89: regd: handle supported regulatory functions by country
b45acf245596 wifi: rtw89: regd: refactor init/setup flow and prototype

---
https://github.com/pkshih/rtw.git


