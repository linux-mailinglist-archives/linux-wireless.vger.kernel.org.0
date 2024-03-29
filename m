Return-Path: <linux-wireless+bounces-5509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD86589104A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 02:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4601C249E5
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 01:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850CB1755C;
	Fri, 29 Mar 2024 01:17:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734314295
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675063; cv=none; b=Gbb+79q5qyhXhwH7I1atogWLM+tl5REDsYMxSmlgflWchCK85wo8GIurebQKOAyO2zZ6Ecv/KRl2wlN2NYr9rmEZO1PFg4SUdtRg4pS6c3Ohu0lieXhz5nSqyCK4E28v+NYlWcMXJEcowwqebzvdX2Irf6YlXDeyavXIWJk5NbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675063; c=relaxed/simple;
	bh=BOZc0/jAEZbB0ZGr6+0rh+EPBLF663vG5NRDE/hDkLo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Drr3JL1xeYdAAbMCR+O0waFhc5sfPZMGkhAj34TxA30dPJn9b4T34Bua8EPZmM80v/IjdKS7ZA+Dr5j69JS+/ImGau8+baJbDw3MNgKqLnAkvJ2oOkItRHBDjifPG7llZME8odPWMmITinrj6e57V62IAvrbecU+n17dSEF0mIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T1HZBq83136626, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T1HZBq83136626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 09:17:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 09:17:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 29 Mar
 2024 09:17:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2] wifi: rtw88: station mode only for SDIO chips
In-Reply-To: <20240327004155.7172-1-pkshih@realtek.com>
References: <20240327004155.7172-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <cba131eb-6763-4e85-adf0-34958eecc7c9@RTEXMBS04.realtek.com.tw>
Date: Fri, 29 Mar 2024 09:17:35 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Since only station mode has been tested on SDIO chips, only keep it support
> for SDIO chips to reflect correct supported features.
> 
> Link: https://lore.kernel.org/linux-wireless/87wmpu1do6.fsf@kernel.org/T/#t
> Link: https://lore.kernel.org/linux-wireless/36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in/
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

a54b7a7c773b wifi: rtw88: station mode only for SDIO chips

---
https://github.com/pkshih/rtw.git


