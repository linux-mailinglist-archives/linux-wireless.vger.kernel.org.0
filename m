Return-Path: <linux-wireless+bounces-25423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F791B04DA5
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 04:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7E07A1434
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 02:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481831C84B2;
	Tue, 15 Jul 2025 02:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CcQFJIYx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6892BAF7
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545004; cv=none; b=HAtmbaTK6Z7kqE8TOlByYqkBZPJssuw3su/pP9oza3PbnZbKbUi2MxhkHUU+h5cQyIa9+ou1D7nkzWdZX+hN6yrGUFXM2kMRe7rXG3jrYFW82ldnA3kEaZ3lT9PqVCa9iwl15jd4i8rFyWqqEUGjD23x6nMUMppsADJsb7+no6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545004; c=relaxed/simple;
	bh=BrU7IMOrZ0SKj1SJMz8n21JV4gWj0frv1EgWo4D6F7o=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=eGGVA2Rolvbi/GWepNaLJsyWxPI+LjS4H6dhxLedpa1lfdfWRfODrN7ycz80TevUjohtWmfUGBdH67i1PSyaKrgwhF7Z8o0ed/onilGJ5mbzAfMKMp4ciC5ZhyUuGvFEVveuZVAaY4PPCxyUgqpgJCu0Tg0pMgO8V5aavC2uJ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CcQFJIYx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F22twF63810376, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752544975; bh=C8iq7ihuiJCUhNYTieuSpW0MdAChLlqPuvWmoQ6UdZ8=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=CcQFJIYxwgwOdOEejtzU3E4Fq2wmBSgcZzsyKUkMcQpFEHjssONvuFotulB/DucTp
	 6GWi4c9ixCV5hHpbpMk4Tpd0EhDFMVuP7+FSud/1ds3JDxNg0a0LLBX+3lfDQfhmDb
	 6dgpZH8pZVPd2tjehh9SVi5Jx9ei57MICwMvjSODoCSoDnFRuxRwbo12R+xWFxod7j
	 t96LQao60EuQtSR8cATQWJFMYuuySgOAhWvhro0Uh4McQhJVbKcLiYLwmXTDDaaj6P
	 p9L0JIOjfyI+IhX/VF7uryMteJIIt8tD7H7FJMU0gaJ8+xkKsicFoDi7wJACV6cJ5n
	 L9Od5hiyJjQcg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F22twF63810376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 10:02:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 10:02:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 10:02:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: Fix RX skb size for aggregation disabled
In-Reply-To: <20250709121522.1992366-1-martin.kaistra@linutronix.de>
References: <20250709121522.1992366-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1b686841-cd06-41da-bc59-b1c2a3d8de6a@RTEXMBS04.realtek.com.tw>
Date: Tue, 15 Jul 2025 10:02:55 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

> Commit 1e5b3b3fe9e0 ("rtl8xxxu: Adjust RX skb size to include space for
> phystats") increased the skb size when aggregation is enabled but decreased
> it for the aggregation disabled case.
> 
> As a result, if a frame near the maximum size is received,
> rtl8xxxu_rx_complete() is called with status -EOVERFLOW and then the
> driver starts to malfunction and no further communication is possible.
> 
> Restore the skb size in the aggregation disabled case.
> 
> Fixes: 1e5b3b3fe9e0 ("rtl8xxxu: Adjust RX skb size to include space for phystats")
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d76a1abcf577 wifi: rtl8xxxu: Fix RX skb size for aggregation disabled

---
https://github.com/pkshih/rtw.git


