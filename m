Return-Path: <linux-wireless+bounces-6716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840098AE52B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2AA284390
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEFA130AF9;
	Tue, 23 Apr 2024 11:43:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590A7D3E3
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872612; cv=none; b=WJw8hUGS4n1LWsBM2ZUncvdE7X6uVrs9bMP26zLKtL3KUEqnFUE2FCMzl3bODBCdgbAnVl9XP5Fz8XznYQBOhoW5gMhThKY4Tt8KXs1V4RJ/hwh5DmceNkJC/q8+zteAH69uizrE8HxGT3BtmXU/VNmGgEb5Bu8qEyjvUZYwSWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872612; c=relaxed/simple;
	bh=HGrj8hXht7GI11+D7xVMaPnTO2MsXL1ZF3CdSBu9atQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=nMfE4v1p5bFfcnh5oSSm3oMTzF4E2bynn5tBK6nGOFhrsHQUgaAJaaZHa9D+ZpqBUpMzGkI2+Z4uYFv5B35uRsMKS/HDjcKe5+URAx9a9rAp3MeH5SvWuz/mBwxSrpF0nA7l129+6/19uk8t0Kpq5C3NQXncVhF6fEd9Q/kxBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43NBhOIW11210319, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43NBhOIW11210319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 19:43:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 19:43:25 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 19:43:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v4] wifi: rtl8xxxu: Add LED control code for RTL8723BU
In-Reply-To: <7df66d1f-87a1-4f44-9aac-ce75438abde3@gmail.com>
References: <7df66d1f-87a1-4f44-9aac-ce75438abde3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <58664fb6-1cf7-4b54-b4ee-7696f7b114b7@RTEXMBS04.realtek.com.tw>
Date: Tue, 23 Apr 2024 19:43:24 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Software control (on/off) and hardware control (automatic blinking)
> tested with EDUP EP-N8568.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

feaedb05fc47 wifi: rtl8xxxu: Add LED control code for RTL8723BU

---
https://github.com/pkshih/rtw.git


