Return-Path: <linux-wireless+bounces-33456-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMRhG0mfu2nplwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33456-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 08:01:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134BD2C7068
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 08:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 683C23001339
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 07:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7C38B140;
	Thu, 19 Mar 2026 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MC0eZfCy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090F1A2545
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903684; cv=none; b=nAnRx0/2pRm8YnYNqs3/Qhh2xzC9Rh9WUkijr81MhvmYF/yzG1M0prnLqnPx+tvvHzNzf97LAW/Py+Hf1KrCgv6dmgDkj0PfCDWdCdyyNuV4GX+wAl+EZ/eq2KljsDpyM1c888/g7lZkLta++MZm8qA8smG35O8yxPOV3s+iQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903684; c=relaxed/simple;
	bh=OGzT3WcNV4XcrIcCCAXbBxF8OenAhvGB96RMGbjnAr8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=NVZdbKhfefvl2GM5ZeoDzrmPiw4nCdxlTzJT6RY/uByEJ0WlkSAlGIxWKSoQfY94ENWt/r7l9c9CrQhGjIhPPnovc5aH+41umXlHWoBExjUkv7ErS+UvIjJftV3khWqOWDqujjBEWQdsb1fnNH/xP9+l6R2tZvNoHwmYsocLeSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MC0eZfCy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62J71IT003234615, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773903678; bh=MBlKhFS+9CC4GN/TyRlnuZ/reSvw5mTEGUd57wpg7yg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=MC0eZfCyZS8IwCkmW+vvMxeM7iHXJTZza5n9akSbgSratMZ5b76zQTx4iRPl5m+Sm
	 DXE5dG7mHOTM7nH6aOITOWR5ZnqXURJwTpTLTbHpA2342mknSPW0gGgmO/dX4NTcJL
	 c1/2bM+KQRc2GDcvIxRGd7Z6NzY/B6bqa/WbszvnUVp6j4m5T/SCKE7AyYg1UiYA9N
	 jsxUiyPbfZpJoYFDpfoFFLg1AKp0U7y4RM5DWNga/MublTZWZutBq8NkVsbonWQDj1
	 CAXgGBhHRivmVPybCvKXQQ71xf67Stx7y2aTGTsOoRovJtCFQdLTBAJFBCm6w9f4IF
	 kyDbnEr6UXgog==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62J71IT003234615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 15:01:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 19 Mar 2026 15:01:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 19 Mar 2026 15:01:16 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 19 Mar 2026 15:01:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>, <mh_chen@realtek.com>, <isaiah@realtek.com>
Subject: Re: [PATCH v2 rtw-next] wifi: rtw89: usb: Rx aggregation for RTL8832CU/RTL8851BU
In-Reply-To: <20260312055724.12177-1-pkshih@realtek.com>
References: <20260312055724.12177-1-pkshih@realtek.com>
Message-ID: <06d1e5c2-207d-4e5d-bac0-692b16f9755c@RTKEXHMBS06.realtek.com.tw>
Date: Thu, 19 Mar 2026 15:01:16 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33456-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,RTKEXHMBS06.realtek.com.tw:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.903];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 134BD2C7068
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Shin-Yi Lin <isaiah@realtek.com>
> 
> USB RX Aggregation is a performance optimization technique used
> in USB network devices to increase throughput.
> 
> Instead of sending every received network packet to the host computer
> individually, the device hardware groups multiple smaller packets
> into a single, large USB Bulk Transfer.
> 
>  * toAP/toNB use iperf3 respectively.
> 
> With Cisco BE6000 - iperf3 tcp 10 pair (to another NB)
> 
> [6G 160Mhz]:
> 
>  RTL8832CU-USB3.0
>        before   after
>  TX    941      941
>  RX    847      919
> 
>  RTL8832CU-USB2.0
>        before   after
>  TX    293      286
>  RX    342      356
> 
> [5G 80Mhz]:
> 
>  RTL8832CU-USB3.0
>        before   after
>  TX    864      877
>  RX    864      902
> 
>  RTL8832CU-USB2.0
>        before   after
>  TX    279      271
>  RX    327      349
> 
>  RTL8851BU
>        before   after
>  TX    115      114
>  RX    295      306
> 
> Signed-off-by: Shin-Yi Lin <isaiah@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

eef6d4449e8a wifi: rtw89: usb: Rx aggregation for RTL8832CU/RTL8851BU

---
https://github.com/pkshih/rtw.git


