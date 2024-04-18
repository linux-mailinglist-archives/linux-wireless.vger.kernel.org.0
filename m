Return-Path: <linux-wireless+bounces-6475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB76B8A9043
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 03:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14441C21270
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 01:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A6A611B;
	Thu, 18 Apr 2024 01:06:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6D259C
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402366; cv=none; b=dHquoAUlZxP7j/qV94lxUQuWccTzy09R+jooDhOGQCZZekWoLkAI9fUsy6PedLBoZWd98P/amDkvMwNNon0M8eAJzqGBSpMJgORgvzf+4aSJEYOnkVe4y9awkyozaNMx3CX1AGffhxPqfAa12KOc4exCO1Nd88CMOj/wQS0cVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402366; c=relaxed/simple;
	bh=/CTByZg9VUqsdjqzvTnZQpvuzT3VKGW4PHwXNUWFV3g=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=VsPkm9gEvM2Hx8PLL3l0jpi/C0ExiiW32HFwYlzZxx08/8+JuDUUhw3vuhK701AvKVMnrviTnzuvkFEKnW1wj+8n7UpyrwnLS/LhUg+C4U/vJ+Qa6g0gaE+a7Nchm60giE6uDPJrRdnsGRJnn7td8PmlGKrC1on9W57X9chwDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I161yX43915268, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I161yX43915268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 09:06:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 09:06:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 09:06:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: pci: correct TX resource checking for PCI DMA channel of firmware command
In-Reply-To: <20240410011316.9906-1-pkshih@realtek.com>
References: <20240410011316.9906-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <e40848a0-7b9c-4faf-9cd6-7c003c0fbf81@RTEXMBS04.realtek.com.tw>
Date: Thu, 18 Apr 2024 09:06:01 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The DMA channel of firmware command doesn't use TX WD (WiFi descriptor), so
> don't need to consider number of TX WD as factor of TX resource. Otherwise,
> during pause state (a transient state to switch to/from low power mode)
> firmware commands could be dropped and driver throws warnings suddenly:
> 
>    rtw89_8852ce 0000:04:00.0: no tx fwcmd resource
>    rtw89_8852ce 0000:04:00.0: failed to send h2c
> 
> The case we met is that driver sends RSSI strength of firmware command at
> RX path that could be running concurrently with switching low power mode.
> The missing of this firmware command doesn't affect user experiences,
> because the RSSI strength will be updated again after a while.
> 
> The DMA descriptors of normal packets has three layers like:
> 

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

c6330b129786 wifi: rtw89: pci: correct TX resource checking for PCI DMA channel of firmware command

---
https://github.com/pkshih/rtw.git


