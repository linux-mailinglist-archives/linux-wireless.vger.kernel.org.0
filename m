Return-Path: <linux-wireless+bounces-29217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2093C772E3
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 04:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C202B28C93
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 03:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6322335950;
	Fri, 21 Nov 2025 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vTDXNJ18"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE818248878;
	Fri, 21 Nov 2025 03:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763696729; cv=none; b=lzxQxHnHhxlBXtIO46gP/zG+imWQVo/udLcATIIqlZ2kel+vCR1CKC3592iZ4y4U6PuaDdS2wiXBYZ5uvrAug7M//s7nuL3+ytEj1eYgkINSaAJ01dZqVReBoI2U61ZPskOFD/4D+apRZ1LN+XFTHnqtVqpTYdD1k32a5lmHC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763696729; c=relaxed/simple;
	bh=8QcyxaDqiYU+Mc0zXUe0J1C7LTn8y0bC9dQiKZu3ZA0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=b6bzOh59E5HJOk8XBZtmrkGwSE57WBbbTpzK9+PzYI9uVSQ9MDVml/3KKb2mKn7QYZs3GAtlNDoacTdYn/rYSbVOMgY6INfIbjjDXbvqxdHMLEm7AOXIUqssEQHw2NBzzyytlo0NHmTEAVes0g3gDbhrf93taEVtv4OMbTjwb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vTDXNJ18; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AL3jHJC12856912, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763696717; bh=2uQzRCPZStyps6V2zL8Jb9YMjhdSzpfENnzphfJEBKY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=vTDXNJ18rxhlOkXkScvTHzgSxsyF98K+h+RVJ2BnC9xUkYxvwCfYnLyaKd66VSxw5
	 R+esjjJ1+DfCxsnbF63bU6KseaUbMTkIxqTc3LSjIAzrcfVm3bcVLiFs4+gPX1EGmh
	 tcIsvMBVXY6PtEZMd7La0F/BSqktb4jKEdj+wyUBXr+1FgSO6t97yZlvAorYQ12Hdp
	 FaNyZUUrS0ulubkOCx0roL/dXwYIVQdFI+e7LM348o58IrKCTZFajas1XlMGydLbHj
	 yZBjJ5HQFp9uNTlkoyVLzyAZbgS+0YFTKsRcPNpfg2Twk3uVYaIKAHXfXSdbgo9LJp
	 xU/6NjmiXmzFw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AL3jHJC12856912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 11:45:17 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 11:45:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 21 Nov 2025 11:45:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: pip-izony <eeodqql09@gmail.com>, Hin-Tak Leung <hintak.leung@gmail.com>
CC: Seungjin Bae <eeodqql09@gmail.com>,
        Kyungtae Kim
	<Kyungtae.Kim@dartmouth.edu>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()
In-Reply-To: <20251118013258.1789949-2-eeodqql09@gmail.com>
References: <aa04fd38-a1df-4d16-bf16-e24a848a00f8@web.de> <20251118013258.1789949-2-eeodqql09@gmail.com>
Message-ID: <f2c4b0f5-1065-4ac1-9430-09e46b210ebc@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 21 Nov 2025 11:45:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

pip-izony <eeodqql09@gmail.com> wrote:

> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> The rtl8187_rx_cb() calculates the rx descriptor header address
> by subtracting its size from the skb tail pointer.
> However, it does not validate if the received packet
> (skb->len from urb->actual_length) is large enough to contain this
> header.
> 
> If a truncated packet is received, this will lead to a buffer
> underflow, reading memory before the start of the skb data area,
> and causing a kernel panic.
> 
> Add length checks for both rtl8187 and rtl8187b descriptor headers
> before attempting to access them, dropping the packet cleanly if the
> check fails.
> 
> Fixes: 6f7853f3cbe4 ("rtl8187: change rtl8187_dev.c to support RTL8187B (part 2)")
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

b647d2574e45 wifi: rtl818x: rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()

---
https://github.com/pkshih/rtw.git


