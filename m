Return-Path: <linux-wireless+bounces-15426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776779D07A1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 02:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D5CB21582
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 01:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BDF10957;
	Mon, 18 Nov 2024 01:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="js8Op3n7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A28F66
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731894163; cv=none; b=I4z7+26C3+Co6Kem09MDnupdeZS9zHqp8RNLsS9QsiR3Gpf0BA7TZbzcGBY3bAjgctszIVB0icyrQvEdYHT15jOMpJOV8lHgMcGVL+3XnRIM4DB6CQdWG5f0YjJJ9BvFL44RfSPxcYpOWgJGBEVqxvWVfPzMvqKhIbakmEr6ANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731894163; c=relaxed/simple;
	bh=R9DjK3IaplzHwvnbH4XE8zNzi/aOi/pkXrkyrHIYsH4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=uFgLA9pjWR2xsel22yGYiaKqlE5G2GDfw9Ivzd+TCt3HAAfoCvA008Fr0e8bwgmBm678gVs8LYntwhyz4AKgbJQOxic/i4FyRK0+iNoAxWGHqqN/N3ho/51fKtvrKqEk3RTFilXGKsVFJr7U8TeEkA/OYs/cdmXdQ/zVcg3S46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=js8Op3n7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI1gX1i94123979, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731894153; bh=R9DjK3IaplzHwvnbH4XE8zNzi/aOi/pkXrkyrHIYsH4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=js8Op3n7EtkZT7Fr/ZYJUokjMcJrhumc0S2wNUDphM4P6UWfVBqweK7SKowuvvdtq
	 hyhDR/Umhzy31u/35R5qC//lZ244bH2gp5tB1jHN6iuSaTNdCnqeU5HBT/XMtxGZXF
	 YiIcJunewWdPSkJAy5Nf35EcS1AFdZEKTkYAgFb4K45KVGKh5y8ejSPM8Fhg6RNPp9
	 lhIe4oQl3XbLGFFPooIXcbG9dum5OoE573m/gTFr7qjaTfXeoP0ubXGIf/I7y3njck
	 Y1l3WeRFB9iugON+1IfjHiwJFU18lISJUEak/9kCOSrAq40AxnbKZZ8ZgjiphdWtqN
	 ZPllOibigRCyw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI1gX1i94123979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 09:42:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 09:42:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 09:42:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtw88: 8821au: Add additional devices to the USB_DEVICE list
In-Reply-To: <da05b866-a9ff-428c-a008-35e8cf200a98@gmail.com>
References: <da05b866-a9ff-428c-a008-35e8cf200a98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <5b907c91-2c49-4a93-bd92-a2fcf891f3d3@RTEXMBS04.realtek.com.tw>
Date: Mon, 18 Nov 2024 09:42:34 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> From: Larry Finger <Larry.Finger@gmail.com>
> 
> These are the entries that Nick Morrow provided. From
> https://github.com/morrownr/8821au-20210708
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

7b5ce65d9018 wifi: rtw88: 8821au: Add additional devices to the USB_DEVICE list
1ee6ff9ae3c1 wifi: rtw88: 8812au: Add more device IDs

---
https://github.com/pkshih/rtw.git


