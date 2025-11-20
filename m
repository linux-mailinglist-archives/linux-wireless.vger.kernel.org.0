Return-Path: <linux-wireless+bounces-29150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8712C721D1
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 04:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41C7034D613
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 03:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86614DDC5;
	Thu, 20 Nov 2025 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OnZiOBr2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464B372ACF
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 03:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763610594; cv=none; b=h0WL2/qMV0gy/ePxFANX0R7eyRFSrysCi/MWOnAOJxDzu0aomRSQAnAIX73qkNWM5Mty+kolfCXMmQV/BkLOE0AKcz8cH3I2AJaRQSdgr4+KApR0+6m/AZ/dyCYAfuZigOWgUnujd5vOfky8OYbJ3tizlNFbpglhnPV+bHcsVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763610594; c=relaxed/simple;
	bh=AJwFGnC6/QDf9Uc2vXmj6ct1nS2CBsXWpOXhNssIig8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=gcVTs9SC8VfKYr83Yq86cHUs7FzAqjKeyomCiRdnZE/E/ZSlMJf6Kgc/jPBzSk6+7W076aMHKVN3fqNnzNJw3po8tpwAGq/8ZaAHuHK4e3UFOze3XCKB8M70njwIZN3ynkLjKgTx4SELutJ8V1cSy8YDC9BYZ4l30dhPVsH3+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OnZiOBr2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AK3nl3F3757061, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763610587; bh=GYKOz2gtUnhki8p5iguRTb5sZ06us+8J4SCmwblPmj0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=OnZiOBr21RIm8rp2+HUrU7vZahmAERVjzzXXvD1EifMinh/Z+ycq0QRlVpdhCyYfc
	 NIRMWJ8Xn58aG5SaTjotk3ZRHV//00Q9QLdmyf1TI2Wlnhb6JN9ZiWSnspIPAvWVt3
	 hKTD+sCq7h1/iuQtVCZOSqOLNUyxDkt32DNl6KFye5fbEY+uQlPBkWOJpuKzHTJoYz
	 ffqL8z23iwrciPVyQgn4uFOY+3YHUQxduysP2EVVw33o83q0vG/x6xakhbNBLRzCJi
	 yhBbiYWdOEu0nylwMtcncS1qh3rFwJAqitw4/wadMRpJJneBQEl7vwFRgaADbPuZkj
	 9LaKVbNzLz6NQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AK3nl3F3757061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 11:49:47 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 11:49:48 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 11:49:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 20 Nov 2025 11:49:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw] wifi: rtw89: hw_scan: Don't let the operating channel be last
In-Reply-To: <c1e61744-8db4-4646-867f-241b47d30386@gmail.com>
References: <c1e61744-8db4-4646-867f-241b47d30386@gmail.com>
Message-ID: <dfef6ddf-f31b-4811-b18e-4757e4ea72bb@RTKEXHMBS04.realtek.com.tw>
Date: Thu, 20 Nov 2025 11:49:47 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Scanning can be offloaded to the firmware. To that end, the driver
> prepares a list of channels to scan, including periodic visits back to
> the operating channel, and sends the list to the firmware.
> 
> When the channel list is too long to fit in a single H2C message, the
> driver splits the list, sends the first part, and tells the firmware to
> scan. When the scan is complete, the driver sends the next part of the
> list and tells the firmware to scan.
> 
> When the last channel that fit in the H2C message is the operating
> channel something seems to go wrong in the firmware. It will
> acknowledge receiving the list of channels but apparently it will not
> do anything more. The AP can't be pinged anymore. The driver still
> receives beacons, though.
> 
> One way to avoid this is to split the list of channels before the
> operating channel.
> 
> Affected devices:
> 
> * RTL8851BU with firmware 0.29.41.3
> * RTL8832BU with firmware 0.29.29.8
> * RTL8852BU with firmware 0.29.29.8
> 
> https://lore.kernel.org/linux-wireless/0abbda91-c5c2-4007-84c8-215679e652e1@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw branch of rtw.git, thanks.

e837b9091b27 wifi: rtw89: hw_scan: Don't let the operating channel be last

---
https://github.com/pkshih/rtw.git


