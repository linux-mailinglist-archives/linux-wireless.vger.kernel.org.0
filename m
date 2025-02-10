Return-Path: <linux-wireless+bounces-18689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA60AA2E2E9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 04:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119B01882BAF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 03:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0ED3F9C5;
	Mon, 10 Feb 2025 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KKZQh2wH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85E125B2;
	Mon, 10 Feb 2025 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739159425; cv=none; b=dtQamuTOqq9KHVauPPKloeIqiA1TtYI7+B6PwJLUFX15mCa1rq/+eU8WprKg1yyedtuzC3hmct2hlUBWNFwmJY/WOHvZnHt1bWu9elgxG0CyzcfstqUPN0yEEfFK3mJ/G6Tlwxn0PohMDVQX6zrIv4QDIdaUrtJEHWf23SWhkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739159425; c=relaxed/simple;
	bh=AQbAd1v0Btbrh9m+EmG/+yuJT/dULSVEHMZ7L8h+lEY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=E04uhfnxdXR3A6thfQPtiO9mj9UesWsumoeXuCRmu3fA8dL57FkHYTMk6UfcGMIg3auoFc3ENm5X0+0cpHSI6CAYVsBPnPgfZHS3ThiS8pHSm9riUK5P8E0I0uWCbDJhyhhe9QHUyIPGWzqnXpfJQSmy0fqMuKV6WmR3KP2LqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KKZQh2wH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A3oE9L11598199, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739159414; bh=AQbAd1v0Btbrh9m+EmG/+yuJT/dULSVEHMZ7L8h+lEY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=KKZQh2wHUO9Xtvm4AhbenvhKV3WDN5iznjgGYCSt70pwnxWKcIfBgQ8JdOG0wMfsm
	 KIHsJZsYGAN+eWyFXd/OzBrw082S97umzy0kP+7+wtD+5Mx0HOIjTN+TkGlAttOKzt
	 5z53D31gT9qd5/GnuJ4TC7145bdmcoMC0rtJWkLmUZSD7kT5+1QZY1ZjxayjLMSV3A
	 NjWKiS8JFMd88X/rN8xRxVTn9EptW0DZIvQfFc4mCG1KN2YhlvZEjEcKEVQ23o66VA
	 tlI6h0arPMpd6572bjQWEr7VQ648clawIWplD4dZZFI5PYZs+r2ldAAze9f7QUtgDp
	 W6p2W0vO1l8LA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A3oE9L11598199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 11:50:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 11:50:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 10 Feb
 2025 11:50:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Andrew Kreimer <algonell@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Andrew Kreimer <algonell@gmail.com>
Subject: Re: [PATCH net-next] wifi: rtlwifi: rtl8192de: Fix typos
In-Reply-To: <20250206082457.9148-1-algonell@gmail.com>
References: <20250206082457.9148-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <3cb7598b-8e67-4ff8-aba1-e41df2fe0eed@RTEXMBS04.realtek.com.tw>
Date: Mon, 10 Feb 2025 11:50:14 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Andrew Kreimer <algonell@gmail.com> wrote:

> There are some typos in comments/messages:
>  - althougth -> although
>  - asume -> assume
> 
> Fix them via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

6b39cc01af66 wifi: rtlwifi: rtl8192de: Fix typos of debug message of phy setting

---
https://github.com/pkshih/rtw.git


