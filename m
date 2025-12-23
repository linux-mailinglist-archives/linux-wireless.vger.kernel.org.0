Return-Path: <linux-wireless+bounces-30075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FDACD7FE3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1AF13013E9E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9F02367B8;
	Tue, 23 Dec 2025 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bHTODR/R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E923D7F4
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461803; cv=none; b=rK5rVb25Nxp6hAT+wykQtTctT5tnoVG51nlfk/7E6Zpvl7X34DFoHnM57SzGihXjjC3CJ2ZE8oge+eIdmqFJzoRsPcd5NHq/7ZF8yFVPQI2TKhU5KCD4LtlG61ejWbYPLq4mAPaxsBxahYOvWwcSJz84YkkSMmf6st6Dmv7YRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461803; c=relaxed/simple;
	bh=kKOCydlyoXCvfqPMDvGUYiiXbpvlyucC/i+9mKTnzh4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=VjSAZZdrA3395HDlha4y7f60E9ALSmupmguJscrZoOj24lDSpCTwekKzl16S4ogRJFPg6Cppz63aBxjZeixSy54uvsZ0YNb4nyIWlYbXWy0SGA1VzL0Dih/N2YLG9OjOszGaREL8L/l2Ip2Y/W6PEfhDCI5ruOuCQWvF8XjkM54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bHTODR/R; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN3npClB631018, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766461791; bh=P+6WN9JpAcSO5yIY2CqlSmUGaD6riVpsLh/5fo5tftE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=bHTODR/RCUCbi1+vjulRdp021usqwVEmGaihugXxgGx3sad3m0xPO0TGlJ9MRx8c/
	 NzB6TuHts5ErUSGNkDMeh4F+YEOakyWhNTP5cO6CmQ7SDc4gjMhRUeAVU4U9pVvJms
	 q5ZZxayT+2rFHF0I6BiG/Kavu0XN6lJMb8SiQg/BozFpd9aeAFBeMn5FsskOuFjMR/
	 MtQgWv7IpWKlK+VGNq1dH7iISUsGfMJCfv8by1fd1r36qpKvPojocmOr7O5Hlcfkvi
	 UrP6kGkd078Ko08QgrPGKjzOLEauS1oiHGAyV0k6cCo0IJe1lE0PA/Jm1UUzWJZYYk
	 VncMsm5cth/pw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN3npClB631018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 11:49:51 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:49:52 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:49:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jan Gerber <j@mailb.org>, <linux-wireless@vger.kernel.org>
CC: Jan Gerber <j@mailb.org>
Subject: Re: [PATCH] wifi: rtw89: 8852au: add support for TP TX30U Plus
In-Reply-To: <20251212005515.2059533-1-j@mailb.org>
References: <5b26cb7740894638b84fedfcad52ca03@realtek.com> <20251212005515.2059533-1-j@mailb.org>
Message-ID: <e9b69287-d022-4980-8e57-b7c1fece3f8d@RTKEXHMBS04.realtek.com.tw>
Date: Tue, 23 Dec 2025 11:49:47 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Gerber <j@mailb.org> wrote:

> the device shows up like this and everything seams to work:
> 
> Bus 004 Device 003: ID 3625:010d Realtek 802.11ax WLAN Adapter
> 
> Signed-off-by: Jan Gerber <j@mailb.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

a2f1fc9ab6fb wifi: rtw89: 8852au: add support for TP TX30U Plus

---
https://github.com/pkshih/rtw.git


