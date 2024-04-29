Return-Path: <linux-wireless+bounces-6952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F58B4F24
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 03:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC01F21CB9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 01:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB87F;
	Mon, 29 Apr 2024 01:13:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F091624
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714353216; cv=none; b=e+8Nr8gSPruiBgbMJ3uJGzjp+jaznxgW5ktMXI8a24WRASVKnIChuX8RhVTkYLEsgsmbQhzDUgWTq1W7NiaGttozUALJSxCmsonmHrxlMAIiBInl6b2WzmNoaNLgp3goT+KMHtToEiKHM5iY7iZh0VsuK/EfoF262bC/MR8WRQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714353216; c=relaxed/simple;
	bh=nZOjcISDFUeCmlCsjhP1gkixvGw9jCsNd6SHMmWZ3W0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=ifTe6BCpHRtrYN+Ez3fA0TQhRljJvXrtcp/CidJG+pfGIzBWAnvx1nvaHEkBV7m+SXagmRhLB6ljXT/lwIzvBL+UC3Qb+XWodBy6DDgJ6+3i8AxGhm7gT9ZS2mQGXIKl1UTi/HbxSWRmdp6oe9siWuIyWSbjbVcHdStndix9YXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43T1DVNa82869077, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43T1DVNa82869077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 09:13:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 09:13:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 09:13:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH 1/8] wifi: rtw89: coex: Add Wi-Fi null data status version 7
In-Reply-To: <20240423130502.32682-2-pkshih@realtek.com>
References: <20240423130502.32682-1-pkshih@realtek.com> <20240423130502.32682-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <0d615b44-28ee-473e-be1b-977040a2caaf@RTEXMBS04.realtek.com.tw>
Date: Mon, 29 Apr 2024 09:13:31 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> The mechanism will use Wi-Fi null packet to stop the packets from
> access point to avoid the interference to Bluetooth when switch
> to Bluetooth slot. The report can check whether the null packet is
> working as expected or not.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patch(es) applied to rtw-next branch of rtw.git, thanks.

430d80e79477 wifi: rtw89: coex: Add Wi-Fi null data status version 7
e5d0305a2b55 wifi: rtw89: coex: Add Bluetooth scan parameter report version 7
b60b46863375 wifi: rtw89: coex: Add Bluetooth frequency hopping map version 7
1a5565d81285 wifi: rtw89: coex: Add Bluetooth version report version 7
947cbc6ead46 wifi: rtw89: coex: Fix unexpected value in version 7 slot parameter
efb85ded5c20 wifi: rtw89: coex: Add Wi-Fi role v8 condition when set Bluetooth channel
11173c7062db wifi: rtw89: coex: Add Wi-Fi role v8 condition when set BTG control
416a445ec328 wifi: rtw89: coex: Check and enable reports after run coex

---
https://github.com/pkshih/rtw.git


