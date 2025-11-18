Return-Path: <linux-wireless+bounces-29067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D98C66F82
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 03:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7A94364DB7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 02:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23547269AE9;
	Tue, 18 Nov 2025 02:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mjZXHua+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711F20B22
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431596; cv=none; b=POzUyg6tfDZ4EmREWpOmCqvFjnP6kCXMMiRlLZYIkiO4SJ4uMEC16LJ7dIvwOz2kXEaDyUNvfXSfkuJ/YxhBE0rYBWzdXRLjOQIEItqiKYG5n5Jdvll0czOUzLTS9HdOm/pCT39rkrBnU2LFxnuDK2lKGJS6JC+5V1ha107wopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431596; c=relaxed/simple;
	bh=WoAD51PZQ8Y/SftQxmHf7eb3wkr9kDA+3QUBlkF2/9A=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=FLRsTizvA8BdPR0S5MgDivEzlC5i/TQ3qvF8zMotIqnEt3VxhjyFh7rTioQzMH3P3qARB/Msw7EW3HqRg4P9ghWvJvOmGqYJIvKyCQtx9/tf3LdS5vvyY4iwAJMyvELLbZGNR+UOgBQ4GJet9YribwvMbEdXHL51o5ElXwABN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mjZXHua+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI26OmxC590301, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763431584; bh=9y4di1FIJGYtSUO26qRkgnys5nxSUIEqQNG5geAMpTw=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=mjZXHua+zVd+Up+hBIfHvyLMjFE6j+uZQk92K2LLQ4Aa7nvV94hIPI9Ae2v7HiISk
	 sLRGr/KovbjkEt20/u+DFUqLgSumP/SMoXiJjQG40Te58DxgSCGKiyEMujOxG0YbXA
	 V7reFBgIb49WACxhGNGwJT5sBCBQtLkVtWnHPo/q0BzISaTvTAi6A5OsSmyPzq8jS3
	 I9IXHce12R+X/Vv5XCs5iY4fTJKMVBWhRiIXLIgAY+5v6GGUwI2Mo9KqVrnhqz/jlX
	 IvTqFHci5Sw4iJKEs3MSwl5UCwUFdM7Ocg2ebNz6WqY3kzCemImMaAzu3cZxz8sDHa
	 PeGqFtxfE6yOQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI26OmxC590301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:06:24 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:06:24 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:06:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 18 Nov 2025 10:06:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <geert@linux-m68k.org>
Subject: Re: [PATCH rtw-next] wifi: rtw89: use separated function to set RX filter
In-Reply-To: <20251113053459.34995-1-pkshih@realtek.com>
References: <20251113053459.34995-1-pkshih@realtek.com>
Message-ID: <885322d9-c9a8-41bd-b4f5-2acc016a71e6@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 18 Nov 2025 10:06:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Normally use rtw89_write32_mask() with a consecutive bit mask, but mask of
> RX filter B_AX_RX_FLTR_CFG_MASK is bits 31-22 and 15-0, which excludes bits
> of B_AX_RX_MPDU_MAX_LEN_MASK (bits 21-16).
> 
> Though the original logic is well to set RX filter, change it to a separate
> function to avoid the tricky design.
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

c8d212fa81c5 wifi: rtw89: use separated function to set RX filter

---
https://github.com/pkshih/rtw.git


