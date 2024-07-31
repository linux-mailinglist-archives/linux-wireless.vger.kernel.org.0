Return-Path: <linux-wireless+bounces-10707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7294261B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 08:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997701F21CD7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 06:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7982D94;
	Wed, 31 Jul 2024 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UqnEXNKW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1D6F066
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722405875; cv=none; b=DNLjpIigoBzDGvrdPt/w7Vtk/kSnsYz41Xwpvqs77AEW9pFeL+YM6MFR14hT5l6+ZUsAtdDR4raZMV6LpujWQoI+J4wdNvi9N3fe13TDh1vup30/JeKv/0ZlrAhUWMm9h1RTLKVE7usPj40Jg0pEz9pAaSAlvH+iVibUcGXvcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722405875; c=relaxed/simple;
	bh=RhyhoFeMwfoEs5z0miUt6qvGK4ZhZx1GWhC8LRAZ2ME=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=fVuyOfRoJHEnr81rRK+z47gnfcVhqfFQ2Q33gJLgQqQGYhFCR09O7mdtNOsntVjMjeuYve0z6qzPFBI5sb6VDLmWfdGSmo1jhSuwQwM3eTzYyJaboExF9XM+M95mq7Hk/5AoLDPDAslLszMEyhVtImcQhbaH2UZmkHwwoF17t8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UqnEXNKW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46V64U3k82012214, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722405870; bh=RhyhoFeMwfoEs5z0miUt6qvGK4ZhZx1GWhC8LRAZ2ME=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=UqnEXNKWhRBnmXvOuuB/sNZeMt5VycJruvyicJl/X59C1qSd59N3KnbzMlZxem7+n
	 zCqKkuoM1Y9oUI5Sb8VMwifJfq2uqnSDXOZly4UqgzPJw5n4elUG1itvcIUzBbU22m
	 HE7G5IoeTiGqTghaeGS/pfj8rb66q6seUQAx6Y3eTk3ClPNVTeVQqutZW1adgzeNB5
	 gupR6a/XjQcShuhTaNx2hHx+Td/WgBufIDtgo4GUktnzZev5UJlIsuJ0A+hNR3V/+v
	 5gGh6QJrpex077YyLUBUoZsNsEwS8xe9KdPMP6WCW2IkCnh1p6VoThVH1sU1HrKthp
	 WU4VkDwauL6rQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46V64U3k82012214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 14:04:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 14:04:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 31 Jul
 2024 14:04:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] wifi: rtw89: 8852bt: add set_channel_rf
In-Reply-To: <20240720021340.12102-2-pkshih@realtek.com>
References: <20240720021340.12102-1-pkshih@realtek.com> <20240720021340.12102-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <eea1455c-ea60-4d3b-9de9-4d175014c38a@RTEXMBS04.realtek.com.tw>
Date: Wed, 31 Jul 2024 14:04:30 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Add RF part of set_channel() is to configure RF registers, and then
> hardware can TX/RX on specified frequency and bandwidth.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patch(es) applied to rtw-next branch of rtw.git, thanks.

6bd63e44e98e wifi: rtw89: 8852bt: add set_channel_rf
be457fbacea9 wifi: rtw89: 8852bt: rfk: use predefined string choice for DPK enable/disable
c4dea0481e23 wifi: rtw89: 8852bt: add chip_info of RTL8852BT
62eddca4d296 wifi: rtw89: 8852bt: add chip_ops of RTL8852BT
e67e15cb867c wifi: rtw89: 8852bt: declare firmware features of RTL8852BT
bbe48c328ff8 wifi: rtw89: 8852bte: add PCI entry of 8852BE-VT
b9cdbb06d4fc wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig

---
https://github.com/pkshih/rtw.git


