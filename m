Return-Path: <linux-wireless+bounces-24808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F30FAF8617
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 05:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F6F4A4272
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 03:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3244D599;
	Fri,  4 Jul 2025 03:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WoyV7hOa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1932DE713
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 03:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751600896; cv=none; b=m+fQ34VqMgN6UCJkTR0C+R8PsbwIC4IVUxuiZ3XTObpuaEnKLxKQilyDidomDuJCP/8qLD99P6+6Bwivm2rmOvjeHL5wZnxIjjlSOKyoNEbyx93Spt8ga9M9KxssJTmngQKVTHO3Q6n17bA8gR/j4HR3V8gMRRyMEuXwYa+wrjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751600896; c=relaxed/simple;
	bh=N6dinIuZxCJE7B97tE4WQ7kEgBd9VSBoxLHss1cCYqI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=NPwEk+lNUMmSVSu4yOmyOKDHRRFC6mZ5kDUU4NZst1fz3d3qFU6Gn8ANGPDP4/PXjvweqUavpT04RMzulUBylU4BnTWJM2+KWlQuREb7NUSJC+LeZ7arpLLvgtTa2HkUfJ/e9uN3OikIVjfauGvvYzdz7fkm0qPuMhvwgM0kPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WoyV7hOa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5643mATK13685208, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751600890; bh=WDbDMzkDgeUaqGSxf4JzoUhdHHshtG0+su85SYFpr8Q=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=WoyV7hOaoNYtPp1xU3h1pwoLhSQecCAW5aDqH6B+KgU/WSR2FhV64YaznrGf8Sy/U
	 i0CxcNSE7UT9vbnwOEnCpKFEjXce/o01v5L/MxsFU2FmTHZJfrjREkuxMfjoeYjLx7
	 ZH+ZgIOEae95RVQbhVkvANTDExygIx2ZHvwzFEvDYYVb/53xymTTTniJ/tlaY9ZU6j
	 yXGle9NWJJh9PC74U3C/hQmz7fhSpeo77XF4Jygebi2oQlW/gJO43mCRCL7csEZtYT
	 Xal4OtStP0eJ6KSrTiISZ245aEpP6/j7EfgfCoLq7OLBuPqjSmfk22guKorATKjw1s
	 WwVE/TvDPFaMQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5643mATK13685208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 4 Jul 2025 11:48:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Jul 2025 11:48:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 4 Jul
 2025 11:48:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: Re: [PATCH v2 rtw-next] wifi: rtw89: enter power save mode aggressively
In-Reply-To: <20250701073839.31905-1-pkshih@realtek.com>
References: <20250701073839.31905-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <11312dfc-e6d3-4129-bd77-5ca287bed6f8@RTEXMBS04.realtek.com.tw>
Date: Fri, 4 Jul 2025 11:48:34 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Currently the driver allows the WiFi chip enter power save mode
> by checking the transmitting and receiving traffic is very low
> per two seconds. But it's hard for some applications to enter
> power save mode, like video streaming, which sends burst traffic
> regularly for other side to buffer and only send little traffic
> at most time. So adjust the criteria to enter power save while
> lower than 10Mbps and check it per 100ms. Thus WiFi chip could
> reduce power consumption under these applications.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

480dd4dddfc5 wifi: rtw89: enter power save mode aggressively

---
https://github.com/pkshih/rtw.git


