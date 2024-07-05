Return-Path: <linux-wireless+bounces-9996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCCE927FDB
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 03:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959F01F22489
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 01:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B42572;
	Fri,  5 Jul 2024 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="iaEggGhZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B1ECF
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144166; cv=none; b=P5OxHqMHHgzjy3xgQSNMUqxo3yK7UXOoMPOaNq1DcoqLfwfmnRBcR10jEQ5aU64w4n29QPWdx2p2IRxh4yU3nuaavRekBvcLOrb9HXFpSB4MpqzC6gSIt/RLrzuwL2KyK6BB8r5Rl/z8TXdkuFyPIaTzWk+zUrbRDBi2y0AdA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144166; c=relaxed/simple;
	bh=ozhhZngBb6k0XHVpXng6EAVTGUJgKB067AZ36H7TWZI=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=coIedeaFCJHizRuDRtLtYHldO8Y9PGIDtt6MSRC5g62ZGmSt9q/a6gv8ZHfWG9LY7+Ge5ULJAfKjU9S5lZgdxRYvWvNViDi8lGcrOBK/I73P5lG+g8pwwfNK+0Ho5Cv1Od30a4m2iV6wT5Yc2/p18JihLBynXXLmop9/JrytG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=fail (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=iaEggGhZ reason="key not found in DNS"; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4651nMyM54088496, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720144162; bh=ozhhZngBb6k0XHVpXng6EAVTGUJgKB067AZ36H7TWZI=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=iaEggGhZBEkaVgllrD0o/pWOl+eBPtANH1iqPoxPuYqxKpHQT+ionKPKGaB2CQk/W
	 obkK7dtert6Ors1ts5RidDXRgSmlWv2fOT8hLYiTMBJqeoA63iwT4NICgtHL+kTtqJ
	 zJNM4x5i6OlsjOygPvYhUtGlIFdyU0OJVjGQp6d/8L61rXmNC4x9ndvagGSJqFd2Xz
	 CUworwwx0YlExKtZEQZAwiPvihfTVXsEg8EReoET1oQCtS4ozfGaEfJwSyxHwxt8lD
	 wR7Fl8GwSbUOEwdbmLa7EnxQpZ0Qcx6Y74Y4t8AnILckhPRgWRWt7jsUzOhLNFMeXB
	 b3coJDH3C/XeA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4651nMyM54088496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 5 Jul 2024 09:49:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 09:49:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Jul
 2024 09:49:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: rtw89: 8852bx: move BTC common code from 8852b to 8852b_common
In-Reply-To: <20240701014619.7300-1-pkshih@realtek.com>
References: <20240701014619.7300-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <cdf618b4-b691-4ce6-9d69-f53d4f218342@RTEXMBS04.realtek.com.tw>
Date: Fri, 5 Jul 2024 09:49:21 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The BT coexistence part of 8852B and 8852BT are similar, so move shared
> code into common module.
> 
> Don't change logic for existing RTL8852BE.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

0e557c5c1a61 wifi: rtw89: 8852bx: move BTC common code from 8852b to 8852b_common
52bc83ad2ed5 wifi: rtw89: 8852bx: add extra handles of BTC for 8852BT in 8852b_common

---
https://github.com/pkshih/rtw.git


