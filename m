Return-Path: <linux-wireless+bounces-11549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6202C954832
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 13:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16ABC1F2171A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722C12C54D;
	Fri, 16 Aug 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="T8NypC/U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626C1AC8B9
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808618; cv=none; b=EbJ8Vc4amB5JsFMfoFO1VCQKSzpKvqNQTVI9Vuo12Hi6urdqKW9YJQzt1H6t+G29oCElLPKfD22qEJDYQ6BCbhm9rJr1PfJOOxJmkoOdV5ixFKPJDqfcuKz2eQ9xNXH+y3jHz+e816Ywd7Dg+I7zboHBz+9ahYpyRECWNZ9jSdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808618; c=relaxed/simple;
	bh=SVjFulxPoM4zWkpgzRe0jMU5fI5emTC09VLIV40HUZ8=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=qdiPOG5sGiKq3SIS+EQdoVO7i/+Vwc45IF7QFjnT4Gd6FyrY2TdhUubK6b7oHVfM0p7DkP0iQjkkCIebfyPSTjkWVnxCJlVpnUeaXj7VMkTWBxNyrJ1rnq5aD3rlumgmglpX+jRQ1Xq0RQmF1RcProAqL3W+41WzMmRbVTmUpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=T8NypC/U; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47GBhKx35983033, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723808600; bh=SVjFulxPoM4zWkpgzRe0jMU5fI5emTC09VLIV40HUZ8=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=T8NypC/U995+aQazH7fTsEPWhFdqBK4JLL1U8ClFlbvCXnGXvjZvmlBF16ADSXFAz
	 P/BuLat63sax1bHB3tl2WQLloWMIHdpVhKSGf4SCHJBuZUip7rCTNCPKhy270kgtj7
	 7T4kyVzNzo1STwWbVDXV7yIi/e8ffan+Zydk5S7gHuo6amXtq6FT0x3hCV8Phrh3Sr
	 a+L4dEkOSXqkJ+1ezoGc1bU/7b3dt+5missuf8dDu9eDhyGtTk3CpdgESrTy0+LmYO
	 6NPcV4dvZI0AR1XdWDrP+jRAA0PNn/GZxmewhrPmggzBgEzjyorF04dALr93M4QUG8
	 1MNQAzltxvI1A==
Received: from mail.realtek.com (smtpsrv.realtek.com[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47GBhKx35983033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 19:43:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 19:43:20 +0800
Received: from [127.0.1.1] (172.16.21.174) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 Aug
 2024 19:43:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Kandybka <d.kandybka@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>,
        "Dmitry
 Antipov" <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: rtw88: remove CPT execution branch never used
In-Reply-To: <20240809085310.10512-1-d.kandybka@gmail.com>
References: <20240809085310.10512-1-d.kandybka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <8dac9cf4-e2cc-4c49-9986-8c3b89611681@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 Aug 2024 19:43:20 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Dmitry Kandybka <d.kandybka@gmail.com> wrote:

> In 'rtw_coex_action_bt_a2dp_pan', 'wl_cpt_test' and 'bt_cpt_test' are
> hardcoded to false, so corresponding 'table_case' and 'tdma_case'
> assignments are never met.
> Also 'rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[1])' is never
> executed. Assuming that CPT was never fully implemented, remove
> lookalike leftovers. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 76f631cb401f ("rtw88: coex: update the mechanism for A2DP + PAN")
> 
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

77c977327dfa wifi: rtw88: remove CPT execution branch never used

---
https://github.com/pkshih/rtw.git


