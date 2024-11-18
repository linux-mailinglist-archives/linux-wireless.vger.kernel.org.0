Return-Path: <linux-wireless+bounces-15432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF19D07D8
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 03:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B941F217BE
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255EF1802B;
	Mon, 18 Nov 2024 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SlWoy+Dx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3252907
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731896437; cv=none; b=cgP6zAHuhX5RInoH4qxDS0GOK7rM1WeokS4ElasQs27zj+7hE7B65Bxt4MEiwT2EqPdDek60yv8tA+Igr/LUjkEJTvPLQj9Qrnsd7STS+ve7SBP6NLBfosZ5xdlqfGgRSgTNeG2EHCPhetZ9mpvWoT78OO/SB0b0boVBlJT0vZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731896437; c=relaxed/simple;
	bh=Rz7VCldQeb4QJWt3AMnFWOpawVKpnsMFhpTuPkaPcWk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=GxXaL7QxqcDauYQUqiICyuQoxI4BUEH7V2d5U4VNGnC/r+WIbzuCDFree5daUZ4m6s8oQCWDkryu5fg30axcyrF12Mswwspim3sZYcyAX2atwWj5GRzvtmOoBHc/nRCC+bD7A6UVygO80kOYJFEmKPWDcHayrU/ae+8FdXikSkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SlWoy+Dx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI2KW7x84165193, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731896432; bh=Rz7VCldQeb4QJWt3AMnFWOpawVKpnsMFhpTuPkaPcWk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=SlWoy+DxACDPUG0u4zav6ca+7MOTgT8aLWDkMMqNsgSMcUFe+jPlgHzzfy/D+Sbhn
	 dESoHxQ+2bbLeEKq2f5Gb9udNuee2j1oSsrrI9BWAPsXeL3V5x63zof0TYtrMsKqpW
	 AmhMff/OFJNXzo6Hl+8Th7AskOYkubXWltM9pP/58ISWajWTxXqrUJCewtZwBBjuYI
	 2Sn4nx/B/le61iDlqZJfq/VkIDno4h8F/Kfazmyf/Jzux3aYRQHoc9Z1qKkG1J2exj
	 axNTVVK4/p3i21pKv4MtrFGQdJanh9Psql4nrKAh3wGrSNShHjO415guvTCWxmsmmO
	 Kf2ES9LZCW1/Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI2KW7x84165193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 10:20:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 10:20:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 10:20:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: Re: [PATCH 1/3] wifi: rtw89: sar: tweak 6GHz SAR subbands span
In-Reply-To: <20241111065132.19587-2-pkshih@realtek.com>
References: <20241111065132.19587-1-pkshih@realtek.com> <20241111065132.19587-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <3d362f48-e73e-4858-9692-c3f922b4f122@RTEXMBS04.realtek.com.tw>
Date: Mon, 18 Nov 2024 10:20:32 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> Given that the 6GHz subband edges are not aligned, specific frequencies
> can span two adjacent subbands. We considered the need for this
> functionality outside of SAR and moved it to a common function.
> 
> No logic change for existing chips.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

abb541d1e52f wifi: rtw89: sar: tweak 6GHz SAR subbands span
f0f08a4456b5 wifi: rtw89: introduce dynamic antenna gain feature
50191eace88c wifi: rtw89: handle different TX power between RF path

---
https://github.com/pkshih/rtw.git


