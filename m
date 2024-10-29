Return-Path: <linux-wireless+bounces-14625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84F9B411A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 04:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C99D1C212C1
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 03:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A6C44C94;
	Tue, 29 Oct 2024 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cbcTk3Fv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A04376
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730173130; cv=none; b=lqSFPLOLSSwZ3xZZTrY28RaFHz+mxtwwx0G3WBCjWzXvDpDvCLaScFRISbKgec090EhyKv69PBFMs7lZByosWvSqZvfnX2kjCheRQSMnvoSQGFH01VeewYZpqmdQrt+JUXEgJN/4Yd4s1MQjs1qPsfM0LJ64eC+2QZEYSNSlR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730173130; c=relaxed/simple;
	bh=lr6ALL4MGZabptdUIm2fqE2OHNxmU9xrQg3vOeOkCYE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=JAZc8/TaViH430T0a98UvHZQpprt0WKqALerUYrWtD6qMMfmuoi6TFyc7jFcYt2GDEHQ0ToLzNZ9EejU00d7trZDSKRGFQv2B17TW1By1PPi2t4UmZuUBnZxocGiG9XkIOZFf6Nbk/9Oa5EhBRb7G4W4E0KRnpgI1sCZDrWcVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cbcTk3Fv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49T3chKP31792296, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730173123; bh=lr6ALL4MGZabptdUIm2fqE2OHNxmU9xrQg3vOeOkCYE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=cbcTk3FvsnMKxiIKesH4RLxVvvZveWQdeueBQGD3ThbzBwxaLTtEYfbYSS/CkEAgs
	 roNdd6t5zT7W1wAif1TMvaXKT3IpA9ytbsgfK/B9kUQ+wY9GohMzqpChn+NBl4KqCg
	 2acdA34pJWSyfV4x9SZkRGhifzB2uKR8d1q6nr2okL/gS39IUflGFwJsoXOzxsLXrp
	 NpLTqYKY26T74IGJtylToQyvrT2mBuKH6dbONVtlMmJjcDSLcyCnWAzlEY5XqHdXZx
	 z7nFjuwCiY0oNmdz0HdIoSE8BJInUELUvNZUqik6wTWFQzqhyb+aJ7yBzfFPE1oqPx
	 xUn3/jkO7Qbng==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49T3chKP31792296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 11:38:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 11:38:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 29 Oct
 2024 11:38:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH] wifi: rtw88: Report the signal strength only if it's known
In-Reply-To: <f7e1e448-2c9b-498f-b8b1-a14dd967d7d3@gmail.com>
References: <f7e1e448-2c9b-498f-b8b1-a14dd967d7d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <57691f89-20e9-4e80-a842-955d9e054341@RTEXMBS04.realtek.com.tw>
Date: Tue, 29 Oct 2024 11:38:42 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> RTL8811CU doesn't report the signal strength for many (any?) data
> frames. When the signal strength is not known, set
> RX_FLAG_NO_SIGNAL_VAL in order to avoid reporting a signal
> strength of 0.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

47f754b3f838 wifi: rtw88: Report the signal strength only if it's known

---
https://github.com/pkshih/rtw.git


