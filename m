Return-Path: <linux-wireless+bounces-9040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D190A27C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 04:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3591C1F2207F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 02:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19295433A0;
	Mon, 17 Jun 2024 02:35:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBAD42AB3
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591730; cv=none; b=upXTaUXIU8aPYCNE2+YCefDo6JKl4pbo0qL6ZRMpfv6l89dv1ac+07YGhUKnHNAuYzLhgysYsGWbUvIjIv0EeTfC5o2VT8ZLE4FuGdKONl2bzDUeYQ9TE1AacC+w+b/+OAS6TSrV+gaGgx8tUXRMINgZKrn4C6b2IvKbDs2DI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591730; c=relaxed/simple;
	bh=e3m6FhyR4h+KHYl1sFWNVMP1wLs92YgF/JcM16JQZhU=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=PQSsoOy2bjvyOnmga+2nSbqDGwTyOxhJ1QkMJMF+uSA+t7g9wF+bJZIdWDDjVCZFJeiFqYlpM9HFpmnAhJvVBbzqvG2H+MWdrZVKJ/N/jV2U6hZqwwbu0VP9aTXNnYW4/lYKN5xKm1BEe/FUezvVF+/qschj2ASoWON/b0Y6MM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H2ZPbA42599140, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H2ZPbA42599140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 10:35:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 10:35:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Jun
 2024 10:35:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: adopt firmware whose version is equal or less but closest
In-Reply-To: <20240607140251.8295-1-pkshih@realtek.com>
References: <20240607140251.8295-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <8cf916f9-aa40-4c3e-91bc-7927324ab64f@RTEXMBS04.realtek.com.tw>
Date: Mon, 17 Jun 2024 10:35:24 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Version C of 8922AE hardware will use the same firmware of version B, so
> extend rule of firmware recognition to allow less but closest firmware
> version. Originally only accept firmware with matched version.
> 
> Tested on version A/B/C of 8922AE.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

8a00f7dfed62 wifi: rtw89: adopt firmware whose version is equal or less but closest

---
https://github.com/pkshih/rtw.git


